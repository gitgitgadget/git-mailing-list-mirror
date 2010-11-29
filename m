From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH 5/6] web--browse: use (x-)www-browser if available
Date: Mon, 29 Nov 2010 17:18:47 +0100
Message-ID: <AANLkTinGustedMv9rm+RgGMQckfxgbTPA+Yqpz7vqTfm@mail.gmail.com>
References: <1291042075-19983-1-git-send-email-giuseppe.bilotta@gmail.com>
	<1291042075-19983-6-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 29 17:18:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PN6RL-0007ya-L4
	for gcvg-git-2@lo.gmane.org; Mon, 29 Nov 2010 17:18:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750985Ab0K2QSu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 29 Nov 2010 11:18:50 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:40599 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750860Ab0K2QSt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 Nov 2010 11:18:49 -0500
Received: by wyb28 with SMTP id 28so4592123wyb.19
        for <git@vger.kernel.org>; Mon, 29 Nov 2010 08:18:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=U8KWwVARNu8vqs+Lnn0atObeRHSaTThMYx4t0IB1Q3w=;
        b=vJ9UOx1lMsLXaKa7OeNOuksvuX93opm5R7wEkTz5rdF4C1Eu4f7bwWW08M0yDMLlJN
         gmGpQXBd0eQ4thJTk/k2IkIOrssjD+eFzIRUbQiLpUW3tlIg4zuSwT1Q5GXVqX3Wt6Qh
         R28xESoSHks4yeWK4OVXbDOxHtsZF11re+hWk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=HFWVHIZqkWCMlSWUlgQiKEUYt0lUDh5IWGWakOcwbbY7MlsL52n491Eg2WStM71KEN
         UAHQIx6Oi3S7LHAsurHYcDlk6D6lYzia84isp49e6mGvw0m1/4JI+bV2KwrJZO/W1mJn
         DXYFRXSzQIFTrcdDAZejFbZPl96UhyK9s+I0o=
Received: by 10.216.161.130 with SMTP id w2mr5182123wek.17.1291047527913; Mon,
 29 Nov 2010 08:18:47 -0800 (PST)
Received: by 10.216.85.213 with HTTP; Mon, 29 Nov 2010 08:18:47 -0800 (PST)
In-Reply-To: <1291042075-19983-6-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162395>

Hi,

On Mon, Nov 29, 2010 at 3:47 PM, Giuseppe Bilotta
<giuseppe.bilotta@gmail.com> wrote:
>
> +# Debian and derivatives use x-www-browser or www-browser to set
> +# the default browser for the system
> +if test -z "$browser" ; then
> + =A0 =A0 =A0 wwwbrowser=3D"/usr/bin/www-browser"
> + =A0 =A0 =A0 if test -n "$DISPLAY"; then
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 wwwbrowser=3D"/usr/bin/x-www-browser $w=
wwbrowser"
> + =A0 =A0 =A0 fi
> + =A0 =A0 =A0 for i in $wwwbrowser; do
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if test -x $i ; then
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 verstring=3D"$($i --ver=
sion 2> /dev/null | head -n 1)"
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 browser=3D"$(echo "$ver=
string" | cut -f1 -d' ' | tr A-Z a-z)"

Stupid questions:

Did you check that all the browser we support accept the --version opti=
on?
What if we add support for a new one that doesn't ?
Shouldn't we add something like :

test -z "$browser" && browser=3D"$(echo $i | cut -f1 -d' ' | tr A-Z a-z=
)"

And are you sure that when they support --version, the first word of
the output is
better than "$(echo $i | cut -f1 -d' ' | tr A-Z a-z)"?
What if we add support for a new one?

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 case "$browser" in
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mozilla)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 browser=
=3D"$(echo "$verstring" | cut -f2 -d' ' | tr A-Z a-z)"
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ;;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 google)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 browser=
=3D"google-chrome"
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ;;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 esac
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if valid_tool "$browser=
" ; then

valid_tool "$browser" is called once here...

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 browser=
_path=3D"$i"
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 fi
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 fi
> + =A0 =A0 =A0 done
> +fi
> +
> =A0if test -z "$browser" ; then
> =A0 =A0 =A0 =A0if test -n "$DISPLAY"; then
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0browser_candidates=3D"firefox icewease=
l google-chrome chrome chromium konqueror opera seamonkey iceape w3m el=
inks links lynx dillo"
> @@ -129,7 +156,7 @@ if test -z "$browser" ; then
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0fi
> =A0 =A0 =A0 =A0done
> =A0 =A0 =A0 =A0test -z "$browser" && die "No known browser available.=
"
> -else
> +else if test -z "$browser_path"; then
> =A0 =A0 =A0 =A0valid_tool "$browser" || die "Unknown browser '$browse=
r'."

=2E..valid_tool "$browser" is called again here if it failed above, and
here we die,
so isn't it clearer to die as soon as we call it and it fails?

Thanks,
Christian.

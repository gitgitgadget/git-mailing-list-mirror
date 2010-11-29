From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH 5/6] web--browse: use (x-)www-browser if available
Date: Mon, 29 Nov 2010 17:25:58 +0100
Message-ID: <AANLkTi=Ob=7fvZUGNBy22r4+Pz31tgA+LeY4RqSTf1KU@mail.gmail.com>
References: <1291042075-19983-1-git-send-email-giuseppe.bilotta@gmail.com>
	<1291042075-19983-6-git-send-email-giuseppe.bilotta@gmail.com>
	<AANLkTinGustedMv9rm+RgGMQckfxgbTPA+Yqpz7vqTfm@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 29 17:26:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PN6YL-0002bi-Cr
	for gcvg-git-2@lo.gmane.org; Mon, 29 Nov 2010 17:26:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752456Ab0K2Q0D convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 29 Nov 2010 11:26:03 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:47494 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752133Ab0K2Q0B convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 Nov 2010 11:26:01 -0500
Received: by eye27 with SMTP id 27so2051163eye.19
        for <git@vger.kernel.org>; Mon, 29 Nov 2010 08:26:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=x8GxS6uuBArcRwSensA+RCGA9yzMf/smyoSfDvOV3TY=;
        b=wIX5Swh3574PZBXkjXuR9nNpgBjUixJ8KsHv/p5ANMxUK33tbocSUF20nuyFB4Z1Px
         HRFSsuN/sS88RssSXPCy6JiQfwTt+lN1HR3EIVA0hI5TlqbfqhCIVkeMDhdzJZiELTGr
         Upded07RpOiG7kjNWk9wsbkR8+eBiLA/P0JEw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=oWeFyFh9q7ZNIilbzp0bAmACOaHTfvnqcH2lhrAZLCiRW8xhxPavxHxKQM9LFsk/aX
         +l0KjIn+x5xDjnokNfhXxT2V8dExsnZ+suDpzrOYPJG6hqbYz/knPvCB7BCprzs483++
         HsgjfaWvLjrqe+GxY2syAsTDrUn4lIUVyD0YI=
Received: by 10.216.160.1 with SMTP id t1mr611536wek.2.1291047958615; Mon, 29
 Nov 2010 08:25:58 -0800 (PST)
Received: by 10.216.85.213 with HTTP; Mon, 29 Nov 2010 08:25:58 -0800 (PST)
In-Reply-To: <AANLkTinGustedMv9rm+RgGMQckfxgbTPA+Yqpz7vqTfm@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162396>

On Mon, Nov 29, 2010 at 5:18 PM, Christian Couder
<christian.couder@gmail.com> wrote:
> Hi,
>
> On Mon, Nov 29, 2010 at 3:47 PM, Giuseppe Bilotta
> <giuseppe.bilotta@gmail.com> wrote:
>>
>> +# Debian and derivatives use x-www-browser or www-browser to set
>> +# the default browser for the system
>> +if test -z "$browser" ; then
>> + =A0 =A0 =A0 wwwbrowser=3D"/usr/bin/www-browser"
>> + =A0 =A0 =A0 if test -n "$DISPLAY"; then
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 wwwbrowser=3D"/usr/bin/x-www-browser $=
wwwbrowser"
>> + =A0 =A0 =A0 fi
>> + =A0 =A0 =A0 for i in $wwwbrowser; do
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if test -x $i ; then
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 verstring=3D"$($i --ve=
rsion 2> /dev/null | head -n 1)"
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 browser=3D"$(echo "$ve=
rstring" | cut -f1 -d' ' | tr A-Z a-z)"
>
> Stupid questions:
>
> Did you check that all the browser we support accept the --version op=
tion?
> What if we add support for a new one that doesn't ?
> Shouldn't we add something like :
>
> test -z "$browser" && browser=3D"$(echo $i | cut -f1 -d' ' | tr A-Z a=
-z)"

Sorry I mean:

 test -z "$browser" && browser=3D"$(readlink $i)"

> And are you sure that when they support --version, the first word of
> the output is
> better than "$(echo $i | cut -f1 -d' ' | tr A-Z a-z)"?

and: "$(readlink $i)"

Thanks,
Christian.

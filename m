From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH 5/7] gitweb: auxiliary functions to group data
Date: Thu, 16 Sep 2010 10:26:46 +0000
Message-ID: <AANLkTinU3dQnricwXsf_-b1skWMCaNGxSLYLpOJZ94cm@mail.gmail.com>
References: <1284629465-14798-1-git-send-email-giuseppe.bilotta@gmail.com>
	<1284629465-14798-6-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 16 12:26:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OwBg8-0005SE-DF
	for gcvg-git-2@lo.gmane.org; Thu, 16 Sep 2010 12:26:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754041Ab0IPK0s convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 16 Sep 2010 06:26:48 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:50058 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753683Ab0IPK0r convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 16 Sep 2010 06:26:47 -0400
Received: by iwn5 with SMTP id 5so950697iwn.19
        for <git@vger.kernel.org>; Thu, 16 Sep 2010 03:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=xIK6sQxlGiQMo1XKG0MK1LpG9+H1P57eSJl9bFPP7Z0=;
        b=B9jLJmGOqGcF1+/VOyyHDW3NCD1Yal+QdoczSWpr7Q8cATOdoZkx0CJZ6b6FuSs+pV
         lce60h7lo623fSJ0bLWIy3vk8OxFtlc4ZMeQgoByNXqhsVNSiUJgVtmvWiw+f9fz81aY
         xT6plwY5+WbkhmRLFaEKFU8DD5fozMMT9c8Vw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=TAv+hp4fRE9Zngmn4np1jR/PhLuTIh6FBof8/t39ZQoM9zuZQkR1tKAQNLXwr1PzlI
         Bi7Ul6LNCIHtH+LETqLtBugnVk74znXrYTYFjxNs/Z609P7IP2XOJyouxSx7CWjYyCs2
         gbODyumG6JFlZMsHF1AcsDhkZQF/m06cqoc7c=
Received: by 10.231.34.139 with SMTP id l11mr3159057ibd.141.1284632807014;
 Thu, 16 Sep 2010 03:26:47 -0700 (PDT)
Received: by 10.231.171.145 with HTTP; Thu, 16 Sep 2010 03:26:46 -0700 (PDT)
In-Reply-To: <1284629465-14798-6-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156312>

On Thu, Sep 16, 2010 at 09:31, Giuseppe Bilotta
<giuseppe.bilotta@gmail.com> wrote:
> Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
> ---
> =C2=A0gitweb/gitweb.perl | =C2=A0 15 +++++++++++++++
> =C2=A01 files changed, 15 insertions(+), 0 deletions(-)
>
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 6138c6e..92551e4 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -3765,6 +3765,21 @@ sub git_print_header_div {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0"\n</div>\n";
> =C2=A0}
>
> +sub git_begin_group {
> + =C2=A0 =C2=A0 =C2=A0 my ($class, $id, @rest) =3D @_;
> +
> + =C2=A0 =C2=A0 =C2=A0 $class =3D ' class=3D"' . join(' ', 'group', $=
class) . '"';
> +
> + =C2=A0 =C2=A0 =C2=A0 $id =3D ' id=3D"' . $id . '"' if $id;
> +
> + =C2=A0 =C2=A0 =C2=A0 print "<div$class$id>\n";

Hrm, this would be better:

     $cgi->div( { class =3D> "group $class", $id ? (id =3D> $id) : () }=
 )

> + =C2=A0 =C2=A0 =C2=A0 git_print_header_div(@rest);
> +}
> +
> +sub git_end_group {
> + =C2=A0 =C2=A0 =C2=A0 print "</div>\n"
> +}
> +

But obviously that won't fit if the closing element is being printed
separately.

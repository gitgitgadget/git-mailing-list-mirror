From: =?UTF-8?B?cnllbnVzIOKXhw==?= <ryenus@gmail.com>
Subject: Re: [PATCH] repack: find -> /usr/bin/find, as for cygwin
Date: Sun, 20 Mar 2011 00:43:23 +0800
Message-ID: <AANLkTi=EQhtOM3dR8V5dxP=AfNxWuSFoTbvzL36q3rXL@mail.gmail.com>
References: <AANLkTimHof_MNSGbU2KGX=7Q3MQpjkzXK+xyGGVjbngR@mail.gmail.com>
 <AANLkTimPbz2s=Maafhqg-7wOk_TT4fFSh7AQ-3rWY0A3@mail.gmail.com> <AANLkTinxyp=PbvzRkyyxXin5aOFm1NP4Be6U2Dv0aD6d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	git@vger.kernel.org, gitster@pobox.com
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 19 17:43:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0zFl-0007EK-5u
	for gcvg-git-2@lo.gmane.org; Sat, 19 Mar 2011 17:43:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756733Ab1CSQnp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Mar 2011 12:43:45 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:37934 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755277Ab1CSQnn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 19 Mar 2011 12:43:43 -0400
Received: by ywj3 with SMTP id 3so1942394ywj.19
        for <git@vger.kernel.org>; Sat, 19 Mar 2011 09:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=BPt/6iTNcMxNb1Zf+fZCTCPYgMZlsPH+vigSayHJqdg=;
        b=RCVUSYap5xjH8OgnChKUqamYmUieSUOkjBO0bp4u2o5Xu33BhgdIcHhpbWw65r9DPS
         lgs3i1Kwna6rM5K+GhUanRHDMzX+M7jPAkyYOTjXpNAhp3diICzyo0Hn4ROtS+dKOFaC
         DHh4banSEmD2Seciy2Qjgo5l1/o/brDSAckKc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=AEmpLtlbROwoPZroX4MmajuOyMprRA3yXY2HhFMhvW0Zi0aC1cu/jQXw9UgvpP1sMz
         N8gWdMMqvJ7aSygPcsL5UvSQzg6mNd3MRSaO0qB39ZmZf1pAGOx88xNBN5bJaw/kHFut
         0EpjDt9vLgYLbdeaYDitzxIDSLkQjFYtppiGk=
Received: by 10.100.193.12 with SMTP id q12mr1835771anf.7.1300553023110; Sat,
 19 Mar 2011 09:43:43 -0700 (PDT)
Received: by 10.100.121.3 with HTTP; Sat, 19 Mar 2011 09:43:23 -0700 (PDT)
In-Reply-To: <AANLkTinxyp=PbvzRkyyxXin5aOFm1NP4Be6U2Dv0aD6d@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169448>

OK, I've been away for a while and didn't notice latest replies :-) do
you mean find is not used elsewhere in git?

Anyway, looks like checking for both MinGW and Cygwin still applies.

Thanks

On Sun, Mar 20, 2011 at 00:32, ryenus =E2=97=87 <ryenus@gmail.com> wrot=
e:
> Thank you, Duy, you're almost right, I just checked git-sh-setup.sh,
> in the bottom, sort and find are defined as functions like what you
> pointed out, but only for MinGW, therefore a better fix is to check
> for cygwin as well:
>
> ---
> =C2=A0git-sh-setup.sh | =C2=A0 =C2=A02 +-
> =C2=A01 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/git-sh-setup.sh b/git-sh-setup.sh
> index aa16b83..5c52ae4 100644
> --- a/git-sh-setup.sh
> +++ b/git-sh-setup.sh
> @@ -227,7 +227,7 @@ fi
>
> =C2=A0# Fix some commands on Windows
> =C2=A0case $(uname -s) in
> -*MINGW*)
> +*MINGW*|*CYGWIN*)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0# Windows has its own (incompatible) sort =
and find
> =C2=A0 =C2=A0 =C2=A0 =C2=A0sort () {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/usr/bin/sort =
"$@"
> --
> 1.7.4
>

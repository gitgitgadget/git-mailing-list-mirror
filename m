From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH v4 03/13] parseopt: make OPT_INTEGER support hexadecimal
 as well
Date: Sat, 4 Feb 2012 11:55:30 +0700
Message-ID: <CACsJy8Ba2qxyT4XqeRmUv63Z3rT1-FmBkZ3tB6YMh6qrXjLP1Q@mail.gmail.com>
References: <1328276078-27955-1-git-send-email-pclouds@gmail.com>
 <1328276078-27955-4-git-send-email-pclouds@gmail.com> <7vaa4zmsku.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 04 05:56:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RtXfU-0006JA-Ag
	for gcvg-git-2@plane.gmane.org; Sat, 04 Feb 2012 05:56:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754508Ab2BDE4D convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 3 Feb 2012 23:56:03 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:42247 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754390Ab2BDE4B convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Feb 2012 23:56:01 -0500
Received: by bkcjm19 with SMTP id jm19so3583290bkc.19
        for <git@vger.kernel.org>; Fri, 03 Feb 2012 20:56:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=3PJTtLoI+QENZUm5fJjXafME0H1G107ymVB7KIUbcI4=;
        b=L+3I6jmow1IRNKJTYFJ/CxerLEkmYTAgk13FaqYkJ9qHSFrL2JVMS8t1SCE4ngvJNc
         T9vqLQYHUj+Pjx+v7kNa3wwuUSRf67D5wrjuQ9SIMtDPXfFBid8+0DPCmJlRCPUhZFSn
         sGRKsJMKpTOxmM73J4DTOnjrmn/h1XxbnnBqU=
Received: by 10.204.130.150 with SMTP id t22mr4679551bks.1.1328331360182; Fri,
 03 Feb 2012 20:56:00 -0800 (PST)
Received: by 10.204.33.70 with HTTP; Fri, 3 Feb 2012 20:55:30 -0800 (PST)
In-Reply-To: <7vaa4zmsku.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189839>

2012/2/4 Junio C Hamano <gitster@pobox.com>:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy =C2=A0<pclouds@gmail.com> w=
rites:
>
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *(int *)opt->value =3D s=
trtol(arg, (char **)&s, 10);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!prefixcmp(arg, "0x"=
) || !prefixcmp(arg, "0X"))
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 *(int *)opt->value =3D strtol(arg + 2, (char **)&s, 16);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 *(int *)opt->value =3D strtol(arg, (char **)&s, 10);
>
> Can't you just do "strtol(arg, (char **)&s, 0)" instead?

I could but that means "01234" is now in base 8 and that's currently
accepted as base 10. 0x1234 does not have this problem because current
git rejects it.
--=20
Duy

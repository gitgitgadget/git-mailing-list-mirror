From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH svn-fe] fast-import: make code "-Wpointer-arith" clean
Date: Mon, 28 Feb 2011 22:36:33 +0100
Message-ID: <AANLkTikD8qQKdhXN9dx+hk8r=eGRBtc3eRSFU2vDxmsP@mail.gmail.com>
References: <20101224080505.GA29681@burratino> <20110226114435.GB12231@elie>
 <7vhbbolm5q.fsf@alter.siamese.dyndns.org> <20110228213210.GD1942@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	David Barr <david.barr@cordelta.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 28 22:37:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PuAma-0001R8-TZ
	for gcvg-git-2@lo.gmane.org; Mon, 28 Feb 2011 22:37:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753095Ab1B1VhR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Feb 2011 16:37:17 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:33143 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753018Ab1B1VhN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Feb 2011 16:37:13 -0500
Received: by ywj3 with SMTP id 3so1422821ywj.19
        for <git@vger.kernel.org>; Mon, 28 Feb 2011 13:37:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=K0I9rEMqF7Ie6m+L7ePP6fFo5BQPsc8FSYmUwH9qemk=;
        b=HvYkIs0OzKOzTy948UQ9jczlEPCGzAV3WGiAU3xdmzQoRFZYWRvclojZO6kK+lXq3V
         ULJlYjlJNJc6Tq1w8Q+FSyUPKtGJAktZiWVRIZ2iyLN+YhmrDkLPahcxJ30IN3zQB6DG
         guk8lT5x215jmSUgNz5FKZZ0QqLB/YxD+jfoo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=TQ15WXkYeZY7NKUNrrD1SyP1oP/KY2SsXUIpuisxbGtBP9Odu8TBQLYcTeaaxM+pTi
         M9Dshz07+RnFFiYivxrfMxDUBglSyhdmRoIaPM2Tg9QaZVOjkAao24Q5w+CLPjLHukIg
         BePbt//h9c03hEQJFmchYOWULg04pCt4PmNaY=
Received: by 10.150.8.10 with SMTP id 10mr7907756ybh.7.1298929033099; Mon, 28
 Feb 2011 13:37:13 -0800 (PST)
Received: by 10.151.11.12 with HTTP; Mon, 28 Feb 2011 13:36:33 -0800 (PST)
In-Reply-To: <20110228213210.GD1942@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168150>

Heya,

On Mon, Feb 28, 2011 at 22:32, Jonathan Nieder <jrnieder@gmail.com> wro=
te:
> This should fix it, I suppose? =C2=A0A
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0-std=3Dc99 -O3 -Wall -W
> =C2=A0 =C2=A0 =C2=A0 =C2=A0-Wno-sign-compare
> =C2=A0 =C2=A0 =C2=A0 =C2=A0-Wno-unused-parameter
> =C2=A0 =C2=A0 =C2=A0 =C2=A0-Wno-missing-field-initializers
> =C2=A0 =C2=A0 =C2=A0 =C2=A0-Wno-empty-body
> =C2=A0 =C2=A0 =C2=A0 =C2=A0-Wno-pointer-to-int-cast
> =C2=A0 =C2=A0 =C2=A0 =C2=A0-Wno-type-limits
> =C2=A0 =C2=A0 =C2=A0 =C2=A0-Wno-unused-but-set-variable
> =C2=A0 =C2=A0 =C2=A0 =C2=A0-Wold-style-definition -Wpointer-arith -Wv=
la
> =C2=A0 =C2=A0 =C2=A0 =C2=A0-Wdeclaration-after-statement -Werror
>
> build passes, except for an "unsigned long expire" in builtin-reflog
> that confuses this copy of gcc.

How come this slipped by unnoticed (except by Junio)? Is the default
Makefile not strict enough?

--=20
Cheers,

Sverre Rabbelier

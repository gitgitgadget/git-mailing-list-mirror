From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 9/9] for-each-ref: support %(...:aligned) for left alignment
Date: Sun, 19 May 2013 17:02:31 +0530
Message-ID: <CALkWK0md-p25EkyyAjGE3_Ygq-4rEqQ6saG3dDq--FGRqGbF6Q@mail.gmail.com>
References: <1368959235-27777-1-git-send-email-pclouds@gmail.com> <1368959235-27777-10-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 19 13:33:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ue1rf-0008TT-Pv
	for gcvg-git-2@plane.gmane.org; Sun, 19 May 2013 13:33:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754156Ab3ESLdN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 19 May 2013 07:33:13 -0400
Received: from mail-ia0-f178.google.com ([209.85.210.178]:50594 "EHLO
	mail-ia0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754077Ab3ESLdM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 19 May 2013 07:33:12 -0400
Received: by mail-ia0-f178.google.com with SMTP id i9so6367113iad.23
        for <git@vger.kernel.org>; Sun, 19 May 2013 04:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=TpZfqNWNN2MwzUkaHtC8zprROV/10h9TK+8pVPm4GHs=;
        b=zEAu8I2KpA64by2MpZw9Tn4olTE/1VUqvdwL+2ADV++GlxKJ1sM7tiOAwJvZhVFvEE
         Dgoo8+jKJEz3e43rs66bVd7ZS/omXao5+kzxYKsprNb4YOPKAWAXoyAqYEongE+TPso9
         9ewCb9eBUdrOhzGbptPiQ3BdX7EtpT8vZuAFQy/ss7/guGJ+YCSrQDleM2AHsxHUdc9Z
         Oqxr9pwvCXmoOWyteVa/HvW8UAVS/wVUL8F3bV8bMl5OzgNmjlp9sUoZAYeEIKwBOgLw
         o3uHrTCKskIWARmuNKbJN8z1jZhvoNMRJf6exdUfaWxLqBtih9FIfHvAGK79GhpygApQ
         CzSA==
X-Received: by 10.50.3.38 with SMTP id 6mr2840630igz.44.1368963192111; Sun, 19
 May 2013 04:33:12 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Sun, 19 May 2013 04:32:31 -0700 (PDT)
In-Reply-To: <1368959235-27777-10-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224854>

I don't think [7/9] and [8/9] belong in this series.  Let's see how
you've used it in :aligned.

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
> diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
> index 1390da8..3240ca0 100644
> --- a/builtin/for-each-ref.c
> +++ b/builtin/for-each-ref.c
> @@ -1012,8 +1013,26 @@ static void show_refs(struct refinfo **refs, i=
nt maxcount,
>                                 emit(sb + i, cp, sp);
>                 }
>                 atom =3D parse_atom(sp + 2, ep);
> -               for (i =3D 0; i < maxcount; i++)
> +               aligned =3D !suffixcmp(used_atom[atom], ":aligned");
> +               for (i =3D 0, max_length =3D 0; aligned && i < maxcou=
nt; i++) {
> +                       struct atom_value *v;
> +                       get_value(refs[i], atom, &v);
> +                       len =3D utf8_strnwidth(v->s, -1, 1);
> +                       if (len > max_length)
> +                               max_length =3D len;

Why?!  Why are you denying me the pleasure of using %<, %<|, %>, %>|,
%>>, %>>|, %<>, and %<>| that you invented in pretty?  The code is
already there: you just have to hook it up.

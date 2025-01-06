Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 211581DF271
	for <git@vger.kernel.org>; Mon,  6 Jan 2025 19:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736191621; cv=none; b=Ff2Tfq/lDFmSK4kOvYoknYCGKdUCjl2MgBi1RoSSZF20NeE5EXXE/OONZC20/1g6Z9J2tLZgqQTBA1D/g1WZObxTmEp9FzKfvhunc6ifAhwnNa73PkdDHbLFllLPnU4FEX6k89T/HysYaFFqHeGe3XC4FbkwjMx41iG/fjt7W50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736191621; c=relaxed/simple;
	bh=Eike1Ur4nVGCS6+VOGie4mMbAkivSYt3C8lCwafw0aw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sr9u4jxp+oBNOSHh1PAf4ENvEiJNyiZPePuielOx6ZAAhwYOt+T6hz7Z2vtR4i7AQ6LxFK7K4owu35o7b+xQ+85WklNBcKS3Y1lf3dgDNnsbxpDvY98qDG3PvfeGDjt3EObv2oJ/nMBgiZ8a2uGa7Q1X/oYfIXiPdgN3qqifZfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aWtaVj/W; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aWtaVj/W"
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3a9d9c86920so56592335ab.2
        for <git@vger.kernel.org>; Mon, 06 Jan 2025 11:26:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736191619; x=1736796419; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7FtfRXI0EMus8VyKvs9nJ1lsp+I39UeJKWrm5QAnifA=;
        b=aWtaVj/WDEWg0p9d+Yel6fK0+xpq6b6qtiorTUUQbWG1ZiplRpaLGFjNbuTUB6TZCf
         K/zpxtb1uOU9sDdAOODn7lFUkum6pT6PxGYhlmGDxy7GdhL/ZIYMWb3E6S+rSPLca7xD
         cVTl3nYpa5lFw1LvuoaXAmuuFC/gA7+LgvS4OmBAuUn0Mas9SLafDFu79rHdtumTNf7n
         F3DDsan6vx1vafL3v6N8F7FK3D7zpmf18oPTSZRmyieeQP81DKSbgMBBQNYECsB2oVN9
         16Qy+R69xQPPYjTSWCiC8H6gCLOCpSyY+aYaEORP1gmD0QBmPiWoV3eHtfn02R88bSb+
         co5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736191619; x=1736796419;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7FtfRXI0EMus8VyKvs9nJ1lsp+I39UeJKWrm5QAnifA=;
        b=gGm0QbgJNrTyxk4EMP5mav8s4Ni43iE0ycrMQM5vS4Dn8oUZCNLlQrPQK/9S54GfJl
         rG3STH0fbb+tTALkU5FmamtYFtlmNi6bExro8JrhkHmVMar6NP8jDGn5XVL+4doFTv9z
         arBplWh3DOYXCotuSL4QjwS2esWIUroncRBtp+gVpngBoRc19xii1SJMANaR6Z4N87Ce
         k/Vv8V9RlX6luCltcP/CWeMZI9ocaHCgGcdICHCCxZucibXyBKOP05xTPwjQ9E6IUD5S
         +a6syexeg6gI/bfmAS8XvKIfxD/QhG19nOC0fRqiOHDac2Jyg61ITYPZkBUcFLj0LYjj
         mqtw==
X-Forwarded-Encrypted: i=1; AJvYcCUSmsKDGG3KdeNOUo/WNr8oO705OwL1ijMXfXKCfIYnrZdNWnALiTdze/X2/1hOlCT0pe4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+vFOoEMmW3ULTuy/5gOld+g0GM3b5LJTz9iHlxu8By6nAIvOZ
	wnYVIupMCf0zyRaTrJuCff5qrwMuZya72vNGy9w+8Aa6v+u6QO3s2o0IoMFJEV7EsP+qijC/d/u
	YO/iDor0ew7kcTiLafkX/eE3rMzx49tG6
X-Gm-Gg: ASbGncsAe3UnagT4FOJgnW7uCnDUEWNqQWBj6N5FRPMQKo7ELVT6go8t5zp89BKA0h6
	eT36NoDWFbAFp+UyoLbyIu+viv/CldTVhjnByWaipPSiO1ermMfwqQ3b1Ho9n4rjsjUbUcZM=
X-Google-Smtp-Source: AGHT+IGNNs9t6Q3JyiD50ik23nVuLhPWzaShfzkuwRLPi6mi/10Xn85hwpIimxziYvh7VOmWdLva5IWX73yxJPSa/nA=
X-Received: by 2002:a05:6e02:310c:b0:3a7:8cdd:c0d2 with SMTP id
 e9e14a558f8ab-3c2cc083da3mr468784055ab.0.1736191619255; Mon, 06 Jan 2025
 11:26:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1844.git.1735699989371.gitgitgadget@gmail.com>
 <pull.1844.v2.git.1735949870.gitgitgadget@gmail.com> <xmqqbjwjzw9b.fsf@gitster.g>
In-Reply-To: <xmqqbjwjzw9b.fsf@gitster.g>
From: Elijah Newren <newren@gmail.com>
Date: Mon, 6 Jan 2025 11:26:48 -0800
Message-ID: <CABPp-BHyWgu47mCDH_f_MkS4CMGh_OtX4K-YGFsB-fZvvaNJPQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] object-name: fix resolution of object names
 containing curly braces
To: Junio C Hamano <gitster@pobox.com>
Cc: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 6, 2025 at 9:29=E2=80=AFAM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > Maintainer note: these bugs both date back to 2006; neither is a regres=
sion
> > in this cycle.
>
> While I was preparing today's -rc2 release, I noticed that this
> change broke some of my release scripts with
>
>     $ git rev-parse --verify v2.48.0-rc2-161-g6c2274cdbc^0
>     fatal: Needed a single revision
>
> which is the construct that has been there almost forever.  Its
> expected output is
>
>     $ git rev-parse --verify v2.48.0-rc2-161-g6c2274cdbc^0
>     6c2274cdbca14b7eb70fb182ffac80bf6950e137
>
> The series seems to need a bit more work.

Gah, I made sure to copy the object name into a string buf, so I could
operate on just the relevant part, but then ignored that and operated
on the full thing.

This fixes it:

diff --git a/object-name.c b/object-name.c
index 614520954c7..cb96a0e6161 100644
--- a/object-name.c
+++ b/object-name.c
@@ -1318,7 +1318,7 @@ static int ref_and_count_parts_valid(const char
*name, int len)
        len =3D cp - name;
        strbuf_init(&sb, len);
        strbuf_add(&sb, name, len);
-       ret =3D !check_refname_format(name, flags);
+       ret =3D !check_refname_format(sb.buf, flags);
        strbuf_release(&sb);
        return ret;
 }

I'll include it with all my other fixes in a reroll, which I'll
probably send out after 2.48 to avoid distracting from the release.

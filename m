Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA98A314A73
	for <git@vger.kernel.org>; Tue, 14 Oct 2025 13:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760449275; cv=none; b=unP84DjZpeiCWQ1OPl5EtsWSeuAADIgMVe0QRHpD0OAEzqs3RDwiv3k9fEaEsQGvzfUKW31v9YFxeo784kYe3vXt9QZPFqbIHG7I8HNuB3TxlUYyQbxFSxPGQZPQkMNFLoKEdf1rPAWuxCHoY8Xnm3mFD0fe+UB2L1rFUQFoZEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760449275; c=relaxed/simple;
	bh=vnbfbbbNytWCCFQqcoM1jAffS+YnUwMBiTjkMFMebcI=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s5C79HS5JgzuDXcSouuDUp4kA4JfWwylh0/hmKFhkOHzqcHW1fIvqSCS2psFVFouO7YDVVrVz3rqdXF0+/+/QYxoclq+/Mp7R6oOnGLdDV7TAF2E95k48VCipul8KO/0l1gyvgEW0U7TXPJEwa9aLxgtKsUB3igCakAcgHtXZ6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JW6S1gqa; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JW6S1gqa"
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-554e726e5cfso946174e0c.3
        for <git@vger.kernel.org>; Tue, 14 Oct 2025 06:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760449272; x=1761054072; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=33O8gr4bVYigdad5vtM2a3s7z8SywN2qbVsFyQhdR3A=;
        b=JW6S1gqa5GQJFbDigB5NvgFa7Z4tEUFIsGrqOfOonWwFezreWO3A4KucM2Co2ne6Y4
         9drA/a1u0RoU7p1pNGhPWAgLxM6eb/BrL0r+TvCtI5RW1G0X5VJUFsLIaVVlV6ymtW08
         4LLTD4Xjk6Q4GZRHDPF79NPISr+fVTciNdJKuYmOogAb6CIWo3HRASdk8qkOQNFfN4Ny
         cF9d4pQqCnTVVPNdgJk5S06JN5FhgBPD+3LZZXQvn8mrRJidqnYfEThs9nxwBQHmatnV
         iEWKeXJtCPDYvd4GqhWlBkNKTsbe3Xm2n3PQ1fVPc77XUJPmn4NZZvHKXCCYmOEmshbC
         ZLKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760449272; x=1761054072;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=33O8gr4bVYigdad5vtM2a3s7z8SywN2qbVsFyQhdR3A=;
        b=fOn/F+Xn2mqFrdtYRqO95xeuMm/gcOjbMEgMkT9wdWkGOsSnnJSkQ1rWC5OiTQJASj
         h9YAUR/sFdKqDQysCuywUtHzUJzAPQY008Yobf1Mv6EZcsT5WSz+I5ICvpQX9GSlymKG
         quP0GkIE6Gl6pVVO0gCSEB9lRrehiGiBBc49/V4b11MISCShYVsvD2zJdbLH3N62AlUs
         QfvkRcEQDMzKvRp1CAQgoeQ5qGV76HIiwUDbr8U+BH9bUkf2SNAypltZYzGTlBBCxtYS
         +vw0VfS05VNVrzZHeTQbjx/y4VlxtjNB6hr4zrV9TcHhYhKuFcmoJuK8cY7EtDkL1Nii
         uGXw==
X-Forwarded-Encrypted: i=1; AJvYcCUNSb5U6lcxsrbyovfgv+AKX2anMrEkQLlja7JQRHn87Bif5FFcKOc4igs5tDBSHz0Ezcs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxveIfgqx3F5K5lRMSejXj1/trvpYjMaAfkQkwDZtfgGdJE1cIW
	9CRfLAuptOzb3z82bna+V1ubAqRj32ARohOiEBLs/lEyEzlHvR91RRdkVFt41SENs59RoYYhZPH
	/58N8L/Msyf4rmp7JAEu+eYWrA+7YQGI=
X-Gm-Gg: ASbGncuTvIYQYLfSr9+/C7MYeFmceejCza7XkTguq/9U8BlW39FIrjWYUpGJampvWR4
	77SQoU7UHmoQUYWu5Aodt9akVBVSVIKAstCpDaJoGA4qlLFeZJfKGZZbzyXOTr4HuHQKY0koNLy
	XauUBZV3Xd7rlmTLPLp591irF+fZkD1WZaG0yBhqyEqLAKwG9a5SvlGWhHXlxbyPiu0nSzv/+WA
	BIYzbV76YKCtEuxczVx5XeQV9lsgypvXGDYq8JMNtio5cOLHKD0Uxim5LX/h56xZvbD4vk=
X-Google-Smtp-Source: AGHT+IGgRX6rIF/O3yzeJoXKEQR5vJNMvQxigvT0CwtMnKPu4vKRpnZuEVidtHKGlbIBQSTJ74OaIKhmBeySjo7yoD8=
X-Received: by 2002:a05:6122:3c46:b0:54a:1e96:e958 with SMTP id
 71dfb90a1353d-554b88e4b6emr7639832e0c.0.1760449272524; Tue, 14 Oct 2025
 06:41:12 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 14 Oct 2025 09:41:11 -0400
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 14 Oct 2025 09:41:11 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20251001-b4-pks-history-builtin-v4-0-8e61ddb86317@pks.im>
References: <20250819-b4-pks-history-builtin-v1-0-9b77c32688fe@pks.im> <20251001-b4-pks-history-builtin-v4-0-8e61ddb86317@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 14 Oct 2025 09:41:11 -0400
X-Gm-Features: AS18NWAjbAMN587BpCl2uedTgNkuSKPN8h_wImgCR84zaCMeP5-Wg5bjwC2y-Xs
Message-ID: <CAOLa=ZRa6s1CMq19Z4GDz2HGsw6TCUQ4eu-nC26P2=qP2Jb6ug@mail.gmail.com>
Subject: Re: [PATCH v4 00/12] Introduce git-history(1) command for easy
 history editing
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
	Sergey Organov <sorganov@gmail.com>, =?UTF-8?Q?Jean=2DNo=C3=ABl_AVILA?= <jn.avila@free.fr>, 
	Martin von Zweigbergk <martinvonz@gmail.com>, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Elijah Newren <newren@gmail.com>
Content-Type: multipart/mixed; boundary="00000000000088d4ac06411e89a1"

--00000000000088d4ac06411e89a1
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> Hi,
>
> over recent months I've been playing around with Jujutsu quite
> frequently. While I still prefer using Git, there's been a couple
> features in it that I really like and that I'd like to have in Git, as
> well.
>
> A copule of these features relate to history editing. Most importantly,
> I really dig the following commands:
>
>   - jj-abandon(1) to drop a specific commit from your history.
>
>   - jj-absorb(1) to take some changes and automatically apply them to
>     commits in your history that last modified the respective hunks.
>
>   - jj-split(1) to split a commit into two.
>
>   - jj-new(1) to insert a new commit after or before a specific other
>     commit.
>
> Not all of these commands can be ported directly into Git. jj-new(1) for
> example doesn't really make a ton of sense for us, I'd claim. But some
> of these commands _do_ make sense.
>
> This patch series is a starting point for such a command. I've
> significantly slimmed it down from the first couple revisions now
> following the discussions at the Contributor's Summit yesterday. This
> was my intent anyway, as I already mentioned on the last iteration.
>

Hello,

I'm jumping in directly to review the fourth version of the patch
series. As such I might have missed discussions in the prev versions.

Apart from small comments and questions, it looks to be in a good shape.
I think the addition of changes would perhaps warrant a re-roll but we
should be close :)

Thanks,
Karthik

[snip]

--00000000000088d4ac06411e89a1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: a6e50ef731efee9a_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1qdVV2VVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1meUx3Qy80cTljQjIvTUVSakMraE92VEQrdTRzUlNwSgpXTmg2Wmp2TE1x
SEI1dzZOVXNwa1Z1bFh5MWxaMVhnNlZzS0wzWnkyWE9CZWZEcFJYWnlrNkNZSG1TdXl4bzJTClhR
RzlUYmIxYVNIRE5NajFNbHpZS2I4L2JjOEFJNGpjQzdjazZxYmlLLzVJWkFlUGVsQzdhbnNzWjly
V09iMisKMnlyVThmeFBxMHlQWWxSOVQwb2Vra2RxekJwOU1CbnlWWlVkc3k3RmpTOXRXRnhXNE8r
QitJMG11Mjl5Vm5mLwpEVzRvbGVjcWYxYSt3T1A3OCtYUXl5enQ4WEF0ODBPQWhva2NUWXgraGNj
OE9nUGxZbXJMckxYbDMrZUY2SEdiCmxQeGlVdjhuOUc5S0hCczB3L29zUGM4YUZ2cUlZR2Z2UVk5
amJqSnoyU2prYm1QZUVhemQzVTBHY25aZlZyWm8KZGxmQWwrdjVHYWUxYXZsZkUvOHRxYktSWWND
NXIxSGNSMGI1UHFVaW9ISEcxQzBFM3c4a2Ewb00vdW9zWURSbgpwV1lHcFNBWVhZNGFTdUJhbXRh
SUMzalcrbkpybFpZVUl4NzBOc3R1SDk3c01XNzRYaUMzWjk1Y0tIMWlYR1RTCkl6a25abXhsWFlX
dzFlTGlZNGFacWNoWlhLZGJUenA1L0laamRUaz0KPWdVajcKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000088d4ac06411e89a1--

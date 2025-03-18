Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 511C8207646
	for <git@vger.kernel.org>; Tue, 18 Mar 2025 09:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742289921; cv=none; b=dHmlcUC3bR+IXeHJ43sta5hwK/JDWBWr9bcHgW4iS3TYHA/OT99SOZNJipB1J4YJs6CP+V/cClVM79goGgexsqw2FjjV+Ib8MV9Z8sGSkzAkxSjbRBV4aCyXQOMmmhrySe8VMFbCPjIs0ZtGD5EeHVT4FgUdilXFv1fcO5OfcD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742289921; c=relaxed/simple;
	bh=afok3LpiTH83O1MlFTtcH2RcA9CDYqZDfXl6q83H1zs=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F0YlCW0Hy+PpAHLbdAMhl+5xfyjpZqTZoj3Wy9zvAdolpuZhudMIyfFWGpXrOZOnncOCi2gfDdl8d2bjEt2jskl6o/zy4BH5tffZg+IQAnKHjShU94OjwGg9UYvx8i1I6iXNl68pfVcySfqPJjs5WZjycpKsDGAzFCRjcVsvSfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PVcNwDEB; arc=none smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PVcNwDEB"
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-86dc3482b3dso1976953241.0
        for <git@vger.kernel.org>; Tue, 18 Mar 2025 02:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742289918; x=1742894718; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=afok3LpiTH83O1MlFTtcH2RcA9CDYqZDfXl6q83H1zs=;
        b=PVcNwDEBwfL4kZJUjVEw00ajk4vdvGbZIVZktJIkF8jn9zmQcE2/ZzGN2AOuWXAG44
         7MZJ7c8e/sNiltGlYGIaOL9YgWU/XL7AR54SB+npa35uDOhAbwloJo/t8QKFLx28uKKb
         teDYmMQYrNm+Ys24mTtfYt9S0KjZPAtrty/kS13SZ+a6bw6RRSo/bXR71Kbg5PXRe2qX
         gFAs/TF6UOPs1VlkxOpzQ+/Vu35kEOih4FkKtqIY2S8q0pZYNmQA+A6VONCihj+9MN0a
         LhSuz1T70SCclycwa/MsGCM73l0jfjL4q1efA+EP80r5RsIurtQFE89vu7NhMShKvH3w
         mUwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742289918; x=1742894718;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=afok3LpiTH83O1MlFTtcH2RcA9CDYqZDfXl6q83H1zs=;
        b=OZHw5rDXGwVHDkQFUtKh0twYBH4tvr9e3pwc1nVDS19zhOYS9pU5d2vRpb9/PJ6chg
         cbv7xzR1TreD5toDsXDRtGLDy9mkMtp5Uwx4DJxlSQZLHsTvn7mJER+Wd31WTdaMB4O4
         3FMgoj7x8ZEqdlKwyNlhy9EK/AqpHCREfqHGh6uJpDEsYUlSIUNoeYa4MQT9hAKMtOev
         xBvi94+6OScrnCh32h8zZ3rMZ3OtdNCaIO0EGQP540Hftqrn/AH/rceW3J10Ah4V/OAQ
         4lVKYdd/K0bT10dRb4Rb5EdkxHxP2+85opfuCa6FbO2zKCa8mwp78h5qLz0MeYLBwEvc
         4T1w==
X-Forwarded-Encrypted: i=1; AJvYcCUN5tXzF7NlJHej6j3mfeWYg+kXxsGGFXWsKjOCCWayS9Pp+RtDqYm5xLN8jAOaXS5QBck=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9RsBsNRxEIcoBQxg73j1uWEsGXmiEXL9WS2tgTJvpxw16US58
	wIQwOIcCih+S8YBJk+yX7kEoulvO+6s+lahGm6gI5W27+k8El+TAFfNj/vaflYHjkmJzOzZc1OL
	er3n5YMRZwLcB+8cRAy87oetMiRIonPdU
X-Gm-Gg: ASbGncvMkKUBgk61x+SJuRROiSw6oVCCHpUWESUAS4IaRfkI4j1sJkpnVXO2Nq0GuJp
	JZfeSMZJv5kbnc0ur/TIkDeKmndAiXWjw8QJt9X1o1TpyvaUlA41JjoS/O2r7XgeOAvoHCpWFXs
	tvDZnPHFfoyv1K4goIY7CgDBNr
X-Google-Smtp-Source: AGHT+IEX/QmG1cqH9cOgzGV3hobhlmgdzO9I1qt9UfW2JcMWWWF6bOmb85OUOiblpT5ijl+ke6MDkI7Zz5k2EsuffkY=
X-Received: by 2002:a67:ee95:0:b0:4c3:878:6a62 with SMTP id
 ada2fe7eead31-4c4da6b95b0mr1398828137.8.1742289918121; Tue, 18 Mar 2025
 02:25:18 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 18 Mar 2025 02:25:16 -0700
From: Karthik Nayak <KARTHIK.188@gmail.com>
In-Reply-To: <CALz2WHD2_F_S3EROi-U-tevjVhGqSCqW4maZwibBEwDOE1SiCQ@mail.gmail.com>
References: <CALz2WHD2_F_S3EROi-U-tevjVhGqSCqW4maZwibBEwDOE1SiCQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 18 Mar 2025 02:25:16 -0700
X-Gm-Features: AQ5f1JpDjR-fivd-MtAIKKM09Um-IND9bDinxqTZK3kb8q-SNj3ru-9au_IhA1M
Message-ID: <CAOLa=ZSkMp+H9PZeBZXK47=fx1sH=S54AuPT=oUosm7F7V8MGg@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_=5BGSoC=5D=5BPatch=5D_Modernize_Test_Path_Checking_in_Gi?=
	=?UTF-8?Q?t=E2=80=99s_Test_Suite?=
To: Sampriyo Guin <sampriyoguin@gmail.com>, git@vger.kernel.org
Cc: ps@pks.im, shejialuo@gmail.com, christian.couder@gmail.com, 
	Ghanshyam Thakkar <shyamthakkar001@gmail.com>
Content-Type: multipart/mixed; boundary="000000000000aa7c4a06309a7bd6"

--000000000000aa7c4a06309a7bd6
Content-Type: text/plain; charset="UTF-8"

Sampriyo Guin <sampriyoguin@gmail.com> writes:

> Hi everyone,
> I've submitted a patch using GitGitGadget. This is my first patch.
> The pull request: https://github.com/git/git/pull/1918
> I'll continue to work on similar patches. I will also explore any other
> patches.
>

Helo Sampriyo,

I think you would still need to submit [1] the patch on GitGittGadget.
This would ensure that the patch would be forwarded on the mailing list.
Finally, the review happens on the mailing list.

While we're here, please make sure you also read the following documents
to help understand our guidelines:

- Documentation/SubmittingPatches
- Documentation/CodingGuidelines

[1]: https://gitgitgadget.github.io/#how-can-you-use-gitgitgadget

>
> Any feedback is appreciated.
>
> Thanks,
> Sampriyo Guin
> (He/Him)
>
> PS: You can call me Sam too!

--000000000000aa7c4a06309a7bd6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 174dc83b36a2bee6_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1mWk8vc1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNkE3Qy85UEE3UmUxWWVnNms2akxLWDJDTUs5RzZKSwpiNHZpOERYejBi
RmhkVjRYL2NPWWpjZHRKZ3pSZkI0TlA4MnNsdjF0d2FBellVVWt4L21XYU8vcXJlVjVzemI5Clp0
Q3lPL0tRbkQySHR3TnplTUsyZDd2MHAzZVVlb2F1MkQvT3pGN0VyV2Q3QmtXa2FBREFGamlZQk9R
WXBqd2IKWVAzU2Vudml2TjdLUVJldXJOT1U5dmJIYnpTUXI1S2lJV29nVzdqaVZGYThyMnVRMTE5
bW1lcXA4UlNDWjBkOQo0d3N5RllKOTF1d0RZa09DVE5OT3RYaFRxMnVVQWJCTFZzY0l1ZWQzeGZX
RmJpVUV5RHBtMkZEL29CRTgxRllBCkpZd1B6T1I1Mzl5ZkhVV01XbE9zaDdseFZyMU5DVkxKSmNU
UHBzMlZPUVlQdFgxdXJ4OXhMNXlpQ3pVdXdlMG0KVlNaUG91VWNwWFZIYWhiZjVLcm95TzFJNVlr
RW9xWEVuZHUrWEF0c1Buak5QcENIbjMwdGZ5VngyaGNKdDZTRgpWZkI2K3VCVmkyaHZ1ZE1wZmV6
SEtrYWx4YmxzV1VpenlXRVM3Q3k0NzRNeXlxL2FSS3M2NkEzeWFUeDVkRDZICjExRlkycE9CK1Za
NkcvYlFKQVZQM252c0srTnJhUUJYTDdDMzJRYz0KPTEwTjkKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000aa7c4a06309a7bd6--

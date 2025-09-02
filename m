Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75E52E8B88
	for <git@vger.kernel.org>; Tue,  2 Sep 2025 08:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756802085; cv=none; b=KOeKJ2C25XJ5g9auOLdBFCXytNhZzOQ8BVUxmE/Sebl6eOYn8iWJFL/BPD91bGH1/YHvDlWtWsrIc3t1JYAxRR1bZoSlvDY3toAEX7A3YBYe3FO7FgPDBJybpZdkwYKhNHCuyUNE2LqGauNWU1jY4fZS9ceQzQgeKBr6fiyG9HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756802085; c=relaxed/simple;
	bh=AR7C+cyu8e1AeinypqdChFDUKICCstZuTyc5rm/5quo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=cXIzcI03UgEY8fhQZL2vDra0l1l68erT5KuS3MKmLf3m0k/HgT9cOeqqMFAX2kL4ka+o/D6DzAZBv2sg0ddABcvSEQUzIzhEjnKPXLqPdcLA6AzQmNefdqH9BirwTtZ7/DaxvhViSM8VV33awUHfMunHymAYgrT4tfRsjL8bfK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FUfOArDK; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FUfOArDK"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b0428b537e5so297073766b.3
        for <git@vger.kernel.org>; Tue, 02 Sep 2025 01:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756802082; x=1757406882; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=P7YELUABY4LnEGo6VzUrofVBhRs4Ne6CkXB5d/hgEMc=;
        b=FUfOArDKunXP/ytPVvHKlUEYQ142ArHU2uI6/jN0b9ld//R27LkkDQYJPKpR9R5V61
         khcBOfB+ObKGlPVuDTbaaoPWyA8ozIcOGHQK6EFp2XhdQdoBKH9T9kH58l8VDB3PqKuL
         n9Zd6SZM0TYObssjkJ837HyU/RVogjA4MLPNJFmqn11tX3KwOVJQudiggRjQ/uQ9/x49
         i1Vm7SUFnzglCNbrWh/kmndf66SiI1laOBVcgfe7unjJEnPm/tR/AHw2oWtm2GkPe3rd
         qP5rkibaoZ9HxBzpCYN2UgYTCn1KWoBvG6s11CH0J5VxBjFJipomX04pJPugfs1Uhn2C
         VCMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756802082; x=1757406882;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P7YELUABY4LnEGo6VzUrofVBhRs4Ne6CkXB5d/hgEMc=;
        b=aD771mhT8VsFK0FBRnGQ87QNx+DNVQQk1AJII/z83tX0uoYS5UM2lKnIlBa4dzir7a
         PDpir05basrEt3OI7brLogQfzuKIfZ9Q2w9H3rryNyNSr8Scm+idFIYpn/xqfOHGZNYc
         BJeMPzEy83hqocd8btIDLduK8BFYsMCc9a1/HmftLHMxNyieHr7QNGsMkt2ypuynGkSv
         qexS/gbdqLcLyoL5fRFP+iivI/yeXTE25frj76co/1zga+eT77PLn1Wciwf+qFLfKN/h
         K0Kg30xQCe05kf7wkgMrXULAd9956XCUz83zFF1o4z/iS+UaDmmFru+6qKHZT3uf9F6d
         RCIA==
X-Gm-Message-State: AOJu0YzFyp5P7puHxP4CfoJDvk96VthDa/E1+9Tx0bhgG6xS8RSQBcOl
	TlL6pzslOnKjPHJENbxTLth9DkxlLPy/jjscce+8eHXHtsMRVvDRDOde
X-Gm-Gg: ASbGncu+N3WffYzOGXp3E4z8qV7EO1nCE5s7SIdFwSiFHbDchSx0ksZOy6Fn9Uu+CNS
	76JsaeN7YPLbIllKECqT/TD2sNEozH5SFbY+Joh04Tj/p0gHrhdGfEA1S3BcNBi2EbhBf+gZO12
	UBQbH2BD4RiA8OjkbPg7SiOo1KJpsjLdItrXvPVw7F3WA5LBHcjUJR7CquXCOnUFthTZHXTuJQx
	Xi2TZTs50bShSKou4tQ63SngUC3WGqeawlxnbHMqJv+H/Luy/DAyIkUwxb3brwsQBv8uXMbJehI
	DfwC+gSEZSU+sex5EwCNQ/sdKwH0L3JAQL2DeJmZe3yx3g7RuQUiAEYwNP2NuuBNwq1/G/XOaoL
	MaYD8x42I95U2XJdPatT09UW5tTPA
X-Google-Smtp-Source: AGHT+IFZkoJDtep5HWr1gIRVoLrXq2n5wztoXwFLuN8LWr0w6NV44fNNJ5rLkTEEwkGPhlSudMj9Dw==
X-Received: by 2002:a17:906:c289:b0:b03:2d91:55b0 with SMTP id a640c23a62f3a-b032d91ab41mr864620966b.60.1756802081806;
        Tue, 02 Sep 2025 01:34:41 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2455:8268:bc00:d13e:1f84:4afd:ec5e])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b041800e89esm594785366b.30.2025.09.02.01.34.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 01:34:41 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH 0/2] refs/files: fix issues with git-fetch on
 case-insensitive FS
Date: Tue, 02 Sep 2025 10:34:24 +0200
Message-Id: <20250902-587-git-fetch-1-fails-fetches-on-case-insensitive-repositories-v1-0-35e69bbb507d@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABCstmgC/yWOQQrDIBBFrxJm3QGVBqVXKV2I/SYDRYMjoRBy9
 9p299/i895BiiZQuk0HNeyiUssAe5korbEsYHkOJmfcbIJzPAfPi3TO6GllyznKS/8E5Vo4RR2
 noigqXXZww1bHrF8Pm2iDTz6mqwUNydaQ5f0LuD/O8wPg6aobkAAAAA==
X-Change-ID: 20250822-587-git-fetch-1-fails-fetches-on-case-insensitive-repositories-0a187c7ac41e
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, joe.drew@indexexchange.com, 
 peff@peff.net, ps@pks.im, gitster@pobox.com
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2359; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=AR7C+cyu8e1AeinypqdChFDUKICCstZuTyc5rm/5quo=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGi2rCDgywdBsyzRQQYko+cWEryB9VfmtFFFQ
 hlQ+Af9VvlG/IkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJotqwgAAoJED7VnySO
 Rox/s7kL/1yERhiVgrAmRn6dBodmqtuF3OwHZdtPttvWlkdGe/nEHKwhozZ0yaSDR5+Y8BLNSUz
 HakRQ8EAKao9G2Pt74S9VsmPvsHtWbVSkru0JduamZA9EzvOf4sYElY3Fp9l5o+dn5+KaL+5+uh
 Q+6h8N6WnKLeVvziWgHNMOiu/Yv4nROsabwGfyV7b2DLx00PA6t7xUDCMk0tL00vea2KmSwC0UU
 lr4TRmT83QGV7vmx6zLVT9eyWEoVSyiBy07ZVWG95LRrMNeCewSima/MzVSMA/tddWqYke500Cm
 NstZ21vL009RdqOsWw31RLvPaDfMeup/PFSgOsKURdNj3H9pUNy4Zqvnr+2rOx5zn4UeH1QV1bp
 b7SL4ns15m2ZZzZjQ/1chGUHVRe0Mi3BTv63YLT8iH4D6IRZbFDmxvmUkBXQUMNVGePNAPXL2Cu
 TgbHqPilbUR34NNkxlKlca4L53QfFMGKIJn4cyJK0+S3sqvU1V5dCvqj5A0KzQPdBtoK734AOf7
 nk=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

Hello!

With Git 2.51 we moved 'git-fetch(1)' and 'git-receive-pack(1)' to use
batched updates while doing reference updates. This provided a nice perf
boost since both commands will now use a single transaction for
reference updates. This removes the overhead of using individual
transaction per reference update and also avoids unnecessary
auto-compaction between reference updates in the reftable backend.

However, in the files-backend it does introduce two bugs when used on a
case-insensitive filesystem [1]:

1. When fetching references such as:

   - refs/heads/foo
   - refs/heads/Foo

Earlier we would simply overwrite the first reference with the second
and continue. Since Git 2.51 we simply abort stating a conflict.

This is resolved in the first commit by marking such conflicts as
REF_TRANSACTION_ERROR_CREATE_EXISTS. This allows batched updates to
reject the particular update, while applying the rest.

2. When fetching references such as:

  - refs/heads/foo
  - refs/heads/Foo/bar

Earlier we would apply the first, while the second would fail due to
conflict. Since Git 2.51, the lock files for both would be created, but
the 'commit' phase would abruptly end leaving the lock files.

The second commit fixes this by ensuring that on case-insensitive
filesystems we lowercase the refnames for availability check to ensure
F/D are caught and reported to the user.

Sorry for the long wait on this, with the OSSE and Git mini summit last
week, I didn't get as much computer time as I needed to test this.

- Karthik

[1]: https://lore.kernel.org/all/YQXPR01MB3046197EF39296549EE6DD669A33A@YQXPR01MB3046.CANPRD01.PROD.OUTLOOK.COM/

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/fetch.c       | 21 ++++++++++++++++++---
 refs/files-backend.c  | 21 +++++++++++++++++++--
 t/t1400-update-ref.sh | 24 ++++++++++++++++++++++++
 t/t5510-fetch.sh      | 42 +++++++++++++++++++++++++++++++++++++++++-
 4 files changed, 102 insertions(+), 6 deletions(-)

Karthik Nayak (2):
      refs/files: use correct error type when locking fails
      refs/files: handle F/D conflicts in case-insensitive FS



base-commit: c44beea485f0f2feaf460e2ac87fdd5608d63cf0
change-id: 20250822-587-git-fetch-1-fails-fetches-on-case-insensitive-repositories-0a187c7ac41e

Thanks
- Karthik


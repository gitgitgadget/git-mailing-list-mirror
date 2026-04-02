Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55053356A0D
	for <git@vger.kernel.org>; Thu,  2 Apr 2026 21:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775164648; cv=none; b=P66S+eJ1ULnBbaKdWNK07R+ULfG35gjkMZzRKknteZU501WpVXMeBd7sE+SOTYGAQho43CVAFQUYN9dHVYPRvSY572EraDD6Hp1/fmDNDap+b2VS8yVzvOBfoED+f8JQ6605DIreQtmtshHINxQ/wiPWhvT50RDpGlPdEn//Eok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775164648; c=relaxed/simple;
	bh=z5oalB6VnWq3AJ3vMm/GO6kyMGJjeFmMQz4jl32r9P8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TmE58A5BoN/yxvxMjchCUV5i3qhmAdfJwil7kjUg8pdmsh7ugsDN2gg7nFDXU30KaS/R6LJioG3QRcUNyyQfjGgwhjlUdXt1pdqtDu0EAtnCq5elNeNuu720j95JMF0YLlCpVvdNqnBsXKgflZLGQKnEZyvDNdTzTK+qmx6BxlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WucS3XIx; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WucS3XIx"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-486fb14227cso17656535e9.3
        for <git@vger.kernel.org>; Thu, 02 Apr 2026 14:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775164641; x=1775769441; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yxfh9S6eRO4R5i4mSm/r9mk6QhIuU5Xm6IoyAXq8q2A=;
        b=WucS3XIx/LVM3A2SoEDIKZd5TFZORHdiPk6CvbsC8BCxJYrmmzgrZopmXRWwHYJZnQ
         Wwjh4TCa9mRhtaVvC+pMSV50eXT63BbUCgMjwQOVJB/vz5SFoyCwypV/wsFLMfp1wLkm
         wuCKFD9HPjcLGoVhpEID1A1hQumPxwwukR+xvnZAeRfUgP62S8+oPD5a1AB0Y5FujbA3
         SZauHwn2tg3UnztxVchrwJ4leB68fuPQcSc3Kc/TnIRV/5Wq6+WY1+oaHazjZhloLZHa
         3qmIAquEmcU5YVkwCgc6VKP11ZkEQFDyzso4L6BUsUMIqsEzMV81cSFZagZ4SR7gSGr5
         QFAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775164641; x=1775769441;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yxfh9S6eRO4R5i4mSm/r9mk6QhIuU5Xm6IoyAXq8q2A=;
        b=LSSYP3Cs6GVuBfw6tZj/zvjMvaiLZQBJ2hcZUnWnN8U0aEozKW5HeKc5iPAxLkfJVj
         olzXOmBAy5+ptg2RXOAhc1Ei5+xi8vxHP6XTycxmlD6Gzt3KyVE94PASVbhLfqJ3dY9b
         QETQevYL0siT3F35qzJHwXksmXTMFHgBMeqAkJjtkeIeABVaIgNX6DZXJtfKeUhoQ/ql
         Tkwh6OtdJXUiJPIoN/v4gt/7OLNUPPjK1Z87YBDLgYHT+y7yggt5Vq/Ox/HCG3J+2jVl
         mOn3ZGwEB0k0QDfAbWB7EL89MtixlL4tqkMDTiyGxlt+HI1WuKy3/tm7ppWw4xumhZoD
         MQQw==
X-Gm-Message-State: AOJu0Yz34OkR5T7TIh/juhYKWIfcQbfuGbo0q+KybVNwfC8pcJcxwO/B
	WUASBTCRzMA210vVt6ElXICsljJ5H/bNFqbzYAjGq0bRdkFy+vL7gLmcK5maMfkG8z8=
X-Gm-Gg: ATEYQzwXgdP9F56SBFbG+a9vvsOMmM9Rz6GQrbTBq39no3o66/6o3SqEmCsX9p8i++/
	Upf2H4iB9cR5wPxk6Tl7fq4zof5qm9SoKQSsCWxdtdT/nNPzHCdpqN75s9N4Z3qYc+HYDkFW6Ox
	f8S5lmIf6M+fZGyqsQpuripMlZxNBvNM+0AvmjfZFuF7uc7tIMFZmvZYFarHUT/OMhkM/kaR9qb
	xf9DHVDXYgfd/zrr5FfvWEsCKOVJl4K9Gn2iGbmlwZkl1TZTyy41CzWpy7yfZ0ElxnxiMZpO9Jz
	LOIy7t4NiaeOApwRUlsTph6OTx3Vut/wgof9GXGl6nmPO59jqAHjBDgddyOCDVYouvTEAOPf/b6
	Q8NBbkccHMjljdo97n2yCqw/GbVv7Auz/Yix/UiKl56SN3f5qF4cGKtMU+KaUUso8rxMDRtU0qt
	Woelt7LbG3VIwrefYcSnPlXQAlFJgxbpDWgpvB8RCghCpk1IA546oj2usPyOV8enam922GhD1Vi
	L6eSn1Qn7KeVcsxx9KLhWiUYE148ptWRlspi/BS/Hzh02GuVJv53vOBpw==
X-Received: by 2002:a05:600c:3b19:b0:486:fab9:a578 with SMTP id 5b1f17b1804b1-4889976af3bmr8258295e9.11.1775164641235;
        Thu, 02 Apr 2026 14:17:21 -0700 (PDT)
Received: from farblopa.localdomain ([84.126.0.39])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48899d1b12bsm3893915e9.5.2026.04.02.14.17.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 14:17:20 -0700 (PDT)
From: Pablo Sabater <pabloosabaterr@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	christian.couder@gmail.com,
	karthik.188@gmail.com,
	jltobler@gmail.com,
	ayu.chandekar@gmail.com,
	siddharthasthana31@gmail.com,
	chandrapratap3519@gmail.com,
	Pablo Sabater <pabloosabaterr@gmail.com>
Subject: [GSoC RFC PATCH 0/1] graph: add indentation for commits preceded by a root
Date: Thu,  2 Apr 2026 23:17:16 +0200
Message-ID: <20260402211717.3604688-1-pabloosabaterr@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When having a history with multiple root commits and drawing the history
near the roots, the graphing engine renders the commit one below the other,
seeming that they are related, which makes the graph confusing.

This issue was reported by Junio at:
  https://lore.kernel.org/git/xmqqikaawrpx.fsf@gitster.g/

e.g.:

  * root-B
  * child-A2
  * child-A1
  * root-A

This happens because the engine prints left to right from the first free
column and the root has no parents thus for the next row, its column
becomes free and the engine fills that gap with the next commit (child-A2)
seeming that root-B and child-A2 are related when they are not.

The actual implementation is very minimal.
This patch makes the roots to be kept alive at least one more row to avoid
that and indent the next commit to the next column and then clean the mapping
letting the indented commit to naturally collapse to the column where the
root was.

e.g.:

  * root-B
    * child-A2
   /
  * child-A1
  * root-A

This is done by adding a is_placeholder flag to the columns, the root commit
is actually there but marked as a placeholder

e.g.:

   * root-B
  (B) * child-A2
    /
   * child-A1
   * root-A

(B) would be root-B column with the placeholder flag active.

Then teaching the rendering function to print a padding ' ' when meeting a 
placeholder column outputs the second example.

There could also be the case where there are multiple roots

without the patch:

  * A root
  * B root
  * C root
  * D1 child
  * D root

with the patch, the indentation cascades:

  * A root
    * B root
      * C root
        * D1 child
     _ /
    /
   /
  * D root

the _ / might look weird but that's how the collapsing rendering does it
for big gaps, this case being from the 4th column to the 0th column.
Another patch could change the collapsing rendering for placeholders ?
I haven't done it to keep it minimal, but a follow up could make it 
to be straight '/'. This would make it bigger but easier for the eye to follow.
IMO is not worth it, but opinions are welcome.

The patch also adds tests for different cases like a root preceding multiple
parents merges and the examples above.

There could be some edge cases still so any testing is very welcome.

Pablo Sabater (1):
  graph: add indentation for commits preceded by a root

 graph.c                      |  68 ++++++++++++++++--
 t/t4215-log-skewed-merges.sh | 136 +++++++++++++++++++++++++++++++++++
 2 files changed, 198 insertions(+), 6 deletions(-)


base-commit: 256554692df0685b45e60778b08802b720880c50
-- 
2.43.0


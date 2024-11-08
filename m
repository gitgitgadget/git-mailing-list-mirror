Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D580C8CE
	for <git@vger.kernel.org>; Fri,  8 Nov 2024 13:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731071809; cv=none; b=g18glekeQMUOugNqh2JGA/m/78RR0SoySxFk4Afq8QTzKVt9OkVFHK358EA5miE9O2kQ5iwrA7Mfs3+qIM4V7RboOVlgRnE0pznCMel0vVHK/PuySuBzUqFFPOCfYXF1ZzUT/CFAyNaWQBffyRPRtcPkv4yWE1ua0AlkkfzYuqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731071809; c=relaxed/simple;
	bh=8MN/6Z+gl/oF9Tqq2Xc9cRUaWXk16poUXkVWbUDEQ/E=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=X2+QE/g47FrVOObPAyyhZ/VMDV1V/HdxC/Jl4WMzd+0vgV4G29A9IamyKEYzsKIP3maAObD4r1AuzDS3UssjB0RDIVAxJGzYIr++jaHfzfRBvdrSDsCpdFInYx0cVnyAAKL5aZq9pEDvapgQIwdGaPE1nQIslEKAnYTJpC/FBiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=m4GAIEs/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QMNx2okj; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="m4GAIEs/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QMNx2okj"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 85B4C114018B;
	Fri,  8 Nov 2024 08:16:46 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Fri, 08 Nov 2024 08:16:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm3; t=1731071806; x=1731158206; bh=FBG8X8AKcG
	2TV4Q6Abl45DK0hwwIbSEDkDqTJ6GuCnI=; b=m4GAIEs/cs8evEDJix1UHzPzAO
	RrLSN2c7KiVPeEqsDhZ8b6ftZ9k/lP8+L+8bT2UA/KyKTkmU9Qm83vxh03bOoYo7
	IoivOADBQK1m6sHl9XRFICDmPHzuhfdHmaJad64+/zSpBGeUnDf20LasmTHOHMJi
	s2jt/+sGUDfbdgX813IO+Vd/bGXR9iGx6Gq8Y0bG+qQwUGXwr8vaHNZoTMIysMHN
	csod2yuLjWv3X6Epw3vzdkywQtnSyms+HTN57Hvu+poaatXM2w2ckKQ75SXT8YTn
	Y3I1OW33I9C7BGOpwRjpEIHRI5J2f2qxdg+hsUdpdNp9ADCCvIFrZMd8x4Cw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1731071806; x=1731158206; bh=FBG8X8AKcG2TV4Q6Abl45DK0hwwI
	bSEDkDqTJ6GuCnI=; b=QMNx2okjOIqFQvNckd3burFYmcPTaWTDCiU+H3Q2mo2n
	OUyozzin1TmkN7mz4lns/jq/mgwuuD+VGN++XOqd9ZSY+9Eo+wXhQoRCJ+yd6tNR
	vVmovEcHXG/e4iN5kGBr0HPeISQejVXV5gEwC+31wfxkquba9Hh9/m2aNh7cV7/+
	Zr+51gUMBA4/adUxp6EgEe0zw7iZn6zdISdqtKKlYWNmOb9OUnK9vye0tGJ1LkaE
	FPJyc3+RIeemtlouBAJUMZo7pBoailLjlKbagJYs7g2csqTaoWdZPcCfFD1C/CH4
	Ye39/9SIsYZZzFM3JowCd0hFlF5W5KKIKUl+y4l7mA==
X-ME-Sender: <xms:Pg8uZ1XsTzVPTdq3Y0Ckw3tqpufPvW3pLI2LdFEkz1TTECaEd33CbQ>
    <xme:Pg8uZ1karl1h5YHua4z7hRMFXcqeaxym6PGD5eyLjptcn_1uTasottEKiOfFbpZW3
    1Cdac8auZkujyzdcw>
X-ME-Received: <xmr:Pg8uZxaGOb78wZYen6g9eUeCCcOGDpAyraLFAwmQW2iX2NToAOvc8mNd31QI2mImiWj6Ahd9H04ewL6iMWSdXOORrpT0xBWikZyHRYi6ZuWH2lI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrtdeigdegjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhufffkfggtgfgvfevofesthejredtredtjeenucfh
    rhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqne
    cuggftrfgrthhtvghrnhepveeugeektdetieegjeeuheeuudfgveelfeevheeuhefgteff
    ffevhfeuhfeukeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhht
    phhouhhtpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgi
    druggvpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:Pg8uZ4VHIaJ7Hxk8uhwJUR9y-f-uuAn97NUHUq2_oG5ttgEZzzfDpw>
    <xmx:Pg8uZ_m1TG8PA418biXBcMb9tRGHyAeGcQutcWASZ0gEW672IaVMBA>
    <xmx:Pg8uZ1fNmX92BfptSyVdoQ06_m3CaOFttS2Z2mSJM1-5ichHOyY1DQ>
    <xmx:Pg8uZ5EpyrN2FJbwjDT5c8G7TzSp0phqeXjRn7Orz5cvhPGwYNtp2g>
    <xmx:Pg8uZ9jml5WsEJEM8vr75NpWmixS3qOeoBeekXrepY5OvPQ-YMmABwMZ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 8 Nov 2024 08:16:45 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 786a3a0e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 8 Nov 2024 13:16:14 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 0/3] Build improvements for clar
Date: Fri, 08 Nov 2024 14:16:22 +0100
Message-Id: <20241108-pks-clar-build-improvements-v1-0-25c1fe65ce37@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACYPLmcC/x3MwQqDMAwA0F+RnA3YOqbdr8gOtUYN01qSKYL47
 ys7vsu7QEmYFF7FBUIHK28xw5QFhNnHiZCHbLCVfRhTtZg+imHxgv3Oy4C8JtkOWil+FU2o3dN
 65xs3Qh6S0Mjnf+/e9/0DFsQCAm0AAAA=
X-Change-ID: 20241108-pks-clar-build-improvements-1c3962a9a79f
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
 Phillip Wood <phillip.wood123@gmail.com>
X-Mailer: b4 0.14.2

Hi,

Dscho has reported in [1] that the CMake build instructions for clar do
not work well on Windows/MSVC because we execute the shell scripts
directly instead of using the discovered `SH_EXE`. This small patch
series fixes the issue.

[1]: <3b2cb360-297a-915c-ae27-c45f38fa49b9@gmx.de>

Thanks!

Patrick

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
Patrick Steinhardt (3):
      t/unit-tests: convert "clar-generate.awk" into a shell script
      cmake: use SH_EXE to execute clar scripts
      Makefile: let clar header targets depend on their scripts

 Makefile                             |  6 ++--
 contrib/buildsystems/CMakeLists.txt  |  6 ++--
 t/unit-tests/clar-generate.awk       | 50 ----------------------------
 t/unit-tests/generate-clar-suites.sh | 63 ++++++++++++++++++++++++++++++++++++
 4 files changed, 69 insertions(+), 56 deletions(-)
---
base-commit: facbe4f633e4ad31e641f64617bc88074c659959
change-id: 20241108-pks-clar-build-improvements-1c3962a9a79f

Best regards,
-- 
Patrick Steinhardt <ps@pks.im>


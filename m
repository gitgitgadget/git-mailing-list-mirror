Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE64284B33
	for <git@vger.kernel.org>; Wed,  1 Oct 2025 15:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759334278; cv=none; b=Shyyjf6jsHo7FrZoNfYXIghVIkrNGHV6ijZcrlRbaHiBN9R3afvQteUIykGuHyaMkYGPIbFa8/0ZF8KkOEiSymLNBy6BjnTXJaHdx5paZUQF/Ktw3OI93WF3XbIt0ggABStgcHc5AhSzfJ0fIpYr8CJFKMozCoTeVtK/jNdcAjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759334278; c=relaxed/simple;
	bh=y0cNqkqV3ApI0X/bp71xjo+UXFrqJTTf+mWeJ/3d5oU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mGGMTH47nrhQ3thRuxL+aPhoHuLDS1nKjvRK9jZ/dZsk3SHkchcMqKmxdL4cLCdlIOLNIuN4Aywy8br+LRMLcbN1yEX/D/e+UqAWRovN4QnOO4eSWTuWSw6LgSeWDlg20ehUcahHbbmoCOhyMoW9JKxiyBgvkLjMmcYOQ6AqVmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=VBFcwg0k; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=amMsFi7y; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="VBFcwg0k";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="amMsFi7y"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id E2C321D0030C;
	Wed,  1 Oct 2025 11:57:55 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Wed, 01 Oct 2025 11:57:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1759334275;
	 x=1759420675; bh=pYPKPxzEdZaUkPdFKpTharICfBen/48yzCNuNRvv8Sk=; b=
	VBFcwg0km3mBw5+jeU3hNUxRKeGqw0sRVuHMcO/HOLvc4+LPX7V7s68SNkPwiDEB
	E1JlZsC+OC1ePdxUgCghyTzCjbnkaCJQSbQJw4E8EtXJs81rjPtSLFG/hOM0KyDu
	9CfdWlkJr6SnvwmFH/aR57FqLBFKoe4vbQ/Y+y+rIhXngU9kVlYW+lY7h6E501Ky
	0BaqFXFwbHt7s+ypq8EdynL3LopDq7fTPLYbRTb/nH/5L5qu+Mf8Ql/JCr3Agy3f
	E9bxdgfSfuwv33GP4L9A4NBK0AEmS0D6n6kwJcmjOWW4jV5wd7EHIjRuDYqdP1/m
	D161zqWziPIYZ9mT8kgqlA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759334275; x=
	1759420675; bh=pYPKPxzEdZaUkPdFKpTharICfBen/48yzCNuNRvv8Sk=; b=a
	mMsFi7yf+Xs90vMg9Uxv1ChLjVAToMBXTuy76vWNvbBjzbPuZusNVoXnhseIA9Zq
	cj1RQaOKVUV/6lMlHS0GJ3UpSfIgD6DQ83wXIXhZz9KNXShiMA50v/JU28JkcwxO
	t8NnnIR47F8fOydhu0RDwMUV8RbYIM9bFAZ3D/zsHWvFt4MaVejJcjWxWB1vNxJu
	tL1NCLJcp2RvK9foLp+A1oHgWj3naIbdRZXanGG2i4GahpXSa7aWt+8I0gVR0naC
	2TP+OetgtlXS+VNRW83QDaMIa9h7iQs1D8H1JxUpO1/RIRVtKqngPglpXS2ZLDSl
	uLoAWv4NOD9OxR7cEQzBA==
X-ME-Sender: <xms:g0_daI0BiKzmBCjJx844ZXfotuDmP4dyyU-aM1Vn-h507euJxkhbxg>
    <xme:g0_daCJSsum_0UX8Y7Ow2rxkxbMR3sw09LsD5ciw9pmmwmJoR3EgYUjoOlca3mgLy
    qowuJ1fQavHiuyb4O-vmWEwUHou8p5_FZ5uAJkIwdrVVa0Epftm>
X-ME-Received: <xmr:g0_daHFCnH29fG5BuA05eJD8Qmf7JRJE2kwjIGqpWt21xqXvLWpd1as289BbMCgRHAUEnNpA-ML4HCDMMLzD7UqcegxeRprYArTaZPkS6Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekfeehhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpd
    hrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    shhorhhgrghnohhvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhnrdgrvhhilhgrse
    hfrhgvvgdrfhhrpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepmhgrrhhtihhnvhhonhiisehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhith
    hsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhn
    vghlrdhorhhg
X-ME-Proxy: <xmx:g0_daOXtTpJdNolHhoSruJYd3iwNNplh_7qflSrpwdNP5Csb5aoSlw>
    <xmx:g0_daPyWsUKH4prleQ9J8FyG7yQXiIwMVx3GYhqtqvqRJD0fvLNnHA>
    <xmx:g0_daDSvS4ytIgayUM86WT6GKM58HkZmYd9LERCm_mEiyjPUA1eOTQ>
    <xmx:g0_daLihVdpWSW-p4GNzUs_8yjnvzjkY_LmkTsQ5guCI69v3hHofJw>
    <xmx:g0_daCx0_T2tOPO4Y83K0trX-QyFNQWE_EI7_7XkvpfclylT7xND9Npr>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Oct 2025 11:57:54 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f653856b (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 1 Oct 2025 15:57:53 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 01 Oct 2025 17:57:29 +0200
Subject: [PATCH v4 03/12] replay: stop using `the_repository`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251001-b4-pks-history-builtin-v4-3-8e61ddb86317@pks.im>
References: <20251001-b4-pks-history-builtin-v4-0-8e61ddb86317@pks.im>
In-Reply-To: <20251001-b4-pks-history-builtin-v4-0-8e61ddb86317@pks.im>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Sergey Organov <sorganov@gmail.com>, 
 =?utf-8?q?Jean-No=C3=ABl_AVILA?= <jn.avila@free.fr>, 
 Martin von Zweigbergk <martinvonz@gmail.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Elijah Newren <newren@gmail.com>
X-Mailer: b4 0.14.2

In `create_commit()` we're using `the_repository` even though we already
have a repository passed to use as an argument. Fix this.

Note that we still cannot get rid of `USE_THE_REPOSITORY_VARIABLE`. This
is because we use `DEFAULT_ABBREV and `get_commit_output_encoding()`,
both of which are stored as global variables that can be modified via
the Git configuration.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 replay.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/replay.c b/replay.c
index e22ce39940..13d75d8054 100644
--- a/replay.c
+++ b/replay.c
@@ -62,7 +62,7 @@ static struct commit *create_commit(struct repository *repo,
 	obj = parse_object(repo, &ret);
 
 out:
-	repo_unuse_commit_buffer(the_repository, based_on, message);
+	repo_unuse_commit_buffer(repo, based_on, message);
 	free_commit_extra_headers(extra);
 	free_commit_list(parents);
 	strbuf_release(&msg);

-- 
2.51.0.700.g236ee7b076.dirty


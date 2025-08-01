Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FBFD13E02A
	for <git@vger.kernel.org>; Fri,  1 Aug 2025 14:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754059686; cv=none; b=QeG4EhuvoKJyyzDPZT5RwsIevJvCvLaEq4Z94RJaLU7GfHL9ydWs8RELkKQBK17vcnL5itfUlkR7MvA5aag5x6rf/BDfA6r15WdpuRfR74xCRgUAqkG2WSvus73CThib1sfm6zqqX2ZMJ0mrKDW+9G2VSOmmH3ndLBbwh/2vH1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754059686; c=relaxed/simple;
	bh=4EJiv4WW38rlvMXSO4TD4QNxIf+9X0s4Cuqm0z7v8D8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hfDXsDJIoKRAS+dV2Cx+agQn2QMGnVvIAZSXAaGrZPQQqQgUkyMmqIUl1S25T8V78Tn8osrOG6rFBYbf5BsPPDDPSZ5j+ffqbkI9H32A2TvB7cdX7dnJYWpArDBcfl6cKUQrhbFhSX1to6NVo6UyApudJ6ypR3GA9QUs5MZJvkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=i1Wnqm1w; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lj6se1fe; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="i1Wnqm1w";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lj6se1fe"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5AA287A07C2
	for <git@vger.kernel.org>; Fri,  1 Aug 2025 10:48:04 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Fri, 01 Aug 2025 10:48:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1754059684;
	 x=1754146084; bh=1wEQ/PTY4t+ygfiy0LchWWXqgoWUtLbAMWAITA8zxFM=; b=
	i1Wnqm1wEM/KTKaMXCm2JGZKgBo6UvJAGb5qywINZi2SRDoutjftLnG5tmclga15
	1HSWeVZv7U/tfNbGa9Xna+7pIphweK58MbqI/wbqvCHOH/2L2AlCxgFNAN0/GWzc
	nJS972tqkpvrDv32ZyH0VwmAdNQhK/PS0TH3g8TELZ3mwurnMRtP6jhj6mynARhR
	wfnGhyqRtgVinVw2i4njklUfLohMIYvzQ4mo2haFOondzeXdqQSxRv4WUwDtQ+bn
	4zvspqikFbLboxBKvVqYmoxFrC16clvg/OQ+uWZQv2dou8mBEfEKbmCastrOaew7
	sWqi4j6QmL707ip/L/HZxA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1754059684; x=
	1754146084; bh=1wEQ/PTY4t+ygfiy0LchWWXqgoWUtLbAMWAITA8zxFM=; b=l
	j6se1feEN0+RZlHi5RRGsSOz8yF6XR8mG8HZG0bvD2kG8+Kyv144CwauW1xPLVtV
	DC2H3e0BdPauXSOi38JdCiCW4axn8ggoqZEczsB7OBePzeAikZFgvmZ0wtQdHQzD
	PGSJ9FLcBWndhHAwctBRZo9Le6xC07S5n9202oqfLcRdnVGrH8mJbi5quzcE8XQp
	Xe/jqcbqZ6mzw5O1xl49qGeujs5JYKsQxm/kF3KMhfQJ8TBSY0/yKQPEQN1YyQJb
	/IKnQWGKaywkxjka0viV3Io1BgObvxI2pm3ODqUfoJJvKAK5+3el/A4xozzBRvNR
	I6c51PhiKFuU2SNHYPb7Q==
X-ME-Sender: <xms:pNOMaN2CpaDGly-aAHKkYTNsrf6o7aJg_pxFCC1PE5RLeDJBENdUGw>
    <xme:pNOMaGGx6d-3yKFzuoqjHC_HiVrR9-Z0Quy3H6MEnlV-bYl33VhPER-QpgF4g1khV
    uVS9wwREveKoki4aA>
X-ME-Received: <xmr:pNOMaHQtv1fdtTU53Y_0i-ryDPAgnkmVhqHoL1_t50Y6N7vCptu7wAESjOJf-GVfhfRHt2poT1cOR6EPQznovj232JSQ-kjcxqZZ_bf0nAVM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddutdefleejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:pNOMaNCHUT_l3-jX4W4ukJkYIET4tpDYIsfX_RYBBPhE8xks-Qd-MA>
    <xmx:pNOMaH2gJot892T_GGt4ylHGInJNJYxVSXml13XehUZbyRZtTPPlFQ>
    <xmx:pNOMaLWs3VsaIJynALaTxCYHstCnDVaYbW-Fgok6gd903DhC-pFqyw>
    <xmx:pNOMaJnG_EsrmXImOPcX_cfGGuSlaqPhjwScN2QmILnELcVcYbnj6w>
    <xmx:pNOMaL9ALhN7Cq4iXVucwiARsIGyY0dkglwakCqibWstMIz2EJvVXjch>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 1 Aug 2025 10:48:03 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 869fa88e (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Fri, 1 Aug 2025 14:48:02 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 01 Aug 2025 16:47:49 +0200
Subject: [PATCH 3/5] reftable/stack: fix compiler warning due to missing
 braces
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250801-pks-reftable-fixes-for-libgit2-v1-3-f446e1c33cb9@pks.im>
References: <20250801-pks-reftable-fixes-for-libgit2-v1-0-f446e1c33cb9@pks.im>
In-Reply-To: <20250801-pks-reftable-fixes-for-libgit2-v1-0-f446e1c33cb9@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

While perfectly legal, older compiler toolchains complain when
zero-initializing structs that contain nested structs with `{0}`:

    /home/libgit2/source/deps/reftable/stack.c:862:35: error: suggest braces around initialization of subobject [-Werror,-Wmissing-braces]
            struct reftable_addition empty = REFTABLE_ADDITION_INIT;
                                             ^~~~~~~~~~~~~~~~~~~~~~
    /home/libgit2/source/deps/reftable/stack.c:707:33: note: expanded from macro 'REFTABLE_ADDITION_INIT'
    #define REFTABLE_ADDITION_INIT {0}
                                    ^

Silence this warning by using `{{0}}` instead.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/stack.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/reftable/stack.c b/reftable/stack.c
index 4caf96aa1d..3480ad21c3 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -704,7 +704,7 @@ struct reftable_addition {
 	uint64_t next_update_index;
 };
 
-#define REFTABLE_ADDITION_INIT {0}
+#define REFTABLE_ADDITION_INIT {{0}}
 
 static int reftable_stack_init_addition(struct reftable_addition *add,
 					struct reftable_stack *st,

-- 
2.50.1


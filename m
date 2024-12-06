Received: from flow-b3-smtp.messagingengine.com (flow-b3-smtp.messagingengine.com [202.12.124.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BDFE1FC110
	for <git@vger.kernel.org>; Fri,  6 Dec 2024 10:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733480861; cv=none; b=gUDYxwYQQ9QfiH/6K8SdzdeW1fsRV40IypkjBDVMZ+Jf13gA63fXYTLFMdWDjySIRLZc6M+qaPuaEJrs+hKvDoyEXCDzl4ar70Lir05LgyannkQkF2yHS9lCF0PIOr9Bviffy2nF5ImmwTuErJ49YGpxm7xr7SeHUCJ0NYF58t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733480861; c=relaxed/simple;
	bh=+GAZHQwsNXOz5X6RBqCMGSS0jJ6zg/37nifc597U8/4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gXxTwa5hDCu+ysd40sejNGC5PjfT5cQBK6iIXIgy/uaF57/x1Zc0zGtn4g5rXeG7v/ysn8WOAuUAuIFEyYzlaoZhZI6BckMZ2Fn0awdbOml1JeePsmF9yRV1irrmLKYc6AiT8hQm327w1ohV651IJxEhLXCXULFyv9YAC8D+f7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=e4LXxtsR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Mk0Z81oR; arc=none smtp.client-ip=202.12.124.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="e4LXxtsR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Mk0Z81oR"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailflow.stl.internal (Postfix) with ESMTP id 3C60A1D40636;
	Fri,  6 Dec 2024 05:27:38 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Fri, 06 Dec 2024 05:27:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1733480858;
	 x=1733488058; bh=b6ho0wcLsh01aSmlNVS0ZfrjkuOVmB9vVz4X/lCsbbs=; b=
	e4LXxtsRV65h4aGmVyeS836e40ABbkIIsN7V+qTNjKxuLliKu2o+Bt19bGZWPEyB
	+DZhyH8m8sCi7QhIYylZytZT7G4tWCscEgYsqrlTsUQ9PXCnzN5ngqf66jOX7MQA
	VxCgIPD7Z2sed5eOOHDBFl5OOho30rmvSPFsRu6mAqoc93c/00oXYJ3nbaXOzMqy
	5y39P94SbV8Qp1JMapoUwDdxfh743QhVEI+6ARD+FReNNqigEYkkKnDEF2AsXMDa
	pIZESdJ2BtZm9CPHXLVAkmJpEHIFm2Yq6YsyunWJxHZDnpEZRZyfq81VIKIv6O94
	Jv6wr4FwkMNn+KJnsuWkIQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1733480858; x=
	1733488058; bh=b6ho0wcLsh01aSmlNVS0ZfrjkuOVmB9vVz4X/lCsbbs=; b=M
	k0Z81oRTsWP/853cSfGfp6JRHAU6I7dIDcNnYgdxMMdOcjKLaMQ6VNN3OnHdSVxP
	jZC16ELag3Za33M/bfKH7IyfzR6IjmsdKIkaw4HdGVK7vnTQaMKGmEJCXyh9IWNu
	/M3r4siv/nPBOtWwIoutheHze2a6zgrQ9mzsORJkLu4CG43N82/FLkOAoNNec5bW
	YT36WJpsEwAYs3yE1wZksQnCbUkCog55FKg/rzbXKIvPXYPvl6XIhwovNnmWVUFR
	zff9aZ7yN8SRdAgCGdGzWsTM52iVbZK+VLiTD56yK3VEo1mGN/yfmPIFDT05n0IX
	9Q127bZoq1GJRAGRr7lJQ==
X-ME-Sender: <xms:mdFSZyWs0gp2oQ3yvLI8KXfqhDo-WCZVWPB-cvwgGGakVZ7GTQ6Z8Q>
    <xme:mdFSZ-mlbvIMtB7ier8TuxIIiF6gnzOG96zeD_8mNediEVIxDZVZwNZ30V2NjhAHj
    c7gMwAe1xs5IdU5HA>
X-ME-Received: <xmr:mdFSZ2ZSWJoLWqJEH1V1HIgGJVbqBK0ON-OZLgOvKE8i75LcX4Vm_YUPu2vjEt5OolxGFA6W7CzLVnUXNPCn4Kz1Zn2Xrv_zjTgsgHYd6e_AiQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrieelgdduhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecuogfuphgrmhgfrhhlucdlfe
    dttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhm
    pefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtf
    frrghtthgvrhhnpeegleejtdelfeffleetvdeivdeuuefgheetjeehudetjeehhefhheej
    teeugfffvdenucffohhmrghinhepghhnuhdrohhrghenucfuphgrmhgfrhhlpehhthhtph
    emsddsfiiffidrghhnuhdrohhrghdslhhitggvnhhsvghsnecuvehluhhsthgvrhfuihii
    vgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtg
    hpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehpvghf
    fhdrnhgvthdprhgtphhtthhopehshhgvjhhirghluhhosehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:mdFSZ5UljsAxS5BmEtebps8XEJzI0cq4O2hIA3aPn_Ro5AgGidYAtQ>
    <xmx:mdFSZ8mi6cmHKWX0Bffbkin2jKnqCyVEXPsL6i6nM9HTW9vTRGO2cg>
    <xmx:mdFSZ-eB7cDDLouZOFtiCQQ1eE7iS-mCMRFgWe47OhIWxUWXhfPjxw>
    <xmx:mdFSZ-FqZw1Sp-ewELBDYPtN1Hjnmm2T8eZsrTAw3zNdd5PQ_ZmiAw>
    <xmx:mtFSZ4tuijAyUKq48sUaeGLUo0wLSdJYkf6Es8dHSBqmKh15mKmSpO2A>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Dec 2024 05:27:36 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id b5defb24 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 6 Dec 2024 10:26:12 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 06 Dec 2024 11:27:17 +0100
Subject: [PATCH v4 02/16] compat/regex: explicitly ignore "-Wsign-compare"
 warnings
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241206-pks-sign-compare-v4-2-0344c6dfb219@pks.im>
References: <20241206-pks-sign-compare-v4-0-0344c6dfb219@pks.im>
In-Reply-To: <20241206-pks-sign-compare-v4-0-0344c6dfb219@pks.im>
To: git@vger.kernel.org
Cc: shejialuo <shejialuo@gmail.com>, Jeff King <peff@peff.net>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

Explicitly ignore "-Wsign-compare" warnings in our bundled copy of the
regcomp implementation. We don't use the macro introduced in the
preceding commit because this code does not include "git-compat-util.h"
in the first place.

Note that we already directly use "#pragma GCC diagnostic ignored" in
"regcomp.c", so it shouldn't be an issue to use it directly in the new
spot, either.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 compat/regex/regex.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/compat/regex/regex.c b/compat/regex/regex.c
index e6f4a5d177bb7d44345fcc25fabca1e62b0eebc4..4b09cc4e1457dc362b2c974e82a6f9739b499a83 100644
--- a/compat/regex/regex.c
+++ b/compat/regex/regex.c
@@ -17,6 +17,8 @@
    License along with the GNU C Library; if not, see
    <http://www.gnu.org/licenses/>.  */
 
+#pragma GCC diagnostic ignored "-Wsign-compare"
+
 #ifdef HAVE_CONFIG_H
 #include "config.h"
 #endif

-- 
2.47.0.366.g5daf58cba8.dirty


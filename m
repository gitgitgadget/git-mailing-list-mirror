Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA0C353EDE
	for <git@vger.kernel.org>; Wed, 25 Mar 2026 06:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774419697; cv=none; b=UvAnVrvrlbMXS04CYVcEqLa21QApwGNj+u7mPU56liRvnl8c/F5qwr3Sk1lSmUZkaVE4m/taXKFweNSwmgZnFfKK8n6f2ziRGHvs+EH4s17CDcgmlqHzrmPAPZMsN2WqmCrYbmrP1ieTS+7wCuwwdSEdzXbccq/jsRnJmQhzd/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774419697; c=relaxed/simple;
	bh=L5Yl1ULzjGERjZkeEqpIDEIZE8k+ICT0JDlKXOqK8gA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mk6UcQOIQMoW/uAeitNkqJe/9ysQA+uYA4/OLy2tt3lb2NIB7VVO45uxsF3cBJ+93d8h6cmZGwDghFW71rp+xwmLq0MtsIT96YA26ieuLzpjYnuAugyFKb3F28HR4QaqB8tjR+6byuc725aK8vVsakfMCynNcCaDO65/RFTzaIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=R2YWUqQ5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=usv0D493; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="R2YWUqQ5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="usv0D493"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 75D4B7A006C;
	Wed, 25 Mar 2026 02:21:35 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-08.internal (MEProxy); Wed, 25 Mar 2026 02:21:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1774419695; x=
	1774506095; bh=XFh01m8gPkiyC9TzIM2BvycctOzHpe/2afL3Z9/xUXM=; b=R
	2YWUqQ52WvhNKmvhsQkOyVb3o3h+RDvUBzdCQ5gAMV23zQmzqk8D+wWYPCwI4QMu
	N8vCLY4yESShFfkcMoSQDvKDIgCw5o8u2DVyBYBD6ml2Tr7eJHEqO5RH5S/aO451
	Kl2/yZMUFXyNYhXe9z7PKPJSkA16a90GFWzC+9rc++2G4I2+tFoeTFLwBM9A97WP
	lMZd/RDUQyRuaznogI3CHGaHuhdnB9MDlBQwnH3iGIFathZ+1xunqpDLnwfXrf8f
	I2FeQwQDjh3307qr/RX+p/K/1Nfj2hW8QUWv6rncInNrk7PnL9PQHWGdQPGGh8bh
	nqjLRncUWG4/HA4ZrOr7g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1774419695; x=1774506095; bh=XFh01m8gPkiyC9TzIM2BvycctOzH
	pe/2afL3Z9/xUXM=; b=usv0D493TxjGpebA89888ymICShlOtKsQKNvVli7uBTb
	aQKCcNlY+1sLG34rskwuqSf4cRvBa+4fKMbfzS0UJ+qAkwl72OIhroGl5Vvq0wzO
	Ur5/abRl8wWHMHflhgeNd3COArCzrnq5TgRipA4LOcQNjiZJVl7Aw9xk/+kUKHhU
	rAegQaZJ6xUY3SSmhBBVnTePIxIKhVRQBBL8mx/5Thn23g2DjcFbZkCcskihHR1/
	4ECuNLAN3ISy3vb8A9HS14elhg+10RVMRK1nqDAcgcl82DdanPaUb8ABuSQTSZt2
	MBVtZTeuXHJZPpPgJFnQn4kQfex0jVijoCbRMyL60g==
X-ME-Sender: <xms:737DacXDJ893I-6ZVCGOz8PRpivd7AKzwCS7XTZnmw1dCsJhAoP7vw>
    <xme:737DaWn4ABZl677THYq7uYqLSQBpImzqujfzvhLnEPvWCPzXjUy8S55rHXSWkvg-q
    BjxY_UXwahSqzHNFLM8YseIbqVghNkosW0yICF8TyCOiK9k4W4bgQ>
X-ME-Received: <xmr:737DaeAQrYAlxa7XdmkU9YcglhLCexA96OXLFge_g6zTMU9o3cRfhkU6xLgmr1m0V3rvNQIfWxx4ZQ39viBYRoQ82AwbgYpMXw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvdefjedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekredtre
    dttdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphho
    sghogidrtghomheqnecuggftrfgrthhtvghrnhepleevieefieeuffeugefhveeugefgfe
    evvdefleevuedvfedvudefkeehtdeftdegnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspg
    hrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhm
X-ME-Proxy: <xmx:737DaWe4Mz3At5w12VM-bQcvOMEjlqeGpSCfpaU_RssplXZYwTS64g>
    <xmx:737DaZKLbMEnTq1yvjIHkT2ySbxXGi30eFl8MaYZM1HZv8xZWKEQsA>
    <xmx:737DaZeEzMRSONgDI584L0TETb98VaJkGsiuYAdKzoLSR105DwdUtw>
    <xmx:737DaQ3R_JK2A740zY0VdGDFhcrVM2HpvhgQTrWwW4k2YczQzj92kA>
    <xmx:737DaXsYC9SSfAroqZo7aP2A7j-nXIjJzGd7daVjaR-HsPxOXMp9ufmh>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Mar 2026 02:21:34 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH 11/11] t9902: make test "set -e" clean
Date: Tue, 24 Mar 2026 23:21:14 -0700
Message-ID: <20260325062114.2067946-12-gitster@pobox.com>
X-Mailer: git-send-email 2.53.0-886-g529cbd14ff
In-Reply-To: <20260325062114.2067946-1-gitster@pobox.com>
References: <20260325062114.2067946-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In order to catch mistakes like misspelling "test_expect_success",
we would like to eventually be able to run our test suite with the
"-e" option on.

This script uses the "read" utility to populate a single variable
with the contents of a here-document.  As "read" signals that it saw
the EOF by exiting with status 1, this triggers "set -e".

Here, we squelch it with the standard "|| :" trick.  A simpler
alternative may be to use a simpler assignment, e.g.,

    refs='main
    maint
    next
    seen'

Either way would work, but just honor the original author's
preference.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t9902-completion.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 2f9a597ec7..e3a7df7691 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -590,7 +590,7 @@ test_expect_success '__gitcomp - doesnt fail because of invalid variable name' '
 	__gitcomp "$invalid_variable_name"
 '
 
-read -r -d "" refs <<-\EOF
+read -r -d "" refs <<-\EOF || :
 main
 maint
 next
-- 
2.53.0-886-g529cbd14ff


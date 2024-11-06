Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91BD7204F72
	for <git@vger.kernel.org>; Wed,  6 Nov 2024 15:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730905890; cv=none; b=jo1fQ5NrdWh60fJfKpFAnu9EN+AqiU2KP0vmLW86uY2IFxv8ufnoHm4qsEgmVrTXdnBOPj49dTezvqBktMSbwlUWy6yFxtYmWrWWvU1vhwdbdqhCwBoJ67YIcH8Wqzh5FCGMQTXW9YZRW7tNge643lsECJNoEqgRCnTpZrfBV3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730905890; c=relaxed/simple;
	bh=+PRSnb+SzOCep+pScEkUf9e2pjn+OaKtNO7t4LyYDqU=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N2OSyTKT5DgOuGF8HgiincEMymbytATf4L/3qko9w8DTsza4rz+P50wtByuUbCCbSW5vsdsPX2+I+f75wqFgpmXwrmgSKbQ9ptHVKWEZNH9rvQfhgWJMGt95Uyx4gU8oPNE5fyhNW9FJHtvlYlPJ7XsRieOKIaL7XDa0iJ0nsyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=K89TUMYy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CvI6Dfen; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="K89TUMYy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CvI6Dfen"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 8A35B1380215
	for <git@vger.kernel.org>; Wed,  6 Nov 2024 10:11:27 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Wed, 06 Nov 2024 10:11:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1730905887; x=1730992287; bh=RR4RrEiHea
	LGI6y5FegVyffzRsGFzbVmusEer6FHicY=; b=K89TUMYyB0Io1vNUu7l16ODJyN
	kZ90bxUXjzrF0m56TEj++HVi6ChYU5K93CnHTFyiBRWl0FOa+AXc9f2k4Grm5gmv
	e/XJAoiKoYe6ndKtY+ktP45Eu4uQlvTWsR4R6hDD4p3+KQTsuZASr9+zTlCcWHAk
	7o946Lf/ET7yud1pUsop1lMPX0f0QAO6mOa2/i3T7UdpLhq/NcXvmGywJiz1D8Ve
	7FcHx/bp+HcGRWy8L9bSYx8J0vhBb7MND8vgTATLIl/0m8lcIJWOT3uTPbb3AlWx
	GQNPxScn6Ci/3UTLpqqbjZst4TRhHXmzsKNa9AASUvYNYx+RzEZaafyFqb+Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1730905887; x=1730992287; bh=RR4RrEiHeaLGI6y5FegVyffzRsGFzbVmusE
	er6FHicY=; b=CvI6DfenAuJ5sgDDO8Jn3qvOo3G3Tn1TEcYTBDspdl1OoG2BvsW
	f1AjzT6ApHF1pFHqBY6hH0kGyJ3awKsJNVYbqIbFgzXN4sYZWoIB0T4yPRWVuYx0
	8j0ZVrikDuc5OAnHRTdgzYR1Wm5UW4bKjb8hO5Z6VHN7trHUdR7Do6vOPZtbY9Zq
	UrK7S8Vw+3YnVaSA62wqgeJ5XreN/9CUjp+zzeBJQ1BsdeVq3gFdoU2l76BxewGX
	ctxdS38MPSGk/EF/o+AstwnFeWCf4T00NMFIn0vv/KvhtCTseRu2kTZ12lU4v1t5
	OD34h57IBjqSvMB1cmqNA1UvIM7hweBjThg==
X-ME-Sender: <xms:H4crZ8iH0_QmWB-wqEV-ClIxMLMYd8eMX8LXqfpggY5-R2LeB2V45w>
    <xme:H4crZ1CcZC4v82L6XaR_veHE58CfATFgapOqLMWHQk_M9B5gmP-Q9XwDlewrWcjCu
    ilH0k8QeIg_Z3cM7Q>
X-ME-Received: <xmr:H4crZ0HGZpZUY1tT9x0RNHHfb-fsWxaX2-urU5-yuQseVYH8Wqy7UCZGXN3n4CsyxqpbqUnsqFP1urZJOkqAvb644GrBwifkr5kieVu_1VgGhQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrtddvgdejvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukf
    hfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgr
    rhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeehkeeffeeggedvge
    dvfeefheettddtffejuefflefggfehfeelffeljedvfeehieenucevlhhushhtvghrufhi
    iigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprh
    gtphhtthhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:H4crZ9Q7sMaiuO07_ynpxGDk9n8FaZqEZdcc1fQyFrIo0dbQTY36Qg>
    <xmx:H4crZ5y1fSqN7P_WHeqwkTBZYpnDKRO8C4ijLGAaUbuNpuA3fjF28Q>
    <xmx:H4crZ74XZz303Nh-NjGVk-cK4sLCziTUGCxdNmeJx5AfbwBXzLQjug>
    <xmx:H4crZ2xh_93C-OTHJkKXtA0HYOLs7HNe36sChitSE5SyGU1dWLxtSg>
    <xmx:H4crZ6pt237ij_UEsCWqzvx3RbHT6cI-STv5kDcZswooux_iCAAyuNKS>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 6 Nov 2024 10:11:26 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 81f280d3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 6 Nov 2024 15:11:02 +0000 (UTC)
Date: Wed, 6 Nov 2024 16:11:18 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 20/26] t/helper: fix leaking commit graph in "read-graph"
 subcommand
Message-ID: <6439796a0bcc709febbce62277769d680992a44b.1730901926.git.ps@pks.im>
References: <cover.1730901926.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1730901926.git.ps@pks.im>

We're leaking the commit-graph in the "test-helper read-graph"
subcommand, but as the leak is annotated with `UNLEAK()` the leak
sanitizer doesn't complain.

Fix the leak by calling `free_commit_graph()`. Besides getting rid of
the `UNLEAK()` annotation, it also increases code coverage because we
properly release resources as Git would do it, as well.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/helper/test-read-graph.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/t/helper/test-read-graph.c b/t/helper/test-read-graph.c
index 9018c9f5412..811dde1cb3c 100644
--- a/t/helper/test-read-graph.c
+++ b/t/helper/test-read-graph.c
@@ -97,7 +97,6 @@ int cmd__read_graph(int argc, const char **argv)
 	}
 
 done:
-	UNLEAK(graph);
-
+	free_commit_graph(graph);
 	return ret;
 }
-- 
2.47.0.229.g8f8d6eee53.dirty


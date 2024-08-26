Received: from fhigh6-smtp.messagingengine.com (fhigh6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E4313C669
	for <git@vger.kernel.org>; Mon, 26 Aug 2024 07:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724656956; cv=none; b=dPbSDep0mAt17oYZEWdJtwBeMCVRt0FRKLsf+O209iqkAaVCgNBiFt8jwmP9I37aJZtG6fdiDmSsJxm3VzwMRnN7SIFlZIngQio+ctdTyQ3QyD58ZVCtSD8wNnzR+s+7fwMMOXOUjlHUDbctcqEWlV3DPt835BW20m/dWa+TU8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724656956; c=relaxed/simple;
	bh=li0qY7IJAsXpCcJMnQo02cqbmy07fhegFtnmm+YlnYc=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=osbLLjDFPLyUyMAxoX+dEkYtcNg8crcYsDWC21BDylzlT+pTOvxgo71KA9+f9PHF591zNzbFpzKSOYkjb8Dy5sxKXX8uAdxLkogBxrGShbiQMHPwm5AlwRD+7HbIdbQAjwQFZbGx/g7Byg5hc1DsnhN+3gkda1ifpaXfJc0uVlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=DtVJ4t1q; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dMejJ6Di; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="DtVJ4t1q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dMejJ6Di"
Received: from phl-compute-02.internal (phl-compute-02.nyi.internal [10.202.2.42])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 966061146D4C
	for <git@vger.kernel.org>; Mon, 26 Aug 2024 03:22:34 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 26 Aug 2024 03:22:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1724656954; x=1724743354; bh=+OGED14Xzp
	5cNWy48ZsubjnyWicoXOz6Kj4A6a6hlBE=; b=DtVJ4t1qOgvFRfddJX4MdQfY9d
	Oa/y9XNuwNMK8jH0jiddoJezQQQp3ggwQvvXBogEqlHzRIxb7KoNGgfu693R8r8c
	9B2egaGJjnmebnI/Ug5KBq+BMgy9jWi8PjMDVBanDeTOr77KyShUB2I6eiCPOJg5
	9yCIpjKALvmwIqWliGg6rRbpzxxYJYWCpByiEhTjPZT48SM3pOGqsYMMtl7bQp84
	3tK7tCQ72LGMgPPPsaK8PMJJxs+yJgIz0nbxderAoSTqNVKwXeG21jLWHjNKWerl
	Xy+QUxeVjw64nTo31sSekFr6eJWU8gL04T7d21J8gIM1bPt6GTNNCtO75f0g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724656954; x=1724743354; bh=+OGED14Xzp5cNWy48ZsubjnyWico
	XOz6Kj4A6a6hlBE=; b=dMejJ6DiCMKXtkL06i7PzY8BpH1cKSQlSdsMOCGs3ant
	vm5HCj+y9SZq3v3urPL1I9ipF5TQPKvbb+jdAclA52D82U+uIJFjZ6ayUG4Bvaop
	/E540WYUFIdififQT/KDPUhtxWPEN0gFbAaH0gdm27hOiiO6Fj1GNa4pOwPy3Ipq
	LORLtJ++TCvFtx4XZjPhivehEFD9Q33e/3DZZhXVauS6UvldmnxPjsYzOHy3xY1n
	Q7au/wjzVw+5Adk3CbvBhoOEAfJlIkdk4pE0CL0Jfm1/9SLkzy8YUEckcTYwnTjN
	vr5enV8hP6EG+gAoCWjc5UWpF/FaYp05HSJQLXK/ug==
X-ME-Sender: <xms:Oi3MZti0sksmQZY4XvzJwF99dgwuVVMji9rac06o5_T5KdRF2pGurQ>
    <xme:Oi3MZiAspxhOZYBxUUV2ii8IpMAlcMNl_WjUM_7AtsbXlIRWAylX-VHuIcbpMU_Hp
    sQVQplalR2MtXMtkw>
X-ME-Received: <xmr:Oi3MZtHhshXMuGor_52rcjx731eVSd9-ijiQxdWUtD6927yC1x6Ynz-fgCnmY2_bz6BE4KgBQvIc4O2iHWk5K1vs3d8okCB2m8to-Ai15Vk1L4U>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddvjedguddulecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvf
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeehkeeffeegge
    dvgedvfeefheettddtffejuefflefggfehfeelffeljedvfeehieenucevlhhushhtvghr
    ufhiiigvpeegnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:Oi3MZiRYm6Ndez3i2yLF6b93UbWyaE8IXwjfN2ta81QJpsugD7xZjw>
    <xmx:Oi3MZqyjyO9bkcmafrNp-KqABL8SK6rT8iIMAy8C2WXl0aF-gQFqFw>
    <xmx:Oi3MZo7U8Oaq3vij0mVaSsDAmek15En9BRdgQdBxrdBfcUdAYraWkw>
    <xmx:Oi3MZvylBz3_3Tet6znOjidXMDz0hFT9ACeNqWrEiIMRhcpxIDs-rw>
    <xmx:Oi3MZvrDT8ejUtjdNxhzP7zIaFJJWRmDZldDR9IDXQ7bLE_HTMknc3Nx>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 26 Aug 2024 03:22:33 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 86ccaf3e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 26 Aug 2024 07:22:31 +0000 (UTC)
Date: Mon, 26 Aug 2024 09:22:32 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 19/22] builtin/fmt-merge-msg: fix leaking buffers
Message-ID: <b37391c0d6bec8a017968bb78f1a2284a408e9b0.1724656120.git.ps@pks.im>
References: <cover.1724656120.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1724656120.git.ps@pks.im>

Fix leaking input and output buffers in git-fmt-merge-msg(1).

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/fmt-merge-msg.c  | 2 ++
 t/t6200-fmt-merge-msg.sh | 1 +
 2 files changed, 3 insertions(+)

diff --git a/builtin/fmt-merge-msg.c b/builtin/fmt-merge-msg.c
index 957786d1b3a..0b162f8fab1 100644
--- a/builtin/fmt-merge-msg.c
+++ b/builtin/fmt-merge-msg.c
@@ -67,6 +67,8 @@ int cmd_fmt_merge_msg(int argc, const char **argv, const char *prefix)
 		return ret;
 	write_in_full(STDOUT_FILENO, output.buf, output.len);
 
+	strbuf_release(&input);
+	strbuf_release(&output);
 	free(inpath);
 	return 0;
 }
diff --git a/t/t6200-fmt-merge-msg.sh b/t/t6200-fmt-merge-msg.sh
index 5a221f8ef1f..ac57b0e4ae3 100755
--- a/t/t6200-fmt-merge-msg.sh
+++ b/t/t6200-fmt-merge-msg.sh
@@ -8,6 +8,7 @@ test_description='fmt-merge-msg test'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY/lib-gpg.sh"
 
-- 
2.46.0.164.g477ce5ccd6.dirty


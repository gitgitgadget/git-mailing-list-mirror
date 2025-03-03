Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 714B723E327
	for <git@vger.kernel.org>; Mon,  3 Mar 2025 20:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741034711; cv=none; b=MQzEDLF52ECpyD7COie7J+AuZtKY7Bpvvu70TDR893ITZ8CHn2XpREo2vtRi+8gH1oMz6G86WA0yENrE+t/y7RXnPokc0WLxvZochWZAJfonj0hUdpv1OdZh9fD67hQ/C4BxnkY4Q+TjN6jSU6uJN4oTiRzVsCyjnFzBbiz1Bek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741034711; c=relaxed/simple;
	bh=f3YLkxv6wwiQi/oUX++CyGawpTnPSswzbn/3MAD3DYg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FfE/n/aNZJBYd2PKiJKVPayX5mKhjKLx6O6wEhHblscVPAo9YeUqDsGqUAYFS7Q/kYg4Aj22//0l6mgQ/DpWYa1jTFgk6sZaAEW/q9cuMlammXCftiCowFz79TSmY2YeAG/yC4mfsBcNxWIKvDdSEeCrIWXBq+qYBjJUiBNEUR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=rPWVAVTo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VY2QbkGu; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="rPWVAVTo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VY2QbkGu"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id ACF601382C53;
	Mon,  3 Mar 2025 15:45:09 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-10.internal (MEProxy); Mon, 03 Mar 2025 15:45:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1741034709; x=
	1741121109; bh=EXH+oiA3rjVpmmpwqNn9zVupWT6+J4UL/lIV40fIUvE=; b=r
	PWVAVTo0wtvDjzCiIvC0YmQqvgg10v6oEiL6tW0wT9A9F7IHI/4yWC+uqB7qj5hr
	CXRPVNOTk+GNF4Mi9YJbl6EfNVxWqBNFGU9doYmMDHS2xhFkjEJ9PRkT3anbuQho
	JngaGNmZeHBLe7AjlEX+WL3VlmqGjr3aXH1HMYN1S/unX+liY1Qi6aTnWxmO2XCP
	OCfSL8CxJuXGene8vBxMtt/UtKfHdA+BBbapDZlXIQf4u6a82H3hYJJ61mEqHMem
	eG2mVsHeX0QWtoXDy7GUFC20KuzUi3H3ujlUWbsDp2/khHGBGVAOBRdwi7muNpPv
	9YnYrttjopScsW65V7T7g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1741034709; x=1741121109; bh=E
	XH+oiA3rjVpmmpwqNn9zVupWT6+J4UL/lIV40fIUvE=; b=VY2QbkGu/YKOHSWjf
	yV/zEano0Qxknvmi7kNskAmMhXjQDUTitCQGk0KxobmljqzSOGjApsGf8Q5QJjbm
	PycPqqUNC6M7rBnSTdjv4KJuzmvXWUBy/BIXXNeoY7arFZw9eCVb3KbRPLcRzero
	Yk2BifoNLeURLmfMF+8Jr4fobzQOlJlBYQg1ISWsOTWcGg9ax3IDkaFlkc80aPK8
	ENuQkMOa48cqsCEP45NcMZjZtWZOV+MZbXbuwYdeI+Hh4F7/9EDoCPfZ4T92BDPy
	gzClGn48CJ3AcaDWY/iRbC16tu945zxm4Cposw850zt10UEM69qrbi7rLFiqXEsp
	DYsfg==
X-ME-Sender: <xms:1RTGZ06Ez-E4vSYhKBcxZKSzNgFxG8j14ITnnOY7vSd-MjNPrxqy7Q>
    <xme:1RTGZ16FF3pxLXeOpSaQDUSKgu98p8S_GgDJUOusQO5IfEnYYIbQui2uPBnFAvwmy
    Fdd-FYCoVZp4QF9Ww>
X-ME-Received: <xmr:1RTGZzeV3otLlIQ41Z4s_09mFaAgr1fF4EY6rX8JmUi6TWTIeeV4FuwAVDsJaO8Xc37Wh4G-K8Pynwj4SNHrpbsfP00>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutddtudduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvf
    evufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefvohguugcukghulhhlihhn
    ghgvrhcuoehtmhiisehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeejuefggf
    ehieeugeeuheevgfegudetheetuedvveeuueeileeuhfeigeefkeekieenucevlhhushht
    vghrufhiiigvpeefnecurfgrrhgrmhepmhgrihhlfhhrohhmpehtmhiisehpohgsohigrd
    gtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrh
    esphhosghogidrtghomhdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohho
    thhhphgrshhtvgdrnhgvth
X-ME-Proxy: <xmx:1RTGZ5JebA2_YD-F1wIkfmGwe8NwwAyGegRyMMk7S2Ud6ZONJhvOKw>
    <xmx:1RTGZ4I09xrb6-AIxnkLlmWfXTz7xRQJ9W7svW7Mw5PuNgsJf6VsmQ>
    <xmx:1RTGZ6zDLDn83xMZ0Y4XSX7HHFUHz0O1GqjLgeM-CLMohBTVeEzKNw>
    <xmx:1RTGZ8JpCY32ykBaekNV62ij90SofwmTJCt6a-o_Ls1wLFs1QXzAnQ>
    <xmx:1RTGZ81y0S2XLP3HPblynue_e_41a8rPC_Xz5JmaJO0CfhYubaPXQnFp>
Feedback-ID: ia13843cf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Mar 2025 15:45:09 -0500 (EST)
From: Todd Zullinger <tmz@pobox.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 23/34] pseudo-merge.h: *.txt -> *.adoc fixes
Date: Mon,  3 Mar 2025 15:44:21 -0500
Message-ID: <20250303204443.360595-24-tmz@pobox.com>
X-Mailer: git-send-email 2.49.0.rc0
In-Reply-To: <20250303204443.360595-1-tmz@pobox.com>
References: <20250303204443.360595-1-tmz@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Todd Zullinger <tmz@pobox.com>
---
 pseudo-merge.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/pseudo-merge.h b/pseudo-merge.h
index 29df8a32ec..c9fbe9d312 100644
--- a/pseudo-merge.h
+++ b/pseudo-merge.h
@@ -101,7 +101,7 @@ void select_pseudo_merges(struct bitmap_writer *writer);
 
 /*
  * Represents a serialized view of a file containing pseudo-merge(s)
- * (see Documentation/technical/bitmap-format.txt for a specification
+ * (see Documentation/technical/bitmap-format.adoc for a specification
  * of the format).
  */
 struct pseudo_merge_map {
-- 
2.49.0.rc0


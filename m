Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB5A214812
	for <git@vger.kernel.org>; Thu, 16 Oct 2025 10:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760610727; cv=none; b=jzxYUjE5hzuQyyAzT3vjEYSI6akgTKRSZLYoidWIgsBT38LgAfdE8Dvz6lZZxkgbSVTktgM3rjo8AZZDvFMDvwXQtFmL4LnIt9yekLLXvo1rGLmGg7c9XnTNLP4DbewDZZocTpQ/WMLdO2NYW7lgbe4ck4i3JwqGHkN1D6qA5Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760610727; c=relaxed/simple;
	bh=PfGhdNZO2gayD6+gDXADdkAnOO009DVQ870UQuPOEhI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Fp0CY7Ko+p/GRbrvZXSiFo/4jfCv4G+P26/3CsPpqHnmMuIgVheoLYk3H/7bYrinhHFm+CJs9UrnOcr8kimAHGJI7imtCff5G3vgpO90bAxAIX5EYPD2LPpdiH0CXf04lTRQgGEBZmltjqveHGhWb2Dhn9K0qY+7WbCvJ9WcJFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=dPVY1KYR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SKMZ9U3v; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="dPVY1KYR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SKMZ9U3v"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D2660140006C;
	Thu, 16 Oct 2025 06:32:03 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 16 Oct 2025 06:32:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm2; t=1760610723; x=1760697123; bh=yFWGBQ5AMOAh2/B5aOMbE
	210qVzD3pfq9F3Jv2LnXYs=; b=dPVY1KYRvwl9r6dx7BbEz1nBVn9EKrIt9pyNw
	YDNxV+pVENHm+utPrIZIS/MLkxWhiElNq+TmcIfWEE5ROpUND1mX+OSSbNrdRfcs
	l8BuYmBB5hYv+Ce/TYU7KPa31yYlzFhdZfhiQywSRr8EzHN7d0yINqnfyZKM5UB9
	4whCE1BVLvrgvTMHa1vFfrbJKylJYOfxE/CYaoafhp309JaMORiCxeiMDxvsyeBB
	OCE+AG3u97IrWoW4pOTeNd+FBUH/z2wBkD7k2UnQyodh59MIlMDQoeSj7DqJ+3f3
	7jknpThtqGclKvNhMDXtIjRWddnGox4+7sDnw/nRaL0XpW7KQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1760610723; x=1760697123; bh=yFWGBQ5AMOAh2/B5aOMbE210qVzD3pfq9F3
	Jv2LnXYs=; b=SKMZ9U3vv6JuGhAsFl94U2RSIRpoHrsiV1k25QdbokP32jx+vIF
	1RAWICoerLPx3kGUBAc4bYyzDpDavF4qAW+BvYzuWxck5joXfuPUVLeoZ509hJOP
	17I69/U8yXgR9JX5p/SsIAB47nv/Wrq3fzrrGuHk+Xd1HwZYeN+9qX9jXW+4oqvb
	weKEhpIeLv9GwwHu5PsXd0fLWW58Z0t96yAXDtRcqueBUTsuA1RPxfoRxbCk+l7R
	zjjkb3BLfG7pow6+xAQP/PaADYMxzHLdnGsPYu4PfZpV4b0CLiHwcxWQCto+yoQI
	0hCXsRGEx4ScMGfdFVhQWmib3g633/BcwDw==
X-ME-Sender: <xms:o8nwaF3XXKyeh-q4d1-Q2ajEFKHdYelCRMHE0pfKZQrEmAurrp400JQ>
    <xme:o8nwaCHgVNV5dksxi3O1lZLA1lMlUXsLX2oSpnro8Gnujb4Z_W0_MuRsz7XDw0wqX
    e7ytRWXRLg1Q05FgTD5VoLdDqAs-kswxiydzD94TWD87J5UMub79A>
X-ME-Received: <xmr:o8nwaDgKNocPkNBqIjuXVhSoc7JHX6HjA27r_NQGC_k7O55qUTnEYdz8cyOe6ex7TbS_aPKagwcpwpREBJyHHCLw_wSIpSpW0Qe8xps>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvdeitdeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffoggfgsedtkeertdertd
    dtnecuhfhrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghi
    lhdrtghomhenucggtffrrghtthgvrhhnpedvheelvdejheejjeehveettdejkefhhfffve
    ettdffgfekuddvvdetfeejhfdutdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsth
    hmrghilhdrtghomhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegtoh
    guvgeskhhhrghughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:o8nwaN_yqkJhyqmFxrh6ZfPKHies-Jhou94CmJpj7DdWxsE_87tzyw>
    <xmx:o8nwaKpAWCpCldwmnG3vI9e9pZ7wKHU0vgXYSyFqOYXGTseF8EKN_w>
    <xmx:o8nwaM8v_PfuJfwBY62U5kwKcRPmpFZJaG9sWb_xXnoOw8_ymuODZw>
    <xmx:o8nwaOUHvZlF8nitoNmrUpPHz-lvferw3kkQIUg4ICoh3dozqMD7Ew>
    <xmx:o8nwaBPYCYXojvZVJr2OFlxfpoeYG_J3h7iyLSgA-u7Pfg27yxLtaKhy>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Oct 2025 06:32:02 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: [PATCH] RelNotes: sync with Git 2.51.1 fixups
Date: Thu, 16 Oct 2025 12:31:43 +0200
Message-ID: <7620da43552a693c0a145cee0637e61d678c8d35.1760610541.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.51.0.352.g356bc2d8d49
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

Carry over the fixups from 8c3d7c5f (RelNotes: minor fixups before
2.51.1, 2025-10-15).

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---
 Documentation/RelNotes/2.52.0.adoc | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/RelNotes/2.52.0.adoc b/Documentation/RelNotes/2.52.0.adoc
index 67b0ac7c459..8c4ed4eef48 100644
--- a/Documentation/RelNotes/2.52.0.adoc
+++ b/Documentation/RelNotes/2.52.0.adoc
@@ -100,7 +100,7 @@ Performance, Internal Implementation, Development Support etc.
 
  * CodingGuidelines now spells out how bitfields are to be written.
 
- * Adjust to the way newer versions of cURL selectivel enables tracing
+ * Adjust to the way newer versions of cURL selectively enable tracing
    options, so that our tests can continue to work.
    (merge 1b5a6bfff3 jk/curl-global-trace-components later to maint).
 
@@ -212,13 +212,13 @@ including security updates, are included in this release.
    name.
    (merge bcb20dda83 js/doc-gitk-history later to maint).
 
- * Update the instruction to use of GGG in the MyFirstContribution
+ * Update the instructions for using GGG in the MyFirstContribution
    document to say that a GitHub PR could be made against `git/git`
    instead of `gitgitgadget/git`.
    (merge 37001cdbc4 ds/doc-ggg-pr-fork-clarify later to maint).
 
  * Makefile tried to run multiple "cargo build" which would not work
-   very well; serialize their execution to work it around.
+   very well; serialize their execution to work around this problem.
    (merge 0eeacde50e da/cargo-serialize later to maint).
 
  * "git repack --path-walk" lost objects in some corner cases, which
@@ -294,12 +294,12 @@ including security updates, are included in this release.
    updated.
    (merge 54a60e5b38 kh/you-still-use-whatchanged-fix later to maint).
 
- * Clang-format update to let our control macros formatted the way we
+ * Clang-format update to let our control macros be formatted the way we
    had them traditionally, e.g., "for_each_string_list_item()" without
    space before the parentheses.
    (merge 3721541d35 jt/clang-format-foreach-wo-space-before-parenthesis later to maint).
 
- * A few places where an size_t value was cast to curl_off_t without
+ * A few places where a size_t value was cast to curl_off_t without
    checking has been updated to use the existing helper function.
    (merge ecc5749578 js/curl-off-t-fixes later to maint).
 

base-commit: 143f58ef7535f8f8a80d810768a18bdf3807de26
-- 
2.51.0


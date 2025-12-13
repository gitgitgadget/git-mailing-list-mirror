Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 608CA1B0437
	for <git@vger.kernel.org>; Sat, 13 Dec 2025 13:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765633704; cv=none; b=XfxO8CQZMUmffYjbEHHjQ6t0+ZtRabbpEqDJ5ly2r+m9UCwcRkXx8cww0PkPJflJYTmV9fIq6mdVj0QkZLzv86EOhwA1GsI7Itu/oY9yLEJXMowd3dgz9imzqSiRrhXFXajomkrXo3Fs9BAvLy/HVrKjtnLXJfcqx/piKHChznU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765633704; c=relaxed/simple;
	bh=tlMrolXxwTPKxw7YhUhBYpNlbZLwGZvoUY7c+aOHQwE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fTDs1DZ6KfVMsdJ7bl5471fqVmwY443MzsfAZzEpGxMvsWzRIpnL5ocpGkZSE13/UarNRLJawKqcVTtXDb0uICzFdU02XdXHQSuE+ZA+timn2Y5ECl6McGgW38CLaXMKxQ919bHlJRh9KyEDscsqkOh8Q3TmBZ46lQO8NHPg51s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=T6B8qQRt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=t1JLXtEn; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="T6B8qQRt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="t1JLXtEn"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 85DC97A0050;
	Sat, 13 Dec 2025 08:48:20 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Sat, 13 Dec 2025 08:48:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1765633700; x=
	1765720100; bh=2xIVmzt10exjDcl7oS9hanNiwT6MpykfJfWLZ9j9DwA=; b=T
	6B8qQRtjRPU8drTflk4f07TuQ3eVcqLp2hC34yO/kuoypDYBwq216qysmPcw38kd
	kC+OMps9TxOl7g41DYInfZIciA7l/nLFoEosmFxEPtT9JGLiVq0Ns3iS+jeBHr4b
	vGa8V9fi6nH275PIDzMKQR0sObikw5Ogfv5Jcs37szblRYt+gG7cQsyU6oKiiF8X
	eA3hpJYy31PA7EBsxEn055ONHfnIW5M89uk+Wv1tymqj49b4Po3RmuWH034VMpgW
	XzyAeK86W6O45WgdFfyKPG4QJfRiDh52W1Z1QvFpoZ/Ri7rjbXrtZhSkNwpbjV5M
	JovtQygjymrIN1xwNHDlQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1765633700; x=1765720100; bh=2
	xIVmzt10exjDcl7oS9hanNiwT6MpykfJfWLZ9j9DwA=; b=t1JLXtEnjJYS04VWI
	zDQxS69w41j0Tt0sv0wizr2LONo570NCUcQjNwlrexP4GiJm6Vpq3AX2z/2YMPO5
	njGQMS7Huz5FbZrAt9ENu4NT4VEp7JJJkPET6nBLMCkxgUYwhkihNhkBgeQUOQjJ
	Ddamrx2AcHy/iNbqnsDpPkCd3LKlMrenlmrxGziqwnPirW4vBgYcJ9md9TR9WN7+
	aN0ygP4POPrIKipvcb32A1KXoM7qyrviliFmku7n3zHYNhemvunBbT3O0lJurHBB
	DG1H5vjBROsGnJxfWkXxILHXtqXQv1+zX1lDOeaGs+HRey9f7VM2EEne4DmhDfwG
	HwSIg==
X-ME-Sender: <xms:pG49aQqOLMkDDpjBIaO-W72MsDIsDBxtVyf3qn2TOUNivZynCbw10q8>
    <xme:pG49aXXkfNupf7AF4NZVQ6TjgbSa0Bh9_YFqczwc65NRQCWZPXxjLtH6AWuSbN-Gh
    D583tYeVQFNKj37BOEcQfkJQ9_HDGnWJd46POrScMfmjfSWpu6EyQ>
X-ME-Received: <xmr:pG49aTY4_wJ_cCPd6Odvq-KKKv9QX4YwqfcJICiGL3HSkGC6DBCDHhGxGZ3OVDU4D954Ny5auMm5EslGl3CtzywrC6fuIMaO8418Q28>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefuddvvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenfghrlh
    cuvffnffculdefhedmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredttden
    ucfhrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrd
    gtohhmnecuggftrfgrthhtvghrnhepfeehteekfedtieffvdejteeutefhuefgtefgtdev
    hefhveffuefftdehiedtfedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgr
    ihhlrdgtohhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtph
    htthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtoheptghouggvsehk
    hhgruhhgshgsrghkkhdrnhgrmhgvpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehphhhilhhlihhprdifohhougesughunhgvlhhmrdho
    rhhgrdhukhdprhgtphhtthhopegthhhrihhsthhirghnrdgtohhuuggvrhesghhmrghilh
    drtghomhdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthho
    pehsihguughhrghrthhhrghsthhhrghnrgefudesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:pG49acfSQIvuLGpuq6tuvlZpHyN7OWFRdzBYu4IvqZA04Nkar-F8Pw>
    <xmx:pG49aV3kRt1U5RtbIizZjGbYOMZPwKcyPjNcIReAdUtd_HhNPKLk3Q>
    <xmx:pG49abLEf6J7WCwLKPmQ4j_hP9hOHHCZiuCx8vnricKRzqenbl420A>
    <xmx:pG49acFpwz4qbsYQYr87dPPHsFLQrB7VjY69Z3PdPe3pjDgv_E420Q>
    <xmx:pG49aTng0vQhc683q4OfTs75DnNbRulGnRIvlirA9-PeMdW8WMf1p0la>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 13 Dec 2025 08:48:18 -0500 (EST)
From: kristofferhaugsbakk@fastmail.com
To: Junio C Hamano <gitster@pobox.com>
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	git@vger.kernel.org,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	christian.couder@gmail.com,
	newren@gmail.com,
	Siddharth Asthana <siddharthasthana31@gmail.com>
Subject: [PATCH v2 3/3] doc: replay: link section using markup
Date: Sat, 13 Dec 2025 14:46:58 +0100
Message-ID: <V2_link_OUTPUT_section.132@msgid.xyz>
X-Mailer: git-send-email 2.52.0.10.g08704017180
In-Reply-To: <V2_CV_replay_conflict.12f@msgid.xyz>
References: <CV_replay_conflict.101@msgid.xyz> <V2_CV_replay_conflict.12f@msgid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---
 Documentation/git-replay.adoc | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-replay.adoc b/Documentation/git-replay.adoc
index 1e2469b9034..22fd1b271af 100644
--- a/Documentation/git-replay.adoc
+++ b/Documentation/git-replay.adoc
@@ -19,7 +19,7 @@ the working tree and the index untouched. By default, updates the
 relevant references using an atomic transaction (all refs update or
 none). Use `--ref-action=print` to avoid automatic ref updates and
 instead get update commands that can be piped to `git update-ref --stdin`
-(see the OUTPUT section below).
+(see the <<output,OUTPUT>> section below).
 
 THIS COMMAND IS EXPERIMENTAL. THE BEHAVIOR MAY CHANGE.
 
@@ -67,6 +67,7 @@ The default mode can be configured via the `replay.refAction` configuration vari
 
 include::rev-list-options.adoc[]
 
+[[output]]
 OUTPUT
 ------
 
-- 
2.52.0.10.g08704017180


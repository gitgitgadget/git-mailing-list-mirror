Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D622D978C
	for <git@vger.kernel.org>; Sun,  7 Dec 2025 17:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765130197; cv=none; b=PxVm8KvshQ7k5oytqO+k9bmnW/AKpKFCQW76xgfLBYm8ugwBuQxod3sEVqoS1HrIMBJrf5xrR1XolkgLSz3dRldHRXgzvEPSE8iEjMmO/5R/+0U2lf4rGweimUPN4p8RM+UTKVd1dHUKc2c6gbeA47oZn90lCfnOBqo3VEmw79s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765130197; c=relaxed/simple;
	bh=OJNNDDUjPJtnBK8ZmJRtfpdwAdkZO/Qr7IxTQSksgxY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sPdGrrsjbIK6Boqa6XXKme2Ja50eK7iCIXgdOmWviRLC4zXHkvoZ6HdIe3dwqlAF6JkESfhgXOmqEM/6VTBoqRbiuBqtBxLrGTDPmC3vjI/ALVCFUi+Kwx+Di351MU8uOZ0bLB9gL7/uje7n3CDPiZcYx7zS3m10fKOmubxk9bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=FZgnVmki; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nj/1LCw7; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="FZgnVmki";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nj/1LCw7"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B79CB14001EF;
	Sun,  7 Dec 2025 12:56:34 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Sun, 07 Dec 2025 12:56:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1765130194; x=
	1765216594; bh=NJaZBrH/J3EuhtBmuq7V/5FnuOU3ZTl6sQn5yZ/mHX4=; b=F
	ZgnVmkiuxRb8BeX1gLSZbtcgvAHNO2OPj0aDjRbGcd+i/XJWAkzXSrNYwYbq1pw7
	SmwvodGowzbRMdgDH/lV6OP7YypJtadtjWWI/1jZsSeOHSMQ10dDOe5NwZ4g6GNa
	YBJMv8ov8Sch45FY+F+g5qU4ZQkbfKKOJbEKei+NAcp5mw/+WzoeFFT4EFigYgEs
	uE6fEh4yP/mGVVBel7Cmq6QVMsnCNThDZ+EnDnOea6xmAQvE4z/sgG4qyVFGZMU0
	bsxxw8/7ln5IpiKUt73jWByU0eEJMPvNZY52NC14RNMptlFzI+ro1ilEwyKxMgKY
	ZWfrKS2Urb8+B5x8UKG3g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1765130194; x=1765216594; bh=N
	JaZBrH/J3EuhtBmuq7V/5FnuOU3ZTl6sQn5yZ/mHX4=; b=nj/1LCw7KMVJKt2tB
	HSYWufihoHB1tl2uKYbjX+zMRruI4ooCHynFY5kMmDK+uC4mkFKvsvSWJL4amZNe
	mHgX4oWgolQhYFRAGNOaVHTbemEMbHo0oz0L9eGHle21ImApaHaqdVAmmJGUF/09
	mjNGL79J3hk59XWY8x2wy7+oYGHgqmRFoXdJ7JZ3AX0EX8TxYlJsB0HjX3/3ViVl
	2D9OdVpJSMgPBF9yQySs8m9WyCJhU65MlJV3KiZzQoGC+ZMccOxlVlsUkvLodg1R
	9RJt2v91zhUf9pQ8h/1t2M3s3I0iRTWBGSaRKLABb6IrmctMHPfkBthu5+/qr8bN
	WVEgQ==
X-ME-Sender: <xms:0r81aW8OZtaN4sCYM7ppYEUAXmBnV9ovlSgv73CMuT2u3jGcFBnX4Fw>
    <xme:0r81adnF7KXSO1r0BAhH714PK_kxVzX2abqGVK-Iv4BN96N5Eqti_uCRIFCkPAtzY
    I-1ctOfjRo4BfjuMaGdIyGVvdQcz-W3rWunsBSnwnlz4IQd3xBa8g>
X-ME-Received: <xmr:0r81aUXGr5SF8mowB5Vj3ZIBqipyTNqck_ASauasda742qgDvQsDYYIZFzqH3H45o1Jlln-skJ851rg8kdgSOkskW6iARIF2lVdsfcWOlwwO1xgCoCblUew>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugeegiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenfghrlh
    cuvffnffculdefhedmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredttden
    ucfhrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrd
    gtohhmnecuggftrfgrthhtvghrnhepfeehteekfedtieffvdejteeutefhuefgtefgtdev
    hefhveffuefftdehiedtfedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgr
    ihhlrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtph
    htthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghouggv
    sehkhhgruhhgshgsrghkkhdrnhgrmhgvpdhrtghpthhtoheptghhrhhishhtihgrnhdrtg
    houhguvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepshhiugguhhgrrhhthhgrshhthhgrnhgrfedusehgmhgrih
    hlrdgtohhm
X-ME-Proxy: <xmx:0r81aaGTNl58PlOU3bkFL61empDgV-7TZq5Dou5COwv-WW4WYaz-3g>
    <xmx:0r81aYc-YRGn4tBMcM-jCjXfRaJDks_8Y693lJeVhHbs5lLAWLdUNw>
    <xmx:0r81aTJDBX_6C5qoi5wXCH777vySJ8h_DVoNlA-WrgyAaxmZ3y20Gg>
    <xmx:0r81aVHQ7XPsdQBeJibIJnoUJBIIQP023zkn_3XaBrsnb6ROE1p0iQ>
    <xmx:0r81aRVptA0WIeHFI5r5EkFdTE5wShRRm_uF1nKJIMJmYhbSgbddU-Fr>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 7 Dec 2025 12:56:33 -0500 (EST)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	christian.couder@gmail.com,
	newren@gmail.com,
	Siddharth Asthana <siddharthasthana31@gmail.com>
Subject: [PATCH 3/3] doc: replay: link section using markup
Date: Sun,  7 Dec 2025 18:55:11 +0100
Message-ID: <link_OUTPUT_section.104@msgid.xyz>
X-Mailer: git-send-email 2.52.0.10.g08704017180
In-Reply-To: <CV_replay_conflict.101@msgid.xyz>
References: <CV_replay_conflict.101@msgid.xyz>
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
index 1b8661185bb..04944a5fa23 100644
--- a/Documentation/git-replay.adoc
+++ b/Documentation/git-replay.adoc
@@ -19,7 +19,7 @@ the working tree and the index untouched. By default, updates the
 relevant references using an atomic transaction (all refs update or
 none). Use `--ref-action=print` to avoid automatic ref updates and
 instead get update commands that can be piped to `git update-ref --stdin`
-(see the OUTPUT section below).
+(see the <<output,OUTPUT>> section below).
 
 THIS COMMAND IS EXPERIMENTAL. THE BEHAVIOR MAY CHANGE.
 
@@ -66,6 +66,7 @@ The default mode can be configured via the `replay.refAction` configuration vari
 
 include::rev-list-options.adoc[]
 
+[[output]]
 OUTPUT
 ------
 
-- 
2.52.0.10.g08704017180


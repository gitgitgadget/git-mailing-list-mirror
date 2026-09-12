Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7C8361977
	for <git@vger.kernel.org>; Sat, 12 Sep 2026 19:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789240538; cv=none; b=kh/mcy6xTJWy3XQ9Cq90wB/T6CA5/bZRj/VgDB6OFqiHbwGvLPCicqHqGE8bk9GdMcBVlHqkKfZxwYbyoImfYMMdjocbaOqWVy52l9S3z/fnv3TL7bgReVAnrFw9hKbU9jr+z3xqJiwxZLkTaQM0vmMyMwcPbLUgURpr+6cqNI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789240538; c=relaxed/simple;
	bh=ORBlZW0RFfVAwbotQhn+MGy6zhnUIFNeu5Xnw9LHt/M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sppYgejKs2sF41PeaOzYQjJ1LbcsUOqcVb3k6j3YkxVqB895iI7vi7dU/mGR+IvLjep1Uz0OBesoMO/ok/2abxk9jMurS07dIFyNkwEpN4KSI07JcLdnZX2TtyhNfyGlq1bVUOVBMmy4Z4MU2kMKFEZUCNR0iGCPaQmRvlX2OGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=wGyY7B8H; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kKDYDotM; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="wGyY7B8H";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kKDYDotM"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7004E7A006B;
	Sat, 12 Sep 2026 15:15:36 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Sat, 12 Sep 2026 15:15:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1789240536; x=
	1789326936; bh=w94+GoJdGrZT3tZ/E81U5mu1FLS9cHt6GJu6WjpF5pA=; b=w
	GyY7B8HGMMAd3XX/QLyHIjrfyg/ggI1h2BrYPx1HYTmCwO7BWxSrNH15q/eYh+s8
	LwwfLvJOI/EgLjj6bjE1vxXjZn2LBtqKR+DBPEehpNe2TnRhcl9qkqfG6GkoK9Hn
	+umXWChs2N+Gl8lPJCKuuHk+S8LpKye1vjKp2T3uytwrBwK0vw+tueBmqWjiPWqN
	Ie5eiEU9/W5n7gRFq7jxT+9MR1dY7dZZDeQPeW18FufHoKb6DZmD/diTe2PE+naS
	Bi38yM3Oxwhv9wvuwkHR0DHCY3hTWZZulrKxKqD7RWMa/0vSXIdSQLEL4AOx0Z7s
	2Id7bcTbt1HnzyqJtPeBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1789240536; x=1789326936; bh=w
	94+GoJdGrZT3tZ/E81U5mu1FLS9cHt6GJu6WjpF5pA=; b=kKDYDotMdVoOjuCZt
	virime15cc2hLRvwE3g33oXU9sNaeeIc5DM8HaSl/3hYt0t/VVoYbkWPTyrCp23A
	FJlA7BxJBRc5IQHi3aVK0DaMlydzWxxX6YfXIa8JH2bAxo1QIXDcih6JcmJH/L/r
	xYWHFiWjToIgF/zUnMYJcWyLRNv6BVuAcGxLAe9uLogTu22jV49caRFx9u25gukd
	lnHxfyq2pxeHGUGdEcUxVO2oTNB4hSfuLNJlLkJTpmyu1IyBdAoSuMqyzwVK2nEl
	q/iRW7KBeZ74NJMIhVptWLXUtrfLMxhi0+0cTNy0dcUPwqUvh7E72IUTbrAsCxsw
	Wj7dA==
X-ME-Sender: <xms:2KSlapYuuCgB0sUWB_39O-RwSi6nvEB2t5HfIz03mKOEWDtfgxlaSQ>
    <xme:2KSlamY5Iq8sOUhREJ2iL5ulLJqZvHThlILafyLsIu3nBg0jgqH4vv3E8Q5T21QQ_
    gCiV30ERaVLFLkP45NJTOVIRexN6K6kIiGlHmAvjsKpom1tFlxV4Wk>
X-ME-Received: <xmr:2KSlapkKdeP5pAwpV5XlA4DwmGJa4eswomT4E7AiIdzoJMwzCVkawLJgyyHGCczP1O76ju8WcZxI-QErfjiNBpCEium69tiGFfyGzQmF_Yg1u-1BLeoqAJ9Xks-7uMfKaqdJtxBjpL4onmVQ>
X-ME-Proxy-Cause: dmFkZTGgyrv9fjfBch5r9WuS8+zty/bjEUQ6PaD63JJ4DuNno0NbLlCnET6SGYjDe3R38f
    6/RwmRC12sygsP78n6IjBBPYMkex2sawFiCauIIYRGPN/5Zzi/IJtwGP0zBTOYnLIPO9V2
    tJ/Ef8xZMhJZ5N9VgGKVtI4IOw5zHhPqMAlTJoq2ZwO/GSdBcd3o7AtWm4P+U6O7rbDp9p
    jNBn6lzp2udmip570jZPEyu2h9XBwUlqXOq/g7WSuBICk03YEh+OE5Iqp/HHtmhuiYWLMt
    03xAZlbtGUQG0t50uGh3bDzJxf2urZfK8452c84rTg6QtaNuAUMFi7uyIxgK01qeAIr+C+
    IgbFfKcvNTSDZFAQwOWy49FIzMmhuK7MwvBGtWdPW0J9aSYk+nFypgvEbvyxhhA8YgPGoh
    D7KtrIdbPzd6Q86abCHpBCeeT0+wHwQYjDWB2/aZ/SeRY2IMTIll4WCy6ar3FXDu5O2k5o
    hmg3e+a+rVrdRd0hnYZGpiy7pBkNVb5cNvEol981QV6pl6DTlxKahxx4SksC5RjLNsn5KE
    pqZ3AyDt0LFZKzAm7nyYpUSG+bowPd5E9j4MVsL/95qTshp2s0ln/wXXGUqK72dfBtSUjo
    RJXeNB11vzSWoYw8zQdw0iCAAWJ1PlXK8bnQHQIfUptO3I0RqFt6vebdX3cg
X-ME-Proxy: <xmx:2KSlaixCQZtNtKpGch7VOb4EyZHq8L5Z-1peACPwaXtXgWIp1Z0JDg>
    <xmx:2KSlanMyk85L_GjOVFd_TSwfRzcZOFfoHGJPDLH4J0U4FqFO0CWkeQ>
    <xmx:2KSlamS4mw2LHIB9SStMrnBP1frSHcmJQ-jS-Ej1-gp9RmzeaWwGkg>
    <xmx:2KSlalYNvEIWVyGZhY7MMLvdHaHuXomW-fUKZPh7xdlxeIgc71Yn_w>
    <xmx:2KSlasw_pgtk1LWhdwjToEceXYT7XmCVkG1lMhEnsmNChvKdoLCEFv0w>
Feedback-ID: ia13843cf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 12 Sep 2026 15:15:35 -0400 (EDT)
From: Todd Zullinger <tmz@pobox.com>
To: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
Cc: git@vger.kernel.org
Subject: [PATCH 3/3] doc/refs: backtick-quote commands and options consistently
Date: Sat, 12 Sep 2026 15:15:02 -0400
Message-ID: <20260912191509.844954-4-tmz@pobox.com>
X-Mailer: git-send-email 2.56.0.rc0
In-Reply-To: <20260912191509.844954-1-tmz@pobox.com>
References: <20260912191509.844954-1-tmz@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The git-refs doc was converted to the synopsis style in 89be7d2774
(builtin/refs: add '--no-reflog' flag to drop reflogs, 2025-02-21).  The
commands and options were not backtick-quoted at that time.  84f3d6e11e
(doc lint: check that synopsis manpages have synopsis inlines,
2025-08-11) applied backtick-quotes to the existing commands and
options.

Subsequently, a number of commands and options were added without such
quoting, leaving the documentation rendered inconsistently.  Apply
backtick-quotes to all entries.

Signed-off-by: Todd Zullinger <tmz@pobox.com>
---
 Documentation/git-refs.adoc | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-refs.adoc b/Documentation/git-refs.adoc
index 9063892651..9dc08cbca9 100644
--- a/Documentation/git-refs.adoc
+++ b/Documentation/git-refs.adoc
@@ -54,40 +54,40 @@ These limitations may eventually be lifted.
 `verify`::
 	Verify reference database consistency.
 
-list::
+`list`::
 	List references in the repository with support for filtering,
 	formatting, and sorting. This subcommand is an alias for
 	linkgit:git-for-each-ref[1] and offers identical functionality.
 
-exists::
+`exists`::
 	Check whether the given reference exists. Returns an exit code of 0 if
 	it does, 2 if it is missing, and 1 in case looking up the reference
 	failed with an error other than the reference being missing. This does
 	not verify whether the reference resolves to an actual object.
 
-optimize::
+`optimize`::
 	Optimizes references to improve repository performance and reduce disk
 	usage. This subcommand is an alias for linkgit:git-pack-refs[1] and
 	offers identical functionality.
 
-create::
+`create`::
 	Create the given reference, which must not already exist, pointing at
 	`<new-value>`.
 
-delete::
+`delete`::
 	Delete the given reference. This subcommand mirrors `git update-ref -d`
 	(see linkgit:git-update-ref[1]). When `<old-value>` is given, the
 	reference is only deleted after verifying that it currently contains
 	`<old-value>`.
 
-update::
+`update`::
 	Update the given reference to point at `<new-value>`. If `<old-value>`
 	is given, the reference is only updated after verifying that it
 	currently contains `<old-value>`. As a special case, an all-zeroes
 	`<new-value>` deletes the branch, whereas an all-zeroes `<old-value>`
 	ensures that the branch does not yet exist.
 
-rename::
+`rename`::
 	Rename the reference `<oldref>` to `<newref>`. The old reference must
 	exist and the new reference must not yet exist, and both must have a
 	well-formed name (see linkgit:git-check-ref-format[1]).
-- 
2.56.0.rc0


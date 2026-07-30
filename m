Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 368573B27FA
	for <git@vger.kernel.org>; Thu, 30 Jul 2026 09:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785405533; cv=none; b=Wkx2YBSs1+sLUA1tqJKL4rK0Q7mWdgk4opOqV/RwLwZFmruaguPVAbD6xeO6DYrIkhMpJ7KwDYftdXuKOQXhoaav2UtkjV+dP2a9tca5C9DUWv79YyFh17u9tgpJTyxdmIEiuDfy3TCpqb8gmJJVfIL0tIb3QHyvkCIcSup6FcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785405533; c=relaxed/simple;
	bh=5Kt6vUhlAdd6tVMnfOGMH4wsTDgeAvOt66VboqS5YUY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VJG/d/MCNxqr9NZnCVd4xbNb9Oo5knswiSYdaxJqeGGixRxriZzfUNntpdS0LUTvtDEfTQ1jIvDFQ4F5XG5JbYit2xuPVJt9u1h+BYlJWh+BSaKaV/YM6svxqlmpQ0ntpcqzzEEQngPRvm4HL6RWGX66EVPRUJ1jUGnYkq9FH/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=cQbc2R2i; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mcUDDXdQ; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="cQbc2R2i";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mcUDDXdQ"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 9C22D1D00100;
	Thu, 30 Jul 2026 05:58:51 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 30 Jul 2026 05:58:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1785405531;
	 x=1785491931; bh=Y6TFVl1BvOqyMFEJITy+xRES/uxfN/YvxpkLhq7QYU0=; b=
	cQbc2R2ibDORTbsYxaRIJRcZmIjvIhgmdJUVu5UoEYssyNfiUtbrGsoVl4s7PVeW
	pcKX1a1TGHBY2XCrjHZLrCOzrGGjALFo/G/yt3bFYEB7gVNJqG+2LKCn3Zg20+vY
	pQK5NvcmsftvcBkxdDa7T4L5EYtnxXvGkEFUXzLIHiP5YJH5g6tKjTkjPTY1sLck
	vOx5UNUEAJdoe84uxzb4NZ9r6eodmr7PZu9Plf6hyHyfrcjntnaSL2QpZOwgXiLw
	ftYY1cKwKpXv+Y3+mCT6NqdDh1YHDMJKw3Ja9DJqOerUoPDhsUCS2XRznBWnQsRu
	U69Oo3mhRP6sfvMNdiiUMA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1785405531; x=
	1785491931; bh=Y6TFVl1BvOqyMFEJITy+xRES/uxfN/YvxpkLhq7QYU0=; b=m
	cUDDXdQdJaWYf2XjaD+4GpfYFJy2euIZz02wNCpDIRW2ioxm79lFGp42r5UQJovw
	foBkN9CtJo6nOxOqSJEaBq5ezkGPA9A+igfE+XWSE6m0JuHlUrUKfdDp1WUntPMD
	93uh6Qy7ty0LFbHymWYU/qaaCwhq4CPaqmCHAhqAoymce+X9Pu+3Qfn6HuRt+xen
	8CZoHWwOYhbFZRrudXmW/5jme/IxyPBthQVITVQGBb42411HWakz+j49t3qhXcXZ
	3qhx7UM+D+rpwTCdq04cY4khLV/w9QafvkkswswTUZYAz6fKIaxig08d9k6oY9fC
	TMO2hKxBjcH2wGXKJ8yLQ==
X-ME-Sender: <xms:WyBravxibCVCLBRcJx3XR-EShXq3acCrOG1LJJG_hcWrdQwmBsaFr-0>
    <xme:WyBraq_O1Q-Lturfu2nkwCM6eIAGjEkFbYhwW3ET4FwOWF5sjDFQBBnPs236VfzT3
    eF1j_-TY7PbJplV3CTw0o1yRCswIBB6ZvN4IYqtYYbT9l0cruxqUA>
X-ME-Received: <xmr:WyBrajKV0WkMMlRLNhUI5a9mWWe4hmKaO3uaVN8sjQ3oKPrIB6l27HVcvx43mWEKfzY5iOGnVPKmRrEp2JqYgLYQNpXVf2tpCG4_2xI6xR4NfuAL6HVh3XA>
X-ME-Proxy-Cause: dmFkZTFfu9LVkCyNTP6+w6+0ZCMcaqhCtFuyvf05XAb4FwXSPv/MYEleVb9TzBk6Qvz/s/
    IvygWfZN6VHUHNxSYD44KjA8ts2v64690aiuIXPk2zZgmLp5nemG8bDjADJEypjZhi+ZEc
    6NSnUpjHltimymeQKG/qtUMEUu3geU96gM/0U2aarlp4dLDm3/R5N7Vy/H5zBuLV/4h8iq
    busaVXOq4HOpzpeBHnzN1gkbuSbXE5CbDozSB53iqgdQGTaWYZk6ohFf0mRDBzIk7vuWgv
    HAjm71J5slVjMnkI/DUneq2oIdA9Vm1iFn5FzYHQwl4VoqzTTFeiYaUx7ll3YyY3WYtKTK
    TpTlXsiagLn7ePo5UHNdEuBQFy8rvCQjM94sUvu8lNMzO1c0f266laWhJCjhX6G3PtsKOv
    CSJ2XcoVA2yTpk0GTO10cIbV9goSas0dAC1KhGlcWOZIfQM/GyskzXYumse2THmm4mobxW
    W9gi28bsmeHq4lnHl4I7ieWxVVn7lGnJqZPY8nkKHHvJEOZe5BFdjzSHp5KRAcuD9WB489
    OdE8DAL/538lFnmYzfpC3xXPz0QhGikJov+U5D7rJ6S38Pn7YynokxLoGpSTxqryuNNw1r
    gFOXv+XRg3ZcGy0ouhlWsrD6tJCQEbHnf2UFm6lAEny9H3Hri97vfVoR0h6Q
X-ME-Proxy: <xmx:WyBragfiTCQVSqARbJk3i-uHzWpoPSvd0YZ3R3hKnBTmJBYtZXJMCA>
    <xmx:WyBrai9WuF5hV6oYt5yitI3KvKd7QBNhsi6mMuFmwLZzYeBj1F9w6A>
    <xmx:WyBratoKb7aIypqrQXcSyvIZ9xE7uZBm6mHOeeaR_VzNpRxfPXEudw>
    <xmx:WyBranDxB4zk9dCCZIEDxTdxfPFzRbReO__CKCzzXgRgLcNUmHv9Xw>
    <xmx:WyBrao0A6lb_RtY7XcAbpOtf9j6PMGV6nx7wuIAwATkN_Cc0Wkpbhv5f>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Jul 2026 05:58:50 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Junio C Hamano <gitster@pobox.com>,
	Siddharth Asthana <siddharthasthana31@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Toon Claes <toon@iotcl.com>
Subject: [PATCH v4 4/4] =?UTF-8?q?doc:=20replay:=20move=20=E2=80=9Cdefault?= =?UTF-8?q?=E2=80=9D=20to=20the=20right-hand=20side?=
Date: Thu, 30 Jul 2026 11:57:16 +0200
Message-ID: <V4_default_RHS.af7@msgid.xyz>
X-Mailer: git-send-email 2.54.0.22.g9e26862b904
In-Reply-To: <V4_CV_doc_replay_config.af3@msgid.xyz>
References: <CV_doc_replay_config.709@msgid.xyz> <V4_CV_doc_replay_config.af3@msgid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

This is now a description list (see previous commit) and parentheticals
like this do not go on the left-hand side. Moving it to the other side
makes it stand out just as much and is also more consistent with the
rest of the documentation.

Let’s also do the same for the `replay.refAction` description list.
That makes the two desc. lists identical in the first sentence. Let’s
add a comment about that for future editors.

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    v2:
    • It’s “description list”, not “definition list”
      • (Same mistake I have done for “line continuation” (it’s “list”))
    • It’s e.g. “right-hand side” (drop “-side” hyphen)
    • Change `replay.refAction` “default” placement
    • Now that these two description lists are so similar, add an
      AsciiDoc comment about it for future editors. Note that I
      outright deleted this list in the previous version because I
      didn’t want to keep them in synch. But we can remain aware of
      these with two comments.
    
    ---
    
    v1:
    > do not go on the left-hand-side.
    
    At least I haven’t seen it.

 Documentation/config/replay.adoc | 5 ++++-
 Documentation/git-replay.adoc    | 5 ++++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/Documentation/config/replay.adoc b/Documentation/config/replay.adoc
index a7dd5288553..84e17e313a1 100644
--- a/Documentation/config/replay.adoc
+++ b/Documentation/config/replay.adoc
@@ -3,7 +3,10 @@ replay.refAction::
 	The value can be:
 +
 --
-`update`;; Update refs directly using an atomic transaction (default behavior).
+////
+These use the first sentences from the description list in git-replay(1).
+////
+`update`;; (default) Update refs directly using an atomic transaction.
 `print`;; Output update-ref commands for pipeline use.
 --
 +
diff --git a/Documentation/git-replay.adoc b/Documentation/git-replay.adoc
index b4fe43ec687..ea4d14baddb 100644
--- a/Documentation/git-replay.adoc
+++ b/Documentation/git-replay.adoc
@@ -80,7 +80,10 @@ incompatible with `--contained` (which is a modifier for `--onto` only).
 	Control how references are updated. The mode can be:
 +
 --
-`update` (default);; Update refs directly using an atomic transaction.
+////
+Expanded description list compared to 'replay.refAction'.
+////
+`update`;; (default) Update refs directly using an atomic transaction.
 	All refs are updated or none are (all-or-nothing behavior).
 `print`;; Output update-ref commands for pipeline use. This is the
 	traditional behavior where output can be piped to `git update-ref --stdin`.
-- 
2.54.0.22.g9e26862b904


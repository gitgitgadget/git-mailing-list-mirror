Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 905FF3EE1F3
	for <git@vger.kernel.org>; Mon, 27 Apr 2026 19:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777316845; cv=none; b=SSCXnv0C8Yl+RmVcXp3X34X7rk4HurY9GM1HtJS+Oxq4/l985WurqvddttEMbitL6eQcBbt7xcbG4If6WWKLijfpJisQoYT6W1zaeQOHCKPajUf7olpwa0/8t6DVWpglmuX1piNDKKFGTzzCo1pO/3lYLgn3UpnTm+hXk2QaimA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777316845; c=relaxed/simple;
	bh=nYA5/PDYGRe2p3ISPuRh4G9DrwlzB8i6dfv+Kc4w07Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bi73PqsEf0qUa9u+WLRl3TBfmjkRCETuE/WBebRItIR11b7uxNvigVkjbVZkmuM8Y+aqiDmZYMj2FCFuAsQgToMZEjfSyAJIADMwGqLaeamLjtYw73G6RoCQv/f9GmdXIF+qreL4Sppb+BhFeMoAVmloQHxnvhRY01g94Vxt51Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=QX7mWMu5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nZLKh4hI; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="QX7mWMu5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nZLKh4hI"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id BB5B7EC183B;
	Mon, 27 Apr 2026 15:07:23 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 27 Apr 2026 15:07:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1777316843; x=
	1777403243; bh=PKrzYTlwZgj9sYtrQRdYPd0wC7I/fyI4mTW4lNmEuX8=; b=Q
	X7mWMu5zwNkaHQaUUw46MlClepge5xAXHS3PmZl0ueK8/zPhn73h7WE4ohoCYdIt
	99ZQljBC3mBEx5vj8RQyhj0qQa1QxQqBgiA3EDSBTIbeJG6bkj2sTb03tvB4FB0t
	HqYAM4bEkIeld73vg5A1mj1atC8WIB8NMuekYSiSc6hRIxlCQUBQsGT0Fo0KMl4W
	qUr4woaiqYDZqHgZVPipfqIjCQ1+5qz+SjsgojHuLRpVUuUWKICMQAi6//cUpre/
	930SUfm13+eZmfj7gvZFSgoXUKUeMc0yKdxyOSpFOrsIBfQxWBcZoLJxm1R4SW8h
	jFBOhZkpLSbHx7jg+QfFw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1777316843; x=1777403243; bh=P
	KrzYTlwZgj9sYtrQRdYPd0wC7I/fyI4mTW4lNmEuX8=; b=nZLKh4hIt56laDgIq
	X0q6SEzAZejSuKlPXCAuLab+Vs1o/PiQWYtre6TKQKfQ2jJdyPH5wd+2sx8YFmVh
	EDDG5q0VXd/U9qoKT045kVeUhcYutBns6vx98b0RHJFk8mk4IWlXIuainr368GQG
	PuAJsFWc+M5Z4h942djVQO6ze6DYDXwhhK6bICgY0x3fmXXnJBR+H+kRvebrzxR5
	QASPMUd6lmzRHUsbOGxj8L38MrZbQ4JsltpvqRZm1dFymUBKpF2hzE44DpM19Rpc
	/Q46VO8gyjVW87u5ESXwZLbkBpCbLAQl9Q9GJli2kl9/arQeDRJuG95hz0tm6SXg
	7eC6Q==
X-ME-Sender: <xms:67PvafXnDdlfAKEHQ_hXAXh8oI257LnvXvBXybP1k84Tp0tiQ0pSbVA>
    <xme:67PvafDY_-amtoRNgzqZUJL3hHTVTqrfZRyB1yjC_IwkrceKN51xyC1_pJDlVXvyf
    qn3a6NVbwkKyBKOj9e_s9jsiMEbWvasmCmUfcPjc8MPseCBazUjIHY>
X-ME-Received: <xmr:67PvaYwGlYltivAntB8IJlz_SOPfKS5jcQv8-RjnDexhEamf6SQ7Kj7flpKwozPEakSMf1l8c3hH_y2LO1AzJ-aNmTTHD6tuz7yx1d5Bc5EiyCwGv4TbdEM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdejleeglecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenfghrlh
    cuvffnffculdefhedmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredttden
    ucfhrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrd
    gtohhmnecuggftrfgrthhtvghrnhepfeehteekfedtieffvdejteeutefhuefgtefgtdev
    hefhveffuefftdehiedtfedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgr
    ihhlrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtph
    htthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghouggv
    sehkhhgruhhgshgsrghkkhdrnhgrmhgvpdhrtghpthhtohepjhhnrdgrvhhilhgrsehfrh
    gvvgdrfhhr
X-ME-Proxy: <xmx:67PvaUAVMNJ2Wp6zZDiFaoOCLG8HafX2L89rCAstxHkhoWxR-vdqnA>
    <xmx:67PvadYH8jK44R-o2GmAjFzYHnHtbIliztMBI8M0JUXysX0R6DxY5Q>
    <xmx:67PvaUgb8fsUFoWhl5SfGvEnEQh0GtQcm2vwEYRwMf43Q6qDosSvWQ>
    <xmx:67PvaX5XXuj70y0m6DTlpfke1wWJfMDSwY0Le4oxPhQR3W38k_SAKw>
    <xmx:67PvacqjMsxJsbVWYXMKlm37Zyz7-Fp9iM0dk33OYS1ECuYinfb0Uiop>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Apr 2026 15:07:22 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	=?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
Subject: [PATCH 1/2] doc: log: fix --decorate description list
Date: Mon, 27 Apr 2026 21:06:49 +0200
Message-ID: <source_block_description_list.627@msgid.xyz>
X-Mailer: git-send-email 2.54.0.13.g9c7419e39f8
In-Reply-To: <CV_doc_log_--decorate_list.626@msgid.xyz>
References: <CV_doc_log_--decorate_list.626@msgid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

026f2e3b (doc: convert git-log to new documentation format, 2025-07-07)
transformed the inline description of `--decorate` options to a
description list:

    We also transform inline descriptions of possible values of option
    --decorate into a list, which is more readable and extensible.

But a source code block was used instead of an open block.

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---
 Documentation/git-log.adoc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-log.adoc b/Documentation/git-log.adoc
index e304739c5e8..1c95499060d 100644
--- a/Documentation/git-log.adoc
+++ b/Documentation/git-log.adoc
@@ -36,14 +36,14 @@ OPTIONS
 	Print out the ref names of any commits that are shown. Possible values
 	are:
 +
-----
+--
 `short`;; the ref name prefixes `refs/heads/`, `refs/tags/` and
 	`refs/remotes/` are not printed.
 `full`;; the full ref name (including prefix) is printed.
 `auto`:: if the output is going to a terminal, the ref names
 	are shown as if `short` were given, otherwise no ref names are
 	shown.
-----
+--
 +
 The option `--decorate` is short-hand for `--decorate=short`. Default to
 configuration value of `log.decorate` if configured, otherwise, `auto`.
-- 
2.54.0.13.g9c7419e39f8


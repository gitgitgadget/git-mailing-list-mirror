Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A7CB1F0E34
	for <git@vger.kernel.org>; Wed,  3 Jun 2026 16:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780502677; cv=none; b=DGjxsrZh9JcutH35AQkxXbdz7nOv3B20u7+HOGDfKdZeTkJvbD8PYt/HZRmwksExokhliUKWHlO2KTmW24bD1KlTnxVtWbmsHCqyJQgPWEANc0Nx1tMnUE9AzAWILfloE4FuL4V+N+u2yvBhtC5bxmIG0+Lv08f6nlQQnannZKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780502677; c=relaxed/simple;
	bh=NPqhhi2UpKN3OOnGWrDT8yqOv1HzC2mRRBwVr9I18CE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J/T2aR5h8TSO2tcRfG7V3FpGvFsJM/G2OFh9yi0ERq1GLHqZloRnlBmiDonHrM4x1YAE0o4H74Wary7nJu/qND1hKjNbRWbnAGFxpyibC2KS7RD94vUH28fE3cdy3cv0Vo2PRQAfKvlMI+XS662UZc85u1R0tRlO7xNaeiNT01s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=b5f1JiEl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=j/0n8jzZ; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="b5f1JiEl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="j/0n8jzZ"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 67EBD7A0077;
	Wed,  3 Jun 2026 12:04:35 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Wed, 03 Jun 2026 12:04:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1780502675;
	 x=1780589075; bh=OYxuc8qcPB8/M10hoyqCzzNXk5yao2hgUPR15eRSKZA=; b=
	b5f1JiElXbXhJAL/ChKa9b91V4JZpcsPTXFehJv3YI4P1LJLOVFbnWdcK/rd9cyA
	p788Tgtkl73WvsZ5dzKQhK+C/1aFo6EsNwuZRwr9E4dyMREh6pW+ej6QgBha52qG
	1EwQhN9Me9uE1qDj5tFQ3jTaQlUYWHMpfEd5ixCZxg82OOmIXwGr2FVRRO/bpNdu
	fPW+USJjHeRidytfUhbm5KbXkQ0PrG+cHie49M5y/xtRAkdJRe3uZINJ1Bb7TwER
	cHV7uwGJuvsLMPkzZN/b/aPaaPDknL3NQmQ8pYMJLJZQSv/7whSAS4YAocetC5hq
	ZiSZH0CMlq42IzowGbduBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780502675; x=
	1780589075; bh=OYxuc8qcPB8/M10hoyqCzzNXk5yao2hgUPR15eRSKZA=; b=j
	/0n8jzZ2O2cRyTmL5DOLhy/wwBo1x5ignH7RaPxztu7vsie/yNFM5pB1C6wE+TPw
	a778+CV278sggYrlSr3tnaTp1iNMgxGgNS8AhbkfhDIEY6Kjb32ACBHafUBNAiYe
	UgqWo2hghJFZ7e+KCu1IXuGPtEZD9RBS+tX3ACon0IMDphyfu1E+ncC+x/yumxqR
	zlGuuZ+rP7OlKh4ZjeuPxUTkYPrUDxVu7J8+1s+inDYY5p+nnR6IDr/haVBVfJvd
	Ae6rGM1akRSz1guHE4B5nZtKKx9yCk5cJFeZa9QFUq2hpM5x/j4bB4Agza3K9h96
	7LL7VT64zpFWYoq8Z63iw==
X-ME-Sender: <xms:k1AgahlcB2OF-HtdtNqvj6SLdqyOCXGCBVji_SFJ3i_Xpg39DSzE-QQ>
    <xme:k1Agaj1tG7_2VPZSym1xELeH77W46OCKIoVvTmPjCDN6nz1EQM1qDj6LxIA5WkCqf
    O9KV7ShkAtkr9PT7GlKVZKhyRfWYrO-n9h-ZFz3_iRePk8MG0U>
X-ME-Received: <xmr:k1Agaspe-AoC3SvUMtRE1_oMLwxjss6rwK65oMyN3hbLjz0e3FXW3o2kTqte99AYmqfqfXbkXHivGN7Amv3MciBbQk-MGYucMUirl9g>
X-ME-Proxy-Cause: dmFkZTFBnHuhQocGhNR3wnteGW0eB7gMQ6zFxf8jocqy5zqVQXLKCvfdvnfGeFTu82Wybz
    SAtT5q2hFB3NpAesYJAeqNw7REUrj6oUruvF+ifl29kHCZ5rytRbLXeiLOyTd/MksV1nKK
    gRMxQl0HmIPlwbD56e3wczxxaD7BYTajM7eKmgjodPCjFjmqe2qgC56BNexz/M6ErsCVDg
    Yylx54sNG+Jes832AX8jIWqd1r36wKJ9oAffZpI5kk7OcC4Rmigf6sEgSoWHGv8pEodIhh
    amvoOutxoXvU9VVCyDwcWHG7p0tTE86OjQ053zpbJUkOGT4ozLXFyT6WAbXVO/gWTZ0RLR
    ILS98yeVR6nALB1Ov22aeogXSfF4g6nOTobq1tzHVC7f72a/Q20HfPweUI3QF2x8thbLb7
    IgHoNr5RH4UfL/r0P01/hrjZedQBot8ZokFNu3GIY0uBlQsrBcz91Yfxsowh3OYnhVLpIx
    uL75P1QHCJ0EjCOElOmtqG0HMZ63xYdCwDkxq4c1psMKMl1YWTtIKHcxTjWPMJqrLiBdNy
    JpfSMuV4CQE6TmxAAMnCUo8xdL0CNbnf+whKXkcdvssuX6/pLsWTk3yaI5nIRELBISWDG5
    Zp4OWPbPsnt23/pYRHcAmTDhObsoXbZ1tC1y+lKH9BlerxBr6JyQU3tS6ANA
X-ME-Proxy: <xmx:k1AgagfmQTj0n5CPue_O4Tkey1Q_8YoePHLxNjUs7PCE27V0n8DNGA>
    <xmx:k1AgarpwbvaYHXY72pJadp6zkwmIFYFL9Otx7BwGUMu3AT9-95KONA>
    <xmx:k1AgahFpW6wH-S70Ilx4pR4E-HBWuFV2u-54KMrtxFDUZAoPq56wug>
    <xmx:k1AgarsV6KRDC6cwqwC3ogAFnuryzTDl8yJYFm963M3u3fXXyI4CGQ>
    <xmx:k1AgaoIlMLsxTMN08_HkN6Tslg8HoJxClfmUwSU-wcEV21vjapdZn4Nh>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Jun 2026 12:04:33 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: Junio C Hamano <gitster@pobox.com>
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Siddharth Asthana <siddharthasthana31@gmail.com>,
	git@vger.kernel.org
Subject: [PATCH v2 0/4] doc: replay: fix config link
Date: Wed,  3 Jun 2026 18:04:21 +0200
Message-ID: <V2_CV_doc_replay_config.767@msgid.xyz>
X-Mailer: git-send-email 2.54.0.22.g9e26862b904
In-Reply-To: <CV_doc_replay_config.709@msgid.xyz>
References: <CV_doc_replay_config.709@msgid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

Topic name (applied): kh/doc-replay-config

Topic summary: link to the config for git-replay(1) (one variable) in
git-replay(1) and git-config(1). Also improve the doc for that config
variable and `--ref-action`.

§ Changes in v2

See the notes on the patches for more points and details.

• Keep the description list for `replay.refAction` (Junio)
• Add a comment on both description lists about the fact that
  the two are similar

[1/4] doc: link to config for git-replay(1)
[2/4] doc: replay: improve config description
[3/4] doc: replay: use a nested description list
[4/4] doc: replay: move “default” to the right-hand side

 Documentation/config.adoc        |  2 ++
 Documentation/config/replay.adoc | 19 +++++++++++++------
 Documentation/git-replay.adoc    | 16 ++++++++++++----
 3 files changed, 27 insertions(+), 10 deletions(-)

Interdiff against v1:
diff --git a/Documentation/config/replay.adoc b/Documentation/config/replay.adoc
index 42e521694d1..40d1695782a 100644
--- a/Documentation/config/replay.adoc
+++ b/Documentation/config/replay.adoc
@@ -1,5 +1,15 @@
 replay.refAction::
-	Specifies the default mode for handling reference updates. Either `update` or `print`.
+	Specifies the default mode for handling reference updates.
+	The value can be:
++
+--
+////
+These use the first sentences from the description list in git-replay(1).
+////
+`update`;; (default) Update refs directly using an atomic transaction.
+`print`;; Output update-ref commands for pipeline use.
+--
++
 ifdef::git-replay[]
 See `--ref-action`.
 endif::git-replay[]
diff --git a/Documentation/git-replay.adoc b/Documentation/git-replay.adoc
index 39ecc2e1876..ea4d14baddb 100644
--- a/Documentation/git-replay.adoc
+++ b/Documentation/git-replay.adoc
@@ -80,6 +80,9 @@ incompatible with `--contained` (which is a modifier for `--onto` only).
 	Control how references are updated. The mode can be:
 +
 --
+////
+Expanded description list compared to 'replay.refAction'.
+////
 `update`;; (default) Update refs directly using an atomic transaction.
 	All refs are updated or none are (all-or-nothing behavior).
 `print`;; Output update-ref commands for pipeline use. This is the
Range-diff against v1:
1:  ef8212a076a = 1:  ef8212a076a doc: link to config for git-replay(1)
2:  7e915e331b5 ! 2:  b60e2e02826 doc: replay: simplify replay.refAction description
    @@ Metadata
     Author: Kristoffer Haugsbakk <code@khaugsbakk.name>
     
      ## Commit message ##
    -    doc: replay: simplify replay.refAction description
    +    doc: replay: improve config description
     
    -    We don’t need to list what each argument does since the documentation
    -    for `--ref-action` does that. So let’s simplify the `replay.refAction`
    -    description by referring to git-replay(1).
    +    First of all, this bullet list for `--ref-action` introduces a term with
    +    a colon.  This is exactly what a description list is, structurally. Let’s
    +    be sylistically consistent and use the description list markup
    +    construct. Let’s also drop the harmless but unneeded indentation.
     
    -    Also make sure to not self-link for the git-replay(1) inclusion.
    +    Second, let’s replace the inline-verbatim `git replay` with a link
    +    to git-replay(1), since we are naming the command. But make that
    +    conditional so that we avoid a self-link inside git-replay(1).[1]
    +
    +    † 1: See e.g. e7b3a768 (doc: git-init: rework config item
    +         init.templateDir, 2024-03-10) for another example of
    +         avoiding self-linking
     
         Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
     
    @@ Documentation/config/replay.adoc
      replay.refAction::
     -	Specifies the default mode for handling reference updates in
     -	`git replay`. The value can be:
    --+
    ----
    ++	Specifies the default mode for handling reference updates.
    ++	The value can be:
    + +
    + --
     -	* `update`: Update refs directly using an atomic transaction (default behavior).
     -	* `print`: Output update-ref commands for pipeline use.
    ----
    --+
    ++`update`;; Update refs directly using an atomic transaction (default behavior).
    ++`print`;; Output update-ref commands for pipeline use.
    + --
    + +
     -This setting can be overridden with the `--ref-action` command-line option.
     -When not configured, `git replay` defaults to `update` mode.
    -+	Specifies the default mode for handling reference updates. Either `update` or `print`.
     +ifdef::git-replay[]
     +See `--ref-action`.
     +endif::git-replay[]
3:  30952387f35 ! 3:  d13cd39cb36 doc: replay: use a nested definition list
    @@ Metadata
     Author: Kristoffer Haugsbakk <code@khaugsbakk.name>
     
      ## Commit message ##
    -    doc: replay: use a nested definition list
    +    doc: replay: use a nested description list
     
         This bullet list for `--ref-action` introduces a term with a colon.
    -    This is exactly what a definition list is, structurally. Let’s be
    -    sylistically consistent and use the definition list markup construct.
    +    This is exactly what a description list is, structurally. Let’s be
    +    sylistically consistent and use the desc. list markup construct.[1]
     
         We can reuse the `::` delimiter since we use an open block.
    -    But for consistency use the typical nested definition list
    +    But for consistency use the typical nested description list
         delimiter, namely `;;`.
     
         Also drop the harmless but unneeded indentation.
     
    +    † 1: Same explanation as in the previous commit
    +
         Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
     
      ## Documentation/git-replay.adoc ##
4:  71a61bc0ed4 < -:  ----------- doc: replay: move “default” to the right-hand-side
-:  ----------- > 4:  17804ea7afa doc: replay: move “default” to the right-hand side

base-commit: a89346e34a937f001e5d397ee62224e3e9852040
-- 
2.54.0.22.g9e26862b904


Received: from fhigh3-smtp.messagingengine.com (fhigh3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D435313D28A
	for <git@vger.kernel.org>; Wed, 14 Aug 2024 06:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723618340; cv=none; b=IdSLzsoL+yIH5Js8ISmwog6UQCwzUjMWidFyYLGi0ggcwC5Kd7ObN2CuBgzgLlq2kz1mk6M6rMlCLDjF81fMz6Q0Xks9W4s2FFKJUPpezSPYO4BSpvW00y50ISHNh8pL0AjwT41EM7oov0clyWOb68jf6aFG+mLbBlWbiNUvolM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723618340; c=relaxed/simple;
	bh=JU+n7Yx3jSr8AyZIV6SJuxZrhmweAHgRqO0ZPi6qHDk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qVgJiirpbLzBj8ktorK1CkAIS9A009EXBaRQIOQot2+b9h8hCzPNZvdXXJxFwYLLBZrW7XLhd5f5aSMGZbVX4nDGx1ARQqTgyfDsuHpslHSDC8qnTrZ7sTGfn6X9ROVvC1IlweA4gxWrUTkTu/O/q0aKZhHm9lbJH6FqVBwhUgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Bz/wvipZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=C1Es7tYB; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Bz/wvipZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="C1Es7tYB"
Received: from phl-compute-01.internal (phl-compute-01.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 097EB1151A98;
	Wed, 14 Aug 2024 02:52:18 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 14 Aug 2024 02:52:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723618338; x=1723704738; bh=LakOwOwaVp
	c6934Z2Z9eCyYXy7OVRrlsGgNCDtQF08c=; b=Bz/wvipZkNCfntLnFiFc8Dpazz
	MnvdhihR7QV4q74sfgVwBI2o/A8mp8mHPQ/HFDPm5NXDUEaQXE03I+fSjj0ksCQq
	29L9XwhxAsoBshshUnPcF6Ch23lw495yRX5n0+aSlBGaNBWERA1DD6nOpr0hXSkl
	YXhK1BYZA3axA8uWYb6R8voGxLMlon0a81N4pjdCgOR8+/iuepfyAtwXmZh/zkN5
	wWIk4yZYIMZR3BkIPww04AwgCVddHVTqhqcs2kd2vsRN2M+eSrRBFP2SZkVidzhS
	KzButmutAjqpW97um7hBOqJmZKpS36bNzwP63uPXfUgERC9qijVWVebFHJBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723618338; x=1723704738; bh=LakOwOwaVpc6934Z2Z9eCyYXy7OV
	RrlsGgNCDtQF08c=; b=C1Es7tYBxn36RQeiQ29U/+31Szo0H6YZcIfC2wxEOWLB
	i5STMc5O8l8IZ52a+OeU6ipvx1ni+3tus9bu5oAu2PscJpt4nrDg+4ZKCV3nqXEg
	Yz3RyOIu1+Jx7he8r+i1QHU3WZzjgnVu9F3N8hbz26awOv7wgtjuZOfgEyvOXP8R
	OoLGfZuu5fGfPJNZY6SbMWl2UjghgkDFDWsdJbCnXG/sItd8doH3HQeFlXzJMb4i
	JxYkReJOe9/awKKENaa2/kM28XLzWFW4v6Vv7gohFBRTo5F4d3fJHIvQEL24KLaI
	+Fnh2kESt1Fvo2jRXASTHovBvzbQi7LqjqJVfe+q7A==
X-ME-Sender: <xms:IVS8Zu5juAOqb2lgue608FswCfsrVRnYricvMoOoD6zr1JI1E8DIqw>
    <xme:IVS8Zn58qArfIVr5H8sybIe0DSjQEeRt_rYdaDu_paZCIAOoZYw_WSpe_CEWn9dq_
    vxYkcJDQZuCnv6ViA>
X-ME-Received: <xmr:IVS8ZteNHukpSZ6j6FqfrGXZllOBEq4uROtXf5UTIaINgXIzJX6ZLtXnjCJTPoEyxmsXoYXLdp2M3--7f60T3XnBqYowEvgEgOyjnFQ1wOp95Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtfedgudduhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeeipdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpth
    htohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthho
    pehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrd
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepjhgrmhgvshesjhgrmhgvshhlihhurdhioh
X-ME-Proxy: <xmx:IVS8ZrL6iC7mp93lrG1KUihW1b11X5VBBorOkjqZB1xlEpRVVp_v6A>
    <xmx:IVS8ZiJu6pUk0n5S7cQBCFDFugz-mHKe-RRUAoIQVAsamg3Lnlyrbg>
    <xmx:IVS8ZswMAvisqQ43RihMe0uE3df2o1VrmB7wWhVJ86VYf4v_KtNQlw>
    <xmx:IVS8ZmJMDJcHRT5zux-_2n9KUPIIWWTQDeZR6Q0J5Tvj0IGzBU5TwQ>
    <xmx:IlS8Zq-g3pV7dm_I81EIgSzghuLe1NZhJ7gi_lpC7Q1pwXvIQ8TBmnQr>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Aug 2024 02:52:16 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 2f941015 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 14 Aug 2024 06:51:58 +0000 (UTC)
Date: Wed, 14 Aug 2024 08:52:14 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: James Liu <james@jamesliu.io>, karthik nayak <karthik.188@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v4 08/22] config: fix leaking comment character config
Message-ID: <9054a459a1419e333ae8f950b9c9c2bf894c55f5.1723614263.git.ps@pks.im>
References: <cover.1722933642.git.ps@pks.im>
 <cover.1723614263.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1723614263.git.ps@pks.im>

When the comment line character has been specified multiple times in the
configuration, then `git_default_core_config()` will cause a memory leak
because it unconditionally copies the string into `comment_line_str`
without free'ing the previous value. In fact, it can't easily free the
value in the first place because it may contain a string constant.

Refactor the code such that we track allocated comment character strings
via a separate non-constant variable `comment_line_str_to_free`. Adapt
sites that set `comment_line_str` to set both and free the old value
that was stored in `comment_line_str_to_free`.

This memory leak is being hit in t3404. As there are still other memory
leaks in that file we cannot yet mark it as passing with leak checking
enabled.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/commit.c | 7 +++++--
 config.c         | 3 ++-
 environment.c    | 1 +
 environment.h    | 1 +
 4 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 66427ba82d..b2033c4887 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -684,7 +684,9 @@ static void adjust_comment_line_char(const struct strbuf *sb)
 	const char *p;
 
 	if (!memchr(sb->buf, candidates[0], sb->len)) {
-		comment_line_str = xstrfmt("%c", candidates[0]);
+		free(comment_line_str_to_free);
+		comment_line_str = comment_line_str_to_free =
+			xstrfmt("%c", candidates[0]);
 		return;
 	}
 
@@ -705,7 +707,8 @@ static void adjust_comment_line_char(const struct strbuf *sb)
 	if (!*p)
 		die(_("unable to select a comment character that is not used\n"
 		      "in the current commit message"));
-	comment_line_str = xstrfmt("%c", *p);
+	free(comment_line_str_to_free);
+	comment_line_str = comment_line_str_to_free = xstrfmt("%c", *p);
 }
 
 static void prepare_amend_commit(struct commit *commit, struct strbuf *sb,
diff --git a/config.c b/config.c
index 6421894614..205660a8fb 100644
--- a/config.c
+++ b/config.c
@@ -1596,7 +1596,8 @@ static int git_default_core_config(const char *var, const char *value,
 		else if (value[0]) {
 			if (strchr(value, '\n'))
 				return error(_("%s cannot contain newline"), var);
-			comment_line_str = xstrdup(value);
+			comment_line_str = value;
+			FREE_AND_NULL(comment_line_str_to_free);
 			auto_comment_line_char = 0;
 		} else
 			return error(_("%s must have at least one character"), var);
diff --git a/environment.c b/environment.c
index 5cea2c9f54..1d6c48b52d 100644
--- a/environment.c
+++ b/environment.c
@@ -114,6 +114,7 @@ int protect_ntfs = PROTECT_NTFS_DEFAULT;
  * that is subject to stripspace.
  */
 const char *comment_line_str = "#";
+char *comment_line_str_to_free;
 int auto_comment_line_char;
 
 /* Parallel index stat data preload? */
diff --git a/environment.h b/environment.h
index e9f01d4d11..0148738ed6 100644
--- a/environment.h
+++ b/environment.h
@@ -9,6 +9,7 @@ struct strvec;
  * that is subject to stripspace.
  */
 extern const char *comment_line_str;
+extern char *comment_line_str_to_free;
 extern int auto_comment_line_char;
 
 /*
-- 
2.46.0.46.g406f326d27.dirty


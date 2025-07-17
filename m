Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD1F1DE3C3
	for <git@vger.kernel.org>; Thu, 17 Jul 2025 17:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752773497; cv=none; b=eSq4rxafdIFsnaJixKJ7nXvKcvkhFZlzj3RWvTGuQB60vYyrWJPCiKk/EaGGRo0wBaZSMzDkmmmuLdLUd15qbtBEuCUClKJx4aBXSa50vM19YGI5FPdWnvimdYkoKJHfQ4Fw5z8gjr8Juno28P3OxCowidIFCFcAlt4pLZV8skk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752773497; c=relaxed/simple;
	bh=1VGGEVq7rB1r4TJH7eqHeNjnTM3tlK0HAMNIe3D0F4Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pOst0jZhoMSfBDOISgdZ/rkdTQyPic90AIiCG6M0t7g/EhszcYLBtwKiQhHdyJaKSd6GCz+XIYm3Zzw8zgAfZCD66fqa7bCFZeiNVcgqkQpWF2KCDa1XNZbu/iikKk88dZdfO4EPG6re7nDhztHsCLiAvyeOKcx6IcSQWPFDLDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=hgMm1vJL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=k3zKcKD8; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="hgMm1vJL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="k3zKcKD8"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id E47441D00150;
	Thu, 17 Jul 2025 13:31:34 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Thu, 17 Jul 2025 13:31:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1752773494; x=1752859894; bh=ZHd6RsMjUH
	fX/iio959N1sSU+XLxZnpng3ohq92KLRw=; b=hgMm1vJLiuX97Iy3DKfwNWsXq2
	2YFokRyDHC1cMoVXf3hhRF2L1hHNHyeJ7XUWO8eDzpkxBrfR93Yox29pMsU3tY3Z
	G9Bt/dpDwyzcMmI2UN+bGBZ828lOrSb7qlt5hsoqcFCl81MZRKYMtXG+gs+M0Usx
	CnQbqc/JsjiMmy40xQC8acMyy56T61bPLEgqXGy2n7LTbKllNzAeqlIxxiQVKDLD
	4L7hxri0OkeXSoRRddu9BIlU/rGlRGj2qVFvyVMXFToV70+cKhATMLvm16vNpkxH
	OPiKW8eVt1yIUsf0CcqB0tMuHhjlUJVzIYQFIOWq3/q2VXrfiaM7TUSc+1mA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1752773494; x=1752859894; bh=ZHd6RsMjUHfX/iio959N1sSU+XLxZnpng3o
	hq92KLRw=; b=k3zKcKD8DUBBSa21GHCRo1bpIjtaxqBCMASgTW5zazYlQDwNXf/
	wPk++wenBwWbmi4/p4d6yTVYrrvAi3ciyeQBRf0Tgc1BHKh0GvL+WFweK+wUWJAG
	g+pr/ZiLX0LzKOi2AqTDLekKRf0LoBloOwPQJ42mjF06WMeETKXy9vi/6qN1BW3j
	GSCXjgrIEacXmc87TJ6E2YEv/axIxS+5ON5c6LkiPEiOE0E1qhBK8uU5UNr3Il5p
	igW7FHF+7V7aYhw/SkDS9k/Kwp5M3spyPPLGrM01YkzJ+p4s6qVjYFLb86APl0FT
	hKYpoI344/ATo4ufMAXgFyUuDHI+QX1BKYQ==
X-ME-Sender: <xms:djN5aGvP7vqt-GPkiu2BhMOrh-9RhLAKtyG1oRkRt2OJwF56AXKzhw>
    <xme:djN5aGCAltSVX7oKvjnoQysVrfv0scI4xge9Zt8NUFJATZlbEZCj0VHmn3HxnVmgt
    mxdFj9jdEaU9ttX3w>
X-ME-Received: <xmr:djN5aOX2Ci3hcy24I96X3rnPQGSjb78UDdnJA3cGrAMiIE1zyHFMZ7ZOisuTAsiTe7aMUDLfebpxxhSylmUtDWnSFNxQKXDW8pElAuw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeiuddulecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhithhsthgvrhesphhosg
    hogidrtghomh
X-ME-Proxy: <xmx:djN5aEAT2uVbWFFBLXHAKiZ-2KL-ds_8RrgQzRYya4u7WkhCRIDPZw>
    <xmx:djN5aB8AvFhjTNwIPbi_bzB5vFyuB0nimnJHwxXt0Gh_I2pzD29Y0Q>
    <xmx:djN5aLH6pjYpLsA-j894wg74bIj0C8FszkaCQHNGDHH6pPwIQH6k6g>
    <xmx:djN5aPOprP73ECoNz2b1GJ6yEYQfsJhJAZUxClw_dcFFOXl08JH2cg>
    <xmx:djN5aGfopCXidueforN-4qU35dgs_4xJwNb6BiZy86zh3LfXvPnbm5qD>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 17 Jul 2025 13:31:34 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>
Subject: Re: [PATCH] config: remove unneeded struct field
In-Reply-To: <31724ce432b19088b7c7643654788d8e712b3193.1752588042.git.phillip.wood@dunelm.org.uk>
	(Phillip Wood's message of "Tue, 15 Jul 2025 15:00:56 +0100")
References: <31724ce432b19088b7c7643654788d8e712b3193.1752588042.git.phillip.wood@dunelm.org.uk>
Date: Thu, 17 Jul 2025 10:31:32 -0700
Message-ID: <xmqqv7nq67wr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> I stumbled across this use-after-free while working on the deprecation
> of core.commentChar=auto.

And that other topic also adds more uses of "is kvi->path set?", so
we'd need a bit of semantic conflict resolution, which was fun ;-)

FYI, here is what I'd be using as merge-fix, a change that would be
squashed in when the named branch is merged in.

I expect that this part would change a lot anyway, to make it fail
when "auto" is used under WITH_BREAKING_CHANGES, so the conflict
resolution for the current/previous round may not matter all that
much.

--- >8 ---
Subject: [PATCH] merge-fix/pw/3.0-commentchar-auto-deprecation

Conflicts with pw/config-kvi-remove-path that removes kvi->path
field.  Checking if kvi->path is set should be done by inspecting
kvi->origin_type and seeing if it is CONFIG_ORIGIN_FILE instead, and
otherwise kvi->filename is usable when it is CONFIG_ORIGIN_FILE.
---
 builtin/commit.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index a513709a51..04440fbd3f 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -771,10 +771,10 @@ static int comment_char_config_cb(const char *key, const char *value,
 		return 0;
 
 	cfg->last_key_id = key_id;
-	if (!kvi->path) {
+	if (kvi->origin_type != CONFIG_ORIGIN_FILE) {
 		return 0;
-	} else if (get_comment_key_flags(cfg, kvi->path, key_id)) {
-		set_comment_key_flags(cfg, kvi->path, key_id, KEY_SEEN_TWICE);
+	} else if (get_comment_key_flags(cfg, kvi->filename, key_id)) {
+		set_comment_key_flags(cfg, kvi->filename, key_id, KEY_SEEN_TWICE);
 	} else {
 		struct comment_char_cfg_item *item;
 
@@ -782,8 +782,8 @@ static int comment_char_config_cb(const char *key, const char *value,
 		item = &cfg->item[cfg->nr - 1];
 		item->key_id = key_id;
 		item->scope = kvi->scope;
-		item->path = xstrdup(kvi->path);
-		set_comment_key_flags(cfg, kvi->path, key_id, KEY_SEEN_ONCE);
+		item->path = xstrdup(kvi->filename);
+		set_comment_key_flags(cfg, kvi->filename, key_id, KEY_SEEN_ONCE);
 	}
 	cfg->auto_set_in_file =	value && !strcmp(value, "auto");
 
-- 
2.50.1-441-gd7f68e2bd5


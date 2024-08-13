Received: from fout3-smtp.messagingengine.com (fout3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0960C18991A
	for <git@vger.kernel.org>; Tue, 13 Aug 2024 09:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723541493; cv=none; b=fS21eO/usGQNkFBtp/1rwQNFJc/7C1FTuJmlRjhfJ9xiCTRbbOER/2ebMkElWyFGCkaZu7xZ+WfLuAC+qXR3M4QribLkZ/huJRTVBwcUf3x6nfNjAfRBvbNNrmUip2b3yEu4AxMt1ZaC4NTJS85qBthENgWrRIhrpDKsEeEj00s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723541493; c=relaxed/simple;
	bh=JU+n7Yx3jSr8AyZIV6SJuxZrhmweAHgRqO0ZPi6qHDk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oGAb7COjAS5JayhNjviRAA3YIWSEU/H6e29JjbZeIzK9gIuy4fsjUZqZaDcXK6zHA8Nm5oq6WrEgs3CQZLsIicjgNKCf/En5ICarT+Lwp84NuVB+ye3P+WdyXXmDDxdxg1ihFCQeGpMIVYsIwGTlgSLBiWyQe5u66Y0bVL8DrBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=NEQ+GFgs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Tefj+3kn; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="NEQ+GFgs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Tefj+3kn"
Received: from phl-compute-03.internal (phl-compute-03.nyi.internal [10.202.2.43])
	by mailfout.nyi.internal (Postfix) with ESMTP id 4A1D4138FCF9;
	Tue, 13 Aug 2024 05:31:31 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 13 Aug 2024 05:31:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723541491; x=1723627891; bh=LakOwOwaVp
	c6934Z2Z9eCyYXy7OVRrlsGgNCDtQF08c=; b=NEQ+GFgsTGjPnAjfjf7QFqChG2
	r0W0YQQ9iAL3dnsTOnX28Q96zqSwL6UkXGjeWI5Hhn3SmrM7XtHPgFZiTPVdKHPf
	2OG0EidCQLzNAiuQD7aWVeNZupOCgo7URBO+XzX5DccQTZuDUEUC/aND5P91CG1S
	0lFlKYakBkmxGcouJagfOk7h/RbZguCW/OxzUzYsc/Fth0sGUMDSufJ6QOkuHf4A
	fpSN4uUrDtd/qgJuh6nd1x3NIISbOgO775qJ4ved+ZsNWcpiuFuMt63QwYyD+RCd
	IY9PVGP978HREhbpWeoI/cjN+JoXlgsRP/YSR4HirRj7wwLXFobuqmefcx4A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723541491; x=1723627891; bh=LakOwOwaVpc6934Z2Z9eCyYXy7OV
	RrlsGgNCDtQF08c=; b=Tefj+3kn47iMykTbMnfpIZFC2lJvyAZJc1A+yd4LKr2Z
	3radkIBD57+tttxh3MCXQlDjlzcAdPvkEhw3iTvKZN4WBhl2JGx39UW9s2jwpzas
	7gUpSRJvb/XZfYaZQfial5P/3ZNNIxyUES6jA3A0az25WgMmv8oLdDQVPpKFRgKa
	eEiTIjLK/v2sXRNaZNlHgaZLrWYKmhhyBrTciI69EMliOkTvKmGjZWpXwPX+q6Uc
	n69xuXriHNwHWUKpjqLoc734+1i1vS0a4+bTqt3oKQV/3PdiWSRcnFDIsEbJy1c1
	zldSy6APS0EGtuPFqH6+HgjqXWBbw9YIISzzg8Fk6w==
X-ME-Sender: <xms:8ye7ZrvVipsFjun-aev-UvHD1N_a2EdqP-7Wk1Js-wZdE2Cm0DqBQg>
    <xme:8ye7ZscefXAoE-smRMEL-cpgeD6BTZbf1qdKauU9MfD0O4swqfz-CPRqsG4EJ3dto
    vPvwSOOnA_Vo4Mk_A>
X-ME-Received: <xmr:8ye7Zuw8wTeKG06r58g6NW4VsVafaDkL2Kfl1SiU5wFy8IF2_ssqyhdl7C6J_oR9BuaHY9QPYOt4uXYGa4UBUPzV1Y46wtx78bXgoeVWRXocug>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtvddgudehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepfeenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhgrmhgvshesjhgrmhgvshhlihhurdhiohdprhgtph
    htthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepghhithhsthgvrhes
    phhosghogidrtghomhdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmh
    grihhlrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtgho
    mhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:8ye7ZqNkdnDv1hkV58Lps1jVXyMUts_VnqGV1h4W4a5xzVoHv3XDyA>
    <xmx:8ye7Zr8PW51MQYscczBu4FQk2A6Zmz3d4Pg3N28XiBO3d_RqATPbgQ>
    <xmx:8ye7ZqXq5XaavQK9AfzR-1e8xhdlBoxaR_kNmlW5bbPwJ-RMARi-Pg>
    <xmx:8ye7Zse3bgmHJ0uPcO_q4vrT8W7xqWyUPgLESNi0BpvQb4WfpltrvA>
    <xmx:8ye7ZrwfFTiwx5LP4rdvhSKsLNhHgjjpdIIZQ2e6NvDW69K0msngo-B8>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Aug 2024 05:31:29 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id ec16b4b5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 13 Aug 2024 09:31:13 +0000 (UTC)
Date: Tue, 13 Aug 2024 11:31:28 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: James Liu <james@jamesliu.io>, karthik nayak <karthik.188@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v3 08/22] config: fix leaking comment character config
Message-ID: <9054a459a1419e333ae8f950b9c9c2bf894c55f5.1723540931.git.ps@pks.im>
References: <cover.1722933642.git.ps@pks.im>
 <cover.1723540931.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1723540931.git.ps@pks.im>

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


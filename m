Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1568348C5C
	for <git@vger.kernel.org>; Fri, 17 Jul 2026 14:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784299932; cv=none; b=duBqseDRbU1JRkRH1BAC3E70waOmT9ty6USFAuFquuJLDOt1gy5HxOxXxYXh3rMAKXiQxPJkMGV/xy/keszwPg8ify072g5Dg6MSLQeXn+ppQ9zXjikWiAi6cmuRr5+go/iSxXjvVbPQAcqSNIfGP3TaX37RUIFgV8xJF+uHgCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784299932; c=relaxed/simple;
	bh=d95hKhpozzFmYV6Wlh/DeCyYfzm8ZJUy5Zjni0lti4Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iOyX14XRBzyp3Pmkpns/ebZ6ThEKj54ypbreK4/j0y6UMVDF+vUzJTYi/g2UnWhShhHQEHObCVTZcXw2s7XFEFWSpB7t1ER77fDeGgx03JkBmEL9kzgGkk/ZhgmTnHY57AijOL95H7qvryL2luxCJ9wrGrKGjkYS3RbO8ihDHRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=5ouma.me; spf=pass smtp.mailfrom=5ouma.me; dkim=pass (2048-bit key) header.d=5ouma.me header.i=@5ouma.me header.b=aIHNeHq3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hu4Vmf1/; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=5ouma.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=5ouma.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=5ouma.me header.i=@5ouma.me header.b="aIHNeHq3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hu4Vmf1/"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id A2155EC01AD;
	Fri, 17 Jul 2026 10:52:03 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Fri, 17 Jul 2026 10:52:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=5ouma.me; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1784299923; x=
	1784386323; bh=eGq4zwHlNbxpRQXP97uRh41HPERjaBu6niGCGOz71C0=; b=a
	IHNeHq3KQy6URHwKpwu5FrGHMVnnS01IdnteRh9+B+ceoVy+nYQti1ulSyMMi7Ep
	JjZRA8CBCdNQZrbD3+8hi6wIl9TOydQ/toUxZbHF9FgZHTP8NEUUzGWSV04S3ZPZ
	76OHbrTr8PccN2A/44Mo23T2eyYjeLXKUlSZB+CvZA/cNnDL6+NxwP/kaVK2zn84
	PBSrjMc65Czy8uypyCJpWlsrvBV9YNFyjFH13LsDlBzyNgrWh4mtSQ2pFMCYY7fS
	Ln7sBoUJF4cMdHPkE1gJTTBLFZghca8t41SXTU959jt38HiKy1d2cB4ZE3cahkeG
	utgOfuhrX2gdB6aTyCFSw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1784299923; x=1784386323; bh=e
	Gq4zwHlNbxpRQXP97uRh41HPERjaBu6niGCGOz71C0=; b=hu4Vmf1/lQlSfe7vk
	S7azWr8xWc7oaJeYsa0X4bq6SbCM9UCv0fsa2GfpdNEFmfGJg/wChz6bWGwUjNT5
	Efa43S8N0tKLOxICNCvNtJkVf74DoCwlLJ/zSCBpAY6M2z1u5Upb+GgQExyHcqYG
	g1MMuy6rRQJa8LEwmPT3oABzV42gCKPeZPS8gMje8LgSbXb59Vn1vb2pjT3KSGAu
	Pjcy6hn5OkY0yqXTPV/ZisBSVPbglC2I2TEgnFeGD6Uv4ZwgA1ieWskTG6TCw5wL
	gjn94iUrMbY71WpVZqLAZFmQkDvtxY/VDODSwBJ9+jud1DXT1qSGahsa0O1jEqjS
	tLq8g==
X-ME-Sender: <xms:k0Faaqlzou4bzQjRyf3_tF3ZQpq5qw6qqjlvv6Eji2U2mMFKY60Qqg>
    <xme:k0Faao3VDyDAVD0llE_wsSwctdGwGxLUdD2U9VWffJmz8MHpf5hOsqBotH9Xs3hJ-
    7lsWoZZsXIJ8EJqZBbXegVOeLlOVyggx0149dcl5XLJsa0LlgBbTkQ>
X-ME-Received: <xmr:k0FaatqogHLIJ-VTZ--7yjAX2iBHkGgCpxBL5k0-vJulZHXZzKmB-Pig-M8_2o_gewzs1p2aJ3aKlHSnSSM1f5LHZtxRmkfkmkUxm_esps03Cg>
X-ME-Proxy-Cause: dmFkZTGTNu7c2BC3q6kUOeI+OH/ahuNn6EHThkB1vk0dS7hte3EKY1gN4N92y560jrT+Ew
    DutcwCCDc3PEhr0x1jHi5sOpsDb8bb9YQJhewjjXTGPwoBY+ssin4OeTeUL6sJ7uBNKxEL
    7/WcG5vEBESqdwpWLQ76cDRz7bfxR1oiIqHRXndFNodl2t7ttBrXnvuEeSrM9aPTGNqnBg
    Ty6xfNTNhDpQzRMpMOfozCCHoYfH/CZ+GpFAHe0EcEj1NrJdF1+kNTvnLFaubpJV9qT8zc
    C+CI3pgXCYmReaqQAeNYkR97p1srzLAlBmzNPPAXnfpUTIK61E95I+luWT0iBDqgP33wjv
    Sivbnfgpd1Drh3TYuPUBtpVcqRW48DiPSaD/qIzc01SV96mRlnUT8Fg2UesCabZvTSwgD1
    nKwY1B7dIuDIY8INanQzdlc6vm2JrLUOhzdwKQgIZL8np2lZVQ33SuXcoAAclBIq2Uo+Hh
    J0V5sMPFe3fKrJN6Dv+hjA/ZnFAFD/M1I2xHIeSxIRsIAhAGu+976oeToJylt+559g+oii
    tTDesZO45m69cmimVjcfXIGqxUUuFQDwxiSFgDTUaZYAhFRpRta21JuLbGHZ+btlyw5bEu
    9BgaKEceCrlsS2A55KbJKhfK2aAYIqPosM3YBGFtop40iskHQsmYr3ETWZIw
X-ME-Proxy: <xmx:k0FaatfOk-bFHD2pC6snqgZNR1YQg4UNEFZOL_IKfLhvOFClfzEjyQ>
    <xmx:k0FaakpxOcbOJwtjqKvebnGXYFTZQmWs-Op33SKCnTvHBMlinDWsnA>
    <xmx:k0FaamEGDO1pFyPgG9CpYHbK2Robz97J4zwEgvKwSLFZEAaolwwwkg>
    <xmx:k0FaasvwMEPBivQOqOaFouCQw26diCkrLTePsmFd_aJyZy2y8TbVKQ>
    <xmx:k0FaakSStbPUCrtpm1QiN9SpwyokXSESkMwES1S4VhrxInavYaqnHXc9>
Feedback-ID: i4b264863:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Jul 2026 10:52:00 -0400 (EDT)
From: Souma <git@5ouma.me>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	ps@pks.im,
	Souma <git@5ouma.me>
Subject: [PATCH v2 1/2] replay: allow callers to sign commits
Date: Fri, 17 Jul 2026 14:51:41 +0000
Message-ID: <20260717145142.39478-2-git@5ouma.me>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260703145037.69832-1-git@5ouma.me>
References: <20260703145037.69832-1-git@5ouma.me>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The replay machinery creates commits directly through
`commit_tree_extended()`, but callers cannot currently request
signatures. Commands that replay rewritten history consequently cannot
carry their signing policy through to descendant commits.

Add `sign_commit` to `replay_revisions_options` and thread it through
commit creation. `NULL` preserves the existing unsigned behavior, an
empty string selects the default signing key, and a non-empty string
selects an explicit key. Existing callers zero-initialize the options
structure, so their behavior is unchanged.

Signed-off-by: Souma <git@5ouma.me>
---
 replay.c | 13 ++++++++-----
 replay.h |  6 ++++++
 2 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/replay.c b/replay.c
index aac9178875..19a6402bf0 100644
--- a/replay.c
+++ b/replay.c
@@ -81,13 +81,13 @@ static struct commit *create_commit(struct repository *repo,
 				    struct tree *tree,
 				    struct commit *based_on,
 				    struct commit *parent,
-				    enum replay_mode mode)
+				    enum replay_mode mode,
+				    const char *sign_commit)
 {
 	struct object_id ret;
 	struct object *obj = NULL;
 	struct commit_list *parents = NULL;
 	char *author = NULL;
-	char *sign_commit = NULL; /* FIXME: cli users might want to sign again */
 	struct commit_extra_header *extra = NULL;
 	struct strbuf msg = STRBUF_INIT;
 	const char *out_enc = get_commit_output_encoding();
@@ -270,7 +270,8 @@ static struct commit *pick_regular_commit(struct repository *repo,
 					  struct merge_options *merge_opt,
 					  struct merge_result *result,
 					  enum replay_mode mode,
-					  enum replay_empty_commit_action empty)
+					  enum replay_empty_commit_action empty,
+					  const char *sign_commit)
 {
 	struct commit *base, *replayed_base;
 	struct tree *pickme_tree, *base_tree, *replayed_base_tree;
@@ -341,7 +342,8 @@ static struct commit *pick_regular_commit(struct repository *repo,
 		}
 	}
 
-	return create_commit(repo, result->tree, pickme, replayed_base, mode);
+	return create_commit(repo, result->tree, pickme, replayed_base, mode,
+			     sign_commit);
 }
 
 void replay_result_release(struct replay_result *result)
@@ -431,7 +433,8 @@ int replay_revisions(struct rev_info *revs,
 
 		last_commit = pick_regular_commit(revs->repo, commit, replayed_commits,
 						  mode == REPLAY_MODE_REVERT ? last_commit : onto,
-						  &merge_opt, &result, mode, opts->empty);
+						  &merge_opt, &result, mode, opts->empty,
+						  opts->sign_commit);
 		if (!last_commit)
 			break;
 
diff --git a/replay.h b/replay.h
index 491db145e3..6ed0608911 100644
--- a/replay.h
+++ b/replay.h
@@ -57,6 +57,12 @@ struct replay_revisions_options {
 	 */
 	int contained;
 
+	/*
+	 * Key used to sign newly-created commits. An empty string requests the
+	 * default configured signing key, and NULL disables signing.
+	 */
+	const char *sign_commit;
+
 	/*
 	 * Controls what to do when a replayed commit becomes empty.
 	 * Defaults to REPLAY_EMPTY_COMMIT_DROP.
-- 
2.55.0


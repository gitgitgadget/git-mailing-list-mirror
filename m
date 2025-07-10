Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB5FE27145D
	for <git@vger.kernel.org>; Thu, 10 Jul 2025 18:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752172639; cv=none; b=LICTTYdY57o6lytzrR+xtuRgLcMEHxiU4fwe4IilF01bC/H4VV105F64rsLv/rwX9nqDWrVF1ROZBwHRAiUh8FHC2Q4XOyvfTQGkiPV15vPuYTfLLTYNn5ZHz7lKUTvx3JIdJq5a8WK3fiJbVvvDXGQLYtlgMJjIceuVAbRXUkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752172639; c=relaxed/simple;
	bh=yXYKaPTkzjNHLVRUIKSOLsS+BHl8zISOzrHbYjpj9dI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pBSi2cRBTVRxSJm1PG0KbR9I23fkbrBmFp4ZUIjG6OjjGi05RkaOQ1efHjtdZdBpsoQU23e5oEt5QATeC/yDjLorqs4BmRH6skkz5E0grha47GJF0cfaZfAJO477S7WwWZ7WvejlzQL95qjWnp7bT8viZvU7G5AetlWHpCfpyNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=nnRdZ4TX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fCDVm4dA; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="nnRdZ4TX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fCDVm4dA"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A9E537A0162;
	Thu, 10 Jul 2025 14:37:15 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Thu, 10 Jul 2025 14:37:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1752172635; x=1752259035; bh=w38EtcJDYl
	g5C3kVjz0BdHGhZWwDYIkUFz2mnQAKA4Y=; b=nnRdZ4TX7hlUOcyERO9ITR2ZUI
	9UeecwWF03C7DlxhD6lNaBn8HpBFr+HaggktgtGZQD6BE07oHZBuUVobXG6wAM9p
	hdKY920YWFGviSJNCv0bRxAo1Ty58PLI3u14AN9ZAd+j3vMfmEfR08rmj0ZVb7mo
	rIKQqHuJ7VD90hFbqCEwDTuB6hkGI5QnKBAs2bttKA1yPUEIhEDHIlKdjg2vt0jY
	PpuDNI6dteoK8FZHehJtburiXM+SbtXEKmnwBgA+RVe5qykFjeerCNyJzw4qOL4/
	TZb/nsL+BugkHf+zygqLF726cg/K2L7h3WsXIDPHMPJgyhZSRpHMzuC+0zgA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1752172635; x=1752259035; bh=w38EtcJDYlg5C3kVjz0BdHGhZWwDYIkUFz2
	mnQAKA4Y=; b=fCDVm4dA/UtiJWmgIfON5Rl/H2X9dBXYr1l0zwf4Tt8AYng2L98
	8LzcAwXWFkYjbRn4378SBOjdIziYfUyRd0LWgsa4lf7pYGWuwGgTGMlZrXKOibYy
	nMZqcPBsnAMKQlNYCKN4W+PNUZ9lJl2zMzatp+2S/qv+LuvOR+6fOHj7sCzvfp8S
	GaS2n23XuQfbMiz/Ko8zHuMZho7/fqOawobAHMxEm1dOxGdgGWJ9awy8ecYnB+4W
	DRG/yu55juZaNt35MXRvvh1xk5b0NGfa7+nn5sh+Xyp8kjhODiQjPy9oVBMzYEBl
	+B+KWNerV9e9FXVjLGrP1xQkpi/6BtFVc7A==
X-ME-Sender: <xms:WwhwaNPTPjCAQ009qZ5Xsj4FdlJLUimfogEo7fXzYNx_hGB_Rim2AQ>
    <xme:WwhwaNie1yiLGwMDroCUjV1wqjK7mIjCiWAFZonrzIFfH9xUJqfB72J0LTpkE20yt
    kcNvbihDEV-T7ArTA>
X-ME-Received: <xmr:WwhwaCsgVGprZeyBzTaffuav18oIpQS7WAbrjbCJjarZbPz5G315P0dmf0gIAbS6j2Sna24X9lFtxiuL1mhfsZMjBXzwLvV0V4nnbVw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeguddujecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehtohhonhesihhothgtlhdrtghomhdprhgtphhtthhope
    ihlhguhhhomhgvvdguvdesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgsh
    gsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepshhtohhlvggvsehgmhgr
    ihhlrdgtohhmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtth
    hopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:WwhwaLQoERQMPeQp17KzsGM9_UO5kZRrLXyt1kfgirEETa6VU5fzqg>
    <xmx:WwhwaG1sHeb7_ICiQumt4P1aAz0nD0IGc5pUSuYJD_E0BkRInQE8yA>
    <xmx:WwhwaAt0R1g3kGz33o5BkZXkcLA6-v97LMAAjeyMl2X8FqkslkVE5Q>
    <xmx:WwhwaMhFO9vifVNPoZeyI6CRs5Nrb702AUikYaCcigOO32f1gSUJRQ>
    <xmx:WwhwaPQLvl7Qaqcb7jgl_WO47Zj_BNAG4Fg1sAOzXi817Dxzo7AjhZG4>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 10 Jul 2025 14:37:14 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Toon Claes <toon@iotcl.com>
Cc: Lidong Yan <yldhome2d2@gmail.com>,  git@vger.kernel.org,  Kristoffer
 Haugsbakk <kristofferhaugsbakk@fastmail.com>,  "Derrick Stolee"
 <stolee@gmail.com>,  "Taylor Blau" <me@ttaylorr.com>
Subject: Re: [PATCH v4 0/3] Introduce git-last-modified(1) command
In-Reply-To: <xmqqldoxauyk.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
	09 Jul 2025 14:57:23 -0700")
References: <20250630-toon-new-blame-tree-v3-0-3516025dc3bc@iotcl.com>
	<20250709152628.1644521-1-toon@iotcl.com> <xmqqldoxauyk.fsf@gitster.g>
Date: Thu, 10 Jul 2025 11:37:13 -0700
Message-ID: <xmqq8qkv7uzq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> Toon Claes <toon@iotcl.com> writes:
>
>> This series adds the git-last-modified(1) subcommand. In the past the
>> subcommand was proposed[1] to be named git-blame-tree(1). This version
>> is based on the patches shared by the kind people at GitHub[2].
>
> You do not have to deal with it just yet, but FYI, another topic in
> flight renames away a few bloom API functions that this topic adds
> more callers of.
>
> If this topic needs to be rerolled after the other topic graduates
> to 'master', we may need to see this topic rebased on a newer
> 'master' with something like the attached patch squashed in, but
> because the other topic is not close to 'next' yet, let's keep these
> two topics independent from each other as long as possible, and let
> me deal with this trivial semantic conflict resolution, at least for
> now.
>
> Thanks.

The situation wrt what you need to do hasn't changed, but the other
topic reshuffled the order of parameters for a few API functions.
The result does make more sense to have the key structure as the
first parameter, but a fallout is that the way the new calls added
by this series are massaged to fit the new world order needs to be
updated.

Again, just FYI, if you ended up needing to rebase your topic on top
of the other one, the following would become necessary.

 builtin/last-modified.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/last-modified.c b/builtin/last-modified.c
index 466df04fba..70e1e14f21 100644
--- a/builtin/last-modified.c
+++ b/builtin/last-modified.c
@@ -47,7 +47,7 @@ static void last_modified_release(struct last_modified *lm)
 	struct last_modified_entry *ent;
 
 	hashmap_for_each_entry(&lm->paths, &iter, ent, hashent)
-		clear_bloom_key(&ent->key);
+		bloom_key_clear(&ent->key);
 
 	hashmap_clear_and_free(&lm->paths, struct last_modified_entry, hashent);
 	release_revisions(&lm->rev);
@@ -77,7 +77,7 @@ static void add_path_from_diff(struct diff_queue_struct *q,
 		FLEX_ALLOC_STR(ent, path, path);
 		oidcpy(&ent->oid, &p->two->oid);
 		if (lm->rev.bloom_filter_settings)
-			fill_bloom_key(path, strlen(path), &ent->key,
+			bloom_key_fill(&ent->key, path, strlen(path),
 				       lm->rev.bloom_filter_settings);
 		hashmap_entry_init(&ent->hashent, strhash(ent->path));
 		hashmap_add(&lm->paths, &ent->hashent);
@@ -138,7 +138,7 @@ static void mark_path(const char *path, const struct object_id *oid,
 		data->callback(path, data->commit, data->callback_data);
 
 	hashmap_remove(data->paths, &ent->hashent, path);
-	clear_bloom_key(&ent->key);
+	bloom_key_clear(&ent->key);
 	free(ent);
 }
 
-- 
2.50.1-394-g0a41f16de2


Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FAC33128B6
	for <git@vger.kernel.org>; Fri,  3 Jul 2026 20:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783110535; cv=none; b=UA/NRT7t+vQ1LBXtulr08G4qFTQGYy0PmZzpy7rMXXyUY/NsuIK/5d9mPwVRlcVk8d7tgb72gM/mcBxeu7M6KL1PpdctnyiM1tPMMzzB35Yjs72ZZOAozm9HUqM0OpEnQvMLpdTtOzioN+FMfYOv8HrrcSlCOH2rB8mCNk6DVzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783110535; c=relaxed/simple;
	bh=KHvAUGhZS2pllU08SewyPdSKfF8Pk1wHBuTnsTjPFxs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KNrJMOcJZ2qMTXj5XXufwGHzpE0tDDjIrBcfDdV99evNLYj0QZEUmtnjZqbKj1jPZ5p89TxFbPxRf9efchHSu9P8Lxrpj70JJkNFhGFgfilsQgeuCCb3n3gVPOmtydvef0SEclkx6hX1WnSjyXm23ClK16ArzOB06MSZBogZQRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=vqiXUkC0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=D9q7pmip; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="vqiXUkC0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="D9q7pmip"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id DDC031D00054;
	Fri,  3 Jul 2026 16:28:52 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Fri, 03 Jul 2026 16:28:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1783110532; x=1783196932; bh=KuihF1lrCL
	sFu0UcNR7zKqwwzyUJXf2u5XYtv4JMoho=; b=vqiXUkC0cXnWZlfwcDJJyZDQhQ
	asjd25t+xtoETH+g3IWSQaH6gcscpRhExx/qUwFzK0k6qOysKGa1YxeiOf62Cj7P
	klas8Yqwsn3W07KjtTCa8F8keQDD8fR7GIZMelPi/NhkQDwyEg8u9/SFwk6p0jSg
	OnJX29txCAph5v+YSevV20dGMO1j5uVDXCvjYHfE01jIUi5VliqNMb7qNINPOxO0
	3iK6TDOK1uzJ0jd/9ZBdITqyhP0JIxLD3rMaqyUkJRD8WbEIb7eSj0RQjN+o5irJ
	muoIus1mC2r4MuztfqN+Y/hTxGOttB8XDYGodeVZQVQO1wI/wIv6HCIqRtBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783110532; x=1783196932; bh=KuihF1lrCLsFu0UcNR7zKqwwzyUJXf2u5XY
	tv4JMoho=; b=D9q7pmip127NC+0Br/euOkE3d/bX/98kNo6HY35l4bE6QlIrBVT
	roBO2Txfr1iT5MxmXoXOzKjjQSU79ckpaSmEc6QqOyMgI3pwoSPiF5b8ACbHk4kE
	4vzHvRXclaCjAbblTzEy1a/jTPED8chtm72n5ST5a6a4mfmKDIYa74xWWgb+srYx
	rK7TwZoG6o9T+TSNHYaiST4IIecdx25ywpNgyTIJh3wzPIgMoyBOC2f3FnzAZCOB
	xsG8YOpw2JrhdEBJB4uyZghKn+V2YmL3gO9GVWco+Gp1giVisrRYMGUae4Vp0/GR
	nsgg0L32fV7OiowwLHC4yRWapJkmyv/p1TQ==
X-ME-Sender: <xms:hBtIajPXMNLyAupbYzgzI-1AVoXyi3CAMs5pHvQeVH-qV4DH9XoE1A>
    <xme:hBtIaryAR9bKUDUOBFXRDjoO6P8dq3D40od0g3ymqfhtJV2vw_XSkGtkJ1CYEo9xJ
    URXN2uDw8uun9WphuSpn2wUbtBLBpeYj9nV92SWtvw4B92qGbYOjg>
X-ME-Received: <xmr:hBtIasvtq9weFgIIW5r65wyWVDKjEdDfliy-yiq1MSI8sXmKY9YGurxkhWuZ6MEr854IxNQyPP79zzG2cHMVQVc4xbgMKr1qh9MLu64>
X-ME-Proxy-Cause: dmFkZTE09g2NMSNFyBH7mNFmWVZnED7T3VNHvPI7vTiKdFjnDpl59D0oNBhl8nnIE5vfjs
    HlmpPLJVMRTowetT8Qm0pXi7lxuY7+/x9tCovQlwLqjvaK9OAV0UPAhXeVJUF8bj2OV97Z
    lmdikY+tmLQyy694KaoAydMMyMSTTcLqxx1/ALRrFvawtYk4W7xQ7cX1izFGcDWPNUOX4x
    NDeWCpHvboficcSSPgAzOCk6zjS+ZQKnocns6InplfBYIbhXBLjfSDEfmiG7bFRC9Hc4Vs
    1givgu71QO0F/JShf5l1mjx3gKjhiF07TAbiLePPeWqJ0grgrr2VdjnstkAiz1CZGRfnAn
    5tcOhqnk2ilKA3ea5rqMo5wz8K9bNYJwps1w1+SPoRyIhDaZYv+OGQ6gwtO6ZsGwGm+7ki
    lXF+MeRpjhr+/ZiEH78mICvZBs7wo9GJOVqZxNtx18gOiEl1vc9GE31rkRE0QoCToNIcGP
    R98gwSh3mNPsSZL6bbbNJsUdG3wbXXYgIGdGD7bZiYZ+B1k1ibeBNl941QnD1ky3NtKIWa
    uNJ9W8icuggHlWdPE3bkXHCtGqSjLfyEAsP7fPnqf6KsweBjrb2jf0NlwD2qsonEJFEa+g
    wm3j94Hmm5Jrx9wr6FMRAA0TwXS0le5j5Jv2uTtufjAImjWSe0GhYRySTQqQ
X-ME-Proxy: <xmx:hBtIak7vkvxJoZt4aSO3CNPHcYJbT_Pe4-bGbWVffvrO6_-iLDup_g>
    <xmx:hBtIarQLY1UpuQJmly66GgLTJbNnhxG63TuPNNXRYpgfbgGGrHcLgg>
    <xmx:hBtIajqazFR16F4IwFDMvvqawTF2rcpro0auSlp36TrX4QIli1jGfw>
    <xmx:hBtIapJZOArt1mU8V87cFC2EyGGNqMLfAqJIV7WCAGcfnMw9NW_0tg>
    <xmx:hBtIagZS_kHy3LBthF4krMXCCsi3YTU3a0G3Iq6FyxHuQbGxqTVJnoQH>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 Jul 2026 16:28:51 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Michael Hore <Michael.Hore@asic.gov.au>
Cc: Jerry Zhang <jerry@skydio.com>,
    "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Bug report - git rev-list --exclude-first-parent-only
 [SEC=UNOFFICIAL]
In-Reply-To: <ME2PR01MB5490E3CE825C83474D1573CED1F52@ME2PR01MB5490.ausprd01.prod.outlook.com>
	(Michael Hore's message of "Thu, 2 Jul 2026 03:59:04 +0000")
References: <ME2PR01MB5490E3CE825C83474D1573CED1F52@ME2PR01MB5490.ausprd01.prod.outlook.com>
Date: Fri, 03 Jul 2026 13:28:50 -0700
Message-ID: <xmqqbjcnizr1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Michael Hore <Michael.Hore@asic.gov.au> writes:

> I believe I have found a bug -
>
> My repo has a commit structure like
>
> R2
> |\
> | F
> |/
> R1
>
> i.e.
>  - there is a merge commit R2 with parents R1 and F
>  - the parent of F is R1

IOW, R2 is a useless merge that could have been a simple
fast-forward directly to F.

> I ran "git rev-list --exclude-first-parent-only F ^R2"
>
> it gave the expected result: "F"
>
> I ran "git rev-list --exclude-first-parent-only F R1 ^R2"
>
> I expected the same result, but I got an unexpected result - nothing at all

This seems to have come from 9d505b7b49 (git-rev-list: add
--exclude-first-parent-only flag, 2022-01-11).  I do not know if the
original author is still around, but it would have been nicer to ask
for input from them (cc'ed).

A fix could be something along this line, but I've never used this
feature even once (I instead use Michael Haggerty's exellent "git
when-merged" thing), so I may very well be breaking _other_ use
cases this feature was originally intended for without knowing.

The patched part is inside a huge "while (parent)" loop.  The idea
is to break out before the loop goes on to smudge later parents when
we are in the "smudge only first parent as uninteresting, without
contaminating the history leading to other parents" mode.

 revision.c                   | 10 ++++++++--
 t/t6012-rev-list-simplify.sh | 18 ++++++++++++++++++
 2 files changed, 26 insertions(+), 2 deletions(-)

diff --git c/revision.c w/revision.c
index e91d7e1f11..1f50d42a7a 100644
--- c/revision.c
+++ w/revision.c
@@ -1151,12 +1151,18 @@ static int process_parents(struct rev_info *revs, struct commit *commit,
 			if (p)
 				p->object.flags |= UNINTERESTING |
 						   CHILD_VISITED;
-			if (repo_parse_commit_gently(revs->repo, p, 1) < 0)
+			if (repo_parse_commit_gently(revs->repo, p, 1) < 0) {
+				if (revs->exclude_first_parent_only)
+					break;
 				continue;
+			}
 			if (p->parents)
 				mark_parents_uninteresting(revs, p);
-			if (p->object.flags & SEEN)
+			if (p->object.flags & SEEN) {
+				if (revs->exclude_first_parent_only)
+					break;
 				continue;
+			}
 			p->object.flags |= (SEEN | NOT_USER_GIVEN);
 			if (queue)
 				prio_queue_put(queue, p);
diff --git c/t/t6012-rev-list-simplify.sh w/t/t6012-rev-list-simplify.sh
index 4cecb6224c..2284bbba12 100755
--- c/t/t6012-rev-list-simplify.sh
+++ w/t/t6012-rev-list-simplify.sh
@@ -285,4 +285,22 @@ test_expect_success 'log --graph --simplify-merges --show-pulls' '
 	test_cmp expect actual
 '
 
+test_expect_success 'exclude-first-parent-only with parent already seen' '
+	git checkout --orphan test-seen &&
+	git rm -rf . &&
+	test_commit r1 &&
+	git checkout -b branch-f &&
+	test_commit f &&
+	git checkout test-seen &&
+	git merge --no-ff --no-edit -m r2 branch-f &&
+	git tag r2 &&
+
+	git rev-list --exclude-first-parent-only f ^r2 >actual &&
+	git rev-parse f >expect &&
+	test_cmp expect actual &&
+
+	git rev-list --exclude-first-parent-only f r1 ^r2 >actual2 &&
+	test_cmp expect actual2
+'
+
 test_done


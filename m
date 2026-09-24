Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 850344DF4AD
	for <git@vger.kernel.org>; Thu, 24 Sep 2026 21:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790287161; cv=none; b=Z5MOpA0CbU+s+cCNezmDEzuWmcdWQ1Uc7Q7BHzC6uSZI+CKS45yld5nEUu66znaEe0/0T9wHsnrXqgOrH6qbjogronmXuf2fHbUMKmcTyn8O/BzIO8o/HsKxRL+ZRON2QG/0IkIUQGxBEQdnqJHp0+RuxtXu9P/hjKckw67PK1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790287161; c=relaxed/simple;
	bh=BIFLkVYtpku/Gjs78RW02LMw7i+YV/k7+nQh4JBpTBU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UHFLPmyOhOzxSxDgbK6FIDRER9SGQGbhKJeZOtVuSL+MQ4NrzL7f9j0k0cKE+1m4LBSOuETle4dcrEFy4KBjFax170X2hO0EvOi2gsRcs4LKPMRUBarNxAjr07SAwzPSpuAI1LpX3aDko7g5bt6GiWlQ8LlHInsHAeQYHyLKvCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=L0Lvuzae; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KHMDG8m1; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="L0Lvuzae";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KHMDG8m1"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 5B3D2EC0181;
	Thu, 24 Sep 2026 17:59:17 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Thu, 24 Sep 2026 17:59:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1790287157; x=1790373557; bh=jLAzn70qiw
	KoAHaGh4+LsPze7dnKQeUfin0/HoEWYQ0=; b=L0LvuzaeJtM1lEZe5a2tqcn7j3
	cemrTNtTzVAHlSmUrwioBGa6cB4XRNjnfsDI+nnSR7YcoZI9O3/Zr44c68QyXdzI
	p9CqAAts6DugRPfYbVUgUD8S6PBnVfOZRurqXk3t1X8ZBQfWthHTVHswPiDrG7w0
	gpeQCH5x4GVp6gMRbI8s8GSt8lwSLJzCkzTabkPGV7pYxMSpWcQx26PGhA9EP2/g
	D/O/8LtjK3pqVaxQNWZdjuoZJ3NhWxGECZY62Ixp9cSgPxIVMb5/THkbU/oQt5Sq
	DCETuCXijejJW3iFeBxRjLw/U1JaukZrWy/MgqDRrcs2aK22SVIinMoODMVQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790287157; x=1790373557; bh=jLAzn70qiwKoAHaGh4+LsPze7dnKQeUfin0
	/HoEWYQ0=; b=KHMDG8m1NVm1W0OA6ddNPPbwoBoRzyOE05zLNCNti/g1/HiOfs9
	GPSYUF4tbNPAxtYbyLX1KGgK4kiKpeb7ByZOXW3Z+Jnoc6NJWVOAS8ZVFY8DxXlf
	GbOW/quJDyfEYVlK8XZW9q1k16geFGSZI9l0/27EUNj/pHCqf++o56M51rx/F0GW
	XPSikgXuGmSoVJHWDBZNeOxYQmNcCtM8d9aa/ktVDnDsDCFXV2yABtaYM6L5lA5W
	kaPRtrmArm42N/kYPQa2lOGSUySFCkXWwBABNUJWRXOW9857puAQJvrxCtjJj+GO
	6aiU5rl1BhP28R667hmi2DFj4pjjw5DHuAg==
X-ME-Sender: <xms:NJ21araUFqeNwxzb4r2aBCZJaSQciDw8WIifGlEFoN6Tc0-kFm83YA>
    <xme:NJ21ag51br-XJrJq8CPfs5xka2XqmQH_6mOpRY9hwGn0bASvqh-RnjuxwQEqA68IW
    dXDHHdx3OM6Y177addK3Cuf7Eu-yQL4GZZ7cgrKm1F65JkhYHe05Bs>
X-ME-Received: <xmr:NJ21ar91BGUQ2QU8C9khNZHUj1DJsuTcsUemDUxShENq5NhtQx4mj_e42jvtxV1Ft5h413Yj9_9sVbLf-2CLEXPqlNhpsuwOElsl>
X-ME-Proxy-Cause: dmFkZTGVWSe0hUi/wHht+d0/H/SAdRMFy8/l8UpuTJPx4Hc4tlJmWPvnPAD/YRFZMkrXlz
    /BbJy6FUx0SAVIJJ0K7hLqxxNGqbTo+qA8kVZ92gmzT9tvgDKBEWb2ZbWoKUe6bcAliRid
    M3KmOhDmXWkX2RgLqOxZoyP0Q3W8/uIy6Lc4lsMopWYmB815H44iOaQHU2Pa4LZ34tSaGG
    CAYu0MAe5PEDSu62FxZS7J7lk0ADVjwtXqcbSDE1X7ym3hd+5RZFygZ8NzwY87T1s3tH4C
    Cqh+vV44Kx/7FJZx2O6rjh4MUCEwboS8qFqGlDvctKMtyl6ZNzfECH2VhP9O3TsQuGK0W9
    ZDLnkt5FlV0CgWYWQKlxLDDRiHAkrWaEYCRgyy17JVSRTDLybKQ3Lx7pRVYmdHwi7czCIz
    PPQsNVQ1ii7km3SiqTLLmuZOzctDfnie/IBlhKqYR5YQxDHIJFvps5reoV7J/Dn+OZLZEj
    u4MKJi6k8CWT36dRxt0M3htX7jvHMtSPBcI5Lq8p4q46iL0ahO4N5S6NvQQMY2KDO6bVCX
    9dsicXkB0Eh0b99WrasA+qL9mOEQKNsBqXTW6t/OkTTgQgvczNBGzseHOkWkNif0rT0O+7
    +FVvDUWZXsKfPEUQ61GXognbU9Yqtm9On/H6gawya25HyMMSvkQXbBmj8gVQ
X-ME-Proxy: <xmx:NJ21akYIbkAr-9B1FQ9rbFjsx0BuTTzj3PIZXz73iWdQq4-C3lLCMA>
    <xmx:NJ21as5MvhhSWk90H0RZPjndIyVIR_UbAX9LSW6cXhhRWyFWee05GQ>
    <xmx:NJ21ahm7tZEw81bYotNP7gG9sUoy7-PIGQ4aOPkaiEBdOkdZWdl16g>
    <xmx:NJ21akFt_EA6eaiif-6O34Yv2tUooKN13Sx-OcF8Ze-b7zneDAc-gw>
    <xmx:NZ21agRftAjBKrqqJlNsqMhQtNrhdMMlw_F72o6xQc1YGDaEjK3s0BqQ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Sep 2026 17:59:16 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: git@vger.kernel.org,  Eli Barzilay <eli@barzilay.org>,  Phillip Wood
 <phillip.wood@dunelm.org.uk>,  Johannes Schindelin
 <Johannes.Schindelin@gmx.de>,  Patrick Steinhardt <ps@pks.im>,  Elijah
 Newren <newren@gmail.com>,  Adam Johnson <me@adamj.eu>,  Victoria Dye
 <vdye@github.com>,  Jeff King <peff@peff.net>,  Derrick Stolee
 <stolee@gmail.com>,  =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason
 <avarab@gmail.com>
Subject: Re: [PATCH v2 4/4] builtin/stash: merge index in-core
In-Reply-To: <e49936ee12aaf5d82a98dddcc618cee01ac3c681.1790168285.git.ben.knoble@gmail.com>
	(D. Ben Knoble's message of "Wed, 23 Sep 2026 08:58:07 -0400")
References: <cover.1789853192.git.ben.knoble@gmail.com>
	<cover.1790168285.git.ben.knoble@gmail.com>
	<e49936ee12aaf5d82a98dddcc618cee01ac3c681.1790168285.git.ben.knoble@gmail.com>
Date: Thu, 24 Sep 2026 14:59:15 -0700
Message-ID: <xmqqse2yz4y4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"D. Ben Knoble" <ben.knoble@gmail.com> writes:

> @@ -671,29 +627,27 @@ static enum stash_apply_result do_apply_stash(const char *prefix,
>  		    oideq(&c_tree, &info->i_tree)) {
>  			has_index = 0;
>  		} else {
> -			struct strbuf out = STRBUF_INIT;
> +			struct merge_result result = { 0 };
>  
> -			if (diff_tree_binary(&out, &info->w_commit)) {
> -				strbuf_release(&out);
> -				return error(_("could not generate diff %s^!."),
> -					     oid_to_hex(&info->w_commit));
> -			}
> +			o.branch1 = "Upstream index";
> +			o.branch2 = "Stashed index changes";
> +			o.ancestor = "Stash base";
>  
> -			ret = apply_cached(&out);
> -			strbuf_release(&out);
> -			if (ret)

So, we used to take a diff between w_commit^2^ and w_commit^2 and
then give the resulting patch to "apply --cached".  w_commit is the
working tree state, w_commit^1 is the HEAD (i.e. b_tree) when the
stash was created (i.e., "diff HEAD w_commit" is the change in the
working tree), w_commit^2 is the contents of the index
(i.e. i_tree), so we are computing a patch that represents what
"diff --cached HEAD" would have shown when we created the stash.
And the goal is to reflect this change on the current HEAD to
recreate the "staged" changes in the current index.

IOW, we want to three-way merge the change that moves you from 
b_tree to i_tree into c_tree.

> +			o.verbosity = 0;
> +
> +			head = lookup_tree(o.repo, &c_tree);
> +			merge = lookup_tree(o.repo, &info->i_tree);
> +			merge_base = lookup_tree(o.repo, &info->b_tree);
> +
> +			merge_incore_nonrecursive(&o, head, merge, merge_base,
> +						  &result);

We are using the merge machinery to perform a cherry-pick of the
changes to go from b_tree to i_tree into c_tree.  but the three
trees involved in this cherry-pick is named unnecessarily
confusingly.

merge-incore-nonrecursive() takes the common ancestor ("merge_base")
and two sides ("side1" and "side2") in this order.  It takes the
changes to go from common to side1 and computes the result of
updating the remainder (side2) with such a change (or vice versa; a
merge is symmetric).  When cherry-picking, the first tree would be
the b_tree, the second tree would be the i_tree, and the target tree
would be the c_tree.

 - b_tree serves as merge_base
 - i_tree serves as side1
 - c_tree serves as side2

Am I following what the code should be doing correctly?

I am wondering if the order of the tree trees in the
merge_incore_nonrecursive() call is correct.  Shouldn't it be

			merge_incore_nonrecursive(&o,
						  merge_base, merge, head,
						  &result);

(or merge and head swapped) if we want to update head (I would call
it side2) in such a way that the change to go from it to the
resulting tree is similar to the change between merge_base (b_tree)
and merge (i_tree)?

Ahh, or perhaps the trees are indeed given in a wrong order, but not
in a random wrong order.  merge_ort_nonrecursive(), which is *not*
the function you are using, takes head, merge, and merge_base in
this order, and that order matches what you wrote.

Perhaps the true culprit in this confusion is that the order in
which merge_ort_nonrecursive() takes its three trees (head, merge,
and common) and the order in which merge_incore_nonrecursive() takes
its trees (merge_base, side1, and side2) are different, and if we
fix them to match, it would make it easier to work with?

The new test in the attached patch will fail with this step but if
we revert the changes to builtin/stash.c in this step, it passes.

 t/t3903-stash.sh | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git c/t/t3903-stash.sh w/t/t3903-stash.sh
index 3958ab3c8d..0a87e62b11 100755
--- c/t/t3903-stash.sh
+++ w/t/t3903-stash.sh
@@ -374,6 +374,38 @@ test_expect_success 'stash apply -q --index refreshes the index' '
 	test_cmp expect actual
 '
 
+
+test_expect_success 'stash apply --index does not revert unrelated upstream index changes' '
+	test_when_finished "rm -fr playpen" &&
+	mkdir playpen &&
+	(
+		cd playpen &&
+		git init &&
+		echo "base1" >file1 &&
+		echo "base2" >file2 &&
+		git add file1 file2 &&
+		git commit -m "initial base" &&
+
+		# Make a staged change to file1 and stash it
+		echo "staged1" >file1 &&
+		git add file1 &&
+		git stash &&
+
+		# Upstream advances by modifying unrelated file2
+		echo "upstream2" >file2 &&
+		git add file2 &&
+		git commit -m "upstream change to file2" &&
+
+		# Apply the stash with --index
+		git stash apply --index &&
+
+		# Verify working tree and index state
+		test "$(git show :file1)" = "staged1" &&
+		test "$(git show :file2)" = "upstream2" &&
+		test "$(git show HEAD:file2)" = "upstream2"
+	)
+'
+
 test_expect_success 'stash apply --index leaves everything untouched on failure' '
 	git reset --hard &&
 	echo test >other-file &&

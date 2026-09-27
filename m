Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E63B0437136
	for <git@vger.kernel.org>; Sun, 27 Sep 2026 18:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790535588; cv=none; b=PLW4yg1+df7CoWqoFh1c9v/3WBAwfs0Is7TstWDiE6OdEs7eZgqsMVdNfo3wpp0DoFjBPReRvV8K46Zzs8n9lZlcB0+nye42jG3x1TtdcO8Ihg+I+f5YhthXbe7KvU0b5V5wBoVZJp536RQxAmAf5aGmWo0MDs5lsFdzTxpxEAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790535588; c=relaxed/simple;
	bh=MoIqLSsvCx8SpIq6L1BEyrrlDu8hlZ0Iyq4pdm0UmNc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=s8jWatH4J+ba2os+T8h4CTAdUCVwCU0qjQKqxL+3pzqgVSo0f1CK36D0y3a7EwB88c+1zQLuoK3G77DH1oslCq17ISYjqER64QVmvNWr+PxmTSEjAJZxobGmTMbNbcssX4oozC4t3S0CZw77+3th8z4+BcwRXnUYjPod/Bv5RVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=WdKUjO0e; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JR9NuI6U; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="WdKUjO0e";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JR9NuI6U"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C82361400058;
	Sun, 27 Sep 2026 14:59:44 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Sun, 27 Sep 2026 14:59:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1790535584; x=1790621984; bh=tZJs2Ll+xv
	qjEyCw/KgBkQA9lUnXYt0R2IS9y3xHFG0=; b=WdKUjO0ercyy/5kNAm8QVfD3mW
	m0hYakMLjrzSxL6O5vvNPHssKKrr7RlBAfUGrRn4Ddslpo6nVfqLaER+OZsE/e1g
	jhUh8sYnY2EYvsQBLyNgJHr7hGE17qjJ/fzkBLHmYP9fzXXSOF6yDD45cmzn9OHw
	que58ItzBS2CGffjeMsk1DT5X8cUVy7HmNmyP8OC0FweL+gBNuTBuC1wVnWrXpTH
	GVWf2DRMteHKq2KUeT67vCFZFvuNNCeHbOhdUHGh5/wwFIsUzVwfUecO7D3OapB6
	9VTCJAqGdpHJW2eM/i/hPTgjIk4wqtPKlyLJfSiVmZXvNCwEQuABENjBjHcA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790535584; x=1790621984; bh=tZJs2Ll+xvqjEyCw/KgBkQA9lUnXYt0R2IS
	9y3xHFG0=; b=JR9NuI6ULyX85HKyHQJO1FsEpkQRPD/A8TZZ7o+sb67VxPzL4TJ
	m6gX8Yovu/gwGDE/Q2MVE6sAQqDNELX3FrK0eQGb+rpBAUCZNS4LMqv2Y9h/NFPe
	rUNrb0X8mQxZyf9pl0lbKToTZUzbLC2x9iH68g5sYZqipFiWgjK1U4l+s5ssKpXf
	MwobbLrdG6XGNoe8+Qa+KQ8uo9CHV8fUUxWj4VRBGLLQ1+6qzVV3f2v1mWE84YQI
	wBgO3IFNO4BGUg1nKLWBdF10NNmXm+zrP5StKN1TPKEOhFUIf6gBi0GRlPfVMo0y
	0j4CQw2dSRRyJ7isXghclrRkaMbfRMeKz/g==
X-ME-Sender: <xms:oGe5ag6k-dtblPcvvOOS58gWanrMFXJPYp8CkjCZjWxwcHzsWLvjBQ>
    <xme:oGe5agL0D7Ynr8NDFWDcgYRcRxU9_9z1XLwXi8zNuFZrv8_dYKrL3Iimygeifr0mK
    NQghnMBrUcHpeUAGUpKCRczY3LwGzii7_N9v_1DTKuK5qXOF5_MCOs>
X-ME-Received: <xmr:oGe5aoz0Kn8JONmEx8XTeDVz9MeeDkSjIqx7l_0EdSHjF-x9DO5LeLDQ6Pjpj_kR7Wbna7ON9eaBz4soIqcCv2guZ3w7v7jQuQgV>
X-ME-Proxy-Cause: dmFkZTEZcz6dFyzEtHLXMk+AKkxOq0VgZ4ROjpkf/MW2JeCoW3TSFEYRIQQ84bRd+kN3Gb
    FE9lKCijolZrf/Py8SPGzZMeaXpAV60WvoamNJZinV2ctmDIOKJ3HWDSFEcekm/iXvTwv8
    ezFOQV9uJlr2s4QO6ES5JIjOON1bNfdEhEwiCM885woAMRAVBg6fe80Ae81jgdk7JGkGbI
    v+AmoJZ5Hc2r9VobgJOPaYAyPtcBXjxsCPKiIjuJ0z4nkiQzeYd7og1R8bUQEUPc29NF46
    eHrOhSwdH+zNr8N3eeen5/KtRaIHRpAucRW/4AlIlhTx3bZ0fo+4NiLBYU4DqvxKCydKWv
    MlGyFq/YxNmR5hFFk5jQufQ1etTgQvIfQdjIHezklMJcVrQXvGytxmSZWfQtYa2DI8vif8
    W1qflkBFYQPDTpcC2q1B2IGzWf/PyBu4vGzu2r/Typ8H/KPo+Pb5rQsG62dZqQO4Ux+vM/
    j/2E2LADbwJ6AdcHtoPXovuL/8FKfcFhHmwrlXhfDxcZTsW9Zt9RTgfU4Snr0hn0Q/uwqm
    GDHYi6jmtWChXYROs4AEqBWD4fq2guLdctwN9dn5LxoDwuO9A1jGZQ1R+NeTYAmAAJ3wfr
    DvWIRfe0JbTj4Bl8K8nYC1rPLdxSrXriY1EVPRMpcvchdK7bz9r31oPxH/rw
X-ME-Proxy: <xmx:oGe5aoK69IwcpXcpxcviB3pWGkNeZukWkd8WQkYQiMDni0AGlLU1iw>
    <xmx:oGe5anVQZ1-T73wYeYy54-6LwPVoyJcUNEhVXhJz6WhSoSdeNWRxVg>
    <xmx:oGe5arbKU9CT1CmFURPhShalCO_9fgFA9qVCdmW3GqLs1JAuHIP8nA>
    <xmx:oGe5auwM5ncWb68xatJ1lQh5gwmRkPvchjZzODftyBM-J-gPhGCthw>
    <xmx:oGe5aizCml87dkn4SV1YTCGS2-IwBbOvq1fbjxz4vHfZ4gCX83OF0lNn>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 27 Sep 2026 14:59:43 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: git@vger.kernel.org,  Eli Barzilay <eli@barzilay.org>,  Phillip Wood
 <phillip.wood@dunelm.org.uk>,  Elijah Newren <newren@gmail.com>,  Patrick
 Steinhardt <ps@pks.im>,  =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason
 <avarab@gmail.com>,
  Victoria Dye <vdye@github.com>,  Adam Johnson <me@adamj.eu>,  Jeff King
 <peff@peff.net>
Subject: Re: [PATCH v3 5/5] builtin/stash: merge index in-core
In-Reply-To: <fde7fb7988b695707c6f2776adc18eec7fe4696a.1790425008.git.ben.knoble@gmail.com>
	(D. Ben Knoble's message of "Sat, 26 Sep 2026 08:16:48 -0400")
References: <cover.1790168285.git.ben.knoble@gmail.com>
	<cover.1790425008.git.ben.knoble@gmail.com>
	<fde7fb7988b695707c6f2776adc18eec7fe4696a.1790425008.git.ben.knoble@gmail.com>
Date: Sun, 27 Sep 2026 11:59:41 -0700
Message-ID: <xmqqo6dir04i.fsf@gitster.g>
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
> +			o.branch1 = "Current index";
> +			o.branch2 = "Stashed index changes";
> +			o.ancestor = "Stash base";
>  
> -			ret = apply_cached(&out);
> -			strbuf_release(&out);
> -			if (ret)
> +			o.verbosity = 0;

We realize that 'o' is a struct merge_options defined on the stack
for this function, initialized with init_ui_merge_options() fairly
early on.  It would have initialized '.verbosity' to the default
verbosity, the merge.verbosity configuration variable, or the
GIT_MERGE_VERBOSITY environment variable.

You drop the verbosity here, presumably because you want to match
the previous implementation 'diff-tree | apply --cached' (which I
guess was fairly quiet, but I do not use 'stash pop --index'
myself).

> +			head = lookup_tree(o.repo, &c_tree);
> +			merge = lookup_tree(o.repo, &info->i_tree);
> +			merge_base = lookup_tree(o.repo, &info->b_tree);
> +
> +			merge_incore_nonrecursive(&o, merge_base, head, merge,
> +						  &result);
> +
> +			oidcpy(&index_tree, &result.tree->object.oid);
> +			merge_finalize(&o, &result);

And then the (index) merge is quiet, which is nice.

> +
> +			if (!result.clean)
>  				return error(_("conflicts in index. "
>  					       "Try without --index."));
> -
> -			discard_index(the_repository->index);
> -			repo_read_index(the_repository);
> -			if (write_index_as_tree(&index_tree, the_repository->index,
> -						repo_get_index_file(the_repository), 0, NULL))
> -				return error(_("could not save index tree"));
> -
> -			reset_head();
> -			discard_index(the_repository->index);
> -			repo_read_index(the_repository);
>  		}
>  	}


But the thing is, this is not the end of the function, or the last
call to the merge machinery using 'o'.  We then use the same 'o' to
drive another three-way merge.  Yet nobody restores '.verbosity'
that was unconditionally turned off above for that second merge.

It is a bit surprising that the existing test suite did not catch
this.  Perhaps we do not test --quiet and the merge.verbosity
configuration in combination?

Anyway, I think you'd need something like the following (caveat
emptor: written against checked out 'seen' while reading the patch,
and not even compile tested).

Thanks.


 builtin/stash.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git c/builtin/stash.c w/builtin/stash.c
index 0f10b9c703..a165419d77 100644
--- c/builtin/stash.c
+++ w/builtin/stash.c
@@ -622,6 +622,9 @@ static enum stash_apply_result do_apply_stash(const char *prefix,
 
 	init_ui_merge_options(&o, the_repository);
 
+	if (quiet)
+		o.verbosity = 0;
+
 	if (index) {
 		if (oideq(&info->b_tree, &info->i_tree) ||
 		    oideq(&c_tree, &info->i_tree)) {
@@ -633,8 +636,6 @@ static enum stash_apply_result do_apply_stash(const char *prefix,
 			o.branch2 = "Stashed index changes";
 			o.ancestor = "Stash base";
 
-			o.verbosity = 0;
-
 			head = lookup_tree(o.repo, &c_tree);
 			merge = lookup_tree(o.repo, &info->i_tree);
 			merge_base = lookup_tree(o.repo, &info->b_tree);
@@ -658,9 +659,6 @@ static enum stash_apply_result do_apply_stash(const char *prefix,
 	if (oideq(&info->b_tree, &c_tree))
 		o.branch1 = "Version stash was based on";
 
-	if (quiet)
-		o.verbosity = 0;
-
 	if (o.verbosity >= 3)
 		printf_ln(_("Merging %s with %s"), o.branch1, o.branch2);
 


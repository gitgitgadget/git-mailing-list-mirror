Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0078B3D955B
	for <git@vger.kernel.org>; Fri, 11 Sep 2026 15:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789140719; cv=none; b=Kofd/PtIs5cHPulewAfqPfZQb5aSft+PvaIX90TMAfBqZm2DqR6W8eFrSy0sXpnSkPhkYnIRc42m3JTp9vTQGgAd+GBkAffzno3TrmfWn1ms7WwVOfeBMFzpcGnmVWJsmkPu7JzNwtBG0Q53e8lnjjsUhyC9zZemKslxTrKhH40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789140719; c=relaxed/simple;
	bh=YFL45fzCJP1E9DmE7YXgG0LHBaBAlx4qibTnGkIxjz4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cR7bPEtbiS/oymtdg6r5wfUowu5zphp6/U0p6V/Wp1zNAC4oJvVikkUjcDgTIMPFCE29pf9TxEwrQoh9TxacGD86aeX4a0Kq+TQ1M3VQOVocRCX6ZoAEhqIcB8IpFIvTDvPReaQTfH9Y+TqQCbkReGhrV70y/0rsfIUKMou8nWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=UfLNuYrL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UjQqaKhQ; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="UfLNuYrL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UjQqaKhQ"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 068ADEC0412;
	Fri, 11 Sep 2026 11:31:57 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Fri, 11 Sep 2026 11:31:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1789140717; x=1789227117; bh=uDCCeFuOKb
	xmLRDA+nkrHQOl8FyblNPP8byrzbbokas=; b=UfLNuYrLs/hyN40doSDZ3vzk29
	3m3Sk45ZE3QtbsKu+GOk9Yh64KUuuhNzoBhUCa+I1qSCln2gVkUvM1p26FQgB5zI
	c4r9AHd3m+bg/cDLsD3BTN4iyc6ms8IFmAaLVE9telTHaNfDD4vhcK4j4qcobaOn
	PntoF+K1Csnq56m3BwZI6R+LOLkPvilHDhTiK6v7AYyHD3IUy8j7O7/TEqB+emSV
	MQcBifN5nAT6KstR8/AfKy87I/9GHofNX+wPMaSIJ4DAxRBmPLfC3OWFVOXqCZZo
	2wV/uiXrlItZhOvgR9GJwIopPFyxBtkfXRe0RbGyvJyIwd2XGCCr6n8eXyJQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1789140717; x=1789227117; bh=uDCCeFuOKbxmLRDA+nkrHQOl8FyblNPP8by
	rzbbokas=; b=UjQqaKhQ0sURl12j12YJAaiZki/H5owQ2m66lXgtz20nYBdtp2R
	RkQySKCXi6cd9THhi7M4lk5ET/8tj35/SujxbcPHm6k34kXBpaeV075wQcLu8vDT
	ogFI6QkCdxhv/P0R59pXCRX+xhoaahmKm26SaOafPxgEXBhXa801fTOl6scOdg2s
	aTt7ynh2evc1ZfZUXKS68RxX7eib1fR1T28kVKu0RPEil7Q3ZTSHq0akKqkDHDoE
	hs2lN+iVDrCurCyvcSKcgh1MQaX7CAakPJQpGAA4ggJgCFaFXHtb5hLC+pJRLTjX
	wlFhSKqsX9KpbjMe3SOyL5+vjXu4BFVny6g==
X-ME-Sender: <xms:7B6kallgXR1KHvKUDH7kmtlPQJUQzwiBoc7_psvWjdfPM0k-7dQJFw>
    <xme:7B6kav72xvMxDmR1KQQv5_9nSeKN0Eh5-SxT69UDIatmGfHBJbQQPUhMHYHr7Zdb_
    oFSSql3yaO0nrshoKuZ4oXKavIq7F-pj24oXUsURxmin8TowzHCMA>
X-ME-Received: <xmr:7B6kah0cVBcPqOLKQJJ79P5bDITHTMCAorp5f__fpdhK8VGuZLg0Cux4YaMrCbVtriJD9aCeeEkpSX4bJMSz3fo-wpgEZSd5gx-L>
X-ME-Proxy-Cause: dmFkZTEHH+JT3fH1rMEkW5GZdYolfmmMMy4POi/6DNmLN9EgVtJ30DJ4VMcUfPjeJIxcso
    WD8TBhy+yuIdi3p/4BShqSmVdUC6TEyQTS8QB608T0ed6WGvFSPqIHe1VX6PHXFTEgUjwz
    4w90tsnJR9+4DjGwNavbgRZ5h1QOGRLU+8kP/BC5BiQSBrIhRehIG69GfC+dl32P3CIuFF
    jrlnzpOH6fB6fN86GyFvDrT74i0Ypmj9uNLAmNHYm+N57hLrDSJq8tPQKGAQuGwbXPFM9w
    EqfoVLT4KE59x10XGTqJPP3zyR0Msv0hN3K3iWBxMiXX1MzVXISfz9AvnXfStS6LqDYEH6
    PGLXdQjbjUnbxE82eKhCTWgrYwUX5SkywXHDwVTNjx2y7aRAXrkXEfOKM2I3rdG01jKN/S
    l6WBuvDbRc+d0/kH4ZgroqxaDN6QcfZCRmkFLh8FjfJG6uLaJen9v5lnq80I4TzfegQymi
    Uab2or6/g/RIA15bQS5SRsskVsPopnaHITugUeh7XuIEhKf3m8XoPrvH/x2N/zr61XFJeS
    Nz17nwVgU5CxB12LhMidLy4I87F0F7NJkwNJa3dWU2K1BYKPMivyG470YIzD1XuQ7/iVny
    len2m2FPeZCOGoQOjp3G36CTQzTKXVCcLoCnLW+H/j2QATKMI/jvykyU8Olw
X-ME-Proxy: <xmx:7B6kaiEktwVnotJcgOYE1HQiWuy_qWlIb5msrMf3WwQBUcTtYdVgFw>
    <xmx:7B6kaoiWGg4xPqpL1BToyPSgyqgzRsSbjKZ-5OgVtVOj9BpRtTqQ1Q>
    <xmx:7B6katBFqHoUz6I9o1WKQ1UuGgoIkSeAQniJc8Du_C5PuSEVC3cnMA>
    <xmx:7B6kaiTq4aYLSLjbjcS5xm3fD6rzhBjc0RkncSNo86FZnQJkm1u0vw>
    <xmx:7R6kamHETw1TsGRF8_ZSIKjlxQLPHADZ6mcXnLMohGKDGoUzJcNu_Ptn>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Sep 2026 11:31:56 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Tyler Cipriani <tyler@tylercipriani.com>
Cc: git@vger.kernel.org,  Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>,
  Stefan Haller <lists@haller-berlin.de>,  "D . Ben Knoble"
 <ben.knoble@gmail.com>,  Phillip Wood <phillip.wood123@gmail.com>,
  Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v3 1/2] push: check pushed ref for --force-if-includes
In-Reply-To: <20260910230506.1631656-2-tyler@tylercipriani.com> (Tyler
	Cipriani's message of "Thu, 10 Sep 2026 17:05:05 -0600")
References: <20260904210122.431757-1-tyler@tylercipriani.com>
	<20260910230506.1631656-1-tyler@tylercipriani.com>
	<20260910230506.1631656-2-tyler@tylercipriani.com>
Date: Fri, 11 Sep 2026 08:31:54 -0700
Message-ID: <xmqq4ifverdh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Tyler Cipriani <tyler@tylercipriani.com> writes:

>  static void check_if_includes_upstream(struct ref *remote)
>  {
> -	struct ref *local = get_local_ref(remote->name);
> +	struct ref *local;
> +	const char *name;
> +	int flag;
> +
> +	if (!remote->peer_ref)
> +		return;

This function signals its displeasure by setting remote->unreachble
to true, so any early return means it is OK to force the push, right?

What is the significance of remote not having peer_ref?  Is it a
usage error (i.e., push is not updating anything over there, and it
makes me wonder what the command line to do so looks like)?  Is it a
programming error (i.e., if we are pushing to update no remote ref,
this function should never be called)?  If the latter, I wonder if
BUG() is more appropriate.

> +	/* A deletion has no local history to check against. */
> +	if (is_null_oid(&remote->peer_ref->new_oid))
> +		return;

The comment for this condition is clear.  If we are pushing to
delete, checking if our side once used to build on top of theirs
does not guarantee us anything, so we accept the loss of history.

> +	name = remote->peer_ref->name;
> +	if (!strcmp(name, "HEAD")) {
> +		name = refs_resolve_ref_unsafe(get_main_ref_store(the_repository),
> +					       "HEAD", 0, NULL, &flag);
> +		if (!name || !(flag & REF_ISSYMREF)) {
> +			/* detached HEAD: no per-branch reflog to consult */
> +			remote->unreachable = 1;
> +			return;
> +		}
> +	}
> +
> +	local = get_local_ref(name);
>  	if (!local)
>  		return;

The same question here.

Are any of these silent "punt" returns tested below?  It does not
seem to add a new test about pushing-to-delete.

Thanks.

> diff --git a/t/t5533-push-cas.sh b/t/t5533-push-cas.sh
> index cba26a872d..0c02151747 100755
> --- a/t/t5533-push-cas.sh
> +++ b/t/t5533-push-cas.sh
> @@ -396,4 +396,69 @@ test_expect_success '"--force-if-includes" should allow deletes' '
>  	)
>  '
>  
> +test_expect_success '"--force-if-includes" should allow forced update when using differently named branches' '
> +	setup_src_dup_dst &&
> +	test_when_finished "rm -fr dst src dup" &&
> +	(
> +		cd src &&
> +		git fetch &&
> +		git switch -c newbranch origin/main &&
> +		git rebase HEAD --onto HEAD^ &&
> +		git push --force-if-includes --force-with-lease origin newbranch:main
> +	)
> +'
> +test_expect_success '"--force-if-includes" should allow forced update from HEAD' '
> +	setup_src_dup_dst &&
> +	test_when_finished "rm -fr dst src dup" &&
> +	(
> +		cd src &&
> +		git fetch &&
> +		git switch -c newbranch origin/main &&
> +		git rebase HEAD --onto HEAD^ &&
> +		git push --force-if-includes --force-with-lease origin HEAD:main
> +	)
> +'
> +
> +test_expect_success '"--force-if-includes" should reject forced update from differently named branches when local lacks remote ref' '
> +	setup_src_dup_dst &&
> +	test_when_finished "rm -fr dst src dup" &&
> +	(
> +		cd src &&
> +		git fetch &&
> +		git switch main &&
> +		git reset --hard origin/main &&
> +		git switch --orphan orphan &&
> +		test_commit I &&
> +		test_must_fail git push --force-with-lease --force-if-includes origin orphan:main
> +	)
> +'
> +
> +test_expect_success '"--force-if-includes" should reject forced update from HEAD when it lacks remote ref' '
> +	setup_src_dup_dst &&
> +	test_when_finished "rm -fr dst src dup" &&
> +	(
> +		cd src &&
> +		git fetch &&
> +		git switch main &&
> +		git reset --hard origin/main &&
> +		git switch --orphan orphan &&
> +		test_commit I &&
> +		test_must_fail git push --force-with-lease --force-if-includes origin HEAD:main
> +	)
> +'
> +
> +test_expect_success '"--force-if-includes" should reject forced update from detached HEAD' '
> +	setup_src_dup_dst &&
> +	test_when_finished "rm -fr dst src dup" &&
> +	(
> +		cd src &&
> +		git fetch &&
> +		git switch main &&
> +		git reset --hard origin/main &&
> +		git switch -c newbranch origin/main &&
> +		git checkout HEAD^ &&
> +		test_must_fail git push --force-if-includes --force-with-lease origin HEAD:main
> +	)
> +'
> +
>  test_done

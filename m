Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A8C633D6D6
	for <git@vger.kernel.org>; Mon, 21 Sep 2026 16:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790009415; cv=none; b=QeEUxsaz3OHuJzdzGeEd3vpVpUS0hsN/Yii5KvFMUjvuuTPNmbhb4O7vtrjxhjGpRuCCIb0VLclJ/zewFKvS9c6Jr+7AGm4sbwDPL3OcO/Id3moiCkNdWZymNC5gUUyFshaH/VnUDl4cR5W0tGQIjl7wpGqb+O2S12uZxtYCwj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790009415; c=relaxed/simple;
	bh=KexReKVcPdBR7wsi747EH2J+xg1uvHJrvvWmGKH5Eo8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fN8dngp3Cf2wP4OuxkXsYvB4P56yNKI7/dnlJhI+PzMhHjPHCDie6tprUNsCJuEXVcyp4HUKGa/BPqTd9averClJdRt5mLtxYVkt2t/pw231JmNXbanB/hUlzli0769P0ppOLn5OdRdlhQoI9QyYadRzZjt8bzfReW+fiNrqL7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=uNgj+Moh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BicNfJPz; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="uNgj+Moh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BicNfJPz"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 2FB22EC0264;
	Mon, 21 Sep 2026 12:50:12 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Mon, 21 Sep 2026 12:50:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1790009412; x=1790095812; bh=q8Yj1u0V+E
	E+bAulXtBCSYM5Xz2Rnaej1RLg5LCJGOw=; b=uNgj+MohZa1jLql0R6iSgMJPb0
	pOv5JtAYnu135NqcdbOYTJyEWAWTnH6h5Kn/Sese87viasP0nQa3XCdn6vFBSP06
	x8MiBXum7u1FGCkuNyT942Hwe8RvetfxBFfudH9/ZJDRcOMNssmZgifv72J3s0dc
	7kPayzp90fVnjosjoxIfLN9nbQms0OBYwdR8PJAKPAK3O4smb1TbRkDLoFA4h3Pv
	z+9I396vwB1wX6FkpdEkdbzZq6MaQoLuwnNFMzOruq28MUha+oITdZCl84NmeAPD
	Bzjib/zuUTAx9i6WEFi4pav59gJ2oIn8kwGLhg9qun7WA0+p5sKf+kPyfeDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790009412; x=1790095812; bh=q8Yj1u0V+EE+bAulXtBCSYM5Xz2Rnaej1RL
	g5LCJGOw=; b=BicNfJPzlWvEbLSmLhtiNRlTaIYVa47AchgGnY+ZZIc2Uz6Uy+u
	iVNP8FUNR98L7ljKjZuKtY7nL3ZHUaAmM4tuET+qHGIpcwH27T7xsAczNaByyb/Q
	pvFu6ikIgmtuS4UX4XeCPDnXYLMbYfEe7mN/rIN0K8YEPnfoWbAOgz0GULbGl0Vl
	wWPlYPVPYALbilB4cemx6cJufm2sWTimwT4318wlBSxv38pt2HxnKw5xQF97D4GH
	zPmKD6PH+r3O9k9+fV7k6w+DvVVVn0kLO3znrPkw30BhK59SQSKBLHrmT11MkMKA
	J6KN4T+XlJl2uqsHJwhhV/OAw0eujCFXFfQ==
X-ME-Sender: <xms:RGCxatHXDzTus8ld0EBkfJduKm0A8DanHIXSftZ8fVsvYWQFxAvZHQ>
    <xme:RGCxapVqf_wYsRg9-rYQCBhjrpv1yVPNsSMvGbTaf7YQS8mzWZsmYlVGe8WitxwuN
    wz2FFzWb-tYwGlGznlxXdBVxngk1Avf_Qf3GVpSiCzSx_as9c0UCygP>
X-ME-Received: <xmr:RGCxakJNSOFhcDS7k6Sh_C8QENIyuCn6MaoXYzCSflfseGGs3Y-YT4MtA-lWTtYrmW59DIDMjZeHx6RgiNBgL6Igb_SV8o3tJ8c1>
X-ME-Proxy-Cause: dmFkZTGcd5jcnd6ukRGfA+bqkDS2zTF11GKdvhT+Wq+7pabJO0/LNWsPXNqQVMdWMW9qHq
    b8eer3p5rrjvKsS0HxbwZkaic7+vsblU+kNuxudXc8HnXfJ1rbWytd4auUpCY99CXFoVVg
    45W4UJ1sQjlk4+ASYRTm2Co9VkODnI7uY+MqUQ8IGl0UE9R0BkT/y6Zz9X08485H++eggB
    A4sUyjFkaBGcYNAbi8dQ79CBklpUsK+qZZI5jBBR8LE2Dl/GAd3CJlbuxrAKIJdK3st7HY
    tVJ7WBH7pPy6GZnZTuTkT5ip1zHDeM3SVlH2/iZUwszySiOmFOxemAA6gcCnJ/7WyMIxgH
    e5v/gZy0GvBDuAHsxBy9giIwvxA9tkjBBNxRNCz8KYPpeCUWxQSl7E1kXwfLz2gHzFHfK7
    +YT/Of7RruZ0xNgKMW9exhvJgnERDuHn4Speqs2dYaUcQO6aB+UuR2MRd/A76cnJJgb2rd
    yXsLwkqT+OfP2KyPwTNOqge2ZijNotlg53UhYMoJMYPEDqhQYagA2NywSHC64KMlOFBLxA
    huxuiWki9MgKfz4w00mdkAARyByf0DE+XiaeUmWlrVN8IqTfzdIIkdp87Kk/ju7tWeQMIs
    eunBjQeUw4X110JSYo7OfHgBa/rJDTfFf4CPsG7kL276fxCjv0IKMpv+sX1Q
X-ME-Proxy: <xmx:RGCxah8_Ki8AIe6XdjQxkWrzHP1fskwjFaazUnfEWPO4y75GBOd6OA>
    <xmx:RGCxavLvh8kIZ--jMcG0XFlhUY0KDJGDTaJif6KFtBEQtzhA_-Po8Q>
    <xmx:RGCxaunjIk6mFwPjOaAwnjpzpkqUtvoDq8nvah7VtVN9LWoAF2i_QA>
    <xmx:RGCxarNzVU79H1uh_8z6rcINlFBx5efRr6MS-bocRVLVlyeyzKwuzg>
    <xmx:RGCxavrZ1bEkOpnQrayZCuimZN2sui7vQrzf5bJ-Y06ibXy4Sr0YFcca>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Sep 2026 12:50:11 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Harald Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH] object-name: explain why <ref>~N fails in a shallow clone
In-Reply-To: <pull.2413.git.git.1789898013916.gitgitgadget@gmail.com> (Harald
	Nordgren via GitGitGadget's message of "Sun, 20 Sep 2026 09:53:33
	+0000")
References: <pull.2413.git.git.1789898013916.gitgitgadget@gmail.com>
Date: Mon, 21 Sep 2026 09:50:10 -0700
Message-ID: <xmqq8q4uo8fx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Harald Nordgren <haraldnordgren@gmail.com>
>
> Asking for a commit's ancestor with <ref>~N or <ref>^N in a shallow
> clone that does not have N commits of history locally fails with a
> bare "is not a commit" error, with no indication that the repository
> being shallow is the reason, or what to do about it.

I am not sure if bringing up '^N' (the N-th parent of a merge) in an
attempt to be more complete helps readers or confuses them.  Unlike
'<rev>~N', where increasing N raises the required depth of a shallow
clone to make the target revision available, both '<rev>^1' and
'<rev>^43' of '<rev>' share the same depth.  If '<rev>' exists
locally and its first parent '<rev>^1' also does, it is likely that
'<rev>^2' is also available, as they are at the same depth from
'<rev>'.

The title of the commit does not share the problem, which is a good
thing ;-).

> Add a hint, shown when the walk runs out of parents exactly at a
> recorded shallow boundary, explaining that history was intentionally
> truncated there. When <ref> looks like <remote>/<branch> and <remote>
> is configured, the suggested command names that remote and branch

Good thinking.


As branch 'B' of remote 'R' is not necessarily stored locally at
'refs/remotes/R/B', implementing the semantics correctly and showing
the correct remote name and their branch name by reverse mapping R/B
back requires a bit of care, but it should not be impossibly hard.

> directly. For <ref>~N it suggests the exact --deepen needed,
> accounting for any history already present instead of just N. For
> <ref>^N the suggestion is always --deepen=1, regardless of N: a
> shallow boundary commit has no parents recorded locally at all, so
> deepening by one generation fetches its complete real parent list in
> one step, whether that commit turns out to have one parent or several.
> The hint only fires when the search stops at an actual shallow
> boundary, not merely because the repository happens to be shallow
> elsewhere, so it does not misfire on a short history that is not
> shallow-truncated.

I think Ben also mentioned this, but <ref> is probably better
written as <rev> in the above.  A ref(erence) like "master",
"origin/next", or "refs/remotes/origin/topic" are all rev(ision)s,
and this new advice feature is not limited to requests that are
made using references.

    When the revision <rev> is given as a remote-tracking branch,
    the remote and branch are exactly named in the suggested
    command.  For <rev>~N, it suggests ...

> The advice is threaded through GET_OID_QUIETLY so it is not shown
> during the internal re-resolution some commands do while building a
> better error message, which would otherwise print it twice for the
> same failing argument.

Nice.

> Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
> ---
>     object-name: explain why ~N fails in a shallow clone
>     
>     Asking for a commit's ancestor with <ref>~N in a shallow clone that
>     doesn't have N commits of history locally fails with a "is not a commit"
>     error, with no indication that the repository being shallow is the
>     reason.

It may not be intuitive to new users that in a shallow clone "git
log" stops in the middle, instead of going down to the beginning of
the history, downloading necessary objects on demand.  But fixing it
by adding such a feature is totally unrelated and outside the scope
of this topic ;-).

> diff --git a/Documentation/config/advice.adoc b/Documentation/config/advice.adoc
> index 81f80a9274..5b44037fff 100644
> --- a/Documentation/config/advice.adoc
> +++ b/Documentation/config/advice.adoc
> @@ -128,6 +128,10 @@ all advice messages.
>  		give directions on how to proceed from the current state.
>  	sequencerInUse::
>  		Shown when a sequencer command is already in progress.
> +	shallowHistory::
> +		Shown when `~<n>` or `^<n>` cannot resolve enough ancestors
> +		because history stops at a shallow boundary, to suggest
> +		fetching more history.

It is obvious that users would see such a message when they say

    $ git show HEAD~20
    $ git log HEAD~20..HEAD

but would they see the same when

    $ git log -20 HEAD
    $ git log --since=2.months HEAD

and internally HEAD~20 fails to resolve?  Should they see the same
hint?

> +	test_must_fail git -C shallow-advice rev-parse origin/main~1 2>err &&
> +	check_shallow_history_advice origin/main "$oid" \
> +		"git fetch --deepen=1 origin main"

This is very straight-forward.

> +		test_must_fail git rev-parse origin/main~5 2>err &&
> +		check_shallow_history_advice origin/main "$oid" \
> +			"git fetch --deepen=3 origin main" &&

Again, very straight-forward.

> +	test_must_fail git -C shallow-advice-caret rev-parse origin/main^1 2>err &&
> +	check_shallow_history_advice origin/main "$oid" \
> +		"git fetch --deepen=1 origin main"

Ditto.

> +		test_must_fail git rev-parse origin/main^2 2>err &&
> +		check_shallow_history_advice origin/main "$oid" \
> +			"git fetch --deepen=1 origin main" &&

Ditto.

> +test_expect_success 'shallowHistory advice not shown for a non-shallow repository' '
> +	test_must_fail git rev-parse HEAD~100000 2>err &&
> +	test_grep ! "^hint:" err
> +'

OK.

> +test_expect_success 'shallowHistory advice not shown when resolution succeeds' '
> +	test_commit shallow_ok_1 &&
> +	test_commit shallow_ok_2 &&
> +	test_commit shallow_ok_3 &&
> +	git clone --no-local --depth=3 --branch main --single-branch \
> +		.git shallow-advice-ok &&
> +	test_when_finished "rm -rf shallow-advice-ok" &&
> +	git -C shallow-advice-ok rev-parse origin/main~1 >actual 2>err &&
> +	test_grep ! "^hint:" err
> +'

OK.

I guess the answer to my earlier "does internally failing to resolve
due to graft point count?" is "no"?

Thanks.

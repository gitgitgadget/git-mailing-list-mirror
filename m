Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 214F63375C3
	for <git@vger.kernel.org>; Wed,  5 Aug 2026 16:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785949087; cv=none; b=ZPFIl5QYEiwSg4tqXob+fE1a2mxSHCoQXIpzH+gRQL2dgYg9nwID9GNrTVDHqzvV4tQXdN/iDv7sqqt6NIhKQAGdAMKi3MZsvpGkjMUg5GgdDjdQTZdit4JQaKdMGtZMdf6d97UZ1aqTi5K9bB5f6UJoLJ6X1dPlCPPQ+YQgu8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785949087; c=relaxed/simple;
	bh=9X1tOttsxYElV8b2cEzitaW/myDX2VUMmq9ddjiveP0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mrdBVmPDdzlBTdyzJNs/xz5GWQIgY+kFZucLCCRTwo3s5+6hZ0Fxif7aF7fiAvjBluDKzzbnwheX8NMaXHFD6sM/V7n9J7qYxAJP+A1qX7Owq9uzWQ9PNuNaDpBGPbI2ZGTDAw3DovpVRDL23cq1TzBFwzn7ZekZTUVdgRHGeOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ChLWIDxC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OgKGGuGk; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ChLWIDxC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OgKGGuGk"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5B4827A0173;
	Wed,  5 Aug 2026 12:58:05 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Wed, 05 Aug 2026 12:58:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1785949085; x=1786035485; bh=qbqN4I1+UX
	cb5A0PW5hVOpkuaIxhjLrXjiff6/vte/o=; b=ChLWIDxC6g/ZsRiQLbR/dJOLwN
	8aIRSGsGFLdatvrlgoEjfbPyY5Ebw2x5OwKM8Rvq6BnbGZX4j0z+gjHhzYBzpHYz
	PeeKvKkNxeux8hFwYO9tH1X2GJVuMtyXdJ6+R1dvaZmH7tBcscME2YI1W3AFL4qZ
	vDkCZhtlo43scjFqD0O3Pm/k2CGZDtcfaKcd5ycJFqsj+GjVEikztaoKLLkk889E
	dM78aLcEIviXPH3yrpPxKkzz8NZfr7CP3UP3odYlXhcOOixq8zGv4azt6jtSYfL6
	PgLqYMygh6KJVoxtb3+yMxyLHg35mMEF4BKfe2fz4lM9UQ0P4i8UFzSpTAHw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1785949085; x=1786035485; bh=qbqN4I1+UXcb5A0PW5hVOpkuaIxhjLrXjif
	f6/vte/o=; b=OgKGGuGkbW91IexnRxyONO6EcLeh0VoIW/4yEs2iFQrYhnE3ep+
	YEpJ3jeV9cxDmzZpFmPPakitXprMCyBNnXzoFLjfIERscnMgeFE18/rNgqY1Vdqo
	RclFWPMjvLI3xecz8JNiq4E7muUdwAdlSsu3oWhA58mcEkOZeY3CVk8G1OlYBgRx
	yRbpmN5yu4Ftns2CoZ0cPyddMld02B5ilWjXsd6Af85IOwbZfGAsIxOcWtg1kqjx
	yFZSFBO4mNmAyAxd4tFQxDZU5/GU9EnGwoSPr5gE3hC0zkagYttlmbF44PkKYauD
	Sacxi/tqSZdXItLUORvV8ev7KamdIL8mkwg==
X-ME-Sender: <xms:nWtzauoQryHnq75Tz5ceoyqharjg0RAj5rVrUMVFB56_tD19el7wrA>
    <xme:nWtzajhWoT-XD7wud1tQBfN4kfCESbmAxpXkkZH5gOfQTW5iNRXXLJ4LKpxSN9NW7
    WsUtE6_3CJzse899LkzUgUbPsXIQQA40gaIr1fXX-cLyJooaWmmSA>
X-ME-Received: <xmr:nWtzariY2rlTPeUW9Vt_FDtg5R9D5wtUyn-95SKnMTYLaK1GEZraCHxyOe283yNIsGQZ5GKl-rlBxyvQ47OsquRIW2oDD6NwFg>
X-ME-Proxy-Cause: dmFkZTFxQuJUp60Tlt47PwTxK3qxO+W2kSkZPOVxjs2eNFfw3Ho2Ul94zT0xKZzJsPMb78
    WotD9LYB2tZO3vf24PJx8Q8WY2cVILW8e3OSHoiZPGPGb5xSLbjVZqzKTN0S4Ky0W6cJA6
    jnsqweb0ll6rCrCaiar55cwRkf86QwREjXrnYYITWvwjcilf5zhE6v5Iwj110crKiLjCcw
    R9/q2pZOPEKRuD5IxOg3PHwm7xOs7k8oMzYjktryj+gQfgyVaPPdo/KLue+YyqVKGaoQ9/
    Tyufp1JMMew4MU60Imlvd7XpnkHiTpcUP2fnR4hr1k03sj2JImbKYhlwmugblfkd1IBuHd
    eBiZCud6B9cIMwQcQAhYc2MLNulWKpMRHAJGUoN0KA1JRvJyXetD2FtK0L3xWtqYFdBPYY
    FZ7Ny5n8dSvzIKqs1WgcDpArhcvpVaFtuBc25CCV0dkfSygJGZz1v0Kq0h65na5OyraPqF
    /+UwTfPXvpuGBU5ESrTZ3dueKvNaoilzA8PhRR5zx2vCWi9rMTjNuJSM1T+9fwh2EuPbOf
    9s01CI1aGcE3vUpD690KOaTfUktDqwEWON5FcpWMg3v7aYLZfg/qL2s2y05yAhrzHILLqu
    Exz6siyvDEyGgxHIjngUZW7zBak2MU/og9HzA1A2V6/7XStAYuSjkFnAwiVQ
X-ME-Proxy: <xmx:nWtzapiAiWY0CeFiHqgi81Q_-XCU-i5Q4om5GiuKYAJkQbL59-He0g>
    <xmx:nWtzarINSsNWE2TRAGktSOQ9xCoZAoFYaSF_sH0hgDKAcF3Q9JRWPg>
    <xmx:nWtzaoEa6q7o-JTlfwpRvziaT2iDrv3RVStgDF0gaTz8QT0caU0Wew>
    <xmx:nWtzavR2onBJ2bJrzzyG0UuJpToYFMltiaYuvbnbM7d4rU-A5mt2iw>
    <xmx:nWtzaucDAVMjPdTr240xdj6zJsgt7lTpZTvTfUv-l0CSkpGBV9D_ViWl>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Aug 2026 12:58:04 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Yoichi NAKAYAMA via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Jacob Abel <jacobabel@nullpo.dev>,  Yoichi
 Nakayama <yoichi.nakayama@gmail.com>
Subject: Re: [PATCH v3] worktree add: shouldn't dwim if -b or -B is given
In-Reply-To: <pull.2192.v3.git.1785934486496.gitgitgadget@gmail.com> (Yoichi
	NAKAYAMA via GitGitGadget's message of "Wed, 05 Aug 2026 12:54:45
	+0000")
References: <pull.2192.git.1785852032626.gitgitgadget@gmail.com>
	<pull.2192.v3.git.1785934486496.gitgitgadget@gmail.com>
Date: Wed, 05 Aug 2026 09:58:03 -0700
Message-ID: <xmqqtsp8qzc4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Yoichi NAKAYAMA via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>
>
> 'git worktree add <path> <branch>' DWIMs <branch> to a
> remote-tracking branch when neither -b, -B, nor --detach
> is given.
>
> However, 'git worktree add -b <new-branch> <path> <branch>' can
> still DWIM <branch>, causing <new-branch> to be ignored.
>
> This is a regression introduced in v2.42.0
> (128e5496b325640f0a09cc1d5b1e346c069b410f).

I'll commit with the latter half of the above message rewritten like
this:

    However, 'git worktree add -b <new-branch> <path> <branch>' can
    still DWIM <branch>, causing <new-branch> to be ignored.  This is a
    regression introduced by 128e5496b3 (worktree add: extend DWIM to
    infer --orphan, 2023-05-17), which appeared in Git 2.42.

As we refer to an individual commit using "log -1
--pretty=reference" format.

> Signed-off-by: Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>
> ---
>     worktree add: shouldn't dwim if -b or -B is given

The change looks good to me.

Thanks.

>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2192%2Fyoichi%2Fworktree-add-should-not-dwim-with-b-v3
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2192/yoichi/worktree-add-should-not-dwim-with-b-v3
> Pull-Request: https://github.com/gitgitgadget/git/pull/2192
>
> Range-diff vs v2:
>
>  1:  b00f6c2fa1 ! 1:  477ea27c8b worktree add: shouldn't dwim if -b or -B is given
>      @@ Metadata
>        ## Commit message ##
>           worktree add: shouldn't dwim if -b or -B is given
>       
>      -    git worktree add <path> <branch> DWIMs <branch> to a
>      +    'git worktree add <path> <branch>' DWIMs <branch> to a
>           remote-tracking branch when neither -b, -B, nor --detach
>           is given.
>       
>      -    However, git worktree add -b <new-branch> <path> <branch> can
>      +    However, 'git worktree add -b <new-branch> <path> <branch>' can
>           still DWIM <branch>, causing <new-branch> to be ignored.
>       
>           This is a regression introduced in v2.42.0
>
>
>  builtin/worktree.c      | 22 ++++++++++++----------
>  t/t2400-worktree-add.sh | 10 ++++++++++
>  2 files changed, 22 insertions(+), 10 deletions(-)
>
> diff --git a/builtin/worktree.c b/builtin/worktree.c
> index 654d27c3e1..cc46c1b415 100644
> --- a/builtin/worktree.c
> +++ b/builtin/worktree.c
> @@ -898,16 +898,18 @@ static int add(int ac, const char **av, const char *prefix,
>  		/* DWIM: Infer --orphan when repo has no refs. */
>  		opts.orphan = (!s) && dwim_orphan(&opts, !!opt_track, 1);
>  	} else if (ac == 2) {
> -		struct object_id oid;
> -		struct commit *commit;
> -		char *remote;
> -
> -		commit = lookup_commit_reference_by_name(branch);
> -		if (!commit) {
> -			remote = unique_tracking_name(branch, &oid, NULL);
> -			if (remote) {
> -				new_branch = branch;
> -				branch = new_branch_to_free = remote;
> +		if (!new_branch) {
> +			struct object_id oid;
> +			struct commit *commit;
> +			char *remote;
> +
> +			commit = lookup_commit_reference_by_name(branch);
> +			if (!commit) {
> +				remote = unique_tracking_name(branch, &oid, NULL);
> +				if (remote) {
> +					new_branch = branch;
> +					branch = new_branch_to_free = remote;
> +				}
>  			}
>  		}
>  
> diff --git a/t/t2400-worktree-add.sh b/t/t2400-worktree-add.sh
> index 87b926728a..ba3bec078f 100755
> --- a/t/t2400-worktree-add.sh
> +++ b/t/t2400-worktree-add.sh
> @@ -621,6 +621,16 @@ test_expect_success '"add" <path> <branch> dwims' '
>  	)
>  '
>  
> +test_expect_success '"add" <path> <branch> does not dwim with -b' '
> +	test_when_finished rm -rf repo_upstream repo_dwim wt &&
> +	setup_remote_repo repo_upstream repo_dwim &&
> +	(
> +		cd repo_dwim &&
> +		test_must_fail git worktree add -b branch ../wt foo 2>actual &&
> +		test_grep "^fatal: invalid reference: foo" actual
> +	)
> +'
> +
>  test_expect_success '"add" <path> <branch> dwims with checkout.defaultRemote' '
>  	test_when_finished rm -rf repo_upstream repo_dwim foo &&
>  	setup_remote_repo repo_upstream repo_dwim &&
>
> base-commit: 5b2471720c93ee30e5764a19f3d3b3ae9ec9712a

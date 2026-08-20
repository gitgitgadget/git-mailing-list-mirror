Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C5A488762
	for <git@vger.kernel.org>; Thu, 20 Aug 2026 17:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787247300; cv=none; b=Wxyz9SLgcO/Gw6HkebU9348+84gPN7DJuIlYg2ooz2GZxCs4ztljmaBw6rAVbgMHDD+5UvDY8qIY4KNkYa1/mWIsH4wCQRwzYXGLnjQ/R0MAEzmJ5fcJnf65BiXDJWEzspPmBc5p+8bOEIdDtlHoVKQZeue1hIJUImm3n7eI5tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787247300; c=relaxed/simple;
	bh=A4AnYayqsDnlN0a2bKQL111aeF+dc+l/HHeAkYoJ5kg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tgidA5oVldeTR7MrlmYmmwYibGaywxS7/SUkpqAB6gZtCeuTJpKrVFJ8GesP4i7qxVuIJCPaKqt+sD4pYR7/1GannVg23UwdMImxarCWX92O+u0Z0Eb5numXYDRiAx3DEYRWSgwtaanXxfqcyHnuMr/W2efRC1DDqGvR2ExSnvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=QshAnPII; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ejsEOz2N; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="QshAnPII";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ejsEOz2N"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5BBF77A0141;
	Thu, 20 Aug 2026 13:34:57 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Thu, 20 Aug 2026 13:34:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1787247297; x=1787333697; bh=FGycQ8mdEa
	my1rvdRPBBNCkYFgMVYDdbAUe9LDOd3ho=; b=QshAnPIIiIZFc3R8RW4K/ccIRX
	JVlcUKqhoQFLXvgwnyoinD5++ZwrMlwxI55POH0JIscNa1/EEELfwW1AbZUeov69
	isMxkHxQZsEs6ikVR0aAtGmqQtiKCkVH0f6tQBOlR1hX5AapFdf/x9qthbhsyZ1+
	BeHOd2otv9C+kK5JyfplipB+zBRVxTSEwXlpttGkc8+WejJCKiLTZLRRhKyPOHR0
	MNo5HuysQyxivQFUVf1GPfepvWS9b5DbQroYMluWMYMYVXTNrix3hIVKwZJjsSk6
	pT7yQoUZXTHC4OzcshZvH7ELSQPC8rHevlxCEMWEnd5nYmZfFk/0llpJTywQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787247297; x=1787333697; bh=FGycQ8mdEamy1rvdRPBBNCkYFgMVYDdbAUe
	9LDOd3ho=; b=ejsEOz2N+ypubrgkXegOkLm7Dl0uuCD83RXyP6Msk3fLDircori
	ZB+QZ59bfL5px3KGTFWMCg/so4Q5+TIZMmvFw9xbVORXub97BxIDefJ6Bfp1F4P9
	70GrDq/gIF+cIBjuDoOEcssBvo7zRlo0yodzrqYM/fEhDS1XcFrdhTPiziebs8Au
	NrZuT1fKQNxdpJnApB+JGkUvhnNhzUJ3CYKyAi6PUHsU9EVZOFnIfwHOS9impg94
	qsg6EaBVNhoCCDpi6SGA4Qxq9FQD0REGJAe5eCY5jSGmfv0sHnLMPDtwzFopWW77
	dD9iVai6bklOmWQwBbZpcQ6vjkQpJcxV4dw==
X-ME-Sender: <xms:wTqHauS0Ihr7yngP2mxSZrYqE8c2gzlbptO68J39hpWktzM26MFhaQ>
    <xme:wTqHaqrDqORfMk967Py09pjftCJ8w-rCUpcF1G59kssP5oEeFqQGE_itcJjOuOVEG
    yCj7TImYLfYJKPrmYwInOcNt7snE3hvbgkNBc6fscClnJSywvLvQps>
X-ME-Received: <xmr:wTqHakKecGvqv942F3FPlNiCP_7ahmKbLS26iYyqeGiAraoqr2_2sb46Y5Pi6tDV1-ukh5rYUQC3LYmEUMkldCjsczccJaJfGA>
X-ME-Proxy-Cause: dmFkZTErGGAln5TdkkSCcPcezBZkDMln1zxG/KlhPIVNP2ZnPbcNNFAa3fFLANMeeKml7G
    X8KC3y9Qt1grq8Tqovl3YkVsFoUyIqUvxsxf8LjCD9uaq856zqKa+dXx48ApNLWu3uX8zw
    vJsdw4OHXo6OYZsrSY9Q8TrUR5k0yps4osf9bZObH5PO3TacvNd7E2sHTWVvOUl9+VxZ1x
    SbfUsyyvra3NS8LmJ8+6aH8Bkaxd1yTGs2ke+sGzXTE85idgs+UDdkinngNsIq3qfOI1GJ
    gQ73CHHGGqNPD2xri4o91FTVWH9lRDK66yfYu+3mVkaJ/pU6STmumHwpVKzsQbg0fwKMVy
    vLiVFoeqxy9NZWyDSF72NERt2AIy0lsTj+eW3+5jziaGbnXk4DNECKEEa+7Te/LO8qrSGT
    /Hq9Gd1+CuDQjKEWFs1Ie5zypNmYjIgJQwrmnr5RF/j4mMSVKh8Tm3LU0RtUeE6t/FztVS
    fVymQWxUZoY8DwrZ9QwdsLtE04stdA+GJlj1yuxF8qphFEz//h3jl3E7IweUYUunj6M0vQ
    A1GjcZD9nFWmj+S7E98Q4uN2EWb+xJCyWlu/nY0WDsehaBFWzTFR4jrBlkTsPozF+SO2AZ
    mME1bGjR9cI4tzacqpShjgL1yXSKBzaAinK5hf//pKOAeewjkG17DijrsRBw
X-ME-Proxy: <xmx:wTqHalrYm5MTo3IYtQJOHSN6oAxS8MLalIpylBBSw687sdG2KTZ8lQ>
    <xmx:wTqHaky3yZGd1fucwVuFUxb-9BMrASYpjQT3_tBdyz0ufn_-CWDmcA>
    <xmx:wTqHahOtnTNDQukWAd7qmqAXuRSAgVis7vteVtEN-3nDx6Aq2a75Cw>
    <xmx:wTqHah4LXwHsshp791IyyKrqTAZ5qGsVbAeDDfTk93XCLDrL3SIdag>
    <xmx:wTqHauG2YvMcs2yXgKqJ6CFX_iJevHWhQ4N1BaXynyEldk_k4bTdRbDQ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Aug 2026 13:34:56 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Yoichi NAKAYAMA via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Jacob Abel <jacobabel@nullpo.dev>,  Yoichi
 Nakayama <yoichi.nakayama@gmail.com>
Subject: Re: [PATCH v4] worktree add: shouldn't dwim if -b or -B is given
In-Reply-To: <pull.2192.v4.git.1787221888406.gitgitgadget@gmail.com> (Yoichi
	NAKAYAMA via GitGitGadget's message of "Thu, 20 Aug 2026 10:31:28
	+0000")
References: <pull.2192.git.1785852032626.gitgitgadget@gmail.com>
	<pull.2192.v4.git.1787221888406.gitgitgadget@gmail.com>
Date: Thu, 20 Aug 2026 10:34:55 -0700
Message-ID: <xmqqecfssnk0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Yoichi NAKAYAMA via GitGitGadget" <gitgitgadget@gmail.com> writes:

>       @@ builtin/worktree.c: static int add(int ac, const char **av, const char *prefix,
>      + 
>        		/* DWIM: Infer --orphan when repo has no refs. */
>        		opts.orphan = (!s) && dwim_orphan(&opts, !!opt_track, 1);
>      ++	} else if (ac == 2 && new_branch) {
>      ++		if (!strcmp(branch, "HEAD"))
>      ++			can_use_local_refs(&opts);
>        	} else if (ac == 2) {
>      --		struct object_id oid;
>      --		struct commit *commit;
>      --		char *remote;
>      --
>      --		commit = lookup_commit_reference_by_name(branch);
>      --		if (!commit) {
>      --			remote = unique_tracking_name(branch, &oid, NULL);
>      --			if (remote) {
>      --				new_branch = branch;
>      --				branch = new_branch_to_free = remote;
>      -+		if (!new_branch) {
>      -+			struct object_id oid;
>      -+			struct commit *commit;
>      -+			char *remote;
>      -+
>      -+			commit = lookup_commit_reference_by_name(branch);
>      -+			if (!commit) {
>      -+				remote = unique_tracking_name(branch, &oid, NULL);
>      -+				if (remote) {
>      -+					new_branch = branch;
>      -+					branch = new_branch_to_free = remote;
>      -+				}
>      - 			}
>      - 		}
>      - 
>      + 		struct object_id oid;
>      + 		struct commit *commit;
>       
>        ## t/t2400-worktree-add.sh ##
>       @@ t/t2400-worktree-add.sh: test_expect_success '"add" <path> <branch> dwims' '
>
>
>  builtin/worktree.c      |  3 +++
>  t/t2400-worktree-add.sh | 10 ++++++++++
>  2 files changed, 13 insertions(+)
>
> diff --git a/builtin/worktree.c b/builtin/worktree.c
> index 654d27c3e1..15a1c9624a 100644
> --- a/builtin/worktree.c
> +++ b/builtin/worktree.c
> @@ -897,6 +897,9 @@ static int add(int ac, const char **av, const char *prefix,
>  
>  		/* DWIM: Infer --orphan when repo has no refs. */
>  		opts.orphan = (!s) && dwim_orphan(&opts, !!opt_track, 1);
> +	} else if (ac == 2 && new_branch) {
> +		if (!strcmp(branch, "HEAD"))
> +			can_use_local_refs(&opts);
>  	} else if (ac == 2) {
>  		struct object_id oid;
>  		struct commit *commit;

Ah, that is a much smaller patch, and does not share the same issue
as the very initial iteration.

Will queue.  Thanks.

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
> base-commit: dea0ea3582e6980ddbc1173cc8e3e9f9db91cde0

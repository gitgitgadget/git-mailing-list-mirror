Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58133408624
	for <git@vger.kernel.org>; Thu,  1 Oct 2026 16:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790871009; cv=none; b=tLU1Zh9ztVw2hHIGLfomu9rB6td8ps9i677VYOvPvUp/eqv/b7Am4f7np8N8C2bXAcVqCENM3fovgLp5ih2NUUmphg+LN4cXElVZubIM6paOoyEb5k65RJZUmQDEX87MV3ek+Ug21H+7V1fwooUXc3iS1grR6VenQFbSKPDm4Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790871009; c=relaxed/simple;
	bh=jIwtNHv+HbBwbKpgX0H+lJae0LjKhAI2uyejB9WLc5o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Qb0OW+rRjr4tiMZyDogTr+a01OU6YMC+Ko0sqGmJse+xZUtrc+JW52XjVaXbSfYL91Darn0QzAeOlEYlgaZgbUnzzZ2SdbcGBAAnXffq8XoL+IOgiE/1OyuuAU2i0i0+JLgpGr/FEikyxAvHecPxO90/My9vE6iAa/qIyXsb6Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Jh48E+Jw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rQGpIBpR; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Jh48E+Jw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rQGpIBpR"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 57644EC0169
	for <git@vger.kernel.org>; Thu,  1 Oct 2026 12:10:06 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Thu, 01 Oct 2026 12:10:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1790871006; x=1790957406; bh=RXeyXkEQGo
	s68+JhQKNJkojIriUMQQ4d5BB7LruHrwU=; b=Jh48E+JwcvgJcsG4R7EBuaEzWK
	h5q/MOKNjrf9fyJ/OOrHaiC8cvkBjA7DOUzexfxuZKuTe/JR/42Er+cXZsEC72rl
	ku7zizo/4QXkVdtFFGsB1exEFEoVMJhjFMk6cRWN+E6kqTPVCyc4bvPXmvBoNSPw
	Kmrz4Ass+JFAt4QOwqLu4VTjqr4L93gY+B5bGNGIycqyYqeUUBuI4vRlqM10vEZa
	jK9ZfErvwNnS/CKDxlcCIhAvS9arTLVN0776VAvZGNND4QbjLc5JIUc3zZflGaIa
	9NrcTrnIJ1+P7jtx5hT3Z+Ob310hIEcMDnmejYdG/pHFEFe+qflwZT9EHxaA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790871006; x=1790957406; bh=RXeyXkEQGos68+JhQKNJkojIriUMQQ4d5BB
	7LruHrwU=; b=rQGpIBpR3ZYhkhC1dxR932yukIS95sDLwD11xiQXODccTjygchA
	gGgynneBMfvvF5lYPCe10lUiUu3G4yc5VHjecnSKUPyoYhIytFqxFeG19uktH8RF
	9ZXQaVOJclzVFs1tWTomcfFwb2fmG0jZHoRxBgNsEdze58rS7kl3JM+VZbfGKFCv
	uQtiVfX0Ge5nNXS7cUee37s+zYrvqo+Q6QS4RaZJkiugcbN+YNaWrJ2rn2oC0wAL
	EdgeEWxKPtLnjrrMVGi4jD1rWWSVi4VJ+3/5Z4zmFSh/pH6OEFYupbwEPkw7s2on
	tGHz85uGWmw7lJfaa8fp5Xfq0YhhR7ydz7w==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1790871006; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:lq6nM1yKhRmhfdSV4XL1DFRSg+fVxgyOgca6mkjFsAfSEKE
	llgpdK4Ige5AFEwI1NY/0UFhzyF1oUYf+3Q1yPSy21rkSPuldtaxDUTO47oohdSC
	4VVA6XzmWh11AeKSVtYERw5skVD1RAeHlKhakXoCqPDul2gOZWCN8ZyGcbQRwvDK
	KjBM+QHWkqDuSZGGFNfqriTYX+NxDQBdkI+Gk796DDUSinWG4v6NM8DepomZOr/G
	X9sQ2KdNRKBu6d/AUGCf0Xpollj8GVM+Wfnjub0FncwP84okeUgwMRoRciFxHwg6
	SkB7jLu68j62Gn31bpx2ufai8sB2vZyU5XPuhIA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:4VVMm7elJ2Mz6+gPtWmLI9O1KAqPp7I6yqCnBr9lURM=:jIwtNHv+HbBwbKpgX0H+lJae0LjKhAI2uyejB9WLc5o=;
X-ME-Sender: <xms:3YW-auK0GbwIejkEAeuFagrDLqDjjW0gXm4koom088jaKp16nnZA6Q>
    <xme:3YW-atD2-QaRl3zAOngrkzQtYXX10W2aO9BGQMf8_q7caTxJMqWsR4j3GsGhmOrK-
    zg7tmGf04CUcMdoB-glg6WWMf4rfl1TdZGzV9NMcB83DBumi5Xq>
X-ME-Received: <xmr:3YW-anCJ_xYApeNOfUpDnc-RoqpCn6a4OUw_F4Lf7YPM34KcHCxuQsO2SRyS4qBub2LYguRCWtMMKpSGd-Icq798fmO8Z9KwqxzP>
X-ME-Proxy-Cause: dmFkZTFKRl0ev2ukTAq1r6N42r0hGxrDNDW/uKX2hgxFKsZ20H8D0BR5fNSSUCR6AHWth3
    G8/GRirWmgknuePQmYMyVEYTfAJ34j0vqqKWfDZt69lTd5YZN2ON6H3dvEBG3yMuiZGJjE
    A1FHdA5kCcFXHF6Au+tMbuFHVUGXJPGqWqpJIMBQldh1ZAoqfrIuj3meTYtUVSCE7/VKcR
    QpshaB30F30rsCaplFRcI5aYyvQ6iMHM0DPecz6/aIvn/EVFcINlT7bBc1EyIscV+TZo2I
    dSQ9r+c46iF7vLMasQmNo0Uzk1UgxKa8rnqX8PEJDthMnxvFDPmJ1eyHIyDqA/SuVXCRNH
    vKg6E8jucj4vWthdDL5Srhdbzf/HIz5tXOO/BGm2KPd6WOJ8y3UmrfcsycbGWSrju5fn1g
    BN9NYgWugh3Xwt4XcSkITF/Sw71SPPl1vqhHw5TrLH/R0MB5GAV80VpW8nnn1ee5lwIjcU
    6fhx0Jkq3BRE1cIl0pOSUmHL9cOXaTFo52HLA0FvUZ4VO26w+8yRJFXxF+b8PgNQAySZv8
    EDcfXL7+V+Fq/6Z4j7cCZJBnIuT19KOpiV+iLZlE1KT6Ob7rwTEKT8QypEskUHxlAxYikb
    7YOyJL2/H5Te4hjFqVxlECRS9t3jhdOQsooEweSzormg1Ic0rHwBsB61c9Qg
X-ME-Proxy: <xmx:3YW-avBOKbm-QyINWFh_FY3diqMkQNQi7oEo87UEjLzJPB5Gol5Vmg>
    <xmx:3YW-air51w2ONFKmG19BtUvWSvmLP_4JCgZYDhUMMf8wOUJ5sH3w4Q>
    <xmx:3YW-apkshRGJkZ9R3S9blo828eKYEa-84Lb1VHiSG5z1Lt8ae-2F4A>
    <xmx:3YW-aiy7Cj0o5JYXFvyWEc6jCrS-vZ4KOHQ4vo7kklMsJveQw0xJnw>
    <xmx:3oW-aqc2z56k22JTPvyd37Ai2LoIEOsuT-FxxukXV-lCqvvHwqRsGzZH>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 Oct 2026 12:10:05 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Grant Moyer <dev@grantmoyer.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Michele Locati
 <michele@locati.it>
Subject: Re: [PATCH v2] filter-branch: fix commit map init from state branch
In-Reply-To: <20261001012347.3998801-1-dev@grantmoyer.com> (Grant Moyer's
	message of "Wed, 30 Sep 2026 21:23:47 -0400")
References: <20260801033127.10606-1-dev@grantmoyer.com>
	<20261001012347.3998801-1-dev@grantmoyer.com>
Date: Thu, 01 Oct 2026 09:10:04 -0700
Message-ID: <xmqqh5j57677.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Grant Moyer <dev@grantmoyer.com> writes:

> The commit map dir is populated from the state branch assuming a
> "to_commit:from_commit" format, but the state branch is written with a
> "from_commit:to_commit" format, resulting in an inverted mapping when the
> map is populated from the state branch. This is especially evident when
> --prune-empty is used and creates commits which map to nothing; when the
> map dir is populated from this state on subsequent runs, git-filter-branch
> outputs many errors while trying to create files with empty names, like:
>
>> /usr/lib/git-core/git-filter-branch: line 305: ../map/: Is a directory
>
> This change corrects the population of the commit map dir to match the
> "from_commit:to_commit" format and adds/updates tests to check that the
> state branch is written correctly.
>
> Signed-off-by: Grant Moyer <dev@grantmoyer.com>
> Tested-by: Michele Locati <michele@locati.it>
> Co-authored-by: Michele Locati <michele@locati.it>
> ---
>  git-filter-branch.sh     |  4 +++-
>  t/t7003-filter-branch.sh | 24 +++++++++++++++++++++++-
>  2 files changed, 26 insertions(+), 2 deletions(-)
>
> diff --git a/git-filter-branch.sh b/git-filter-branch.sh
> index 24fa317aaa..9aa07be6e1 100755
> --- a/git-filter-branch.sh
> +++ b/git-filter-branch.sh
> @@ -302,7 +302,9 @@ then
>  		do
>  			case "$line" in
>  			*:*)
> -				echo "${line%:*}" >../map/"${line#*:}";;
> +				from_commit=${line%:*}
> +				to_commit=${line#*:}
> +				echo "$to_commit" >../map/"$from_commit";;
>  			*)
>  				die "Unable to load state from $state_branch:filter.map";;
>  			esac

I very much appreciate the clear description in the proposed log
message above that makes what this change corrects very easy to
understand.

> diff --git a/t/t7003-filter-branch.sh b/t/t7003-filter-branch.sh
> index 86011e7b1f..cf225b0f0f 100755
> --- a/t/t7003-filter-branch.sh
> +++ b/t/t7003-filter-branch.sh
> @@ -121,10 +121,32 @@ W=$(git rev-parse HEAD)
>  test_expect_success 'using --state-branch to skip already rewritten commits' '
>  	test_when_finished git reset --hard $V &&
>  	git reset --hard $V &&
> -	git filter-branch --state-branch state -f --tree-filter "touch file || :" HEAD &&
> +	git filter-branch --state-branch state -f --tree-filter "exit 1" HEAD &&
>  	test_cmp_rev $W HEAD
>  '

I am not sure what this change is about.  Care to explain in the
commit log?

> +test_expect_success '--state-branch incremental rewrite uses the rewritten parents' '

It is a minor nit, but do we want to have

	test_when_finished "rm -fr incremental" &&

here, before creating a new repository that is used only for this
test, or do we expect that in the future we will add more pieces of
tests that work inside this new repository (in which case leaving it
there may indeed be a better choice)?

> +	git init incremental &&
> +	(
> +		cd incremental &&
> +		mkdir sub &&
> +		test_commit first sub/file &&
> +		test_commit outside root-file &&
> +		git filter-branch --state-branch refs/state \
> +			--prune-empty --subdirectory-filter sub -- HEAD &&
> +		rewritten_first=$(git rev-parse HEAD) &&
> +		git reset --hard outside &&
> +		test_commit second sub/file &&
> +		git filter-branch -f --state-branch refs/state \
> +			--prune-empty --subdirectory-filter sub -- outside..HEAD &&
> +		test_cmp_rev $rewritten_first HEAD^ &&
> +		git show refs/state:filter.map >map &&
> +		echo "$(git rev-parse second):$(git rev-parse HEAD)" >expect &&
> +		grep "^$(git rev-parse second):" map >actual &&
> +		test_cmp expect actual
> +	)
> +'
> +
>  git tag oldD HEAD~4
>  test_expect_success 'rewrite one branch, keeping a side branch' '
>  	git branch modD oldD &&

Thanks.

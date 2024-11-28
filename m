Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D832B1C173C
	for <git@vger.kernel.org>; Thu, 28 Nov 2024 17:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732816737; cv=none; b=k80v45AqZl3u4CLxpPKcLSFl+axn+uKel70PFHRd1pSzNpEqFxQXRd4wG2iPUL/g6eSrgeHrt4bnvCMVheB4jl6Uy2HPK1l6ug65NUioovTqa6kMrX8L65eaA48y7NzZqQnF0rysdUGZUj8WefhHgeFHgcCF30IdxV0G/NVmLF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732816737; c=relaxed/simple;
	bh=fVphaGLUgajlQijhNYRQt+eNT9BbNR6OtoPOyuSCBvY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h7vkCjBsCN19rnYa+J5HLrdcJSd8vEaa86CYBiOScNnR8tGt75DQ6cHQOs/DmJq9BoTMWi7okVDrWu1DIYUiw9qjUkc8Vq6g8jq8YTRRBO3RRXmN7hFy2iaHLyzavkLeBVhEdFB1uUa/WjpOgw1tLCNAVRaiVG984lZlrm6lzbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=CRcpmSty; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="CRcpmSty"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1732816733; x=1733075933;
	bh=I5cWcihqXOjFiNK2x69sPq1ous/EPI9NEguhiS09xdg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=CRcpmSty8l1LB9x6ai3jdbrzsqQhjxm6DdB2FWXtLgq4WhKAwuVwJKKsqcZk1x18x
	 zDzqWSnrSb1t07hsJiGDFwAOA0RKB13PSTNpnFZmXkl1gAFFZmBeCc/GEDBaqb5zeM
	 SZXxI/FMr6KvE/Q87fi28yg7w+cR3JY+qD18oEA6qrCxSc8lkoh/5fB1F6tcNZJHJv
	 1UV8u/L91OjEAwz/WPMBhHGeboCwMcJ8nkWvnXmDkqM9NS41K3AUQoPm+/u0pnH+DH
	 EkHayG9eqtX8MD0h6WnHuW7zPj/4WB6oGN9wyWKpchgRrmKkwnzWB3l5slB5xmpHBh
	 TuUzYN4FTC0XA==
Date: Thu, 28 Nov 2024 17:58:49 +0000
To: phillip.wood@dunelm.org.uk, git@vger.kernel.org
From: Caleb White <cdwhite3@pm.me>
Cc: Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v5 0/8] Allow relative worktree linking to be configured by the user
Message-ID: <D5Y09IBPIL5V.2LHPVW07V4ZDR@pm.me>
In-Reply-To: <054b70c2-accd-4d85-a576-66910d35a26d@gmail.com>
References: <20241031-wt_relative_options-v4-0-07a3dc0f02a3@pm.me> <20241125-wt_relative_options-v5-0-356d122ff3db@pm.me> <054b70c2-accd-4d85-a576-66910d35a26d@gmail.com>
Feedback-ID: 31210263:user:proton
X-Pm-Message-ID: df9240c15c58cbe35dbc29eadc9c6cca134e5244
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu Nov 28, 2024 at 8:44 AM CST, Phillip Wood wrote:
> On 26/11/2024 01:51, Caleb White wrote:
>> Changes in v5:
>> - Added docs to `--relative-paths` option.
>> - Added test coverage for `repair_worktrees()` and relative paths.
>> - Move `strbuf_reset` call in `infer_backlink()`.
>> - Cleaned up tests.
>> - Slight stylistic changes.
>> - Tweaked commit messages.
>> - Updated base to 090d24e9af.
>
> Thanks for re-rolling, these changes sound good. Below is the
> range-diff of what is in seen today compared to last week. I've left
> it untrimmed so other people can check what's changed and I've added a
> couple of comments. The only thing I'm worried about is the deletion
> of a check for setting extensions.relativeWorktrees in patch 5 the
> rest of the changes look good, thank you for the extra test checks and
> log messages.
>
>      @@ t/t2400-worktree-add.sh: test_expect_success '"add" with initiali=
zed submodule,
>       +=09git init repo &&
>       +=09git -C repo commit --allow-empty -m base &&
>       +=09git -C repo worktree add --relative-paths ./foo &&
>      -+=09git -C repo config get core.repositoryformatversion >actual &&
>      -+=09echo 1 >expected &&
>      -+=09test_cmp expected actual &&
>      -+=09git -C repo config get extensions.relativeworktrees >actual &&
>      -+=09echo true >expected &&
>      -+=09test_cmp expected actual
>      ++=09test_cmp_config -C repo 1 core.repositoryformatversion
>       +'
>
> We have lost the check for extensions.relativeworktrees
> here. Although we don't set worktree.useRelativePaths anymore we
> should still set the extension as we pase --relative-paths to "git
> worktree add"

Good catch! This was removed unintentionally. I'll add this back in, but
will hold off on re-rolling until we're ready for the final re-roll (or
there's other changes requested).

Best,

Caleb


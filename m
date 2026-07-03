Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B33139AD49
	for <git@vger.kernel.org>; Fri,  3 Jul 2026 09:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783069383; cv=none; b=ahTpaxoHsASg6pLy/95my2Nxbx6nO3AQRyTb5nTHFpEDY4ZQC00d7L1O6gAz10uVdZcu845hfnV9fjGCa6GwdpnFS+fAFs0Bb3rgA905BBLOPcyVtrcFXk0zS+6951i8NzkT57uxBncfQWp7RtRxUXICkYBvrgEa18Vkg5+8HYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783069383; c=relaxed/simple;
	bh=9naZ0sCX2d3pDG7Ucf+f0Ry9Ys+L9/WghKivVaMrpiw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=syLLv23VMSm8YAPp6yQymvFl7DC6RLtcDBHKmd8/TYs4hq5wHbtqZTx9+2seOoPLLCreMD6g0cBCssiXQspzfg9T2hyw2HCWiHA2VHrKCxxax4SDjNBN/kHHEsPbys4boUde2BytEPkNN5QqqA+E4rqJvC779gfgJxDSlfGnvZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=bYv8PHBJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=I1tDOeYq; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="bYv8PHBJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="I1tDOeYq"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 1A60D1D000F6;
	Fri,  3 Jul 2026 05:03:01 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Fri, 03 Jul 2026 05:03:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1783069380; x=1783155780; bh=uJlK3yW7aX
	kvQh02zAgNvjQlAc3HpEKJUyPYL2pReYU=; b=bYv8PHBJT1qOkmscOMOYu8xJ8d
	Sd0uA+ToIYVNwJVPsURuPxr4EO78hE6AomKUhUViZXmmufU+d+PvQkQ3/ZohGSAq
	ul6TsmhqrASzS60RlKJXaJ6ol8dSH2fP9Vczy4fHi0tdK3mBi+D0siTUNPx7VG66
	NHZ1nLFLj65Q1G5yAtci/zpC5IzUNh3ZF2DDsQ5aF/kybofzh4qG9MpzS/skxrHP
	gD5nykDHXUag5vSJulmO6PxsPhY89BBwzWnKT9619pMoLCA8w+cxylSOJcTvJ9mH
	+JGCEnYKCgkaWD6Uo5UZ4DN7mzdRQirkhwtYDA6Cst7e/T1BiKhNkriwbPTQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783069380; x=1783155780; bh=uJlK3yW7aXkvQh02zAgNvjQlAc3HpEKJUyP
	YL2pReYU=; b=I1tDOeYq2yDZUmsNvNduVM5Y4Bm3HOjarVQ7oQb33qKvgakYze0
	oXTyrexTbFKnTswywGWuN5Qx6TSPbtqGKwkRXA8ZPMLU+T0SLDKwfbf3EI5G56jt
	GOhSUlZbZKkzjrezh5DKaxkhE6FGVRKzv4hmfOffWRidp2slpcUYoMY4ohMILw7W
	6lwuJ/FtqIk8DihaTfLpHZtE/5aAkvBhVlgCRJkFpRl0uLlikLn8vER7rdnbGcWa
	6R7bBi/R21FvneuP8HVMlKH/FrxDX6fziAHSMn9i/zHGu76AsibfSF+p6RUEmjKY
	dRw5xhbi0dSTUhsu74b5jh8FC6QIveupX3A==
X-ME-Sender: <xms:xHpHanN6Uyal3ACD8fFWSdO_JdrQiBBMM8xfEUDiJKEBESuk58xlUw>
    <xme:xHpHairjQXx9mDZvyNl2f5vuFNLcbyebptveoLhjnyHytgnL-E6ShIW_DlwP4iNVF
    eDPz5s32W9-_5wbV2r1oRGE3MiFlv04_V0DWb29eXD-F4Ezpjz1>
X-ME-Received: <xmr:xHpHakdJkjiHbG33mnzjwnW0kgdWY8CcAhFhu8x-lELgDvEcMWAbkrhLljpuUSvBYfsywqp1QSmZoB4ltZNa7A2buAt640mCoYfSIcM>
X-ME-Proxy-Cause: dmFkZTEQMHZ7JCrAgazfnAzZ3pjz0OPyddOr71KDzMD5iS9frlIpVfSSE3fWLaETFFozPD
    MpMQHXtCTSSmtvzWvgKdtuhYgo7f0fo18iXeCyS6NUPLHfhMKwCH83h3Kl+s53Knf1ytk7
    hO7sZ01NYM5zc6MVtqpUD2AARJS+um84GGIgEGYhbI4flS2xUr8TD4/0bPzKAgHtnOHtcd
    k4ja4sD2lxKURox6Mg3AXXMGWF9BhT1TIkNDppgLjQKGMb9kn0A9XNEIJHhNH/PHkyG2Q1
    wP/zeWTSVjOIGUEs8jJVCCoSzsUdPo+RLqbKQRh6maAESuBJKo2lksqvsgCrtjDuMQ0lZZ
    s6VjjBL5HfZ55RQuM1/D/1ec233cnqNFvmUNHG76dcU3ToQOjvUwINSPPEMrH5rdavRnFZ
    MypScWcScBvjReiybAxwAntjrV4nrBf2MCGPTaSg8z5rUfGLz4Q7wcNIPIY7ZFrLCgQ4z2
    ZOCeEPq3buo/KVOBWyiYxKTacRLv1Pgd71YlHYpvYND2GNmGEehybtlwAhISS77nrObdpj
    8ltAOcj4ZGdynPy7pd8A4GNGURjBShVPYbhjq3hKllex7U4VTim9cT6ePU1SOVfv5Yw4gO
    FJ+pQ2WT/filOOfw0foIq3Ec6EMou/aNGiH2JWwgWghgu7TT2JjzRVNYfmhA
X-ME-Proxy: <xmx:xHpHagRd4PVzk_lzv7HbMJXrc6jdhBnDl6cFl8nuKeGUZhuKZDBvtA>
    <xmx:xHpHalaOo--MxZTnvXLJPc3h1il-azU4a9nAn7wFjSyI86wCEUUrvQ>
    <xmx:xHpHarfZNVQvjqXmCQhs2d_CZrvopbUoNWsmNmgDNS9omKIShSEuEg>
    <xmx:xHpHauLayDaUhM_3CikD0yQGCUZch2zMnbkSDKa2ZZsNy-zXuuEC6w>
    <xmx:xHpHavQtRMyLUgK1LUrfXhaBJZWNlYM6_vV_-pT2oTgadRUblYcUlkB_>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 Jul 2026 05:02:59 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Chen Linxuan via B4 Relay <devnull+me.black-desk.cn@kernel.org>
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Patrick Steinhardt <ps@pks.im>,  Chen
 Linxuan <me@black-desk.cn>,  Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v6 2/2] config: add "worktree" and "worktree/i"
 includeIf conditions
In-Reply-To: <20260703-includeif-worktree-v6-2-a13893ad9a7f@black-desk.cn>
	(Chen Linxuan via's message of "Fri, 03 Jul 2026 11:13:18 +0800")
References: <20260703-includeif-worktree-v6-0-a13893ad9a7f@black-desk.cn>
	<20260703-includeif-worktree-v6-2-a13893ad9a7f@black-desk.cn>
Date: Fri, 03 Jul 2026 02:02:58 -0700
Message-ID: <xmqq1pdkjvi5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Chen Linxuan via B4 Relay <devnull+me.black-desk.cn@kernel.org>
writes:

> +`worktree`::
> +	The data that follows the keyword `worktree` and a colon is used as a
> +	glob pattern. If the working directory of the current worktree matches
> +	the pattern, the include condition is met.
> ...
> +can be set once in a global or system-level configuration file (e.g.
> +`~/.config/git/config`) and applies to all repositories at once based on
> +their worktree location.
> +
> +`worktree/i`::
> +	This is the same as `worktree` except that matching is done
> +	case-insensitively (e.g. on case-insensitive file systems)
> +

OK.  I briefly wondered if

        `worktree`::
        `worktree/i`::
                What follows the keyword `worktree` (or `worktree/i`) and a
                colon is used as a glob pattern. If the working directory of
                the current worktree matches (with `/i` the match is made
                case-insensitively) the pattern, ...

is easier for those who looks up 'worktree' to notice (without
having to scroll too far to look at the other entry) that there is a
case insensitive option available.  As the construct used in this
patch mimicks how `gitdir` and `gitdir/i` are described, however, I
think such a change is better done as a separate topic, long after
this patch lands and graduates to the master, to clean up both
`gitdir` and `worktree` in the same commit.  So let's leave it out
of this topic.

>  	else if (skip_prefix_mem(cond, cond_len, "gitdir/i:", &cond, &cond_len))
>  		return include_by_path(kvi, opts->git_dir, cond, cond_len, 1);
> +	else if (skip_prefix_mem(cond, cond_len, "worktree:", &cond, &cond_len))
> +		return include_by_path(kvi, inc->repo ? repo_get_work_tree(inc->repo) : NULL,
> +				       cond, cond_len, 0);
> +	else if (skip_prefix_mem(cond, cond_len, "worktree/i:", &cond, &cond_len))
> +		return include_by_path(kvi, inc->repo ? repo_get_work_tree(inc->repo) : NULL,
> +				       cond, cond_len, 1);

Fairly straight-forward.

> +# Use a loose pattern so the "present in non-worktree cases" check works
> +# for Unix-style absolute paths and Windows paths like D:/a/git/...
> +test_expect_success 'conditional include, worktree without repository' '
> +	test_when_finished "rm -f .gitconfig config.inc" &&
> +	git config set -f .gitconfig "includeIf.worktree:**.path" config.inc &&
> +	git config set -f config.inc foo.bar baz &&
> +	git config get foo.bar &&
> +	test_must_fail nongit git config get foo.bar
> +'

This looks much easier to understand than the previous round.

Thanks.

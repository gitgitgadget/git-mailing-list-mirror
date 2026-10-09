Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A5F4498928
	for <git@vger.kernel.org>; Fri,  9 Oct 2026 09:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791536787; cv=none; b=sj9OFWymih14f+tcCJBPZYlVpUjbQmfahX3GCEjjIXz3qwlGELJ5aDnoXX2Pkq4uyj6kR/LXnjcW4s2qZtINgZAFi13VqWir6WtQPfNR+5UDOyQydgMr4Hg4aehybjjjCAL04FatT+yGelzpAgvc2/CLmBnj/ralHVosETpsos4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791536787; c=relaxed/simple;
	bh=O61ylT22cll/AIQXJwdKTDrnWUmPKMknYTPneqY9VFk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cTRSQrN9gOR7qF/STMephp9aNF5oEmo/LBpyQKhPgMRPGz8ZI/NypvOs/ZF1pBSIlhX6ym1IwiBaGVQO7+uKlNNt02k1zysvnkEdBJ+wFM+QBfUZdLvSPMVbHWHJOSSgdzqxaSlk1sgBLhBG9afbuBR9mFKQlDhYz39hp+yTJSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=rjMF/euN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uBmfNSJu; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="rjMF/euN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uBmfNSJu"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5899E14000F8
	for <git@vger.kernel.org>; Fri,  9 Oct 2026 05:06:22 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Fri, 09 Oct 2026 05:06:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1791536782; x=1791623182; bh=h37b+gOKsL
	JwFRq0tqf0j25FTfe/EdFVgEGE3Pjgc0I=; b=rjMF/euNXCfmrx0nf1aeXCNadY
	uRgiFgSYWJprT///Qs3VRinwgc6ivLrzKU8t8st84oYl6ZRRV0oTSDyLUoNZ3AxP
	hw29YjBpMnc2wvOFk72I0/kyZTL3NSol3xuYd9LzEM85YYrWALo0RJFy6yxC2aKG
	Ebfudf0T24K2YX/5kExXgHH1xZfi/fdJdcssolKvyaJDB23oyKyCHm0kp0FK8Rc5
	gX7xnKnf6YJccysUFFSUd9IfAnfF8ByNI8lTG1rXelyYyf13Eg1T/Kzm4TSSTdHi
	tRw+4tsOD/e6UrLaFzTypENMJ8pg3JYcB+ucod4iV2nCof7cbhAxdnv9y0QA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791536782; x=1791623182; bh=h37b+gOKsLJwFRq0tqf0j25FTfe/EdFVgEG
	E3Pjgc0I=; b=uBmfNSJu9fLHkw0rL3RmBRIqpGK7KRLel2oUqM+1R5LOciYghZj
	s0NUr21ad5nHIshTSl6Vwsum/AcyUghqBzZnYuw3bIcfzrsrHnDSKvlfRY8v5ZWJ
	PB3u7F8unhLU1Sl6/0OpelwChL/KaEj8Zh9+5EN+iToTxzXzKQxplAa4p15CEcVr
	6Vi4oY1zrc9tqq7f5s0tTBeYmSWSBjRpKPvWTQZZdviCw3taoPt+jPM1tmsxn39r
	GTEdUjNepgBvts6a+PmzbSe1ph64oY6+1/MSESGsgQz8p+z3OYtsF9Ds0y01TKL4
	p90u4iGwUSfL/ji7Gr9Jmy5iMgzVf8EN6Jg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791536782; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:u0JhV1Mmek8cJuWeo61J8OUDEOKHHaE5XHcK+fJbKCX/qgj
	yECBh0NmsIjCS3vhjv1MpWcyOmQv4oJTm/d8V4h1qcaw7VVyynKCitnZDnyakB8J
	J6b41gchJKZPWvN+RRZ00O+JNMdFg6aIWRQmSEEFTlOAx/yfI/gmxEm9CM4md1CR
	V5fr/yjQID/gfOc1HBb1/tV9wu+Lt1Lc+TNTFzY34hUyfjtL/eXufQr9m4gRWIdT
	Fp25svwytMtdrS6fSbkqUcvIh1YybBkObR6ReOKBftwzuRCdlDe6p0mC0Ws6/Z9H
	6ARupP9YtT1ziXagzYrm+/znHMBoUzuL3x5oj3w==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:pSsDkKH3MJqYuLU5nu3X8xBd6ueCDbd6bHvKjW4Uv9c=:O61ylT22cll/AIQXJwdKTDrnWUmPKMknYTPneqY9VFk=;
X-ME-Sender: <xms:jq7Iagn53K3flTCJLPeBV5iiBQrDxuH8nOFpqSxUI0tDyEkrnMXnPw>
    <xme:jq7IapKODdUreC9NZVF2cL7fgPSafJwecxCcDgC7aczHXvQH7if19mcscL63IVvCc
    EkhiSw9qXnERVZ5d8o_FRLZwWI4CakS5FGVYQxnWZVwWpGqPG5gu4E>
X-ME-Received: <xmr:jq7Ial6v6lX6BAFw-DJquobEL1iI0ba1xL_FEcKf6esCVTZ7sEMBh2ygWsa0bLyRdhRFlw>
X-ME-Proxy-Cause: dmFkZTETDyWyfXbf1rWyL+SbBlkN01JdmH/IuS5hBcl/amykqQLGubvJvnP99c984Ywn3M
    /MLmrT5CNAFee0nkGbNFlUSCcaCtl72Doz0Qy095f20OGvOKq1gfhPsPwrLha7xulC3639
    zXmZkCtCna6WSEKVcglUd5qQLK3jp0QxdV+aiL1WoFEo9gwkcFtSo1KMa7bGel0ig5ljft
    lqL6uy6KvkhOqhb6BZdTLUiUbCArLFBCwtuvVyrabbriyJUcAHEGNlKCFv+7iQlMB5uoIN
    1JQwBMZGN4TwlrwZWaoCSKFoGe50POwnjcyvSvxj/3FDgLIQ98fYhGJu8derJAcyJjFit/
    MgF0N1qcUwRwBn5zHDde8fKRSuS4uwZZtSjNqEi+czFdQM3M2zyP8Fv2/0LcUW9NZX9wW5
    tu5UklvHXH7wSs3BKsZCR7z8vEqk2y6ckR9eELO+drj7bLrIWTqy7wHoZa2VBHUoVgsbl+
    Kwm8NhC/p0yo2Ense/xMylWmsgMJFwHyEJCFOe+46p7SmPdrKIjxFZaa8PjVEkF8OWqRah
    i2TMRYLHqLqC8Fpv6OQSwNC8Ab4jjK6gSSGl1R4isz7Px5bY36z1vWXuvXg66GdkdS3Dhq
    zXEFg+bTi7Fq5UGSJXvOq0K7+xVdGx9RCxR6BaGmZvywZCckmhGNg2V01Q5Q
X-ME-Proxy: <xmx:jq7Iat09UyxRSpT-6WE_qg57jdFsIZ5QkHuk2NEIeZ5Zkp2w6TwVcg>
    <xmx:jq7IardbymTMsK3iuULFWhk2QCWeolaZ96Sk0tkfeParzsS3XYKSpg>
    <xmx:jq7Iajd7EfbmnRRQBkb4I2K5i1WYKKmBdC3xN7BCTVLJAg7o127Npw>
    <xmx:jq7Iamy8HK7jHadm5LxVOrZfaKQ_deF1KruG93BB_AbIPFdzl59owg>
    <xmx:jq7IapAXWLtGXYl7bf7FAsI9b8MYIEZrI0I-JkOPghc1dluuIXNyNctX>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 Oct 2026 05:06:20 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 8a6be758 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 9 Oct 2026 09:06:20 +0000 (UTC)
Date: Fri, 9 Oct 2026 11:06:18 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Thomas Bachem via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>,
	Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Thomas Bachem <mail@thomasbachem.com>
Subject: Re: [PATCH v6 3/3] rerere: go on at a conflict when the lock stays
 busy
Message-ID: <asiuemA6ouAW9NXy@pks.im>
References: <pull.2214.git.1788337897490.gitgitgadget@gmail.com>
 <pull.2214.v6.git.1790939492.gitgitgadget@gmail.com>
 <cd018289bbb330753e41a1e5b6156b6e85c12dbe.1790939492.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cd018289bbb330753e41a1e5b6156b6e85c12dbe.1790939492.git.gitgitgadget@gmail.com>

On Fri, Oct 02, 2026 at 11:11:32AM +0000, Thomas Bachem via GitGitGadget wrote:
> From: Thomas Bachem <mail@thomasbachem.com>
> 
> When a merge, rebase, cherry-pick, revert, am, stash or apply stops
> at a conflict, it runs rerere right before it returns to the user.
> If MERGE_RR.lock is still held when rerere.lockTimeout runs out, the
> command dies there. In a rebase, the sequencer has not yet written the
> state that "git rebase --continue" needs. A later
> "git rebase --continue" fails, and the "git commit --amend" that its
> message offers first folds the conflicted pick into the previous
> commit.
> 
> So warn and go on without rerere. The conflict is still in place, and
> a hint tells the user to run "git rerere" before resolving it. That
> records the preimage or replays a known resolution, as the command
> would have. The hint is under advice.mergeConflict like other hints
> printed at a conflict stop.
> 
> Everything else that waits for the lock is left as it is and still
> fails if the wait times out. That includes "git commit" and
> "git am --continue", which run rerere after a resolution. When they
> fail, the rebase or am can still be continued.

Is this a commit that we maybe want to defer to a later point in time?
I'm not yet convinced that it's really necessary with the other changes
that you've done, and it feels fishy to me to just skip some operations.
So I'd propose that we drop the commit for now, but keep the option open
to reintroduce it at a later point in time in case where we have users
actually hit the issue in the wild.

Patrick

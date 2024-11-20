Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9544317C91
	for <git@vger.kernel.org>; Wed, 20 Nov 2024 05:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732079617; cv=none; b=V+D+fkgzdZypPeaj/WjtxXsOZIhBhA45kIXLLJoCi55HwnW7CM2398flU2DaWP+HUaw3wWrOcGTo3ovafIeqMPe/Byj+NHtx9ohPK0S9kTHB2Qy9CKvxO4gE87ovKHTuLDa3767maQ4fF0/l4XxqZprWiT8cuBnxyDqgBcHujrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732079617; c=relaxed/simple;
	bh=QsF2zhsxV7KwYfjirM1heLySPgGrWw5BQSPYDFfCVo4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hbpQ61FclcIz3ViHtaIgnr/EZHkij0tFXcZr0dg9kKSdvx+0g6q4Og86Mn+EHoVped32nEq4laz9zUzWjTElE3qATOitxasvkFbYGY7AKBCvw716gqhoC9SFjWruvCIytfAiAq+RjNjY7E3xp+XpsRC7I0qewMuzYOYEGrFmWOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=Az6Bsx/G; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="Az6Bsx/G"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1732079607; x=1732338807;
	bh=QsF2zhsxV7KwYfjirM1heLySPgGrWw5BQSPYDFfCVo4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=Az6Bsx/GLHV+03LRvMqVwUugAdx3ifANh3yI6OPQ69DjnLcgcsuBCUDQ+0V+gXZ5h
	 4V5aY2YAm/xB+nuoAFuAoyhHzFA8zGe2QmChd1jNO/bK57VJXOxqsy+XVg3U1wJVJM
	 nM1tpp0R1ZKdW/nCznebm7IiDa7362COUBYmqlnwiDtj4eGoc1/KO1wkxkmQSI4cTn
	 4C1B3lxWNvY1Js4HcRyPMZX/GxcraUQlUWCwlZnH7GsIu1j11dWwSls57l2h050KrD
	 As/ZC99kTiKQk2Nrrr999qGP09tBczuoHu21XU9l8iSmuslLewSRKuko0tA29Pvzm4
	 Rb02ZMWLwfBeA==
Date: Wed, 20 Nov 2024 05:13:23 +0000
To: Phillip Wood <phillip.wood123@gmail.com>, git@vger.kernel.org
From: Caleb White <cdwhite3@pm.me>
Cc: Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 2/8] worktree: add `relativeWorktrees` extension
Message-ID: <D5QQZ2X595GX.2FRO57TTXZ548@pm.me>
In-Reply-To: <47f2b6bf-1e10-4b01-8365-467cc5ca7779@gmail.com>
References: <20241031-wt_relative_options-v4-0-07a3dc0f02a3@pm.me> <20241031-wt_relative_options-v4-2-07a3dc0f02a3@pm.me> <47f2b6bf-1e10-4b01-8365-467cc5ca7779@gmail.com>
Feedback-ID: 31210263:user:proton
X-Pm-Message-ID: 8495a44d6dd6c26feb02bf82e8a517b821bd92b1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue Nov 19, 2024 at 9:07 AM CST, Phillip Wood wrote:
> On 01/11/2024 04:38, Caleb White wrote:
>> A new extension, `relativeWorktrees`, is added to indicate that at least
>> one worktree in the repository has been linked with relative paths.
>
> Out of interest what happens in the later patches if we add a worktree
> with a relative path which sets this extension and then convert it to an
> absolute path? Will we clear this extension or do we leave it set? I'm
> mainly curious, I don't think it's the end of the world if we leave the
> extension set.

The extension would remain set. I was going to try and unset the
extension, but it is only safe to do that if all worktrees use absolute
(meaning they would all need to be checked) and I decided it wasn't that
important. I suppose the check could be added in the `repair_worktrees()`
function during `git worktree repair` if it is deemed important.


Best,

Caleb


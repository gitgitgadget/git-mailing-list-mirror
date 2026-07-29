Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F6C43AAF46
	for <git@vger.kernel.org>; Wed, 29 Jul 2026 15:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785340325; cv=none; b=ZW0sBbLPniCUhGjaZQWwBd41DSZ8Kj6Gycxx0dgVXmt8hPdOEA+OAMbU/zWT+UKauce/Brn2C8GD2W9cx3SXjcMFHoNWgnmhBzdh0oUKES3SOtDMlRm06eWjMg2jI3mM4e1ch4k3eKUjsoxu+XRuxenCl0OYSl9QwcJSPXQhWCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785340325; c=relaxed/simple;
	bh=v1gArYaE3Q+WsbcVtIz/jWxJ04gXur/hhOKUnhoMfSI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YdCMtJEsjCHApX+RHx+xBQJVU3XPMDhPGj6cI+ehYcBVQHtq9EMXAvGcMkT+0jxTQmu6yqqvzuyDlFMNy8/rNKQDG25Hybp/OGNaElhYjpudfgzVQ6vTvmSouPWQwbDMb0nzHZ3svsFpzYaqKQz5buQrmE5CTe8AC3zLA8opdss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=egKLf5g5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OQ0OkUaQ; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="egKLf5g5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OQ0OkUaQ"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 889CA7A003C;
	Wed, 29 Jul 2026 11:52:03 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Wed, 29 Jul 2026 11:52:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1785340323; x=1785426723; bh=Nwi8ecGruT
	syGuOT/3u/t8WUhgdq/cnZjSdzwXUNxC4=; b=egKLf5g530P2Yv3kpwZFG2PxTY
	l2CDtTHHdqdPdUFk7b5H+/2FkRAAnvvUNEjPrQ0mXWj+lmcOjSxSLtJKKqcXOE6/
	pTX7ncHgzuTuHqEasSkLrf/NUYcS7/l81LPcfpTEi2U77k4cgC96pHjyDAjqBKy/
	LSfzehBfeluv++J3ngr181HZ6Ga7pgzLQzUcfI7o9FxojIxiRyamHhT7HU7zElc0
	Je80pNvIT837T1MQHZ8LLNQD9+RdLv6ndY54kILdzNyUGjys9nunAEkQB8R8f2/z
	0Y+KahpewIPX7ko1Q79do8D/neRdbmDa/MSlpdtUkfRWjYh77S/bvORdgIsg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1785340323; x=1785426723; bh=Nwi8ecGruTsyGuOT/3u/t8WUhgdq/cnZjSd
	zwXUNxC4=; b=OQ0OkUaQ9MVkBRAjLuSLe/dLwCYk1jpxAHTwKKf+q2j2x+37WX6
	AQvUGqXpbU1qQmVQJjtCz2+0Hnjc3YThVTzM6y6Fkos/fEEhrva39fLhT38MEXFl
	bS4eejopB8C0KlLuuSIj9fVTILkE39Hst49AkSlWZXWuzHNrcL3nWyQb7qRtXrFs
	RtGfLwc2vgR2VlXR8AOZwydM3C863riC8naoS03A/zhi1gbgo/m2h6JbcuYNurrw
	GhkZMB32NsVu3hYtkBx/S8mEHq//3fAG8On3Go2HFURNUPIVuhAfJTNpWhcErK91
	qdRVn3qyPSJFZEItoz5T3jwA90MmsHheZqg==
X-ME-Sender: <xms:oyFqaleq27mSCc1MdZJIWqr6cGR7_jVh41DBPq5IsyhdtN2y-X8ntQ>
    <xme:oyFqaqqol6mAYs3bagpaRKiQ3ifGcG4d0pUG2hC65l9NRlDynNPbBiodJaOHx9sim
    Pq73rUaQ-lrIdD9yrmmYjhAAo3difOB_VzMEQV0H6Ddp1fqcacDiK8>
X-ME-Received: <xmr:oyFqar6UUZS27Pqr4sjTkv1W7GsiCUuKkh25c71v1Ls3QFFrl6-YAgLQbUwIlYrpEpCT3D991rTeVy-SAsj9FTv6-0Qg0m-IBA>
X-ME-Proxy-Cause: dmFkZTFAZtC2LoqtqpP6HS0iPOp+SFpmKXLbszgXDRN9G9FpdyxLMmeuJLf1yK0sZ/nHN2
    ywK6EKymg3PDyvwJ1NumYXvzxMWQeuteinz3hmxKz1+CEpim/N66yMfOdHcurteF1RM1mM
    SJ+lzDg4v/WZFEG4WwR/AkuQF2y/tgNlDJSs7HSd7DwMmItvA0lvJ9Vi9OrjkhKJ5jxuis
    CI+ZwrqihiJFibEYarcP63WOL/0b7ZnXFmlcsa/1hor2f6c3/LhbiMTJOL0lLosvYK9Sw6
    H1HlGMHTdD0WfXTCFGET20ln0RgoETjaYRTXCq5E9QIG3KunxSYZJFwPYkXcs4xvC4KklY
    6AmLZFfHnmktaIJn8x6/CiotNljRg7ZxxMgmYIsiNZN0BGySWOVdpuSE0tAewmdHz7scsl
    rvOYnI+4RlYXsJixNeeFBuacVf2hofE4WQ/ty2zkH6vrScRjnICh5KZSMXyAs4GEoc24St
    D01R50PdAVZcmu95WOKNoH3M2S82lFN15Ko28uoqXmhuv29eHPB54ZNsBaNU3ThDkkqeNQ
    gtkXKfJBDVs4LcXDwlf+9ex+Scjm+HcDBVrzh3q0igzBSP0faNwuHYgVhVfngZSzEjPOvS
    ax/vR1px+dpk5JVNxq4kf97PnjLQn7EHFZWvHpU5sXtC7AhGs/VIynh5w37Q
X-ME-Proxy: <xmx:oyFqaoqMUT4asFAuPe5p_T9DBKj7RJOAZ4P0TSgb8M8uZ1h3P_y0rw>
    <xmx:oyFqalhOlnLaAeOtrCM-7pvfrU1HrTWkDQkPNXEINaNEi4L9jVt43g>
    <xmx:oyFqaqLsE2ibAeW1ZKF-NTpA4QmokDLDcAAlvRMPMo0iVQdre6EuGg>
    <xmx:oyFqatBWQEZiW_Jteu3Pq5zEnubf85u39KQ-QwXuhllL7USvPSkJig>
    <xmx:oyFqamoLxV8aAFSluin3CVL6jz30AiZMY03hxWe89uAV8Fr5Y1WicLVm>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 Jul 2026 11:52:02 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jul 2026, #12)
In-Reply-To: <80bd230e-7b8c-41d3-af1c-fa84b0c7b1c4@gmail.com> (Phillip Wood's
	message of "Wed, 29 Jul 2026 16:14:46 +0100")
References: <xmqqfr15ruw7.fsf@gitster.g>
	<80bd230e-7b8c-41d3-af1c-fa84b0c7b1c4@gmail.com>
Date: Wed, 29 Jul 2026 08:52:01 -0700
Message-ID: <xmqqa4r9aj4u.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> On 27/07/2026 04:09, Junio C Hamano wrote:
>> 
>> * hn/branch-delete-merged (2026-07-25) 7 commits
>>   - branch: add --dry-run for --delete-merged
>>   - branch: add branch.<name>.deleteMerged opt-out
>>   - branch: add --delete-merged <branch>
>>   - branch: prepare delete_branches for a bulk caller
>>   - branch: let delete_branches skip unmerged branches on bulk refusal
>>   - branch: convert delete_branches() to a flags argument
>>   - branch: add --forked filter for --list mode
>> 
>>   The 'git branch' command has been taught the '--delete-merged' option
>>   to remove local branches that are already merged into their tracked
>>   remote-tracking branches.
>> 
>>   Will merge to 'next'?
>>   cf. <xmqqy0ez14s9.fsf@gitster.g>
>>   source: <pull.2285.v23.git.git.1784979136.gitgitgadget@gmail.com>
>
> I've just left some comments on this. It is almost there, but the way it 
> checks if pushing a branch updates its upstream looks dodgy to me. The 
> behavior wrt branches that are merged but are upstreams of other 
> branches has changed so that the entire hierarchy is now preseved. I 
> preferred it when we only kept the branch that was the upstream of the 
> unmerged branch and deleted everything underneath but I'm happy enough 
> if others prefer this new behavior.

I don't particularly favor the behavior in the latest round myself,
but I doubt I am the primary target audience, so I'll let the list
figure out how much we collectively care ;-).

Thanks.

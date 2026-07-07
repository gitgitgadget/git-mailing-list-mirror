Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E334B35F184
	for <git@vger.kernel.org>; Tue,  7 Jul 2026 20:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783456024; cv=none; b=qrLaB7w7upxnuCWVU0z5r8Y4fxh3+5iP5K2EGLqXQjW30v0qEeED3uF/U2Wt2rQr2au0lfPKKrSLHrAFGUrcg1cZZG2MY98ujePQcw5eAeaE6O7NhhIqPlaigLw0W5nLFFKSPwqiLuj4coMJf0tRGU+1TOD7KOAsvKMDYsqxGHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783456024; c=relaxed/simple;
	bh=9hkQ7tASGpABZsmcTWCMz0WMPrkQmL0+g3wO7G+dcOM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IEN5+WLLLazyvZDLPeizDCQ0dKToFPXGLTxY/1C23Qy9QkORNema0x5vEJNY67o/pZXNgS3UUftOqywCunus6n2tRXI9DLfrrkRNPWfqN+o6Jr4+xtRhJEC1zvaJit7psJlFNqzC9vua+xr3gdt3Oxo4ZV/MpaU3jMkpXObImAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=U+YXAtfj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=S1RpfCfk; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="U+YXAtfj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="S1RpfCfk"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 306E9EC018A;
	Tue,  7 Jul 2026 16:27:02 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Tue, 07 Jul 2026 16:27:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1783456022; x=1783542422; bh=WdpIBN7lzT
	sDWoT2Y7ZoPQpz9941cEi7IGbkYftP2EU=; b=U+YXAtfjlenJUH1AXo5FAGbBpu
	sGpffQz/zEKcced3emEDPioqMYTi3RzDZtsmLrfjQg0XkDHGWfFjHiTYUAGj/4ab
	zZl27kXeuijvQoWlUZrHOEATaojWU5+Dk0MSihtMMmtIl3z1/76FCnrRMUsoYLe2
	r1BtYPgWbv0O3XWSG9Zpq8488Kjq/hVP83ODqn0jTXse6b/3EE1QHz8Tejk/G2rd
	MSFv0TkY7uO9qUJTWjm2j8k1C6wpZSTHWEuMIHjtBXiK0Xsd9pZvGq58WIt2r8L3
	LIyGmpARq6oXKy4AFBjxOXZpUdZZQbMcyPNaX7sY/TA4k+vJKenp13Yoo//Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783456022; x=1783542422; bh=WdpIBN7lzTsDWoT2Y7ZoPQpz9941cEi7IGb
	kYftP2EU=; b=S1RpfCfkJbN+WTMSNx69yw0Mh1M/51kkN1JaKHBmBGWhVN2OPdQ
	fufSgdSXSlOd9bsEk9jZhh3j2xC/JGBlALZAPDvueKjlA8mFzoF1QCkZLqYnsAbU
	gnQ2KgAVJ5Ck8CDe7sPbyZD30J+u1+Dw2scFbQd65sIBh9QnCPN8vWLD3gLbl/dN
	iXnTxRu1S8QNAImnFnewHtlWTL6b31uhgKiNjSJTqoRfPDherlA0yyUrgyFV6mAS
	NKogYEgrxQOhwoCHuKrPdaBGAIR4yUJMEbIXGgpUFVAZfxDeQ0UsjRYg7fDZ/8oo
	h2CKsQpjTTOJfJV4BBdPel7lDxN7RUDDovA==
X-ME-Sender: <xms:FmFNap2GebS6oDjl5MWG1mLJoieITIKaudEtuifZ9NP7e344_l-T_Q>
    <xme:FmFNanhWPfdtNS0YEReToXEpqqP_HGlfq21IRj6xbt4mYPcZZDzeNJPafMcsGisd-
    usB4b4Uxgd-6GUNOnlfdpftePV2-v8l6uQaNHC132IpteUAqYfgeg>
X-ME-Received: <xmr:FmFNanSp61s5Q8RADi2VALMxMQY7fal2vt6oAmjO7jMH9Iqy_SR-W1yvGckb4s-iiI42G9SmSDxQ4lgRmiYybHZoQiQOoWNrP_S9icY>
X-ME-Proxy-Cause: dmFkZTGgSylfT1WTWsNwykLtmw2/c+lIrKP/3qAotXtg9e/uaLt5BmBmLjD+KvVnHgXUhO
    KqBV+qRxDWNIJHi8Dj0+eUGm+IxAyvn/1jsaKdAFiHTZ5dQVPUYIOQZLEH2gHSa5fhZU3s
    rYjoH8WE2ulsQ+7aHdvPccMDNkIJXlg97raYD+rVPdBaUFTb3oVu/d5fDq0dzV0tQJIS/U
    rDAwPi3r19ouzJfXqp1pSrklqwdtGPWl21N7AASFGiRz5lzu48iddVGVs3D6ir36coY7dK
    tEymLpST63SRIDvz561s3Akze29t6RiLWsjS41tbrn7UdwflS2YOXZID8TvxM1Q5224RqS
    GZ6BUAofPktUwgm0MpJS2wrtqZo/eNFBU9k3reUAYry5KVtpdz2jxOlShc/IrNjfyt6lHI
    ZqnRIpFJzNQ/uKnFk4j4aDgSeFG54/awq4cJeaejyg6TXDo+Z/a5AmgshDqyYo1cW/HSYG
    SdAyb/JkRs8ZJliCWf3BBUINZUDHuU5XpG/6AYrWF8Grla4WZ7Stth6o/zbtqYRnDIcaM2
    FhhHicrvhzwsTphVXS8p1YCoycmXHc4pqoC2SHMkaN8ntRPZDDlHWjw7DgtwgEg9vBxiIg
    3Ku7fgK8yO3NBT9VbUv9QwqpYqD2b4E8vkuKg2CX1UOIPrz7dyzyr0OxOhGQ
X-ME-Proxy: <xmx:FmFNagjiT5Wp1G2p2Bi3UW1Qcr5TQ_zFIa39VXl3d0JiNtoaADppOg>
    <xmx:FmFNav7o1xFYZUWaOtwVWkdXAGqTM_NYl8_jvXILUP1B9ZQGDFVw1Q>
    <xmx:FmFNalDp-6xLwAC94UE_J4cta0H4ZuKOyKnW_810Qv-ytVNVpwcrZA>
    <xmx:FmFNauZAc94BGKyo67E2MulUoo1E3V5C8bPDiRBe3Vqz6AAPgWnfRQ>
    <xmx:FmFNanpg_cFr-bFbPF67NOmj07ngwJkUd0T64rMARno9tH4bi0ya2qHa>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Jul 2026 16:27:01 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 02/11] builtin/gc: move worktree and rerere tasks before
 object optimizations
In-Reply-To: <20260707-b4-pks-odb-optimize-v1-2-aae607667be4@pks.im> (Patrick
	Steinhardt's message of "Tue, 07 Jul 2026 17:32:34 +0200")
References: <20260707-b4-pks-odb-optimize-v1-0-aae607667be4@pks.im>
	<20260707-b4-pks-odb-optimize-v1-2-aae607667be4@pks.im>
Date: Tue, 07 Jul 2026 13:27:00 -0700
Message-ID: <xmqqbjci1r6z.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> In subsequent patches we'll consolidate all tasks that relate to
> maintenance of the object database and move it into the "files" backend.
> The relevant code is somewhat scattered though, as several other tasks
> are interspersed between.
>
> Refactor the code so that all object database optimizations are grouped
> together, which requires us to move worktree pruning and rerere garbage
> collection around. In theory, rearranging this code can have an effect
> on the object database optimizations:
>
>   - Rerere entries really shouldn't impact garbage collection at all, as
>     these entries are not stored in the object database.
>
>   - The index and HEAD reference of pruned worktrees may reference
>     objects that become unreachable.

Over time "gc" (and more prominently, "maintenance") ceased to be
about object database optimization but about general housekeeping
operations to keep your repository healthy.  rerere database,
reflog, packed-refs and reftable compaction are all outside the
scope of object database optimization.  Grouping these inside the
umbrella "gc/maintenance" framework would be a good first step to
make parts of them pluggable.

> That being said, the impact should be overall rather negligible. If the
> user was asking us to prune objects with immediate expiration time then
> we might now prune objects that were previously still kept alive by the
> worktree. But besides being a very specific edge case, it's arguably not
> even the wrong thing to also prune any potentially-unreachable objects
> immediately.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  builtin/gc.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/builtin/gc.c b/builtin/gc.c
> index 77d0a5c948..8f568003ee 100644
> --- a/builtin/gc.c
> +++ b/builtin/gc.c
> @@ -1011,6 +1011,13 @@ int cmd_gc(int argc,
>  	if (opts.detach <= 0 && !skip_foreground_tasks)
>  		gc_foreground_tasks(&opts, &cfg);
>  
> +	if (cfg.prune_worktrees_expire &&
> +	    maintenance_task_worktree_prune(&opts, &cfg))
> +		die(FAILED_RUN, "worktree");
> +
> +	if (maintenance_task_rerere_gc(&opts, &cfg))
> +		die(FAILED_RUN, "rerere");
> +
>  	if (!the_repository->repository_format_precious_objects) {
>  		struct child_process repack_cmd = CHILD_PROCESS_INIT;
>  
> @@ -1038,13 +1045,6 @@ int cmd_gc(int argc,
>  		}
>  	}
>  
> -	if (cfg.prune_worktrees_expire &&
> -	    maintenance_task_worktree_prune(&opts, &cfg))
> -		die(FAILED_RUN, "worktree");
> -
> -	if (maintenance_task_rerere_gc(&opts, &cfg))
> -		die(FAILED_RUN, "rerere");
> -
>  	report_garbage = report_pack_garbage;
>  	odb_reprepare(the_repository->objects);
>  	if (pack_garbage.nr > 0) {

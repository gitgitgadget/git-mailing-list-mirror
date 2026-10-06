Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 512F74A33F5
	for <git@vger.kernel.org>; Tue,  6 Oct 2026 18:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791310861; cv=none; b=XTgiDh3MeHzMd95sms2fYF/QrVOKNBoKVH6xb2KB8BupNiOtC4Efae9L7aglwxcGtT3hWnFiTRsfB2ZXj8DOyUuaYwlDCUgHLODLdhJcNRsXO56vfOml588werFHQJHj7h6qWYzbC3DZWmh2MVmZ03w8UBDoe3e7umiK9IObqF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791310861; c=relaxed/simple;
	bh=rhjepCubF2XEKl4sRKKqMDqXd3KzaFny7BWoA78bxLw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eOz+rtWpu3pooS8e77PHLXBLs+r0Ctues9Eow+KVCkwjU48SEZpfBT43p3LJQygg+EeW/v1RbQbD07Pyjoj/aVWZ+8cjABWDdckJid/Z8WaSGiq4ecX0NnD79/yjyDuJgoe58/QG2iOqDveyumtqMbZj+1TRwMjBpaM+MuzdJrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=hub0HLCF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=R7d9svxF; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="hub0HLCF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="R7d9svxF"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id A4BF21D00180
	for <git@vger.kernel.org>; Tue,  6 Oct 2026 14:20:58 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Tue, 06 Oct 2026 14:20:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1791310858; x=1791397258; bh=+FwrUe9Mjr
	8erDepuaNWwUTQorlekbaR4XI+/iSQGMs=; b=hub0HLCFaRoMNCrNe7AUEmC7qY
	LFlVUSxN2gf+oE/0VOXuoiA0SEu+TDLoOxwBqeyi3yR2fHK69AOgOGqF36t1xEG3
	ozhSxBVYtIT93DLJXMs+iraDO3JgBYoHPxQEvVWLJ8HDsyW2R9J+9uiTE9XR/B0S
	ssjcSrUQCeGjJSbnqEnHYsF6q7nq2fPK3s0TpcKZIVuWSCIOhP8oEDE+BxTSFg98
	iWpPhhZWC3GB0t/Oz9TvmNeNxiTcev+wt+SyBU0arq9M7Q0SGnncE4HtUTw9TvcI
	luIb+l1ACWWSNKXWnPuitztRTLWXDlSgG+dtDCj9OvXiFbyvu6ieAO+COK3w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791310858; x=1791397258; bh=+FwrUe9Mjr8erDepuaNWwUTQorlekbaR4XI
	+/iSQGMs=; b=R7d9svxFq4c/EeXfQ8Dp9XSrYYa90BTou/t8hFoaWUcThUQjZhX
	lybJ0t3UpopHXv1eZezM3hx46f+obyYJXuu/eTtiU2mMMQwafU62+Am5/4SMCiOb
	1F6QAVgKWV5br8kfC9fbDJkdxWp92onqkAz+iyuvm4CdRrPpQ+1FwlQXdXMOl65A
	bODA2FEP3HFtmEN9LRbYgqhRI4gNShPdn/50nCyKtT0ZVskfNN7fJoYyTrYwo0CM
	LOwR/gNNYTYHQ4Tc7GR+jv/cInc1b8zeW3dzoxQzR1Ubdv6sLs5/1RNuYrECSnE1
	QtU7x+/XubbxjYf3/2LsIMF9voU4Mp2vJtA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791310858; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:FSige1wK5wmHzAivg8xEAKPuo3o4qVDKG6k7IEz3ctJQS8V
	o5/6aXAfChPO3lOPBhxBXPb/wOtA/VM01rREzSoVl0MavaA38qoS/dvD1Kz5b7gF
	mHHIoA9szSvTJ+PNVHeZuJKiO5v02gvunoVvPjgBa9IgOt2LB1CmHLWGLe8zXULd
	eqmOFlb5xb+crKBO6M6G7b6fVcibp/YdqmTAc7iy0Uh7zT1mCmyXHLb/Fk67bsPG
	/xAJ+cXk0Pj/ndlNY+2v4dlbGNKcjs3nnHh52rURkeG2yPSe6ZkM3uFqL7t6yJ3s
	M5Hci9Y6keop9MbOewWMnu2jbLUiUhDw79GT9gA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:YzJnOwk2/bPlF7pzmzRiTyo7adodQWpFJbLXG/Tg54k=:rhjepCubF2XEKl4sRKKqMDqXd3KzaFny7BWoA78bxLw=;
X-ME-Sender: <xms:CjzFaioEyK_WSSI18-XE9DnzaVOgheMQHOvBVWAccBqL6KwK3ZXr-w>
    <xme:CjzFanhozOndhzWY-3VFF-AMkzwt3pvqNxmh2hU4tRsGzqLoyqZBI5OYxrPQdF8nA
    9fbjTClKGMuU8ceaRj11xM100u6TIACHJjY1XNcW5cC_XLg1iHxpmY>
X-ME-Received: <xmr:CjzFavjdljPmB4w7uUPub9fiqlJSASsM_EGIdoJ1CB02EJdI3dUgIQGllN1gaFSixbSyajXOrluc6aDUYWgOqAgqu8sJEQQrLipH>
X-ME-Proxy-Cause: dmFkZTGhllY/xbcH5HCzaYbb+gqVaqJqOYe/NDVbUOWrL373ZNnsA/4cSXBz1EBrXzdz84
    R1KwmGcAscPlbQ1126SwERjDdZT7Xbq/G5eHLaqNTGA3B29NWR2h8VodcTHj7+Hy6LN2bo
    xOUcalQzTfUIFozCmWh5I9ao8B71rn6JYIx6io7M3KkfSMjrCc5ofZqxbGMxofvCmfQmnY
    3Hgc4d3/iOJzBmBi7wzC8YmjhlyChyBdW57G2EDkG4vtl1aViqnY1Gaxq0bragRFSBbqrV
    Gqkzy4shy3Kz7+FLcu5FIz66YPIKFWPMQmMK1Vww0D3y/g8HowIF1Kf+cyvonrB4J6d3Iq
    sNtij3A9rexGv8pOe/QG3oKcETDlqILlilkNg7wYrpkpCWSiMHlJL3fHcWO8Jbsd7zlBd5
    SATL1MsD0JsRnRib0iOiSx8PEv1J0SPN1X9SyHwHvUMjoI8VoKYR6ZXGDWoOlQiu7gez1G
    bE8yiAt1QEWfPxEwq0DgYNacC3n6bSvU8Qg18bTfDg1Q3NQVOPDnX0WVzBrJ810aTPe19y
    HK67/d7YVuXV6+58oFx2j1QTh6L+vOAZXcqMLfgILIW7YmTWScb6CO1aVgSiRwBKT0tJ53
    D07Wa+plMYcqQFBUv/q/S7cIa11kydDrgAlHAruV3D6UOyav1C2UJOw4q+EQ
X-ME-Proxy: <xmx:CjzFath86rj6WvE7BRWXQWFlrZxx4rITlZgWx_VYfrRQzzh9j2PpWg>
    <xmx:CjzFavL0NgT0QfZhnD1iXBWn8jfv64pqk65t-bx_t9eMS-izBAGFwg>
    <xmx:CjzFasEQjNq8sUOTDwmaUrAmVTCsjcra1HhJJ4mTvGSkNWkiSd-mpw>
    <xmx:CjzFajTQ1QqfWIOLeJzf58RuiLQgHhNl56O33wqorwoT6cAEUyoTHA>
    <xmx:CjzFagxdXJ-bA11D_1HwpQeGcW6OYoiR3F2h8pjVSQykoQI7XdbNI8UE>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Oct 2026 14:20:57 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,
  "D. Ben Knoble" <ben.knoble@gmail.com>,
  Julia Evans <julia@jvns.ca>
Subject: Re: [PATCH] status: suggest `git merge --continue`, not `git commit`
In-Reply-To: <pull.2249.git.1791291762665.gitgitgadget@gmail.com> (Julia Evans
	via GitGitGadget's message of "Tue, 06 Oct 2026 13:02:42 +0000")
References: <pull.2249.git.1791291762665.gitgitgadget@gmail.com>
Date: Tue, 06 Oct 2026 11:20:56 -0700
Message-ID: <xmqq5wzeelmf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Julia Evans via GitGitGadget" <gitgitgadget@gmail.com> writes:

[Administrivia]

As you have

    cc: D. Ben Knoble" ben.knoble@gmail.com

at the end of your pull request that you gave to GitGitGadget, you
ended up with a bogus Cc: address that reads

    "D. Ben Knoble <ben.knoble"@gmail.com>

you may want to help improving GGG by raising an issue to reject (or
ignore) such a malformed address.

[end of administrivia]

> diff --git a/t/t7060-wtstatus.sh b/t/t7060-wtstatus.sh
> index 942ddbbf0e..a9b435b5e3 100755
> --- a/t/t7060-wtstatus.sh
> +++ b/t/t7060-wtstatus.sh
> @@ -37,7 +37,7 @@ test_expect_success 'M/D conflict does not segfault' '
>  	cat >expect <<EOF &&
>  On branch side
>  You have unmerged paths.
> -  (fix conflicts and run "git commit")
> +  (fix conflicts and run "git merge --continue")
>    (use "git merge --abort" to abort the merge)

This message comes from show_merge_in_progress(), which is called
only when the code is convinced that it is seeing an unmerged
index due to a conflicted git merge.  We can therefore make this
message as merge-specific as we want.  The suggestion to use
'git merge --abort' already does this.

> diff --git a/wt-status.c b/wt-status.c
> index 57772c7501..f7b0dc29d5 100644
> --- a/wt-status.c
> +++ b/wt-status.c
> @@ -1273,7 +1273,7 @@ static void show_merge_in_progress(struct wt_status *s,
>  		status_printf_ln(s, color, _("You have unmerged paths."));
>  		if (s->hints) {
>  			status_printf_ln(s, color,
> -					 _("  (fix conflicts and run \"git commit\")"));
> +					 _("  (fix conflicts and run \"git merge --continue\")"));
>  			status_printf_ln(s, color,
>  					 _("  (use \"git merge --abort\" to abort the merge)"));
>  		}
> @@ -1282,7 +1282,7 @@ static void show_merge_in_progress(struct wt_status *s,
>  			_("All conflicts fixed but you are still merging."));
>  		if (s->hints)
>  			status_printf_ln(s, color,
> -				_("  (use \"git commit\" to conclude merge)"));
> +				_("  (use \"git merge --continue\" to conclude merge)"));
>  	}
>  	wt_longstatus_print_trailer(s);
>  }

We could tighten "You have unmerged paths." even further to indicate
that these paths came from a conflicted 'git merge'.  In the same
file, show_cherry_pick_in_progress() and show_revert_in_progress()
already provide instructions very specific to these commands.  Since
the message for 'git merge' is the oldest, it is not surprising that
we did not update it when 'git merge --continue', the instructions
for cherry-pick and revert, or 'git merge --abort' instruction were
added to the system.  This commit moves us belatedly in the right
direction, and as always, it is better late than never.

The changes look good.  Thanks.

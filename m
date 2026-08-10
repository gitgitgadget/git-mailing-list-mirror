Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C14193F6614
	for <git@vger.kernel.org>; Mon, 10 Aug 2026 15:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786374413; cv=none; b=oig2qI5ulzLA1Q1GywS8M4bbQ8UYULyzdc22lNBF1V/7/D1WzDrXRzl8REC4IAXnX3iOWTEI9+FoK3or8nzKVKp1A0sWe1SR++6Z8+I1DmyDTpy2ieRYPvsg9i/BHMUOb9cV1enuR8y1ygOb9vDQNl3Y/8t9KY4v8AIUIwl3324=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786374413; c=relaxed/simple;
	bh=jA5ASmS4f11a3byzYWhGm3EOyBLODwuQTAeyAdczbIg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tFVAs9ag826tZ7rXUmDlM7LRre/AdDEic/ujVR04S9cYSdOeOAouz0rnySDs1MZEeW5pG4gRynEpT/cf3RB+4WfRnPwzjzDyie4ieNkjBSvYErPd1jzyJPMU8/+4nqfFY1dG+m65QMVZuiQVERUuN93I+d4zBnA/u/CgN1y5G40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=SYpieVou; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jD/Cxpqb; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="SYpieVou";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jD/Cxpqb"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id B4DE21D0018A;
	Mon, 10 Aug 2026 11:06:50 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Mon, 10 Aug 2026 11:06:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1786374410; x=1786460810; bh=jmYoPZprSi
	sqc20by9/nk4bDjXqYJosRisVQZIVjFZw=; b=SYpieVouzeeBR+KnQOBsjuJEe2
	HItSvLM/vtrEGfGggWH4lKWqOSZfF9mrqmrIdvVVIPkgoFfbCopY7OYZQm81Ppsi
	GfM08eM69HIwGJEkA4Fwwv8Uw5YSt+6mthk8gV6TKm8bkMP5HCSS+8umbOAVRbD/
	gmXGm+nKH/d5nRVgXbNFto8m30pqMev3rILG0MciNu+WGtrQp6ja7Dz/aHl5o9Of
	+kBWdWS2uVbXIrHPlI3fW2zILQ6wGCawItvwJGDK9l0FFdVCZpTfvG8pUHK+sNmO
	MxFIZppinbpEc7IGzY1WSi+Z65o8IlSWRcLWH0Vs6E2r3aO5ssvQ4X6Ln2eQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1786374410; x=1786460810; bh=jmYoPZprSisqc20by9/nk4bDjXqYJosRisV
	QZIVjFZw=; b=jD/CxpqbRmXZWfOlRD57EQQvBvsjgPOuymREwraZ+/ZLb1c+ouf
	HJeELgV+NSFjuCMX83iMEmzLeon/sSl8B/aNbQUjU9kT+xI9GqBNjYwVTPkstj7F
	0cckGcdZv0rPE12e6WKieaFJMmh/r74p7Hrhd8EhEW0qxnw0hF8K/R58BVZflTr4
	d8lwGNZMomtT4DPchDOFRBHbHeIeHu/V+sE7cMu+PU1VzGTR2y8z5r7As5SOQVfj
	mD5Fje/3o5BD1n5i5kF9mhjbpHzv0elaZj/kiq1VHHT9CQgeIQ+1b21Xd/47pfH6
	toKoiyqVdO+1T5FesTIwJXZP0uG9Jc80xjA==
X-ME-Sender: <xms:Cul5ahEyLoptIIiX30BEKS_9ushKozbuRbE8t5vECb3ymV2VmJ6tWw>
    <xme:Cul5aqDYwzNClVjYMickes8N5iv4ubhWAWqLEV14nF7WfNca9VZpxR0JKAAVB0l9J
    NvaRZmyiOzhRaceqWyGa6yQSBbiJ1tOPTTB91q_4vKj08q_JHoiZ64>
X-ME-Received: <xmr:Cul5as9WRrshPaA6vZSQpKBilIT-eM2gXOCHk4TFs8tIgauxYa9l8ncC95Ct1IEZTU46ZfneyIUpIwwjoWR87JzDWgRvAsIzQA>
X-ME-Proxy-Cause: dmFkZTFT/OdqyinVkz/F5QRw0rorynKBZKX+HAagruUZGRX70Cl2wlALUX/gf8Cf3uWU7y
    xifwVFpcosr79p7IzE7aCdvJuyfmpK72f44djJrqgTt1XORb7d+jnut9Ly4aG2Ng9sQPt4
    b1U5Fcz34WR3Po8Nr9y7ChlpbwfxU/Hm3YeMMXfzsFwfilCSw3f46juLFTypbPJOdE8jJV
    YS5yF13QUH+A4HYGBBCRYXOrvOaPJnNhAyxbgq5zO7rtBT9qOol+JHTromhADLL2Ydgmoz
    rGyNr6aO9p7sWKJ3w7VZDveYORLomFq7jvGHKI8AIvRQstfI0XnYx9KZsjas5/8Q05bbmJ
    x9fhVbd008ZtG5oGLe5w6lEP7wloBc2XHTEqUHgVThWcMqS4iYKpYTf3l4xcqowEJcW5at
    qBVLXKm2nsKBS+rd3Pf5Bb1TMg6LWpozlusbaiYcYNbW6xzSbEi2d3kRpVkKTmkt/ZTnSx
    pYLM0ouo5kVA2kKEhFMyzt6+eE+rnMNxVWCtyBVlRIDNCzoBJonzuWqoUxpGTwqbwaUTj+
    snru6ivhVI0dX6w1OqXNmiwsvoQ2Z5ewMTXY9WgQPu8UI6TAmvCxBvWOJ0M29yJhRnGcnF
    cOtUY1AX14yr2+Xy3o0QO4YP02yNABDwDV6apy7qNSvkeokoSAmSgg8lbD6w
X-ME-Proxy: <xmx:Cul5auBfsltXEIRrCvZLhifUvyApAqainLhspPXsIowLqfaeROUM5w>
    <xmx:Cul5apThC1ZKyErwwfSxqyYMn0eTDzD4vtO2ShB42kEkQLDkBlArlg>
    <xmx:Cul5atsiWivbWOcJeWKpPBSJejVcPDAyecVOhQLiZEXgdd0wN17p3g>
    <xmx:Cul5at0PnoogpmGUAz5E_roQVHYglX-ql0y6-9jkOfB6n9vAI49fYw>
    <xmx:Cul5arrG0xV_pbUul9ctr233xlkyX2PVMvygWnU5jWhs0jmAMRQHMGOA>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Aug 2026 11:06:50 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Yoichi Nakayama <yoichi.nakayama@gmail.com>
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,  Yoichi NAKAYAMA via
 GitGitGadget <gitgitgadget@gmail.com>,  git@vger.kernel.org,  Harald
 Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH] worktree add: improve message for ambiguous remote
 branch name
In-Reply-To: <CAF5D8-vkd3GOOpdaC=swLv-gxtCzkdhNNUpbTSwr2PBH_Jk=1w@mail.gmail.com>
	(Yoichi Nakayama's message of "Mon, 10 Aug 2026 22:35:44 +0900")
References: <pull.2197.git.1786177301832.gitgitgadget@gmail.com>
	<CALnO6CAdr0ft8KFgGCFX9ueKUdX9-2DwB+SNs3Q8ykw4ne=54Q@mail.gmail.com>
	<CAF5D8-vkd3GOOpdaC=swLv-gxtCzkdhNNUpbTSwr2PBH_Jk=1w@mail.gmail.com>
Date: Mon, 10 Aug 2026 08:06:48 -0700
Message-ID: <xmqqse4m6mlz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Yoichi Nakayama <yoichi.nakayama@gmail.com> writes:

> Before the change, it calles lookup_commit_reference_by_name() again
> in the if condition and die() at:
>
>     if (!opts.orphan && !lookup_commit_reference_by_name(branch)) {
>         /* snip */
>         die(_("invalid reference: %s"), branch);
>     }
>
> The motivation for the fix was that this error message did not
> accurately reflect the situation.

The location of this die() is a tad away from the places that the
patch touched.  The proposed log message could be made a bit more
helpful by mentioning it.  What was posted reads:

    Display a descriptive message when DWIM fails.

    Add advice on how to work around this by specifying the fully
    qualified name or by setting checkout.defaultRemote.

but telling the readers what they will see instead of a descriptive
message and how that happens would be very helpful to understand why
it is a good idea to die early.  Perhaps

    When the user runs 'git worktree add x y z' command that does
    not exactly say which remote they want to work with, we try to
    guess which remote by passing y.  If there are multiple remotes
    that have branch named y, we silently gave up, leaving remote
    still NULL.  This later causes A and B not happen, and we end up
    with passing an non-existing branch to
    lookup_commit_reference_by_name(), triggering "invalid
    reference" error and die.

or something like that that describes the issue to a similar degree
as above mock-up message.

Thanks.

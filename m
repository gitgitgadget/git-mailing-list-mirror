Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A803E49C6
	for <git@vger.kernel.org>; Tue, 21 Jul 2026 16:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784650304; cv=none; b=k7JjpBZdxq/2W7iOzLj8cNT7rrCQQZDMzohsp+j7K/4r7es1C7P1Oy1m16WbqFdEVHjuS5fzB7WJqL1D7jIWHJoRGHmMwx2tOfUrUX1PKjwh7JPNWVyuReIHcLXVc+GE9WMC/5/L71yxMfx5x477heHnJCxMm6qVJckjezFRNTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784650304; c=relaxed/simple;
	bh=5KeqnBwynWKcGEOH8rDPIHKVZm48tF7VcO8w1zfIRTo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mn05ZftXas9dxh+1KZW6qDLZcrbevmAnuo/ZjpU3pdix8MC/2ik/WWFWX4veYaQ5TZ8lHr4IYqGGLc6Z6wfQ38dlFSx2/xmt9tfgYEY+Vrzf1pOqSG10D0cVKS6PdQaHoC8SIVA6R9p2gARjTxe0nX1TIQ9q5M4O6svNGJuEhM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=tO8s74xF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lRyLRKV7; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="tO8s74xF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lRyLRKV7"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0A8CD14000CF;
	Tue, 21 Jul 2026 12:11:42 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Tue, 21 Jul 2026 12:11:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1784650302; x=1784736702; bh=vCVWkBotWf
	gwM7UDAY0KwT7kqUKV8jSURW10egweOwU=; b=tO8s74xF0KlQ6RdOYRk9dhRiH0
	ba20+sPmXvg6QuwE1CrkrNc/Gk2trOj+wzRPi+WpzqC9m8Le/HCC9Pe/VKJfSAUv
	n8LvbWPwLHvZPqdchSBTQ7v2cec6SsE/Tn0FddAGIXpe2sWpWD9QLq65Lp5/yZQQ
	bX9pGbv+iLFlq8eUrPdKxKCSlsLvWLCorAKS9Ptc93oijM3cqJEJnGlo9qJqn6YB
	5Ga4T4DjbuyEjpI9TtlkHFqAJ+hstpYTY3ESgOBestSoMcmaoZOqiWHpDNYK4jIp
	WJBVUN/0it64h8A6KDrmChDnxE5qoxMeLA0yEPsYWIsemhiBpq/BkEMROrMg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784650302; x=1784736702; bh=vCVWkBotWfgwM7UDAY0KwT7kqUKV8jSURW1
	0egweOwU=; b=lRyLRKV799ZU7LtiQpY8kzC0h7o9rl/3IdfRUk0NZHq9o1DrUmj
	/Uy0dT8IOAnlQp1jV4EMgZB6f/FlaZUx7rtcBJlBOwPW5qJUvxidBobLtAC2PJn2
	bJzI74WAQjA4otwDkQLI3oPhIZfs25GQgHclFvO9agn8HJ7YVD3wMf4kb7ILHs/y
	V8wjj2XQBJf32IqvK0G11FL8B/mTZiIEwxOKZdv850nRMaQc8qRw2T6GkMEtq95y
	Ql1WtVveCrLFyPdZFvG77sMYyQHYRFfsvD/2703DPjFnDELwYDImm7Ic7YOgLAjK
	pZPrmROnP4Bqd5Bodf7ppzEQB8CAVJC1ImA==
X-ME-Sender: <xms:PZpfau7GhQC5JiEqU9fzJWAyzdMVHgSuUl5_2knpjl0N-_GVCjDrGw>
    <xme:PZpfau5HRpRon8FC_b4rPEti9HCJNLg0El4Gn6WQ0iyIPNgD_gIgiahLd6pvRtLKU
    Wll8txFEs77u4METe0DrieliVL69cnUK5dpahW13rhSMQdxalKp9fI>
X-ME-Received: <xmr:PZpfaieC3mflSKztuw9ZYfZx33w1BhmcucCwv8i1CgbtJ_YoAQr6_TFJsnRScofBNI9aqrq7VKSO69Gp-RpJey1pIatiGUvKWQ>
X-ME-Proxy-Cause: dmFkZTFWj20JCsOgrWZSfREWgbpGK+VEPN3fcy17iaJ7GZvMO9GXgIT6TjZMt0qXN1MeI8
    9VD1ts2QFyoUFeRSivBx1YurCo29pPxsWCHG6XPsqIeUy4TYsQC9xljU+JPf/r7Vckfdkg
    u/3Xo/FkUTw9gEuNxnGDfyYw7M02bLix2VicDRi3L8lw21wQ5kWDjDqGWsdTSt8qDJ5VJx
    yiDVXejOSfluMYvfbc166IdyDq8svQmJTZCeu1U4ysJcCCY69M9SY1KdAZUuW3aE8NK8q1
    MmTlt+4ulZYNtR4U4bt53WLv3piDc1F9eJuggEjHs7h5k+mljelx1Ilh7H3zi0i6rE+yAD
    Ee7KR4RsBP/gwLA5E9fNWvR2P0kx/7t1rSQdasWFUOyV/8I52ScQaZVl+jv0FLA5/0v7ga
    PskxwYs+rLNSfER59cyL/EHRAMYudYhRjIoBzhfCj/EU8Q4qFIR1Lcren+dLYZiYg5OA4T
    LMHQMgFWH5IvQFT/p1zJmKbR68Jxg0fDYVnGneHXbauNSsaYVUXh6moLx5MauOiXo32DP6
    CxRp0iD6pzXp6/kkjPlZT78BbqMszz52ZFa1586IFY/fOLfbKZaTo7c8NDSw/o/NPidiTd
    Gg9eWqs8WwhbZ1/n0uTPVSUnEbHqYgSP9jBAY95s+N8RAD3XtYY5HH6KnxNA
X-ME-Proxy: <xmx:PZpfaqCCwMlBENYJ69FBgkWl7oBicFKtFDW41jTc3GqwnCs_DHqc-A>
    <xmx:PZpfat-TFLWafOZ4xcPlck1otG1rUSRreuxXQQKos92qMh9y-5nZzQ>
    <xmx:PZpfatKdx5iQBZ6l8qyxoB7Vs04zdOrGe8rdxc1p5K-8U3V7a5vxLQ>
    <xmx:PZpfaujxS4ZFXVfEM4kYH-OLsNYdSAGyieTNznMj9zAiCkrOtTCwWg>
    <xmx:Pppfah8_ZBDDfeQ_HvnFS8t-K6_TI5Ao46bZa623WA_-IwDU1Ugkx_fr>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Jul 2026 12:11:41 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Harald Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH 2/2] remote: resolve URL-valued push tracking remotes
In-Reply-To: <ff645b21591a4b365b30acaf67a295510889141c.1784538618.git.gitgitgadget@gmail.com>
	(Harald Nordgren via GitGitGadget's message of "Mon, 20 Jul 2026
	09:10:18 +0000")
References: <pull.2358.git.git.1784538618.gitgitgadget@gmail.com>
	<ff645b21591a4b365b30acaf67a295510889141c.1784538618.git.gitgitgadget@gmail.com>
Date: Tue, 21 Jul 2026 09:11:40 -0700
Message-ID: <xmqqecgw726b.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Harald Nordgren <haraldnordgren@gmail.com>
>
> A branch may name its push destination with a URL instead of a
> configured remote. This is useful in fork workflows, where the original
> remote is renamed to "upstream", the fork is added as "origin", and an
> existing branch.<name>.pushRemote continues to contain the fork URL.
>
> Git can still push through the anonymous remote created for that URL.
> However, the anonymous remote has no fetch refspec. Git therefore cannot
> resolve @{push} to origin/<branch> or update that remote-tracking branch
> after a push. The push can succeed, or report that everything is up to
> date, while status continues to compare against a stale tracking ref or
> cannot show the push branch at all.
>
> A uniquely matching configured remote already provides the missing
> mapping. Use its fetch refspec when resolving the push tracking branch
> and when updating tracking refs after a push. This changes neither the
> push destination nor configuration. Keep the existing behavior when no
> remote matches or multiple remotes share the URL, since either case is
> ambiguous.
> ...
> +struct remote *repo_remote_for_push_tracking(struct repository *repo,
> +					     struct remote *remote)
> +{
> +	struct remote *first_match = NULL;
> +	struct remote_state *remote_state = repo->remote_state;
> +
> +	if (remote->origin != REMOTE_UNCONFIGURED || remote->url.nr != 1)
> +		return remote;

I briefly wondered what should happen when a caller passes NULL as
the remote parameter to this function, but it turns out that no
caller passes NULL.  One caller is tracking_for_push_dest(),
which is called from branch_get_push_1().  The latter refuses to
proceed when !remote is true and does not call
tracking_for_push_dest(), meaning it cannot pass NULL to this
function.  The other caller is transport_push(), which passes
transport->remote.  This value comes from transport_get(), which
ensures transport->remote is not NULL before returning, so it
cannot pass NULL to this function either.

Therefore, it is OK to assume remote is not NULL, and let the
program crash loudly if that assumption is violated.  Adding an
explicit BUG() check would be overkill here:

    if (!repo || !remote)
            BUG("...");

> +	for (int i = 0; i < remote_state->remotes_nr; i++) {
> +		struct remote *candidate = remote_state->remotes[i];
> +
> +		if (!candidate || candidate == remote ||
> +		    !remote_is_configured(candidate, 0) ||
> +		    !remote_has_url(candidate, remote->url.v[0]))
> +			continue;

This check, as well as the safety uniqueness check at the beginning
of the function, only pays attention to the url member.  However, it
should also consider the pushurl member and, when it exists, ignore
the url member.  The upfront check would then look something like
this (please sanity check the details):

	const char *check_url = NULL;

	if (remote->origin != REMOTE_UNCONFIGURED)
		return remote;

	if (remote->pushurl.nr) {
		if (remote->pushurl.nr != 1)
			return remote;
		check_url = remote->pushurl.v[0];
	} else if (remote->url.nr != 1) {
		return remote;
	} else {
		check_url = remote->url.v[0];
	}

The test inside the loop would then use check_url:

		!remote_has_url(candidate, check_url)

instead of testing remote->url.v[0] directly.

Thanks.


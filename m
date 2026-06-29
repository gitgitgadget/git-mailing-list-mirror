Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5990327BFA
	for <git@vger.kernel.org>; Mon, 29 Jun 2026 14:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782744457; cv=none; b=gz3GYfUmYbt1ZUV7ofGAumK/kh5Glj4kTRA4OYe3q2Aaw9m/eYVi2lkXa0gGcmrGY+c40bxV+JtCgiC3AkPlELdKVMRrULJg1FsJHy+eFEOf/6IuHd+SmfY2858Sm0gaxQPGIcwiKH+OhhVZRRi1HzQtcrLj/SvhE8sihgsEzLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782744457; c=relaxed/simple;
	bh=kHX6Ar2wzDxxsLyNRvl6Bz4Wkjl96f+z4sq+aFvbRDI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cMIpDmdWS38DD1FgwnUm3heycd+xB9N/j5tLCUXL0MwQSSmwO8cwvYwnhnhE8CB5+XLmi9im9i+XcsIi0mV7Hid+zcKn30DJbNjF3Ggjez7DfhvvksvuuiB4OMd98OL6HC4Mc1569PYtoJpqlRHlKnvpHDLJ+grxQ7Bo1FEzHqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=iTi2iLBq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Y9iMhQ3s; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="iTi2iLBq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Y9iMhQ3s"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 1B6AB1D000D9;
	Mon, 29 Jun 2026 10:47:36 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-10.internal (MEProxy); Mon, 29 Jun 2026 10:47:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1782744455; x=1782830855; bh=fHIa/WiYJl
	08HmX+4z9GVAXDQQZvm/hyhRbbiMLurvk=; b=iTi2iLBqCur0kBIcd+4oN1ObNg
	hBHs6j1r4g7SnfHuvRDLpkKMrExJbMkrWQ2mbThfUt+6CSa7iwYvBMFekgRyt2cw
	XziK/a6+dSWCBYTeXQMbyx5vGKxfiL27sVYULqxUgx3cg+SA5jVaQ6D+S71ozC3Y
	Vw9x9rwTn+oixzFtlZuJBis+ovSh2egw1d99cDYtzMaDRRWTaQyojwZCQOmJrfKr
	QonyHByH5wuHMZKYPYkHKMZTjWbUkVc7UD9GRauYIkyPTgsuAHO7iFsrxFozmK43
	pjjnjApVqG4Ae+CqHusT4VrGJa6rqC52njI7zFAISqKpZAH+Um2dfzslMpkw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782744455; x=1782830855; bh=fHIa/WiYJl08HmX+4z9GVAXDQQZvm/hyhRb
	biMLurvk=; b=Y9iMhQ3s5ZBnADok4LNK8BUZaS8XsRb6F6s/GAdUd2Yo973dH3X
	8jqyZg+0llufprtQy5dqpr7zrmrI7xtRMglAGZvYdO6LEeLZlzpN1KQ7Adh7tZR6
	U+pnfL7JJlfHETrrITI9kRRDO61iJ+nGhk9aqKTwzQE2I+tSs/cmaAugkKTQXf6y
	zdti7eC8JAzeQ3Zw81wDhvqDzSsqXAXe2ejL6cM1Cf4IDrfXLtWiNYKRwwTJO3rh
	TFncsXya+lAL9hIiJTDszWclLH7vENncL65RCSr1Pk23FTXKH9BVDG7MX4OmKITk
	2/UHeKp3OjROSsbVHiPL4aAHa/2IY0LOkCw==
X-ME-Sender: <xms:h4VCamaeK9AzuDBn65ukqpLAXG1RJxVLiCe77fDrPJeWLQZW5uzuZQ>
    <xme:h4VCaocQU9t3jqHdJrD1mUoWSbnXt8uVB8hfGyi6E24kaCpFiu98AhN6XtBu8Ije0
    njOzQgzjQCFsOulelB5FmmiYA9yCVghDo_A-igEcVcRl_hjhpF5MA>
X-ME-Received: <xmr:h4VCanIROOUBaHHgSzXCGQ3n0hroE6aepXjNdLQ0S4cSM1B4b6ZwK551uYxu8h0pspcQyQyHhuJzUe8qe5uIOVSKqNYx5vxUoDCSwpY>
X-ME-Proxy-Cause: dmFkZTF+Ap5HaYbeDP/Lt1t93PSZwr8GBTdRbzOz8xHeyjNAoqQJ5U2r+082kIutlwWQ3b
    inytE9K19nJ5PjCWJdGllalwT5EPh2N4+Gkjry9g7/kTRc5QCg3xZsDGSi54ueFqCGKS+G
    zFsvkMtNaPU/mJL/qH1tqw2T/1p45glfgw6S4KpGqwsOu+f/n45959wqJAb17Bcxq0ZA0j
    AOWfqcj5D9pfDNXJFjY8aaSp7VAeBguqYWaeD3b0AXdwmrClJzKNaJtOqAyavoXt5zHQaC
    6Nfkvn7OFIIwdM1reV3ns/NtcwtBAuC1zHscFdkBINjFdyeuWjJWJj73nscQgcvWUuXhE7
    fbrDYIvD6RyqMLZ8kWyNE5maI7umuNLn6V7ERCRQVvIkuPbvp38YBnOFftTp1FveOm7UIu
    bN9lzxhjzYMpbutSunMkUGsHrngSOf38LlekDjSMnRd0l5VU5CHbb+/rVZdh9PZsBndS6T
    4GLCwLLEsxpQ9mITUObl/k3dCk82A/+cX2M0vkFD3xWL9pRzNDyOegmDBdThflYb7lpGDW
    wyX3wORPwgKvz2Fkd5bXlsugcxYE/mzEem4gGKewCYv3JgcWrWc/AzXmvEc78bcvEtQABT
    ZaWWWeEeMm1KDVJUuzsMuj5NJQLY0rDDbkmhMgEZyvd5aAKCHHiA6y0v79rA
X-ME-Proxy: <xmx:h4VCalL3jF7BnvLr9U8zldA2QdXTyY1Jx3eXpQ3HgJD7L8UlCu9Nuw>
    <xmx:h4VCamWIDyzZY02M3YkIQzBXCgMhKeDqOtftO95fa12O4Ui8MUOgNA>
    <xmx:h4VCaunO--prkap0eQgK13fmvuazcF17gEqhm_mI0OWby0acLxdFeQ>
    <xmx:h4VCasm_q5g-35guh-iYe5K5BlIzYZdhbebzTyyg8IDPL4Nr_i_yYQ>
    <xmx:h4VCauHmkI2kq19TjUkLbqksG91VHM4bCmzQaUoIX8kaUraij_JHMdsb>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Jun 2026 10:47:35 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: Tian Yuchen <cat@malon.dev>,  git@vger.kernel.org,
  cirnovskyv@gmail.com,  szeder.dev@gmail.com,  Ayush Chandekar
 <ayu.chandekar@gmail.com>,  Olamide Caleb Bello <belkid98@gmail.com>
Subject: Re: [PATCH v4 1/1] environment: move excludes_file into
 repo_config_values
In-Reply-To: <CAP8UFD3Z0M_1NEXGcAxNZKpRUQiSkHZLTEvNNYushKA_PoPgjA@mail.gmail.com>
	(Christian Couder's message of "Mon, 29 Jun 2026 08:03:40 +0200")
References: <20260626075037.532164-1-cat@malon.dev>
	<20260627160813.1074201-1-cat@malon.dev>
	<20260627160813.1074201-2-cat@malon.dev>
	<04d1a7d5-ef83-4728-b816-5cdf1cb4aa25@malon.dev>
	<xmqqv7b34snt.fsf@gitster.g>
	<eabb8169-2c13-4961-9b21-f44b1fa66f70@malon.dev>
	<xmqqbjcv2h3j.fsf@gitster.g>
	<18ad7c1c-5ddc-4f62-ba7c-5cda53f5a48d@malon.dev>
	<CAP8UFD3Z0M_1NEXGcAxNZKpRUQiSkHZLTEvNNYushKA_PoPgjA@mail.gmail.com>
Date: Mon, 29 Jun 2026 07:47:34 -0700
Message-ID: <xmqqbjctz9mh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Christian Couder <christian.couder@gmail.com> writes:

> I agree that the best end state would be to have no `if (!repo ||
> !repo->initialized)` check, but we shouldn't have to get there right
> away. I think it's fine to proceed in several steps:
>
> 1) `if (!repo || !repo->initialized) return NULL;` allows us to remove
> the global variable and use getters which will help us in the next
> step.
>
> 2) `if (!repo || !repo->initialized) return BUG("repo must be an
> initialized repository");` now we want to find and fix callers
> (including tests) that haven't properly initialized things.
>
> 3) No `if (!repo || !repo->initialized)` check, as we are sure that
> all the callers that didn't properly initialized things have been
> found and fixed.
>
> So I think 1) is fine for now as long as we properly explain in the
> commit messages and in code comments (maybe using NEEDSWORK comments)
> that we know there is more work to do on this in the future.

I am OK with the progressive improvements, but if "wean us away from
global variables" topic stops at step 1 I would have to say that is
a failed experiment.  Not doing (2) means you made the system bug-to-bug
compatible from the old world where these things weren't in repo-config
but were still globals, which is code churn for nothing good to show
in the end result.  We need to get to (2) before declaring victory.

But of course, we need to start somewhere.  (1) with in-code
comments sprinkled to such places that say that we'd need to revisit
would be a good place to start.

Thanks.

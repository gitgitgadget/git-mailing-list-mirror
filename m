Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF82C3F9A01
	for <git@vger.kernel.org>; Tue, 21 Jul 2026 14:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784644810; cv=none; b=Kasb94qVNd44b9A6PVA5QUy55gG1oUYFSgQTbCVJ+AmMYN0I46a2m+RMmRBt8lqaFVPMdOdG/TzZkNnEyLfhwSxGQGlvVr1dzVDNLy6Blc1GU0ZOwFVJ+4bIecK3g1g2e36QOHsol2HlfhvUkI575Lg9IppxMbHlqfz4eugjHT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784644810; c=relaxed/simple;
	bh=UUxd+YTR/o9vui/gwyKS7TTQUktnlQB/q7q2hS702Fc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=R5BiRrnJQZYX5A6qsqtAqf3C+l6dqdgtFXQZjh2BmRVOTUHgTl62t8Gd/rvdDzPKHH2I3ROZad2YWLYQ447Z3APmycihxgbpNH0U1mJeuBaGSwnlYNrHU6X9GGPXpSTCwnKZj4rg4/bRoJf/IzDM0SSp7NU6pHu7wAHoJzasox0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=E3SSRMAn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BSr+7LcH; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="E3SSRMAn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BSr+7LcH"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 04F71EC01A6;
	Tue, 21 Jul 2026 10:40:06 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Tue, 21 Jul 2026 10:40:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1784644806; x=1784731206; bh=HzDMQolKlw
	2cqMvxvACghL40DmLhfQFe/v3hckKic6o=; b=E3SSRMAnE3vZiGup2Zak+DtEKq
	Qjlmf/Xaz0ORoE+WHpIIbNYh+46LtFkevt2bbrRmaP4rMe9oUeDZyD/sLTkvsWPM
	2JGOJJwJ8gGosNNeRryBIezRxpCatq2e056aIeQtouAnGhNGgNPl9fKrWUk6AZVc
	wTLrW/X6FAw158KAxOYjdPlomWVIa40JCaU6wlvHGIpMrvWsDpjlbqIWNxTpKskE
	ACAizi47pp8LYNTlTo1c2KXkrOJxa/ixhWbq/+LRJJwvarU/FptDiUtZbtK+JS8b
	KNAP5h0a4r2aMVWO5oodMNWTTHAyvDY3EzS1hQHxDnwXduZe6VehH7jcK4wQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784644806; x=1784731206; bh=HzDMQolKlw2cqMvxvACghL40DmLhfQFe/v3
	hckKic6o=; b=BSr+7LcH3r8IMOh3h/5ctU/uhrJDo47YLgvYGSkEWrquwQnnaNS
	mJy1PXHsJ9sVMyD18mqNtFhj3TAqc6ReYeLwksx3MsqtxTPaLu17AY9gCOv1bIge
	DiMerJru5Jc9eAkDUX2iEUMO2FGNaeE91bTleAa7emQVG265DWvoZ7ljwrOjNBE2
	zu9j5FD/VxblwXwV6Hl7QnHmGiQajc72JEUuO1coj3gzbx+1hYgwkHwP5UoGKXQx
	W2EsN9Ufh76XFT0MnEokpLj1072v2zBBhTgbdgZ82qo7vAirzvKBut/xDQJt+7PF
	Br0KRcfh5VsrPnk7uk9VRDcI3TWIwy0fgwA==
X-ME-Sender: <xms:xYRfanlrwmhCMahxb889c7Dzl8GzWVllWV_iPrbLUKgbdvXpLw5AwQ>
    <xme:xYRfahtfD2TNiPAJx4dbdf_1GcBtXnX1BNUFFCWmIcqwh1LZ-Sk0y8fXd2cZC_cfm
    YnW6c6AIfYidNVZTZa1o2A7ZsLCeKSBq8QgPF4HmVy_2qRpDwYTQg>
X-ME-Received: <xmr:xYRfal9T9COIjrK7PKefO2A5ZV5cPmxNGIf5HooRxQsBoa1SkSIckzEqm8zmRoUHsYDDzpSZCPHzqZKsiXXGS3OBZ9EyTyc2Kw>
X-ME-Proxy-Cause: dmFkZTF6xBnHEfW6FXKHhU+9SHg/QygjBRGrWpoa4sPUPPUrkxlpyGAip6wsS+704lh5Z5
    3vTAUm2XM2pKraBK12EHrnBXGGJsH2gBrdaNLWxIo4q1+mLqF0Ht44kEclI2sRABxu6QFq
    0kdSXZI2gyrMQF5yc7p7azQMpzAJDWjLkj8DLuNl8bmgdOfReSSKtZiAtgcTmI3hoWd0LV
    sSPI7UzataE3608i3+9dEuATTwB8x6r056V2dLZ/v6g+NHJzU/gfnN3p7I/kgQEl0JqGb9
    Y+ZtXuRsdDpDESssIN5cnVg4omBuBZrXaKedmGZja75e4fXjJujmAQdEXsREEpt2zlyNL/
    wAXogWP0ZF4zH7j7ejLePSYyb5mJ3KJuR/LC0BSenxthRSypQWUWEe/pgl3cNecW7wnsFo
    e7SKS3/gMIOOqiCfMsYARy8OyqPDm5nnavHG2Um2KCECehoA/8fWnqkLaaeHuy7HOihVGz
    URqPvtZGsHmJGHKn9NNvdUFIXpr/bJbNBXhxnbsCumFJwy8u9X/koXQLPEcWQMbJv6tEIX
    pqqT6M2Xo/VDdV68h5tQYjkvIIXSGFQFHuO6QNCCRN5yY0ookf8108NIweFvuRBGlqjhNq
    eogi5V2FZIMZ+8vmxyf+FojnNCtKH0xA2twhhD527sT/UquKoX7gQV3NwirA
X-ME-Proxy: <xmx:xYRfarMDJJVwSK1mgFBP-ZCxTXt21Fx-qqHMXk1DNt_wblg-lEsUQQ>
    <xmx:xYRfajEiwrOUCJGKPUlTHqOq5YX3VT0m6SH8HYBl9bmB2wEYbsV8_g>
    <xmx:xYRfapTuiPt0j3i_MdWDfQsbDVftcWiaBp7nQRHgpSpooVyVGKkudQ>
    <xmx:xYRfagvVT76RKpgm20_vI-ilVOKKE2678mivdpjruuq0KgsgZjNhEQ>
    <xmx:xoRfahV6nyaK5M6IW4GFIccQ-V2QESl1WfaZwWXfQfG5Mh5hUu7GuPeB>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Jul 2026 10:40:05 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Wolfgang Kritzinger <wkritzinger@atlassian.com>,  Patrick Steinhardt
 <ps@pks.im>,  git@vger.kernel.org
Subject: Re: Performance regression in connectivity check during
 receive-pack (git 2.54)
In-Reply-To: <20260721035733.GA581473@coredump.intra.peff.net> (Jeff King's
	message of "Mon, 20 Jul 2026 23:57:33 -0400")
References: <CAFXJcxvpKHoVDwE5mBOd=w-A5vPdUmehqr8SHLUD7qv1qB00rA@mail.gmail.com>
	<20260721035733.GA581473@coredump.intra.peff.net>
Date: Tue, 21 Jul 2026 07:40:02 -0700
Message-ID: <xmqqtsps76f1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> Yeah, and that type of regression makes sense for what a593373b09 was
> trying to do. But I think the v2.54 behavior is wrong. We should check
> all packs before any loose objects.
>
> I'm not sure of the correct fix. This is working against the whole "odb
> sources are independent and abstract" refactoring that a593373b09 was
> going for. But I think it's an important optimization. I guess the
> abstract version would be that each source has "fast" and "slow" lookups
> or something like that, and we check all fast ones before slow ones. But
> that is pretty gross.
>
> I'll leave it to Patrick to ponder further. I haven't really been paying
> a lot of attention to the odb refactoring.

I think checking the fast sources before the slow ones is probably
the best we can do if we want to retain the 'each odb source is an
opaque object' abstraction.

Stepping back a bit, the 'rev-list' command used for the
connectivity check is curious in multiple aspects.

 * On the surface, it looks as if the caller wants an enumeration of
   all objects that appear in the range.  However, the caller is not
   interested in the actual list of objects.  Instead, they are
   interested only in a single bit: whether the traversal succeeds
   or dies due to a missing object.  This is because the traversal
   determines whether we need to fetch, or whether we are already up
   to date, to decide whether the proposed 'fetch' is a no-op.  The
   positive ends of the traversal represent what we are about to
   fetch; if we already have all the objects needed to reach those
   tips in our repository, we can do without actually downloading
   anything [*].

 * A false positive answer to the question "does the traversal die
   due to a missing object?" does not affect correctness, as this is
   merely an optimization to save downloads (though a false negative
   is unacceptable).

Given this non-standard use of the command, we can pass
application-specific cues (such as "we are doing this traversal for
a connectivity check") down to the machinery as a hint to help it
optimize its operation, and I suspect that such a hint might have
value.

For example, we could enumerate all loose objects in the loose
object store using 256 opendir() and readdir() calls for about
10,000 files (since once you have more than 6,700 loose objects,
auto-gc would pack them) and store them in an in-core table [**].
This would enable us to say "the object with that name does not
exist here" without running lstat() at all.  I wonder how many
lstat() calls we would need to save for such a scheme to pay off.

There may be other highly application-specific optimization
opportunities, as utilizing revision traversal for
connectivity checking has peculiar correctness requirements
that differ from the normal use of the API.

[Footnote]

 * It follows that in a lazily cloned repository with promisor
   remotes, the traversal could download everything needed as it
   goes, only to conclude: "No need for the main fetch; we have
   everything we need."  I would expect this to be a fairly slow
   process that defeats the entire reason we have this connectivity
   check up front as an optimization.  While I have not checked, I
   believe the actual code prevents this either by skipping the
   connectivity check altogether, or by instructing the connectivity
   checker to treat promised (but not immediately available) objects
   as missing and abort.  But my point is that theoretically one
   does not even need 'git fetch' in a lazily cloned repository.  It
   is sufficient to use 'git ls-remote' to determine the tips of
   remote refs, and run 'rev-list' to fill the range.

** If in-core memory pressure is a concern, we could use a Bloom
   filter, as we only need to know "the object is definitely not
   here" and can tolerate "that object might be here, but we are not
   certain."

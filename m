Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43601DDC1D
	for <git@vger.kernel.org>; Thu, 18 Jun 2026 16:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781798899; cv=none; b=P9+aJQBZQAKbR+FRXixvCpadMcdsRFY0lHdY04r9XQbPKnHnU9gtIyt4zCZC3pep8XqJTYc/cM7JmAsL+nGGNjrBg5RVaKsQ3nd8GCqGRW5g9hzJZmtuR9fzgn8F4Q7VC2q2ViC/2KH/aIKeMN0G1TdUL9p5jeuHWNsRlQtD/LU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781798899; c=relaxed/simple;
	bh=A8MRkTxs26Vz4fAwMGlqoYVMoJGgeOrgqZB0KsYuo7U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eXQoqcS0WJ+LjN5bWGtJ20YvqY8LumrnftD8xXz2DfPZFEtisI8aAx52D2k1rbEeZ97nlTdkgdeKEWnOPVSzaf1kqQsuVzRojAGZi0OjxExSBUc0Qbdqng88EvGaP5l275YBEnVf7EzkqfJLUD7XMuyGXLEwbRjqs1erZbXYixM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=UoTmgnKO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ehpWqBIE; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="UoTmgnKO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ehpWqBIE"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B8B6E1400184;
	Thu, 18 Jun 2026 12:08:16 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Thu, 18 Jun 2026 12:08:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1781798896; x=1781885296; bh=GfQIeYHcPd
	LhtQBoP1WKacxgpty7XVUWHvaSfDebjHc=; b=UoTmgnKORJvAlQ9RQJTmLtTJ4m
	A6JTe9uUMDfV0DA/OvXlrbCBIrGHXdF8W5zWKsGHtRLH3oK++2qy7y+YQxpzVXJk
	9UlPdGL9YBWWd3SJ9bgOR+WnzlIlvB1dpReMTXYdbFjuv/nmv/36rTHu4Y1Xx8py
	TtewZJEe2R8ApB8krC8b6XM5/XUx3hBP4na5sEdb15ziFBhJZzmyngPaESqftqjC
	OHELc1bJfXUoZExS6tecQ9YLlzjT6I7TxfsZx+jZkYeZttrr/1I+Oav2Xr+z15JY
	ReZq4HxbmMtek6ce00WPTnPa2HSyWXLVseygQbBDkMj8wJqmsbsfLE4ACkPg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781798896; x=1781885296; bh=GfQIeYHcPdLhtQBoP1WKacxgpty7XVUWHva
	SfDebjHc=; b=ehpWqBIEF2SgjiPS+uCEtvbl9h0AAELRE3wInUHJE6dbiIvQ3lD
	fQdOG80/BAYTtEgiQDe7nsIcjcElVjNXdhWAgoRqpy8S1kg7vZ+d53keJsm4zQVk
	Cv60pdWHEb4K6+QTcaaDZeQKWgLj2QFHTGMxObbzz4EdQ/ZfWRL3en2puvT89C+Z
	mFAbBrMhBCsttQH79V3iAPECYk1JCmke5vskx7691DeQ7SeJu3oPSmwEpas9AsBM
	42zJgaI52AXKZsVBPKqFpYPzVMNgAOADNPvNQbFc+h3KnFyF2Vbcth704DNzkTNH
	3F5K4Tvk5jWzRrpdosTWqkI4p5h9PRJiIEw==
X-ME-Sender: <xms:8Bc0arwu7aWsWn3waKbELNDLJiw9YSBAUU6tpjE7uQhZhWl7Rgl1_Q>
    <xme:8Bc0ag2qjcYtW046ghCfCfC_0Y1UizDMSaxlqIjwQFuQiYbxnB12uio6VgPiYObPL
    IFRqxUSZ7F_xy6IQ3YypB9Za2GEmBECk2lGS_hs4XI0COgJgYC41w>
X-ME-Received: <xmr:8Bc0aryDxGnt-q_mgXEp_meRh4VJ0ILDHveKsI5CyuwnlKPFYg5iG77ye_r5KRWx7KG8jBE2n6yCBNsatvqEagUmNersKPl9PXdI>
X-ME-Proxy-Cause: dmFkZTGZzf02LuFd28igBi12qmA3CB0y45DwiZXSKNOHPdiGnB3Xhdmr+XXgjwSqgt82eo
    kkqO2RFr1B5E5h934dvVV08OIEOFI438jaPkgzVGLAZAPQCmzGwjzeE+SHldIy/JJCCYV4
    Wi4N1TR3dwi6I4vXim/gldIEked4UWFmZ1L9wEqGvDhzTgDBrQqUk2E/BzIQnM4EWE5ZzC
    5t3Z3cAi1v+fq0YCLzHSMtMrqQGKv/TfLMfYHaHWY6+3Wmx7z2neL5ZGI4fNS6NKw/k58V
    xezj6Gr0N/nO352pY8DNEU9fo5aszlLVyaYD9+bkMkNYZAy1IeaRI5+C8slqUj2A8r6AOd
    wifnnZMA0nrC3Ipa5lVFP0U/HPX/LQU9MglrgIzU+YAS2gL4COu0JdUGT+7aEpBATle4rd
    r1PGx4zFyAxaILJkCLWT5OlWBNOy/IYhlUNYmdBnshgSd7pmUrp050wyeKbxo9GiLwHsDo
    Zgicuera3o8DHBv1O9aQ5KvhmJ9zQX9kzfHEWxxHlTGxoZEyj2G7/rw8RtvDZXf0KMj647
    K01YWEnhYBetOrg+WTtSrK793XPZ09vxY5kQFb5o7CnsXSIfWFoW/KTMZXFBSgDuTuZADe
    u3+XE6CJ9J9KJuUpgv999CGvjLFLRrc5ONq22PAyEakh975B6pgIhuPh1+pA
X-ME-Proxy: <xmx:8Bc0anHTC1h5HrtZlLYdaCSGR1jNvhcCMu8rfxhlWSodtcYhfzX4Iw>
    <xmx:8Bc0aubseVmTdloNqpspHSDLTy7-DaSuMn1iGkST0-OAii4sv3hHZQ>
    <xmx:8Bc0apDdou_y0vy0HganFuYl9g4P88AgYubOvlFfkGA9hfFdPBf7Gg>
    <xmx:8Bc0ammxkAoWzmlmRjLtZWQ4NowFW_wENQ_JnBHbzEZ7qlAazsspkA>
    <xmx:8Bc0auDFAZn82MVJNceKPhSvFvDCsYNiSOnBvXnUUUgoKr86ZbbGWiGo>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Jun 2026 12:08:16 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Harald Nordgren <haraldnordgren@gmail.com>,  Harald Nordgren via
 GitGitGadget <gitgitgadget@gmail.com>,  git@vger.kernel.org,  Kristoffer
 Haugsbakk <kristofferhaugsbakk@fastmail.com>,  Johannes Sixt
 <j6t@kdbg.org>
Subject: Re: [PATCH v14 4/6] branch: add --prune-merged <branch>
In-Reply-To: <37f2a483-c8bf-4c24-84de-c6233cc20b25@gmail.com> (Phillip Wood's
	message of "Thu, 18 Jun 2026 14:42:25 +0100")
References: <pull.2285.v13.git.git.1780684553.gitgitgadget@gmail.com>
	<pull.2285.v14.git.git.1780999917.gitgitgadget@gmail.com>
	<9924373da0a0598cabe4f08f3bc4200833679171.1780999917.git.gitgitgadget@gmail.com>
	<78b6dfdd-df61-4c44-96eb-b527cb26243c@gmail.com>
	<CAHwyqnUsjpCHfS=eBphmkdDGYpQZ_LQUJi1mjrxV8ZXi+w4yhg@mail.gmail.com>
	<37f2a483-c8bf-4c24-84de-c6233cc20b25@gmail.com>
Date: Thu, 18 Jun 2026 09:08:14 -0700
Message-ID: <xmqqcxxnsufl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> One thing I've just thought of related to this patch is whether we want 
> to protect branches that are the upstreams of branches that are not 
> slated for deletion. With stacked branches it is possible that a branch 
> has been merged but has other branches stacked on top of it that have 
> not been merged.

An interesting point.  We do have "this topic is built on the result
of merging these other topics into main" and I expect the practice
is wide spread.  These base topics may graduate first, but other
topics may still be updated.

But when you rewrite these other topics, wouldn't you leave their
bases untouched?  IOW, a new iteration (i.e. "rebase -i") would
reuse the base that was used in an earlier iteration, i.e. the
result of an earlier merge of the other topics, some of which might
have been pruned since then, into an older 'main', so it is OK to
lose these other topics once they have graduated, simply because you
wouldn't be recreating the merge that you used as the base of this
remaining topic, no?

Or am I missing something?

Thanks.

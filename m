Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC35AB662
	for <git@vger.kernel.org>; Thu, 23 May 2024 23:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716507321; cv=none; b=oCcDvrJngtwmZV033iLXemXS7NoW6SCg+y7NPUAb6uRVxmP3hc2DD2Tjb6BCHK1jwZVauG5te7BIIqca71nBvy8vpwu5wzGlkU4WfPqf//Xt06kLMEscff/e8JXZiirfm1gv78geKixsJuLtcCNet96o8GSbQCeYIzrsDuaGYZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716507321; c=relaxed/simple;
	bh=yXEaf6tocg5AYT0T7W1ta8x2fPukI1IUqBQT+/IAHhA=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=V3z3NG6UEGsNjYafoGXytm5sYbEuSaqACg5XaCZ6C1Wjdos0dUvjoU+nB3VfrgpVG0v/N3LY19ycvtu59e2JFPAbdjl0ebagGqMxpxB5aG5fpCEkM4m3Q4M5ExJAoEhP/3EoL7IAzKQJ5qEK5Fy92WOHYQVniJLuq8oOMPvfiOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=k+lwgH38; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="k+lwgH38"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1716507317;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aeecKswDcjRFBOAqHuyUgldfJ6KOfNbvy9VQZAWoD6g=;
	b=k+lwgH38bx3NxKCZkuUxur8yuXuAkRXhTSpg2n/ltmCP07NPwbC4iztxI35sOgKGwVBygV
	41sdUyI7tg75AD2l3aGFnwcCRLbXzNXI2nHPU1Gyiq2mL9iJzyAN+BLRn1z957npCkGd4P
	qHvu3QgOkS0JHQ9AUZsRR+iReeXzGoHBbU4EhYwuMfMq6dwTxIVM1VHQ3ACwcfsJZEsuAi
	t3L8u77L/V7WmwCqG29Jw8wVesrv6/P0aoRP/iUVEv/hNtH5m5Kqxuzusvz22a1QeHdiSn
	GKqVWkss1JnkX2gFrX8+s3MduRWIycdaPle7NisLuR41ODhjFaF19+JJLBsBAw==
Date: Fri, 24 May 2024 01:35:17 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 0/2] give range-diff at the end of single patch output
In-Reply-To: <xmqq34q8qfek.fsf@gitster.g>
References: <20240523225007.2871766-1-gitster@pobox.com>
 <83436db5996b129032c2869f331980d0@manjaro.org> <xmqq34q8qfek.fsf@gitster.g>
Message-ID: <8b08ccd0953aec5a2fcb3a61bc86c32d@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-05-24 01:25, Junio C Hamano wrote:
> Dragan Simic <dsimic@manjaro.org> writes:
> 
>> Hmm...  I think this should be made configurable, with the current
>> behavior being the default.  Without that, we could easily disrupt
>> many people's workflows, because the power of "muscle memory" is
>> often really strong.
> 
> I would view this more like "Porcelain layers reserve the right to
> change the behaviour to suit human-end-user needs, without having to
> complicate the system with extra configuration knobs."
> 
> But if other people want to do a follow-up patch to cleanly add such
> a configuration, I would not object to it.  The main desire of this
> patch is *not* to make the option to have range-diff at the end of a
> single patch "series" available, but to make that the default.

I see.  Personally, I find the range diffs placed _after_ the actual
patches more pleasant, but I'm just concerned about other people that
might not like such an arrangement that much.

To me, a range diff is like an additional description of the actual 
patch,
or like a really long footnote, so to me it makes more sense to put it
at the end of the "document".  Sometimes I don't even want or need to 
look
at that footnote, so not needing to scroll down is another plus.

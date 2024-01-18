Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEBD18F60
	for <git@vger.kernel.org>; Thu, 18 Jan 2024 06:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705558539; cv=none; b=jaB00NGeSZLjUCb4LEWO6+zbZXaX9JcfpBYKdQuFPY5g9r9fyOEkRNbToGYg7BTbVcD7zQYrohebVM7gqMIZFeIV/TOTOwjjsmD86t5dUMGbD5LDOLXEhIGaBKprzK57vg3BagLYWTuxLOL91IS/QQGUwxA4yYn0MDIK4RiMvtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705558539; c=relaxed/simple;
	bh=L6MxkFz6OsJ47xqDjauF92925lH1xZVZpK4SAh5pJ9M=;
	h=MIME-Version:DKIM-Signature:Date:From:To:Cc:Subject:In-Reply-To:
	 References:Message-ID:X-Sender:Content-Type:
	 Content-Transfer-Encoding; b=dJeeZ7FbW7m/NonFGLF6ZAjNjfyFXc1qXKHPhO85DmFoPB9caj5Rt2m6WOYqu1M26L00jYrL2kIzzazDqdKc+quWEzoLCv1ewWOh6qOVvUGrwWhN9Ed6MVuqzolNJJ0i/chOT/K9xPDKExgDNMCUnCADi1IRQKBfEoNP6TxDfOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=sje1SRpt; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="sje1SRpt"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1705558532;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QGThpx5rvCdggY7dCcpJvZzIjfSncaodWQsKx85VADs=;
	b=sje1SRptxSy8cd7L1SaFDmzg5PPwViaBDzOVNvZAKADtnU/xhVkvexP2D8wFxeK4/QVA3p
	yuiAMlYTfCndJ8UPcMqOzxVjPEDNXhrI0Op0U+sJWmffxJVKrKDb4WY8vs1DBAkrtGRQ+b
	qpwx4h/YnNfLhq9g696dmwb9eGkP0JtLBSLc8m29vrqO6xFkruNnVX4AFkarY8kKANArE2
	hPPmT9ib6p+KQQeE7o8KXYDn80K415ZLjaqmv9BiEhrWZpEnNjV5TMCJ57h71grQ57YC6s
	gJ8qxEWEmcngYlmdXWzvamT7ZF7mISp32EE4MELuQM1jxDk2w81RKQuqZmD3nA==
Date: Thu, 18 Jan 2024 07:15:32 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Jeff King <peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, =?UTF-8?Q?Rub=C3=A9n_Justo?=
 <rjusto@gmail.com>, Git List <git@vger.kernel.org>
Subject: Re: [PATCH 3/3] advice: allow disabling the automatic hint in
 advise_if_enabled()
In-Reply-To: <20240111080429.GG48154@coredump.intra.peff.net>
References: <7c68392c-af2f-4999-ae64-63221bf7833a@gmail.com>
 <d6099d78-43c6-4709-9121-11f84228cf91@gmail.com>
 <20240110110226.GC16674@coredump.intra.peff.net>
 <aaf59fc82ef3132ece8e1f70623570a2@manjaro.org>
 <97fdf6d4-1403-4fe9-b912-a85342a9fa56@gmail.com>
 <a97b03a305a7b8b95341b63af1de0271@manjaro.org> <xmqqil41duov.fsf@gitster.g>
 <d6d72ec5431ad1ca775e6e4e9921f94c@manjaro.org>
 <20240111080429.GG48154@coredump.intra.peff.net>
Message-ID: <5f322b3e6053c27dda58ef1c1f025d11@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-01-11 09:04, Jeff King wrote:
> On Wed, Jan 10, 2024 at 06:45:49PM +0100, Dragan Simic wrote:
> 
>> 4) As a careful git user that remembers important things, you go back
>> to your git configuration file and set core.verboseAdvice to true, and
>> the additional advices are back, telling you how to disable the
>> unwanted advice.
>> 
>> 5) After you disable the unwanted advice, you set core.verboseAdvice
>> back to false and keep it that way until the next redundant advice
>> pops up.
>> 
>> However, I do see that this approach has its downsides, for example
>> the need for the unwanted advice to be displayed again together with
>> the additional advice, by executing the appropriate git commands,
>> after the above-described point #4.
> 
> Right, the need to re-trigger the advice is the problematic part here, 
> I
> think. In some cases it is easy. But in others, especially commands
> which mutate the repo state (like the empty-commit rebase that started
> this thread), you may need to do a lot of work to recreate the
> situation.

I apologize for my delayed response.

Yes, recreating some situations may simply require an unacceptable
amount of work and time, making it pretty much infeasible in practice.

>> Let's see what it would look like with the granular, per-advice on/off
>> knobs:
>> 
>> 1) You use git and find some advice useful, so you decide to keep it
>> displayed.  However, the additional advice about turning the advice
>> off becomes annoying a bit, or better said, it becomes redundant
>> because the main advice stays.
>> 
>> 2) As a result, you follow the additional advice and set the specific
>> knob to false, and voila, the redundant additional advice disappears.
>> Of course, it once again isn't perfect, as the next point will clearly
>> show.
>> 
>> 3) You keep using git, and one of the advices that you previously used
>> to find useful becomes no longer needed.  But, what do you do, where's
>> that helpful additional advice telling you how to turn the advice off?
>> 
>> 4) Now you need to dig though the manual pages, or to re-enable the
>> additional advices in your git configuration file, perhaps all of them
>> at once, while keeping a backup of your original settings, to restore
>> it later.  Then, you again need to wait until the original advice gets
>> displayed.
> 
> These steps (3) and (4) seem unlikely to me. These are by definition
> messages you have seen before and decided to configure specifically (to
> "always", and not just "off"). So you probably only have a handful (if
> even more than one) of them in your config file.

Yes, the number of such messages shouldn't, in general, get out of hand
over time.  Though, different users may do it differently.

> Whereas for the case I am worried about, you are exposed to a _new_
> message that you haven't seen before (and is maybe even new to Git!),
> from the much-larger pool of "all advice messages Git knows about".
> 
> It's possible we could implement both mechanisms and let people choose
> which one they want, depending on their preferences. It's not very much
> code. I just hesitate to make things more complex than they need to be.

Perhaps having both options available could be a good thing.  Though,
adding quite a few knobs may end up confusing the users, so we should
make sure to document it well.

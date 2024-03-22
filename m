Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79FE022EF5
	for <git@vger.kernel.org>; Fri, 22 Mar 2024 10:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711103236; cv=none; b=T4ex6zPHVrGDc0UDb3LHqSDN3aLMaLXggJg88bRgzdgAEGw+TslCGe+3JBqcNkCUzyHSsiGB/CtJI1Xj0JQTTOYYZfIYGvsypBUHo9GWphWAoOBJkAuXvTT00c1KGeNdKeYvHm8uc19AaxCGEcNhsVv/HYReUXn/9SGi+qFz6pA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711103236; c=relaxed/simple;
	bh=DaEN0ZI1Fmxs8s+NiJJd8ForuFjIzkw6Sn56x+CZP4k=;
	h=MIME-Version:Date:From:To:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=poaUbIbg6Ps/7Gj6xsfCkpIYq92zoXoxbQNhFUVFqFK7ozOol9eospYzdv2dcpRQ0/kA9Y8M+XZB46w8D6JDNzYQH54nj4bWnMVJeepNAhEVQrV55te59P+/FeiRWbLfM8hr5XbaOX7veye46fI1Hle8L+yHIqYQFAvhajHMWbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=T30qY2Mm; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="T30qY2Mm"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1711103231;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1D73m0X2KOoOmbYgrJu2PBTf3xKDeNRj5mVP9CYndco=;
	b=T30qY2MmClWMNfahFWfib5YTzzpyMrMXEr47TkNv8HN+4qc2IBoHJqoVixByahmvPV/FkQ
	8mAt1WKYOX82NLxeOz2H9n9M2XDhKB0EytuyLWd2hVwVIes4PGi1bxBF1yCRGf1TEr7ujr
	XCBQnzb3ObCpXkcoXSeWEG15FC/Hcn3Dp+H1kJlWf+Vfth2rT3yTDRo5spvVMRL9ILM5Pt
	nvmwVLmERU1Kws2hPPPLhN8n6w8dLh2TMviJwtb9gotTEurvpNucod9l/J9G4Y6Keu4etD
	xaTsKfMDqtG8fUxLegDsc1gJqh9k4gRjP/7XA4Bakr2+MjOahhhCd1EGzX0B+g==
Date: Fri, 22 Mar 2024 11:27:11 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: git@vger.kernel.org
Subject: Re: Merge selected files or folders
In-Reply-To: <20240322095640.saas2lxwmitrwoki@carbon>
References: <PA4PR07MB7406FAC1F8C00E29979FCFF59E322@PA4PR07MB7406.eurprd07.prod.outlook.com>
 <xmqqbk778oeb.fsf@gitster.g> <87bk76fvvr.fsf@osv.gnss.ru>
 <20240322095640.saas2lxwmitrwoki@carbon>
Message-ID: <838ca1b39625dea6827fa623abb51792@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-03-22 10:56, Konstantin Khomoutov wrote:
> On Fri, Mar 22, 2024 at 12:39:36PM +0300, Sergey Organov wrote:
> 
>>>> I'd like to merge only certain files, or folders, from another
>>>> branch.  What command or options should I be looking at to get
>>>> this done?
>>> 
>>> If you are using the verb "merge" in the way Git uses, then there is
>>> *no* option to do so and that is very much deliberate, as allowing
>>> such a operation will break your history.
>> 
>> No, it won't break history. The merge commit *content* does not break
>> *history* in any way. Path-limiting makes perfect sense when one is
>> about to create merge commit content and knows in advance the exact 
>> set
>> of paths the changes from which are to be included (or ignored).
> 
> This reminded me of the "disaster no. 2" in the rant, arguably famous 
> at the
> time [1], in particular:
> 
> | One user of Tortoise Git would do a pull, have a merge conflict, 
> resolve the
> | merge conflict, and then look carefully at his list of files to be 
> committed
> | back when he was committing the results. There were lots of files 
> there, and
> | he knew that the merge conflict only involved a couple of files. For 
> his
> | commit, he unchecked all the other files changes that he was not 
> involved
> | in, committed the results and pushed the commit.
> 
> My understanding is that the OP actually wanted to create a similar 
> situation
> consciously. It's quite possible that they intend to never merge the 
> results
> back into "the main line" but anyway.
> 
> The point is, the feature you're advocating is bound to be abused 
> exactly
> through this "this is my stuff, and there is the stuff I do not care 
> about"
> attitude.
> 
> Having said that, I do not oppose these features (not that my opinion 
> should
> have any weight; I'm just making things clear) as in the end the only 
> workable
> solution to have decent quality of a project's content is "gatekeeping" 
> the
> changes by the review process.
> 
>  1. https://randyfay.com/content/avoiding-git-disasters-gory-story

Here's a similar story...  A while back, when I used Subversion heavily,
I (ab)used a lot its ability to perform partial updates to the working 
copy,
i.e. to run "svn update <path>".  It can be highly useful if used _VERY_
carefully, but it's also quite dangerous.  Like a chainsaw.

Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F103FDF59
	for <git@vger.kernel.org>; Mon, 29 Apr 2024 05:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714370397; cv=none; b=OQ4zspI0pF1BzOFGxYh5mWh6vrYdwmXZVfRQ0nwQrrSZ3a9JT16hsjNFQzHUPVnU7UIhXvFjmtThomsxlnwBxr2r6MdVxNaaahiCJqzJb3iFiQTkkxUxs1BQbJWCUtXzdSo88hRQqS2IM5+HrkbV37zVqdWbW7wxwIqF5BtZJwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714370397; c=relaxed/simple;
	bh=lGQa5nMXhe4iOVcEJ3Y9xMWFjsYYuvkOc0cWIleZUfc=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=dKmmI/Qp9XX8I4jDOgJCMUm+iT5kX9WlitpNnoR24xvWvirbRX3tMbfZu7K3+gBAEE51obwxer/raI/EoumoJwYWDjAjgkeNHK89+LeIjiLKddTVHibPIBL5o1pYNnSlyZlsE+xjo8HmkNaozMMxdSrZfLk42A2eQizW9Eu0CR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=PYEIpoGG; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="PYEIpoGG"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1714370392;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qUIxIfHZ/cZn/wJpBLTG3Z0x3vYwqYBUGur4Q6hGkVs=;
	b=PYEIpoGG4CedLGz0CTFOB7224A8PEOVvzMsavxKdV8d2RJVd9DOvvJLQiLJ9J4rZ/b33ex
	JnQc0PFLgii0DkkrP8dcFnlUGQ5tdvwJ9e+m+nB3pJH5RkVqsupBvSEn1G1iZ5y0UP6aNk
	oSVIMqOcckluHrKNmDhtOR1jb2S8AnNKuyBlvLj83uUDR9iudHJYrBv09ugz6yWrl3UsQH
	AThR9Q4dlToReSvaCqzKmNmgqf5VySALGFyYhWDXAzWQJ+9RzErSoKxDzazJdrWC1/D4T0
	/UqC7eABn97+PcLkL6jLEzcOnHk2ZgzVLQBSHpd60HKQWRsD2gH5aQweFsBy0A==
Date: Mon, 29 Apr 2024 07:59:52 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: James Liu <james@jamesliu.io>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 1/1] advice: add --no-advice global option
In-Reply-To: <809a1452fb18a6c03d9e8ed516d5c9c0@manjaro.org>
References: <20240424035857.84583-1-james@jamesliu.io>
 <20240429010925.93205-1-james@jamesliu.io>
 <20240429010925.93205-2-james@jamesliu.io>
 <37512328b1f3db4e8075bdb4beeb8929@manjaro.org>
 <D0WCCOLSMM9K.24BIGLR6EEJI8@jamesliu.io>
 <809a1452fb18a6c03d9e8ed516d5c9c0@manjaro.org>
Message-ID: <4991578233e75f5a9f096b701c4b5efd@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-04-29 07:36, Dragan Simic wrote:
> On 2024-04-29 07:01, James Liu wrote:
>> Thanks for the feedback Dragan!
> 
> Thank you for working on the patch.
> 
>>> After having a more detailed look at the Git documentation,
>>> I think that adding support for "--advice" at the same time
>>> would be the right thing to do.  That option would override
>>> all "advice.<hint>" options that may exist in the configuration
>>> (and would override the GIT_NO_ADVICE environment variable,
>>> if we end up supporting it), similarly to how "--paginate"
>>> overrides all "pager.<cmd>" in the configuration, which would
>>> be both consistent and rather useful in some situations.
>> 
>> I think this makes sense from a UX consistenty perspective, but I'm 
>> not
>> sure if we should increase the scope of this patch. It's also much
>> easier to re-enable previously silenced advice hints, so I'm unsure
>> whether an --advice option makes sense. We can also avoid the decision
>> of what to do if the user supplies --advice and --no-advice
>> simultaneously if we only have one option.
> 
> Regarding what to do if those two options are both supplied,
> it's simple, just error out with an appropriate error message.
> There are already similar situations in the code, e.g. with
> the -k and --rfc options for git-format-patch(1).

Actually, the -p/--paginate and -P/--no-pager options can
currently be supplied together, which isn't the expected
behavior.  I'm preparing a patch that will cover this as
a case of the mutual option exclusivity.

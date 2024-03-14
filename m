Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4340A71750
	for <git@vger.kernel.org>; Thu, 14 Mar 2024 18:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710442108; cv=none; b=ObxPrKkwNBD63rAXaCboh+LPsmE+TRO9QBuFP7rzW4dYgwi22v44gVFwhsXNyI8L3+zFETMRnMpcHMBc/moHF9yNkeVerwz/uacg17edY6KeujO81yghRRwGRD0Egz59N8aVFoxDEyHaw037rVy4Akczhpf7zs3zyKGyl3wqobA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710442108; c=relaxed/simple;
	bh=ii1bpErtqNUn4qWgVcHhJ43WfU66SOIJLNhS3HQszDI=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=Y002ciCs5lidAJG6td+DUSwf6anAY5SCoApFkRXFV/p5btDZcagV3tsFFHA95btLez40ej+OJDGyBhXtIhPZg+UeWZFJG5ExwMMlc4RfzUFgjdQ9i7LLnxWFBpIuIfpp3SEjCVAwJU9Mk+95Qh0ANwrfu9zWt5Hg6/ZtHaKmjFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=E3COC+2O; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="E3COC+2O"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1710442103;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2+KgVsBL5eu9vPGs6xxcD+yBVzXyspHbhmQWzyvbkw8=;
	b=E3COC+2OROU5hyB6SwTZ4kqN0rGr4HS8nKtpjwR1Ufqqygi5TM5R64oxL+1jHZh0WT4l/Q
	rIyX5NRjB05nSXqXF4fuwQAbjT+L4B99Xk+9Wm9+r9Yb9BRwC3zZHeU+QekOI/PiC1w+7n
	QkxUvuE3tgK8U1M9fbPvGsSkgYbzuDKFObY+Pc1S27pc6JUI+q1PouuiUkJWFT1N94D6FD
	7bKKDfixl4izCIVdhsun4RUBH0wZx9qS8NFLPucWkhkJrCIPxYqlEW6exXQ4fmVYTj6JNw
	13+u+Fy780oONrdHhmqslT48VLrqGRLgNuM18i4xWxVJNlThpooQFq+8aVxXlA==
Date: Thu, 14 Mar 2024 19:48:22 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, rsbecker@nexbridge.com, github@seichter.de
Subject: Re: [PATCH 1/3] config.txt: describe whitespace characters further
 and more accurately
In-Reply-To: <xmqqh6h8wymc.fsf@gitster.g>
References: <cover.1710258538.git.dsimic@manjaro.org>
 <1c670101fc29a9ccc71cf4d213545a564e14aa05.1710258538.git.dsimic@manjaro.org>
 <xmqqjzm51ugt.fsf@gitster.g> <ff7b0a2ead90ad9a9456141da5e4df4a@manjaro.org>
 <xmqqh6h8wymc.fsf@gitster.g>
Message-ID: <11be11f231f3bf41d0245c780c20693f@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-03-14 17:45, Junio C Hamano wrote:
> Dragan Simic <dsimic@manjaro.org> writes:
> 
>> Though, further investigation shows that setting a configuration 
>> value,
>> by invoking git-config(1), converts value-internal tabs into "\t" 
>> escape
>> sequences, which the value-parsing logic doesn't "squash" into spaces.
> 
> Correct.  It would have been nicer to just quote values that had
> whitespaces in them, but replacing HT to SP while turning HT that
> comes from our tool into "\t" would still let the value round-trip,
> while breaking anything written manually in editors.  If you stay
> within Git without using any editor, what ebdaae37 (config: Keep
> inner whitespace verbatim, 2009-07-30) left us is at least
> internally consistent.

Yes, but we already support unquoted values that contain whitespace
characters, and people use editors to configure variables.  For example,
I never use git-config(1) to make changes to my ~/.gitconfig file.

>> I'd be happy to include the bugfix into this series, if my
>> above-mentioned
>> fears prove to be unnecessary.
> 
> Documenting status quo is a good place to stop for now.  I do not
> know if it is a good idea to add too many tests to etch the current
> behaviour that we know is wrong and we'll need to update when we fix
> the bug, though.

But I already started to work on a bugfix?  I'm pretty much close to
completing the bugfix and doing some testing.

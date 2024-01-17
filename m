Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19BA825626
	for <git@vger.kernel.org>; Wed, 17 Jan 2024 22:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705528925; cv=none; b=KLtkjDvUFVswPHABew3UdUarA1ysyaUeGZB1ZgtZ2j9Cwm9zPUR89dlwgmlX3sg5sCeymI6kjz2iROTbjMT+Bk6ZLG5FYYFsAuSmCXnFnmaOv4xCQoTr4E5eYCwtGfmXmqFtQC0yoC6uXkLf28Efkb3dXLOrn8WEaFZ1cNpp5sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705528925; c=relaxed/simple;
	bh=g2YMyQJFY/WF3bksuHshWLcF8W62HP0RViUFcFHYTbo=;
	h=MIME-Version:DKIM-Signature:Date:From:To:Cc:Subject:In-Reply-To:
	 References:Message-ID:X-Sender:Content-Type:
	 Content-Transfer-Encoding; b=HtSz6kICTpxgKC+Kgd617bPtYwO5KDQQjawYPjtJGXsV8FJOIAFQm51/3O7u0KFZlh8eYRBUWhLEPJXCU9ktl5/kKekeXPC9fwPA3os9dk+pgdgVlEK6RWgkL9Cuf+UJn530bv4ckx2P/pCQAIuWGI5Sx4OR0HOkUULqgxw6wFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=lmTPtrL6; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="lmTPtrL6"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1705528920;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5ZdxNan7ekeRCsPEkyUIlpvV5WYgidjs4HXI2bIfrMw=;
	b=lmTPtrL6a2t27a7LJuX1eh+vA5LuYFui3cNIw/nxPQ54gKnN3xPbPEGlygO0VBGwr6nGwd
	NtyOzSKajS67p1mP9/+E6uCJEx4AfEHCPXIIm/rXCexCrKI0LahYhh7oy2xNy0NrevVBqP
	G1qKX8CFlGCO8VMapW42DJdLxqtPoCkRjKHY+KxoBIsp86k/P30g0g/mADfux/gd7Cq9No
	j98nUu40YvbIEJd/2ahkz3pio8ukkrp5aSNiF0yb0TguPTM2MYv3r8VGjGKAtkIbcbiGRe
	duvkrOZnKutOm2uLh7qvERJ84d5ATiZagfZp6JJFhywPFcU5K/uEgHNd79zZBQ==
Date: Wed, 17 Jan 2024 23:02:00 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Taylor Blau <me@ttaylorr.com>
Cc: Benji Kay via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, Benji Kay <okaybenji@gmail.com>
Subject: Re: [PATCH] push: improve consistency of output when "up to date"
In-Reply-To: <ZaBhHSCT7EOgTo/N@nand.local>
References: <pull.1638.git.1705008449995.gitgitgadget@gmail.com>
 <ZaBhHSCT7EOgTo/N@nand.local>
Message-ID: <d6161449aa19aebeb4c3bea1a751e8b5@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-01-11 22:43, Taylor Blau wrote:
> On Thu, Jan 11, 2024 at 09:27:29PM +0000, Benji Kay via GitGitGadget 
> wrote:
>> From: okaybenji <okaybenji@gmail.com>
>> 
>> When one issues the pull command, one may see "Already up to date."
>> When issuing the push command, one may have seen "Everything 
>> up-to-date".
>> To improve consistency, "Everything up to date." is printed instead.
>> (The hyphens have been removed, and a period has been added.)
>> 
>> Signed-off-by: okaybenji <okaybenji@gmail.com>
>> ---
>>     push: improve consistency of output when "up to date"
>> 
>> Published-As: 
>> https://github.com/gitgitgadget/git/releases/tag/pr-1638%2Fokaybenji%2Fup-to-date-v1
>> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git 
>> pr-1638/okaybenji/up-to-date-v1
>> Pull-Request: https://github.com/gitgitgadget/git/pull/1638
>> 
>>  transport.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/transport.c b/transport.c
>> index bd7899e9bf5..c42cb4e58b4 100644
>> --- a/transport.c
>> +++ b/transport.c
>> @@ -1467,7 +1467,7 @@ int transport_push(struct repository *r,
>>  	if (porcelain && !push_ret)
>>  		puts("Done");
>>  	else if (!quiet && !ret && !transport_refs_pushed(remote_refs))
>> -		fprintf(stderr, "Everything up-to-date\n");
>> +		fprintf(stderr, "Everything up to date.\n");
> 
> Between the two, I have a vague preference towards "up-to-date", which
> would suggest changing the pull command's output to read "Already
> up-to-date". Personally I think that neither of them should include a
> period in their output, but whichever we decide should be done so
> consistently between the two.

I'm not a native English speaker, but I spent years contributing to 
English Wikipedia.  According to the manual of style employed by 
Wikipedia, which is based mainly on The Chicago Manual of Style, 
hyphenated forms should not be used at the ends of sentences, or at the 
ends of sentence-like forms.  In this case, we don't have complete 
sentences.

[1] https://www.chicagomanualofstyle.org/home.html

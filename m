Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADFD429408
	for <git@vger.kernel.org>; Mon,  3 Jun 2024 20:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717445979; cv=none; b=tpS2p6Us7e9Is41wmU5sZhRAga3IUgcHen97CoJr3cQQNluEFXmjWpC1mIKx/CRu9zeJCGR+//eCIgZyC2RHjNgFxByXic81hdec4WBlPJTeZ+9pafvtPpxpAn0YdDvWGtBOb1E2l7eV3eDTNvjFHWYedFSWq6ABUQ2BolSh6Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717445979; c=relaxed/simple;
	bh=xlXhi9xPHW/qs65wwvjo6Rv3s034B5OfB6qN57McknY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pbDktJyvs3EQjkmfYpLSGke7zWUe4dbk33CbRswL2nSw67HYpdK7mAsxmq4sWKmKenC0q2uGuWH3+7Qprit2vw6wmpsbZb/dxt6B+m08mGbfYAIN1vJsz+/QeQDWyT5yJLMzgIIEQIihtgqI660/Ak5ZoQp3nSRZ0s9OxvB6kcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l4zY1TAF; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l4zY1TAF"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4213373568dso27416335e9.0
        for <git@vger.kernel.org>; Mon, 03 Jun 2024 13:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717445976; x=1718050776; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DU5s5Hjae7xbbotLB0J8Pg85RroZYYC97XHnf5jtl48=;
        b=l4zY1TAFjX0OHGrQ4imYJEvjYJiPD2I11nGdZUnJScYx6mLb9D0kVVKCb3e1qwG80a
         HIn8HDULqlIkTp3j4gBnpaRgTpipuen4n/HTF69cE3fC1nv7j4OFqMC0HLp7VS3wqZYd
         mcBaDz9qk9WslaL4WcJnJJ7Q9UvDzt69byXRVG0bssrVeJIbqGd5BYdeQZQZSfQvuMQP
         pq7PSkDV4giDXptgevm4hcxmePhEi0Xp2fNSdUUNIqj6/77rw4zNalL3ep0RDNEANcpC
         ewcb4a3gNsH08FXFOMggG9uEh7OO5DDVPOFzJ+S4geNvUM2kSoZEIqRjoWk2qR/eMWFJ
         LjPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717445976; x=1718050776;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DU5s5Hjae7xbbotLB0J8Pg85RroZYYC97XHnf5jtl48=;
        b=pWuPjJK27VHt3B5fUIsAjEjoVppRn2vQWKokERfk7kzOIAlSelN4y4Gpt/txONxnCf
         myDstcmsoG0Z9srItxEMa8co6aCOug57bx7lFdMKsLGbx9ttRUnO5RAyK3uswGkepWhr
         LRft0yRShC6YF2NAGCNYsWhzP8pvg/+vWUhMZPeNq1QIjQ5BAlX9pC3buNYOxxIvfmKH
         PvewW+XOdFP9puXC8kiaUxWzvlmCX61acxflnKjz6Vah0m9/6rB8nzkA92oW7SRFalsx
         KOuCXhdeGxdFCIi/v4/bg3hIf1SdZbjhun8celD4iv5yRw6HU6YUKwVnpBCNb12TN8VU
         s5Wg==
X-Gm-Message-State: AOJu0Yy5KNbnGMZZ7SVqBLLsjnyQmr10YqaCJfsfcKZKKZccoX6+iKyb
	RZUW1N4k2pLF9GffLz3DDRCR+brbKiJjnrKCouOYH48Mxm96C8I2
X-Google-Smtp-Source: AGHT+IHhz25nBNQ5jiX2O7+bb7qo5fC7rmTsjXLy7C+rZvwTuoGWJbNWDWiSvsQB+1gikVqRgQh7eg==
X-Received: by 2002:a05:600c:3595:b0:41f:fca0:8c09 with SMTP id 5b1f17b1804b1-4212e0bddf6mr73236565e9.40.1717445975766;
        Mon, 03 Jun 2024 13:19:35 -0700 (PDT)
Received: from gmail.com (20.red-88-14-43.dynamicip.rima-tde.net. [88.14.43.20])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4214a4abdd5sm1330195e9.0.2024.06.03.13.19.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jun 2024 13:19:35 -0700 (PDT)
Message-ID: <9d05b41f-c120-4db0-9ee5-e24d20389129@gmail.com>
Date: Mon, 3 Jun 2024 22:19:34 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/6] use the pager in 'add -p'
To: Dragan Simic <dsimic@manjaro.org>
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
 Jeff King <peff@peff.net>
References: <1d0cb55c-5f32-419a-b593-d5f0969a51fd@gmail.com>
 <199072a9-a3fb-4c8d-b867-b0717a10bacc@gmail.com>
 <b7e24b08-40a1-4b18-89f6-e25ab96facaf@gmail.com>
 <81d52b31ce4c287765a43d87d94f526b@manjaro.org>
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
Content-Language: en-US
In-Reply-To: <81d52b31ce4c287765a43d87d94f526b@manjaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On Sun, Jun 02, 2024 at 07:36:37PM +0200, Dragan Simic wrote:

> The way I see it, using "| <program>" should follow the de facto rules
> already established by the "--color=auto" command-line option in multiple
> utilities.  Thus, when piping to a custom program, the escape codes that
> perform the coloring should be stripped.

Interesting.  However, I'd like to find a way to keep the escape codes
when using programs like: '|head';  perhaps with the '>' command,
suggested by Junio.

At any rate, I feel we can leave that, perhaps corner-case scenario, for
a future series.  As this series is mainly about the 'pager' machinery.

> 
> > This, a new 'interactive.pipeCommand' setting, or a new switch: 'add
> > -P',
> > are left for discussing in, hopefully, a future series.
> > 
> > One final note;  I preferred to model the help text this way:
> > 
> >     y - stage this hunk
> >     n - do not stage this hunk
> >     q - quit; do not stage this hunk or any of the remaining ones
> >     a - stage this hunk and all later hunks in the file
> >     d - do not stage this hunk or any of the later hunks in the file
> >     j - leave this hunk undecided, see next undecided hunk
> >     J - leave this hunk undecided, see next hunk
> >     g - select a hunk to go to
> >     / - search for a hunk matching the given regex
> >     s - split the current hunk into smaller hunks
> >     e - manually edit the current hunk
> >     p - print the current hunk
> >     | - pipe the current hunk to the pager, or |<program> to use a
> > program'
> >     ? - print help
> 
> I also like this form better, but I think wording could be improved.
> I'll think a bit more about it, maybe something like this:
> 
>       | - use pager to show the current hunk, or use |<program> to customize

Certainly!  It is indeed a sensible idea to improve the wording, avoiding
the word "pipe" :-).  Thank you.

> 
> Also, what's the single quote doing after "use a program"?

Just a typo.  Sorry.

> 
> > Instead of:
> > 
> >     y - stage this hunk
> >     n - do not stage this hunk
> >     q - quit; do not stage this hunk or any of the remaining ones
> >     a - stage this hunk and all later hunks in the file
> >     d - do not stage this hunk or any of the later hunks in the file
> >     j - leave this hunk undecided, see next undecided hunk
> >     J - leave this hunk undecided, see next hunk
> >     g - select a hunk to go to
> >     / - search for a hunk matching the given regex
> >     s - split the current hunk into smaller hunks
> >     e - manually edit the current hunk
> >     p - print the current hunk
> >     |[program] - pipe the current hunk to a program, the pager if
> > none...
> >     ? - print help
> > 
> > Because I believe it reads better by maintaining a single character
> > before the dash.  But I am not opposed to the latter.

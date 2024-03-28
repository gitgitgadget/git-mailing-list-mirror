Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 257B317E
	for <git@vger.kernel.org>; Thu, 28 Mar 2024 19:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711652698; cv=none; b=j/llFs1D4rQF5LJZwaaxSrDHlkODhPUMFiEHIAO7RUthtA3FbDqqtjlEsAOkcmpNkqehYmp+oXz/J65pBR39aw8ShzfiwqaO4o4kH2LTCjLyJv+e8b2/kZ9URH2BIz18cnWItV0Zz5fltwvvVVpdSyxwRdiIRnXzVc7B7cARASY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711652698; c=relaxed/simple;
	bh=tRW2udWtEGbQoDYeIoWZPjnigk4K7wL6nezdVbGhGtA=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=gI7+XDa7L6vqvHWW0jSfRgKY7h4DweolSbKrrp3aUqYO7F93t1Wt1p6WE4wdl/nDwLsFQBtrad5rnUzyeLm7vGnZfZkKr6UrVCM/856KDUWBYeCRwrEog4+sGBa9myClnxS5VnC2sSl6GL9E24z3I9mdXRM+5UIMdW1GszSd+lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=k/voOnuU; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="k/voOnuU"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1711652694;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yHb5orXNUH766Hc18RIEHnbzfjcDOr64nXiCTFETt/4=;
	b=k/voOnuUMHXMhDbz+/P0AopncIHp/UneTIFR1iwHYp8O96MDQU1Gmu3zLfWGJxwrJxb+Ho
	6V+zVzpsLPia5yqGQjMt4qTuGQPUCYZOhLmNRFuoHQQHwfjhjBIoAywriyLLBdDbs7MQlG
	aoa5KuQ3lEFJTzmRpB7AKTXn+TP4T3lvcaLfxcbY5gjbLWeREyjMOHDzJC9MuiJDcDyOPn
	YX4lW4c9gav5e0OzO9A4e9bPQquALkXsGOHd598Gh7ZaiF1rnByoV07oCqFT5NVDaBRDjs
	HzURgjGNoqlr0U7Z7JIODTsOiMa3DFUPUyM2Cmy6FznBCsYHdIpU7lry+e9+CA==
Date: Thu, 28 Mar 2024 20:04:54 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Eugenio Bargiacchi <svalorzen@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: Better visual separation of hunks in `git add -p`
In-Reply-To: <CAHfn=+tsrgAyUUqUkq4TpXcABr7=ZcH+cna+vwALJqZ3H8LxFA@mail.gmail.com>
References: <CAHfn=+snXChcPFiEgxvK=XFCq2uVMKQTyfrN9RNfAod18d0V=Q@mail.gmail.com>
 <xmqqo7ayuwpi.fsf@gitster.g> <a9cffbe4aadd319760635ca6d5b4f465@manjaro.org>
 <xmqq1q7uusin.fsf@gitster.g> <1b81a013dd0faccdc24fe018fd740755@manjaro.org>
 <CAHfn=+tsrgAyUUqUkq4TpXcABr7=ZcH+cna+vwALJqZ3H8LxFA@mail.gmail.com>
Message-ID: <26f8d21dfd53d699804485b0f8c6abe1@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-03-28 20:01, Eugenio Bargiacchi wrote:
>> Here's a possible solution, or better said a new configuration option,
>> which I've been thinking about for a while...  When running "add -p",
>> displayed chunks can sometimes become confusing or a bit hard on the
>> eyes, but simply clearing the screen _before_ displaying any new step
>> (i.e. a new chunk, interactive help, etc.) could make it much easier
>> on the eyes.  It would be a new option, of course.
> 
> In my head, an option to print an arbitrary string would be amazing,
> since then if wanted one can print a special character that clears the
> screen, or simply add some space, or something else.

Huh, letting the users handle screen clearing that way could be rather
problematic, because different terminals may do it differently.

> On Thu, 28 Mar 2024 at 19:29, Dragan Simic <dsimic@manjaro.org> wrote:
>> 
>> On 2024-03-28 19:21, Junio C Hamano wrote:
>> > Dragan Simic <dsimic@manjaro.org> writes:
>> >
>> >> Here's a possible solution, or better said a new configuration option,
>> >> which I've been thinking about for a while...  When running "add -p",
>> >> displayed chunks can sometimes become confusing or a bit hard on the
>> >> eyes, but simply clearing the screen _before_ displaying any new step
>> >> (i.e. a new chunk, interactive help, etc.) could make it much easier
>> >> on the eyes.  It would be a new option, of course.
>> >
>> > Or your 'p' option can have a 'P' variant that clears before prints.
>> > I have this feeling that even those who want clearing of the screen,
>> > they do not want it always on, when many of their hunks are 7 lines
>> > long.
>> 
>> That would be even better.  Though, would adding new short 
>> command-line
>> option to git-add be frowned upon?

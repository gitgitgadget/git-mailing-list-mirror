Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B02183CCB
	for <git@vger.kernel.org>; Thu,  8 Aug 2024 15:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723132063; cv=none; b=SO2jpPybmpB5HEPYa7c2jgeCEoCZOZH4waYxfXpZ4tXNGLlNIKv5LjauDLmshczVvitLGT9PvMfOyiTd0/4e5Ttweekb6kjxVclAhIzz8wWjYl7IpRE5nCzC0SKzVQkR+v8ZvN2hXBASEPk1CCbzveN5E8gvM0rMvGzVKy8nhvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723132063; c=relaxed/simple;
	bh=V3kPfHKy+xmw322ci/oAvUVp4SrCRCuqvfT9LlKYbX8=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=YhrpWSHL0ohbN4kQNfp9pR2AlLhsTx65TuJCo7BJVOKwWJSf9mdGoOkbiF2I2LzHBq0u47k8sjcVx2l0qC4hOhqkPrHRORTDyvQylCzJjTTbox8QymSQRUTsFGyuBlnuQQAED7CUIzj5PPWNLx2ZlOkvVRwJ1ITEXYfu/Acp3fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=vJhD2ug/; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="vJhD2ug/"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1723132057;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0YUmtJae59lhlaTJngVhB9CNJ40ow7VoNDZmCjgrc7A=;
	b=vJhD2ug/o14yNxqUTUMUeqJ0SO8gIf1BshR1ASdDtvIgcuQ85+QpsgYMtgaHxvVndry/nk
	AcYb4lAS/ZRIMVYOahorEdbpWlyL8uW7QeZe0CD3qh2kJQeqBOKtevcwCr6sJbeD58hsjD
	x5KNsgAAH38tprfH6ckBcxRobXwzE7ZnU80LRc+VsJuuPXDihL4GWmSsmup5E2pMZgcYU1
	Wz2bKMg3Ie2RkoVO7dtRpfBn3HL4S1g73mz75LRiOYhvQVhJo/jS6wtd/qg1jM+wU6Vpv8
	aPdkKVK5Rzi1Dy1y6c6N6SmNvY1ZMMVpreCj43EN7YhpoSmffJx6hyHj3fdqJA==
Date: Thu, 08 Aug 2024 17:47:37 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: rsbecker@nexbridge.com
Cc: "'Jason A. Donenfeld'" <Jason@zx2c4.com>, 'Josh Steadmon'
 <steadmon@google.com>, git@vger.kernel.org, calvinwan@google.com,
 spectral@google.com, emilyshaffer@google.com, emrass@google.com
Subject: Re: [RFC PATCH 0/6] [RFC] Introduce cgit-rs, a Rust wrapper around
 libgit.a
In-Reply-To: <009101dae9a8$fc66bd20$f5343760$@nexbridge.com>
References: <cover.1723054623.git.steadmon@google.com>
 <ZrSxLU-7rmlvdTHC@zx2c4.com> <9fbe5ca8bf133db8f614c0e90ac5fccb@manjaro.org>
 <009101dae9a8$fc66bd20$f5343760$@nexbridge.com>
Message-ID: <6668417d9663e805643c504369bf2506@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-08-08 17:38, rsbecker@nexbridge.com wrote:
> On Thursday, August 8, 2024 9:59 AM, Dragan Simic wrote:
>> On 2024-08-08 13:51, Jason A. Donenfeld wrote:
>>> Cgit maintainer here...
>>> 
>>> On Wed, Aug 07, 2024 at 11:21:25AM -0700, Josh Steadmon wrote:
>>>> * bikeshedding on the name (yes, really). There is an active,
>>>> unrelated
>>>>   CGit project [4] that we only recently became aware of. We
>>>> originally
>>>>   took the name "cgit" because at $DAYJOB we sometimes refer to
>>>> git.git
>>>>   as "cgit" to distinguish it from jgit [5].
>>> 
>>> Indeed, please find something else. Cgit is a real project, used by
>>> many, such as git.kernel.org, and it'll turn into a real hassle for
>>> both of us if there's ambiguity and confusion.
>> 
>> Totally agreed, naming it cgit-rs makes pretty much no sense.
>> 
>>> What about libgit-rs? Or even libgit3, where the rustness of it is
>>> simply an implementation detail, so the name won't feel dated 15 
>>> years
>>> from now when everything is written in Rust anyway and -rs is so 
>>> 2020s?
>> 
>> Well, there are still very active commercial projects written in COBOL 
>> or Clipper, for
>> example, so I wouldn't go as far as _everything_ being written in Rust 
>> at some point.
> 
> There are hundreds of millions of lines of code in the NonStop (TAL,
> COBOL, C, Java,
> in that order) community that is actively maintained to this day, with 
> no Rust
> involvement (not for lack of trying to get Rust ported). Without these
> projects, most
> of your credit and debit cards would probably not work. 😉 Many of
> these repositories
> are more than 500Mb, with a couple I have seen exceeding 2Gb (just for
> source code).

Those are good examples.  Also, I believe that the entire financial 
system of
a country from South America runs on software written in Clipper, and 
they keep
producing modern Clipper compilers that run on Windows.  Let me remind 
you that
Cliper was used back in the days of DOS and 5.25-inch floppies. :)

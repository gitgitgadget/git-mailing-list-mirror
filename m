Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0BFD84A33
	for <git@vger.kernel.org>; Tue,  4 Jun 2024 18:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717524829; cv=none; b=Ae+i5Mfss7M+elwQc4ZicO+IcfEhyEk0Brd+63kmU9Nkwal5Qk1Qcr/0ZW2BzwfRiO6xh8w+DZmAUCdpp7HLbdiDtaL9FXWjUcrp73meXq5G3G2j+fS+3uJvVhCVOVkfWy1Iu/w4v6/qRz3cuxDO/Jh9pQdTEs2nAWpkCoCN904=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717524829; c=relaxed/simple;
	bh=fR6Gj2Sn/SO7BRTOWZrG44YRXVcoJC+KsDtHWonI7Ng=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=XxOOFvmC/EHhjQIK7A/dt5UQ9u9XM3+O0BMRxc8SyO2HQ6G6G6TdDFluJIHSjM+g4wQ7NsXMOs5bj9lrIlaZwDFJvML2PndyHj8IBV4M1e8D2xqruxceroaPPioulQAJKLPLh6lLYKoryijIQ06Mk90pvLeIltqLoGH24iFQ62w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=PvoBaUez; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="PvoBaUez"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1717524824;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BsyQjnNNtFRGoujzrDlvsRZUHfFZDKeYRqOW/XU2D6c=;
	b=PvoBaUezcaRpzZ0G16KVCwXWz2oxRA6/g7JFjziASb4nAhAYcYbGQT90gWubG/kiXXvpF1
	EXv33RSLeBzo+rifnldK7rUQWF4rW8OplEjsUET5M0HsDf9rgahG2MQZwOhqHAVwIVgRId
	BdbJlriqKz22Nkj7SQtZmEYNwOHXLWgbFu7D0ambq1dzGnE15jzaOm4WDY2xDxvnVnuYIc
	9B0IqzH+fa84ZxUymJ2xzbOurGGPmCxiH+eU6PvkuMc2f/XIKXAxizjbbjifiyPqTAwfXO
	n7NVUOBQh8GsoyBdpaumwuXjnxyocCD+Sn0BvaY8sY3AgHKxDfTLcaD5n+1Ucg==
Date: Tue, 04 Jun 2024 20:13:43 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>, Jeff
 King <peff@peff.net>
Subject: Re: [PATCH v3 0/6] use the pager in 'add -p'
In-Reply-To: <9d05b41f-c120-4db0-9ee5-e24d20389129@gmail.com>
References: <1d0cb55c-5f32-419a-b593-d5f0969a51fd@gmail.com>
 <199072a9-a3fb-4c8d-b867-b0717a10bacc@gmail.com>
 <b7e24b08-40a1-4b18-89f6-e25ab96facaf@gmail.com>
 <81d52b31ce4c287765a43d87d94f526b@manjaro.org>
 <9d05b41f-c120-4db0-9ee5-e24d20389129@gmail.com>
Message-ID: <844704794168f9fcb85c75014c84cde0@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-06-03 22:19, Rubén Justo wrote:
> On Sun, Jun 02, 2024 at 07:36:37PM +0200, Dragan Simic wrote:
> 
>> The way I see it, using "| <program>" should follow the de facto rules
>> already established by the "--color=auto" command-line option in 
>> multiple
>> utilities.  Thus, when piping to a custom program, the escape codes 
>> that
>> perform the coloring should be stripped.
> 
> Interesting.  However, I'd like to find a way to keep the escape codes
> when using programs like: '|head';  perhaps with the '>' command,
> suggested by Junio.
> 
> At any rate, I feel we can leave that, perhaps corner-case scenario, 
> for
> a future series.  As this series is mainly about the 'pager' machinery.

I'd suggest that "| <program>" is made to work as "--color=auto" in
the current series, i.e. with the coloring escape sequences stripped,
which is the safe approach because we don't know is "<program>" capable
of handling those escape sequences, while implementing support for
"--color=always" would be left for a follow-up series.  Using ">" for
that future command makes sense to me, because it suggests an output
redirection in raw form.

Of course, the plain "|" should still leave the coloring escape 
sequences
intact, because the configured pager (or the default pager, configured
by Git internally) is expected to handle them properly.

>> > This, a new 'interactive.pipeCommand' setting, or a new switch: 'add
>> > -P',
>> > are left for discussing in, hopefully, a future series.
>> >
>> > One final note;  I preferred to model the help text this way:
>> >
>> >     y - stage this hunk
>> >     n - do not stage this hunk
>> >     q - quit; do not stage this hunk or any of the remaining ones
>> >     a - stage this hunk and all later hunks in the file
>> >     d - do not stage this hunk or any of the later hunks in the file
>> >     j - leave this hunk undecided, see next undecided hunk
>> >     J - leave this hunk undecided, see next hunk
>> >     g - select a hunk to go to
>> >     / - search for a hunk matching the given regex
>> >     s - split the current hunk into smaller hunks
>> >     e - manually edit the current hunk
>> >     p - print the current hunk
>> >     | - pipe the current hunk to the pager, or |<program> to use a
>> > program'
>> >     ? - print help
>> 
>> I also like this form better, but I think wording could be improved.
>> I'll think a bit more about it, maybe something like this:
>> 
>>       | - use pager to show the current hunk, or use |<program> to 
>> customize
> 
> Certainly!  It is indeed a sensible idea to improve the wording, 
> avoiding
> the word "pipe" :-).  Thank you.

I'm glad that you like it. :)

>> Also, what's the single quote doing after "use a program"?
> 
> Just a typo.  Sorry.

Ah, I see.  It looked a bit strange. :)

>> > Instead of:
>> >
>> >     y - stage this hunk
>> >     n - do not stage this hunk
>> >     q - quit; do not stage this hunk or any of the remaining ones
>> >     a - stage this hunk and all later hunks in the file
>> >     d - do not stage this hunk or any of the later hunks in the file
>> >     j - leave this hunk undecided, see next undecided hunk
>> >     J - leave this hunk undecided, see next hunk
>> >     g - select a hunk to go to
>> >     / - search for a hunk matching the given regex
>> >     s - split the current hunk into smaller hunks
>> >     e - manually edit the current hunk
>> >     p - print the current hunk
>> >     |[program] - pipe the current hunk to a program, the pager if
>> > none...
>> >     ? - print help
>> >
>> > Because I believe it reads better by maintaining a single character
>> > before the dash.  But I am not opposed to the latter.

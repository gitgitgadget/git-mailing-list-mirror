Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076771CA89
	for <git@vger.kernel.org>; Sun,  9 Jun 2024 17:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717953643; cv=none; b=YXkYEK9FTq172CmpD/PfTTAzU17LF6UPd3v9TWqLckEaGbun6CZcfFzsf65zs8jMPOjv15Cw3s96WP/8C1KFgnxcfdpzY5IL2IsiWdKw1dBv+pxz2XP9uZQ5qDJ+ZY6WadOaWAZcHXUI8M4KbAqCKqPGyZOwz3g4goRNwCCNx78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717953643; c=relaxed/simple;
	bh=58tD7Zlk0Xcz3pNscPFw7BxyaExXWeclZAM4melT9tQ=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=rshqfl6nxGUAJ7cm4k9dWYqZXnIHW3jq0e4YxlonFspw6MJs0gaPJaIvHlllNhPPqGV97mBIM6p78TZz5sHCr4rIdQQQEqUu68nwDlfZ974jClLl8oqZ9irldq6dtnsAGYI9Qe1rolJuncszqFudZtOjri7LhXWZjVKYMqE4RC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=bQTEv4q1; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="bQTEv4q1"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1717953637;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ni/+Zg5XBWm9MrHGqsyfwYVm5uWqzeduBX18mUyTVPQ=;
	b=bQTEv4q1uEo915gUFC66vQLYlN7JLujL8WGZ9KzEttToxngFj2L4zWB2jcPBzgKJs2elvx
	6AI7WuIzKz7u8KfoYKSe4Oda+tCyYSUhNEXu9kUfZOipMosgNC+We5utgBwecbpdAQypY+
	JyPxMVO3AJ3OwfWPwBiZ8617AAOJZQ/FnxSDrJrWhTiLsL9mK+qoM5wVm5PTzogj7EgPZ5
	PYNOmqDhyyN82y390aaYEoyjfCO7OEe1pCDdQ4aSy70DzYvFrC5mdSgU1v9YEBJglcpwHO
	KWz7zhynAYcvE47ccGZ0gHBDmFAg11ieQSxb/MS6J9GmLppG1lNLmRLSWE6XPQ==
Date: Sun, 09 Jun 2024 19:20:36 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: phillip.wood@dunelm.org.uk
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
 =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>, Git List
 <git@vger.kernel.org>
Subject: Re: [PATCH v3 0/6] use the pager in 'add -p'
In-Reply-To: <a2a59f5e-fd55-41d3-8472-b99256e1f428@gmail.com>
References: <1d0cb55c-5f32-419a-b593-d5f0969a51fd@gmail.com>
 <199072a9-a3fb-4c8d-b867-b0717a10bacc@gmail.com>
 <b7e24b08-40a1-4b18-89f6-e25ab96facaf@gmail.com>
 <20240604101700.GA1781455@coredump.intra.peff.net>
 <xmqqikyo207f.fsf@gitster.g>
 <20240605090935.GF2345232@coredump.intra.peff.net>
 <6056d585-6380-43e7-adf1-9f9aadd2a7db@gmail.com>
 <a8d3415e3913e3a0798a748ed7f7a093@manjaro.org>
 <a2a59f5e-fd55-41d3-8472-b99256e1f428@gmail.com>
Message-ID: <d092f5bb1d3bc7b7a821000a3cad8a1e@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Phillip,

On 2024-06-09 16:29, phillip.wood123@gmail.com wrote:
> On 08/06/2024 06:54, Dragan Simic wrote:
>> On 2024-06-05 15:21, Phillip Wood wrote:
>>> On 05/06/2024 10:09, Jeff King wrote:
>>>> On Tue, Jun 04, 2024 at 08:32:04AM -0700, Junio C Hamano wrote:
>>>> 
>>>> Given that the main use case for "|" is for human viewing through a
>>>> pager, I think the colorful, filtered version meant for users is the
>>>> best default. And then the "bare" version can come from an alternate
>>>> command or a knob.
>>> 
>>> I think that's a very good point. It is hard to see what "|" can be
>>> used for other than viewing the hunk as (a) git does not read the
>>> output so it cannot be used to filter or edit the hunk that is 
>>> applied
>>> and (b) we pass an isolated hunk so the post-image offset in the hunk
>>> header is likely to be wrong and there is no indication as to which
>>> file it comes from so the program being run cannot apply the hunk
>>> itself. Having the escape codes does make it harder to filter the
>>> hunk. For example to just look at the post-image as one needs to do
>>> something like
>>> 
>>>     grep '^[^-+ @]*[+ @]'
>>> 
>>> instead of just using '^[+ @]' as the pattern but the bonus is that
>>> the output is colored.
>> 
>> Agreed, but as I already explained, [1] only when using the bare "|"
>> command.  When "|xyz" is used instead, the version of the hunk with
>> no coloring escape sequences should be piped to xyz.
> 
> Having read the message you referenced I'm struggling to understand
> the use-case for stripping escape codes - what do you want to do with
> the hunk that means you want to remove the color?

Let me recap, please.  Basically, when an output of some command is
piped into another command, e.g. by running "grep -r abc . | grep def",
the command that produces the piped output doesn't put the coloring
escape codes into the produced output, because it's unknown can the
command that receives it handle those escape codes properly.  That's
become some kind of de facto standard embodied into the "--color=auto"
command-line option for various utilities.

In the example above, one can have "grep -n --color=auto" defined as
their alias for "grep", which is what I use, and the "grep -r abc"
produces the output with no coloring escape sequences, which gets
piped into "grep def" that does produce coloring escape codes, because
its output goes to the terminal emulator, which is expected to handle
those escape codes properly.

In our use case, Git becomes what produces a hunk as the output that
gets piped into some program "xyz" by receiving "|xyz" as the command
while "git add -p" is executed, but it isn't known can "xyz" handle
the coloring escape sequences properly, so they should not be included
in the piped output, i.e. in the produced hunk.

As discussed later, [2] we could introduce ">xyz" as another command
for "git add -p", so receiving ">xyz" from the user would pipe the
hunk to "xyz" with the coloring escape sequences included, because
the user already knows that "xyz" can handle them.  Separating this
into two commands is a safe approach.

I hope this makes the whole thing more clear.

[1] 
https://lore.kernel.org/git/844704794168f9fcb85c75014c84cde0@manjaro.org/
[2] 
https://lore.kernel.org/git/7937845d7cb7ae0179c4922ed154c5c7@manjaro.org/

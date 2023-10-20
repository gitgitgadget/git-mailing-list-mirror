Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4CCC1A71B
	for <git@vger.kernel.org>; Fri, 20 Oct 2023 23:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="X5Ka30Yy"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04A421A8
	for <git@vger.kernel.org>; Fri, 20 Oct 2023 16:02:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1697842966;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HZt+uzLJT0/xCFz3H/g6FhXSgYu4KHRCwyr12IDZLFk=;
	b=X5Ka30YygUPkrDjKUflPJgvwJET0RgSN1wCz7JsiPBXFByZ55ZvgJUV3fAkcl0e7cJOWLi
	6Q0K7PRtnDrXxexPsollL3ZQcUCj7lcVnLE3A5ZAGOQQASrBVDdXLtqrt3mqgMRQa4WTsH
	KuiJBp4A2OuXmlfiMkA9QyzbgwtRnmnW0T7MaO+X/M/RK7QFtkGTQDoi94j97hWc4E8mjj
	l2d18xsob4U6pFxPYud3waWBBnxPUFtc3bTh8TmTOApY4iXyCeGtQIpbc/u03M0xtwCJtL
	DI/UFz+O3bkoYpcEnadPz7Stw4mH0SyRyc3oCdiMWkXoKvn7s/RHmLXIiOio+Q==
Date: Sat, 21 Oct 2023 01:02:46 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Jacob Stopak <jacob@initialcommit.io>
Cc: git@vger.kernel.org
Subject: Re: [RFC PATCH 0/5] Introduce -t, --table for status/add commands
In-Reply-To: <ZTL1wJIIK/5YWQK5.jacob@initialcommit.io>
References: <20231020183947.463882-1-jacob@initialcommit.io>
 <fd26df85661d554ced9d8e0445f75952@manjaro.org>
 <ZTL1wJIIK/5YWQK5.jacob@initialcommit.io>
Message-ID: <d3bbe53c3b910f891c80465ea0c3f53f@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2023-10-20 23:48, Jacob Stopak wrote:
> On Fri, Oct 20, 2023 at 08:48:12PM +0200, Dragan Simic wrote:
>> On 2023-10-20 20:39, Jacob Stopak wrote:
>> > This is a proposal / proof-of-concept for a new table-based output
>> > format for the git status command, and for dry runs (-n) of the git add
>> > command. This could be extended to create visual dry runs for other
>> > other commands like rm, mv, restore, stash, commit, and clean.
>> 
>> Huh, please don't get me wrong, but based on the examples provided 
>> below, I
>> really think that's only wasted screen estate, providing little or no 
>> help
>> in understanding the performed operations.
>> 
>> I appreciate your effort, but IMHO it makes little sense from the 
>> usability
>> standpoint.
>> 
> Thanks for the quick (and honest ;) reply - I appreciate it and no 
> offense
> taken! But let me try to expand on my reasoning a bit.

Thank you!

> I agree with you that Git users who are already comfortable with Git,
> the command-line, and their workflows would be unlikely to use this in
> their day to day work.
> 
> The main benefits of this format are for beginners and folks who
> are still learning Git to use it as needed:

Oh, I always do my best to put myself in the shoes of the targeted 
audience.  Maybe I sometimes fail at that, I don't know, but that's why 
we're here to discuss it further.

>   * To beginners, the concepts of working directory and "staging area"
>     can be very abstract. By representing these concepts as table 
> columns
>     on the screen, (a format that 99% of humans are used to 
> interpreting),
>     they become more tangible and intuitive to new users.

Frankly, based on my rather broad experience, there are two primary 
categories of the beginners in the world of version control software 
(VCS), be it git or any other product:

1) People who are forced to use some VCS at work, and they actually 
don't give a damn about it.
2) True enthusiasts who love what they do, and who love expanding their 
knowledge.

For the first category, nothing helps.  For the second category, a 
nicely written tutorial is all they needed to start with, aided later 
with the man pages, Stack Exchange, and perhaps some textbook.

>   * In Git, changes fly around all over the place, in all sorts of
>     directions. Even small hints at this movement can be very helpful 
> to
>     understand what the heck is going on. The table format (esp with
>     arrows used in the 'git add' version) highlights the "flow" of
>     changes through the workflow in a way that the current default 
> format
>     doesn't. The current dry runs just show the filenames being added
>     without context of _where_ they come from and where they are going.
>     Not to mention many commands don't even have dry runs. This might
>     sound like a small thing, but to a newbie having that extra level 
> of
>     confirmation and understanding can make a big difference.

Please don't get me wrong, I understand your reasoning, but again, it 
all comes down to the two categories described above.  IMHO, the second 
category will likely start turning off the default hints sooner than 
turning the table formatting on.  The first category will choose some 
GUI anyway.

>   * Git doesn't exactly have a reputation as a user-friendly tool, and
>     much of that stems from the difficulty of learning Git. So we 
> should
>     try to make it more approachable to normal humans. This format
>     (esp if applied to a wide variety of commands as dry runs) would
>     provide a rudimentary visual output that is more intuitive to 
> users.

No pain, no gain.  That's the ancient mantra, but IMHO it still applies 
very well to many things, and of course not to the first category 
mentioned above.  Nothing applies to that category.

>   * This flag doesn't change any default behavior, it can easily be
>     tossed on for newbie use (either when teaching a newbie or when the
>     newbie is practicing on their own). Given this usage, the screen
>     realestate is not really a concern. I.e. this would be used
>     specifically when needed for the extra info/clarity it provides,
>     not to be efficient with the terminal space.

As I already assumed above, the targeted audience will likely start 
turning the default hints off, rather than turning the table formatting 
on.  Maybe I'm wrong there, who knows.

> That's my perspective anyway, but of course the point of this is to
> propose it to the community and hear the response, so even if it's
> not included it's still a good experience :D.

Let's hear more thoughts from other people, of course.

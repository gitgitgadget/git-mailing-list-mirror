Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0779A93B
	for <git@vger.kernel.org>; Sat, 28 Oct 2023 16:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="SIdywxfK"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4BD7E5
	for <git@vger.kernel.org>; Sat, 28 Oct 2023 09:20:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1698510041;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f1fMfOkO8iVr7HDMbiykkfyvsAggv8XU8D+JpE82nd8=;
	b=SIdywxfKk3RH7As/G2MVUvUnYPVuuP1se1j8StYQz/ahjtVAa0RjJ2viQblDUYej9ohRR8
	qEQGVxJ2njswWeGhYtqJ6ZRbF538riZ0E6wpo90MWjKol9vl/XpJe3k69M6VC5Vm7oydyc
	1ZZzPzpK9mRn/sRix7wEQNOXlyGFt49VTEzc/xExPzcpsy2KiNZtgm6knv/AoWh6q+1rv0
	jCQwI9dzza5qFpwXwZbCAQssHaO3YxikkJaK+fzg2GAGVRON+SwAfVEATTXz9FDBcQqX1r
	vcc+Pv8MeQf3OblEEDHfFvNUrLYRi/B3Y/U1TUFfqfJZazD0g598o5jRRRcMww==
Date: Sat, 28 Oct 2023 18:20:41 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Jacob Stopak <jacob@initialcommit.io>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, Oswald
 Buddenhagen <oswald.buddenhagen@gmx.de>
Subject: Re: [RFC PATCH v2 0/6] Noobify format for status, add, restore
In-Reply-To: <ZT0m68HWZS/tDGtH.jacob@initialcommit.io>
References: <20231020183947.463882-1-jacob@initialcommit.io>
 <20231026224615.675172-1-jacob@initialcommit.io>
 <ca47d328c280e4b4c13bfa6dd9958a57@manjaro.org>
 <ZTvvz6/GFdwagVa+.jacob@initialcommit.io>
 <9b93115810ca269c87ec08f72fdc9c12@manjaro.org>
 <ZTx3fIGpdGl4JpaV.jacob@initialcommit.io>
 <2a0ba4c8e96cb7d2ea66dd1e78cdd39c@manjaro.org>
 <ZT0m68HWZS/tDGtH.jacob@initialcommit.io>
Message-ID: <37e7bd8f6f4b75aa3b31dc98804b1334@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2023-10-28 17:21, Jacob Stopak wrote:
> On Sat, Oct 28, 2023 at 07:55:31AM +0200, Dragan Simic wrote:
>>> Basically what I'm asking is if commands that already have a 
>>> --verbose
>>> flag would just get a config setting that does the existing thing by
>>> default?
>> 
>> Well, not by default.  The default values would remain "false", so 
>> nothing
>> jumps out of nowhere.
> 
> Right, sorry, I worded that poorly.

No worries, just wanted to make sure we're on the same page.

>> Yes, that's what I propose.  It also looks like a logical choice to 
>> me, and
>> it would leave space for some possible later changes to the
>> "<command>.verbose = extended" verbosity, without tying it to the 
>> tables.
>> We'd also leave some space that way for even maybe an additional level 
>> of
>> verbosity, be it "<command>.verbose = simple", "<command>.verbose =
>> graphical" or whatever.
>> 
>> Perhaps this scheme should also support "<command>.verbose = basic", 
>> which
>> would be an alias for "<command>.verbose = true", for additional 
>> clarity.
>> 
> Sounds good!

I'm glad you agree.

>> Perhaps it would also be good to nudge the newbies a bit by requesting 
>> them
>> to enable the extended verbosity for each command by hand.  That way 
>> they
>> would both learn a bit about the way git configuration works, which 
>> they
>> ultimately can't escape from, and they would be excited to learn new 
>> git
>> commands.  Or I at least hope so. :)
>> 
> Hehe ok, maybe there is room in some hints to notify users of the
> extended option...

I agree, there should be a well-placed hint, but we'd need to think 
really well where to place it, so we don't annoy experienced git users 
too much, while we also inform the less experienced users.

>> > Any thoughts on what the section in the config for a more general
>> > setting like this might be named?
>> 
>> Maybe "core.verbose"?  We already have "core.pager", which kind of 
>> affects
>> the way all command outputs look like.
> 
> Ok! The idea of using "core" came to mind but I wasn't sure if that was
> more for lower-level settings or more general things.

I also considered the "core" section to be reserved for the very 
low-level internal things, but having "core.pager" clearly allows other 
appropriate configuration options to be placed here.

> Great. Thanks a lot for all the feedback. Let me doctor up the patch
> series to take these things into account and submit an RFC v3 :D

Sounds good, thank you.  If you agree, I'll go ahead and implement 
support for a few "<command>.verbose" configuration options during the 
next week or so, and submit the patches.  I'll most probably come to 
some more important conclusions while implementing that, which I'll 
relay over, of course.

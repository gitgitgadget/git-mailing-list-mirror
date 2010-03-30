From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: GSoC draft proposal: Line-level history browser
Date: Tue, 30 Mar 2010 11:07:23 +0200
Message-ID: <4BB1BF4B.2060604@drmicha.warpmail.net>
References: <41f08ee11003200218u59c45b6dl82a8eb56cc289256@mail.gmail.com>	 <201003282120.40536.trast@student.ethz.ch>	 <41f08ee11003282114m34aa0f61w536b996dce6cecab@mail.gmail.com>	 <201003292042.01549.trast@student.ethz.ch> <41f08ee11003291952r467601b1o970ce3be802d8521@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Thomas Rast <trast@student.ethz.ch>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	git@vger.kernel.org, Jens Lehmann <Jens.Lehmann@web.de>
To: Bo Yang <struggleyb.nku@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 30 11:10:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NwXSt-000454-Du
	for gcvg-git-2@lo.gmane.org; Tue, 30 Mar 2010 11:10:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756018Ab0C3JKR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Mar 2010 05:10:17 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:40948 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756006Ab0C3JKP (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 30 Mar 2010 05:10:15 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id D5788EA554;
	Tue, 30 Mar 2010 05:10:13 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Tue, 30 Mar 2010 05:10:13 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=6UkBj8EE3HzeroTZYu8tCEgSfkA=; b=nFv97blD7008MS3doxogUBeV0js2rb4Hyfzk2toQA/fmv2ffpJH0+dmSvkYkEbRoCutIDEbDaoBDD6K2Akl93ON3X4n51YOI3YAzIZyqmvCemOsvo/YaQWZBQGlUA7kF3gyYzUH2lhYKmVcFt6slEk/2ca7o3EXZRbCr6jOV7B0=
X-Sasl-enc: a9DetC1DjvpgeZxUlSsPjzVwdG29YGQd8NsqFajF8o+Q 1269940213
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id BC67749C1C3;
	Tue, 30 Mar 2010 05:10:12 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.10pre) Gecko/20100319 Lightning/1.0b2pre Shredder/3.0.5pre
In-Reply-To: <41f08ee11003291952r467601b1o970ce3be802d8521@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143558>

Bo Yang venit, vidit, dixit 30.03.2010 04:52:
> Hi Thomas,
> 
> On Tue, Mar 30, 2010 at 2:42 AM, Thomas Rast <trast@student.ethz.ch> wrote:
>>
>> Is this really the right use-case?  AFAICT the answer to the implied
>> question is given by simply running 'git blame -M 93fc05e:pretty.c'.
>>
>> (Coming up with a better example should be easy; the way I currently
>> think of the feature means that it will mostly replace git-blame for
>> me...)
> 
> I will cite the same example below in the scenario. :)
> 
>> I would, by far, prefer the latter.  So far 'git log' has always been
>> noninteractive, and there's no really good way to make it interactive
>> because it also goes through the pager.  (In the case of blame this is
>> solved in 'git gui blame', which might also be a reasonable approach.)
>>
>> OTOH, if you can really fake a history walk, then just about any
>> log-oriented tool should be able to work with it.  You'd get graphical
>> output for free with gitk and git log --graph.  I haven't really
>> thought through the ramifications, though.
> 
> Ok, so let us try to abandon the interactive way totally.
> 
>>> =====Work and technical issues=====
>>> ==Scenario==
>>> For how we use the line level browser and how the utility should act
>>> to us, here is an scenario:
>>> http://article.gmane.org/gmane.comp.version-control.git/143024/match=line+level+history+browser
>>> It contains code movement between files but not code copy and fuzzy matching.
>>
>> I would prefer if you could inline a short example, perhaps starting
>> at your second diff snippet.  Examples are good ;-)
>>
>> Even if not, please drop the /match= parameter since it is very
>> distracting.
> 
> I put the example at the end of the proposal as a reference.
> 
>>
>>> 7. Reuse 'git log' existing options as many as possible.
>>
>> One thing that IMO is missing from this list, is a plumbing mode that
>> just feeds the raw data to a (presumed) frontend.  It could be as
>> simple as supporting
>>
>>  git log -L ... --pretty=raw --raw
>>
>> or similar, if this provides sufficient information.  Compare 'git
>> blame --porcelain'.
> 
> Very good feedback, I will add this, thanks a lot!
> 
>>
>> This section is too handwavy for my taste.  I think in most cases you
>> say "we can" when you really mean "git-blame already does it, so we
>> can just use a similar algorithm".  Which is fine, but I'd rather see
>> it spelled out so as to see what is not already covered by blame's code.
> 
> Changed in next version to make this clear. But only add some words to
> state that 'blame does similar' :)
> 
>>
>> Push the code somewhere public as you go, even between feature
>> completions.  Post RFCs once you have workable features so people can
>> comment.  Generally try to be visible.
>>
>> Bonus points if you can think of something visible to do during the
>> period where you look at code,
> 
> Yeah, really is a good point. And I have tried to play around on
> github.com and try to set up a http://github.com/byang/my_git for this
> purpose. :)

You may want to create your repo as a fork of gitster/git instead.
That's easier on github, they have a hard time anyways these days ;)
Seriously, it helps making use of their network feature etc.

I don't have anything to add to your proposal (I like it), but I'll be
at NKU next week (Conference @ Chern Institute) so drop me a PM if you wish.

Cheers,
Michael

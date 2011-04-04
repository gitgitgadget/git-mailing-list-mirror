From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [RFC/PATCH] Make "git notes add" more user-friendly when there
 are existing notes
Date: Mon, 04 Apr 2011 14:54:57 +0200
Message-ID: <4D99BFA1.6090701@drmicha.warpmail.net>
References: <09668994f10284cfa5243789a627dce8c2325bc6.1301388217.git.git@drmicha.warpmail.net>	<201103300202.55973.johan@herland.net>	<4D92D399.4090404@drmicha.warpmail.net>	<201103301159.55573.johan@herland.net> <BANLkTi=PHq=VVuh24S5-QZDXkdW4XVWWQA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johan Herland <johan@herland.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Lasse Makholm <lasse.makholm@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 04 14:58:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q6jMe-0002YI-1J
	for gcvg-git-2@lo.gmane.org; Mon, 04 Apr 2011 14:58:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751924Ab1DDM6b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Apr 2011 08:58:31 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:52551 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750885Ab1DDM6b (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Apr 2011 08:58:31 -0400
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id F24F7207C8;
	Mon,  4 Apr 2011 08:58:29 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Mon, 04 Apr 2011 08:58:30 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=3M4C+6X/e0v0MMRI2ZdaliLnR1E=; b=MjO0Ql4ZK61bUxqA1p9c0niSZJreN+qwo+jxu7wzVfgMKtgeddyH96/g6AXSrrz88pWAB/sk1/QPSZ/MFs2/EdBFTMp7sFGng99mb1CZYZkzfw+s10wMnKdUvygsSY6EVYYELkJMqQOTDFtGeDXe7jgLLgJu1bIvKHhWWNH3Mwk=
X-Sasl-enc: nCVQP0wYj2B8DV7/BH4NHxMTxcHIzgXERXXxrbXd7Wqb 1301921909
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 272024008BA;
	Mon,  4 Apr 2011 08:58:29 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.15) Gecko/20110305 Remi/fc14 Lightning/1.0b3pre Thunderbird/3.1.9
In-Reply-To: <BANLkTi=PHq=VVuh24S5-QZDXkdW4XVWWQA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170810>

Lasse Makholm venit, vidit, dixit 04.04.2011 13:35:
> On 30 March 2011 11:59, Johan Herland <johan@herland.net> wrote:
>>> * options vs. arguments:
>>>
>>> "tag", "branch" etc. use options for subcommands, e.g. "tag -d", "branch
>>> -d" etc. "remote", "stash" use arguments, e.g. "remote add", "stash
>>> list". I don't see us unifying that, but we should decide about a
>>> direction to go for "new" commands and stick to that. I feel that
>>> options are the way to go. What I really feel strongly about is that we
>>> should decide once and then stick to that for future commands (and may
>>> be gradually revamping).
>>
>> This is a big discussion, and I don't really have a strong opinion either
>> way (or on whether unification of options vs. arguments is really necessary
>> at all). In general, I like separating the "verb" of the command (_what_ to
>> do) from the "adverbs" (_how_ to do it). For some git commands, the verb is
>> right there in the name (e.g. "checkout", "add", "rm", etc.), so the options
>> are usually all "adverbs". Other commands, however, refer to one of git's
>> "subsystems" (for some very vague definition of "subsystem") as a "noun"
>> (e.g. "stash", "remote", "notes"), and the verb needs to be specified
>> (either as a subcommand, or as an option). In those cases, I personally
>> prefer the subcommand approach ("git noun verb --adverb") better than the
>> option approach ("git noun --verb --adverb"), so as to separate the verb
>> from the adverbs.
>>
>> However, some commands (e.g. "branch", "tag") are _both_ "verbs" ("I want to
>> tag something") and "nouns" ("I want to add a tag"). By now, I'm thoroughly
>> used to "branch -d" and "tag -d", so e.g. "branch rm" and "tag rm" look a
>> bit foreign to me, although they probably follow the above principle more
>> closely...
> 
> Think of it less as the (only) verb and more of it as a domain. In the
> domain of a git remote, (add|rm|rename|...) is the action (verb) and
> that's why it is and should be a sub-command.
> 
> git remote and git stash do it right in my opinion. The default action
> differs (list vs. create) but that's OK because so does the most
> common use case.
> 
> The canonical way to create a stash is to say "git stash create" but
> we allow you to simply say "git stash" because that's probably what
> you want. It seems then, that the canonical way to create a commit
> would be by saying "git commit create" (again, allowing the "git
> commit" shortcut).
> 
> We could even expand on the heresy and argue that git log should be an
> alias for "git commit list"... :-)
> 
> My fingers type git branch -d foo by habit as well, but were it to
> change, I'd get over it and form new habits. We shouldn't let the
> force of mere habits prevent us from doing The Right Thing.
> 
> You could argue that git branch -d is broken because -d is, in fact,
> not an option at all. If it was, you would be able to say git branch
> -d junk feature master to delete junk and branch out feature from
> master. But you can't because -d really is a sub-command in disguise.
> 
>> Then you have weird cases that further complicate things: "rebase" is
>> usually a verb, but in "rebase --continue" or "rebase --abort" another verb
>> takes the focus, and I would probably prefer them as subcommands ("rebase
>> continue" and "rebase abort").
> 
> Absolutely, yes. I don't see this as a weird case at all. In my view,
> this is clearly broken just as git branch -d is. Again, in the domain
> of a rebase, abort and continue are clearly commands and should loose
> the dashes.
> 
>> What can I say? Habits are hard to break, and this might be a case where
>> breaking them is more harmful than a somewhat messy command-line interface.
> 
> As someone, standing on the edge of a 1000+ developer deployment of
> git, the option-vs-sub-command issue is one of the many things
> currently keeping me up at night. I would take a break in habits any
> day to avoid a lifetime of pain teaching people to remember and accept
> these inconsistencies...
> 

Well, I would like say that we should take this up as a long running
task then. The problem is, though, disambiguating things like "git
branch list" if we were to go for subcommands as arguments (not
options). I have no idea how to solve this (without having a complete
switch-over day).

Michael

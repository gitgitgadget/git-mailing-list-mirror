From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: RFC - "git editlog" feature for fixing up local commit messages
Date: Tue, 30 Mar 2010 10:52:42 +0200
Message-ID: <4BB1BBDA.2050102@drmicha.warpmail.net>
References: <20100329133132.GA12201@thyrsus.com> <32541b131003291314r2f5a77e8g28e79b5983821e41@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: esr@thyrsus.com, git@vger.kernel.org
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 30 10:55:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NwXEa-0006k2-V7
	for gcvg-git-2@lo.gmane.org; Tue, 30 Mar 2010 10:55:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752290Ab0C3Ize (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Mar 2010 04:55:34 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:42908 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751088Ab0C3Izd (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 30 Mar 2010 04:55:33 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 22410EA51E;
	Tue, 30 Mar 2010 04:55:33 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Tue, 30 Mar 2010 04:55:33 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=zbhUH4vPR3uzzuWR6f6VKmPloNE=; b=uHYuzwXAWIeH24JquH0bk7xb/1WoLzShDdCsKslbfakSmitTGWf3IbTGxE6A4C5VT950/MKRNlLGxpwC6y7iLX/HLjaMdFyVzOGFvLkM+scZXnGrUoLTQPNZ0bIAlCJk6+c63J4otEwfBPiGgUEXXim9RkND6sU+8nC1XAA8+GY=
X-Sasl-enc: ZwMxA2oP0jwqRhm5V3tvV3sVBUGgz1FZNRrcNIXruFly 1269939332
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 6BFC927A94;
	Tue, 30 Mar 2010 04:55:32 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.10pre) Gecko/20100319 Lightning/1.0b2pre Shredder/3.0.5pre
In-Reply-To: <32541b131003291314r2f5a77e8g28e79b5983821e41@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143556>

Avery Pennarun venit, vidit, dixit 29.03.2010 22:14:
> On Mon, Mar 29, 2010 at 9:31 AM, Eric Raymond <esr@thyrsus.com> wrote:
>> My editcomment script, as it exists, has a technical problem...the
>> editor needs to be something like emacsclient that actually invokes in
>> a different X window, otherwise whatever it writes to stdout will end
>> up stuffed in the comment along with the text I actually wanted to put
>> there.  The underlying problem is that git-filter-branch is sort of a
>> nuclear-powered chainsaw - gets the job done, but in a way that is
>> prone to messy side effects.  A more elegant implementation would
>> probably need to tie deeper into the plumbing.
> 
> It ought to be easy to work around this; simply extract the log
> message *before* filter-branch using something like
> 
>        git cat-file commit HEAD | tail -n +6 >msg.tmp
> 
> (I'm sure someone will correct me by providing a less revolting way to
> extract the commit message, but it's somehow not coming to me right
> now.)
> 
> Then launch $EDITOR to edit the message, then inside the
> filter-branch, just use that file instead of launching the editor.
> 
> Alternatively, in case you want the option of editing *multiple*
> commit messages at once, you could just redirect stdin/stdout to
> /dev/tty.
> 
> A further option would be to extend git-rebase--interactive.sh (yes,
> it's just a shell script) to take an option that makes a given commit
> (or commits) 'reword' by default instead of 'pick'.  And maybe another
> option to make git-rebase--interactive.sh not actually pop up an
> editor before it starts running.  Then your editcommit script could
> just be a thin wrapper around rebase with those options.

I think the OP's point was that filter-branch is better at keeping
merges in place; I'm not sure if this is true when rebase-i is used with
reword only.

> <insert obligatory wistful reference to git-sequencer> (I don't
> actually know anything about git-sequencer.)

Oh yeah:)

Michael

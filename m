From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: git rebase -i
Date: Fri, 20 Feb 2009 12:02:17 +0100
Message-ID: <499E8DB9.5030505@drmicha.warpmail.net>
References: <43d8ce650902190121v2e18aac1rfaa64a4ce6e799a3@mail.gmail.com>	 <76718490902191255w24b30bd8jacaed8aa919d6526@mail.gmail.com>	 <7vzlgij7cb.fsf@gitster.siamese.dyndns.org> <76718490902191626u2202ed38xf63111b6a2758206@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	John Tapsell <johnflux@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 20 12:03:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LaTAi-0001Dw-Bd
	for gcvg-git-2@gmane.org; Fri, 20 Feb 2009 12:03:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751781AbZBTLC1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Feb 2009 06:02:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751483AbZBTLC1
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Feb 2009 06:02:27 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:54398 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751320AbZBTLC0 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Feb 2009 06:02:26 -0500
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by out1.messagingengine.com (Postfix) with ESMTP id 6A9BD2A26BC;
	Fri, 20 Feb 2009 06:02:25 -0500 (EST)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Fri, 20 Feb 2009 06:02:25 -0500
X-Sasl-enc: d9k628g+MQCUxqQ0u3FCr7T07GmkYT1EGZ/0vvfrhnFd 1235127744
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 70E97E8DC;
	Fri, 20 Feb 2009 06:02:24 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1b3pre) Gecko/20090219 Lightning/1.0pre Shredder/3.0b3pre
In-Reply-To: <76718490902191626u2202ed38xf63111b6a2758206@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110836>

Jay Soffian venit, vidit, dixit 20.02.2009 01:26:
> On Thu, Feb 19, 2009 at 7:11 PM, Junio C Hamano <gitster@pobox.com> wrote:
> 
>>> $ git rebase -i -10
>>> $ git rebase -i -n -10
>> The syntax would certainly imply a different semantics from giving
>> HEAD~10.  How would you compute the set of commits to rebase sanely when
>> you have merges after your 10th direct parent commit?
> 
> I didn't mean to suggest that -10 and HEAD~10 are the same thing.
> 
> I would expect -10 to act the same when given to rebase as it does
> when given to format-patch. In both cases, you are asking the command
> for a set of commits.
> 
> But as I said, I don't exactly know what -10 means to format-patch if
> there are merge commits because I've never tried to use it in such a
> context.
> 
> j.

I guess it means exactly what

git rev-list -10 HEAD

means. And that would also be the easy way to implement it.

BUT: The fact that it's not obvious what "-10" is in non-linear
situations is the reason why it's probably not a good idea for r-b-i. If
you want to rebase you need a clear picture of the revision graph. If
you have one you know where to rebase from, and how to say so using
HEAD~5 and such. If you don't have one then using an option like -10
could be dangerous. And in a linear situation, -10 is equivalent to
HEAD~10 (+-1 ...).

Michael

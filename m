From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] log: respect log.shownotes variable
Date: Thu, 08 Apr 2010 10:01:46 +0800
Message-ID: <4BBD390A.1030906@drmicha.warpmail.net>
References: <20100407204536.GA32382@coredump.intra.peff.net> <7vljczapzt.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Thomas Rast <trast@student.ethz.ch>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 08 04:02:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nzh4C-0008IT-Ec
	for gcvg-git-2@lo.gmane.org; Thu, 08 Apr 2010 04:02:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758309Ab0DHCBz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Apr 2010 22:01:55 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:57822 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758254Ab0DHCBz (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Apr 2010 22:01:55 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 6D71EEA1CF;
	Wed,  7 Apr 2010 22:01:54 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Wed, 07 Apr 2010 22:01:54 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=cEQ2hhvYpygntf5JjWrJpqtmoTk=; b=DELS5jkn1PfKkHXz4iNO8uPz8lOqKBpdUVgqsiXGQXnB4VYYQOnuO81vTX+Qq6/QNxtc8/n5oDKUrcincVhtfJkRPS6bs5yEHMG4qYyqvRZVR1MFaT22EnGDnE5E6JwPAlVfRrhyzxV3ZZzCzvs4Oo67m6dPtUAqRzI5jr/W5zs=
X-Sasl-enc: DBpzEiKbJYyOYkxFxZlTasOMl3L52+7vNlLRzOr9+9fN 1270692113
Received: from localhost.localdomain (unknown [202.113.236.7])
	by mail.messagingengine.com (Postfix) with ESMTPSA id C85E54A8A4E;
	Wed,  7 Apr 2010 22:01:51 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.10pre) Gecko/20100319 Lightning/1.0b2pre Shredder/3.0.5pre
In-Reply-To: <7vljczapzt.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144303>

Junio C Hamano venit, vidit, dixit 08.04.2010 05:53:
> Jeff King <peff@peff.net> writes:
> 
>> I guess an alternate solution would be for me to store them in some
>> other ref, and then use --show-notes=email when I do want to see them
>> (instead of just --show-notes, as I would do with this patch). But I
>> still wonder if log.shownotes is a sensible addition, just for the sake
>> of completeness.
> 
> My gut feeling is that people who do have notes in the default namespace
> (or the ones in notes.displayRef) do want to see them _all the time_.
> Otherwise they'd put such notes in namespaces that are not shown by
> default, and view them on demand, no?
> 
> But then there is a bigger question: what kind of notes would you want to
> always see as part of "git log" output?  My answer to that question for my
> personal workflow (both dayjob and here) so far has been "none", and that
> is exactly the reason why my "applied from this message" notes live in
> notes/am namespace and I have nothing in the default notes namespace.
> 
> If the answer is "none" for everybody, we should disable showing notes in
> any command unless the user explicitly asks with either the --show-notes
> command line option or the notes.displayRef and perhaps log.shownotes
> configuration variables.

Personally, I like showing "personal" notes to patches by default. They
often end up being the comments after the "---" in patch e-mails. All
other notes (such as TR's) I keep in separate name spaces.

But I don't mind setting a(nother) config variable for that ;)

BTW: I used to keep external notes in
refs/remotes/remotename/notes/notestree but since a while ago the notes
code insists on refs/notes/. In some sense it is similar to tags, where
you need to set up special refspecs if you want to have the remote
tags/notes but don't want to mix them (and possibly have them conflict)
with your own. But I don't know a good strategy for making this more
user friendly.

Michael

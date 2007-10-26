From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Make rebase smarter
Date: Fri, 26 Oct 2007 16:29:18 -0700
Message-ID: <7vtzodv4j5.fsf@gitster.siamese.dyndns.org>
References: <1193328386.4522.352.camel@cacharro.xalalinux.org>
	<1193373682-3608-1-git-send-email-stevenrwalter@gmail.com>
	<7vk5p9wpwd.fsf@gitster.siamese.dyndns.org>
	<Pine.LNX.4.64.0710270013030.4362@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steven Walter <stevenrwalter@gmail.com>, git@vger.kernel.org,
	federico@novell.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Oct 27 01:29:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IlYcV-0001DR-7n
	for gcvg-git-2@gmane.org; Sat, 27 Oct 2007 01:29:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751926AbXJZX30 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Oct 2007 19:29:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752152AbXJZX30
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Oct 2007 19:29:26 -0400
Received: from rune.pobox.com ([208.210.124.79]:54833 "EHLO rune.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751581AbXJZX3Z (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Oct 2007 19:29:25 -0400
Received: from rune (localhost [127.0.0.1])
	by rune.pobox.com (Postfix) with ESMTP id CA32B150B29;
	Fri, 26 Oct 2007 19:29:46 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 032F7150B15;
	Fri, 26 Oct 2007 19:29:41 -0400 (EDT)
In-Reply-To: <Pine.LNX.4.64.0710270013030.4362@racer.site> (Johannes
	Schindelin's message of "Sat, 27 Oct 2007 00:13:56 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62454>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Fri, 26 Oct 2007, Junio C Hamano wrote:
>
>> Steven Walter <stevenrwalter@gmail.com> writes:
>> 
>> > It is a common workflow to run "git fetch; git rebase origin/<foo>" 
>> > Where foo is the remote tracking branch.  git-rebase should default to 
>> > using the remote tracking branch if no other ref is given.
>> 
>> This would be a reasonable choice between refusing outright and
>> picking one possible action.
>
> Another sensible choice would be "git rebase FETCH_HEAD", at least just 
> after a "git fetch <nick> <branch>"...

We can get the best of both worlds by noticing a line in
FETCH_HEAD without not-for-merge marker and use that as the
'onto' commit for the rebase.

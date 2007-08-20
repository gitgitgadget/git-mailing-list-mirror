From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Document what the stage numbers in the :$n:path syntax mean.
Date: Sun, 19 Aug 2007 23:20:53 -0700
Message-ID: <7v4piuafqy.fsf@gitster.siamese.dyndns.org>
References: <7v1we5bvbw.fsf@assigned-by-dhcp.cox.net>
	<20070814231422.GA10662@pe.Belkin>
	<7vps1paceh.fsf@assigned-by-dhcp.cox.net>
	<46C90C46.1030000@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Chris Shoemaker <c.shoemaker@cox.net>, git@vger.kernel.org,
	Alex Riesen <raa.lkml@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Steven Grimm <koreth@midwinter.com>
X-From: git-owner@vger.kernel.org Mon Aug 20 08:21:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IN0dS-0008Bk-9i
	for gcvg-git@gmane.org; Mon, 20 Aug 2007 08:21:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751282AbXHTGVF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 20 Aug 2007 02:21:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751249AbXHTGVE
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Aug 2007 02:21:04 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:54040 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750727AbXHTGVD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2007 02:21:03 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id A3DA3120AEE;
	Mon, 20 Aug 2007 02:21:17 -0400 (EDT)
In-Reply-To: <46C90C46.1030000@midwinter.com> (Steven Grimm's message of "Mon,
	20 Aug 2007 11:36:38 +0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56175>

Steven Grimm <koreth@midwinter.com> writes:

> Junio C Hamano wrote:
>> People should learn this command.  Really.
>>
>>       $ git cat-file -p :$n:path
>>
>> where $n == 2 is ours, $n == 1 is common ancestor, and $n == 3
>> is theirs.
>
> The git-rev-parse manpage talks about the :$n:path notation (buried deep in
> a list of other syntax) but it just says $n is a "stage number" -- someone
> who is not familiar with the internals of git's merge implementation is
> never going to be able to figure out that "1", "2", and "3" mean what Junio
> said.

The patch makes sense.  Thanks.

Just to give historical background to new readers, this is
primarily because the really core level of the plumbing started
as not caring between stages 2 and 3 (iow, as far as the merge
is concerned, both heads are equal), and the description in the
manual was written back then.

These days, all the merge strategies and other non-merge
programs such as "git am" that can record conflicts as
multi-stage index entries consistently use stage #2 as our
version, and stages #2 and #3 are not equals anymore.

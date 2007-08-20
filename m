From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Document what the stage numbers in the :$n:path syntax mean.
Date: Mon, 20 Aug 2007 12:55:36 -0700
Message-ID: <7vy7g6rnev.fsf@gitster.siamese.dyndns.org>
References: <7v1we5bvbw.fsf@assigned-by-dhcp.cox.net>
	<20070814231422.GA10662@pe.Belkin>
	<7vps1paceh.fsf@assigned-by-dhcp.cox.net>
	<46C90C46.1030000@midwinter.com>
	<7v4piuafqy.fsf@gitster.siamese.dyndns.org>
	<20070820180809.GA8542@efreet.light.src>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steven Grimm <koreth@midwinter.com>,
	Chris Shoemaker <c.shoemaker@cox.net>, git@vger.kernel.org,
	Alex Riesen <raa.lkml@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Jan Hudec <bulb@ucw.cz>
X-From: git-owner@vger.kernel.org Mon Aug 20 21:55:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1INDLq-0002SU-2l
	for gcvg-git@gmane.org; Mon, 20 Aug 2007 21:55:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761136AbXHTTzr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 20 Aug 2007 15:55:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755768AbXHTTzr
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Aug 2007 15:55:47 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:37116 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756828AbXHTTzq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2007 15:55:46 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 4714D1250CD;
	Mon, 20 Aug 2007 15:56:00 -0400 (EDT)
In-Reply-To: <20070820180809.GA8542@efreet.light.src> (Jan Hudec's message of
	"Mon, 20 Aug 2007 20:08:09 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56246>

Jan Hudec <bulb@ucw.cz> writes:

>> These days, all the merge strategies and other non-merge
>> programs such as "git am" that can record conflicts as
>> multi-stage index entries consistently use stage #2 as our
>> version, and stages #2 and #3 are not equals anymore.
>
> Pardon me? In what are they not equal?

The version left in the worktree always corresponds to stage #2.
There is no way to say "please use stage #2 for their version
and use stage #3 for our version" (that is not necessary, so
don't take this as if I am complaining about a lack of feature).
"git-read-tree -m" knows that stage #2 corresopnds to the index
and the worktree and performs up-to-date check on them to make
sure you do not lose local changes.

Merge parent order does not matter --- they are more equal than
stages between #2 and #3.  But that's not what we are discussing
here.

In some minor corners merge parents are not exactly equal --
history simplification and other places that wants to pick one
parent iterates from the first to the last parent and pick the
first one, so strictly speaking earlier parents have a slight
edge over later ones.

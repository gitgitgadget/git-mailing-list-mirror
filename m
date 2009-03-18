From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Ability to edit message from git rebase --interactive.
Date: Wed, 18 Mar 2009 10:54:13 +0100
Message-ID: <49C0C4C5.5070802@drmicha.warpmail.net>
References: <200903171953.23650.ogoffart@kde.org>	 <alpine.DEB.1.00.0903172329480.10279@pacific.mpi-cbg.de>	 <20090318004056.GB25454@coredump.intra.peff.net>	 <7vsklbod0l.fsf@gitster.siamese.dyndns.org> <fabb9a1e0903172242v6f67aa9er40fe0ae2a2db7bc3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Olivier Goffart <ogoffart@kde.org>, git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 18 10:56:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjsVE-0004Iz-LA
	for gcvg-git-2@gmane.org; Wed, 18 Mar 2009 10:56:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754499AbZCRJyb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Mar 2009 05:54:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754476AbZCRJyb
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Mar 2009 05:54:31 -0400
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:54831 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753637AbZCRJya (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Mar 2009 05:54:30 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 30A742F4E09;
	Wed, 18 Mar 2009 05:54:28 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Wed, 18 Mar 2009 05:54:28 -0400
X-Sasl-enc: a+f9CoXlHtsCflMMo1aJmJlM05V9ZYBKT0Y/ze+mB6f8 1237370067
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 0F4A91E50E;
	Wed, 18 Mar 2009 05:54:26 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1b4pre) Gecko/20090317 Lightning/1.0pre Shredder/3.0b3pre
In-Reply-To: <fabb9a1e0903172242v6f67aa9er40fe0ae2a2db7bc3@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113603>

Sverre Rabbelier venit, vidit, dixit 18.03.2009 06:42:
> Heya,
> 
> On Wed, Mar 18, 2009 at 02:06, Junio C Hamano <gitster@pobox.com> wrote:
>> Jeff King <peff@peff.net> writes:
>> I am not quite sure what rephrase is buying us.  Do we also want to
>> introduce retree that allows you to muck with the tree object recorded
>> without giving you a chance to clobber the commit log message?
> 
> Is that a common operation? Rephrase is, at least to me...
> 

Rephrase for sure is common, and for sure can be done currently... It's
only that "commit --amend, save&quit, continue" could be shortened.

OTOH: Most commonly one would want to rephrase a commit message or two
without actually rebasing anything. And the proposed change doesn't help
as much as it could, in two respects:

1) I want to be able to say "rephrase HEAD~2" without having to edit a
rebase action script. (That would be useful for rewriting a single
commit as well, and could be added easily.)

2) Currently, all rebasing operations have trouble with merges. But if
all I want to do is rephrasing a log message then no diff/apply is
necessary, no rewriting of trees, no change in the DAG structure (i.e.
connectivity; sha1s change, of course). So there should be a special
mode for DAG-preserving rewrites, where one can be sure that merges are
fully preserved.

2) seems to be the most important point to make rephrasing safe and
convenient.

Michael

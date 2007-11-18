From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: Re: [RFC] Alternates and broken repos: A pack and prune scheme to avoid them
Date: Sun, 18 Nov 2007 21:01:53 +0100
Message-ID: <200711182101.53936.johannes.sixt@telecom.at>
References: <200711181225.52288.johannes.sixt@telecom.at> <7v3av3wg7h.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 18 21:02:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ItqLk-00028G-7P
	for gcvg-git-2@gmane.org; Sun, 18 Nov 2007 21:02:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752147AbXKRUB6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Nov 2007 15:01:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752083AbXKRUB6
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Nov 2007 15:01:58 -0500
Received: from smtp4.srv.eunet.at ([193.154.160.226]:49818 "EHLO
	smtp4.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752060AbXKRUB5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Nov 2007 15:01:57 -0500
Received: from dx.sixt.local (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp4.srv.eunet.at (Postfix) with ESMTP id 1360497BBA;
	Sun, 18 Nov 2007 21:01:55 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 9D93F58496;
	Sun, 18 Nov 2007 21:01:55 +0100 (CET)
User-Agent: KMail/1.9.3
In-Reply-To: <7v3av3wg7h.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65387>

On Sunday 18 November 2007 19:39, Junio C Hamano wrote:
> Johannes Sixt <johannes.sixt@telecom.at> writes:
> > Then the strategy of garbage collection can be arranged in the following
> > way:
> >
> > - Repack by starting at the "most complete" repo and work towards the
> > "most borrowing" ones. During this phase "attic" packs are created.
> > Borrowing repos get a chance to salvage objects before the alternates
> > prune them away.
> >
> > - Prune by starting at the "most borrowing" repo and work towards the
> > "most complete" ones. During this phase the "attic" packs are cleaned up.
> >
> > What do you think? Is this a way for a solution?
>
> I would imagine that would work as long as it can be controlled
> when all the involved repositories are repacked and pruned, such
> as on repo.or.cz case (but on the other hand it is not really
> controlled well there and that is the reason you wrote the
> message X-<).

Well, I think in many situations pack and prune can be controlled. To be 
precise, if alternates are used pack and prune *must* be controlled. 
Currently, the control is very simple: "don't prune" (and I don't recall ATM 
what you must not do when you repack).

Anyway, judging from the responses so far it seems that people can live 
with "don't prune" (or not using alternates) ;-) Repositories getting broken 
this way isn't exactly my itch, either, so... I spelled out a possible 
solution if someone wants to pick up the topic.

-- Hannes

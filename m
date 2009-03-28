From: Junio C Hamano <gitster@pobox.com>
Subject: Re: On git 1.6 (novice's opinion)
Date: Fri, 27 Mar 2009 18:30:36 -0700
Message-ID: <7veiwi5t8j.fsf@gitster.siamese.dyndns.org>
References: <49CC8C90.12268.242CEFCE@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Ulrich Windl" <ulrich.windl@rz.uni-regensburg.de>
X-From: git-owner@vger.kernel.org Sat Mar 28 02:32:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LnNPo-0006Xf-Vu
	for gcvg-git-2@gmane.org; Sat, 28 Mar 2009 02:32:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752890AbZC1Bap (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Mar 2009 21:30:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752401AbZC1Bap
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Mar 2009 21:30:45 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:58398 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751204AbZC1Bao (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Mar 2009 21:30:44 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 10D2DA555F;
	Fri, 27 Mar 2009 21:30:42 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 0B8CEA555E; Fri,
 27 Mar 2009 21:30:38 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 0D26C218-1B38-11DE-A058-32B0EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114929>

"Ulrich Windl" <ulrich.windl@rz.uni-regensburg.de> writes:

> ... Also some seemingly dangerous commands that cannot easily be undone
> should ask safety questions ("cvs merge (-j)" would also fall into that
> category.

This is slightly an interesting point.

In CVS and Subversion, "merge" (rather "update") can be a dangerous
operation.  You start working, you keep building, and you eventually
accumulate quite a lot of changes but you still cannot see the end of the
tunnel.  Your changes are incomplete and you will upset others if you
commit.  Your changes are extensive enough that it can conflict heavily
with what others have done already, and there is a high chance that you
can screw up the merging but there is no easy way (unless you tar-up the
whole work tree before attempting to update) to get back to the state
before your merge.  Damned if you commit, damned if you don't.  You lose
either way.

This is because you cannot have a local commit.  The problem is inherent
to the centralized nature of these systems.

Distributed systems are different.  Unlike CVS/Subversion's

	work work work; then

        update to merge, risk screwing up the work in progress (or almost
	finished work); then

        commit

workflow, in a distributed system, you first commit and then merge,
preferably from a clean slate.  You will not have to worry about screwing
up the conflict resolution, because both states (what the other guy did,
and what you did) are committed safely away and you can reset back to the
state before you start your merge.

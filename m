From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [FIXED PATCH] Make rebase save ORIG_HEAD if changing current
 branch
Date: Sun, 06 Jul 2008 22:24:39 -0700
Message-ID: <7vwsjy8dwo.fsf@gitster.siamese.dyndns.org>
References: <1215379370-34265-1-git-send-email-benji@silverinsanity.com>
 <7v7iby9ucx.fsf@gitster.siamese.dyndns.org>
 <803A3528-2451-4C5D-A48D-5E0C37B8E90E@silverinsanity.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Brian Gernhardt <benji@silverinsanity.com>
X-From: git-owner@vger.kernel.org Mon Jul 07 07:26:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KFjEr-00053e-PV
	for gcvg-git-2@gmane.org; Mon, 07 Jul 2008 07:26:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751066AbYGGFYy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jul 2008 01:24:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751088AbYGGFYy
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Jul 2008 01:24:54 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:38531 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750922AbYGGFYx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jul 2008 01:24:53 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id B1E0225EE8;
	Mon,  7 Jul 2008 01:24:50 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 0FDF925EE7; Mon,  7 Jul 2008 01:24:47 -0400 (EDT)
In-Reply-To: <803A3528-2451-4C5D-A48D-5E0C37B8E90E@silverinsanity.com> (Brian
 Gernhardt's message of "Mon, 7 Jul 2008 01:16:06 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 05C1CF40-4BE5-11DD-825E-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87578>

Brian Gernhardt <benji@silverinsanity.com> writes:

> On Jul 7, 2008, at 12:43 AM, Junio C Hamano wrote:
>
>> Having said that, thanks to updates to git-rebase,
>> rebased_branch@{1} has
>> useful information these days, so I do not see much practical
>> upside, even
>> though I _will_ apply this patch, just for the sake of consistency.
>
> I've been running rebase a lot over the last few days, and my
> impression was that git-rebase adds an entry to ther eflog for each
> patch it runs over.  While this has its uses, it makes HEAD@{1} not
> terribly useful after a "pull --rebase".

Actually, I was not talking about HEAD@{1}.  Check the reflog of the
branch you rebased, i.e.

	$ git checkout bg/rebase
        $ git rebase master
        $ git diff bg/rebase@{1} bg/rebase

If you have two patches in bg/rebase, HEAD@{2} will be the updated master,
HEAD@{1} will be the first patch on top of it, and HEAD will be the
rebased tip.  bg/rebase@{1} on the other hand is the tip of bg/rebase
before you started rebasing (i.e. the result of "git checkout bg/rebase"
above).

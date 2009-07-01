From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] request-pull: do not paginate output of git commands
Date: Wed, 01 Jul 2009 13:16:45 -0700
Message-ID: <7vy6r8f9aq.fsf@alter.siamese.dyndns.org>
References: <1246361606-20457-1-git-send-email-mmarek@suse.cz>
	<7vtz1x7f05.fsf@alter.siamese.dyndns.org>
	<20090701094029.GA22508@sepie.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Michal Marek <mmarek@suse.cz>
X-From: git-owner@vger.kernel.org Wed Jul 01 22:17:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MM6F0-0004KP-BR
	for gcvg-git-2@gmane.org; Wed, 01 Jul 2009 22:17:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751554AbZGAUQo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jul 2009 16:16:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751225AbZGAUQo
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Jul 2009 16:16:44 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:48201 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751326AbZGAUQn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jul 2009 16:16:43 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090701201645.RZGQ25927.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Wed, 1 Jul 2009 16:16:45 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo01.cox.net with bizsmtp
	id AkGl1c00C4aMwMQ03kGlxq; Wed, 01 Jul 2009 16:16:46 -0400
X-VR-Score: -100.00
X-Authority-Analysis: v=1.0 c=1 a=hoH3GwZHzGIA:10 a=yvBS0kstd_Qq12r5lscA:9
 a=u-W5c-3tW6iwiO-xsRWBm4ewM5sA:4
X-CM-Score: 0.00
In-Reply-To: <20090701094029.GA22508@sepie.suse.cz> (Michal Marek's message of "Wed\, 1 Jul 2009 11\:40\:30 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122598>

Michal Marek <mmarek@suse.cz> writes:

> Good idea, but for completeness, it should be set before this command:
>     git log --max-count=1 --pretty='format:warn:   %h: %s' $headrev >&2
> (which should use tformat to get the newline right). So what about this
> one?

Good eyes.

The blamed commit for that new use of "log" is ff06c74 (Improve
request-pull to handle non-rebased branches, 2007-05-01) itself, which did
introduce the "define an empty PAGER to disable paging" trick, so this
makes it doubly buggy (i.e. for forgetting GIT_PAGER trumps PAGER, and for
introducing a use of log that is not covered by its own trick).

Thanks.

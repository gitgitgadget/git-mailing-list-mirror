From: "Stephen R. van den Berg" <srb@cuci.nl>
Subject: Re: [PATCH] be paranoid about closed stdin/stdout/stderr
Date: Wed, 27 Aug 2008 01:10:38 +0200
Message-ID: <20080826231038.GA24323@cuci.nl>
References: <48B29C52.8040901@gnu.org> <E1KXawS-0001gg-Ty@fencepost.gnu.org> <48B2AFC2.20901@viscovery.net> <7vbpzgb94q.fsf@gitster.siamese.dyndns.org> <E1KXsL9-0004ef-Co@fencepost.gnu.org> <48B3A948.3080800@viscovery.net> <7vsksrad7o.fsf@gitster.siamese.dyndns.org> <48B44C61.2020206@gnu.org> <7vabez2yac.fsf@gitster.siamese.dyndns.org> <7v3akr2xa3.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paolo Bonzini <bonzini@gnu.org>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Karl Chen <quarl@cs.berkeley.edu>,
	Git mailing list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 27 01:11:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KY7hT-0004vA-Tx
	for gcvg-git-2@gmane.org; Wed, 27 Aug 2008 01:11:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751616AbYHZXKk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Aug 2008 19:10:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750990AbYHZXKk
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Aug 2008 19:10:40 -0400
Received: from aristoteles.cuci.nl ([212.125.128.18]:37882 "EHLO
	aristoteles.cuci.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750778AbYHZXKk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Aug 2008 19:10:40 -0400
Received: by aristoteles.cuci.nl (Postfix, from userid 500)
	id B734D5465; Wed, 27 Aug 2008 01:10:38 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7v3akr2xa3.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93832>

Junio C Hamano wrote:
>Junio C Hamano <gitster@pobox.com> writes:
>I think
>	$ git fetch 0<&-
>from the command line is a mere user stupidity.

>On the other hand, if a cron/at job that contains "git fetch" is launched
>in an environment with fd#0 (or #1 or #2 for that matter) closed, it would
>certainly be problematic.  It can easily be worked around by redirecting
>file descriptors appropriately in the script that is launched, though.

A sane cron environment always has proper 0, 1 and 2 descriptors.
This basically goes with rule #2: if your cron doesn't have 0, 1 and 2
open, you have big problems already, so camouflaging those problems
is not going to help the user.

>On a related note, we should make sure that we run our hooks with the set
>of low file descriptors opened sensibly.  It would be a bug if we are
>running them in a weird environment and forcing them to do funky
>redirection themselves.  I think we are already Ok in this regard, but I
>didn't check.

Agreed, but this is the responsibility of anyone launching other
processes (cleanup, then launch).
-- 
Sincerely,
           Stephen R. van den Berg.

"Good moaning!"

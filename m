From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] add --porcelain option to git-push
Date: Thu, 25 Jun 2009 12:07:08 -0700
Message-ID: <7vtz249lpf.fsf@alter.siamese.dyndns.org>
References: <20090622214032.GC19364@coredump.intra.peff.net>
	<20090623011001.GA15352@cthulhu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Larry D'Anna <larry@elder-gods.org>
X-From: git-owner@vger.kernel.org Thu Jun 25 21:07:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MJuI2-0003li-CJ
	for gcvg-git-2@gmane.org; Thu, 25 Jun 2009 21:07:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753172AbZFYTHI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Jun 2009 15:07:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753145AbZFYTHH
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Jun 2009 15:07:07 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:59014 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751663AbZFYTHG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jun 2009 15:07:06 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090625190709.WRUJ20430.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Thu, 25 Jun 2009 15:07:09 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo02.cox.net with bizsmtp
	id 8K781c00A4aMwMQ04K78Qc; Thu, 25 Jun 2009 15:07:08 -0400
X-VR-Score: -100.00
X-Authority-Analysis: v=1.0 c=1 a=thBImqoGNukA:10 a=YnUW0e-6AAAA:8
 a=LN53ul0Pyf0m7ezVysYA:9 a=djis5m8Y6dQ9rnGVRYE7Cun6ensA:4 a=SBuGkJxYsgkA:10
X-CM-Score: 0.00
In-Reply-To: <20090623011001.GA15352@cthulhu> (Larry D'Anna's message of "Mon\, 22 Jun 2009 21\:10\:01 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122236>

Larry D'Anna <larry@elder-gods.org> writes:

> If --porcelain is used git-push will produce machine-readable output.  The
> output status line for each ref will be tab-separated and sent to stdout instead
> of stderr.  The full symbolic names of the refs will be given.  For example
>
> $ git push --dry-run --porcelain master :foobar 2>/dev/null \
>   | perl -pe 's/\t/ TAB /g'
>
> = TAB refs/heads/master:refs/heads/master TAB [up to date]
> - TAB :refs/heads/foobar TAB [deleted]
> ---

Thanks.  Sign-off?

On a tangent, this reminds me of something that I often find myself
wanting to do.  Currently I do:

	$ git push --dry-run
           A..B master -> master
        $ git log --oneline A..B ;# cut and paste A..B from the output
	$ git push

to achieve what I want; get an overview of what I'd be pushing as the
final sanity check before running the actual push.

I've been wondering if it would be a good idea to teach -v (or some other
option) to do this automatically.  That is,

	$ git push [--dry-run] [--summary[=<n>]]

would give the output from "git log --oneline [-n <n>] A..B".

No, I am not suggesting you to fold such an unrelated feature to your
patch at all.

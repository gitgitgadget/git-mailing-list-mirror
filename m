From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] format-patch let -k override a config-specified format.numbered
Date: Sat, 09 May 2009 00:08:16 -0700
Message-ID: <7vbpq2da8v.fsf@alter.siamese.dyndns.org>
References: <8763gcri2c.fsf@meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>,
	"Stephen C. Tweedie" <sct@redhat.com>
To: Jim Meyering <meyering@redhat.com>
X-From: git-owner@vger.kernel.org Sat May 09 09:08:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M2gfb-0008Kp-U5
	for gcvg-git-2@gmane.org; Sat, 09 May 2009 09:08:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753936AbZEIHIS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 May 2009 03:08:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752274AbZEIHIR
	(ORCPT <rfc822;git-outgoing>); Sat, 9 May 2009 03:08:17 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:47347 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751670AbZEIHIQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 May 2009 03:08:16 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090509070817.XCPQ17670.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Sat, 9 May 2009 03:08:17 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo01.cox.net with bizsmtp
	id pK8G1b0034aMwMQ03K8GqM; Sat, 09 May 2009 03:08:16 -0400
X-Authority-Analysis: v=1.0 c=1 a=X7vzqmh8HacA:10 a=ELu1uixjCFwA:10
 a=20KFwNOVAAAA:8 a=5AeRPH9oXEQ0CQk3U3oA:9 a=aLIHcAE9_KqpvGJp7zoA:7
 a=bvNgxO1BDnwYqaE_KxsSIWA70EoA:4 a=jEp0ucaQiEUA:10
X-CM-Score: 0.00
In-Reply-To: <8763gcri2c.fsf@meyering.net> (Jim Meyering's message of "Thu\, 07 May 2009 18\:31\:07 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118650>

Jim Meyering <meyering@redhat.com> writes:

> Let a command-line --keep-subject (-k) override a config-specified
> format.numbered (--numbered (-n)), rather than provoking the
> "-n and -k are mutually exclusive" failure.
> * t4021-format-patch-numbered.sh: Test for the above
> ---

Sign-off?

> Here's a quick demo of the problem:
>
>   $ git config format.numbered true
>   $ git format-patch --stdout -1 -k > /dev/null
>   fatal: -n and -k are mutually exclusive.
>
> This started when a colleague reported that "git rebase master" was failing
> with a "fatal: -n and -k are mutually exclusive".  Stephen Tweedie discovered
> that it was due to the format.numbered=true setting in ~/.gitconfig
> conflicting with the -k of the format-patch command run as part of
> the rebase operation.  Here's a fix.
>
> Stephen suggested an alternate patch in which rather than adding a
> new variable, you'd use "numbered = -1" to indicate that the setting
> originated in config.  Let me know if you'd prefer that.

Some people might find an extra variable redundant or verbose, but I think
your approach is easier to follow and to the point, especially with the
in-code comment.

Thanks.

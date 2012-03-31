From: Neil Horman <nhorman@tuxdriver.com>
Subject: Re: [PATCH 3/4] git-commit-am: Allow automatic rebasing to preserve
 empty commits
Date: Sat, 31 Mar 2012 09:01:17 -0400
Message-ID: <20120331130116.GC2409@neilslaptop.think-freely.org>
References: <1333136922-12872-1-git-send-email-nhorman@tuxdriver.com>
 <1333136922-12872-4-git-send-email-nhorman@tuxdriver.com>
 <7vd37tlsve.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Phil Hord <phil.hord@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 31 15:01:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SDxvq-0000PB-Qx
	for gcvg-git-2@plane.gmane.org; Sat, 31 Mar 2012 15:01:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754805Ab2CaNBX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Mar 2012 09:01:23 -0400
Received: from charlotte.tuxdriver.com ([70.61.120.58]:42811 "EHLO
	smtp.tuxdriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752708Ab2CaNBV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Mar 2012 09:01:21 -0400
Received: from neilslaptop.think-freely.org ([2001:470:8:a08:4a5d:60ff:fe96:79da] helo=localhost)
	by smtp.tuxdriver.com with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.63)
	(envelope-from <nhorman@tuxdriver.com>)
	id 1SDxvi-0005jO-1X; Sat, 31 Mar 2012 09:01:19 -0400
Content-Disposition: inline
In-Reply-To: <7vd37tlsve.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Score: -2.9 (--)
X-Spam-Status: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194451>

On Fri, Mar 30, 2012 at 01:46:13PM -0700, Junio C Hamano wrote:
> Neil Horman <nhorman@tuxdriver.com> writes:
> 
> > Using the keep_empy environment variable, this change allows git-commit-am to
> 
> Is it an environment variable?  I thought not.
> 
Sorry, I use the term loosely.  keep_empty is the script variable I use to track
the keep-empty option.  I can fix up the commit message on my repost.

> > +	# makes this easy
> > +	git cherry-pick --keep-empty "$revisions" && move_to_original_branch
> > +else
> > +	git format-patch -k --stdout --full-index --ignore-if-in-upstream \
> > +		--src-prefix=a/ --dst-prefix=b/ \
> > +		--no-renames $root_flag "$revisions" |
> > +	git am $git_am_opt --rebasing --resolvemsg="$resolvemsg" &&
> > +	move_to_original_branch
> > +fi
> 
> Factor out the "&& move_to_original_branch" at the end of then/else, like
> this:
> 
> 	if ...
>         then
> 		...
>         else
> 		...
>         fi && move_to_original_branch
> 
Will do, thanks!
Neil

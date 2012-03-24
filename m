From: Neil Horman <nhorman@tuxdriver.com>
Subject: Re: odd behavior with git-rebase
Date: Sat, 24 Mar 2012 12:55:36 -0400
Message-ID: <20120324165536.GA17932@neilslaptop.think-freely.org>
References: <20120323185205.GA11916@hmsreliant.think-freely.org>
 <7vvclvrrad.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 24 17:55:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SBUFs-0000hr-OH
	for gcvg-git-2@plane.gmane.org; Sat, 24 Mar 2012 17:55:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755375Ab2CXQzr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Mar 2012 12:55:47 -0400
Received: from charlotte.tuxdriver.com ([70.61.120.58]:48557 "EHLO
	smtp.tuxdriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755317Ab2CXQzq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Mar 2012 12:55:46 -0400
Received: from neilslaptop.think-freely.org ([2001:470:8:a08:4a5d:60ff:fe96:79da] helo=localhost)
	by smtp.tuxdriver.com with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.63)
	(envelope-from <nhorman@tuxdriver.com>)
	id 1SBUFg-0000cq-5J; Sat, 24 Mar 2012 12:55:42 -0400
Content-Disposition: inline
In-Reply-To: <7vvclvrrad.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Score: -2.9 (--)
X-Spam-Status: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193833>

On Fri, Mar 23, 2012 at 01:33:30PM -0700, Junio C Hamano wrote:
> Neil Horman <nhorman@tuxdriver.com> writes:
> 
> > I know that git cherry-pick allows for picking of empty commits, and it appears
> > the rebase script uses cherry-picking significantly, so I'm not sure why this
> > isn't working, or if its explicitly prevented from working for some reason.
> 
> The primary purpose of "rebase" is (or at least was when it was conceived)
> to clean up the existing history, and a part of the cleaning up is not to
I can understand that, although IMHO it seems equally usefull as a tool for
simply doing what its name implies, moving a history to a new starting point,
e.g. to plainly rebase it.  Thats the use that I have for it anyway.

> replay a patch that ends up being empty.  Even though we try to omit an
> already applied patch by using "git cherry" internally when choosing which
> commits to replay, a commit that by itself is *not* empty could end up
> being empty when a similar change has already been made to the updated
> base, and we do want to omit them.
> 
Is there a way to differentiate a commit that is made empty as the result of a
previous patch in the rebase, and a commit that is simply empty?

> A commit that is empty (i.e. --allow-empty) by itself was a much later
> invention than the basic rebase logic, and the rebase may want to be
> updated to special case it, but as the default behaviour it is doing the
> right thing by not letting an empty commit into the cleaned up history.
I agree, I think perhaps adding an --allow-empty option to the rebase logic, so
that empty commits (or perhaps just initially empty, as opposed to commits made
empty) would be very beneficial.  

Thanks all, I'll start trying to pick through the rebase logic this week.

Best
Neil

> 
> 
> 

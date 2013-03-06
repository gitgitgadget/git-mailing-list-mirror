From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: Merging submodules - best merge-base
Date: Wed, 6 Mar 2013 19:12:05 +0100
Message-ID: <20130306181156.GA4114@sandbox-ub>
References: <op.ws2l3rgnrbppqq@cicero.linkoping.osa>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jens Lehmann <jens.lehmann@web.de>
To: Daniel Bratell <bratell@opera.com>
X-From: git-owner@vger.kernel.org Wed Mar 06 19:12:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UDIpQ-0007as-CY
	for gcvg-git-2@plane.gmane.org; Wed, 06 Mar 2013 19:12:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753454Ab3CFSMK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Mar 2013 13:12:10 -0500
Received: from smtprelay04.ispgateway.de ([80.67.18.16]:47727 "EHLO
	smtprelay04.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751225Ab3CFSMJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Mar 2013 13:12:09 -0500
Received: from [77.21.76.82] (helo=localhost)
	by smtprelay04.ispgateway.de with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1UDIov-0005jg-Qn; Wed, 06 Mar 2013 19:12:05 +0100
Content-Disposition: inline
In-Reply-To: <op.ws2l3rgnrbppqq@cicero.linkoping.osa>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217534>

On Mon, Feb 25, 2013 at 05:44:05PM +0100, Daniel Bratell wrote:
> I can phrase this in two ways and I'll start with the short way:
> 
> Why does a merge of a git submodule use as merge-base the commit that was  
> active in the merge-base of the parent repo, rather than the merge-base of  
> the two commits that are being merged?
> 
> The long question is:
> 
> A submodule change can be merged, but only if the merge is a  
> "fast-forward" which I think is a fair demand, but currently it checks if  
> it's a fast-forward from a commit that might not be very interesting  
> anymore.
> 
> If two branches A and B split at a point when they used submodule commit  
> S1 (based on S), and both then switched to S2 (also based on S) and B then  
> switched to S21, then it's today not possible to merge B into A, despite  
> S21 being a descendant of S2 and you get a conflict and this warning:
> 
> warning: Failed to merge submodule S (commits don't follow merge-base)
> 
> (attempt at ASCII gfx:
> 
> Submodule tree:
> 
> S ---- S1
>    \
>     \ - S2 -- S21
> 
> Main tree:
> 
> A' (uses S1) --- A (uses S2)
>    \
>     \ --- B' (uses S2) -- B (uses S21)
> 
> 
> I would like it to end up as:
> 
> A' (uses S1) --- A (uses S2) ------------ A+ (uses S21)
>    \                                     /
>     \ --- B' (uses S2) -- B (uses S21)- /
> 
> And that should be legal since S21 is a descendant of S2.

So to summarize what you are requesting: You want a submodule merge be
two way in the view of the superproject and calculate the merge base
in the submodule from the two commits that are going to be merged?

It currently sounds logical but I have to think about it further and
whether that might break other use cases.

Cheers Heiko

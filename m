From: Toby Corkindale <toby.corkindale@rea-group.com>
Subject: Re: .git/info/attributes not cloned
Date: Thu, 27 Mar 2008 15:23:27 +1100
Organization: REA Group
Message-ID: <47EB213F.1020503@rea-group.com>
References: <47EB0FAE.5000102@rea-group.com> <20080327033341.GB5417@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 27 05:16:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JejXD-0008EE-Eu
	for gcvg-git-2@gmane.org; Thu, 27 Mar 2008 05:16:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750846AbYC0EPe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Mar 2008 00:15:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750840AbYC0EPe
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Mar 2008 00:15:34 -0400
Received: from mel-nat68.realestate.com.au ([210.50.192.68]:53831 "EHLO
	mel-nat68.realestate.com.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1749667AbYC0EPd (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Mar 2008 00:15:33 -0400
Received: from [192.168.53.6] ([192.168.53.6]) by mel-nat68.realestate.com.au with Microsoft SMTPSVC(6.0.3790.1830);
	 Thu, 27 Mar 2008 15:15:07 +1100
User-Agent: Thunderbird 2.0.0.12 (X11/20080227)
In-Reply-To: <20080327033341.GB5417@coredump.intra.peff.net>
X-OriginalArrivalTime: 27 Mar 2008 04:15:07.0318 (UTC) FILETIME=[23DC9D60:01C88FC1]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78328>

Jeff King wrote:
> On Thu, Mar 27, 2008 at 02:08:30PM +1100, Toby Corkindale wrote:
> 
>> If one creates a .git/info/attributes file in a Git repo, it will not be  
>> present in cloned repos.
>> I don't know if this is a bug or not, but it /seems/ wrong behaviour to  
>> me, and reading from the manual pages.
> 
> It is not a bug. The .gitattributes file in your working directory _is_
> cloned, and that is the right place to put things that you want to be
> revision-controlled and used in every repo. The .git/info/attributes
> file is for attributes that are purely local to that repo. This is
> similar to the split between .git/info/exclude and .gitignore.

Ah, OK.
I was hoping not to use .gitattributes, as then the attributes are 
ignored when doing something like:
git archive --remote=example.com:/path/to/repo release/v2.1 | tar xf -

> Can you point out which part of the manual gave the wrong impression (or
> better yet, submit a patch making it more clear)?

Now that you've mentioned the difference between info/exclude and 
.gitignore, I see that in the docs/user-manual.html it is said:

"If you wish the exclude patterns to affect only certain repositories 
(instead of every repository for a given project), you may instead put 
them in a file in your repository named .git/info/exclude, or in any 
file specified by the core.excludesfile configuration variable."

That gives a clue that the /info/ files are repo-specific.
However in gitignore(5) and gitattributes(5), there is no explanation of 
this - it simply mentions that the info version is a higher priority 
than the .git{ignore,attributes} version.

I suggest that the individual docs/man-pages should mention that too.
I'll submit a patch in a separate email, as long as I'm not still 
misunderstanding the mechanism.

Is there a recommended way to make attributes apply to commands run on a 
remote repository, or is that a different bug?

thanks,
Toby

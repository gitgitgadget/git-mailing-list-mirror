From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: Migrating from SVN
Date: Thu, 25 Mar 2010 07:22:14 +0100
Message-ID: <20100325062214.GA1829@book.hvoigt.net>
References: <aosj77-m7e.ln1@burns.bruehl.pontohonk.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Christoph Bartoschek <bartoschek@gmx.de>
X-From: git-owner@vger.kernel.org Thu Mar 25 07:22:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NugSV-0008QH-DF
	for gcvg-git-2@lo.gmane.org; Thu, 25 Mar 2010 07:22:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752645Ab0CYGWR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Mar 2010 02:22:17 -0400
Received: from darksea.de ([83.133.111.250]:48016 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751840Ab0CYGWQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Mar 2010 02:22:16 -0400
Received: (qmail 32532 invoked from network); 25 Mar 2010 07:22:14 +0100
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 25 Mar 2010 07:22:14 +0100
Content-Disposition: inline
In-Reply-To: <aosj77-m7e.ln1@burns.bruehl.pontohonk.de>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143166>

On Mon, Mar 22, 2010 at 11:18:18AM +0100, Christoph Bartoschek wrote:
> Now we are merging both products into one such that the structure should be 
> 
> product/project_A
>         project_B
>         project_C
>         project_D
>         project_E
> 
> I think this makes migration to Git easier as we can now work with only one 
> Git repository. We also circumvent the usage of the unmature submodule 
> support in Git.
> 
> How can I now import our Subversion projects into the Git repository such 
> that for each project the history is kept and ideally the whole history is 
> linearized by the subversion revision numbers?

Import them all seperately into git (e.g. using git svn) and then have a
look at subtree merge

http://www.kernel.org/pub/software/scm/git/docs/howto/using-merge-subtree.html

to merge them all together. That way you will have seperate lines of
history for each project and one (or five) big merges on top.

AFAIK the revision number from svn is stored in the commit message if
you use git svn so to add the project name you might want to use git
filter-branch to add that name to each commit before merging the history
lines.

That way you will have all the history of the now seperate projects in
one git repository. Keep in mind that after doing that its not that easy
to make them seperate projects again.

Hope that helps.

cheers Heiko

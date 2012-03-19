From: Peter Krefting <peter@softwolves.pp.se>
Subject: Re: Please discuss: what "git push" should do when you do not say
 what to push?
Date: Mon, 19 Mar 2012 10:07:10 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <alpine.DEB.2.00.1203190945560.15290@ds9.cixit.se>
References: <7v7gyjersg.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Mar 19 10:07:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S9YZ8-0004mj-Td
	for gcvg-git-2@plane.gmane.org; Mon, 19 Mar 2012 10:07:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758563Ab2CSJHS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Mar 2012 05:07:18 -0400
Received: from upper-gw.cixit.se ([92.43.32.133]:39984 "EHLO mail.cixit.se"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754726Ab2CSJHR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Mar 2012 05:07:17 -0400
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by mail.cixit.se (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id q2J97Bbm020201
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 19 Mar 2012 10:07:11 +0100
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.14.3/8.14.3/Submit) with ESMTP id q2J97AAB020197;
	Mon, 19 Mar 2012 10:07:10 +0100
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
In-Reply-To: <7v7gyjersg.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender is SPF-compliant, not delayed by milter-greylist-3.0 (mail.cixit.se [127.0.0.1]); Mon, 19 Mar 2012 10:07:11 +0100 (CET)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193418>

At $dayjob, our setup instructions for Git do say that everyone setting up a 
new machine shall run "git config --global push.default tracking". This is 
what suits our workflow where people work on a topic branch, which they will 
push to and pull from our central repository (each topic branch is owned by 
a team of one or more developers). By using "tracking", they can just do a

   git push

and not have to worry about other half-finished or local changes "pollute" 
the One True Central Repository<tm>. We have found that this configuration 
makes it easier to explain the workflow, especially since it more or less 
does make "push" the opposite of "pull" (both of them just updating one 
"real" branch on either side).

We also have cases where we work on different repositories, with different 
codebases; we have an upstream codebase that is merged into one or more 
downstream codebases, and sometimes we have branches that are used with more 
than one codebase (pull branch A from upstream repo, merge with downstream 
repo and work with it there). Or we work on cross-codebase maintainence 
(transplant fix on branch A from codebase B to codebase C). We have 
installed hooks on our repositories that try to make sure history does 
not get pushed to the wrong repository -- as could sometimes happen if 
you had a branch checked out locally from the another codebase and forgot 
to configure your push.default.


I have also personally found that this is the setting that I do feel most 
comfortable with in more or less every other context where I work with Git, 
so I do think this would be a fairly useful default value.


I know the policy in Git is to not allow the remote repository dictate 
anything about the configuration in the local repository, but as an 
alternative to changing the "push.default" value, perhaps we should allow 
setting some configuration option on the remote repository that blocks it 
from being the target of a "push.default = matching" push?

-- 
\\// Peter - http://www.softwolves.pp.se/

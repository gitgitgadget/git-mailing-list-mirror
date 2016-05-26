From: Jordan DE GEA <jordan.de-gea@grenoble-inp.org>
Subject: [RFC] Triangular Workflow: user friendly full implementation
Date: Thu, 26 May 2016 12:06:33 +0200
Message-ID: <E83A9439-54C8-4925-8EE3-6AEEDD9416F3@grenoble-inp.org>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Matthieu Moy <matthieu.moy@grenoble-inp.fr>,
	Erwan Mathoniere <erwan.mathoniere@grenoble-inp.org>,
	Tom Russello <tom.russello@grenoble-inp.org>,
	Samuel Groot <samuel.groot@grenoble-inp.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 26 12:13:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b5sIf-0001r5-Es
	for gcvg-git-2@plane.gmane.org; Thu, 26 May 2016 12:13:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751545AbcEZKNx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 May 2016 06:13:53 -0400
Received: from zm-smtpout-2.grenet.fr ([130.190.244.98]:44284 "EHLO
	zm-smtpout-2.grenet.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750791AbcEZKNx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2016 06:13:53 -0400
X-Greylist: delayed 434 seconds by postgrey-1.27 at vger.kernel.org; Thu, 26 May 2016 06:13:52 EDT
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 8C3B920F5;
	Thu, 26 May 2016 12:06:34 +0200 (CEST)
Received: from zm-smtpout-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CvoX1SI3xhBB; Thu, 26 May 2016 12:06:34 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr (zm-smtpauth-2.grenet.fr [130.190.244.123])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 73D7D20F0;
	Thu, 26 May 2016 12:06:34 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTP id 6D9682077;
	Thu, 26 May 2016 12:06:34 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpauth-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bFpgN5-axuwd; Thu, 26 May 2016 12:06:34 +0200 (CEST)
Received: from eduroam-032217.grenet.fr (eduroam-032217.grenet.fr [130.190.32.217])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTPSA id 49D792055;
	Thu, 26 May 2016 12:06:34 +0200 (CEST)
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295642>

We are working on full implementation of triangular workflow feature.
For now, the main options available are: 
	 - branch.<name>.pushRemote
	 - remote.pushDefault
And only setable by hands. 

As it can be difficult to understand, here is what we want to do. 


Context:
	- One main remote repository, e.g. git/git.
	- A remote fork (e.g. a GitHub fork) of git/git, e.g. me/git.
	- A local clone of me/git on the machine

Purposes:
	- the local branch master has to fetch to git/git by default
	- the local branch master has to push to me/git by default

Configuration wanted:
	- Add a remote to git/git e.g. `git remote add ...`
	- Set the fetch remote for branch as default. 

For now, we can do that by setting: 
	- branch.<name>.remote to git/git
	- branch.<name>.pushRemote to me/git
But many options set `branch.<name>.remote`, a suitable solution is to
implement an option for the fetch for example. 


Here is what we want to implement: 

1. 
	a. add the config var: remote.fetchDefault
	b. add the config var: branch.<name>.fetchRemote
	c. add `git fetch --set-default` in order to set remote.fetchDefault
	d. add `git fetch --set-remote` in order to set branch.<name>.fetchRemote
	e. add `git pull --set-default` in order to set remote.fetchDefault
	f. add `git pull --set-remote` in order to set branch.<name>.fetchRemote

2. 
	a. add `git push --set-default` in order to set remote.pushDefault
	b. add `git push --set-remote` in order to set branch.<name>.pushRemote


What's your opinion about this feature ?

From: Jordan DE GEA <jordan.de-gea@grenoble-inp.org>
Subject: [RFC] Triangular Workflow UI improvement
Date: Mon, 30 May 2016 10:39:22 +0200
Message-ID: <C4CF51FB-73AB-4500-895A-928582632BDC@grenoble-inp.org>
References: <E83A9439-54C8-4925-8EE3-6AEEDD9416F3@grenoble-inp.org>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Matthieu Moy <matthieu.moy@grenoble-inp.fr>,
	Erwan Mathoniere <erwan.mathoniere@grenoble-inp.org>,
	Tom Russello <tom.russello@grenoble-inp.org>,
	Samuel Groot <samuel.groot@grenoble-inp.org>, peff@peff.net,
	artagnon@gmail.com, Junio C Hamano <gitster@pobox.com>,
	philipoakley@iee.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 30 10:39:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b7IjT-0007yU-6f
	for gcvg-git-2@plane.gmane.org; Mon, 30 May 2016 10:39:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754186AbcE3Ij1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 May 2016 04:39:27 -0400
Received: from zm-smtpout-2.grenet.fr ([130.190.244.98]:51728 "EHLO
	zm-smtpout-2.grenet.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754035AbcE3Ij1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 May 2016 04:39:27 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 703D620AA;
	Mon, 30 May 2016 10:39:23 +0200 (CEST)
Received: from zm-smtpout-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MNlE9kF63H6M; Mon, 30 May 2016 10:39:23 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr (zm-smtpauth-2.grenet.fr [130.190.244.123])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 56ABD20A5;
	Mon, 30 May 2016 10:39:23 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTP id 4F4A42077;
	Mon, 30 May 2016 10:39:23 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpauth-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eme-DdlEVF4a; Mon, 30 May 2016 10:39:23 +0200 (CEST)
Received: from eduroam-032091.grenet.fr (eduroam-032091.grenet.fr [130.190.32.91])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTPSA id 17A3B2066;
	Mon, 30 May 2016 10:39:23 +0200 (CEST)
In-Reply-To: <E83A9439-54C8-4925-8EE3-6AEEDD9416F3@grenoble-inp.org>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295870>

In my last message, I forgot to add some important 
contributors linked to this feature. Some of you 
already replied to me. 
I will answer shortly. Sorry for the noise. 

> 
> We are working on full implementation of triangular workflow feature.
> For now, the main options available are: 
> 	 - branch.<name>.pushRemote
> 	 - remote.pushDefault
> And only setable by hands. 
> 
> As it can be difficult to understand, here is what we want to do. 
> 
> 
> Context:
> 	- One main remote repository, e.g. git/git.
> 	- A remote fork (e.g. a GitHub fork) of git/git, e.g. me/git.
> 	- A local clone of me/git on the machine
> 
> Purposes:
> 	- the local branch master has to fetch to git/git by default
> 	- the local branch master has to push to me/git by default
> 
> Configuration wanted:
> 	- Add a remote to git/git e.g. `git remote add ...`
> 	- Set the fetch remote for branch as default. 
> 
> For now, we can do that by setting: 
> 	- branch.<name>.remote to git/git
> 	- branch.<name>.pushRemote to me/git
> But many options set `branch.<name>.remote`, a suitable solution is to
> implement an option for the fetch for example. 
> 
> 
> Here is what we want to implement: 
> 
> 1. 
> 	a. add the config var: remote.fetchDefault
> 	b. add the config var: branch.<name>.fetchRemote
> 	c. add `git fetch --set-default` in order to set remote.fetchDefault
> 	d. add `git fetch --set-remote` in order to set branch.<name>.fetchRemote
> 	e. add `git pull --set-default` in order to set remote.fetchDefault
> 	f. add `git pull --set-remote` in order to set branch.<name>.fetchRemote
> 
> 2. 
> 	a. add `git push --set-default` in order to set remote.pushDefault
> 	b. add `git push --set-remote` in order to set branch.<name>.pushRemote
> 
> 
> What's your opinion about this feature ?

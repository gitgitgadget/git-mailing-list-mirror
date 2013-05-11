From: John Keeping <john@keeping.me.uk>
Subject: Re: Cannot push anything via export transport helper after push
 fails.
Date: Sat, 11 May 2013 13:36:26 +0100
Message-ID: <20130511123626.GD2299@serenity.lan>
References: <20130511162936.0354e5d7@opensuse.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>
To: Andrey Borzenkov <arvidjaar@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 11 14:36:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ub92j-0005B8-AR
	for gcvg-git-2@plane.gmane.org; Sat, 11 May 2013 14:36:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751945Ab3EKMgf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 May 2013 08:36:35 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:56184 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751280Ab3EKMgf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 May 2013 08:36:35 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 8123DCDA5BE;
	Sat, 11 May 2013 13:36:34 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -2.9
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_00=-1.9] autolearn=ham
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LywSSsia7+GT; Sat, 11 May 2013 13:36:33 +0100 (BST)
Received: from pichi.aluminati.org (pichi.aluminati.org [10.0.16.50])
	by jackal.aluminati.org (Postfix) with ESMTP id D0418CDA5A9;
	Sat, 11 May 2013 13:36:33 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id C53D9161E410;
	Sat, 11 May 2013 13:36:33 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at aluminati.org
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6Vl9ZnG3uIDI; Sat, 11 May 2013 13:36:33 +0100 (BST)
Received: from serenity.lan (mink.aluminati.org [10.0.7.180])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id 291B3161E3B6;
	Sat, 11 May 2013 13:36:28 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <20130511162936.0354e5d7@opensuse.site>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223963>

On Sat, May 11, 2013 at 04:29:36PM +0400, Andrey Borzenkov wrote:
> I noticed that using git-remote-bzr, but as far as I can tell this is
> generic for all transport helpers using fast-export.
> 
> 
> 
> What happened was "git push" failed due to merge conflict. So far so
> good - but from now on git assumes everything is up to date.
> 
> bor@opensuse:/tmp/test/git> git push origin master
> To bzr::bzr+ssh://bor@localhost/tmp/test/bzr
>  ! [rejected]        master -> master (non-fast-forward)
> error: failed to push some refs to 'bzr::bzr+ssh://bor@localhost/tmp/test/bzr'
> hint: Updates were rejected because the tip of your current branch is behind
> hint: its remote counterpart. Merge the remote changes (e.g. 'git pull')
> hint: before pushing again.
> hint: See the 'Note about fast-forwards' in 'git push --help' for details.
> bor@opensuse:/tmp/test/git> git push origin master
> Everything up-to-date
> bor@opensuse:/tmp/test/git> 
> 
> The problem seems to be that git fast-export updates marks
> unconditionally, whether export actually applied or not. So next time
> it assumes everything is already exported and does nothing.
> 
> Is it expected behavior?

What version of Git are you using?

This sounds similar to the regression fixed by commit 126aac5
(transport-helper: fix remote helper namespace regression, 2013-05-10)
but that was only introduced in commit 664059f (transport-helper: update
remote helper namespace, 2013-04-17) which isn't in any released
versions of Git.

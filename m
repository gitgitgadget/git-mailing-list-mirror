From: Thomas Harning <harningt@gmail.com>
Subject: Re: Git workflow
Date: Mon, 10 Mar 2008 21:58:52 -0400
Message-ID: <20080310215852.7f4d7ab5@shiva>
References: <1205152663.3470.12.camel@tigger>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Peter Gordon <peter@pg-consultants.com>
X-From: git-owner@vger.kernel.org Tue Mar 11 03:02:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JYtob-00006L-SX
	for gcvg-git-2@gmane.org; Tue, 11 Mar 2008 03:02:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754179AbYCKCB1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Mar 2008 22:01:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754150AbYCKCB1
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Mar 2008 22:01:27 -0400
Received: from wx-out-0506.google.com ([66.249.82.235]:64286 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754179AbYCKCB0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Mar 2008 22:01:26 -0400
Received: by wx-out-0506.google.com with SMTP id h31so2239388wxd.4
        for <git@vger.kernel.org>; Mon, 10 Mar 2008 19:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        bh=aUifqc7lxJ9zeiKCSF2yg4kvaSMgsGa1cMDL9Mt6W5k=;
        b=vvV8kBrIoTzmgNPoI0Tw4Wdgl+Lw8wcpW29699jlnTf7NdRhU9q86PmHhMEsei62YsI1wFF8JQ/AzjXAskYvfpBAKnXRX8V+Edv6eG5ZAatclEG8KAJ+Exg+nsiS0YjLX7PxzsM4KJt5xow+wgYR9bRiwhyvmIRa/Ac8NmrVdqI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=XGtQciclnydtXYE7Y8Lw1qu02hVynblshP7x54wz0jOTLgZRDkJUlT01HJQEMgLGcBtiyx6oD1qSHR+0rpzDvNPilpI48GsYlewkXyuxRbbQBrsp/OyyokePPJY+4R+phhiFTYDBpSSc05qqD1xdTmdDznLtpNE27oYnz4Y/54Q=
Received: by 10.70.40.3 with SMTP id n3mr6607751wxn.52.1205200885432;
        Mon, 10 Mar 2008 19:01:25 -0700 (PDT)
Received: from shiva ( [69.245.236.18])
        by mx.google.com with ESMTPS id h15sm2071416wxd.23.2008.03.10.19.01.24
        (version=SSLv3 cipher=OTHER);
        Mon, 10 Mar 2008 19:01:24 -0700 (PDT)
In-Reply-To: <1205152663.3470.12.camel@tigger>
X-Mailer: Claws Mail 3.3.0 (GTK+ 2.12.5; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76784>

On Mon, 10 Mar 2008 14:37:43 +0200
Peter Gordon <peter@pg-consultants.com> wrote:

> Hi.
> 
> There are a number of us working on a project. We each have a HEAD,
> and work on branches, using git-checkout -b MyPatch. When we have
> finished working on the branch, we move back to the HEAD, with 
> git-checkout master, do a 
> git-pull
> and then git-cherry-pick sha1.....
> 
> I have two questions. 
> 
> 1) Is this the normal way to work with git.
Since you always work on your own 'branch', you have no need to check
out a new branch to be independent of others.
If you 'do' work on your own branch, the easier way would be to do one
of the following:
a) git pull
b) Separate branches for separation..
  git checkout master
  git pull -- may cause a merge
  git merge <your branch> -- if you worked on your own branch..git pull
c) Get the latest changes and linearize history
  git fetch
  git rebase origin/master

a - Easiest and more sane
	If you want to work on your own branches you can always
	work on that branch and pull updates from the master
b - Might keep workflow simpler and follows your workflow without
cherry-picks
c - Might be good if you create a simple patch and don't care about the
history and haven't published the branch
> 
> 2) Also, we sometimes get a log of 
> Merge branch 'master' of git://sgit/MyProject which has no commits.
> Why does this happen?
git pull performs explicit merges if your repository is not at the
exact same point as another.  Depending on what has happened, there
might be no code changes, but the history is different (perhaps
out-of-order 'cherry-picks')

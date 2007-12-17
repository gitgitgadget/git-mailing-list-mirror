From: "Stephen Sinclair" <radarsat1@gmail.com>
Subject: how to properly update dumb-hosted repo (using rsync..?)
Date: Mon, 17 Dec 2007 18:11:47 -0500
Message-ID: <9b3e2dc20712171511r41e6bd4p64d243747ad4d2af@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 18 00:14:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4P8l-00087v-4V
	for gcvg-git-2@gmane.org; Tue, 18 Dec 2007 00:12:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935239AbXLQXLu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2007 18:11:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932403AbXLQXLu
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Dec 2007 18:11:50 -0500
Received: from rv-out-0910.google.com ([209.85.198.191]:18472 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936302AbXLQXLs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2007 18:11:48 -0500
Received: by rv-out-0910.google.com with SMTP id k20so2042458rvb.1
        for <git@vger.kernel.org>; Mon, 17 Dec 2007 15:11:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=i4MlYZDlnbvxwxRIDyaY2ekAw3m0olB6oFf3AIoWhFw=;
        b=dAhfcFJ8gq4sCgGiTaIYrcSMEtmRwIA9R3MNBQAol4zUCO8f2IsjtFvZkYrzLcpwxYEmsTv0G2nB+HvmB3Sn7ZiMXPV0O8+fcIZptw9Qak3BCLTvz8FlNs1Jj/gB3INV9ATIgQ140Ij4ndqIZ4zKztMW+8RBDlJelHKC2see1Hg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Mufq0uTkOtr7W+wqlKwS4GNLVezO4ggaYhHP+WbuN3sNahCG6jPfkNX5I7PacVRWbWljXcyC9vtY1A03O17YNBVH7VGfwvoH+ATH4Ev6xb1JaAzPxR5hhO1/N18qalJjR76TkMQY1QdzhJ3YchMTxf6RUdchukfy2nKgTy6UqFw=
Received: by 10.140.161.11 with SMTP id j11mr315549rve.134.1197933107620;
        Mon, 17 Dec 2007 15:11:47 -0800 (PST)
Received: by 10.140.188.1 with HTTP; Mon, 17 Dec 2007 15:11:47 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68656>

Hello!

I have a question related to dumb transports (i.e., http hosting without git).

I have a shell-accessible server which on which I have installed git,
but it is not a web server.  So to make my git repo public I have put
the repo on a web server which I cannot install git on.  I have made a
post-update hook on my server repo which runs git-update-server-info
and then uses rsync to copy the repo over to the public web server.
So far so good.  I am able to clone the http-hosted repo and push
changes to my private server which then get copied over to the http
repo.

However, after a git-push/rsync operation, I typed git-pull to try and
pull the changes I'd just made, and got the following:

-------------------
$ git-pull
Warning: No merge candidate found because value of config option
         "branch.master.merge" does not match any remote branch fetched.
No changes.
-------------------

However I haven't done any branching in this cloned repo, it is
immediately after a git-clone from the web server.

My .git/config basically looks like this, minus the "core" section:

-------------------
[remote "origin"]
        url = http://my.server.com/git/project.git
        fetch = +refs/heads/*:refs/remotes/origin/*
[branch "master"]
        remote = origin
        merge = refs/heads/master
-------------------

Which seems fine to me...
Any ideas?
This is of course only for people who want to clone my web-hosted repo
and then be able to subsequently git-pull my updates.

thanks,
Steve

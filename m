From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: Yet another git perforce integration
Date: Tue, 8 May 2007 14:32:53 +0200
Message-ID: <81b0412b0705080532o14db3b24l1a71409af1c443ae@mail.gmail.com>
References: <200705081023.38810.simon@lst.de>
	 <81b0412b0705080247l2385529t61ad4ecd083261c7@mail.gmail.com>
	 <200705081249.36214.simon@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Simon Hausmann" <simon@lst.de>
X-From: git-owner@vger.kernel.org Tue May 08 14:33:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HlOsK-0002RN-8s
	for gcvg-git@gmane.org; Tue, 08 May 2007 14:33:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966620AbXEHMc7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 8 May 2007 08:32:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966723AbXEHMc6
	(ORCPT <rfc822;git-outgoing>); Tue, 8 May 2007 08:32:58 -0400
Received: from an-out-0708.google.com ([209.85.132.242]:13467 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966620AbXEHMc6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 May 2007 08:32:58 -0400
Received: by an-out-0708.google.com with SMTP id d18so226941and
        for <git@vger.kernel.org>; Tue, 08 May 2007 05:32:56 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=WOdblT9cvOakXPvyXseQkbmglQKKsSw9KXIvDPeTr07as3bBPHXszRNPiH8HCSpd96PIxb+Tg51YVmfjPS+PlB92LfEHeY3OSzd6ntS8otONU466UJD1b0Mj/6U46bMVdYh25/McIawVhzCzU2wUkcPBpT9A+yJO+MDMwFQiZMw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=dZx9YMoEPZXWy8+vcc48AFVzhVkimqNS4kbwFGkUYXGm8LmUwpaxkzYzzUoTMk2h0ibVUgNIcr5Nf6mTsVvuuzo1PxOn7czM82BRtX8Uj5cxRNmsorOLivUJ3BisIi5SnXywdq84HeY9W0wU1akXnAWxPSbtFbTfi3hvq5qq6x4=
Received: by 10.100.136.8 with SMTP id j8mr2407832and.1178627573108;
        Tue, 08 May 2007 05:32:53 -0700 (PDT)
Received: by 10.100.202.10 with HTTP; Tue, 8 May 2007 05:32:53 -0700 (PDT)
In-Reply-To: <200705081249.36214.simon@lst.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46571>

On 5/8/07, Simon Hausmann <simon@lst.de> wrote:
> > > It also doesn't require any additional meta-data. Instead every import
> > > commit has a line added to the log message that contains the Perforce
> > > path the changeset comes from as well as the change number. git-p4
> > > sync/rebase "parses" this on the last commit in the "p4" git branch to
> > > find out where to continue importing for incremental imports.
> >
> > How do you handle that patchwork of mappings synced to diverse revisions
> > that P4 clients tend to become? Don't you have to save change number or
> > revision for _each_ file?
>
> I'm not sure I understand the question. I don't really use the p4 client view
> at all. ...

Ah, you're _that_ lucky...

> > > problems with fast-import when trying that. Also the support for Perforce
> > > branches isn't quite working yet.
> >
> > AFACS, it is impossible: Perforce does not have branches (in Git's meaning
> > of the word). It only has directories. Integration (it is something like
> > "in-repo-copy") metadata are just duct-taped on it (that stupid
> > branchspec).
>
> True, it probably depends a bit on the depot organization. For example we have
> //depot/qt/main and then branches like //depot/qt/4.3 or research branches
> like //depot/qt/research/somecoolfeature . That's the kind of structure I'd
> like to map to git, ...

Recreating it anywhere, not just in Git, would be stupid. As it is in Perforce.

> > > Also I've never tried it on Windows and I expect problems as the script
> > > uses pipes, calls "patch", etc.
> >
> > ...and case-sensitivity. BTW, how does your script handle filenames with
> > special characters and spaces in them?
>
> I don't really treat them special. I get the file name from the output of "p4
> describe" (using the Guido option :) and pass it on to git-fast-import.
>

You seem to assume that the names never contain double quotes and
backslashes. For example in the names of directories.

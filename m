From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH 4/4] save another call to git-update-index
Date: Fri, 30 Jun 2006 13:33:31 +0200
Message-ID: <81b0412b0606300433u54b5caa0i47d1ea83079b5898@mail.gmail.com>
References: <20060630002756.GD22618@steel.home>
	 <Pine.LNX.4.63.0606300235300.29667@wbgn013.biozentrum.uni-wuerzburg.de>
	 <81b0412b0606300022k68d13dg8e292d9b768df51c@mail.gmail.com>
	 <Pine.LNX.4.63.0606301155050.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Alex Riesen" <fork0@t-online.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 30 13:34:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FwHGJ-0007Im-VV
	for gcvg-git@gmane.org; Fri, 30 Jun 2006 13:34:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751745AbWF3Ldp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 30 Jun 2006 07:33:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751754AbWF3Ldo
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jun 2006 07:33:44 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:12327 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1750898AbWF3Ldg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jun 2006 07:33:36 -0400
Received: by ug-out-1314.google.com with SMTP id c2so756668ugf
        for <git@vger.kernel.org>; Fri, 30 Jun 2006 04:33:31 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=gD8N/Z3VcBhnsFqATKUJkRHbknxMzO0x8FyD0Nbnyby/mzrDtXYIjfB6jlZs1GyLXe/SI89zjPpHoj6PgxsC8cI46pGQ4bl0i71zjfArejOcOnoX4zBQrkUIsXThGiIVeBtmHMmKsqoOETIGjYlk+UzfkJPHz8GQLrGSR2ax0ug=
Received: by 10.78.138.14 with SMTP id l14mr123771hud;
        Fri, 30 Jun 2006 04:33:31 -0700 (PDT)
Received: by 10.78.37.7 with HTTP; Fri, 30 Jun 2006 04:33:31 -0700 (PDT)
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0606301155050.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22981>

On 6/30/06, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > >
> > > FYI I've been just battling this pipe for a couple of hours. The first
> > > steps were easy, but since I wanted to do it incrementally, the index has
> > > to be written every so often, and I seem not to be able to get that right.
> > >
> > Are you sure? Does something use the index between starting update-index
> > pipe and pclose?
>
> Yes, I am sure you have to write the cache before git-read-tree and
> git-write-tree ;-)

Indeed :) That's what pclose before git-write-tree is for (which was not the
case as I published this optimization. Noticed it later. The last patch series
has pclose before git-write-tree)

> I must have done something severely wrong, though,
> since there are not too many places where they are called. The problem is
> more likely that the cache has to be _read_, and _before_ the first
> substituted call to git-update-index.

git-write-tree change index?

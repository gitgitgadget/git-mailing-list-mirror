From: seanh <snhmnd@gmail.com>
Subject: Re: Files that cannot be added to the index
Date: Sat, 27 Aug 2011 23:44:33 +0200
Message-ID: <20110827214433.GA347@maru.local>
References: <CAMvu5bLuRWinMYNc4NoRKQKiLCWLcwkpowEFT4GQ0mcJYj6eOg@mail.gmail.com>
 <4E57A93A.6090405@drmicha.warpmail.net>
 <20110826205919.GB8107@sooty-2.local>
 <20110826211233.GB3093@digium.com>
 <20110827153536.GA291@sooty-2.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 27 23:44:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QxQgM-0006kG-BW
	for gcvg-git-2@lo.gmane.org; Sat, 27 Aug 2011 23:44:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751674Ab1H0Voj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Aug 2011 17:44:39 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:37560 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751484Ab1H0Voj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Aug 2011 17:44:39 -0400
Received: by fxh19 with SMTP id 19so3418075fxh.19
        for <git@vger.kernel.org>; Sat, 27 Aug 2011 14:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:mail-followup-to:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=4a7tl+oaD5FhaFOOWCKn5/E07TjEYqkBuAFLEj+kQfA=;
        b=DezRR74TNOI1g8i7ldAr89N4mG8Vh8y4oNATH4qAhRDiEbBOPFHWUZMyB1BX5bZ6Yr
         N/CMCfRRhEvr6b24Rd7x6pqzwW8AFjZHCAjj1uP5NCbGJBYhT6/QItiuqU9Gozo7hE4O
         IkyLOKrFtgafKLsXUi5fglyndEJKHLlQS+YUY=
Received: by 10.223.31.77 with SMTP id x13mr895493fac.124.1314481477663;
        Sat, 27 Aug 2011 14:44:37 -0700 (PDT)
Received: from maru.local (brln-4dbabee1.pool.mediaWays.net [77.186.190.225])
        by mx.google.com with ESMTPS id p11sm2439731faa.46.2011.08.27.14.44.35
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 27 Aug 2011 14:44:36 -0700 (PDT)
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20110827153536.GA291@sooty-2.local>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180249>

On Sat, Aug 27, 2011 at 05:35:36PM +0200, seanh wrote:
> On Fri, Aug 26, 2011 at 04:12:33PM -0500, Shaun Ruffell wrote:
> > Not sure if this is your problem exactly but awhile back I ran into
> > something similar to what you describe and tracked it down to the
> > fact that my filesystem was case insensitive. i.e.
> 
> My filesystem (HFS+ on OSX Lion) is case-insensitive, yeah. I bet you're
> right, because in one repo the modified file shows up in `git status` as
> LOG.txt but in the output from `ls` it is called `Log.txt`. It's the
> same in the other repo that has the problem, the case of the filename
> that is having the problem is different in `git status` and `ls`.
> 
> Perhaps the problem might have been introduced by moving the repo from a
> case-sensitive to an insensitive filesystem? Or by originally starting
> the repo on a sensitive fs and then using git clone to clone it onto an
> insensitive one. Or, maybe at some point I committed a change to the
> case of the filename and that introduced a problem on case-insenstive
> filesystems.
> 
> Did you find a way around the problem? I guess that the repo does not
> really have any uncommitted changes, so I just want to convince `git
> status` and `git diff` of this.

I think I fixed it like this:

  git config core.ignorecase false

then backup the LOG.txt file and:

  git rm Text/Log.txt
  git rm Text/LOG.txt
  git commit

then copy the LOG.txt file back again and add and commit it. Seems to be
okay now.

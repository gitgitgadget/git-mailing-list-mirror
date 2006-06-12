From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH] gitweb: Adding a `blame' interface.
Date: Mon, 12 Jun 2006 05:19:49 -0400
Message-ID: <20060612091949.GB29220@spearce.org>
References: <11500407193506-git-send-email-octo@verplant.org> <46a038f90606111502g607be3cfnf83ce81764a5f909@mail.gmail.com> <20060612082448.GA11857@verplant.org> <46a038f90606120134n21c269bbj3e8c7e31d4d93a23@mail.gmail.com> <20060612084056.GA29220@spearce.org> <Pine.LNX.4.63.0606121107520.21813@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	Florian Forster <octo@verplant.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 12 11:20:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FpiaT-0002AA-Tf
	for gcvg-git@gmane.org; Mon, 12 Jun 2006 11:19:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751231AbWFLJTz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Jun 2006 05:19:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751250AbWFLJTz
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jun 2006 05:19:55 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:52137 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1751243AbWFLJTy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jun 2006 05:19:54 -0400
Received: from cpe-72-226-60-173.nycap.res.rr.com ([72.226.60.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1FpiaK-0005I6-TT; Mon, 12 Jun 2006 05:19:49 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 4E67620FB20; Mon, 12 Jun 2006 05:19:49 -0400 (EDT)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0606121107520.21813@wbgn013.biozentrum.uni-wuerzburg.de>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21699>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Hi,
> 
> On Mon, 12 Jun 2006, Shawn Pearce wrote:
> 
> >   [gitweb]
> >     description=<div class=\"description\">\n\
> > This is a chunk of text which describes this repository.  Some\n\
> > of this text might be rather long, and might need many lines to\n\
> > really be able to describe the repository in a nice editor such as\n\
> > vi running in an 80 character wide xterm.\n\
> > </div>
> 
> AFAIK the trailing "\" will not work.

Actually it does.  I figured out that it works (and why it works)
when I implemented the GIT repository parser in Java for my pure
Java version of GIT...

For example:

  [spearce@spearce-pb15 bob]$ cat .git/config 
  [core]
          repositoryformatversion = 0
          filemode = true
  [gitweb]
          description = This is a very\nlong line to put into GIT\n\
  repo config.\n\
  I hope it works.
          on = true
  [spearce@spearce-pb15 bob]$ git repo-config gitweb.description
  This is a very
  long line to put into GIT
  repo config.
  I hope it works.
  [spearce@spearce-pb15 bob]$ git repo-config gitweb.on
  true

The use of a trailing \ makes sense; the collapsing of multiple
spaces into one space unless quoted inside of "" doesn't.
But whatever...

-- 
Shawn.

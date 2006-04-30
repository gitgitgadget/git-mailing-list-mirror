From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 3/3] fetch: optionally store the current remote information
 in the config
Date: Sun, 30 Apr 2006 19:09:18 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0604301859280.3977@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0604301524080.2646@wbgn013.biozentrum.uni-wuerzburg.de>
 <BAYC1-PASMTP08069B2CE6005391A1AFF9AEB00@CEZ.ICE>
 <Pine.LNX.4.63.0604301743370.3641@wbgn013.biozentrum.uni-wuerzburg.de>
 <BAYC1-PASMTP03034CC49FFA3042562BCBAEB00@CEZ.ICE>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 30 19:09:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FaFQB-0000KD-K0
	for gcvg-git@gmane.org; Sun, 30 Apr 2006 19:09:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751182AbWD3RJU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 30 Apr 2006 13:09:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751184AbWD3RJU
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Apr 2006 13:09:20 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:53739 "EHLO
	mailrelay.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1751182AbWD3RJU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Apr 2006 13:09:20 -0400
Received: from virusscan.mail (localhost [127.0.0.1])
	by mailrelay.mail (Postfix) with ESMTP id F2A30C4C;
	Sun, 30 Apr 2006 19:09:18 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id E22E9C77;
	Sun, 30 Apr 2006 19:09:18 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id C7674C4C;
	Sun, 30 Apr 2006 19:09:18 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: sean <seanlkml@sympatico.ca>
In-Reply-To: <BAYC1-PASMTP03034CC49FFA3042562BCBAEB00@CEZ.ICE>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19347>

Hi,

On Sun, 30 Apr 2006, sean wrote:

> On Sun, 30 Apr 2006 17:49:06 +0200 (CEST)
> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> 
> 
> > The latter should be done, because "git fetch" really is about fetching, 
> > not playing games with the config.
> 
> Then we should also remove the --store option from pull and fetch.  It
> can be set with git-repo-config.

Well, with "--store", "git fetch" still fetches. It just happens to write 
down -- for convenience -- the possibly long url and the refspecs.

> > FETCH_HEAD can contain multiple refs. 
> 
> Which head does git-pull then use to merge, all of them?

The first one.

> > And I don't get the part about fetching from multiple remotes: 
> > my patch does not allow for that.
> 
> Actually it does :o)  User just needs multiple remote.$nick.url entries 
> in his config.

You are right. But you are also wrong. The patch uses

	git-repo-config --get remote.$nick.url

which fails if there are more than one matching line. Note that 
"--get-all" is used to get _all_ remote.$nick.pull lines...

But of course, Linus "built git-push in" so that multiple urls are 
allowed and handled. It is probably confusing, if you can push but 
cannot fetch with the same remote information... But then, I fail to see 
how you could possibly specify the refspecs for the different urls.

Ciao,
Dscho

From: Jan Harkes <jaharkes@cs.cmu.edu>
Subject: Re: "git-send-pack"
Date: Fri, 1 Jul 2005 10:43:27 -0400
Message-ID: <20050701144327.GF4821@delft.aura.cs.cmu.edu>
References: <Pine.LNX.4.21.0506301403300.30848-100000@iabervon.org> <Pine.LNX.4.58.0506301302410.14331@ppc970.osdl.org> <42C454B2.6090307@zytor.com> <Pine.LNX.4.58.0506301344070.14331@ppc970.osdl.org> <42C462CD.9010909@zytor.com> <Pine.LNX.4.58.0506301432500.14331@ppc970.osdl.org> <42C46B86.8070006@zytor.com> <pan.2005.07.01.10.31.53.906759@smurf.noris.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 01 16:37:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DoMcw-0003FK-ML
	for gcvg-git@gmane.org; Fri, 01 Jul 2005 16:36:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263360AbVGAOnz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 1 Jul 2005 10:43:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263361AbVGAOnz
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Jul 2005 10:43:55 -0400
Received: from DELFT.AURA.CS.CMU.EDU ([128.2.206.88]:41700 "EHLO
	delft.aura.cs.cmu.edu") by vger.kernel.org with ESMTP
	id S263360AbVGAOnt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jul 2005 10:43:49 -0400
Received: from jaharkes by delft.aura.cs.cmu.edu with local (Exim 3.36 #1 (Debian))
	id 1DoMjn-0003X7-00; Fri, 01 Jul 2005 10:43:27 -0400
To: Matthias Urlichs <smurf@smurf.noris.de>
Mail-Followup-To: Matthias Urlichs <smurf@smurf.noris.de>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <pan.2005.07.01.10.31.53.906759@smurf.noris.de>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 01, 2005 at 12:31:53PM +0200, Matthias Urlichs wrote:
> > In the end, it might be that the right thing to do for git on kernel.org 
> > is to have a single, unified object store which isn't accessible by 
> > anything other than git-specific protocols.
> 
> Makes sense.
> 
> >  There would have to be some 
> > way of dealing with, for example, conflicting tags that apply to 
> > different repositories, though.
>
> It seems that user-specific subdirectories in refs/heads (and, presumably,
> ../tags) mostly work already.

They work pretty well, the core git commands have no problem with them
and I just sent off some patches for gitweb and gitk.

All git/objects directories can be merged into a common repository. The
refs/heads and refs/tags be copied to user specific subdirectories.

Then a pull like,
    git pull http://www.kernel.org/.../torvalds/linux-2.6.git

Would become,
    git pull http://www.kernel.org/.../linux-2.6.git torvalds/linux-2.6/master

It would make rsync more expensive for people who are interested in only
a branch or two, but there is only one repository which should be easier
on the mirrors. The http, ssh, and some future 'pack' transfer methods
won't see a difference since they only pull the specific commits they
need to catch up with a branch.

Jan

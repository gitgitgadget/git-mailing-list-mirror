From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: faster egit history page and a pure java "gitk"
Date: Wed, 26 Mar 2008 00:52:44 -0400
Message-ID: <20080326045244.GH4759@spearce.org>
References: <20080324092726.GQ8410@spearce.org> <47E8889E.6090403@intelinet.com.br> <20080325053649.GE4759@spearce.org> <47E9A8BE.4010606@intelinet.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Robin Rosenberg <robin.rosenberg@dewire.com>, git@vger.kernel.org
To: "Roger C. Soares" <rogersoares@intelinet.com.br>
X-From: git-owner@vger.kernel.org Wed Mar 26 05:53:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JeNdl-0000jO-I7
	for gcvg-git-2@gmane.org; Wed, 26 Mar 2008 05:53:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751781AbYCZEww (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Mar 2008 00:52:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752111AbYCZEww
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Mar 2008 00:52:52 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:33483 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750934AbYCZEww (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Mar 2008 00:52:52 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JeNd0-0004Uv-Av; Wed, 26 Mar 2008 00:52:46 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id B1EFE20FBAE; Wed, 26 Mar 2008 00:52:44 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <47E9A8BE.4010606@intelinet.com.br>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78256>

"Roger C. Soares" <rogersoares@intelinet.com.br> wrote:
> Shawn O. Pearce escreveu:
> >Hmm.  How long does C Git take for "git rev-list HEAD >/dev/null" ?
> >I have thus far only tuned the lower level machinary, and there
> >may still be tuning left there, but I _really_ have not tried to
> >tune the plotting portion yet.
> >
> >I did push something out a few minutes ago (b66eae Limit the number
> >of UI refreshes ...) that may help improve performance on larger
> >histories.
>  
> "git rev-list HEAD >/dev/null" returns very fast, around 1 sec I'd say. 
> My git clone has 0 loose objects and 1 pack.

OK, so its well packed and C Git behaves nicely.  :)

> I updated from your repo some minutes ago and it's pretty decent now. 
> The history appears very fast, even changing projects, and for the git 
> clone the progress bar disapears in around 7 seconds. :)

So it must have been the massive flurry of UI updates that I used to
be doing during revision walking.  I backed it off to at most 4 times
per second, which seems to help.

FWIW I just pushed another update out:

 * re-activates the old preferences for hiding/showing the commit
   message and file list;

 * word wrap setting for the comment viewer area;

 * saves the geometry (split pane positions) of the history page
   in a hidden preference;

 * copy and select all global actions (Edit->Copy aka Ctrl-C) now
   works to copy:
     - selected text in comment area;
	 - selected path names in the file list;
	 - commit SHA-1s of selected commits in DAG;

 * the window cache is now managed by Eclipse workspace settings
   when inside Eclipse;

 * the window cache now defaults to 8k/10m/10m/no-mmap as that is
   working very well for me on multiple systems;

 * global workspace preferences (Team -> Git) now shows the history
   preferences and the window cache settings

-- 
Shawn.

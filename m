From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC] shallow clone
Date: Mon, 30 Jan 2006 13:13:56 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0601301305100.20228@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7voe1uchet.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0601301220420.6424@wbgn013.biozentrum.uni-wuerzburg.de>
 <43DDFF5C.30803@hogyros.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 30 13:14:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F3Xuz-000856-3b
	for gcvg-git@gmane.org; Mon, 30 Jan 2006 13:14:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932240AbWA3MN6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 Jan 2006 07:13:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932241AbWA3MN6
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jan 2006 07:13:58 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:61599 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S932240AbWA3MN5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jan 2006 07:13:57 -0500
Received: from virusscan.mail (amavis2.rz.uni-wuerzburg.de [132.187.3.47])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id A5DEA1466BE; Mon, 30 Jan 2006 13:13:56 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id 95A17A4E;
	Mon, 30 Jan 2006 13:13:56 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 6421914668C; Mon, 30 Jan 2006 13:13:56 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Simon Richter <Simon.Richter@hogyros.de>
In-Reply-To: <43DDFF5C.30803@hogyros.de>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15270>

Hi,

On Mon, 30 Jan 2006, Simon Richter wrote:

> Johannes Schindelin wrote:
> 
> > > . Set up `info/grafts` to lie to the local git that Linux kernel
> > >  history began at v2.6.14 version.
> 
> > Maybe also record this in .git/config, so that you can
> 
> I like that "config" thing less and less every day. It appears to become a
> kind of registry, where having dedicated files for specific functionality
> would provide the robustness of tools not having to touch things they do not
> care about; but that's just personal opinion.

It is becoming sort of a registry: it contains metadata about the current 
repository, easily available to scripts and programs.

I beg to differ on your personal opinion on the grounds that the 
robustness comes from testing, not from diversity. I much prefer to have a 
well tested config mechanism to having dozens of differently formatted 
files with less-than-well tested parsers.

Thank you for the insights in your personal opinion anyway.

> > - disallow fetching from this repo, and
> 
> Why? It's perfectly acceptable to pull from an incomplete repo, as long as you
> don't care about the old history.

Right. But should that be the default? I don't think so. Therefore: 
disable it, and if the user is absolutely sure to do dumb things, she'll 
have to enable it explicitely.

> > - easily extend the shallow copy to a larger shallow one, or a full one.
> 
> Hrm, I think there should also be a way to shrink a repo and "forget" old
> history occasionally (obviously, use of that feature would be highly
> discouraged).

Yes. And you need information about how shallow it used to be. My 
suggestion was to store that information at a place specific to that 
repository (see above).

> > > . Run `git fetch git://.../linux-2.6 master`, with a local ref
> > >  pointing at v2.6.14 commit, to pretend that we have everything
> > >  up to v2.6.14 to `upload-pack` running on the other end.
> 
> > How about refs/tags/start_shallow?
> 
> No, as that would imply that cloning from such a repo is disallowed.

See above.

> IMO, it may be a lot more robust to just have a list of "cutoff" object ids in
> .git/shallow instead of messing with grafts here, as adding or removing a line
> from that file is an easier thing to do for porcelain (or by hand) than
> rewriting the grafts file. Whether that list would be inclusive or exclusive
> would need to be decided still.

The functionality of cutoff objects is included in grafts functionality, 
so why should we spend time on reimplementing a subset of features?

IMHO, adding and removing lines from scripts is fragile.

I beg your pardon, you want to edit this information *by hand*? Wow.

Ciao,
Dscho

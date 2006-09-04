From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH] pack-objects: re-validate data we copy from elsewhere.
Date: Mon, 4 Sep 2006 00:10:52 -0400
Message-ID: <20060904041052.GA29369@spearce.org>
References: <7vzmdmh2lu.fsf@assigned-by-dhcp.cox.net> <44F871BA.3070303@gmail.com> <Pine.LNX.4.64.0609011129270.27779@g5.osdl.org> <7vveo741tc.fsf_-_@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0609011721390.27779@g5.osdl.org> <7vd5ae3ox2.fsf@assigned-by-dhcp.cox.net> <20060902045246.GB25146@spearce.org> <7vodty1swz.fsf@assigned-by-dhcp.cox.net> <20060902175408.GD27826@spearce.org> <7vhczovf6m.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 04 10:40:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GKA0N-0002dJ-Je
	for gcvg-git@gmane.org; Mon, 04 Sep 2006 10:40:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751208AbWIDIk2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 4 Sep 2006 04:40:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751211AbWIDIkJ
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Sep 2006 04:40:09 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:2771 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S932243AbWIDELB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Sep 2006 00:11:01 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GK5nH-00024f-P5; Mon, 04 Sep 2006 00:10:43 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id C8B8B20FB7C; Mon,  4 Sep 2006 00:10:52 -0400 (EDT)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vhczovf6m.fsf@assigned-by-dhcp.cox.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26405>

Junio C Hamano <junkio@cox.net> wrote:
> Shawn Pearce <spearce@spearce.org> writes:
> 
> > Junio C Hamano <junkio@cox.net> wrote:
> >
> >> If rev-list had an extention that lets you say
> >> 
> >> 	rev-list --objects --all --unpacked=$active_pack |
> >> 	pack-objects $new_pack
> >
> > Hmm.  Seems very reasonable actually.  :-)
> >
> > How do we pick the "active pack" in git-repack.sh?
> 
> I was hoping that will be a Porcelain policy issue I do not have
> to decide ;-).

But would need to update git-repack.sh.  :-)
 
> You could introduce repack.active in .git/config that points at
> the latest active, make git-repack to notice and update when it
> updates it.

No.  I don't think its a good idea for git-repack to be updating
your configuration file during a repack.  If something goes badly
there you could lose settings you would rather not lose.

Better that it update a symref like thing instead.  For example
create a ".git/objects/pack/active" file holding the name
("pack-n{40}.pack") of the current active pack.  If this file is
missing choose the pack that is smallest as the active pack.

-- 
Shawn.

-- 
VGER BF report: S 0.999999

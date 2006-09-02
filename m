From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH] pack-objects: re-validate data we copy from elsewhere.
Date: Sat, 2 Sep 2006 13:54:08 -0400
Message-ID: <20060902175408.GD27826@spearce.org>
References: <20060830031029.GA23967@spearce.org> <Pine.LNX.4.64.0608300124550.9796@xanadu.home> <7vzmdmh2lu.fsf@assigned-by-dhcp.cox.net> <44F871BA.3070303@gmail.com> <Pine.LNX.4.64.0609011129270.27779@g5.osdl.org> <7vveo741tc.fsf_-_@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0609011721390.27779@g5.osdl.org> <7vd5ae3ox2.fsf@assigned-by-dhcp.cox.net> <20060902045246.GB25146@spearce.org> <7vodty1swz.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 03 11:19:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GJo8W-0004Bx-C1
	for gcvg-git@gmane.org; Sun, 03 Sep 2006 11:19:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751086AbWICJS7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 3 Sep 2006 05:18:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751045AbWICJS7
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Sep 2006 05:18:59 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:46733 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1751782AbWICALH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Sep 2006 20:11:07 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GJfZd-0003Zj-96; Sat, 02 Sep 2006 20:10:53 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 8F17520FB7F; Sat,  2 Sep 2006 13:54:08 -0400 (EDT)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vodty1swz.fsf@assigned-by-dhcp.cox.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26366>

Junio C Hamano <junkio@cox.net> wrote:
> Shawn Pearce <spearce@spearce.org> writes:
> 
> > I think the better thing to do here is to not repack objects which
> > are already contained in very large packs.  Just leave them be.
> 
> I've been thinking about updating rev-list so that repack
> can be used to organize packs into zero or more "archive packs"
> and one "active pack".
> 
> repack without -a essentially boils down to:
> 
> 	rev-list --objects --all --unpacked |
>         pack-objects $new_pack
> 
> which picks up all live loose objects and create a new pack.
> 
> If rev-list had an extention that lets you say
> 
> 	rev-list --objects --all --unpacked=$active_pack |
> 	pack-objects $new_pack

Hmm.  Seems very reasonable actually.  :-)

How do we pick the "active pack" in git-repack.sh?

How about "--include-pack=$active_pack" instead of
"--unpacked=$active_pack"?  The latter just reads really funny to me.

-- 
Shawn.

-- 
VGER BF report: S 0.9993

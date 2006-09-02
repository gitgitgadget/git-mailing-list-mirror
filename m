From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Mozilla .git tree
Date: Sat, 2 Sep 2006 13:44:32 -0400
Message-ID: <20060902174432.GB27826@spearce.org>
References: <20060830015122.GE22935@spearce.org> <9e4733910608291958l45c0257dla6e5ebd4176f7164@mail.gmail.com> <20060830031029.GA23967@spearce.org> <Pine.LNX.4.64.0608300124550.9796@xanadu.home> <7vzmdmh2lu.fsf@assigned-by-dhcp.cox.net> <7vr6yw58xp.fsf@assigned-by-dhcp.cox.net> <20060902011950.GB24234@spearce.org> <7v8xl23oia.fsf@assigned-by-dhcp.cox.net> <20060902043931.GA25146@spearce.org> <7vveo6zfx0.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 03 11:27:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GJoGe-0005cu-FP
	for gcvg-git@gmane.org; Sun, 03 Sep 2006 11:27:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751045AbWICJ1f (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 3 Sep 2006 05:27:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750917AbWICJ1f
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Sep 2006 05:27:35 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:22232 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1751293AbWIBTK4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Sep 2006 15:10:56 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GJat7-0007oP-GJ; Sat, 02 Sep 2006 15:10:47 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id C415520FB7C; Sat,  2 Sep 2006 13:44:32 -0400 (EDT)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vveo6zfx0.fsf@assigned-by-dhcp.cox.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26368>

Junio C Hamano <junkio@cox.net> wrote:
> Shawn Pearce <spearce@spearce.org> writes:
> 
> > Using a 28 byte index entry instead of a 32 byte index entry means
> > the Mozilla historical pack index will only be 52.4 MiB rather than
> > the slightly larger 59.9 MiB.
> 
> Yup, that was one consideration.  One small worry is we will be
> placing u64 at 4-byte alignment by using 28-byte entries but I
> think that is Ok.

On some systems (SPARC?) that's definately an issue.  Other systems
(x86) obviously don't have that problem.

If you code the decode function as treating that 64 bit value as
two 32 bit values in network byte order and combine them together
after ntohl() then this shouldn't be a problem.  Though big-endian
systems which can take a u64 on a 4-byte alignment just fine would
pay a small performance penalty that they don't need to pay.

-- 
Shawn.

-- 
VGER BF report: S 0.998672

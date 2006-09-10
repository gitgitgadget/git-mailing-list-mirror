From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: Change set based shallow clone
Date: Sun, 10 Sep 2006 12:28:12 +0200
Message-ID: <200609101228.12956.Josef.Weidendorfer@gmx.de>
References: <9e4733910609071923tf1c49f6o70419e961e9eb66f@mail.gmail.com> <e5bfff550609092123t1d8b6c70s5750fbb787534812@mail.gmail.com> <7virjwuxrz.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Marco Costalba" <mcostalba@gmail.com>,
	"Linus Torvalds" <torvalds@osdl.org>,
	"Paul Mackerras" <paulus@samba.org>,
	"Jon Smirl" <jonsmirl@gmail.com>,
	"linux@horizon.com" <linux@horizon.com>,
	"Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Sep 10 12:29:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GMMYb-0002cG-R7
	for gcvg-git@gmane.org; Sun, 10 Sep 2006 12:28:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750703AbWIJK2V (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Sep 2006 06:28:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750717AbWIJK2U
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Sep 2006 06:28:20 -0400
Received: from mail.gmx.net ([213.165.64.20]:3487 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750703AbWIJK2T (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 10 Sep 2006 06:28:19 -0400
Received: (qmail invoked by alias); 10 Sep 2006 10:28:18 -0000
Received: from p549690E5.dip0.t-ipconnect.de (EHLO noname) [84.150.144.229]
  by mail.gmx.net (mp029) with SMTP; 10 Sep 2006 12:28:18 +0200
X-Authenticated: #352111
To: Junio C Hamano <junkio@cox.net>
User-Agent: KMail/1.9.3
In-Reply-To: <7virjwuxrz.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26790>

On Sunday 10 September 2006 06:54, Junio C Hamano wrote:
> I am starting to suspect that introducing "generation" header to
> the commit objects might actually be a very good thing.  For
> one thing, rev-list will automatically get the topology always
> right if we did so.

I do not think that any commits need to be changed, but only
"rev-list --topo-order" to build its own private cache of
sequence numbers for commits.

AFAICS, a generation number is pure redundant information, as a single
run of "rev-list --topo-order" can recalculate it. If it can not find
the number in its private per-repository cache of sequence numbers,
it calculates it the hard way (same as currently) and puts the found
numbers into the cache afterwards.

The cache should be similar in size to a pack index of a fully packed repository,
but probably could be way smaller, by storing only one sequence number for
a linear sequence of commits with only one parent each.

Josef

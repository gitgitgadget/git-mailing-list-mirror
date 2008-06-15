From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH 4/4] Teach "git clone" to pack refs
Date: Mon, 16 Jun 2008 00:03:06 +0200
Message-ID: <200806160003.06300.johan@herland.net>
References: <200806151602.03445.johan@herland.net>
 <200806151606.16380.johan@herland.net>
 <20080615175613.GC6127@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jun 16 00:05:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K80LR-0005Fu-8C
	for gcvg-git-2@gmane.org; Mon, 16 Jun 2008 00:05:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751064AbYFOWDi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Jun 2008 18:03:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751084AbYFOWDi
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jun 2008 18:03:38 -0400
Received: from smtp.getmail.no ([84.208.20.33]:45392 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751037AbYFOWDi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jun 2008 18:03:38 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-009-z2.isp.get.no by
 no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0K2I00121YLZYY00@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Mon, 16 Jun 2008 00:03:35 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0K2I00GB5YL6LZA0@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Mon, 16 Jun 2008 00:03:06 +0200 (CEST)
Received: from alpha.herland ([84.215.102.95])
 by no-osl-m323-srv-004-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0K2I00GOIYL64PG0@no-osl-m323-srv-004-z1.isp.get.no> for
 git@vger.kernel.org; Mon, 16 Jun 2008 00:03:06 +0200 (CEST)
In-reply-to: <20080615175613.GC6127@sigill.intra.peff.net>
Content-disposition: inline
User-Agent: KMail/1.9.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85146>

On Sunday 15 June 2008, Jeff King wrote:
> On Sun, Jun 15, 2008 at 04:06:16PM +0200, Johan Herland wrote:
> > +	pack_refs(PACK_REFS_ALL);
>
> I haven't looked carefully at the pack_refs code, but my understanding
> was that this would pack _all_ refs, including branches. Don't we
> generally try to leave branches unpacked, since they change a lot? IOW,
> shouldn't this just be "pack_refs(0)"?

Yes, for many repos it does not make much sense to pack branches. But in the 
case where the repo has many inactive branches (I have repos with 1000 
branches where at most 5-10 are still active), I'd much rather pack all 
branches and then later "unpack" the active ones, than write all 
those "loose" refs as separate files onto the filesystem (e.g. in CygWin 
*shudder*). In any case, the user normally does not work actively on 
hundreds of branches, so the overhead of "unpacking" active branches should 
be fairly negligible in any case.


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net

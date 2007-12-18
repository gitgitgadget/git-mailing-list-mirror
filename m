From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: "Argument list too long" in git remote update (Was: Git and GCC)
Date: Mon, 17 Dec 2007 20:52:25 -0500
Message-ID: <20071218015225.GV14735@spearce.org>
References: <4aca3dc20712051108s216d3331t8061ef45b9aa324a@mail.gmail.com> <2007-12-05-21-23-14+trackit+sam@rfc1149.net> <1196891451.10408.54.camel@brick> <jeeje0ogvk.fsf@sykes.suse.de> <1196897840.10408.57.camel@brick> <38a0d8450712130640p1b5d74d6nfa124ad0b0110d64@mail.gmail.com> <1197572755.898.15.camel@brick> <37BDCA73-4318-4BC8-9CCE-1DA30E4A09FC@adacore.com> <alpine.LFD.0.9999.0712171455220.21557@woody.linux-foundation.org> <20071218013401.A1716@edi-view2.cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Geert Bosch <bosch@adacore.com>,
	Harvey Harrison <harvey.harrison@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Derek Fawcus <dfawcus@cisco.com>
X-From: git-owner@vger.kernel.org Tue Dec 18 02:53:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4Rdj-0003wP-BV
	for gcvg-git-2@gmane.org; Tue, 18 Dec 2007 02:52:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751898AbXLRBwf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2007 20:52:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751411AbXLRBwf
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Dec 2007 20:52:35 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:44746 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751232AbXLRBwe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2007 20:52:34 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1J4Rd2-00050Y-A5; Mon, 17 Dec 2007 20:52:16 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id EFE4420FBAE; Mon, 17 Dec 2007 20:52:25 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <20071218013401.A1716@edi-view2.cisco.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68688>

Derek Fawcus <dfawcus@cisco.com> wrote:
> On Mon, Dec 17, 2007 at 03:01:25PM -0800, Linus Torvalds wrote:
> > 
> > > With git version 1.5.3.6 on Mac OS X, this results in:
> > > potomac%:~/gcc%git remote update
> > > Updating gcc.gnu.org
> > > /opt/git/bin/git-fetch: line 220: /opt/git/bin/git: Argument list too long
> 
> > But maybe there is some way to raise the argument size limit on OS X.
> 
> Well the certification for Leopard claims it can be up to 256k.
> 
> I don't know about Tiger or earlier,  but ARG_MAX on my 10.4
> box is also (256 * 1024).
> 
> So - how much do people want?  Or maybe there is some sort limit in play here?

I heard there's like 1000 branches in that GCC repository, not
counting tags.

Each branch name is at least 12 bytes or so ("refs/heads/..").
It adds up.

It should be fixed in latest git (1.5.4-rc0) as that uses the new
builtin-fetch implementation, which passes the lists around in
memory rather than on the command line.  Much faster, and doesn't
suffer from argument/environment limits.

-- 
Shawn.

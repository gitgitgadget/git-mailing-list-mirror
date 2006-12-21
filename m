From: Juergen Ruehle <j.ruehle@bmiag.de>
Subject: Re: cloning the kernel - why long time in "Resolving 313037 deltas"
Date: Thu, 21 Dec 2006 21:35:52 +0100
Message-ID: <17802.61480.299000.553748@lapjr.intranet.kiel.bmiag.de>
References: <8664c896xv.fsf@blue.stonehenge.com>
	<Pine.LNX.4.64.0612181511260.3479@woody.osdl.org>
	<Pine.LNX.4.64.0612181906450.18171@xanadu.home>
	<20061219051108.GA29405@thunk.org>
	<20061219063930.GA2511@spearce.org>
	<Pine.LNX.4.64.0612182248420.3479@woo <20061219202850.GA4501@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Marco Roeland <marco.roeland@xs4all.nl>,
	Shawn Pearce <spearce@spearce.org>,
	Linus Torvalds <torvalds@osdl.org>,
	Theodore Tso <tytso@mit.edu>, Nicolas Pitre <nico@cam.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"Randal L. Schwartz" <merlyn@stonehenge.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 21 21:36:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GxUec-0000KH-H8
	for gcvg-git@gmane.org; Thu, 21 Dec 2006 21:36:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423077AbWLUUgf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Dec 2006 15:36:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423065AbWLUUgf
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Dec 2006 15:36:35 -0500
Received: from meriadoc.bmiag.de ([62.154.210.133]:47591 "EHLO
	meriadoc.bmiag.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423076AbWLUUge (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Dec 2006 15:36:34 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by meriadoc.bmiag.de (Postfix) with ESMTP id 8FE513AF1F;
	Thu, 21 Dec 2006 21:36:31 +0100 (CET)
Received: from meriadoc.bmiag.de ([127.0.0.1])
	by localhost (meriadoc [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 17987-02; Thu, 21 Dec 2006 21:36:31 +0100 (CET)
Received: from eotheod.intranet.kiel.bmiag.de (eotheod.intranet.kiel.bmiag.de [10.130.2.1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by meriadoc.bmiag.de (Postfix) with ESMTP id E6F8C3AF1E;
	Thu, 21 Dec 2006 21:36:10 +0100 (CET)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by eotheod.intranet.kiel.bmiag.de (Postfix) with ESMTP id 71C2F3ADCA;
	Thu, 21 Dec 2006 21:36:10 +0100 (CET)
Received: from eotheod.intranet.kiel.bmiag.de ([127.0.0.1])
	by localhost (eotheod [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 02993-06; Thu, 21 Dec 2006 21:36:07 +0100 (CET)
Received: from LAPJR (dialin5.galadriel.bmiag.de [192.168.251.5])
	by eotheod.intranet.kiel.bmiag.de (Postfix) with ESMTP id 0D5BF3ADC6;
	Thu, 21 Dec 2006 21:35:57 +0100 (CET)
To: Alex Riesen <raa.lkml@gmail.com>
In-Reply-To: <20061219202850.GA4501@steel.home>
X-Mailer: VM 7.19 under Emacs 21.3.1
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at eotheod.intranet.kiel.bmiag.de
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at meriadoc.bmiag.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35085>

Alex Riesen writes:
 > Marco Roeland, Tue, Dec 19, 2006 10:13:19 +0100:
 > > > Not that I personally frequently clone large projects on Mac OS X.
 > > > But new users to Git might.  :-)
 > > 
 > > And perhaps the Cygwin version might benefit too.
 > 
 > Does not work there at all. Even errno is not set (0).

Haven't seen a reply to this yet.

Upgrade cygwin.dll. The fix is pretty recent (1.5.22 or something).
Perhaps we now need a note in INSTALL.

Light testing seems to indicate that this change removes most of the
system times while leaving user time mostly unchanged (though I don't
know what cygwin time really reports in these categories). In the git
repository this is about 30% of the total time. For another (slightly
larger but with fewer objects) pack this still saves 20%. I haven't
compared it with the NO_MMAP version (too lazy), but overall it's a
win for cygwin as well (though we should note that cygwin's mmap seems
to have reasonable performance).

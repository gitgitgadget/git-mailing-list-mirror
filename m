From: Johan Herland <johan@herland.net>
Subject: Re: [RFC/PATCHv7 22/22] fast-import: Proper notes tree manipulation
 using the notes API
Date: Fri, 20 Nov 2009 02:43:18 +0100
Message-ID: <200911200243.18476.johan@herland.net>
References: <1255083738-23263-1-git-send-email-johan@herland.net>
 <1255083738-23263-24-git-send-email-johan@herland.net>
 <20091009142524.GQ9261@spearce.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, gitster@pobox.com, Johannes.Schindelin@gmx.de,
	trast@student.ethz.ch, tavestbo@trolltech.com,
	git@drmicha.warpmail.net, chriscool@tuxfamily.org, sam@vilain.net
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Nov 20 02:43:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NBIWz-0005Fn-QT
	for gcvg-git-2@lo.gmane.org; Fri, 20 Nov 2009 02:43:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757096AbZKTBnP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Nov 2009 20:43:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757010AbZKTBnO
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Nov 2009 20:43:14 -0500
Received: from smtp.getmail.no ([84.208.15.66]:59042 "EHLO
	get-mta-out01.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755940AbZKTBnO (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Nov 2009 20:43:14 -0500
Received: from smtp.getmail.no ([10.5.16.4]) by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KTD00MPPWS7SE10@get-mta-out01.get.basefarm.net> for
 git@vger.kernel.org; Fri, 20 Nov 2009 02:43:19 +0100 (MET)
Received: from alpha.localnet ([84.215.102.95])
 by get-mta-in02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KTD00DDFWS7UY10@get-mta-in02.get.basefarm.net> for
 git@vger.kernel.org; Fri, 20 Nov 2009 02:43:19 +0100 (MET)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2009.11.20.12721
User-Agent: KMail/1.12.3 (Linux/2.6.31-ARCH; KDE/4.3.3; x86_64; ; )
In-reply-to: <20091009142524.GQ9261@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133291>

On Friday 09 October 2009, Shawn O. Pearce wrote:
> Johan Herland <johan@herland.net> wrote:
> > This patch teaches 'git fast-import' to use the notes API to organize
> > the manipulation of note objects through a fast-import stream. Note
> > objects are added to the notes tree through the 'N' command, and when
> > we're about to store the tree object for the current commit, we walk
> > through the notes tree and insert all the notes into the stored tree.
> 
> Some high level comments about this patch:
> 
> - You don't destroy the struct notes_tree during unload_one_branch()
>   which means notes trees stay in memory even if the branch table
>   is overflowing.  I think you should discard the notes tree when
>   a branch unloads, and recreate it when the branch loads.
> 
> - Destroying and adding back all notes is OK with ~20k notes, but
>   doing that with ~150k-~800k notes is going to slow down a lot,
>   losing the "fast" part.

Thanks for the comments. I've tried to address them in the 8th iteration of 
this series (Patch 8/10 to be more precise), just submitted to the mailing 
list.


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net

From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git-index-pack really does suck..
Date: Tue, 3 Apr 2007 14:00:55 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0704031357470.6730@woody.linux-foundation.org>
References: <Pine.LNX.4.64.0704030754020.6730@woody.linux-foundation.org>
 <db69205d0704031227q1009eabfhdd82aa3636f25bb6@mail.gmail.com>
 <Pine.LNX.4.64.0704031304420.6730@woody.linux-foundation.org>
 <alpine.LFD.0.98.0704031625050.28181@xanadu.home> <7vzm5pur7g.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Nicolas Pitre <nico@cam.org>, Chris Lee <clee@kde.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Apr 03 23:02:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HYq8h-0001SG-Mv
	for gcvg-git@gmane.org; Tue, 03 Apr 2007 23:02:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945941AbXDCVCA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Apr 2007 17:02:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753651AbXDCVB7
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Apr 2007 17:01:59 -0400
Received: from smtp.osdl.org ([65.172.181.24]:43939 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753672AbXDCVB6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Apr 2007 17:01:58 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l33L0wPD022743
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 3 Apr 2007 14:00:59 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l33L0tFd003103;
	Tue, 3 Apr 2007 14:00:57 -0700
In-Reply-To: <7vzm5pur7g.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-0.456 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43662>



On Tue, 3 Apr 2007, Junio C Hamano wrote:
> 
> So maybe we should retitle this thread from "git-index-pack
> really does suck.." to "I used git-index-pack in a stupid way"?

See my separate timing numbers, although I bet that Chris can give even 
better ones..

Chris, try applying my patch, and then inside the KDE repo you have, do

	git index-pack --paranoid --stdin --fix-thin new.pack < ~/git/.git/objects/pack/pack-*.pack

(ie index the objects of the *git* repository, not the KDE one). That 
should approximate doing a fair-sized "git pull" - getting new objects. Do 
it with and without --paranoid, and time it.

I bet that what I see as a 7% slowdown will be much bigger for you, just 
because the negative lookups will be all that much more expensive when you 
have tons of objects.

			Linus

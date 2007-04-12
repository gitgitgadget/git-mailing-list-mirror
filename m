From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 5/6] Teach "fsck" not to follow subproject links
Date: Wed, 11 Apr 2007 18:52:46 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0704111850240.4061@woody.linux-foundation.org>
References: <Pine.LNX.4.64.0704092100110.6730@woody.linux-foundation.org>
 <Pine.LNX.4.64.0704092115020.6730@woody.linux-foundation.org>
 <461D6432.90205@vilain.net> <Pine.LNX.4.64.0704111545040.6730@woody.linux-foundation.org>
 <461D6858.4090007@vilain.net> <Pine.LNX.4.64.0704111605210.6730@woody.linux-foundation.org>
 <7vslb6mnva.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Sam Vilain <sam@vilain.net>, Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Apr 12 03:53:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HboUb-0001sH-D4
	for gcvg-git@gmane.org; Thu, 12 Apr 2007 03:52:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161460AbXDLBww (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Apr 2007 21:52:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161462AbXDLBww
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Apr 2007 21:52:52 -0400
Received: from smtp.osdl.org ([65.172.181.24]:41654 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161460AbXDLBwv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2007 21:52:51 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l3C1qmVZ030191
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 11 Apr 2007 18:52:48 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l3C1qlYn020215;
	Wed, 11 Apr 2007 18:52:47 -0700
In-Reply-To: <7vslb6mnva.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-0.957 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44304>



On Wed, 11 Apr 2007, Junio C Hamano wrote:
>
> The small detail in the last step is wrong, though.  Even if
> they EXIST, they may be isolated commits that are note connected
> to refs, and fsck in the repository would not have warned about
> unreachable trees from such unconnected commits.

The superproject *is* a ref.

You cannot prune the subprojects on their own. That's the *only* real 
special rule about subprojects. Exactly because pruning them on their own 
is not a valid op to do.

It's the same way with an source of "alternate" objects (or a shared 
object directory) - you'd better not prune them, because other projects 
may have refs to them that you don't know about locally. So this isn't 
somethign new to subprojects.

		Linus

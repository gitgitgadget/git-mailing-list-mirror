From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: file name case-sensitivity issues
Date: Tue, 23 May 2006 14:30:42 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605231426520.5623@g5.osdl.org>
References: <20060523210615.GB5869@steel.home> <Pine.LNX.4.64.0605231412350.5623@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue May 23 23:30:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FieSq-0007fe-Hr
	for gcvg-git@gmane.org; Tue, 23 May 2006 23:30:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932126AbWEWVau (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 May 2006 17:30:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932288AbWEWVau
	(ORCPT <rfc822;git-outgoing>); Tue, 23 May 2006 17:30:50 -0400
Received: from smtp.osdl.org ([65.172.181.4]:45768 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932126AbWEWVat (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 May 2006 17:30:49 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k4NLUitH029241
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 23 May 2006 14:30:45 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k4NLUgTo021918;
	Tue, 23 May 2006 14:30:43 -0700
To: Alex Riesen <raa.lkml@gmail.com>
In-Reply-To: <Pine.LNX.4.64.0605231412350.5623@g5.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20642>



On Tue, 23 May 2006, Linus Torvalds wrote:
> 
> The closest I can imagine is to add a config option like "core.lowercase", 
> and that would make us always add files to the index in lower case.

Side note: doing it by just changing the name compare functions to ignore 
case is _not_ a good things to do, because that would generate tree 
objects that simply don't work (or fsck) correctly on any other machine. 

The index and tree objects are all sorted by pathname, and thus the 
sorting order has to be something that everybody agrees on, and any locale 
dependencies are not appropriate.

It might be worth asking the monotone guys what they do - they've worked 
on Windows for a long time.

		Linus

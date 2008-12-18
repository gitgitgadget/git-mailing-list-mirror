From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: negated list in .gitignore no fun
Date: Thu, 18 Dec 2008 14:54:18 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0812181452030.14014@localhost.localdomain>
References: <87hc51tajw.fsf@jidanni.org> <alpine.LFD.2.00.0812181429100.14014@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, joey@kitenet.net
To: jidanni@jidanni.org
X-From: git-owner@vger.kernel.org Thu Dec 18 23:56:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LDRmz-0004hT-LH
	for gcvg-git-2@gmane.org; Thu, 18 Dec 2008 23:56:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752841AbYLRWyz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Dec 2008 17:54:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752681AbYLRWyz
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Dec 2008 17:54:55 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:37126 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752097AbYLRWyy (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 Dec 2008 17:54:54 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id mBIMsJLS030240
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 18 Dec 2008 14:54:20 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id mBIMsIib027652;
	Thu, 18 Dec 2008 14:54:19 -0800
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <alpine.LFD.2.00.0812181429100.14014@localhost.localdomain>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.049 required=5 tests=AWL,BAYES_00,SUBJECT_FUZZY_TION
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103505>



On Thu, 18 Dec 2008, Linus Torvalds wrote:
> 
> So you have several possibilities:
> 
>  (a) either create a .gitignore that looks like this:
> 
> 	*
> 	!X11
> 	!X11/xorg.conf
> 	!anacrontab
> 	!apt
> 	!apt/apt.conf.d
> 	!apt/apt.conf.d/10jidanni
> 	!apt/sources.list
> 
>     which should work around it by telling git that it shouldn't ignore 
>     the subdirectories.

Oh, you should have a '/' there in the subdirectory marker too, because 
otherwise a file like 'X11/apt' would now match as a positive match.

>  (c) Try to teach git to not ignore subdirectories leading up to 
>      non-ignored files, and give you the .gitignore semantics you like. I 
>      suspect it's not worth it, because the git behaviour is logical once 
>      you know about it and understand it.

.. and because of subtle issues like this - negated entries are really 
quite complex enough as-is. Don't use them for anything subtle, you _will_ 
get them wrong regardless.

			Linus

From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] Add NO_RSYNC to allow building without rsync
Date: Wed, 30 Jul 2008 12:33:17 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0807301231050.3334@nehalem.linux-foundation.org>
References: <20080730185225.GG10399@yugib.highrise.ca>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Aidan Van Dyk <aidan@highrise.ca>
X-From: git-owner@vger.kernel.org Wed Jul 30 21:37:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOHUa-0003Fo-2T
	for gcvg-git-2@gmane.org; Wed, 30 Jul 2008 21:37:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753359AbYG3Tgt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jul 2008 15:36:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751996AbYG3Tgt
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Jul 2008 15:36:49 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:42550 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753078AbYG3Tgs (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 30 Jul 2008 15:36:48 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m6UJaFAZ024281
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 30 Jul 2008 12:36:16 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m6UJaFUL012371;
	Wed, 30 Jul 2008 12:36:15 -0700
In-Reply-To: <20080730185225.GG10399@yugib.highrise.ca>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-5.409 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90842>



On Wed, 30 Jul 2008, Aidan Van Dyk wrote:
> 
> I came about this because SCO OpenServer doesnt' have mkdtemp.  But I never use
> rsync, so making it optional was an easy fix.

Hmm. Without mkdtemp(), maybe you could just do a trivial compat function 
somethin glike

	char *git_mkdtemp(char *template)
	{
		char *n = mktemp(template);
		if (mkdir(n))
			n = NULL;
		return n;
	}

instead?

		Linus

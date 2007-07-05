From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Email address from username and hostname preferred over $EMAIL
Date: Thu, 5 Jul 2007 14:10:14 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0707051357360.9434@woody.linux-foundation.org>
References: <OF40A04FE5.AA34B1BF-ON8825730F.005D733A-8825730F.0062A716@beck
 man.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: git@vger.kernel.org
To: mkraai@beckman.com
X-From: git-owner@vger.kernel.org Thu Jul 05 23:12:27 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I6Yck-0000vL-BC
	for gcvg-git@gmane.org; Thu, 05 Jul 2007 23:12:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763117AbXGEVLV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 Jul 2007 17:11:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763100AbXGEVLU
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jul 2007 17:11:20 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:58717 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1763022AbXGEVLT (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 Jul 2007 17:11:19 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l65LAKid018716
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 5 Jul 2007 14:10:21 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l65LAEgL019638;
	Thu, 5 Jul 2007 14:10:14 -0700
In-Reply-To: <OF40A04FE5.AA34B1BF-ON8825730F.005D733A-8825730F.0062A716@beckman.com>
X-Spam-Status: No, hits=-2.64 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51694>



On Thu, 5 Jul 2007, mkraai@beckman.com wrote:
> 
> Git prefers to use an email address constructed from the username and 
> hostname to the value of the EMAIL environment variable.  I think it 
> should prefer the latter to the former.  This problem was introduced by 
> ec563e8153cba89728a271a26c8a94e7a42d8152.

It did that very much on purpose. "git_default_email" must take 
precedence, because that's the one that is filled in by the config file 
syntax.

So just use

	[user]
		name = ..
		email = ..

and be happy. Only in the absense of that will git start guessing, and 
yeah, it will not generally use EMAIL, unless it cannot get anything at 
all from username/hostname.

If you want it to prefer $EMAIL, you'd need to change the initialization 
of git_default_email, methinks.

		Linus

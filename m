From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] xdl_merge(): introduce XDL_MERGE_ZEALOUS_ALNUM
Date: Fri, 15 Feb 2008 10:17:06 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0802151012380.3066@woody.linux-foundation.org>
References: <A21B3CA8-6240-434F-87A9-C6F76DA15265@gmail.com> <alpine.LFD.1.00.0802121544370.2920@woody.linux-foundation.org> <alpine.LSU.1.00.0802130003370.3870@racer.site> <alpine.LSU.1.00.0802130108060.3870@racer.site> <7v3arxzlke.fsf@gitster.siamese.dyndns.org>
 <alpine.LSU.1.00.0802131113360.30505@racer.site> <7vlk5mgm5y.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Voltage Spike <voltspike@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 15 19:18:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQ58k-0000hI-Ea
	for gcvg-git-2@gmane.org; Fri, 15 Feb 2008 19:18:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754865AbYBOSRu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Feb 2008 13:17:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754788AbYBOSRu
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Feb 2008 13:17:50 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:57263 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753766AbYBOSRt (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 Feb 2008 13:17:49 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m1FIH7xV032586
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 15 Feb 2008 10:17:08 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m1FIH6mF017307;
	Fri, 15 Feb 2008 10:17:07 -0800
In-Reply-To: <7vlk5mgm5y.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-4.739 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73969>



On Fri, 15 Feb 2008, Junio C Hamano wrote:
> 
> I think there is no excuse not to coalesce hunks separated by
> three lines or less

Well, I think the two line limit is the "unquestionable" one, since that's 
the one that actually results in fewer lines over-all. 

The three-line case gets a bit less obvious since the line count doesn't 
change, and if the unchanged lines are complex, it might well be better to 
leave them as shared. What's not uncommon at all is that you have a small 
change that results in a new variable or similar, and then it's quite 
possible that the first conflict comes from a new variable declaration, 
and the second conflict is the "real code" change, and if there are three 
complex lines in between, it probably makes sense to keep them unmodified, 
and have two much simpler choices.

In fact, in many ways, maybe we'd be better off counting (non-space) bytes 
rather than lines. That gets the "complexity" argument mostly right.

			Linus

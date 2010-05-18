From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] t9129: fix UTF-8 locale detection
Date: Tue, 18 May 2010 10:45:26 -0700 (PDT)
Message-ID: <alpine.LFD.2.00.1005181037250.4195@i5.linux-foundation.org>
References: <1274202486.4228.22.camel@localhost> <1274203013-1349-1-git-send-email-yann@droneaud.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Michael J Gruber <git@drmicha.warpmail.net>
To: Yann Droneaud <yann@droneaud.fr>
X-From: git-owner@vger.kernel.org Tue May 18 19:48:38 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OEQuE-0001rP-5I
	for gcvg-git-2@lo.gmane.org; Tue, 18 May 2010 19:48:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758677Ab0ERRsQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 May 2010 13:48:16 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:33393 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758674Ab0ERRsO (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 18 May 2010 13:48:14 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id o4IHlaBM012732
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 18 May 2010 10:47:37 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id o4IHlZCk026315;
	Tue, 18 May 2010 10:47:35 -0700
In-Reply-To: <1274203013-1349-1-git-send-email-yann@droneaud.fr>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-5.446 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147293>



On Tue, 18 May 2010, Yann Droneaud wrote:
>  
> -if locale -a |grep -q en_US.utf8; then
> +if locale -a |grep -qE '^en_US\.(utf|UTF)-?8$'; then

While -E is POSIX, I suspect that it's not universal. iirc, you still have 
some really crap fileutils tools coming with Solaris, for example. 

Wouldn't it be easier to just make it ignore case, and do

	grep -qi '^en_US\.utf-?8$'

instead?

I'm also not entirely sure you want to make that pattern stricter - the 
whole problem with the old pattern was that it was too exact, so why add 
the beginning/end requirement?

		Linus

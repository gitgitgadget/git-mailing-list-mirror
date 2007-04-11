From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 5/6] Teach "fsck" not to follow subproject links
Date: Wed, 11 Apr 2007 15:48:05 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0704111545040.6730@woody.linux-foundation.org>
References: <Pine.LNX.4.64.0704092100110.6730@woody.linux-foundation.org>
 <Pine.LNX.4.64.0704092115020.6730@woody.linux-foundation.org>
 <461D6432.90205@vilain.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Thu Apr 12 00:48:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hblbr-0005pW-RD
	for gcvg-git@gmane.org; Thu, 12 Apr 2007 00:48:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161332AbXDKWsK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Apr 2007 18:48:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161334AbXDKWsK
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Apr 2007 18:48:10 -0400
Received: from smtp.osdl.org ([65.172.181.24]:35203 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161332AbXDKWsJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2007 18:48:09 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l3BMm6VZ025406
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 11 Apr 2007 15:48:06 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l3BMm562016627;
	Wed, 11 Apr 2007 15:48:06 -0700
In-Reply-To: <461D6432.90205@vilain.net>
X-Spam-Status: No, hits=-0.957 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44270>



On Thu, 12 Apr 2007, Sam Vilain wrote:
>
> Linus Torvalds wrote:
> > Since the subprojects don't necessarily even exist in the current tree,
> > much less in the current git repository (they are totally independent
> > repositories), we do not want to try to follow the chain from one git
> > repository to another through a gitlink.
> >   
> 
> Does this consider the case where the intent of the subprojects are to
> collate multiple, small projects into one bigger project?
> 
> In that case, you might want to keep all of the subprojects in the same
> git repository.

I assume you mean "you might want to keep all of the subprojects' objects 
in the same git object directory".

And yes, that's absolutely true, but it's technically no different from 
just using GIT_OBJECT_DIRECTORY to share objects between totally unrelated 
projects, or using git/alternates to share objects between (probably 
*less* unrelated repositories, but still clearly individual repos).

So the main point of superproject/subprojects is to allow independence 
(because independence is what allows it to scale), but there is nothing to 
say that things *have* to kept totally isolated. 

			Linus

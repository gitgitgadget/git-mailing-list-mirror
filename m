From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] Fix typo on variable name $newref should be $newrev in
 sample update hook
Date: Fri, 2 Mar 2007 08:44:06 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0703020839350.3953@woody.linux-foundation.org>
References: <200703021027.00203.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 02 17:44:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HNArg-0000mf-0C
	for gcvg-git@gmane.org; Fri, 02 Mar 2007 17:44:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992603AbXCBQoK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Mar 2007 11:44:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992605AbXCBQoK
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Mar 2007 11:44:10 -0500
Received: from smtp.osdl.org ([65.172.181.24]:34171 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S2992603AbXCBQoJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Mar 2007 11:44:09 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l22Gi7Ab026249
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 2 Mar 2007 08:44:07 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l22Gi6AT013003;
	Fri, 2 Mar 2007 08:44:06 -0800
In-Reply-To: <200703021027.00203.andyparkins@gmail.com>
X-Spam-Status: No, hits=-2.445 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41229>



On Fri, 2 Mar 2007, Andy Parkins wrote:
>  			# ref that were previously not accessible
> -			git-rev-parse --not --all | git-rev-list --stdin --pretty $newref
> +			git-rev-parse --not --all | git-rev-list --stdin --pretty $newrev

Well, it should just avoid git-rev-parse these days and do

	git rev-list --pretty $newrev --not --all

instead. And quite frankly, rather than "git rev-list --pretty", there's 
no real reason not to do

	git log $newrev --not --all

unless there is some subtle issue with pagers (but none of this goes to a 
terminal?) in which case you'd have to disable that (and then rev-list is 
probably simpler and more readable than adding a "GIT_PAGER=" to the 
front).

		Linus

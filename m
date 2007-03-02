From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] Remove use of git-rev-parse and replace git-rev-list
 --pretty with git-log
Date: Fri, 2 Mar 2007 12:48:25 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0703021246480.3953@woody.linux-foundation.org>
References: <Pine.LNX.4.64.0703020839350.3953@woody.linux-foundation.org>
 <200703021929.20969.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 02 21:48:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HNEg3-00026J-IE
	for gcvg-git@gmane.org; Fri, 02 Mar 2007 21:48:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965111AbXCBUs2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Mar 2007 15:48:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965113AbXCBUs2
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Mar 2007 15:48:28 -0500
Received: from smtp.osdl.org ([65.172.181.24]:40840 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965111AbXCBUs2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Mar 2007 15:48:28 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l22KmQq8001254
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 2 Mar 2007 12:48:26 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l22KmPJN018568;
	Fri, 2 Mar 2007 12:48:25 -0800
In-Reply-To: <200703021929.20969.andyparkins@gmail.com>
X-Spam-Status: No, hits=-2.447 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41245>



On Fri, 2 Mar 2007, Andy Parkins wrote:
>  			# Commit with a parent
> -			for rev in $(git-rev-parse --not --all | git-rev-list --stdin $newrev ^$baserev)
> +			for rev in $(git-rev-list $newrev ^$baserev --not --all)

Looks fine, and I don't think it's worth changing, but you can avoid the 
extra caret by just moving "$baserev" to after the "--not", ie writing the 
thing as

	git-rev-list $newrev --not $baserev --all

instead if you want to.

> -			git-rev-parse --not --all |
> -			git-rev-list --stdin --pretty $newrev ^$baserev
> +			git log $newrev ^$baserev --not --all

And that's true here too.

		Linus

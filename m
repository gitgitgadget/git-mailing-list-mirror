From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] Use stdin reflist passing in git-fetch.sh
Date: Mon, 12 Feb 2007 18:31:47 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0702121830270.8424@woody.linux-foundation.org>
References: <11713297014015-git-send-email-julian@quantumfyre.co.uk>
 <11713297013179-git-send-email-julian@quantumfyre.co.uk>
 <1171329702101-git-send-email-julian@quantumfyre.co.uk>
 <11713297023551-git-send-email-julian@quantumfyre.co.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Julian Phillips <julian@quantumfyre.co.uk>
To: Julian Phillips <jp3@quantumfyre.co.uk>
X-From: git-owner@vger.kernel.org Tue Feb 13 03:31:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGnSW-0001OL-3C
	for gcvg-git@gmane.org; Tue, 13 Feb 2007 03:31:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030373AbXBMCbw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Feb 2007 21:31:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965474AbXBMCbw
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Feb 2007 21:31:52 -0500
Received: from smtp.osdl.org ([65.172.181.24]:51656 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965475AbXBMCbw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Feb 2007 21:31:52 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l1D2VlhB003044
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 12 Feb 2007 18:31:48 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l1D2Vlkt019687;
	Mon, 12 Feb 2007 18:31:47 -0800
In-Reply-To: <11713297023551-git-send-email-julian@quantumfyre.co.uk>
X-Spam-Status: No, hits=-2.422 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.117__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39481>



On Tue, 13 Feb 2007, Julian Phillips wrote:
>
> Use the new stdin reflist passing mechanism for the call to
> fetch--tool parse-reflist, allowing passing of more than ~128K
> of reflist data.

This pretty much seems to assume that "echo" is a shell built-in.

Otherwise, the

	echo "$1"

part will still fall afoul of any exec limits.

Maybe that's aperfectly fine assumption. It's certainly true for bash (and 
probably _any_ shells that do any built-ins at all - echo is pretty damn 
basic ;)

		Linus

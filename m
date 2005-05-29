From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Adjust diff-helper to diff-tree -v -z changes.
Date: Sun, 29 May 2005 11:31:05 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505291129520.10545@ppc970.osdl.org>
References: <42971EB4.2050403@oberhumer.com> <Pine.LNX.4.58.0505271013260.17402@ppc970.osdl.org>
 <Pine.LNX.4.58.0505271024280.17402@ppc970.osdl.org> <7vfyw8zg1w.fsf@assigned-by-dhcp.cox.net>
 <7vvf54xael.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 29 20:28:35 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DcSVF-0008UK-9s
	for gcvg-git@gmane.org; Sun, 29 May 2005 20:27:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261386AbVE2S3J (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 May 2005 14:29:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261388AbVE2S3J
	(ORCPT <rfc822;git-outgoing>); Sun, 29 May 2005 14:29:09 -0400
Received: from fire.osdl.org ([65.172.181.4]:36749 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261386AbVE2S3G (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 29 May 2005 14:29:06 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j4TIT0jA015902
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 29 May 2005 11:29:01 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j4TIT0U7026826;
	Sun, 29 May 2005 11:29:00 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vvf54xael.fsf_-_@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Fri, 27 May 2005, Junio C Hamano wrote:
>
> The latest change to diff-tree -z output adds an extra line
> termination after non diff-raw material (the header and the
> commit message).  To compensate for this change, stop adding the
> output termination of our own.  "diff-tree -v -z" piped to
> "diff-helper -z" would give different result from "diff-tree -v"
> piped to "diff-helper" without this change.

I think this is really a bug in your "read_line()" interface.

You should include the terminating character in the line count.

This also fixes and simplifies "EOF" handling.

		Linus

From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Make sure diff-helper can tell rename/copy in the new
 diff-raw format.
Date: Mon, 23 May 2005 12:16:02 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505231210420.2307@ppc970.osdl.org>
References: <7vfywe769d.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.58.0505230736180.2307@ppc970.osdl.org> <7vwtpp3hsa.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.58.0505231156210.2307@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 23 21:13:31 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DaILx-0003of-Fo
	for gcvg-git@gmane.org; Mon, 23 May 2005 21:12:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261939AbVEWTOG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 May 2005 15:14:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261938AbVEWTOG
	(ORCPT <rfc822;git-outgoing>); Mon, 23 May 2005 15:14:06 -0400
Received: from fire.osdl.org ([65.172.181.4]:13722 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261939AbVEWTOC (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 May 2005 15:14:02 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j4NJDvjA009999
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 23 May 2005 12:13:58 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j4NJDuf7014041;
	Mon, 23 May 2005 12:13:57 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <Pine.LNX.4.58.0505231156210.2307@ppc970.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Mon, 23 May 2005, Linus Torvalds wrote:
> 
> because having it there makes it just easier to parse, and means that we 
> can add "reasons" later without having to worry about ambiguities with 
> filenames.

Btw, putting the "what happened" into the fixed-format stuff before the
filenames allows you to have more thana fixed number of filenames even in
the machine-readable format. For example, it would allow the
machine-readable format to have just a single NUL character at the end of
the line for the "modified" case, since now it's unambigious where the
line ends (thanks to the fact that "M" always has only one file).

Similarly, it allows us to later add a "combine" reason (take two files, 
combine them into a third), which needs three filenames. That would 
becomes very messy if the "reason" part is after the filenames, because it 
gets easily ambigious.

		Linus

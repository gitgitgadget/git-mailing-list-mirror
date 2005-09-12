From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: hmm, can't we give the "root" a parent?
Date: Mon, 12 Sep 2005 13:21:13 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0509121316030.3266@g5.osdl.org>
References: <20050912181101.GA22221@vrfy.org> <Pine.LNX.4.58.0509121123280.3242@g5.osdl.org>
 <20050912195947.GA28502@vrfy.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Sep 12 22:24:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EEuoR-0007ch-FD
	for gcvg-git@gmane.org; Mon, 12 Sep 2005 22:21:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932192AbVILUVV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Sep 2005 16:21:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932214AbVILUVU
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Sep 2005 16:21:20 -0400
Received: from smtp.osdl.org ([65.172.181.4]:17359 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932205AbVILUVT (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Sep 2005 16:21:19 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j8CKLIBo017234
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 12 Sep 2005 13:21:18 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j8CKLDw9016870;
	Mon, 12 Sep 2005 13:21:15 -0700
To: Kay Sievers <kay.sievers@vrfy.org>
In-Reply-To: <20050912195947.GA28502@vrfy.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.115 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8422>



On Mon, 12 Sep 2005, Kay Sievers wrote:
>
> And good to know about that, need to fix the "parent" link in gitweb to
> respect grafts.

Note that the simplest way to do this is to try to use "git-rev-list" as 
much as possible. The "--parents" flag makes the output have the parents 
(automatically _including_ any grafts) on the line that contains the 
commit ID.

That's especially true of any tools that use git-rev-list anyway for other
reasons. Eg "gitk" could parse the parent stuff this way, and didn't need
to know about the info/grafts file at all. I suspect the same should be
true of gitweb.

(So instead of trying to parse the parent info from the header of the 
commit, just do "git-rev-list --pretty --parents" and parse that).

		Linus

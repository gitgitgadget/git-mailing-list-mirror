From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Modify git-rev-list ... in merge order [ repost with
 bug fixes ]
Date: Sun, 5 Jun 2005 17:44:56 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0506051741190.1876@ppc970.osdl.org>
References: <20050605134733.3123.qmail@blackcubes.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, jon.seymour@gmail.com
X-From: git-owner@vger.kernel.org Mon Jun 06 02:40:05 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Df5eS-0008TA-VC
	for gcvg-git@gmane.org; Mon, 06 Jun 2005 02:39:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261152AbVFFAnA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Jun 2005 20:43:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261154AbVFFAnA
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Jun 2005 20:43:00 -0400
Received: from fire.osdl.org ([65.172.181.4]:60334 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261152AbVFFAm6 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 5 Jun 2005 20:42:58 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j560gqjA002676
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 5 Jun 2005 17:42:52 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j560gp92031431;
	Sun, 5 Jun 2005 17:42:51 -0700
To: jon@blackcubes.dyndns.org
In-Reply-To: <20050605134733.3123.qmail@blackcubes.dyndns.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Sun, 5 Jun 2005 jon@blackcubes.dyndns.org wrote:
>  
> -static void show_commit(struct commit *commit)
> +static int show_commit(struct commit *commit)

Ick. You've mixed "show_commit()" to be three totally independent things
 - deciding whether to show at all
 - showing the commit in traditional format
 - showing the commit tree in the new "break" format

I really hate functions that do totally unrelated things, and I'm so much 
happier with the new show_commit() than the old "everything in one big 
function" thing, that I'm unhappy about mixing the thing up again.

Please leave show_commit() to just show the commit, and make the other 
decisions be independent of that.

		Linus

From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 3/3] diff --stat: sometimes use non-linear scaling.
Date: Wed, 27 Sep 2006 08:12:49 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0609270810470.3952@g5.osdl.org>
References: <7vfyeejakq.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Jan Engelhardt <jengelh@linux01.gwdg.de>,
	Adrian Bunk <bunk@stusta.de>
X-From: git-owner@vger.kernel.org Wed Sep 27 17:16:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSb8y-0003dZ-KR
	for gcvg-git@gmane.org; Wed, 27 Sep 2006 17:16:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964921AbWI0PQO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Sep 2006 11:16:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964926AbWI0PQO
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Sep 2006 11:16:14 -0400
Received: from smtp.osdl.org ([65.172.181.4]:6881 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964921AbWI0PQN (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Sep 2006 11:16:13 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k8RFCpnW005297
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 27 Sep 2006 08:12:51 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k8RFCnlv028880;
	Wed, 27 Sep 2006 08:12:50 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vfyeejakq.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-0.968 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.94__
X-MIMEDefang-Filter: osdl$Revision: 1.154 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27908>



On Tue, 26 Sep 2006, Junio C Hamano wrote:
>
> When some files have big changes and others are touched only
> slightly, diffstat graph did not show differences among smaller
> changes that well.  This changes the graph scaling to non-linear
> algorithm in such a case.

Ok, this is just _strange_.

> while with this, it shows:
> 
>  .gitignore                       |    1
>  Documentation/git-tar-tree.txt   |    3 +++++++++

No _way_ is it correct to show more than three characters if there were 
three lines of changes.

I think "nonlinear" is fine, but this is something that is "superlinear" 
in small changes, and then sublinear in bigger ones (and then apparently 
totally wrong for one-line changes).

It should at least never be superlinear, I believe.

		Linus

From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: hmm, can't we give the "root" a parent?
Date: Mon, 12 Sep 2005 11:26:24 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0509121123280.3242@g5.osdl.org>
References: <20050912181101.GA22221@vrfy.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Sep 12 20:28:58 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EEt0k-00086i-Cl
	for gcvg-git@gmane.org; Mon, 12 Sep 2005 20:26:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932128AbVILS0c (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Sep 2005 14:26:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932130AbVILS0c
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Sep 2005 14:26:32 -0400
Received: from smtp.osdl.org ([65.172.181.4]:41635 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932128AbVILS0b (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Sep 2005 14:26:31 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j8CIQTBo008174
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 12 Sep 2005 11:26:29 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j8CIQOLl009813;
	Mon, 12 Sep 2005 11:26:27 -0700
To: Kay Sievers <kay.sievers@vrfy.org>
In-Reply-To: <20050912181101.GA22221@vrfy.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.115 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8413>



On Mon, 12 Sep 2005, Kay Sievers wrote:
>
> Can't we teach the git tools that a "root commit" (one without a any
> parent) is not visible as a "root", if let's say:
>   .git/parents/<root-commit-id> -> <fake-parent-id>
> 
> does connect a "fake" parent to the "root"? This way we could add any
> older Linux history to the current tree. Combined with "alternates" it
> could live in a complete different repository too.

Ehh.. That's exactly what "grafting" is about.

So just do

	echo "<root-id> <grafted-parent-id>" >> .git/info/grafts

and it should all work.

Of course, anything that parses the commits by hand won't see it, but all 
the regular tools hopefully do.

		Linus

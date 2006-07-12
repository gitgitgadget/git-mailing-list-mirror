From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Sharing repositories later on
Date: Wed, 12 Jul 2006 08:47:13 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0607120843570.5623@g5.osdl.org>
References: <20060712132800.GA7328@harddisk-recovery.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 12 17:47:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G0gvp-0003oM-1D
	for gcvg-git@gmane.org; Wed, 12 Jul 2006 17:47:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751421AbWGLPrS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 12 Jul 2006 11:47:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751422AbWGLPrS
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Jul 2006 11:47:18 -0400
Received: from smtp.osdl.org ([65.172.181.4]:49126 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751421AbWGLPrR (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 12 Jul 2006 11:47:17 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k6CFlEnW020712
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 12 Jul 2006 08:47:14 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k6CFlDUR012084;
	Wed, 12 Jul 2006 08:47:13 -0700
To: Erik Mouw <erik@harddisk-recovery.com>
In-Reply-To: <20060712132800.GA7328@harddisk-recovery.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.85__
X-MIMEDefang-Filter: osdl$Revision: 1.140 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23786>



On Wed, 12 Jul 2006, Erik Mouw wrote:
> 
> I just learned out about "git clone -s" to share objects between
> repositories. How do I use that with already existing repositories?

Do

	echo "/source/git/project/.git/objects/" > .git/objects/info/alternates

and then follow it up with

	git repack -a -d -l

where the "-l" means that it will only put _local_ objects in the 
pack-file (strictly speaking, it will put any loose objects from the 
alternate tree too, so you'll have a fully packed archive, but it won't 
duplicate objects that are already packed in the alternate tree).

		Linus

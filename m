From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [BUG] gitk fails with argument that is both existing directory
 and branch name
Date: Tue, 3 Jul 2007 15:17:51 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0707031514160.9434@woody.linux-foundation.org>
References: <20070703202301.GA24071@informatik.uni-freiburg.de>
 <Pine.LNX.4.64.0707032248570.4071@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Uwe Kleine-K?nig <ukleinek@informatik.uni-freiburg.de>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jul 04 00:18:24 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5qhN-00046e-W1
	for gcvg-git@gmane.org; Wed, 04 Jul 2007 00:18:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756887AbXGCWSO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Jul 2007 18:18:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756761AbXGCWSO
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jul 2007 18:18:14 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:38321 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756136AbXGCWSO (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Jul 2007 18:18:14 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l63MHvQr031596
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 3 Jul 2007 15:17:58 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l63MHpvK019362;
	Tue, 3 Jul 2007 15:17:52 -0700
In-Reply-To: <Pine.LNX.4.64.0707032248570.4071@racer.site>
X-Spam-Status: No, hits=-3.133 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51544>



On Tue, 3 Jul 2007, Johannes Schindelin wrote:
> 
> Umm. Why don't you just use gitk linus/master..fixes? This is how we teach 
> people to use rev-list anyway.

No, Uwe is right. There's a bug somewhere.

This _should_ work:

	# create a fake 'gitk' branch if you don't have one already
	git branch gitk master

	# This should look at the 'gitk' branch
	gitk gitk --

but it doesn't. It just hangs for me.

It seems to be some fairly recent gitk bug, too, because I'm pretty sure 
it _used_ to work.

I checked, and "git rev-list" works fine:

	git rev-list --default HEAD gitk

fails correctly with

	fatal: ambiguous argument 'gitk': both revision and filename
	Use '--' to separate filenames from revisions

and the way to get it to work as a branch-name is to do

	git rev-list --default HEAD gitk --

which works fine.

			Linus

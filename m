From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Some git mv questions
Date: Tue, 16 Oct 2007 10:34:01 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0710161030430.6887@woody.linux-foundation.org>
References: <200710161733.49185.wielemak@science.uva.nl>
 <8c5c35580710160905v69787856m7ed11b037c1adef1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Jan Wielemaker <wielemak@science.uva.nl>,
	git list <git@vger.kernel.org>
To: Lars Hjemli <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 16 19:35:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhqK3-0007JP-KQ
	for gcvg-git-2@gmane.org; Tue, 16 Oct 2007 19:35:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760363AbXJPRfF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2007 13:35:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760397AbXJPRfF
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 13:35:05 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:45928 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760363AbXJPRfD (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Oct 2007 13:35:03 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9GHY2IE015101
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 16 Oct 2007 10:34:03 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9GHY1kt007553;
	Tue, 16 Oct 2007 10:34:01 -0700
In-Reply-To: <8c5c35580710160905v69787856m7ed11b037c1adef1@mail.gmail.com>
X-Spam-Status: No, hits=-2.717 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61230>



On Tue, 16 Oct 2007, Lars Hjemli wrote:

> On 10/16/07, Jan Wielemaker <wielemak@science.uva.nl> wrote:
> >         * On a somewhat bigger test I moved a large directory using
> >         "git mv dir newdir" (where newdir is an existing directory).
> >         Now "git status" gives a lot of new and deleted files!?
> 
> You could try to adjust diff.renameLimit in .git/config

Yes. The default rename limit I did has turned out to be a disaster. It's 
quite common to have more than a 100x100 matrix of deleted files.

For people with any kind of beefy hardware, I'd just suggest doing a

	git config --global diff.renamelimit 0

which disables the rename limiting entirely.

There's a related (embarrassing) problem, namely that I think that the 
current released versions (1.5.3.3 and 1.5.3.4) don't honor the 
renamelimit configuration for merging, so if you do merges across renames 
with changes to the renamed files, you need to use either an older git 
that didn't have the rename limit at all (nor any of the speed-ups) or you 
need to use current git from the 'master' branch.

		Linus

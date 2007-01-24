From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Commands requiring a work tree must not run in GIT_DIR
Date: Wed, 24 Jan 2007 14:51:38 -0800
Message-ID: <7v7ivcf37p.fsf@assigned-by-dhcp.cox.net>
References: <87r6trsu7n.wl@mail2.atmark-techno.com>
	<7vwt3jjywc.fsf@assigned-by-dhcp.cox.net>
	<45B07875.9030506@fs.ei.tum.de>
	<81b0412b0701182357l3a6d44fel58da50c7895fb6b4@mail.gmail.com>
	<45B0C7E6.4020509@op5.se>
	<1169214414.18684.25.camel@localhost.localdomain>
	<Pine.LNX.4.63.0701191600020.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vtzymhma2.fsf@assigned-by-dhcp.cox.net>
	<878xfuuhco.wl@mail2.atmark-techno.com>
	<Pine.LNX.4.63.0701231312170.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vodoohcol.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0701241508510.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jan 24 23:51:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H9qxz-0006Ok-Fh
	for gcvg-git@gmane.org; Wed, 24 Jan 2007 23:51:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932832AbXAXWvk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 24 Jan 2007 17:51:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932833AbXAXWvk
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Jan 2007 17:51:40 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:61083 "EHLO
	fed1rmmtao03.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932832AbXAXWvj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jan 2007 17:51:39 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070124225139.VOUV29122.fed1rmmtao03.cox.net@fed1rmimpo02.cox.net>;
          Wed, 24 Jan 2007 17:51:39 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id FArx1W00D1kojtg0000000; Wed, 24 Jan 2007 17:51:57 -0500
In-Reply-To: <Pine.LNX.4.63.0701241508510.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Wed, 24 Jan 2007 15:14:54 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37687>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> I think "require_work_tree" reflects what we are trying to do
>> much better than NOT_BARE.  So maybe we should rename NOT_BARE
>> to REQUIRE_WORK_TREE.
>
> Hm. Might make sense.
>
> But there is a subtle trap here: if a repo is not bare, it does have a 
> work tree. But what we want here actually is NOT_INSIDE_GIT_DIR:

I think we are saying the same thing: "require to be IN the
working tree" (hence not in ".git/objects", for example).

> It is perfectly sensible to run git-pull from inside the git dir, since it 
> has to cd to the top _anyway_.

I would not call it "perfectly sensible".  I never understood
why anybody would want to cd to .git/ in a repository with an
working tree while actually working on the files in the working
tree (e.g. doing merges and pulls and edits and commits) [*1*].
I would say it is in the "allowing it is cheap and harmless so
why not" category.

[*1*] But it's probably just me who almost always is in Emacs;
switching to a shell terminal and saying "cd .git && vi config"
is much more expensive than "^X^F .git/config").

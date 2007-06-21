From: Sam Vilain <sam@vilain.net>
Subject: Re: [PATCH] Let git-svnimport clean up SVK commit messages.
Date: Thu, 21 Jun 2007 18:01:01 +1200
Message-ID: <467A141D.1050502@vilain.net>
References: <1182392095394-git-send-email-dmo@roaringpenguin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Dave O'Neill <dmo@roaringpenguin.com>
X-From: git-owner@vger.kernel.org Thu Jun 21 08:01:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I1FjJ-0003Pc-5a
	for gcvg-git@gmane.org; Thu, 21 Jun 2007 08:01:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751793AbXFUGBM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Jun 2007 02:01:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751844AbXFUGBM
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Jun 2007 02:01:12 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:58016 "EHLO
	magnus.utsl.gen.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751611AbXFUGBL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jun 2007 02:01:11 -0400
Received: by magnus.utsl.gen.nz (Postfix, from userid 65534)
	id 08E8D13A4F8; Thu, 21 Jun 2007 18:01:08 +1200 (NZST)
Received: from [192.168.2.22] (leibniz.catalyst.net.nz [202.78.240.7])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by magnus.utsl.gen.nz (Postfix) with ESMTP id 78DD313A4EA;
	Thu, 21 Jun 2007 18:01:03 +1200 (NZST)
User-Agent: Thunderbird 1.5.0.10 (X11/20070307)
In-Reply-To: <1182392095394-git-send-email-dmo@roaringpenguin.com>
X-Enigmail-Version: 0.94.2.0
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on 
	mail.magnus.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=5.0 tests=ALL_TRUSTED autolearn=failed 
	version=3.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50596>

Dave O'Neill wrote:
> SVK likes to begin all commit messages with a line of the format:
>    r12345@hostname: user | YYYY-MM-DD HH:MM:SS -ZZZZ
> which makes the import desperately ugly in git.  This adds a -k option to move
> this extra SVK commit line to the end of the commit message, rather than
> keeping it at the beginning.

This is a good idea, of course if somebody didn't specify the magic -I
switch to their 'svk sm' incantation then there will be multiple changes
listed in a single revision

some examples

http://dev.catalystframework.org/svnweb/Catalyst/revision/?rev=6477
svn log -r 7190:7190 http://svn.pugscode.org/pugs

There was also a pretty nasty bug in SVK which pushed huge commitlogs
with no changes

see for example

http://utsl.gen.nz/gitweb/?p=pugs;a=commit;h=817b73f
(or:
svn log -r 14734:14734 http://svn.pugscode.org/pugs
svn diff -r 14733:14734 http://svn.pugscode.org/pugs
)

That occurred often enough that it might even be worth detecting and
dealing with specially.  ie, if multiple SVK changesets are seen in a
commit with no changes, mark it as likely bogus.

Yeah, I'm not sure what to say about all this other than "lolsvn".

Sam.

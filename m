From: Sam Vilain <sam@vilain.net>
Subject: Re: git-svn: pulling from local mirror but committing via svn+ssh
Date: Sat, 22 Dec 2007 22:16:17 +1300
Message-ID: <476CD5E1.9020204@vilain.net>
References: <8bd0f97a0712200821j778c12a9g9d42bf02482d953c@mail.gmail.com> <20071222043528.GB18812@soma>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Mike Frysinger <vapier.adi@gmail.com>, git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sat Dec 22 10:16:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J60Sy-0001BK-I3
	for gcvg-git-2@gmane.org; Sat, 22 Dec 2007 10:16:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752099AbXLVJP5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Dec 2007 04:15:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751494AbXLVJP4
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Dec 2007 04:15:56 -0500
Received: from watts.utsl.gen.nz ([202.78.240.73]:42765 "EHLO
	musashi.utsl.gen.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751430AbXLVJPy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Dec 2007 04:15:54 -0500
Received: by musashi.utsl.gen.nz (Postfix, from userid 65534)
	id 881C62064B2; Sat, 22 Dec 2007 22:15:52 +1300 (NZDT)
Received: from [192.168.69.104] (203-97-235-49.cable.telstraclear.net [203.97.235.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by musashi.utsl.gen.nz (Postfix) with ESMTP id DF64121D027;
	Sat, 22 Dec 2007 22:15:48 +1300 (NZDT)
User-Agent: Thunderbird 2.0.0.6 (X11/20071022)
In-Reply-To: <20071222043528.GB18812@soma>
X-Enigmail-Version: 0.95.0
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on 
	mail.musashi.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=0.4 required=5.0 tests=SPF_HELO_FAIL autolearn=no 
	version=3.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69130>

Eric Wong wrote:
>> i have local (fast) mirrors of the svn trees i use, so i normally keep
>> everything pointing at those.  when i need to commit, i use `svn
>> switch --relocate ...` to flip to the svn+ssh master, and then flop
>> back to the local mirror.  it actually works out nicely.
> Can useSvmProps handle this?  I honestly forgot how that stuff
> was supposed to work with SVK/svn-mirror.

It's precisely this use case.  If you are syncing with SVN::Mirror, part
of SVK, or via svnsync, these tools leave breadcrumbs as svn properties
that point to where the repository was copied from.  So, in your commit
log the message will be the URL of the immediately[*] upstream
repository.  SVN didn't ever really support clone per se, what did you
use to copy the repository?

One thing that isn't documented to my knowledge is that you can use 'git
commit --amend' to alter the URL in the 'git-svn-id:' in the commit
message of the top commit as a crude form of grafting.  If the master
repository changes URL or UUID that's probably what you'd have to do.
But in your case, you probably want to figure out which switches you're
missing.

Sam.

* - Usually these tools don't allow for more than one level of indirection

> 
> 
> Mike:
> 
> On the other hand, there's little point in keeping local mirrors around
> when using git-svn since git already does that for you :)
> 

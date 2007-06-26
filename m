From: Sam Vilain <sam@vilain.net>
Subject: Re: git for subversion users
Date: Tue, 26 Jun 2007 17:54:29 +1200
Message-ID: <4680AA15.6040501@vilain.net>
References: <e2a1d0aa0706251248j1b8da150xbe19826bec15eed6@mail.gmail.com> <46809733.2060200@vilain.net> <4680A341.5000208@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Steven Grimm <koreth@midwinter.com>
X-From: git-owner@vger.kernel.org Tue Jun 26 07:54:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I340i-0003lp-AS
	for gcvg-git@gmane.org; Tue, 26 Jun 2007 07:54:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755969AbXFZFym (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Jun 2007 01:54:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755786AbXFZFyl
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Jun 2007 01:54:41 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:36648 "EHLO
	magnus.utsl.gen.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755228AbXFZFyk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jun 2007 01:54:40 -0400
Received: by magnus.utsl.gen.nz (Postfix, from userid 65534)
	id 924C613A502; Tue, 26 Jun 2007 17:54:38 +1200 (NZST)
Received: from [192.168.2.22] (leibniz.catalyst.net.nz [202.78.240.7])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by magnus.utsl.gen.nz (Postfix) with ESMTP id ACBE513A4F8;
	Tue, 26 Jun 2007 17:54:31 +1200 (NZST)
User-Agent: Thunderbird 1.5.0.10 (X11/20070307)
In-Reply-To: <4680A341.5000208@midwinter.com>
X-Enigmail-Version: 0.94.2.0
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on 
	mail.magnus.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=5.0 tests=ALL_TRUSTED autolearn=failed 
	version=3.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50950>

Steven Grimm wrote:
> I will say, though, that the upcoming addition to git-svn to allow 
> merges to be directly committed to the svn repository will make some of 
> those kinds of scenarios a lot less brittle than they are now. It's 
> still a work in progress but it looks very promising so far. (Search the 
> list for "[PATCH] git-svn: allow dcommit to retain local merge 
> information" if you want to see what I'm talking about.)

Yes.  On that.  It would be nice if git-svn could also fake setting
remote merge properties, too.

Some beginnings at:

  http://git.catalyst.net.nz/gw?p=git.git;a=shortlog;h=svk-merge
  (pull from git://git.catalyst.net.nz/git.git#svk-merge)

What it needs to do;

  0. preserve the notion that commits tagged with "git-svn-id:" should
     not vary depending on who synced them.

  1. on commit, if we're committing a merge, make sure that the other
     parent has the same revision somewhere in the repo, and then set
     the "svk:merge" and "svnmerge-integrated" tags to accurately record
     which parent SVN revisions are used

  2. when fetching revisions, spot these tickets and set parents
     appropriately.  In the case of SVK, the merge tickets may
     correspond to revisions in (inaccessible) svk local depots.  It may
     be possible to infer these extra parents in some limited
     situations using the extra information svk puts in commit messages
     by default, but I doubt that is a useful endeavour!

I'll take a look at what you've been working on and see if that's not
what you're already trying...

Sam.

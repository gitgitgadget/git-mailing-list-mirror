From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git-svn -- out of memory
Date: Sun, 15 Feb 2009 16:38:35 -0800
Message-ID: <20090216003835.GA5687@untitled>
References: <1234608003.115771.3468.nullmailer@beryx.hq.kred>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Alfred M. Szmidt" <ams@gnu.org>
X-From: git-owner@vger.kernel.org Mon Feb 16 01:40:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYrWk-00074d-SX
	for gcvg-git-2@gmane.org; Mon, 16 Feb 2009 01:40:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756168AbZBPAii (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Feb 2009 19:38:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756164AbZBPAih
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Feb 2009 19:38:37 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:51851 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756158AbZBPAig (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Feb 2009 19:38:36 -0500
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id 007F81F794;
	Mon, 16 Feb 2009 00:38:35 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1234608003.115771.3468.nullmailer@beryx.hq.kred>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110103>

"Alfred M. Szmidt" <ams@gnu.org> wrote:
> Hi,
> 
> when doing a `git svn clone' on a subversion repository that contains
> a large file (>1GiB), `git svn' dies with the following:
> 
> ams@trillian:~$ git svn clone REPO -T trunk -b branches -t tags
> [...]
> fatal: Out of memory? mmap failed: Cannot allocate memory
> hash-object -w --stdin-paths: command returned error: 128
> 
> error closing pipe: Bad file descriptor at /usr/local/bin/libexec/git-core//git-svn line 0
> error closing pipe: Bad file descriptor at /usr/local/bin/libexec/git-core//git-svn line 0
> 
> Doing a `git repack' doesn't help either.  Anyone got a clue how to
> either solve, or work around this?
> 
> git version 1.6.1.3

Hi Alfred,

Core git requires objects to be able to fit into (virtual) memory.
Adding more swap space should solve the problem for you, but this is not
only a git-svn problem.

Fwiw, git-svn itself has always had a pretty strict "no slurping"
policy.

-- 
Eric Wong

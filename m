From: Andrew Cameron <andrew@worksmartlabs.com>
Subject: git checkout running very slowly (>12s)
Date: Wed, 15 Jun 2011 19:30:55 +0000 (UTC)
Message-ID: <loom.20110615T213016-856@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 15 21:35:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QWvrx-0007vV-4n
	for gcvg-git-2@lo.gmane.org; Wed, 15 Jun 2011 21:35:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754750Ab1FOTfK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jun 2011 15:35:10 -0400
Received: from lo.gmane.org ([80.91.229.12]:39308 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753756Ab1FOTfJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jun 2011 15:35:09 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1QWvrn-0007rG-PF
	for git@vger.kernel.org; Wed, 15 Jun 2011 21:35:08 +0200
Received: from rrcs-208-105-82-160.nyc.biz.rr.com ([208.105.82.160])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 15 Jun 2011 21:35:07 +0200
Received: from andrew by rrcs-208-105-82-160.nyc.biz.rr.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 15 Jun 2011 21:35:07 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 208.105.82.160 (Mozilla/5.0 (X11; Linux i686) AppleWebKit/534.30 (KHTML, like Gecko) Chrome/12.0.742.91 Safari/534.30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175846>

Some git operations (notably checkouts) are taking a very long time to execute.
Here is a shell session which illustrates the problem.

$ time git branch foo
git branch foo  0.01s user 0.00s system 77% cpu 0.016 total
$ time git checkout foo
Switched to branch 'foo'
git checkout foo  11.73s user 0.18s system 99% cpu 11.937 total
$ time git checkout master
Switched to branch 'master'
git checkout master  11.62s user 0.18s system 99% cpu 11.813 total
$ git count-objects -v
count: 953
size: 527012
in-pack: 153432
packs: 7
size-pack: 1986072
prune-packable: 0
garbage: 0

I tried doing a sparse checkout to eliminate approximately 40,000 files from the 
checkout, and furthermore doing git update-index --skip-worktree on a tree which 
contained about another 16,600 files, but neither had any noticeable effect on 
checkout times.

---
Andrew Cameron

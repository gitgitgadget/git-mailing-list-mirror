From: Marat Radchenko <marat@slonopotamus.org>
Subject: Re: [PATCH v2] hash binary sha1 into patch id
Date: Thu, 14 Oct 2010 00:19:21 -0700 (PDT)
Message-ID: <1287040761027-5633988.post@n2.nabble.com>
References: <20100813200031.GD2003@burratino> <20100813212331.GA24127@localhost> <20100813213726.GB2516@burratino> <20100813215801.GA24534@localhost> <20100815072043.GA368@localhost> <1284095850.1728.5.camel@n900.home.ru> <20100910081626.GA30507@localhost> <1286956002591-5629905.post@n2.nabble.com> <1286961452235-5630164.post@n2.nabble.com> <20101013211011.GA2558@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 14 09:19:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P6I67-0006PN-7N
	for gcvg-git-2@lo.gmane.org; Thu, 14 Oct 2010 09:19:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754803Ab0JNHTZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Oct 2010 03:19:25 -0400
Received: from kuber.nabble.com ([216.139.236.158]:52885 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753580Ab0JNHTZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Oct 2010 03:19:25 -0400
Received: from jim.nabble.com ([192.168.236.80])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <marat@slonopotamus.org>)
	id 1P6I5x-00056X-18
	for git@vger.kernel.org; Thu, 14 Oct 2010 00:19:21 -0700
In-Reply-To: <20101013211011.GA2558@localhost>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159026>


I'm running git-rev-list from git master in the form git rebase does:
git-rev-list --no-merges --cherry-pick --pretty=oneline --abbrev-commit
--abbrev=7 --reverse --left-right --topo-order FOO...BAR

New gprof output (I compiled without -O2 to prevent function inlining and
removed xecfg.flags = XDL_EMIT_FUNCNAMES):
http://git.661346.n2.nabble.com/file/n5633988/gprof_-p.txt gprof -p 
http://git.661346.n2.nabble.com/file/n5633988/gprof_-q.txt gprof -q 

This thing takes ~3 minutes of cpu time.

So, it takes ~3 minutes of cpu time and looks like all time is spent in
xdl_cleanup_records.

Repo info: 80GB, 200K revisions (~200 per working day), 500K files (15GB) in
master working copy, running git-rev-list to rebase ~5 commits over ~800
commits that happened upstream.
-- 
View this message in context: http://git.661346.n2.nabble.com/PATCH-hash-binary-sha1-into-patch-id-tp5419375p5633988.html
Sent from the git mailing list archive at Nabble.com.

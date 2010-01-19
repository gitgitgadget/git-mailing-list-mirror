From: Andreas Krey <a.krey@gmx.de>
Subject: Re: git-describe recognize modified files
Date: Tue, 19 Jan 2010 13:21:22 +0100
Message-ID: <20100119122122.GA28667@inner.home.ulmdo.de>
References: <829260.92036.qm@web45202.mail.sp1.yahoo.com> <alpine.DEB.1.00.1001191134130.3164@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: tzachi perelstein <tzachi_perelstein@yahoo.com>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jan 19 13:21:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXD5W-0005WT-5B
	for gcvg-git-2@lo.gmane.org; Tue, 19 Jan 2010 13:21:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752972Ab0ASMVd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jan 2010 07:21:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752856Ab0ASMVd
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Jan 2010 07:21:33 -0500
Received: from continuum.iocl.org ([213.146.114.200]:62611 "EHLO
	continuum.iocl.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752597Ab0ASMVc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jan 2010 07:21:32 -0500
Received: (from krey@localhost)
	by continuum.iocl.org (8.11.3/8.9.3) id o0JCLMB09733;
	Tue, 19 Jan 2010 13:21:22 +0100
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.1001191134130.3164@intel-tinevez-2-302>
User-Agent: Mutt/1.4.2.1i
X-message-flag: What did you expect to see here?
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137451>

On Tue, 19 Jan 2010 11:35:41 +0000, Johannes Schindelin wrote:
...
> > To solve this issue, in addition to git-describe, my do_version script
> > also run git-status, and if there are "modified:" files then it
> > concatenates the string "+dirty" to output of git-describe.
> 
> The problem is that this does not describe the exact version you used very 
> well.

I (and probably the original poster) don't care that much; for me the
important information is that the binary (or whatever) was not built
from the exact committed state. Thus the question is whether the
second two lines of

 BUILDINFO=git-`git describe --abbrev=16 --always HEAD 2>/dev/null`
 git update-index -q --refresh
 test -z "`git diff-index --name-only HEAD --`" || BUILDINFO="$BUILDINFO.dirty"

(after GIT-VERSION-GEN) are worth to be integrated into git-describe?

(And whether it should also say '.dirty'
 when there are untracked files present.
 Or either for submodules.)

Andreas

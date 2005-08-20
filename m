From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Re: [RFC] Stgit - patch history / add extra parents
Date: Sat, 20 Aug 2005 22:12:36 +0100
Message-ID: <1124572356.7512.21.camel@localhost.localdomain>
References: <20050818195753.GA9066@fanta> <tnx64u2p81k.fsf@arm.com>
	 <20050819194832.GA8562@fanta>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 20 23:14:18 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E6aeZ-00080i-0g
	for gcvg-git@gmane.org; Sat, 20 Aug 2005 23:13:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751224AbVHTVMj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 20 Aug 2005 17:12:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751232AbVHTVMj
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Aug 2005 17:12:39 -0400
Received: from mta07-winn.ispmail.ntl.com ([81.103.221.47]:50229 "EHLO
	mta07-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S1751224AbVHTVMi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Aug 2005 17:12:38 -0400
Received: from aamta09-winn.ispmail.ntl.com ([81.103.221.35])
          by mta07-winn.ispmail.ntl.com with ESMTP
          id <20050820211237.MRRS21883.mta07-winn.ispmail.ntl.com@aamta09-winn.ispmail.ntl.com>;
          Sat, 20 Aug 2005 22:12:37 +0100
Received: from cpc1-cmbg5-3-0-cust219.cmbg.cable.ntl.com ([81.104.192.219])
          by aamta09-winn.ispmail.ntl.com with ESMTP
          id <20050820211237.OIUK23288.aamta09-winn.ispmail.ntl.com@cpc1-cmbg5-3-0-cust219.cmbg.cable.ntl.com>;
          Sat, 20 Aug 2005 22:12:37 +0100
To: Jan Veldeman <jan.veldeman@gmail.com>
In-Reply-To: <20050819194832.GA8562@fanta>
X-Mailer: Evolution 2.2.1.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Fri, 2005-08-19 at 21:48 +0200, Jan Veldeman wrote:
> I've quickly reread the threads about stg commit. Am I right to assume that
> _all_ history was being recorded? Because this is not what I want. The
> person controlling the archive should specify when to record the history.

True, I was talking about the full history, but I don't find the idea
much different. There was another mail on this issue -
http://article.gmane.org/gmane.comp.version-control.git/5191

> So for example, you only tag (freeze) the history when exporting the
> patches.  When an error is being reported on that version, it's easy to view
> it and also view the progress that was already been made on those patches.

I agree that it is a useful feature to be able to individually tag the
patches. The problem is how to do this best. Your approach looks to me
like it's not following the GIT DAG structure recommendation. Maybe the
GIT designers could further comment on this but a commit object with
multiple parents should be a result of a merge operation. A commit with
a single parent should represent a transition of the tree from one state
to another. With the freeze command you proposed, a commit with multiple
parents is no longer a result of a merge operation, but just a
convenience for tracking the patch history with gitk.

I tried your patch and test script but, if you try to reorder the
patches, the DAG structure become quite hard to understand and that's
only for a small set of frozen states.

I think the best approach would be to keep a list of tags for each
patch. They won't be browsable with gitk but the DAG structure would be
clean. We might get another tool like gquilt to be able to show all the
saved states of a patch.

Sorry for not including your patch but, while I agree with the general
idea of frozen patch states, I disagree with its implementation.

-- 
Catalin

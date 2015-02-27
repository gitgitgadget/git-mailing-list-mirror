From: Lasse Kliemann <lasse@lassekliemann.de>
Subject: Easy Non-Fast-Forward Pushes
Date: Fri, 27 Feb 2015 16:20:19 +0000 (UTC)
Message-ID: <loom.20150227T170215-199@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 27 17:25:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YRNj5-0005sb-AM
	for gcvg-git-2@plane.gmane.org; Fri, 27 Feb 2015 17:25:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752247AbbB0QZI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Feb 2015 11:25:08 -0500
Received: from plane.gmane.org ([80.91.229.3]:48935 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751605AbbB0QZH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Feb 2015 11:25:07 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1YRNiq-0005k0-Nb
	for git@vger.kernel.org; Fri, 27 Feb 2015 17:25:04 +0100
Received: from dslb-188-108-213-160.188.108.pools.vodafone-ip.de ([188.108.213.160])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 27 Feb 2015 17:25:04 +0100
Received: from lasse by dslb-188-108-213-160.188.108.pools.vodafone-ip.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 27 Feb 2015 17:25:04 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 188.108.213.160 (Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:35.0) Gecko/20100101 Firefox/35.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264500>

As far as I understand, a push will always modify (or add) a ref in the
remote repository. When pushing to branch B, then the ref pointing to the
last commit in this branch will be moved, provided that this can be done in
a fast-forward way. Otherwise the push will fail.

The following options exist:

(1) force the push
(2) fetch, merge, then push
(3) push to a different branch

I don't want (1), for obvious reasons.

Option (2) implies that a particular person has to do the merge, namely the
person for whom the push is failing, or in other words: the person
unfortunate enough not being the first to push. (This reminds me of
Subversion: whoever tries to commit after someone else has committed will
have the burden of an update and possible merge.)

Option (3) allows others to recognize the situation, and anyone with
repository access can do a merge. This is a good thing. However, I am
confused as to what branch name should be used for this. In Mercurial, we
would say that a new "head" is created, and anyone can recognize this by
using "hg heads" and do a merge if he feels competent enough. (A "head" in
Mercurial is a revision without children.) Can something similar be done in
Git? I'd like to provide my co-workers with a command which they can always
use to push their changes to a central repository in order that I can see
what has happened and do merges accordingly. In Mercurial, such a command
would simply be "hg commit && hg push -f". Then I can use "hg heads" to see
if any new heads have grown, and if so, do merges. Upon their next pull,
these merges would manifest themselves in the repositories of my co-workers,
and everything will be fine for them. So, im looking for the equivalent of
that workflow in Git. Thanks a lot!

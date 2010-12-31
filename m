From: Seth Robertson <in-gitvger@baka.org>
Subject: Re: how to update a submodule?
Date: Fri, 31 Dec 2010 18:42:01 -0500
Message-ID: <201012312342.oBVNg1lx021930@no.baka.org>
References: <20101231222438.GA28199@cs-wsok.swansea.ac.uk>
Cc: git@vger.kernel.org
To: Oliver Kullmann <O.Kullmann@swansea.ac.uk>
X-From: git-owner@vger.kernel.org Sat Jan 01 00:49:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PYoiq-0003iR-O9
	for gcvg-git-2@lo.gmane.org; Sat, 01 Jan 2011 00:49:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754350Ab0LaXmN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Dec 2010 18:42:13 -0500
Received: from tsutomu.baka.org ([66.114.72.182]:46339 "EHLO tsutomu.baka.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754304Ab0LaXmM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Dec 2010 18:42:12 -0500
Received: from no.baka.org (no.baka.org [IPv6:2001:470:88bb::2])
	by tsutomu.baka.org (8.14.4/8.14.4) with ESMTP id oBVNg2Gc001177
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 31 Dec 2010 18:42:02 -0500
Received: from no.baka.org (localhost [127.0.0.1])
	by no.baka.org (8.14.4/8.14.0) with ESMTP id oBVNg1lx021930;
	Fri, 31 Dec 2010 18:42:01 -0500
In-reply-to: <20101231222438.GA28199@cs-wsok.swansea.ac.uk>
Comments: In reply to a message from "Oliver Kullmann <O.Kullmann@swansea.ac.uk>" dated "Fri, 31 Dec 2010 22:24:38 +0000."
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164399>


In message <20101231222438.GA28199@cs-wsok.swansea.ac.uk>, Oliver Kullmann writ
es:

    it would be very helpful if somebody could tell me the
    supposed workflow how to update a submodule (I'm using version
    1.7.3.2; the man-page doesn't say much about it).

https://git.wiki.kernel.org/index.php/GitSubmoduleTutorial

--------------------------------------------------
cd submodule_path
git checkout <branchname>
git pull
cd .. # or otherwise get to the superproject

git add submodule_path
git commit -m "Updated submodule to latest <branchname>"
git submodule update
--------------------------------------------------

This (untested) code obviously only works for a single repository.  If
you want to do it for all repositories, you need something more like
the untested:

--------------------------------------------------
git submodule foreach git checkout <branchname>
git submodule foreach git pull
git add -a -m "Updated all submodules to latest <branchname>"
git submodule update
--------------------------------------------------

If you find yourself doing this continuously, and doing it for all of
your submodules, you may way to use gitslave instead of submodules
which keeps the branches checked out all of the time so all you need to
do is `gits pull`.  This may be better, or worse, for you workflow.

gitslave (http://gitslave.sf.net) is useful when you control and
develop on the subprojects at more of less the same time as the
superproject, and furthermore when you typically want to tag, branch,
push, pull, etc all repositories at the same time.

git-submodule is better when you do not control the subprojects or
more specifically wish to fix the subproject at a specific revision
even as the subproject changes

					-Seth Robertson

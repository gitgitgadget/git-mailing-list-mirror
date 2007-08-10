From: Brian Hetro <whee@smaertness.net>
Subject: Bug in gitk: can't unset "idinlist(...) ..."
Date: Fri, 10 Aug 2007 11:41:08 -0400
Message-ID: <20070810154108.GA779@ruiner>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 10 17:41:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJWcK-00039d-8Q
	for gcvg-git@gmane.org; Fri, 10 Aug 2007 17:41:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936281AbXHJPl3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 10 Aug 2007 11:41:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936282AbXHJPl2
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Aug 2007 11:41:28 -0400
Received: from ag-out-0708.google.com ([72.14.246.248]:60728 "EHLO
	ag-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760490AbXHJPl0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Aug 2007 11:41:26 -0400
Received: by ag-out-0708.google.com with SMTP id 35so1102758aga
        for <git@vger.kernel.org>; Fri, 10 Aug 2007 08:41:22 -0700 (PDT)
Received: by 10.100.191.5 with SMTP id o5mr3245925anf.1186760482183;
        Fri, 10 Aug 2007 08:41:22 -0700 (PDT)
Received: from smaertness.net ( [66.67.48.108])
        by mx.google.com with ESMTPS id c20sm4529393ana.2007.08.10.08.41.09
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 10 Aug 2007 08:41:10 -0700 (PDT)
Received: by smaertness.net (nbSMTP-1.00) for uid 1000
	(using TLSv1/SSLv3 with cipher DES-CBC3-SHA (168/168 bits))
	whee@smaertness.net; Fri, 10 Aug 2007 11:41:10 -0400 (EDT)
Content-Disposition: inline
X-PGP-Key: http://whee.smaertness.net/pubkey.asc
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55546>

Hi,
I have a problem with gitk not being able to show one of my
repositories (git version 1.5.3.rc4.41.g7efe).  I get this error while
gitk starts:

can't unset "idinlist(f1d795add789ec43d3ccf1d35f3c39fb464f6e72)": no
such element in array
can't unset "idinlist(f1d795add789ec43d3ccf1d35f3c39fb464f6e72)": no
such element in array
    while executing
"unset idinlist($id)"
    (procedure "layouttail" line 11)
    invoked from within
"layouttail"
    (procedure "layoutmore" line 35)
    invoked from within
"layoutmore $tlimit $allread"
    (procedure "chewcommits" line 9)
    invoked from within
"chewcommits 1"
    ("eval" body line 1)
    invoked from within
"eval $script"
    (procedure "dorunq" line 9)
    invoked from within
"dorunq"
    ("after" script)

The repository log is partially displayed.  gitk does work in git
version 1.5.2.4, and qgit and giggle also work.  git-fsck --full
--strict indicates no problems.

I performed a bisect and commit
1ed84157a21a3e868228b15588e4aadfbe5a030b appears to be the culprit
(Revert 88494423 (removal of duplicate parents in the output
codepath)).

Brian

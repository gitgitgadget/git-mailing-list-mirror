From: Pete Wyckoff <pw@padd.com>
Subject: smudge/clean filter needs filename
Date: Sat, 18 Dec 2010 17:38:22 -0500
Message-ID: <20101218223822.GA18902@arf.padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 18 23:38:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PU5QD-0005NX-Lg
	for gcvg-git-2@lo.gmane.org; Sat, 18 Dec 2010 23:38:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752579Ab0LRWi2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Dec 2010 17:38:28 -0500
Received: from honk.padd.com ([74.3.171.149]:58878 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751658Ab0LRWi1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Dec 2010 17:38:27 -0500
Received: from arf.padd.com (pool-71-111-208-86.rlghnc.dsl-w.verizon.net [71.111.208.86])
	by honk.padd.com (Postfix) with ESMTPSA id 07F9D385;
	Sat, 18 Dec 2010 14:38:27 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id E928231A5C; Sat, 18 Dec 2010 17:38:22 -0500 (EST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163944>

I'm using git-p4 to import and work with upstream p4
repositories.  Some of the files are ktext, meaning they expect
expansion of $Id$ and similar identifiers.

Using the filter driver for this file, I can do the "clean" part
easily, but to calculate the "smudge" correctly, I need to know
the filename inside the filter driver.

E.g., inside file foo/Makefile, the clean line:

    # $File$

should be smudged into:

    # $File: //depot/project/foo/Makefile $

I know the //depot/project location from context in the commit
log message that git-p4 produces.  But I don't know the pathname
in the git repo that my smudge script is working on.

Would it make sense to pass that on the command line?  E.g.

    [filter "p4"]
    	clean  = git-p4smudge --clean %s
    	smudge = git-p4smudge --smudge %s

Or maybe put the path in an environment variable?

		-- Pete

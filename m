From: Kristian Amlie <kristian.amlie@trolltech.com>
Subject: Honoring a checked out gitattributes file
Date: Wed, 28 Jan 2009 16:25:37 +0100
Message-ID: <498078F1.20807@trolltech.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jan 28 16:27:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSCJs-0003y0-0T
	for gcvg-git-2@gmane.org; Wed, 28 Jan 2009 16:27:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751241AbZA1PZq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jan 2009 10:25:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751121AbZA1PZq
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Jan 2009 10:25:46 -0500
Received: from hoat.troll.no ([62.70.27.150]:46782 "EHLO hoat.troll.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751074AbZA1PZp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jan 2009 10:25:45 -0500
Received: from hoat.troll.no (tedur.troll.no [62.70.27.154])
	by hoat.troll.no (Postfix) with SMTP id D8D0420F5E
	for <git@vger.kernel.org>; Wed, 28 Jan 2009 16:25:37 +0100 (CET)
Received: from sx01.troll.no (sx01.troll.no [62.70.27.21])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hoat.troll.no (Postfix) with ESMTP id D140920F58
	for <git@vger.kernel.org>; Wed, 28 Jan 2009 16:25:37 +0100 (CET)
Received: from sx01.troll.no (localhost.localdomain [127.0.0.1])
	by sx01.troll.no (8.13.8/8.13.8) with ESMTP id n0SFPb4N020523
	for <git@vger.kernel.org>; Wed, 28 Jan 2009 16:25:37 +0100
Received: from [172.24.90.99] ( [172.24.90.99])
    by sx01.troll.no (Scalix SMTP Relay 11.4.1.11929)
    via ESMTP; Wed, 28 Jan 2009 16:25:37 +0100 (CET)
x-scalix-Hops: 1
User-Agent: Thunderbird 2.0.0.19 (X11/20090122)
X-Enigmail-Version: 0.95.7
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107542>

Hi!

We currently use msysGit in our company test farm to checkout the latest
development branch and do autotests. However, we have one problem:
Certain files require UNIX line endings, even though this is a Windows
system. For this we use .gitattributes.

However, if the .gitattributes file is also checked in to the branch, it
will not always be honored. I browsed the code a bit, and it seems to
happen whenever there is an existing .gitattributes file, but the
checkout adds new files to it. These new files will not get the correct
line endings (although I'm not sure if it happens *every* time, it could
depend on the order they are checked out).

I think this should be fairly straightforward to fix, by ensuring that
if there is a file called .gitattributes in the index of the current
directory, check it out first, before all the other files that may be
affected by it. I can produce a patch and testcase for it, but I wanted
to hear the opinions of some developers in case there is an obvious flaw
in my solution.

What do you think?

--
Kristian Amlie

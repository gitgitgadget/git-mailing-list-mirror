From: David Holmer <odinguru@gmail.com>
Subject: gitk bug: annotated tag displays as a lightweight tag when branch of the same name is on the same commit
Date: Wed, 5 May 2010 14:17:56 +0000 (UTC)
Message-ID: <loom.20100505T155543-396@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 05 16:25:13 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O9fXE-0005xo-KI
	for gcvg-git-2@lo.gmane.org; Wed, 05 May 2010 16:25:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759274Ab0EEOZG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 May 2010 10:25:06 -0400
Received: from lo.gmane.org ([80.91.229.12]:49188 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753854Ab0EEOZE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 May 2010 10:25:04 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1O9fX5-0005sn-BG
	for git@vger.kernel.org; Wed, 05 May 2010 16:25:03 +0200
Received: from pool-71-167-232-243.nycmny.east.verizon.net ([71.167.232.243])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 05 May 2010 16:25:03 +0200
Received: from odinguru by pool-71-167-232-243.nycmny.east.verizon.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 05 May 2010 16:25:03 +0200
X-Injected-Via-Gmane: http://gmane.org/
connect(): No such file or directory
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 71.167.232.243 (Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.9) Gecko/20100401 Ubuntu/9.10 (karmic) Firefox/3.5.9 GTB7.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146400>

I found an edge case bug in the display behavior of gitk. I encountered it while
working in a repository where we make branches with a name like "1.0.3" and
create an annotated tag "1.0.3" when everything is ready on that branch. In the
process of scripting some of this, I thought I was not creating the annotated
tags correctly because when I'd look at them in gitk, they were showing up as
lightweight tags. However I noticed that "git describe" was showing the tag name
correctly, and thus the issue was in gitk.

The bug can be simply reproduced by the following sequence of commands:

git init
touch test
git add test
git commit -m "commit message"
git tag -am "annotated tag message" master
gitk

The master tag is displayed in gitk pane as a lightweight tag rather than an
annotated tag:

Tag: master
Id:  5b0a763ec5791da4981f14ff5f6ef6384117945c

However if I move the master branch on to a new commit or rename it:

git branch -m renamed

Then the tag is correctly displayed by gitk as an annotated tag:

object 5b0a763ec5791da4981f14ff5f6ef6384117945c
type commit
tag master
tagger David Holmer <xxxxx@xxxxxxxxxxx> 1273068181 -0400

annotated tag message

Thank you,
David

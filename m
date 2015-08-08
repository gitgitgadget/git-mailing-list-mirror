From: Yojem <yojem@gmx.com>
Subject: [gitk] display error for angle brackets in diff
Date: Sat, 8 Aug 2015 05:33:35 +0000 (UTC)
Message-ID: <loom.20150808T073217-282@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 08 07:35:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZNwn9-0002Ng-RK
	for gcvg-git-2@plane.gmane.org; Sat, 08 Aug 2015 07:35:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752244AbbHHFfI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Aug 2015 01:35:08 -0400
Received: from plane.gmane.org ([80.91.229.3]:49150 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751791AbbHHFfH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Aug 2015 01:35:07 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1ZNwme-0001zI-7F
	for git@vger.kernel.org; Sat, 08 Aug 2015 07:35:05 +0200
Received: from cpe-173-174-96-53.austin.res.rr.com ([173.174.96.53])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 08 Aug 2015 07:35:04 +0200
Received: from yojem by cpe-173-174-96-53.austin.res.rr.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 08 Aug 2015 07:35:04 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 173.174.96.53 (Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:39.0) Gecko/20100101 Firefox/39.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275504>

I'm trying to report a bug that I've know about for a year and half. I first
tried to report it to this mailing list a year ago, but the message was
lost. Here's a post I made on reddit 6 months ago:
http://www.reddit.com/r/git/comments/2twvsz/please_help_me_report_this_gitk_bug_to_the_git/
 
The problem is that diffs with angle brackets are displayed incorrectly in gitk.
 
How to reproduce the bug:
 
Create a file with the following, and commit:
x < 1
y > 2
 
Modify it to this, and commit:
z < 1
w > 2
 
Then view the results with:
gitk --color-words
 
You will see:

    "Diff" shows bogus removal on 1st line and bogus addition on 2nd line.
    "Old version" cuts off at right angle bracket.
    "New Version" cuts off at left angle bracket.

I personally use a 2-line patch to fix this by disabling/breaking the
feature that does string comparisons for "  >" and "  <", but I know that's
not the correct fix, so I'm not including it in this post.

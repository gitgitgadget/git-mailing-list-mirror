From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Trouble with cat-file on tags
Date: Fri, 1 Apr 2016 11:26:41 +0200
Message-ID: <ndlesh$dj1$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 01 11:27:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1alvM4-0003AU-LU
	for gcvg-git-2@plane.gmane.org; Fri, 01 Apr 2016 11:27:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753728AbcDAJ0y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Apr 2016 05:26:54 -0400
Received: from plane.gmane.org ([80.91.229.3]:33077 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753671AbcDAJ0x (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Apr 2016 05:26:53 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1alvLr-00033S-Qc
	for git@vger.kernel.org; Fri, 01 Apr 2016 11:26:47 +0200
Received: from 131.228.216.133 ([131.228.216.133])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 01 Apr 2016 11:26:47 +0200
Received: from sschuberth by 131.228.216.133 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 01 Apr 2016 11:26:47 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 131.228.216.133
X-Mozilla-News-Host: news://news.gmane.org:119
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290512>

Hi,

I was trying to use cat-file to get the hash of a tag object (not the hash of the commit object the tag points to), and I'm running into some issues. At the example of a cloned gerry [1] repository:

---8<---
$ git tag test-tag

$ git tag -l
test-tag
v0.0.3
v0.0.4
v0.1.0
v0.1.1
v0.1.2

$ git cat-file tag refs/tags/test-tag
fatal: git cat-file refs/tags/test-tag: bad file
---8<---

So for a newly created local tag, cat-file does not seem to work. However:

---8<---
$ git cat-file tag refs/tags/v0.1.2
object 91b0d21eba039e5ba0a90104c9c485735576dcbf
type commit
tag v0.1.2
tagger Travis Truman <travis_truman@cable.comcast.com> 1452693317 -0500

Version 0.1.2
---8<---

For an existing tag, git-file suddenly *does* seem to work, although I'm puzzled why I'm getting info on the commit object here. I thought "cat-file tag" should explicitly make "cat-file" list information about the tag object itself, not about the commit object the tag points to.

Thoughts?

[1] https://github.com/trumant/gerry

Regards,
Sebastian

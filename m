From: Ed Avis <eda@waniasset.com>
Subject: Suggestion: make git checkout safer
Date: Wed, 3 Jun 2015 08:50:44 +0000 (UTC)
Message-ID: <loom.20150603T104534-909@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 03 10:51:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z04OK-0000PZ-Dm
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jun 2015 10:51:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753031AbbFCIvH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jun 2015 04:51:07 -0400
Received: from plane.gmane.org ([80.91.229.3]:40104 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752903AbbFCIvE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jun 2015 04:51:04 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Z04Ny-0000D8-Do
	for git@vger.kernel.org; Wed, 03 Jun 2015 10:50:54 +0200
Received: from 80.169.169.174 ([80.169.169.174])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 03 Jun 2015 10:50:54 +0200
Received: from eda by 80.169.169.174 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 03 Jun 2015 10:50:54 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 80.169.169.174 (Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:38.0) Gecko/20100101 Firefox/38.0 Cyberfox/38.0.5)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270669>

Currently a plain 'git checkout .' will revert any local changes, e.g.

    % mkdir test
    % cd test
    % git init
    Initialized empty Git repository in /home/eda/test/.git/
    % echo hello >foo
    % git add foo
    % git commit -m.
    [master (root-commit) 34f6694] .
     1 file changed, 1 insertion(+)
     create mode 100644 foo
    % echo goodbye >foo
    % git checkout .
    % cat foo
    hello

I suggest this is dangerous and by default 'git checkout' should only alter
files which do not have local changes (as would be reported by 'git diff').
Only if --force is given should working tree differences be thrown away.

    % git --version
    git version 2.4.0

-- 
Ed Avis <eda@waniasset.com>

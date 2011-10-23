From: Peter Oberndorfer <kumbayo84@arcor.de>
Subject: git gui: adding bare remotes on local filesystem reports error
Date: Sun, 23 Oct 2011 18:14:59 +0200
Message-ID: <2536790.zI3kRoQihV@soybean>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 23 18:16:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RI0jD-00019a-Jv
	for gcvg-git-2@lo.gmane.org; Sun, 23 Oct 2011 18:16:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752035Ab1JWQQq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Oct 2011 12:16:46 -0400
Received: from mail-in-01.arcor-online.net ([151.189.21.41]:36010 "EHLO
	mail-in-01.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751726Ab1JWQQq (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 23 Oct 2011 12:16:46 -0400
Received: from mail-in-06-z2.arcor-online.net (mail-in-06-z2.arcor-online.net [151.189.8.18])
	by mx.arcor.de (Postfix) with ESMTP id 614175A008;
	Sun, 23 Oct 2011 18:16:44 +0200 (CEST)
Received: from mail-in-01.arcor-online.net (mail-in-01.arcor-online.net [151.189.21.41])
	by mail-in-06-z2.arcor-online.net (Postfix) with ESMTP id 5D0471575C2;
	Sun, 23 Oct 2011 18:16:44 +0200 (CEST)
Received: from soybean.localnet (188-23-124-43.adsl.highway.telekom.at [188.23.124.43])
	(Authenticated sender: kumbayo84@arcor.de)
	by mail-in-01.arcor-online.net (Postfix) with ESMTPSA id 42E275A336;
	Sun, 23 Oct 2011 18:16:44 +0200 (CEST)
X-DKIM: Sendmail DKIM Filter v2.8.2 mail-in-01.arcor-online.net 42E275A336
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arcor.de; s=mail-in;
	t=1319386604; bh=alARDqk674GH6XjqtjdJLsMy5hJUCWCVltWaUaU2YdA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=j+eUEHm8o3+UV5byrFYSaqFi0ssBFoanLWDbfFjWEtGJLbva/NIQjnv/oGm3rjA+a
	 fYpCSA0ZAyXRiH0j5XCzx9B96q4CUG6TQww6FjXVbmhFb9vCKHRca+DjISztuvhwnF
	 qp11Nlig78RzzADIfrfryccc7K2luwLiUPKm4W8s=
User-Agent: KMail/4.7.2 (Linux/3.0.0-12-generic-pae; KDE/4.7.1; i686; ; )
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184143>

Hi,

i just tried using git gui to add a remote on the local file system
and push to it.
(set Location to /tmp/blah.git, select "Initialize Remote Repository and Push")

but git gui reported:
fatal: GIT_WORK_TREE (or --work-tree=<directory>) not allowed without specifying GIT_DIR (or --git-dir=<directory>)

I bisected the error to
a9fa11fe5bd5978bb175b3b5663f6477a345d428 git-gui: set GIT_DIR and GIT_WORK_TREE after setup

I guess it is necessary to unset the GIT_DIR and GIT_WORKTREE env vars before calling
git --git-dir=$location init --bare

On a side note i am wondering why it is necessary to call mkdir -p?
And why it is not using git init --bare <path>
During some tests it created all leading directories.

Thanks,
Greetings Peter

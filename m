From: Matthias Lederhofer <matled@gmx.net>
Subject: [BUG] git-diff-tree or git-commit: wrong diff(stat)
Date: Mon, 5 Mar 2007 21:07:51 +0100
Message-ID: <20070305200751.GA13655@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 05 21:08:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HOJTZ-00017Y-EK
	for gcvg-git@gmane.org; Mon, 05 Mar 2007 21:08:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751729AbXCEUH4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Mar 2007 15:07:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751750AbXCEUH4
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Mar 2007 15:07:56 -0500
Received: from mail.gmx.net ([213.165.64.20]:52249 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751695AbXCEUHz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Mar 2007 15:07:55 -0500
Received: (qmail invoked by alias); 05 Mar 2007 20:07:53 -0000
X-Provags-ID: V01U2FsdGVkX1963kQcDMh6IgtXuyQ0Vp5GZ135FSbhgcgSN9ZWvF
	xg2ZcZIO/WUX1C
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41481>

git-commit.sh uses git-diff-tree [options] HEAD --.  The '--' was
added in 521f9c4d to prevent problems when HEAD exists as a file but
git-diff-tree shows only differences below the current directory when
'--' is used.  Hence git-commit in a subdirectory shows only stats for
the subdirectory.  Example:
~/foo% git init
Initialized empty Git repository in .git/
~/foo% mkdir d
~/foo% seq 1 10 | tee a > d/b
~/foo% git add a d/b
~/foo% cd d
~/foo/d% git commit -m blub
Created initial commit 49d6f2eac51d3a2665a539adc2cc8676e5b14a3d
 1 files changed, 10 insertions(+), 0 deletions(-)
 create mode 100644 d/b

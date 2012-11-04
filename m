From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v6 00/16] New remote-hg helper:w
Date: Sun,  4 Nov 2012 03:13:22 +0100
Message-ID: <1351995218-19889-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 04 03:14:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TUpj7-0002ES-Vt
	for gcvg-git-2@plane.gmane.org; Sun, 04 Nov 2012 03:14:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751533Ab2KDCNt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Nov 2012 22:13:49 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:62548 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750951Ab2KDCNs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Nov 2012 22:13:48 -0400
Received: by mail-bk0-f46.google.com with SMTP id jk13so1657497bkc.19
        for <git@vger.kernel.org>; Sat, 03 Nov 2012 19:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=0P2f88l3m1Uerpx5eoDPfbjlH0RzkYABibgj0qSSwzA=;
        b=rhcFLxXeeV9mqWtaICCusJf6daguh8wVAkiC3piRItBXhpJHo40CqNaiV2JIE1t9f8
         +1IDooFeDAZXatkLbzuCw7Fl6jxhLgftNqkixs3h5Qia9fNodx0qZcJ7q4mQpZ/eJaGB
         u/J9rZJZzkZn0+XSsNMdZTstj2Jark+6zX8pnbd0Zqilh1yoW6N1OvtT4ScZEiIP+BO4
         IizAOtsS+9kjoNEGkexiU+OwrJH1/uCDKE3gapDhNFQ73HhLFxUV2Hcp7eDZe3o8Gdy8
         TYW2gMlZ3pTpzgwtvRT8AE5wiZsIs6SRJxlMLsMHTDY4rveGVg/D6SSgNSXIiM0X/Bc6
         aG8Q==
Received: by 10.204.5.206 with SMTP id 14mr1398139bkw.79.1351995226670;
        Sat, 03 Nov 2012 19:13:46 -0700 (PDT)
Received: from localhost (ip-109-43-0-39.web.vodafone.de. [109.43.0.39])
        by mx.google.com with ESMTPS id g8sm7941251bkv.6.2012.11.03.19.13.44
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 03 Nov 2012 19:13:45 -0700 (PDT)
X-Mailer: git-send-email 1.8.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208990>

Hi,

Only a few updates, and has been moved to contrib/remote-helpers
(git-remote-bzr is on the way).

This remote-hg has advantages other tools don't have:

 * Uses transport-helper (git clone hg::path)
 * The code is small
 * The code is simple
 * No external dependencies (other than mercurial)
 * It's easy to install (put into your path)
 * Has extensive tests (for real)
 * Active development
 * Has compatibility with hg-git
 * The required patches are available
 * No changes necesary to git core
 * Support for bookmarks
 * Support for tags

One important alternative is the one written by Sverre Rabbelier that is
now maintained and distributed in msysgit. A list of issues with that
approach (not exhaustive):

 * Doesn't work on newer versions of mercurial
 * There are multiple versions, each with different issues
 * Don't pass a single of this remote-hg's tests

To use it add it to your $PATH (e.g. ~/bin).

 % git clone hd:///full/path/or/url/to/hg/repo

To run the tests:

 % make -C contrib/remote-helpers test

The only caveat is that you need 'python' in your $PATH.

Changes since v5:

 * Move to contrib/remote-helpers
 * Reorganize tests
 * Fix update of bookmarks
 * Fix for older versions of python
 * Performance improvements
 * Improve default branch/bookmark handling
 * Add fixes test-lib
 * Cleanups

Changes since v4:

Felipe Contreras (16):
  Add new remote-hg transport helper
  remote-hg: add support for pushing
  remote-hg: add support for remote pushing
  remote-hg: add support to push URLs
  remote-hg: make sure the encoding is correct
  remote-hg: match hg merge behavior
  remote-hg: add support for hg-git compat mode
  remote-hg: add compat for hg-git author fixes
  remote-hg: fake bookmark when there's none
  remote-hg: add basic tests
  test-lib: avoid full path to store test results
  remote-hg: add bidirectional tests
  remote-hg: add tests to compare with hg-git
  remote-hg: add extra author test
  remote-hg: add option to not track branches
  remote-hg: the author email can be null

 contrib/remote-helpers/Makefile          |  13 +
 contrib/remote-helpers/git-remote-hg     | 785 +++++++++++++++++++++++++++++++
 contrib/remote-helpers/test-hg-bidi.sh   | 243 ++++++++++
 contrib/remote-helpers/test-hg-hg-git.sh | 466 ++++++++++++++++++
 contrib/remote-helpers/test-hg.sh        | 112 +++++
 t/test-lib.sh                            |   3 +-
 6 files changed, 1621 insertions(+), 1 deletion(-)
 create mode 100644 contrib/remote-helpers/Makefile
 create mode 100755 contrib/remote-helpers/git-remote-hg
 create mode 100755 contrib/remote-helpers/test-hg-bidi.sh
 create mode 100755 contrib/remote-helpers/test-hg-hg-git.sh
 create mode 100755 contrib/remote-helpers/test-hg.sh

-- 
1.8.0

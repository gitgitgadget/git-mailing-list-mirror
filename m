From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v2 0/3] format-patch: introduce option to suppress commit hashes
Date: Sun, 13 Dec 2015 17:27:15 +0000
Message-ID: <1450027638-788102-1-git-send-email-sandals@crustytoothpaste.net>
Cc: Stefan Beller <stefanbeller@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 13 18:28:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a8ARQ-0000Gh-0N
	for gcvg-git-2@plane.gmane.org; Sun, 13 Dec 2015 18:28:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751342AbbLMR12 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Dec 2015 12:27:28 -0500
Received: from castro.crustytoothpaste.net ([173.11.243.49]:44766 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750925AbbLMR10 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 13 Dec 2015 12:27:26 -0500
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 0DA7F282CA;
	Sun, 13 Dec 2015 17:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
	s=default; t=1450027644;
	bh=15VU79OShNLOADjY0RWacHYpv7mST2flBCeIHXo/otI=;
	h=From:To:Cc:Subject:Date:From;
	b=0LKMHpiYa7cAYbDUIHp3OK5wAZorZOV3BVQfrFwTwavTSBWjBQF7QGom2bDA5nGQ+
	 d8li9Q9r+Yq9AXf2ukigFm1Gp9vixU3tH/Vb0rLoH8XQSm4rgKliz4kMEc8TAfa0cY
	 wvjgzolybiwnZw6VU7q5XDfcSOCLOnh4ofgMungL/JMHqNEsmbs3wakyER6ImmSyDp
	 FfK0N1ZV4wOeOqqZIFjJzXJYrlwJwFgCPbwrrFkI3p9RdPRUTBuS9O3l0Ysdcl58eg
	 t0pXDAAgEVVLB/Tv9a8ZfzKJQQx19GZXsT2N3YPote9/q8767D1uk3rZ/XJnIN7Qul
	 vrBK0xn1MLg88FWJd+lGtxMGSuC923kvHfoZKMZ0R12fzOC7pyZc6tiZioosyI+Mp6
	 OC0CGUVNXGLOTZhmvrY/CDp51MWR93SO/sPfTxG1BG8twOXy3nY5gw3OnRjE3uyzxu
	 foiKo/G4OppC9iUE50UVz7MGTyHwcPZ8dX4ugt2yViEyaVLfPKN
X-Mailer: git-send-email 2.7.0.rc0.173.g4a846af
X-Spam-Score: -2.49 ALL_TRUSTED,BAYES_00,T_DKIM_INVALID
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282333>

git format-patch is often used to create patches that are then stored in
version control or displayed with diff.  Having the commit hash in the
"From " line usually just creates diff noise in these cases, so this
series introduces --zero-commit to set that to all zeros.

Changes from v1:
* Rename the option --zero-commit.
* Improve the tests to look for a 40-hex hash value in "From " header.

brian m. carlson (3):
  Introduce a null_oid constant.
  format-patch: add an option to suppress commit hash
  format-patch: check that header line has expected format

 Documentation/git-format-patch.txt |  4 ++++
 builtin/log.c                      |  5 +++++
 cache.h                            |  1 +
 log-tree.c                         |  3 ++-
 revision.h                         |  1 +
 sha1_file.c                        |  1 +
 t/t4014-format-patch.sh            | 12 ++++++++++++
 7 files changed, 26 insertions(+), 1 deletion(-)

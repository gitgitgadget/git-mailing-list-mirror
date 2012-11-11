From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v5 00/15] fast-export and remote-testgit improvements
Date: Sun, 11 Nov 2012 14:59:37 +0100
Message-ID: <1352642392-28387-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Max Horn <max@quendi.de>, Jeff King <peff@peff.net>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Brandon Casey <drafnel@gmail.com>,
	Brandon Casey <casey@nrlssc.navy.mil>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Pete Wyckoff <pw@padd.com>, Ben Walton <bdwalton@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 11 15:00:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXY5Y-0007Xs-Qv
	for gcvg-git-2@plane.gmane.org; Sun, 11 Nov 2012 15:00:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751945Ab2KKOA1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2012 09:00:27 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:62032 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750846Ab2KKOA0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2012 09:00:26 -0500
Received: by mail-bk0-f46.google.com with SMTP id jk13so2062168bkc.19
        for <git@vger.kernel.org>; Sun, 11 Nov 2012 06:00:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=9u0JnxSRyVIGx1UOb2h5JJxwUiVWO28h7ZhwhEdMe54=;
        b=ABPuIsEwavIM3mO0lUGVv0aPa1Vu6bEn/abl4p6+40UY41r/qMPzZ4hU387CfH96d2
         6UGFB1fwaIWXwY+3xC03ovq8fOGAeDywqUkoPM2EfCiB8EYHyPzEoSB6xU2MEhGUkEJT
         P1aDxZC4uoi7jdORxDu5ifmFryttcMD1cQg8iyAUAXycfyIS3DsoKMfVeCq01Pp5IXu1
         tDRwuMwhvfv1AYiG/VHfprptOVf4hWlRWO4uLhPwk3bS7TJonRWVU5pOACOpT8Biotqn
         rPtpMD8MQ/JzFSLPgHZKTOuiFqoILWb5IDXJdPPEZAxXAqr5dLvfi26ZMJtILjwz4yfS
         m/sA==
Received: by 10.204.157.144 with SMTP id b16mr5900620bkx.19.1352642424964;
        Sun, 11 Nov 2012 06:00:24 -0800 (PST)
Received: from localhost (ip-109-43-0-127.web.vodafone.de. [109.43.0.127])
        by mx.google.com with ESMTPS id z13sm1489500bkv.8.2012.11.11.06.00.22
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 11 Nov 2012 06:00:23 -0800 (PST)
X-Mailer: git-send-email 1.8.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209355>

Hi,

Basically resending with a few fixes...

I found more issues in fast-export. remote-testgit, and eventually I decided
there's no reason to use this python script, so I wrote a much simpler version
that does the same, and more. I'm not going to list all the reasons because
apparently opinions are not welcome in the list any more. For the actual
differences you can check the patch itself.

The old remote-testgit is now remote-testpy (as it's testing the python
framework, not really remote helpers). The tests are simplified, and exercise
more features of transport-helper, and unsuprisingly, find more bugs.

Some of these bugs are fixed in this patch series as well, for which I already
sent 3 versions, and they come at the end. I was surprised they did fix them,
but hey... good is good.

I know how to fix the rest of the issues, but I'm not going to bother sending a
patch because obvious... er, simple? fixes are not accepted, so there's no
chance of something less... evident? getting through.

Cheers.

Changes since v4:

 * Add check for bash in test
 * Avoid bash associative arrays for older versions
 * Apply trivial comments
 * White-space cleanups

Felipe Contreras (15):
  fast-export: avoid importing blob marks
  remote-testgit: fix direction of marks
  remote-helpers: fix failure message
  Rename git-remote-testgit to git-remote-testpy
  Add new simplified git-remote-testgit
  remote-testgit: get rid of non-local functionality
  remote-testgit: remove irrelevant test
  remote-testgit: cleanup tests
  remote-testgit: exercise more features
  remote-testgit: report success after an import
  remote-testgit: make clear the 'done' feature
  fast-export: trivial cleanup
  fast-export: fix comparison in tests
  fast-export: make sure updated refs get updated
  fast-export: don't handle uninteresting refs

 .gitignore                           |   2 +-
 Documentation/git-remote-testgit.txt |   2 +-
 Makefile                             |   2 +-
 builtin/fast-export.c                |  20 ++-
 git-remote-testgit                   |  82 +++++++++++
 git-remote-testgit.py                | 272 -----------------------------------
 git-remote-testpy.py                 | 272 +++++++++++++++++++++++++++++++++++
 git_remote_helpers/git/importer.py   |   2 +-
 t/t5800-remote-helpers.sh            | 148 -------------------
 t/t5800-remote-testpy.sh             | 148 +++++++++++++++++++
 t/t5801-remote-helpers.sh            | 158 ++++++++++++++++++++
 t/t9350-fast-export.sh               |  41 +++++-
 12 files changed, 717 insertions(+), 432 deletions(-)
 create mode 100755 git-remote-testgit
 delete mode 100644 git-remote-testgit.py
 create mode 100644 git-remote-testpy.py
 delete mode 100755 t/t5800-remote-helpers.sh
 create mode 100755 t/t5800-remote-testpy.sh
 create mode 100644 t/t5801-remote-helpers.sh

-- 
1.8.0

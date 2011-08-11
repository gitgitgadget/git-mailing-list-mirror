From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: [PATCH 0/2] Add an update=none option for 'loose' submodules
Date: Thu, 11 Aug 2011 19:51:44 +0200
Message-ID: <cover.1312923673.git.hvoigt@hvoigt.net>
Cc: git@vger.kernel.org, Jens Lehmann <jens.lehmann@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 11 19:52:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QrZQc-0007YC-TL
	for gcvg-git-2@lo.gmane.org; Thu, 11 Aug 2011 19:52:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752669Ab1HKRwM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Aug 2011 13:52:12 -0400
Received: from darksea.de ([83.133.111.250]:57048 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752626Ab1HKRwL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Aug 2011 13:52:11 -0400
Received: (qmail 25970 invoked from network); 11 Aug 2011 19:52:08 +0200
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 11 Aug 2011 19:52:08 +0200
X-Mailer: git-send-email 1.7.6.435.g741d34
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179112>

If a submodule is used to seperate some bigger parts of a project into
an optional directory it is helpful to not clone/update them by default.

This series implements a new value 'none' for submodule.<name>.update.
If this option is set a submodule will not be updated or cloned by
default. If the user wants to work with the submodule he either needs
to explicitely configure the update option to 'checkout' or pass
--checkout as an option to the submodules. I chose this name to be
consistent with the existing --merge/--rebase options.

We have been talking about loose submodules for some time:

RFC patch for this series
http://thread.gmane.org/gmane.comp.version-control.git/175165

Using submodule groups/dependencies:
http://thread.gmane.org/gmane.comp.version-control.git/130928/focus=131050
http://thread.gmane.org/gmane.comp.version-control.git/176347/focus=178614

This lays the foundations for grouping of submodules. Once submodule
grouping will be implemented the value of submodule.$name.update
provides the default value when the user specifies no group. A group
specification could then be a layer on top which provides a shortcut to
choose other submodule.$name.update values to be registered in
.git/config.

Heiko Voigt (2):
  submodule: move update configuration variable further up
  add update 'none' flag to disable update of submodule by default

 Documentation/git-submodule.txt |    8 ++++-
 git-submodule.sh                |   22 ++++++++++----
 t/t7406-submodule-update.sh     |   62 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 85 insertions(+), 7 deletions(-)

-- 
1.7.6.435.g741d34

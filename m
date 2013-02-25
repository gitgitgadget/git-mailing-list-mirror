From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: [RFC/WIP PATCH 0/3] fetch moved submodules on-demand
Date: Mon, 25 Feb 2013 02:02:52 +0100
Message-ID: <cover.1361751905.git.hvoigt@hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jens Lehmann <jens.lehmann@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 25 02:03:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U9mTV-0002XN-OC
	for gcvg-git-2@plane.gmane.org; Mon, 25 Feb 2013 02:03:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759484Ab3BYBCy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Feb 2013 20:02:54 -0500
Received: from smtprelay02.ispgateway.de ([80.67.31.29]:45195 "EHLO
	smtprelay02.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759478Ab3BYBCx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Feb 2013 20:02:53 -0500
Received: from [77.21.76.82] (helo=localhost)
	by smtprelay02.ispgateway.de with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1U9mSy-0007qu-8x; Mon, 25 Feb 2013 02:02:52 +0100
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217018>

Hi,

this is a series I have been working on and off. My plan is that it
might be part of a slightly bigger series also implementing on-demand
clone of submodules into the .git/modules folder if a submodule is
configured like that.

This is needed as preparation for the final goal of automatic
checkout/deletion of submodules when they appear/disappear. My plan
is to introduce a new .gitmodules variable

	submodule.<name>.init

to specify whether a submodule should be initialized (and thus cloned)
by default or not. If not configured it will default to off to stay
closed to the current behavior. If it proves useful we can maybe change
that default later to on.

That way we would get much closer to "clone/fetch and get everything you
need to work on a project".

I send this series mainly to inform people what I have been working and
to maybe get some early feedback about the approach. Let me know what
you think.

Cheers Heiko


Heiko Voigt (3):
  teach config parsing to read from strbuf
  implement fetching of moved submodules
  submodule: simplify decision tree whether to or not to fetch

 .gitignore                  |   1 +
 Makefile                    |   2 +
 cache.h                     |   1 +
 config.c                    | 119 +++++++++++++++++-----
 submodule-config-cache.c    |  96 ++++++++++++++++++
 submodule-config-cache.h    |  34 +++++++
 submodule.c                 | 242 ++++++++++++++++++++++++++++++++++++--------
 t/t1300-repo-config.sh      |   4 +
 t/t5526-fetch-submodules.sh |  31 ++++++
 test-config.c               |  41 ++++++++
 10 files changed, 502 insertions(+), 69 deletions(-)
 create mode 100644 submodule-config-cache.c
 create mode 100644 submodule-config-cache.h
 create mode 100644 test-config.c

-- 
1.8.2.rc0.25.g5062c01

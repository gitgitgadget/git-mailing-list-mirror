From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v2 0/3] Support `git pull --rebase=interactive`
Date: Wed, 13 Jan 2016 07:57:44 +0100 (CET)
Message-ID: <cover.1452668201.git.johannes.schindelin@gmx.de>
References: <cover.1452612112.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org, Paul Tan <pyokagan@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 13 07:58:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJFNo-00073J-S2
	for gcvg-git-2@plane.gmane.org; Wed, 13 Jan 2016 07:58:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754177AbcAMG56 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2016 01:57:58 -0500
Received: from mout.gmx.net ([212.227.17.22]:54041 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753905AbcAMG5v (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2016 01:57:51 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0MMXVC-1aGUDv3VeA-008GGq; Wed, 13 Jan 2016 07:57:45
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <cover.1452612112.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:2AcL+eIXcBgPciHzOBsW0Nb/VxQexAVr52qIFcaaWjIvPXb6/Mt
 RGZgNQfJRSj16BO3N1nb2Z92fWVAH2C8hHiHITDW+/zQ+5ljPf3OPy8w8t7bOb60GKrSgp7
 8ad1sli1hvyYjjYoLfkZC9H8yc3FZzgoRUQ8XIuYX0sPNKS1kpkHabjFd2ek6Kq8fOzzoTw
 5qxjotWMBmPDaLQbYpnAQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:LEEtAFwlPqg=:nNMoIWt0Uw4YcNxjcNwMKv
 v0ACQ6LEXXKaxVeBQWiJeczKV+kyu9PpPT9GqS0sR4QqbwUwJQUJSDqGbZDyvyrl8pKvtSTHv
 ex/8izP8OQzwAc7xnQ530z7nwWaSfRrPz2xWP+HhePhSdUOxJ4ucyEGcQtQzJStxRaM4iYAQf
 LF4T4u2AClmBMBgf8Lm91T3uqtExtaBbQQbeslntd/aCwCalmE9GX4m4CXm2cabchi8CZZSuv
 aM+Wm1wa8fH0+B8YfINwsaRLWguQuCa9Oim3wvuhXqH9jK8lu5yWneZtCW22oEdW+ni0cqted
 PkQazIiI4/NVqTdI3tArjQkMeaQmYK+OnvoldORUH9TvJw/AQ8FV8lBb2PPE7p+b6IOUKwuMd
 8S+/XkeLwiFF+SFcwHYk7+nlqWFdbztxWbzseGwjJ5TiOZ+2l2VjdjFzaau0BDjoCvtqXO00w
 V13m8NUedxTaIw1kmJmwqXRMsjXslzQ9zqYHbXSc/hSOSOtWdwm1efRIaIrJS00YRh0OFh/U9
 O+w/6geHqAq+LAXFfWEcC0L9YYTSEL5uoEgu3S5cFG5ySWLRFvSEP1aisJ7raOzLLyInpAWRw
 dAV+OiWZrR5vUyyBCia70MMYEZhNjvOt8GCV8qCsv1uRhJhQ28C6tjiUCqFBLi5pw0Ww/rrX8
 hpZuSd9bh5TXjuCBOJAD1fismDlw4+0y6Cxj6igMx03FCcgpk0Q/NHTyBicjOb37VkUk9i/mL
 ZjBKHHVsHZ/wu9ZVbfJvuYdhGqKM5nCGmaJlSM+5PmhmMFdiRtPw6UU3xRpFPizSVGI/vu2k 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283886>

A couple of years ago, I found the need to collaborate on topic branches
that were rebased all the time, and I really needed to see what I was
rebasing when pulling, so I introduced an interactively-rebasing pull.

This patch series ports that work to the builtin pull.

Apart from the change outlined in the interdiff, the first two commit
messages changed, too.

Johannes Schindelin (3):
  pull: allow interactive rebase with --rebase=interactive
  remote: handle the config setting branch.*.rebase=interactive
  completion: add missing branch.*.rebase values

 Documentation/config.txt               |  1 +
 Documentation/git-pull.txt             |  4 +++-
 builtin/pull.c                         |  7 ++++++-
 builtin/remote.c                       | 10 +++++++---
 contrib/completion/git-completion.bash |  2 +-
 t/t5520-pull.sh                        | 10 ++++++++++
 6 files changed, 28 insertions(+), 6 deletions(-)

Interdiff vs v1:

 diff --git a/builtin/remote.c b/builtin/remote.c
 index 0af8300..2b2ff9b 100644
 --- a/builtin/remote.c
 +++ b/builtin/remote.c
 @@ -311,7 +311,7 @@ static int config_read_branches(const char *key, const char *value, void *cb)
  			if (v >= 0)
  				info->rebase = v;
  			else if (!strcmp(value, "preserve"))
 -				info->rebase = 1;
 +				info->rebase = NORMAL_REBASE;
  			else if (!strcmp(value, "interactive"))
  				info->rebase = INTERACTIVE_REBASE;
  		}

-- 
2.6.3.windows.1.300.g1c25e49

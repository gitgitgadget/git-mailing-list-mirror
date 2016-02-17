From: larsxschneider@gmail.com
Subject: [PATCH v5 0/3] config: add '--sources' option to print the source of a config value
Date: Wed, 17 Feb 2016 09:57:45 +0100
Message-ID: <1455699468-45443-1-git-send-email-larsxschneider@gmail.com>
Cc: peff@peff.net, ramsay@ramsayjones.plus.com, gitster@pobox.com,
	Lars Schneider <larsxschneider@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 17 09:57:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVxvo-0006iv-QX
	for gcvg-git-2@plane.gmane.org; Wed, 17 Feb 2016 09:57:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965133AbcBQI5x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Feb 2016 03:57:53 -0500
Received: from mail-wm0-f43.google.com ([74.125.82.43]:34552 "EHLO
	mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965115AbcBQI5w (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Feb 2016 03:57:52 -0500
Received: by mail-wm0-f43.google.com with SMTP id b205so145632482wmb.1
        for <git@vger.kernel.org>; Wed, 17 Feb 2016 00:57:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=svc1UslRKSbkhXLhDBhiFALB++5Z7+KZZA0P99ihVT8=;
        b=ZlABEcYezQm0UT857EhI74UKmPIypP368FbfSEmWW+PRcbW7D/avXYEq3Jx8Vw6xv7
         x2zgIHyDCW3kk4VkoUr5CplsXSuwpUgAJ1F9lMSNydX/u83ANqBXNkL2Sys321LLOe/a
         ZiKVGNmTn1C1RPRgX0renpMe3QECf+/2x4/lIjYX2g9kkfEuJrnDEHTV0EdgCsabZ1JB
         Hnqr9Ut32rYNr9YvoHoZ5/tr+Q4H2iRpyyxVkmPqqtXK496b4jkgXyuyZwvAsGnGUwda
         fZ1J3n9GDZZqbn6zdDJNOEXDPDAhYCzjpgR6y4k45ggXM9PFg7cCxw0c/vYLSADiwNaJ
         etTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=svc1UslRKSbkhXLhDBhiFALB++5Z7+KZZA0P99ihVT8=;
        b=aNAvKXB9FMOxJa6G9jwZ8ITwIYqsr0gmOo8+hjl+w77Uo1a8yVoD95b/CkrtGR5ZFE
         QdLevBQF8ODp0kmY48c2inyGrPWnUNrwpYgZ7Mpi/6ejCB4FG9zOzA7tPSIaIdrJrdaZ
         fM3o12wrYt14/Z6M70JZnFIDo81G6uqMU/VSjzSlpbkR16EAHs8WLgvPrCE2QnB4XRQo
         9l63UqymCecBfRvFz+Fd5H1gHdrqlOktJs6aCLlNZoIS6H4/t0Cta80t5gO8FvZzamyd
         9t5C9uayroaKBSZhLRFrNX2f9O7fdLjWeNWuElzC8KShMP1+jY1SpGIAc0sQGNelqCNN
         tDVA==
X-Gm-Message-State: AG10YOR3MOsutQNbsos10nTAJwEfjVnvBJbV1j2qP7FA/hB5qgpZcKUtpfrGtelQ7b141A==
X-Received: by 10.194.120.196 with SMTP id le4mr501713wjb.83.1455699471154;
        Wed, 17 Feb 2016 00:57:51 -0800 (PST)
Received: from slxBook3.fritz.box (p5DDB412D.dip0.t-ipconnect.de. [93.219.65.45])
        by smtp.gmail.com with ESMTPSA id q129sm2006973wmd.14.2016.02.17.00.57.49
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Wed, 17 Feb 2016 00:57:50 -0800 (PST)
X-Mailer: git-send-email 2.5.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286485>

From: Lars Schneider <larsxschneider@gmail.com>

diff to v4:
* improve wording of "exit code" cleanup commit message (Thanks Peff)
* remove t1300 "--show-origin" test teardown (Thanks Peff)
* fix no parameter function prototype (Thanks Ramsay)
* use doublequotes instead of tabs to test quoted paths (Thanks Junio)

I though a while about Ramsay's suggestion to restore the old error messages
for config reads via stdin. Since reading the config via stdin is not that
common I don't think the increased complexity is worth the effort. Unless
Ramsay or someone else feels strongly about it, I would like to proceed and
keep the new error messages

Thanks for the review,
Lars


Lars Schneider (3):
  t: do not hide Git's exit code in tests using 'nul_to_q'
  config: add 'type' to config_source struct that identifies config type
  config: add '--show-origin' option to print the origin of a config
    value

 Documentation/git-config.txt |  15 ++--
 builtin/config.c             |  33 +++++++++
 cache.h                      |   6 +-
 config.c                     |  36 +++++++---
 submodule-config.c           |   4 +-
 t/t1300-repo-config.sh       | 161 ++++++++++++++++++++++++++++++++++++++++++-
 t/t1308-config-set.sh        |   4 +-
 t/t7008-grep-binary.sh       |   3 +-
 8 files changed, 236 insertions(+), 26 deletions(-)

--
2.5.1

From: larsxschneider@gmail.com
Subject: [PATCH v1 0/2] git-p4: fix Git LFS pointer parsing
Date: Tue, 19 Apr 2016 22:08:48 +0200
Message-ID: <1461096530-82448-1-git-send-email-larsxschneider@gmail.com>
Cc: luke@diamand.org, Lars Schneider <larsxschneider@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 19 22:09:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asbxG-0005MG-Gr
	for gcvg-git-2@plane.gmane.org; Tue, 19 Apr 2016 22:09:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754008AbcDSUIz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Apr 2016 16:08:55 -0400
Received: from mail-wm0-f52.google.com ([74.125.82.52]:33730 "EHLO
	mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753680AbcDSUIy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2016 16:08:54 -0400
Received: by mail-wm0-f52.google.com with SMTP id 127so7204569wmz.0
        for <git@vger.kernel.org>; Tue, 19 Apr 2016 13:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=m0+a2nmBMXma+DbLX1flQneRZ1LAlH9dLj9ojgCghm4=;
        b=EGNMXaz61Yxl5tyEL9uUHhzr+3gD+uTSVq24d4MZP07/gKUuHfUllFcZa4xcqBZP7T
         xX5ht64E5J7XTa9mRO/Qn7ydqnOQtba0rqqgmeCgMIHBcupecIWezYNYJWbX67W5BUGq
         52KGt4PPZQM0FIhviUER1c3DIgplEo2R4j3zC9kkSDbTEZs8L5t4sbwv7j13DFxJlip4
         JMHTBTvdrhLMbjLHmDMJQj+k2fR1WXEoWtHSAC7e2LZwlrE4DxwFrgxlTrLSyztVR2bw
         2gnuajmCk0NfnL/P8Vl47J26XTcmgPEqrm9cG9xqR4ZAmvZPGct58BJHhWO+AFwRxm7X
         0yyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=m0+a2nmBMXma+DbLX1flQneRZ1LAlH9dLj9ojgCghm4=;
        b=ms25Rn8enlrl4mWfQbb2wZY7AvOvjm6KTHT3MHluMvFKE0yLjxpXkOVk4IZihJT92C
         bY6Zi6FNsbg24yTXVd4oMmugriOA7uNYYiYeCTujzfDc3n8578eJxYOWGerb/cl/LgmM
         TdagV12DqJ3YB462ZNGGvvHd7ZqBBM/sh764nIpytrA58S+9cxk/pGN2Mc79/K2tO19o
         nfHo0lQk4GywDq6v4mQ0bZyQOqkM68MuT4gGQnxmKDCYCPJx+lmpTYz7qsxm6Ovczs0p
         j2JCX2kTjJfI/3rrnX22j5Ed+tt0rOpMmq3M77/Dc0thSAQ6aQc15+hR0nE2Ruf46WgF
         CQNA==
X-Gm-Message-State: AOPr4FVfc8XbGa/YrjEea/2mJv0/9LHLhoh06Zx+akv/H/CG3kBJ219qa/Vv76A1QKgGdg==
X-Received: by 10.194.248.135 with SMTP id ym7mr4896877wjc.174.1461096532618;
        Tue, 19 Apr 2016 13:08:52 -0700 (PDT)
Received: from slxBook3.fritz.box (p508BAC17.dip0.t-ipconnect.de. [80.139.172.23])
        by smtp.gmail.com with ESMTPSA id 188sm5999993wmk.6.2016.04.19.13.08.51
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 19 Apr 2016 13:08:51 -0700 (PDT)
X-Mailer: git-send-email 2.5.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291917>

From: Lars Schneider <larsxschneider@gmail.com>

Travis-CI uses 'brew' to always install the latest available version of
Git LFS on the OS X build machines (on Linux the version is sticky).
A change in Git LFS 1.2.0 [1] breaks the git-p4 LFS integration [2].

This mini series updates Travis-CI to the latest Git-LFS and Perforce
versions on Linux and Mac and makes git-p4 work with the latest Git LFS
again.

Thanks,
Lars

[1] https://github.com/github/git-lfs/pull/1105
[2] https://travis-ci.org/git/git/jobs/124047942

Lars Schneider (2):
  travis-ci: update Git-LFS and P4 to the latest version
  git-p4: fix Git LFS pointer parsing

 .travis.yml              | 4 ++--
 Documentation/git-p4.txt | 3 ++-
 git-p4.py                | 6 +++---
 3 files changed, 7 insertions(+), 6 deletions(-)

--
2.5.1

From: larsxschneider@gmail.com
Subject: [PATCH v4 0/3] git-p4: fix Git LFS pointer parsing
Date: Thu, 28 Apr 2016 08:26:30 +0200
Message-ID: <1461824793-43235-1-git-send-email-larsxschneider@gmail.com>
Cc: sschuberth@gmail.com, gitster@pobox.com, ben.woosley@gmail.com,
	sunshine@sunshineco.com, Lars Schneider <larsxschneider@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 28 08:26:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avfPQ-0006RM-Fz
	for gcvg-git-2@plane.gmane.org; Thu, 28 Apr 2016 08:26:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751435AbcD1G0i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Apr 2016 02:26:38 -0400
Received: from mail-wm0-f54.google.com ([74.125.82.54]:35803 "EHLO
	mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750867AbcD1G0h (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2016 02:26:37 -0400
Received: by mail-wm0-f54.google.com with SMTP id e201so63875465wme.0
        for <git@vger.kernel.org>; Wed, 27 Apr 2016 23:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=lsyKczMGliVQql22QpfXCg5pheHMdzBnhmWbVlbfLpw=;
        b=uU9J1SnzvKYd82kNRg99NPdXuCVkoRlCKeAKmnGC9G8ZJOh440DsaNbGfa490vt6rR
         Usiu4OgqZUOadDP3PcxM9n0IjenUN5KD6pOLf403AfU7bjXbL9mXK+dQkhKeZE4YUR+m
         VpxLgrjPn1nb2+GLPkY21T9di+i+YmbLSQTcV/EIL/iojAkyDJprR186MGS7LDkRT1ii
         +Z6P0K7N/ljwmVUaFA4TGK3b4KVzegmDpMcALvG7/as6h13B4EFbCCTYxwzoBbCNkqIJ
         Qgw6OgYDM8lH5xsqOTNmXT9gxuhiX9I6YBjQyOz4Wyb5XU3TVCJjZx1ROE1Axp0fdEOw
         r1yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=lsyKczMGliVQql22QpfXCg5pheHMdzBnhmWbVlbfLpw=;
        b=Ga9sU1oW/P54fXzt4KxdCvOJ4Ahf/lTojXpTCN55VL+Q4T9VsgtR+Wg4q15jcue3Or
         H7p9J2Ys6XXAKcnRpjfR/QfcW8q1H1bwSesN4HmFQfVMUAnxMfDABTYvwR9UtWA6FC1z
         SHghgKzk3zQ/EkLF6WfQwDZuPxYHhDAe1Zc7IUQiiv9Yt4UDqsXTX2fA4lto9gaYh9VA
         6AIrckQ0dN0MCvYjvIonIki2IVxOjq8JzRLpLDkVDN+4e+II71vT45nP/le+m/w2NJTH
         6qLPlmbBJz5Ct4V/joKClJLH3PXSD3V1Lt2E6KWLyj6WhwqH2S4l2PklKb7RJLyj3Pfj
         O1HQ==
X-Gm-Message-State: AOPr4FUP36PTrRyc9MiEZGnry8NJnf7rdJeOzZwgkFHZVpYp8g7YaFHAyTZaODZwpNneUA==
X-Received: by 10.28.60.5 with SMTP id j5mr13835606wma.47.1461824795580;
        Wed, 27 Apr 2016 23:26:35 -0700 (PDT)
Received: from slxBook3.fritz.box (p508BAD07.dip0.t-ipconnect.de. [80.139.173.7])
        by smtp.gmail.com with ESMTPSA id y91sm12225405wmh.10.2016.04.27.23.26.34
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Wed, 27 Apr 2016 23:26:34 -0700 (PDT)
X-Mailer: git-send-email 2.5.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292849>

From: Lars Schneider <larsxschneider@gmail.com>

v1: $gmane/291917
v2: $gmane/291991
v3: $gmane/292425

diff to v3:
* fix missing assignment of pointerFile variable
  ($gmane/292454, thanks Sebastian for making me aware)
* fix s/brake/break/ in commit message
  ($gmane/292451, thanks Eric)

Thanks,
Lars

Lars Schneider (3):
  travis-ci: update Git-LFS and P4 to the latest version
  travis-ci: express Linux/OS X dependency versions more clearly
  git-p4: fix Git LFS pointer parsing

 .travis.yml               | 17 ++++++++++-------
 git-p4.py                 | 13 ++++++++++---
 t/t9824-git-p4-git-lfs.sh |  4 ++++
 3 files changed, 24 insertions(+), 10 deletions(-)

--
2.5.1

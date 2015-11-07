From: Luke Diamand <luke@diamand.org>
Subject: [PATCH v2 0/2] git-p4: allow submission from detached head
Date: Sat,  7 Nov 2015 01:07:50 +0000
Message-ID: <1446858473-19911-1-git-send-email-luke@diamand.org>
Cc: Junio C Hamano <gitster@pobox.com>, sunshine@sunshineco.com,
	larsxschneider@gmail.com, Luke Diamand <luke@diamand.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 07 02:08:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zurza-0006z2-Nr
	for gcvg-git-2@plane.gmane.org; Sat, 07 Nov 2015 02:08:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754787AbbKGBIF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Nov 2015 20:08:05 -0500
Received: from mail-pa0-f42.google.com ([209.85.220.42]:33827 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752594AbbKGBIE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Nov 2015 20:08:04 -0500
Received: by padhx2 with SMTP id hx2so130185603pad.1
        for <git@vger.kernel.org>; Fri, 06 Nov 2015 17:08:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=hz24OjvB52HNIqzrACEPfqVV9MMP6Yi6+841W+tbbP0=;
        b=hu5enEIWkk1y9GnKN8NEXyvHFoi6iLpubFT5sLiodzAglH3QEWQqxZHL9FY8yWwrYy
         ENlwWhz6+vQ6mxCBBdvZx8o09tbHXn9JgVcrCKxLZp4t66S1aH6KkGERVjaXg2ICLPwA
         YDIZxVpt0gh7IQ7YurK22wJR52zg3eGXHAdtg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=hz24OjvB52HNIqzrACEPfqVV9MMP6Yi6+841W+tbbP0=;
        b=fUxm5ED+eo0dKpcfBnhbpX8TeIdr0O+3rGc7nmUPFhD98xZ6OABb3dwYgRGJN6w4Ba
         Lqtgs/yVG9Cofn0xtg+EoR9F7I6159fmyqQ9ToObxnDYust8ZGfGKhIJ4qqqLOogbgHE
         VYYljcDnT05BzSjJCEVRPAfEqVUWUgo9xzGYO/SCkRnzLwEsGsu1Lsmo6O6i+zAuqYWr
         qGXZHXOq1ryPCCLY2vC4OaZGDeSkru6oPMuUnwRLAL4WD+pQZsWWIFp87pvIYd4V66I5
         B7O4P/ejaAAyGnSaJ4OiODQiFmIQ37eZfqhD9nd8c1NFF2AK5a2q4UalyOhwjVUAuwCe
         n/5w==
X-Gm-Message-State: ALoCoQk/O9ke3PYzlFNE+OEyPAaRZw1Sk5r8/OThbsQw1MK/ccibvB8R39RveqYpYPPCPWd/ab1o
X-Received: by 10.68.233.134 with SMTP id tw6mr14841665pbc.46.1446858483397;
        Fri, 06 Nov 2015 17:08:03 -0800 (PST)
Received: from lgd-kipper.local ([216.38.147.4])
        by smtp.gmail.com with ESMTPSA id t13sm2239577pbs.88.2015.11.06.17.08.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Nov 2015 17:08:02 -0800 (PST)
X-Mailer: git-send-email 2.6.0.rc3.238.gc07a1e8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281010>

This is a reroll of my earlier patch to teach git-p4
about detached heads.

It uses Junio's suggestion of calling "git symbolic-ref"
to determine if we're on a detached head, rather than
parsing text strings.

Luke Diamand (3):
  git-p4: add failing test for submit from detached head
  git-p4: add option to system() to return subshell status
  git-p4: work with a detached head

 git-p4.py               | 29 ++++++++++++++++++++---------
 t/t9800-git-p4-basic.sh | 16 ++++++++++++++++
 2 files changed, 36 insertions(+), 9 deletions(-)

-- 
2.6.0.rc3.238.gc07a1e8

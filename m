From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv3 0/6] Memory leaks once again
Date: Mon, 30 Mar 2015 18:22:05 -0700
Message-ID: <1427764931-27745-1-git-send-email-sbeller@google.com>
Cc: Stefan Beller <sbeller@google.com>, sunshine@sunshineco.com
To: gitster@pobox.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 31 03:22:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ycksn-0008FB-1M
	for gcvg-git-2@plane.gmane.org; Tue, 31 Mar 2015 03:22:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754116AbbCaBWP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Mar 2015 21:22:15 -0400
Received: from mail-ig0-f172.google.com ([209.85.213.172]:34262 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753915AbbCaBWO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Mar 2015 21:22:14 -0400
Received: by igcau2 with SMTP id au2so3610835igc.1
        for <git@vger.kernel.org>; Mon, 30 Mar 2015 18:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=BxSS9F4MeaIbbImZOt8Erx+6EygzMN4rRg/M49++Q9A=;
        b=fKug6t5wnoovKt5y5kM+AA+IDsWrpoQhHNpkj8D0MMa8/f9cX1o/xOHEG0kglna+Ow
         oDHzxxXF/Sxn38vT4ON10O8X77ZDZGwv+FlJc8JQx1bl8Zndv3lomBh/y7pellb7/Hvz
         ZxDMVZxtb639hbkFj8U5yFyW3bJN/+DIbSwedX7uHRn46uNvY9JyVbTBCzjaVyZtfvKf
         pxfMzrbM0R0t0UisgKH9oBmrCE5nK8maClcHOJFHsAViyggVehvxHj7fcCglSiig6yHT
         BAcgApZALBOG22nbo/EFQq2zbzTY6bVZFrzi86h0qmOZ5SvDW26+Nm/1QR4SCqZyPa1U
         tSbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=BxSS9F4MeaIbbImZOt8Erx+6EygzMN4rRg/M49++Q9A=;
        b=gPKOLMtGtXmYoYqtedLxiuLfRJxAGl8SYeIKx8JbPth6G1M99isOPm1nhWXtFv1jU0
         V/fSs26bQXH5SNPVMLKnKKNL0DdC2Z2oeeQJx4oiTwV1eN16zQTeShA3UeyECNu3kMqd
         +XVjohllGQIAtIvpk8keXfPphmKvQwDQcxTGt7TE2xvDdNUb/1CcRFiImokxMerjFS/O
         6Pa0H/anj4Pf+abwOSMNiG4HHpyvba4Jn2nmJGsYZF8rs5N1Xn2ZvevwgokUnH5mmSIq
         jGyEZxt9p1/mvZ+l3JknrEpsxfjcPJ2fNYvUsm6nrandT+TguDr3G/wYCCq+sdYnFzMD
         kpew==
X-Gm-Message-State: ALoCoQlDi7I7drVPrton2LzQ2UOnxhl1SmeY3Rd93gHsf0sUrmOhe3ZBfA8ZlyFkJtxASXZV52GL
X-Received: by 10.107.130.202 with SMTP id m71mr25675972ioi.89.1427764933778;
        Mon, 30 Mar 2015 18:22:13 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:3c88:d48a:4382:4b5])
        by mx.google.com with ESMTPSA id e3sm9039532igg.16.2015.03.30.18.22.13
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 30 Mar 2015 18:22:13 -0700 (PDT)
X-Mailer: git-send-email 2.3.0.81.gc37f363
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266498>

I changed the patches based on Erics feedback, all of them look sane to me now.

I still retain 2 patches which I need to convince myself are reasonable to send
to the list though.

John Keeping (1):
  entry.c: fix a memleak

Stefan Beller (5):
  shallow: fix a memleak
  line-log.c: fix a memleak
  line-log.c: fix a memleak
  wt-status.c: fix a memleak
  pack-bitmap.c: fix a memleak

 line-log.c    | 4 ++++
 pack-bitmap.c | 2 ++
 shallow.c     | 5 +++--
 streaming.c   | 5 ++++-
 wt-status.c   | 1 +
 5 files changed, 14 insertions(+), 3 deletions(-)

-- 
2.3.0.81.gc37f363

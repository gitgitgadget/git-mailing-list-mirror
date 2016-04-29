From: Luke Diamand <luke@diamand.org>
Subject: [PATCHv1] git-p4: workaround p4 removal of client directory
Date: Fri, 29 Apr 2016 08:40:25 +0100
Message-ID: <1461915626-10250-1-git-send-email-luke@diamand.org>
Cc: Jacob Smith <jaroslav@gmail.com>,
	Lars Schneider <larsxschneider@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Luke Diamand <luke@diamand.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 29 09:37:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aw2zj-0004i9-TB
	for gcvg-git-2@plane.gmane.org; Fri, 29 Apr 2016 09:37:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751615AbcD2Hhj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Apr 2016 03:37:39 -0400
Received: from mail-wm0-f51.google.com ([74.125.82.51]:38135 "EHLO
	mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750758AbcD2Hhi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2016 03:37:38 -0400
Received: by mail-wm0-f51.google.com with SMTP id g17so21589898wme.1
        for <git@vger.kernel.org>; Fri, 29 Apr 2016 00:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=JHUYTeR01TlgbfJkxVLL0o0jfERzpDNgwZ+iQzagyZ0=;
        b=i8IXTjqSIkNj80v5Q21ByCjKHiH2R+4UKmmwFvdWs9iJHnZmBy7gc/DEk25J0ne1Eu
         HLOOJN6RTTyIdCVKVluESnHFOyaBU0c+bnr3bSWyPwIZt6k+Tbh9mCGAPnRk9WGwDh3D
         a3Pww8XCSSV2Xdh9t3FyA6cdljPMwFxEmL60A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=JHUYTeR01TlgbfJkxVLL0o0jfERzpDNgwZ+iQzagyZ0=;
        b=fZDJddz/Q+WAU0swcci4IzQGph1+nr6fD/OT84a6V2PGzHssrtAI5pxywp4fpeS9KK
         hQPr2n8vwlGvODWe8Zk7blrUq8WK1aUHvxKFvz8f5r6kEUO5p5rsWPerklLkRDXtMO8W
         OOv7Yy0zoyq4N+kzEfror0dAeMKaYwLKO73tqPOKKFh16LHookzF62Irpa2dm2BRsq10
         +Pdtgs+J4gaVV8Cof8BNbGE558vxfyvGvebgLIQF4fbZBx885ykWKljMDSRFPbkym+WM
         CF/I2bvV+2lyYgK6aMwdi7voRj2/GE9x7W2OvIxnnu3BvjZ1R0L/m8/BF7fgiGuH7uq2
         Rbpg==
X-Gm-Message-State: AOPr4FWNum6u1HL5dOvOmxg5L8OPYd+/dqpiM3cDdb5TBwLIkr+mDuwBMfepMMzNw3AxMQ==
X-Received: by 10.28.95.131 with SMTP id t125mr2246771wmb.80.1461915457438;
        Fri, 29 Apr 2016 00:37:37 -0700 (PDT)
Received: from ethel.local.diamand.org (cpc92798-cmbg19-2-0-cust327.5-4.cable.virginm.net. [80.1.41.72])
        by smtp.gmail.com with ESMTPSA id w82sm1937078wmw.5.2016.04.29.00.37.36
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 29 Apr 2016 00:37:36 -0700 (PDT)
X-Mailer: git-send-email 2.8.1.218.gd2cea43.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292975>

This is a proposed fix for the problem reported by Jacob on OSX
where "p4 sync -f" removes the client directory.

http://www.spinics.net/lists/git/msg274356.html

I tried just moving the "cd", but lots of the tests then fail as
the "p4 sync" needs to be in the correct directory.

Luke Diamand (1):
  git-p4: workaround p4 removal of client directory

 git-p4.py | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

-- 
2.8.1.218.gd2cea43.dirty

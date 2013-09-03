From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 2/4] rev-parse test: use test_must_fail, not "if <command>;
 then false; fi"
Date: Tue, 3 Sep 2013 10:06:18 -0700
Message-ID: <20130903170617.GC29921@google.com>
References: <1378103439-3225-1-git-send-email-felipe.contreras@gmail.com>
 <1378103439-3225-4-git-send-email-felipe.contreras@gmail.com>
 <20130903071256.GD3608@sigill.intra.peff.net>
 <20130903075107.GA25540@goldbirke>
 <20130903080358.GA30158@sigill.intra.peff.net>
 <CAMP44s112mwgs=8n0XCnTtPM2V-O5RYE2ns+fjCvgkxj+kEY8Q@mail.gmail.com>
 <20130903111006.GJ29840@goldbirke>
 <CAMP44s349-v6xtCvbDzycVj1wBwTdAgLmuGxB0pYn6CmHYkM1Q@mail.gmail.com>
 <20130903150855.GK29840@goldbirke>
 <20130903170419.GA29921@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Jeff King <peff@peff.net>, git@vger.kernel.org
To: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Tue Sep 03 19:06:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VGu3f-0005S1-Ar
	for gcvg-git-2@plane.gmane.org; Tue, 03 Sep 2013 19:06:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754820Ab3ICRGX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Sep 2013 13:06:23 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:57590 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754063Ab3ICRGW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Sep 2013 13:06:22 -0400
Received: by mail-pa0-f52.google.com with SMTP id kq13so6678938pab.11
        for <git@vger.kernel.org>; Tue, 03 Sep 2013 10:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=X58p4AGf6r6Y+hDdZ2kfVFIEjUJsC1l08CnE7lhiXJk=;
        b=oVXT4MsEqX6iHP4HbGNngD8ZaMb+w+xlpjlO9KfKAIKsJ4R011Q8/PLZvXNnRUF+h6
         X9lfN0hIp6sbACXLI9AAJuSBp9UilldDVmObfxDiG8c0VgchSUdv/DGSwMNtH869VrfV
         qmCE5kAUokbYNS9COMNaNoTMAdqxIvBPaPrGvSZJeFlNNAIqm19D1f1Hhesh5Kn/ycG4
         d8C4EetCOukj18rYoq31c/EmJFqLFLBzsvmAd5J6BGJ3mZjo3dL0mR1vyPR1i7TWRFp4
         DEHXf3KwaJCow8vmnYXtWpu5ZsCKr/H1UBaENPY8pClxUYFYbBqv1t3nJ94KfG48UBoE
         VoDQ==
X-Received: by 10.68.88.131 with SMTP id bg3mr4030812pbb.195.1378227982301;
        Tue, 03 Sep 2013 10:06:22 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id xs1sm25251820pac.7.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 03 Sep 2013 10:06:21 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20130903170419.GA29921@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233738>

From: Felipe Contreras <felipe.contreras@gmail.com>

This way, if rev-parse segfaults then the test will fail instead
of treating it the same way as a controlled failure.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 t/t6101-rev-parse-parents.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t6101-rev-parse-parents.sh b/t/t6101-rev-parse-parents.sh
index c47b869..416067c 100755
--- a/t/t6101-rev-parse-parents.sh
+++ b/t/t6101-rev-parse-parents.sh
@@ -26,7 +26,7 @@ test_expect_success 'start^0' '
 '
 
 test_expect_success 'start^1 not valid' '
-	if git rev-parse --verify start^1; then false; else :; fi
+	test_must_fail git rev-parse --verify start^1
 '
 
 test_expect_success 'second^1 = second^' '
@@ -50,7 +50,7 @@ test_expect_success 'final^1^2 != final^1^1' '
 '
 
 test_expect_success 'final^1^3 not valid' '
-	if git rev-parse --verify final^1^3; then false; else :; fi
+	test_must_fail git rev-parse --verify final^1^3
 '
 
 test_expect_success '--verify start2^1' '
-- 
1.8.4

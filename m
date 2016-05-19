From: larsxschneider@gmail.com
Subject: [PATCH v1 0/2] travis-ci: enable Git SVN tests
Date: Thu, 19 May 2016 11:10:07 +0200
Message-ID: <1463649009-56941-1-git-send-email-larsxschneider@gmail.com>
Cc: e@80x24.org, Lars Schneider <larsxschneider@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 19 11:10:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b3JyJ-00045c-M7
	for gcvg-git-2@plane.gmane.org; Thu, 19 May 2016 11:10:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932677AbcESJKS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 May 2016 05:10:18 -0400
Received: from mail-wm0-f46.google.com ([74.125.82.46]:36327 "EHLO
	mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932594AbcESJKN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 May 2016 05:10:13 -0400
Received: by mail-wm0-f46.google.com with SMTP id n129so220667427wmn.1
        for <git@vger.kernel.org>; Thu, 19 May 2016 02:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=uBjVeLGNPQt0H0UyPGi2bfh3YJs6tpCQcVFElUg+5BM=;
        b=RrEbdjr88aPOyZ5z4p/R+VqvuJa5OKODu5GKY3SIxq+KylRzkEuMoZhNetAYAwvKIJ
         3Jbs3ysLQ/Y6gFhwK7lPc2b7kyqCcU1Vqf7iRCE/DILsVn1xEmLBKWbUJ2dcxfE03DDv
         Ve+Su1+ngWAohqep4SxhxKnVOF9ioFUdun2GhqV/E0MQnRhllBS+YtlDfa5uOd33frag
         b2EkaZbjVwffQo7+xzP2jagxzv0tNAdsAMfhX4IMGR492qSlXyP0iafBvBtCW9c4RfTI
         8+fKht4Fr136YfG+0POrjUbuSlEiIAoMt2388VgvNI4xHyIBrr0fnON1dbe30RviyyTz
         g8Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=uBjVeLGNPQt0H0UyPGi2bfh3YJs6tpCQcVFElUg+5BM=;
        b=Yq53If8n4tMQWtUeABW1fOPAga1K6ct3gjyiTn90+S9gT6XiKtLgPXmRPCDtNXN7/G
         afevkz0krGUoNKydAkTe+1uQNNWC1IH5LRONxpY86L/+QpsaLzFlXm5fuIFpGcVsNgl4
         aFGAvcOUzh1vES0XuRxKtaKgTcANnwLurYclQkSJFF/Jef6g16bOfAMZY+2aj7PSeCFM
         2NKNRtci0VxNxD2HqL7v5V1LQ4cnG+JdWnBfDdfmE9+xqkCE8N4iUnjuDRHy0AeQgghv
         CxdLmdKLWasbUaUqXuJAP81ofQH4YYJ1MtWrd02EnPz3VvGF7mRu+nN9A/p5nb91Oe+V
         D/Ww==
X-Gm-Message-State: AOPr4FW2xxCyFn/uTqg0lSxCOq/UFC/6eYSOZ4/kN28XuxHNrMFdv2kq4kdWnDHMbtFiug==
X-Received: by 10.28.57.85 with SMTP id g82mr36352410wma.3.1463649012096;
        Thu, 19 May 2016 02:10:12 -0700 (PDT)
Received: from slxBook3.fritz.box (p5DDB7732.dip0.t-ipconnect.de. [93.219.119.50])
        by smtp.gmail.com with ESMTPSA id n66sm13716029wmf.6.2016.05.19.02.10.10
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Thu, 19 May 2016 02:10:11 -0700 (PDT)
X-Mailer: git-send-email 2.5.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295049>

From: Lars Schneider <larsxschneider@gmail.com>

Hi,

this mini series enables SVN tests on Linux. Installing the Perl SVN libraries
was not that straight forward on OSX and therefore I skipped it (plus the OS X
tests take quite some time already).

The most notable change is the rename of two SVN test cases. I did that to
identify tests that need to run sequentially using prove [1]. Is this an
acceptable pattern? If yes, then I will document it in t/README.

Thanks,
Lars

[1] https://github.com/Perl-Toolchain-Gang/Test-Harness/pull/5

Lars Schneider (2):
  travis-ci: enable Git SVN tests t91xx on Linux
  travis-ci: enable sequential test execution for t9113 and 9126

 .travis.yml                                                           | 4 +++-
 ...-svn-dcommit-new-file.sh => t9113-git-svn-dcommit-new-file.seq.sh} | 0
 ...ctory.sh => t9126-git-svn-follow-deleted-readded-directory.seq.sh} | 0
 3 files changed, 3 insertions(+), 1 deletion(-)
 rename t/{t9113-git-svn-dcommit-new-file.sh => t9113-git-svn-dcommit-new-file.seq.sh} (100%)
 rename t/{t9126-git-svn-follow-deleted-readded-directory.sh => t9126-git-svn-follow-deleted-readded-directory.seq.sh} (100%)

--
2.5.1

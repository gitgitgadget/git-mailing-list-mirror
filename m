From: Chris Packham <judge.packham@gmail.com>
Subject: Ambiguous date handling
Date: Wed, 12 Sep 2012 21:35:50 +1200
Message-ID: <1347442551-7105-1-git-send-email-judge.packham@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 12 11:35:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TBjM5-0006s1-EJ
	for gcvg-git-2@plane.gmane.org; Wed, 12 Sep 2012 11:35:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755067Ab2ILJfZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Sep 2012 05:35:25 -0400
Received: from mail-oa0-f46.google.com ([209.85.219.46]:59780 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754496Ab2ILJfY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Sep 2012 05:35:24 -0400
Received: by oago6 with SMTP id o6so843053oag.19
        for <git@vger.kernel.org>; Wed, 12 Sep 2012 02:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:message-id:x-mailer;
        bh=DZ9i6z+iBbYt4pv7U9FrvV05loz/BtRIKSLKDAB0bJg=;
        b=W02qtjfQw8CaZ+lu+YmhwsqiOPmQGFGzUJbSExgVgSen74bkAHolX3mpuS3nYb9bwz
         RkblFN2f1MQlFYY9DmvnxQYNNM+ACFO+68xTtdHVEz004v0ylbDnUPnnHcBAhEPaNWPk
         wS/k8JmaPFAOwMFz/qLbjvC52zyMCw3eizKRHzvSGCGTiiAPHvTQ1RiU1lCLBMCp0PFh
         6y75ykVpFRpzAq6+yzkmTCrI6+pmMvAwy1HoOULzSIuHDcQ+cs4HKHd3X8cIUkXuk8Tp
         Xk+vOvSHt3w3oPFooXYvRGkctmCo1r6qckPPRN4WBZCkdat+i9610fUx5hE51CZln19U
         vo3A==
Received: by 10.182.78.161 with SMTP id c1mr21294495obx.88.1347442523440;
        Wed, 12 Sep 2012 02:35:23 -0700 (PDT)
Received: from localhost.localdomain (115-188-15-163.jetstream.xtra.co.nz. [115.188.15.163])
        by mx.google.com with ESMTPS id j10sm15693057oej.10.2012.09.12.02.35.20
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 12 Sep 2012 02:35:22 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205273>

Hi,

I think this has come up before [1],[2] but we ran into this at $dayjob today.
Our default MUA has an annoying habit of using a non RFC822 date format when
saving an email as plaintext. This means the first 12 days of every month we
run into the ambiguous date problem (our date convention is dd/mm/yy).

I see code in date.c for refusing a date in the future which would have caught
this but it doesn't appear to be working for us.

Following this is a patch adding a testcase for this. With the following
results:

  ok 1 - apply patch with ambiguous date
  not ok 2 - check ambiguous date # TODO known breakage
  ok 3 - apply patch with european date separator
  ok 4 - check european date
  # still have 1 known breakage(s)
  # passed all remaining 3 test(s)
  1..4

Thanks,
Chris

--
[1] - http://thread.gmane.org/gmane.comp.version-control.git/18412/focus=18417
[2] - http://thread.gmane.org/gmane.comp.version-control.git/84512/focus=85735

From: larsxschneider@gmail.com
Subject: [PATCH v6 0/6] Add Travis CI support
Date: Thu, 19 Nov 2015 09:58:05 +0100
Message-ID: <1447923491-15330-1-git-send-email-larsxschneider@gmail.com>
Cc: luke@diamand.org, sunshine@sunshineco.com, gitster@pobox.com,
	peff@peff.net, Lars Schneider <larsxschneider@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 19 09:58:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZzL2w-0001tC-9V
	for gcvg-git-2@plane.gmane.org; Thu, 19 Nov 2015 09:58:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756346AbbKSI6Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Nov 2015 03:58:16 -0500
Received: from mail-wm0-f49.google.com ([74.125.82.49]:33048 "EHLO
	mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754723AbbKSI6P (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Nov 2015 03:58:15 -0500
Received: by wmec201 with SMTP id c201so14474195wme.0
        for <git@vger.kernel.org>; Thu, 19 Nov 2015 00:58:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=iB76IsFSIcOFpBFMtf1aV/7okHdLWWRhX0AfJ7ihom0=;
        b=EI7A5AGABRVADjJzLNN2zedczCBCkNSwCdR3kQjorsrYUVEuB0GN1CksfhWBHf9If+
         OSUh7vMRca6ynMe8Rsoj/QStawq/6DzxDbHqn+ASu3C07NQRNfRKPzFJDGBuWtp6Kol9
         e0kkV6dQSvscPgok5P4L1Cqy3c7AsvCHoalqOfAr4SBc7Un6sYsRlMktJI3cVhOUtk/8
         eARmd697Z6ao+OZXxucEm8IoliNLeA9csfWQjUmmR6i526QnYtUncOCAqMngk3xsn4F7
         xVYSRvI6cOqs093lrXQ9TBF4rLQBbcXkTJsPJ8+PjMdqgnVAy+kKA5ydFmi7sG4zAq6p
         UCvw==
X-Received: by 10.194.188.6 with SMTP id fw6mr7611302wjc.95.1447923494660;
        Thu, 19 Nov 2015 00:58:14 -0800 (PST)
Received: from slxBook3.fritz.box (p5DDB77F3.dip0.t-ipconnect.de. [93.219.119.243])
        by smtp.gmail.com with ESMTPSA id m64sm7237965wmf.14.2015.11.19.00.58.12
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 19 Nov 2015 00:58:13 -0800 (PST)
X-Mailer: git-send-email 2.5.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281466>

From: Lars Schneider <larsxschneider@gmail.com>

diff to v5:
* check if PID file still exists on P4D cleanup (thanks Luke)
* fix space/tab formatting error
* add sleep to timeout loops (thanks Luke)
* replace 'date +%s' with platform independent Python function (thanks Eric and Luke)

With the patches of this series the Travis CI test stability increases.
However, as I am "stress testing" the Travis CI infrastructure you can
see that it is not perfect: https://travis-ci.org/larsxschneider/git/builds

Nevertheless, I believe that Travis CI integration has still value as
contributors can test their patches easily on Linux and OS X before
posting them.

@junio / @peff: Do you consider merging this?

Thanks,
Lars

Lars Schneider (6):
  implement test_might_fail using a refactored test_must_fail
  add "ok=sigpipe" to test_must_fail and use it to fix flaky tests
  git-p4: retry kill/cleanup operations in tests with timeout
  git-p4: add p4d timeout in tests
  git-p4: add trap to kill p4d on test exit
  Add Travis CI support

 .travis.yml                     | 131 ++++++++++++++++++++++++++++++++++++++++
 t/lib-git-p4.sh                 |  71 +++++++++++++++++++---
 t/t5504-fetch-receive-strict.sh |   3 +-
 t/t5516-fetch-push.sh           |   6 +-
 t/test-lib-functions.sh         |  39 +++++++-----
 5 files changed, 221 insertions(+), 29 deletions(-)
 create mode 100644 .travis.yml

--
2.5.1

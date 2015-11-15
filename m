From: larsxschneider@gmail.com
Subject: [PATCH v5 0/6] Add Travis CI support
Date: Sun, 15 Nov 2015 14:08:34 +0100
Message-ID: <1447592920-89228-1-git-send-email-larsxschneider@gmail.com>
Cc: sunshine@sunshineco.com, gitster@pobox.com,
	Lars Schneider <larsxschneider@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 15 14:09:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zxx3Y-0002cC-1d
	for gcvg-git-2@plane.gmane.org; Sun, 15 Nov 2015 14:09:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751406AbbKONIo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Nov 2015 08:08:44 -0500
Received: from mail-wm0-f44.google.com ([74.125.82.44]:33815 "EHLO
	mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751272AbbKONIn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Nov 2015 08:08:43 -0500
Received: by wmvv187 with SMTP id v187so140224561wmv.1
        for <git@vger.kernel.org>; Sun, 15 Nov 2015 05:08:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=AUzr/x6Tm2EswaUeFPLHujSxgwKkMi4ju45NwcR2gww=;
        b=SE4aW8ExYqzM0aIPtLR2q3MdIFIJdS1E5MBW5B+J6AS67GtEl8fQo//AazElxn30u+
         2d8hxKYmPYF6jMfuf85dbPUEwLH/wfJ1iH5skVTCc4+RSSJB5ydad+tbaYpjLfGQFtrW
         o+22mJbST9DBrXNP1jNnWrcCQzcjnZH8RsziDWf2almeJMjCCVaEr2e653wwfsag7vGu
         6XIvnApfa/1/cdQ/eZ897mxhXXlg1NKCYoEc5A5fombGPuO267Dy0s+0GGaOErfnvEKA
         nnDrEURL7GcK+zcg2ov+F/sS+c5KuQky9+Ih5rQ82CClAijQPCwYIzuAaIiMjRfymY4d
         XYJg==
X-Received: by 10.28.139.18 with SMTP id n18mr14529621wmd.63.1447592922617;
        Sun, 15 Nov 2015 05:08:42 -0800 (PST)
Received: from slxBook3.fritz.box (p5DDB712F.dip0.t-ipconnect.de. [93.219.113.47])
        by smtp.gmail.com with ESMTPSA id t2sm13472567wme.0.2015.11.15.05.08.41
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 15 Nov 2015 05:08:41 -0800 (PST)
X-Mailer: git-send-email 2.5.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281315>

From: Lars Schneider <larsxschneider@gmail.com>

diff to v4:
* add Junio's "test_must_fail ok=" refactor that he sent as response
  to my patch. Did I attribute this to Junio in the right way by adding
  "Signed-off-by: Junio C Hamano <gitster@pobox.com>" to the commit message?
  Please let me know how to handle these cases properly!
* fix commit message wording according to Junio's suggestion
* do not accept sigpipe failures in "git cat-file" (thanks Junio)
* reorder patches (thanks Eric)
* fix incorrect space indent (thanks Eric)
* add a trap to git-p4 tests that ensure p4d is always killed

You can see the CI results for this patch applied on master here:
https://travis-ci.org/larsxschneider/git/builds/91216501

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
 t/lib-git-p4.sh                 |  57 ++++++++++++++---
 t/t5504-fetch-receive-strict.sh |   3 +-
 t/t5516-fetch-push.sh           |   6 +-
 t/test-lib-functions.sh         |  39 +++++++-----
 5 files changed, 207 insertions(+), 29 deletions(-)
 create mode 100644 .travis.yml

--
2.5.1

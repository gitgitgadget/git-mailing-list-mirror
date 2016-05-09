From: Armin Kunaschik <megabreit@googlemail.com>
Subject: t4151 missing quotes
Date: Mon, 9 May 2016 18:09:45 +0200
Message-ID: <CALR6jEiBsU+jQ8VoRsniMdztCpVDemQ3r00W-OXdRP6ZEt9CFg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 09 18:17:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aznkk-0002lZ-EZ
	for gcvg-git-2@plane.gmane.org; Mon, 09 May 2016 18:09:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751511AbcEIQJq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 May 2016 12:09:46 -0400
Received: from mail-yw0-f195.google.com ([209.85.161.195]:34417 "EHLO
	mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750916AbcEIQJq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 May 2016 12:09:46 -0400
Received: by mail-yw0-f195.google.com with SMTP id i22so23652377ywc.1
        for <git@vger.kernel.org>; Mon, 09 May 2016 09:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to;
        bh=0yjr1irgneDigdCWvWAXIge6hPuJhMvZY32yAVclr8A=;
        b=K/7xnqty9F3k7mkXUiiLPccubhoVuCUC9hrinUvq+DZvJTEM37gr2XGSWQvxkNtfgd
         wd+AGEuce09eW5AWvXgPWHcd5tksoA8a9YRZJvC6D4UUKn2/okMqJP9iKaQ3KFeWqNL0
         ykuejSjDDtBfPDfHUbATlPeP1HxE/QWSzX8L50PV1wb4sNSU/FZfb75excDUMzYWkxa7
         VgYQHpTs1usuZiVoL8ZiCE4029K3LRdF+lkX6Q0JCk0TqPVa4COn9s8IySkPvnBfaYT/
         rvqIrGd/peojx8VsR6T5Cclp78YMFnwBfCMnwKFfLW9/HVlyYO75jVWoiWIXE4sbOl0Y
         Kp8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=0yjr1irgneDigdCWvWAXIge6hPuJhMvZY32yAVclr8A=;
        b=IWLOzcLCU3nSUp8cTcEAmx7/xb3upppoFyQJey9FiopW/XCHJFQh2cFacX8yDvJmDb
         RQwYU1noqFpKNY9fw+Y8ajrTCosOKg3MqiKJLb2og1dYKjVOZizOHua/vkgHW35fKBkV
         3MZ41gy+1Bf974UTGkxIkzP/OgjRU1AWMVtQ0+15BQfp0rA5odmXHuS2E/ChlRN0vWYr
         0U+m0HhNRSTYlfgQtNVD8LZGMLjhKQgsaPEPRlnIOSGM2o6m3nxv18UhCXM7AHaRiT+M
         S3qhHmTGf3Jk8jGo+TC8XGY30iOiy6xHChAn1ky/r5tJ9s/lIWO8oVJ5vB54v1pcE2tO
         9cGw==
X-Gm-Message-State: AOPr4FUs52/ivV/ZexOcWFOmg5wAMO3P78YFK5aoVeYKM4hOflwC9FpIndWpJ6FqlYeRT5W8hA5xlhThsXbPJg==
X-Received: by 10.37.204.142 with SMTP id l136mr20315060ybf.13.1462810185169;
 Mon, 09 May 2016 09:09:45 -0700 (PDT)
Received: by 10.129.45.132 with HTTP; Mon, 9 May 2016 09:09:45 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294004>

Hi there,

skipping through some failed tests I found more (smaller) problems
inside the test... when test arguments are empty they need to be
quoted (quite a lot test in this sentence).

Error is like
t4151-am-abort.sh[5]: test: argument expected

My patch:

*** t4151-am-abort.sh   Mon May  9 17:51:44 2016
--- t4151-am-abort.sh.orig      Fri Apr 29 23:37:00 2016
***************
*** 67,73 ****
  test_expect_success 'am -3 --skip removes otherfile-4' '
        git reset --hard initial &&
        test_must_fail git am -3 0003-*.patch &&
!       test 3 -eq "$(git ls-files -u | wc -l)" &&
        test 4 = "$(cat otherfile-4)" &&
        git am --skip &&
        test_cmp_rev initial HEAD &&
--- 67,73 ----
  test_expect_success 'am -3 --skip removes otherfile-4' '
        git reset --hard initial &&
        test_must_fail git am -3 0003-*.patch &&
!       test 3 -eq $(git ls-files -u | wc -l) &&
        test 4 = "$(cat otherfile-4)" &&
        git am --skip &&
        test_cmp_rev initial HEAD &&
***************
*** 78,88 ****
  test_expect_success 'am -3 --abort removes otherfile-4' '
        git reset --hard initial &&
        test_must_fail git am -3 0003-*.patch &&
!       test 3 -eq "$(git ls-files -u | wc -l)" &&
        test 4 = "$(cat otherfile-4)" &&
        git am --abort &&
        test_cmp_rev initial HEAD &&
!       test -z "$(git ls-files -u)" &&
        test_path_is_missing otherfile-4
  '

--- 78,88 ----
  test_expect_success 'am -3 --abort removes otherfile-4' '
        git reset --hard initial &&
        test_must_fail git am -3 0003-*.patch &&
!       test 3 -eq $(git ls-files -u | wc -l) &&
        test 4 = "$(cat otherfile-4)" &&
        git am --abort &&
        test_cmp_rev initial HEAD &&
!       test -z $(git ls-files -u) &&
        test_path_is_missing otherfile-4
  '

***************
*** 146,152 ****
        git reset &&
        rm -f otherfile-4 otherfile-2 file-1 file-2 &&
        test_must_fail git am -3 initial.patch 0003-*.patch &&
!       test 3 -eq "$(git ls-files -u | wc -l)" &&
        test 4 = "$(cat otherfile-4)" &&
        git am --abort &&
        test -z "$(git ls-files -u)" &&
--- 146,152 ----
        git reset &&
        rm -f otherfile-4 otherfile-2 file-1 file-2 &&
        test_must_fail git am -3 initial.patch 0003-*.patch &&
!       test 3 -eq $(git ls-files -u | wc -l) &&
        test 4 = "$(cat otherfile-4)" &&
        git am --abort &&
        test -z "$(git ls-files -u)" &&

Regards,
Armin

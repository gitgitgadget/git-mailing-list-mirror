Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5ACF520248
	for <e@80x24.org>; Wed, 27 Feb 2019 09:49:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728963AbfB0Jtc (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Feb 2019 04:49:32 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38311 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726617AbfB0Jtb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Feb 2019 04:49:31 -0500
Received: by mail-wm1-f67.google.com with SMTP id v26so4917528wmh.3
        for <git@vger.kernel.org>; Wed, 27 Feb 2019 01:49:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding:user-agent;
        bh=pflGP9EE60FUw4DFHGItr6MVF+HJ8XvOl23Q8IDFTrM=;
        b=L8m06yvdTVkIz105ZRzaacMPgEm3NG/cUIzkZnHLZlXaTUTa4nVtcbujCgRZTR0rAu
         cymOroIzyupjoqkNRJ8PmBFRP8t0BHw4Ic7/k6krP7u9XrKfEvw9iL0CpUoyDCcraBPn
         pN7ri1vi5x7QM5cdmIRnbAYnArHRT6VzzndCxhgNoWE9nZIqfdSiXW0E/LYqn2pwJQAs
         3h5zh+05cV2+1pUCydfKFBmGxBondiy8qEBMxh08xbaHQk1uGjQzmJ9grVRdZkdtDtN9
         xcVjndcybimiUu9UQ9WqC3LKEI+6lfPenN+pGCFyvF86q16CGCFuU+5PQgXqPu2QrE7C
         Ck2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding:user-agent;
        bh=pflGP9EE60FUw4DFHGItr6MVF+HJ8XvOl23Q8IDFTrM=;
        b=m23x4atMMMp1tdIhh36YK2ri0GxkhMzNU8NlUM8lsot9ewLMJwzG6MO7MMbZz92YV7
         Bg7xBU2s/B9W5P03ZykT9EtEqAU1JgQto29b2hqYlzifi0p36VArExh4crfxajt71za4
         WVw7cYFqoyOOAdAqoQUMKmpJT5RFCZHZZWmsUczrOluxtlr+kT6f0ZBTfWWYzwFLvDKG
         /Sw72jdFjTh8TlSVc+g0Ms2kVBHt98isYWRpzmBWRwK8EYx+/kOstktkB5HIuSWUctdn
         h6+aZKgaKIrKZ6qpZObHLHvPxW3XiIfkErCI6Db1wbn24zwT3gfCKO2l3A3DovhBHyxL
         eKFg==
X-Gm-Message-State: AHQUAuYxzDddGCylRUOgYxsiXy3EyVPrB8S8HQTk/viiNGt9+M/1tEzR
        jun0HgQqTf30HGa5PReKOtVCheGf
X-Google-Smtp-Source: APXvYqzfalRWlohHWqj8CLgRE5REZtzise7tQ67UAmKkNaAi6zZ4mHCWQEwQuQhALbRiE9WBukMNNw==
X-Received: by 2002:a1c:f901:: with SMTP id x1mr1214546wmh.51.1551260968658;
        Wed, 27 Feb 2019 01:49:28 -0800 (PST)
Received: from szeder.dev (x4db6969d.dyn.telefonica.de. [77.182.150.157])
        by smtp.gmail.com with ESMTPSA id z15sm28891060wrh.18.2019.02.27.01.49.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Feb 2019 01:49:27 -0800 (PST)
Date:   Wed, 27 Feb 2019 10:49:26 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Luke Diamand <luke@diamand.org>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Occasional git p4 test failures because of stray fast-import
 processes
Message-ID: <20190227094926.GE19739@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Luke,

I saw rare failures in test 6 'git p4 sync uninitialized repo' in
't9800-git-p4-basic.sh' on Travis CI, because the 'cleanup_git'
function failed to do its job.  The (redacted) trace looks like this:

  + cleanup_git
  + retry_until_success rm -r /home/szeder/src/git/t/trash directory.t9800-git-p4-basic/git
  + time_in_seconds
  + cd /
  + /usr/bin/python -c import time; print(int(time.time()))
  + timeout=1551233042
  + rm -r /home/szeder/src/git/t/trash directory.t9800-git-p4-basic/git
  + test_must_fail test -d /home/szeder/src/git/t/trash directory.t9800-git-p4-basic/git
  test_must_fail: command succeeded: test -d /home/szeder/src/git/t/trash directory.t9800-git-p4-basic/git
  + eval_ret=1
  + :
  not ok 6 - git p4 sync uninitialized repo

Trying to reproduce this failure with stock Git can be tricky: I've
seen

  ./t9800-git-p4-basic.sh --stress -r 1,2,6,22

fail within the first 10 tries, but it also run overnight without a
single failure...  However, the following two-liner patch can reliably
trigger this failure:

diff --git a/fast-import.c b/fast-import.c
index b7ba755c2b..54715018b3 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -3296,6 +3296,7 @@ int cmd_main(int argc, const char **argv)
 		rc_free[i].next = &rc_free[i + 1];
 	rc_free[cmd_save - 1].next = NULL;
 
+	sleep(1);
 	start_packfile();
 	set_die_routine(die_nicely);
 	set_checkpoint_signal();
diff --git a/t/lib-git-p4.sh b/t/lib-git-p4.sh
index b3be3ba011..2d2ef50bfa 100644
--- a/t/lib-git-p4.sh
+++ b/t/lib-git-p4.sh
@@ -190,6 +190,7 @@ kill_p4d () {
 
 cleanup_git () {
 	retry_until_success rm -r "$git"
+	sleep 2
 	test_must_fail test -d "$git" &&
 	retry_until_success mkdir "$git"
 }


What's going on is this: 'git p4' invokes 'git fast-import' via
Python's subprocess.Popen(), and then there are two chain of events
racing with each other:

  - In the foreground:
  
    - 'git p4' notices that there are no p4 branches and die()s as
      expected, but leaves its child fast-import behind
    - 'test_i18ngrep' quickly verifies that 'git p4' died with the
      expected error message
    - the cleanup function removes the "$TRASH_DIRECTORY/git"
      directory, and
    - checks that the directory is indeed gone.

  - Meanwhile in the background:
  
    - 'git fast-import' starts up, kicks off the dashed external
      'git-fast-import' process,
    - which opens a tmp packfile in "$TRASH_DIRECTORY/git" for writing
      (the start_packfile() call in the patch context above), creating
      any leading directories if necessary,
    - notices that its stdin is closed (because 'git p4' died) and it
      has nothing left to do, so
    - it cleans up and exits.  Note that this cleanup only removes the
      tmp packfile, but leaves any newly created leading directories
      behind.

While unlikely, it does apparently happen from time to time that the
test's cleanup function first removes "$TRASH_DIRECTORY/git", but then
'git fast-import' re-creates it for its packfile before the cleanup
function checks the result of the removal.  The two well-placed
sleep()s in the patch above force such a problematic scheduling.

There are 4 test cases running 'test_must_fail git p4 sync': the above
patch triggers a failure in 3 of them, and with a bit of extra modding
I could trigger a failure in the fourth one as well.

We could work this around by waiting for 'git p4' and all its child
processes in the affected tests themselves, using the same shell
trickery as in ef09036cf3 (t6500: wait for detached auto gc at the end
of the test script, 2017-04-13), but this feels like, well, a
workaround.

I think the proper solution would be to ensure that 'git p4' kills and
waits for all its child processes when die()ing.  Alternatively (or in
addition?), it could perform all the necessary sanity-checking (and
potential die()ing) before starting the 'git fast-import' process in
the first place.

I've glanced through all subprocess.Popen() callsites in 'git p4' and
found most of them OK, in the sense that they wait for whatever child
process they create.  Alas, there was one exception: p4CmdList() can
invoke an optional callback function before wait()ing on its 'p4'
child, and the streamP4FilesCb() callback function can die() without
waiting for the 'p4' process (but it does wait() for 'git
fast-import'!).

On a related note: this check for the just-removed directory was added
in 23aee4199a (git-p4: retry kill/cleanup operations in tests with
timeout, 2015-11-19), which mentions flaky cleanup operations.
Perhaps this is the same flakiness?!

Anyway, as I mentioned elsewhere before, I have no idea why/how 'git
p4' works, so I'll leave it up to you how it's best to deal with this
issue...


Gábor


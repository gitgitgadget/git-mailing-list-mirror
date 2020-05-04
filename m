Return-Path: <SRS0=JCNZ=6S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6D70C3A5A9
	for <git@archiver.kernel.org>; Mon,  4 May 2020 07:03:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1F46215A4
	for <git@archiver.kernel.org>; Mon,  4 May 2020 07:03:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FMajQU3o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727993AbgEDHD3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 May 2020 03:03:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726410AbgEDHD2 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 4 May 2020 03:03:28 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B706AC061A0E
        for <git@vger.kernel.org>; Mon,  4 May 2020 00:03:28 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id u189so10301427ilc.4
        for <git@vger.kernel.org>; Mon, 04 May 2020 00:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=8HAQvH2GSBzSfoF5nhH4bQfFOps+sQSuMZ6hM0fBx7E=;
        b=FMajQU3oPgLBe3ZhmZ4WHqNMA7p6NOwj04qoFcOe4PRMtUhziWrgXMMuHcgWFSBueL
         9npocc/WbhO9plGg+Y07VTT7DyUfMpfwxSd81oy5EsjEakju4x4UD1m7wDfR+UXhGYkR
         pwciOdc97cQE3sy83pR6/dQAxQiWlUrhaqD9CYodAGCj6cf6Obg7gmo/mQvpHGYcHr4b
         g8bLPREBl6XAx/KDFJae6D5QToi3Y4Cd5gkS0Dmgsow8B6XM6AZ6zfWuQ5v5Mqlc7XOs
         Hrd3QHv5fyUcArIhTdEugqKI9uWMrDSwX7AqUP+XS/y8U0qSwwcUy9Vu30higK0IWp5E
         fJdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=8HAQvH2GSBzSfoF5nhH4bQfFOps+sQSuMZ6hM0fBx7E=;
        b=pQ0zIjvDUFNdIBEJ37mrh+PUlQ11g4rRtrIU971MD7W8kbV+Co6GwohASckhPJdTrV
         frkeY7bLjxughHcEmDgbkYPG3o3YIntnb+dYXrZCJGSDxu0mZtAaHBYOUygwenMvyCDf
         m8Xtit/tpXXSk002aDA/auri96r/jDnPnDWnt9lxsqMEJnMZ32jstQNOBJ3vjitumyJD
         fujI0qBYFYBpli9MG/sMtl7zT6JzppsJlyQcOzqwDB5y1+XLW8+qm5EaEa8ousR+1Dor
         s7UBzD/yVpsJek9eJJ3dBWfvddCXvRzSgPo5YuoBjZvPQayZeqdHjPM0HwlWvIEoy9g+
         8n1A==
X-Gm-Message-State: AGi0PuZspcYT09Xy3Abd4ZSlyoHOEzNnxFpeByAPYJe77Aw3SvH8kdIz
        J+5scgXZA9VWih4N6n7wDfy7rIFJBSioN6Wn1XNF2Nhr
X-Google-Smtp-Source: APiQypLu65nKP5jUa8CPafDsW0ni/R/eYRR3ezpAkO/9q7O52gdqKviKTqRHz/Ut9MNqxAsTc+mOhJ96z0Odu1bFCzY=
X-Received: by 2002:a92:ddca:: with SMTP id d10mr15506635ilr.166.1588575807579;
 Mon, 04 May 2020 00:03:27 -0700 (PDT)
MIME-Version: 1.0
Reply-To: noloader@gmail.com
From:   Jeffrey Walton <noloader@gmail.com>
Date:   Mon, 4 May 2020 03:03:01 -0400
Message-ID: <CAH8yC8myTMOetxgaj1wt0MbvSQ0LSRV0FHz4ywsBM1zzhUQG=w@mail.gmail.com>
Subject: Git 2.26.2 and failed self tests on OS X
To:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Everyone,

I'm building Git 2.26.2 from sources on a Mac-mini with OS X 10.12.6
and a PowerMac with OS X 10.5. Some of the t3902-quoted.sh tests are
failing.

The Mac-Mini uses Bash 3.2.57(1)-release. The PowerMac uses 3.2.17(1)-release.

Jeff

*** t3902-quoted.sh ***
not ok 1 - setup
#
#
#               mkdir "$FN" &&
#               for_each_name "echo initial >\"\$name\"" &&
#               git add . &&
#               git commit -q -m Initial &&
#
#               for_each_name "echo second >\"\$name\"" &&
#               git commit -a -m Second &&
#
#               for_each_name "echo modified >\"\$name\""
#
#
ok 2 - setup expected files
not ok 3 - check fully quoted output from ls-files
#
#
#               git ls-files >current && test_cmp expect.quoted current
#
#
not ok 4 - check fully quoted output from diff-files
#
#
#               git diff --name-only >current &&
#               test_cmp expect.quoted current
#
#
not ok 5 - check fully quoted output from diff-index
#
#
#               git diff --name-only HEAD >current &&
#               test_cmp expect.quoted current
#
#
not ok 6 - check fully quoted output from diff-tree
#
#
#               git diff --name-only HEAD^ HEAD >current &&
#               test_cmp expect.quoted current
#
#
not ok 7 - check fully quoted output from ls-tree
#
#
#               git ls-tree --name-only -r HEAD >current &&
#               test_cmp expect.quoted current
#
#
ok 8 - setting core.quotepath
not ok 9 - check fully quoted output from ls-files
#
#
#               git ls-files >current && test_cmp expect.raw current
#
#
not ok 10 - check fully quoted output from diff-files
#
#
#               git diff --name-only >current &&
#               test_cmp expect.raw current
#
#
not ok 11 - check fully quoted output from diff-index
#
#
#               git diff --name-only HEAD >current &&
#               test_cmp expect.raw current
#
#
not ok 12 - check fully quoted output from diff-tree
#
#
#               git diff --name-only HEAD^ HEAD >current &&
#               test_cmp expect.raw current
#
#
not ok 13 - check fully quoted output from ls-tree
#
#
#               git ls-tree --name-only -r HEAD >current &&
#               test_cmp expect.raw current
#
#
# failed 11 among 13 test(s)
1..13
make[2]: *** [t3902-quoted.sh] Error 1
make[1]: *** [test] Error 2
make: *** [test] Error 2

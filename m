Return-Path: <SRS0=caIn=3X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43232C33C9E
	for <git@archiver.kernel.org>; Mon,  3 Feb 2020 04:08:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1598D2073C
	for <git@archiver.kernel.org>; Mon,  3 Feb 2020 04:08:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yf2uW4j0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727297AbgBCEIa (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 2 Feb 2020 23:08:30 -0500
Received: from mail-il1-f172.google.com ([209.85.166.172]:44933 "EHLO
        mail-il1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727096AbgBCEI3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Feb 2020 23:08:29 -0500
Received: by mail-il1-f172.google.com with SMTP id s85so7983712ill.11
        for <git@vger.kernel.org>; Sun, 02 Feb 2020 20:08:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=sKDG0GASpEw3pbNHtdxf/k+J7qv2hDBDMMUe2/0eJ/M=;
        b=Yf2uW4j0dm6O6Ez5wDNJln8LRiooUl7aDeLxaqC24xT1lMmHuC4mSOs3Uo3evPh3Io
         TsQeaFrsLbasyTK0uOdlq3mshdXd0enVTqP9YC1zK6srLNw1dUDtMgv0rtoTfI/VZXG8
         oBH+eChxsTwALtHrBDgyajGmH+Q5NPkwLoLwejAKDtOKYpxfzO/V/e8BdBCE7gLTKo9E
         BYzsWDGBOm3X38fhMsXYP1r76f/2fkYq9QYoZFmc5oSkbj40TDyNB7pnYy6JoZ2XO5Ba
         E8/8SNzJbkrjdicxSpmLOgZmUBxonAB2fZWKrssBKk1cTCtwO53nLmmvZD8vaYc/qu9B
         c5qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=sKDG0GASpEw3pbNHtdxf/k+J7qv2hDBDMMUe2/0eJ/M=;
        b=VJulb2fc6uQkW1MGzScpAXedNDut7W1gu+REppsdAb2oXy436bcR5zYqY7rceFcTYe
         gWRXT227DkPsuIIrK4MJcjJAp1v0YhMaXigSsJ5XFJwBHbHPjEQaNRPkhavugBVzVeIv
         oj7wX8Og+C7dj1R0ucS96rL5z/+4oUYO7g0yFbpJK+I2wFsw4Yywm3XWoDMM5Onojy17
         9ExOL5/oGmyW+OMrhFxqPksuDhcDDbYjoQAYOrhP3hJLYegs5LT7TM978FDOOfAxKk3I
         HvJj+8Uf5SujgghMw9kH7LfOuTzKqvc1uyS2BfOqZj2fY3u+CFU3sLQ95k+51O6yU9bT
         YdtQ==
X-Gm-Message-State: APjAAAVusn4mKNmWzezOut9bUBrqddxslUMOTuQntSQvwNcr9cxQzpxx
        TuExX5RLjYQLSzG9OYBkE0zXBMfCjNib2pbirv1Io61+
X-Google-Smtp-Source: APXvYqy0sv1CuaYDh1lPX+ee7n7sGrchN41W7kPhmSywwgXFe+WwgtJFOVB/g+/HWQ7Fg6nJsrES/ASppFFJeTDl6uc=
X-Received: by 2002:a92:9857:: with SMTP id l84mr13633286ili.41.1580702907665;
 Sun, 02 Feb 2020 20:08:27 -0800 (PST)
MIME-Version: 1.0
Reply-To: noloader@gmail.com
From:   Jeffrey Walton <noloader@gmail.com>
Date:   Sun, 2 Feb 2020 23:08:17 -0500
Message-ID: <CAH8yC8kXPi0teqdZ8NRJ677Z6btbmdafR=y4MFFaKZgZrB=d4A@mail.gmail.com>
Subject: Git 2.25 and failed self tests on OS X
To:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Everyone,

I'm seeing some self-tests failures building the 2.25 release tarball
on OS X. I'm seeing it on the old PowerMac with OS X 10.5, and a
modern Intel Mac with OS X 10.9. PowerMac failures are not too
surprising, but the modern Mac should probably pass its self tests.

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

Setting LC_ALL=en_US.UTF-8 and LANG=en_US.UTF-8 did not help. (I've
seen sed and awk produce unusual results when they are not set).

Jeff

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 682B2C433B4
	for <git@archiver.kernel.org>; Thu, 20 May 2021 02:03:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 444D660FE3
	for <git@archiver.kernel.org>; Thu, 20 May 2021 02:03:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230310AbhETCEm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 May 2021 22:04:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbhETCEl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 May 2021 22:04:41 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA024C061574
        for <git@vger.kernel.org>; Wed, 19 May 2021 19:03:20 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id j6so19347012lfr.11
        for <git@vger.kernel.org>; Wed, 19 May 2021 19:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oFHf39ulHdz2evw78BbbeY886KyqGqC4BWpe0YNlIHs=;
        b=EXCE5tdEf8RLb6EYUcgCvXEzrJM+HMOpUvVtKgilLjKwiUFr7QEG9PYD7DOxw2WbeV
         eeVydehP5EyqxL3k3MStTYAdcfbzZQSpNy04u5/pCb8mD5ycoqnEQ/VUzVVDI8gw107W
         gVUpIAgZww0ruSHlnwoKe8pclIfarxtl204PfywM714brQzri9iA0N20yAocCpF18Jg/
         TTzwNAdbkLo0/uIC4SyJlMAqaRQ4URsro1Y2Qe/U8WvG9be7KTswxkhopnNlF7K0uj1o
         HCI6dwbZ/vqM/AuOYvjJgzaK4U3Y4kZ8s3qtRjo3rkFL0mvkN+mYOKXxL9M7uy2lcVkH
         01Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oFHf39ulHdz2evw78BbbeY886KyqGqC4BWpe0YNlIHs=;
        b=n2wUlLp7fZRkAgSVpIn2v1rHLPNyMriBCJntFSc/Y+E7xftbLJ+ln4Qlsl/cAQrEqb
         v0seZhP2MFQMAPeBiMYgHg01QKmZv6L0UAtW2zJB5I8zJ1pyZiagiHVChetpD5INzNOM
         ccGciC8sHfyPgrmGjOlu4WeoQckU+88n3h9Qt1Z6xVtczEIoxmq/cR5WLPK/VyBL6oat
         JhhJzfdUTegfn417gjS1SAdF2toUMw6nEFUG9kFLeu8IA8GjGS2VzE4ReQtNtu/l4DrS
         /4mmpwVu1dT8Pc3jlZAordbNaiBweHDx4OInQ0o1bLA/QHeLdEckQsIL/kyWAzucriqd
         zGPA==
X-Gm-Message-State: AOAM53254IvYijhGUzzzV5HZLTNNRbLrvWFznfy6mIkyeIpBAmRTLm6p
        ecyHTjtUP1OhpvPti9Ty5f77qZ18HsFVr/Vp9ZvOv+lMOnnnbg==
X-Google-Smtp-Source: ABdhPJzNDUSpxDe1Jos3ErfbKGdj8antcgG1UmEAHvgPQb3D4gI4Xif+v62rFNjL11skRRIg5ENCGhFaMvTpwOFyxCw=
X-Received: by 2002:a05:6512:34d1:: with SMTP id w17mr1674207lfr.357.1621476199109;
 Wed, 19 May 2021 19:03:19 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1621451532.git.ps@pks.im> <5488f0f4888fbc46378e2777d7daba1ec627b6c6.1621451532.git.ps@pks.im>
In-Reply-To: <5488f0f4888fbc46378e2777d7daba1ec627b6c6.1621451532.git.ps@pks.im>
From:   Chris Torek <chris.torek@gmail.com>
Date:   Wed, 19 May 2021 19:03:08 -0700
Message-ID: <CAPx1GvfggYr2nddcsTdD2JdtgEN9aoNF-aWQo-RQQh5-TowGdg@mail.gmail.com>
Subject: Re: [PATCH 1/8] perf: fix when running with TEST_OUTPUT_DIRECTORY
To:     Patrick Steinhardt <ps@pks.im>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 19, 2021 at 1:21 PM Patrick Steinhardt <ps@pks.im> wrote:
> When the TEST_OUTPUT_DIRECTORY is defined, then all test data will be
> written in that directory instead of the default directory located in
> "t/". While this works as expected for our normal tests, performance
> tests fail to locate and aggregate performance data because they don't
> know to handle TEST_OUTPUT_DIRECTORY correctly and always look at the
> default location.
>
> Fix the issue by adding a `--results-dir` parameter to "aggregate.perl"
> which identifies the directory where results are and by making the "run"
> script awake of the TEST_OUTPUT_DIRECTORY variable.

Trivial typo: s/awake/aware/

(The perl code looks OK to me but I'm no Perl programmer)

>+if test -n "$TEST_OUTPUT_DIRECTORY"
>+then
>+    TEST_RESULTS_DIR="$TEST_OUTPUT_DIRECTORY/test-results"
>+else
>+    TEST_RESULTS_DIR=test-results
>+fi

Optional shorter (one-liner) replacement:

TEST_RESULTS_DIR=${TEST_OUTPUT_DIRECTORY:+$TEST_OUTPUT_DIRECTORY/}test-results

Chris

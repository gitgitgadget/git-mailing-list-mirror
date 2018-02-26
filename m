Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E244C1F576
	for <e@80x24.org>; Mon, 26 Feb 2018 09:04:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752257AbeBZJE0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Feb 2018 04:04:26 -0500
Received: from mail-io0-f179.google.com ([209.85.223.179]:43735 "EHLO
        mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751744AbeBZJEX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Feb 2018 04:04:23 -0500
Received: by mail-io0-f179.google.com with SMTP id l12so16427710ioc.10
        for <git@vger.kernel.org>; Mon, 26 Feb 2018 01:04:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=qJLR5iT7VXZ+mMXEMJRgp7HXyamKXbfcbfjVXzE8m6Q=;
        b=DVM+HdJFqus09loDsNs5ZKrRrnCSw0lXw0YpO2UBrwVruORzSzS7bsRWzyXI0eybIy
         +IivtnR5aMyEy4uc/bPtsahTRSfnZWCD33wX7tK3Do8TWGLl+RKrW3CdJtHnS9Cfb+Mk
         jN5jEGNpvKCGPtqNx6T//xpjTLYuDV4c/+ftLThcef9zcvrEWgzoGha1xb27bR0bqA8a
         IFjIUZtITeBw7+BltkscmQm2ETzxj3M5po8opJImwCIQ8sXmzoiRqDnQ2nrPrzu58w6E
         8z6+0Ir7tFPVMv/nXBYujUKo8tFoWgSFAEy+kure7ql55HQvj7p1broSCIiJThxgOKKY
         dcHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=qJLR5iT7VXZ+mMXEMJRgp7HXyamKXbfcbfjVXzE8m6Q=;
        b=qU+J3P0C0YBbUIYuXLqh0CBfWcR2JI5wZsG56QXQ/hBKUpguozdHYUd16OkWNvqRIs
         hr/wQ+eIURwKjaMQds4Anl/0RsPcnAK1cYiru3sKdQ63fXt9VxnMGRmgoCQuachMN03u
         8xiuOg38sMY+MslRmsFpqAoG0nvQLsnPeDAwpwP/9O3vmZy9IbQZdOkxz9b6fGbbg66E
         gCPwq1+xXiCiYlHQylweavaecgBbtxANRJyHHQRhGQ/SM7hF9DGcBTuy5MwISCkJ05CT
         IHH1CMSLeNNB1LkmJicdTqTkg0pNMfUGcK+xaZ84uD+NhZCWBbOlRf2gURWvyGNE4Fq7
         vdOA==
X-Gm-Message-State: APf1xPDN1EoAD4ZSL1DMrv9Fs3DK1VwW28vMFCwTGRTZcgfL68mLnlEk
        T075tNzrATawTQA214kAxNSdQ9TPlT3x3B0t8y0=
X-Google-Smtp-Source: AG47ELuKQ7jtFUzpVvrHRWy63kIUegR05i0grKjV7+YOJGSd68nLgBq5Y+btrL71oF+b2pdvy4GYyRI+m62j3Bj2EjA=
X-Received: by 10.107.157.146 with SMTP id g140mr10785798ioe.5.1519635863056;
 Mon, 26 Feb 2018 01:04:23 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.206.20 with HTTP; Mon, 26 Feb 2018 01:04:22 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 26 Feb 2018 10:04:22 +0100
Message-ID: <CAP8UFD23z9YDukO=O+cK=o_0DLcxbkXWzp4rCA1kRXGTZ-TMcQ@mail.gmail.com>
Subject: Use of uninitialised value of size 8 in sha1_name.c
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Derrick,

These days when running:

./t5616-partial-clone.sh --valgrind

on master, I get a bunch of:

==21455== Use of uninitialised value of size 8
==21455==    at 0x2D2A73: get_hex_char_from_oid (sha1_name.c:492)
==21455==    by 0x2D2AFE: extend_abbrev_len (sha1_name.c:502)
==21455==    by 0x2D2C3D: find_abbrev_len_for_pack (sha1_name.c:551)
==21455==    by 0x2D2CFF: find_abbrev_len_packed (sha1_name.c:569)
==21455==    by 0x2D2E12: find_unique_abbrev_r (sha1_name.c:608)
==21455==    by 0x2DCB66: strbuf_add_unique_abbrev (strbuf.c:877)
==21455==    by 0x14F7CE: update_local_ref (fetch.c:700)
==21455==    by 0x1500CF: store_updated_refs (fetch.c:871)
==21455==    by 0x15035B: fetch_refs (fetch.c:932)
==21455==    by 0x150CF8: do_fetch (fetch.c:1146)
==21455==    by 0x1515AB: fetch_one (fetch.c:1370)
==21455==    by 0x151A1D: cmd_fetch (fetch.c:1457)
==21455==  Uninitialised value was created by a stack allocation
==21455==    at 0x2D2B2E: find_abbrev_len_for_pack (sha1_name.c:513)
==21455==

A quick git blame seems to point to 0e87b85683 (sha1_name: minimize
OID comparisons during disambiguation, 2017-10-12).

It is difficult to tell for sure though as t5616-partial-clone.sh was
added after that commit.

Best,
Christian.

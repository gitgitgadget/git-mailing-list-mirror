Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2FBCE1F461
	for <e@80x24.org>; Mon, 24 Jun 2019 11:03:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729057AbfFXLDe (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Jun 2019 07:03:34 -0400
Received: from mail-wm1-f45.google.com ([209.85.128.45]:38070 "EHLO
        mail-wm1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727732AbfFXLDe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jun 2019 07:03:34 -0400
Received: by mail-wm1-f45.google.com with SMTP id s15so12897220wmj.3
        for <git@vger.kernel.org>; Mon, 24 Jun 2019 04:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:content-transfer-encoding:mime-version:subject:message-id:date
         :cc:to;
        bh=HmLwnDYMP6pCvZ7bccPMPvb0Q7Sjj2cVFi0OpURzNSM=;
        b=hauvMXBFntdfQlecM1T6xrhJXBPER5mk6tCqiGz+P/XKVC39gPUGeSCWgVmYGVCBL/
         TJNIgKJOBL+bEJMixvtCMF5K/fcd0vSPYobwHmE8HuxNjZGI+3OnvG/qd9kOqAXRemYC
         nzMDcYTY0jzxAyiim3PBNwrxAQgH0wToraEOmiIbUnLX3IyXh3znGVuo4xTfoLA2P5Uf
         85Xqm5HfccS6V2ZWgeonCY8uma7yZmhEbnNVqwnv7jrdENZaU8DUH/T3j/zPMfmRYLqW
         oWT++dbAACW7XWuG0rZhcEZPS4MuzWXpnFsn7ZhHert6hiqMsn+c/TFjoqoqLdsHcSTX
         113g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:cc:to;
        bh=HmLwnDYMP6pCvZ7bccPMPvb0Q7Sjj2cVFi0OpURzNSM=;
        b=SZFPqjKJLftRQzDDEhkM6gSClRmwgm5f/AIAXHFq4+F2ci1vaYyVr8YtNMBXHDG/DA
         Uzz7M8sbUcL6aew65NPgDutys+vv1S/KU4YeqGgzgUcfWt6vNwExEUP1vpF2ehItjpMf
         F+WMD+GqELQbePInn+AZeF3ZrHCgFOg+LYNVqqnK4UmwxZ2+tVV15iCrl2/ygzTw2Gze
         Gz6RNCpPoSRjJqrK9r87b1Ll54wxBFSMKtyEDLi+eFo5olBPxY5/tQUJSiLznaO1sMwh
         cI1E2mS1KHHH4KrwIxUjqQYSjOezEzrEfZUJ6hXCj6LCDIA/Ng1b5tdpmG/eWm2a0WK5
         w9Rw==
X-Gm-Message-State: APjAAAUW7s1UwNPOMB5WCne3GUHfoVKYjodEcokt1k1P0ufuFq7SNh0p
        5tzDBIR3+zUmHr51i5dE3McdtKKm
X-Google-Smtp-Source: APXvYqxODtakEGfs1A8EQXXmlcqpMrijqb77NoZ6E4ost+FY/XTQrQWBsOzLMSV3XQYw5yJMmdiD1w==
X-Received: by 2002:a1c:305:: with SMTP id 5mr16131853wmd.101.1561374211549;
        Mon, 24 Jun 2019 04:03:31 -0700 (PDT)
Received: from 200116b840fa6b00255037fd7cde3798.dip.versatel-1u1.de (200116b840fa6b00255037fd7cde3798.dip.versatel-1u1.de. [2001:16b8:40fa:6b00:2550:37fd:7cde:3798])
        by smtp.gmail.com with ESMTPSA id y6sm10644850wmd.16.2019.06.24.04.03.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Jun 2019 04:03:30 -0700 (PDT)
From:   Lars Schneider <larsxschneider@gmail.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: [BUG] Symbolic links break "git fast-export"?
Message-Id: <95EF0665-9882-4707-BB6A-94182C01BE91@gmail.com>
Date:   Mon, 24 Jun 2019 13:03:29 +0200
Cc:     Jeff King <peff@peff.net>
To:     Git Mailing List <git@vger.kernel.org>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi folks,

Is my understanding correct, that `git fast-export | git fast-import` 
should not modify the repository? If yes, then we might have a bug in 
`git fast-export` if symbolic directory links are removed and converted 
to a real directory.

Consider this test case:

    # Create test repo
    git init .
    mkdir foo
    echo "foo" >foo/baz
    git add .
    git commit -m "add foo dir"
    ln -s foo bar
    git add .
    git commit -m "add bar dir as link"
    rm bar
    mkdir bar
    echo "bar" >bar/baz
    git add .
    git commit -m "remove link and make bar dir real"

    printf "BEFORE: "
    git rev-parse HEAD

    # Fast export, import ... that should not change anything!
    git fast-export --no-data --all --signed-tags=warn-strip \
        --tag-of-filtered-object=rewrite | git fast-import --force --quiet

    printf "AFTER: "

I would assume that the BEFORE/AFTER hashes match. Unfortunately, with 
Git 2.22.0 they do no. The problem is this export output I think:

    remove link and make bar dir real
    from :2
    M 100644 5716ca5987cbf97d6bb54920bea6adde242d87e6 bar/baz
    D bar

The new file in the `bar` directory is added to the repo first and
afterwards the path `bar` is deleted. I think that deletes the entire 
directory `bar`?

If you confirm that this is a bug, then I will try to provide a fix.

Thanks,
Lars

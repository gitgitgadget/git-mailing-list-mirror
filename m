Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CB55C1F424
	for <e@80x24.org>; Tue, 24 Apr 2018 21:03:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751234AbeDXVDe (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Apr 2018 17:03:34 -0400
Received: from mail-pg0-f49.google.com ([74.125.83.49]:41704 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750835AbeDXVDd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Apr 2018 17:03:33 -0400
Received: by mail-pg0-f49.google.com with SMTP id m21so8738885pgv.8
        for <git@vger.kernel.org>; Tue, 24 Apr 2018 14:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yvR8zQsp7qttxYKAgVIpAyme2quf+Ev5J69siKUmvHw=;
        b=mgQb/CrljRv0sv4AZgcre9KlveBGaunyIdgFJpOayPyUl8SqyeHGLFkz5rEYj6wA/D
         UJ9V5zx3rdNqWJ03Zg22pUeOCpEX7eteA2faI+yBhJhpix/rxJBTnC3sJJ0fHpE+wSh4
         9Kc0Xckp4is2ZhcOO1xl5rY/7JGeeAlvquoONKgCwiDmERooSfSyY9byV0aQ+YfwH7/6
         OGpIN9zOdniX5PgX8o5RhlR1U6IUUfOu2atA1W4jyUzvri6V0cGbiRT63Dr1VLuVuacO
         Mv0ZeT6iuZVVmL7oOcwcHV2K1UrUHSOKvrplU5RF7QttVLm5OCuGpbxrCqHTCEpwlv/O
         e9oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yvR8zQsp7qttxYKAgVIpAyme2quf+Ev5J69siKUmvHw=;
        b=uLlts5Z9+tuen9moWj7af5SF/ZD97UK4EJlNg6IXN/7R4QsdIKAUKQ5Mx2AP4cHGws
         OJf6IE+6PU14JhuxNOcOsAEFs11F3SHLNEDRS/fyctlxgO6CELIk2Kuds36f0GcesQB0
         KOd4iK+K0U685Jkze0fu2eJbb1isRZvxNndhuZjia5uEBMX6yuBWc5LO92OzqFiEdwI9
         kzbgFL6Fbql9AGD6Btxdt8gRT9HTbMj4PeSJJMhc93Xr1/EJ4VQ3nHjMxaD7Em4Hlbt3
         ib7nrHH6FW1Yrt8JTayOTKDZ17COv3SJLZQgFTFNbLlCX1HObOeFVSs2PAEKHjRHrvP9
         11sQ==
X-Gm-Message-State: ALQs6tDtjh44Gi0C/ZAjla7f/yhguNYB28CqGBINT2v0PCMfRGc70lW3
        eLvI02eQ4yzUrV9ZNSXK76zInXbrKtE=
X-Google-Smtp-Source: AIpwx48f1Zi5FpUJVnXhXFicoQqyEPay5Z0JICBhdRk2p19APKo8LFDJe+A6YYqA74bW1j3WZ3VMAQ==
X-Received: by 10.98.186.26 with SMTP id k26mr25537254pff.195.1524603812579;
        Tue, 24 Apr 2018 14:03:32 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id f12sm26850747pfn.47.2018.04.24.14.03.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Apr 2018 14:03:31 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     jonathantanmy@google.com, simon@ruderich.org, avarab@gmail.com,
        jacob.keller@gmail.com, Stefan Beller <sbeller@google.com>
Subject: [PATCHv2 0/7] Moved code detection: ignore space on uniform indentation
Date:   Tue, 24 Apr 2018 14:03:23 -0700
Message-Id: <20180424210330.87861-1-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

v2:
I think I have addressed Jonathans feedback
* by using a string instead of counting the first character only.
* refined tests slightly (easier to read)
* moved white space handling for moved blocks into its own flag field,
  keeping the enum for the actual mode of move detection.

v1:
This is a re-attempt of [1], which allows the moved code detection to
ignore blanks in various modes.

patches 1-5 are refactoring, patch 6 adds all existing white space options
of regular diff to the move detection. (I am unsure about this patch,
as I presume we want to keep the option space at a minimum if possible).

The fun is in the last patch, which allows white space sensitive
languages to trust the move detection, too. Each block that is marked as
moved will have the same delta in {in-, de-}dentation.
I would think this mode might be a reasonable default eventually.

Thanks,
Stefan

[1] https://public-inbox.org/git/20171025224620.27657-1-sbeller@google.com/

Stefan Beller (7):
  xdiff/xdiff.h: remove unused flags
  xdiff/xdiffi.c: remove unneeded function declarations
  diff.c: do not pass diff options as keydata to hashmap
  diff.c: adjust hash function signature to match hashmap expectation
  diff.c: add a blocks mode for moved code detection
  diff.c: decouple white space treatment from move detection algorithm
  diff.c: add --color-moved-ignore-space-delta option

 Documentation/diff-options.txt |  25 ++++-
 diff.c                         | 128 ++++++++++++++++++----
 diff.h                         |   8 +-
 t/t4015-diff-whitespace.sh     | 192 +++++++++++++++++++++++++++++++--
 xdiff/xdiff.h                  |   8 --
 xdiff/xdiffi.c                 |  17 ---
 6 files changed, 322 insertions(+), 56 deletions(-)

-- 
2.17.0.441.gb46fe60e1d-goog


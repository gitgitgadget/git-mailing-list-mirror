Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C39B1F731
	for <e@80x24.org>; Wed,  7 Aug 2019 21:39:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729920AbfHGVjx (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Aug 2019 17:39:53 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33332 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727213AbfHGVjx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Aug 2019 17:39:53 -0400
Received: by mail-pg1-f193.google.com with SMTP id n190so2042032pgn.0
        for <git@vger.kernel.org>; Wed, 07 Aug 2019 14:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UETPoMqPWS88pUQDixw4Zb+IuyGVbeoG9e8iNs1ePqg=;
        b=YPfwVXLIzuNmajmyz5S2dZL3TMCD5LVwgFCRueogWahTD8f5ujCfF+Avt2P2W52d3F
         b1rhGQek/rDMqZqNwopPKlGj/PbUJmFp89d4v9rStF2wVqENQK1qBR/gSQmlE1Ks6p3l
         S4wdcVHqHbP5h7X9f5fZ2iIEBxkcVCHWVE0EZB3ySEkWaZMwyMyqS8rQuSivP9FV2hh6
         h1CQ5BCvOm6cwMKPClmesGqQ47x+QTRwkDMWPMDlpbYyvGG+nUakY1bKLZUQLkoSB6Zl
         lNOUGe9N8aPJRHx3CPo/VLr/1chFeciNLDWF6C6moi4rZNRBn/hdZONB1aBVQrVKRbuY
         nNdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UETPoMqPWS88pUQDixw4Zb+IuyGVbeoG9e8iNs1ePqg=;
        b=Vg/sUslG1nB09r4B3cVjWvEZDjjAK9oRz3/0hV6P3j4W2ipxxqU6aMiEwncr/oqr8I
         z9q+MoUwGVLdM8IhOrUK604jMMycwaH41L9L8qhnAJ/QXnknpMvBHQkpG90lA46c07lW
         S9eiQagoMSOxW2EJl1i/CPsYDSeiRyeWeSZsjEkqBrkSdX3ZIll+80gTdKAr4PG76zSO
         c7504Y84RfKlukP6At2wds/x60i6DoIgasNeO46EINa618ri5/7zYeduHWtjXOODF+yG
         rJgV9V4NB57iipW9S2yyCZSM6FXHxevCyfRNBHCdpiYiJkLLIZukLFpPH3iUgeK8N0Bd
         EEGw==
X-Gm-Message-State: APjAAAWbb+ICYWujbzYg+JSl24qly+dCBMi7Zd3yJxHRKedoYN9psrov
        ZmpmHMvMaEg47gg0ngxjq4QkTtV5wt8=
X-Google-Smtp-Source: APXvYqx+HBddeudT9fWaFTXgoyR0HassgHgZSg1bLwMb0NlRL5wrebdmeqFquTjot6Cfczn2l6VaMg==
X-Received: by 2002:a62:5c3:: with SMTP id 186mr11595145pff.144.1565213992469;
        Wed, 07 Aug 2019 14:39:52 -0700 (PDT)
Received: from localhost.localdomain ([205.209.24.227])
        by smtp.gmail.com with ESMTPSA id b24sm63840303pfd.91.2019.08.07.14.39.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 07 Aug 2019 14:39:52 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, gitster@pobox.com, johannes.schindelin@gmx.de,
        l.s.r@web.de, michal.kiedrowicz@gmail.com
Subject: [RFC PATCH v4 0/3] grep: no leaks or crashes (windows testing needed)
Date:   Wed,  7 Aug 2019 14:39:42 -0700
Message-Id: <20190807213945.10464-1-carenas@gmail.com>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20190806163658.66932-1-carenas@gmail.com>
References: <20190806163658.66932-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series is a candidate reroll for cb/pcre2-chartables-leakfix, that
hopefully addresses the root cause of the problem reported by Dscho in
Windows, where the PCRE2 library wasn't aware of the custom allocator and
was returning a pointer created with the system malloc but passing it to
NED's free, resulting in a segfault.

The reason why it was triggered by the original leak fix is the layering
violation reported by René and that is exclusive to PCRE2 (hence why it
hasn't been reported with PCRE1).  Additional work might be available
in a future release of PCRE2 to address that as detailed in the upstream
bug[1] report.

Eitherway, since I am unable to replicate the original bug or take
performance numbers in a representative environment without Windows
this is only published as an RFC,

Changes since v3 (mostly in patch 2):

* git log also calls the "destructor" for grep API
* no more "bug" being triggered by `make test`, sorry René
* hopefully no more crashes in windows (I was expecting at most a BUG)

Future work (other than the needed refactoring explained in the
second patch) and adjacent bugs, includes:

* tracking more possible users of the grep API that might need to call
  grep_destroy()
* completely moving PCRE2 to use NED (as is done with PCRE1 and was
  proposed on the original patch[2] this is based on
* build on top of the new API so that other work could be shared
  (for example the chartables that started this whole mess)

or (hopefully not)

* ignore the original leak (maybe with an UNLEAK) as René suggested [3]
* discard this work and just use Dscho's fix (probably with some improvements)

Carlo Marcelo Arenas Belón (3):
  grep: make PCRE1 aware of custom allocator
  grep: make PCRE2 aware of custom allocator
  grep: avoid leak of chartables in PCRE2

 Makefile       |  2 +-
 builtin/grep.c |  1 +
 builtin/log.c  |  1 +
 grep.c         | 77 ++++++++++++++++++++++++++++++++++++++++++++------
 grep.h         |  2 ++
 5 files changed, 73 insertions(+), 10 deletions(-)

[1] https://bugs.exim.org/show_bug.cgi?id=2429
[2] https://public-inbox.org/git/3397e6797f872aedd18c6d795f4976e1c579514b.1565005867.git.gitgitgadget@gmail.com/
[3] https://public-inbox.org/git/7ec60d57-9940-35f2-f7b5-c87d4dc7cdd5@web.de/

base-commit: 51cf315870bbb7254ddf06c84fe03b41bc48eebd
-- 
2.23.0.rc1

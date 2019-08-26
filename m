Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E90831F461
	for <e@80x24.org>; Mon, 26 Aug 2019 23:57:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbfHZX5l (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Aug 2019 19:57:41 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:36593 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726020AbfHZX5l (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Aug 2019 19:57:41 -0400
Received: by mail-qt1-f195.google.com with SMTP id z4so19731045qtc.3
        for <git@vger.kernel.org>; Mon, 26 Aug 2019 16:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eaiDooYycJ3V2qjKdhGhjUvWvXgqczj1V2OvezmEf28=;
        b=FhhgvYjtrJqt5NGpHl5SnduYJmlkfiNJeMrgqdVJAUkWi7nY0N1fEsu/rBiH7TQBvo
         BuXZzZ3aJ84Uv71FT3pnpj1RUI1kEiWrGZra8p4f4p2XBnzgvtXhkdkQYAsTaQzj2+6r
         RpBYYXo15Dvk4fh0P22/BAU4k57+oisF91uvij6gmErcVqiikxev6KRKR8WtgVlvkxaL
         DmsD/SXxS9SHpF72RsmmS9LH8A/CqXyySd+5kaxHVlrqOXZBtHMeRc6hqgSAbeCdD5+0
         3BYUM4jdergvuETIoCNMg0W4Qw8bedQFfdmVg7EU+BN3nGMBkeUBikmFD1mlcVUbBj4N
         e+WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eaiDooYycJ3V2qjKdhGhjUvWvXgqczj1V2OvezmEf28=;
        b=DaBSHw5d69hFiYpHQCBCLgWghXbvVjTOY/2s6bkKQmK9hRYgH7TLB8DRIwmhRt1WmP
         BuwJKooS2nSsfpoeSuqV5jFiXIil+PXZx7xOTWG/vacfOYh527ZzrwqB+rOpegHr0sR6
         lnrHgcPx1kZFZ48YdJwOkimVtLA/4fHH6y53MtADBHgCyxEPoVvsx+Tm1yYk5z/MlIQk
         PMrx/cyvLpd0R/UZ2wcO14cRFiV+ZXMpF2WwPIWXGQ9FHsc4CHmUKNYQbYtbWcZi0U63
         FtrTuizwizX6h+KEchYoJEc0YDH6+tWm3AFtSNJvNYjxEX9B0FCYLCphjm0XnO/PAxkI
         YcDA==
X-Gm-Message-State: APjAAAVPGp0t2Hi4Dly5yz5ZslGvmjPJBkdEKOyLa+b26pz4AVfpQzzM
        ew/W26SbzgeyZlf7sSg8+hnbmWrONEQ=
X-Google-Smtp-Source: APXvYqx5N6zwjpNFaHkl9AsJU/iVpVl/+YvaOePUQwrAvb8L1C6k+syfvWwVdTUCv3B1iMGEw7YAew==
X-Received: by 2002:ac8:794f:: with SMTP id r15mr20398297qtt.130.1566863860276;
        Mon, 26 Aug 2019 16:57:40 -0700 (PDT)
Received: from mango.spo.virtua.com.br ([2804:14c:81:942d::1])
        by smtp.gmail.com with ESMTPSA id i62sm7192883qke.52.2019.08.26.16.57.39
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2019 16:57:39 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Subject: [PATCH 0/2] config: make config_with_options() handle any repo
Date:   Mon, 26 Aug 2019 20:57:26 -0300
Message-Id: <cover.1566863604.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patchset makes more config.c functions handle arbitrary repos and
use that to remove an add_to_alternates_memory() call in
submodule-config.c. This should hopefully benefit performance and
memory.

Matheus Tavares (2):
  config: allow config_with_options() to handle any repo
  submodule: pass repo instead of adding to alternates list

 Documentation/technical/api-config.txt        |  5 +++-
 config.c                                      | 26 +++++++++----------
 config.h                                      | 16 ++++++++----
 .../coccinelle/the_repository.pending.cocci   | 11 ++++++++
 submodule-config.c                            |  9 +++----
 5 files changed, 42 insertions(+), 25 deletions(-)

-- 
2.22.0


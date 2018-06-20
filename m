Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1FA531F403
	for <e@80x24.org>; Wed, 20 Jun 2018 21:33:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933530AbeFTVcn (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Jun 2018 17:32:43 -0400
Received: from mail-ua0-f201.google.com ([209.85.217.201]:33775 "EHLO
        mail-ua0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933346AbeFTVcm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jun 2018 17:32:42 -0400
Received: by mail-ua0-f201.google.com with SMTP id m5-v6so351675uan.0
        for <git@vger.kernel.org>; Wed, 20 Jun 2018 14:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=5bY2CQRN64cBoHK9nZ26Eov6X7vYW/17KsglvGI7XLA=;
        b=H4eIZmFi7ewQS9AOJQlVnHnSyb1ipynu2hptoZyZVN/62/HUBqNjqjs1pOBkkNC6dW
         UzBnrCzEHpodk5zioz9q46X7+J4hzQZb56t+TqC3GgAgnqfPXF31FiDXUqvYDV9CPShS
         eLfWiZQCaAH0vf6nCOjwIHpRHZEtK+bpKXTMaEsZYwPXOP9WM2rkwSHMQV+nA4bdlXoG
         7NQ1Hndivm7iHY3jFDfgS+MHni33zATAG8106jRMne56UXO+5wTOMUi2lv4iyL0BCVXi
         RIgZ4Q/Me40PMNst0BoyezAQ+vimhuT2iK1DkStr1gfNaL/OD9DJqBWUD1K+pokbuIms
         hDNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=5bY2CQRN64cBoHK9nZ26Eov6X7vYW/17KsglvGI7XLA=;
        b=FeYMnmy/O3gvPfuXvsg27lrNHAQMayT9TSdjt9AZ/DQVO54tPz2Lj5XZT76xQK2md3
         yd1/Z5H82OQooGXfFEtSzRQSqTuK/9RMmgHvkOat7ndgSZP1QMR1lYK6p5Ise+PMN/TX
         c/qjJmmW5ixoPpZH2CEMtpl1ykvEzYWb+tcsjy5Z0yzh02mipnZah3aCJ+AjDmq3Vk/2
         e2Q2INW1dL6zI1SE5eNlnhN9PcsjAShEXhuCITgM0oPzDrn748GuVOmO/BaUUx+ctfOe
         QlewUfbd06Pv0OzUL4KpzYIVFqZeDihTC8AogJ9T5Xwzpd7F3S6pOF2bAgytgAbx4mo5
         FP4Q==
X-Gm-Message-State: APt69E3T8+AVTmK9Hk8oTetSOFYfzOjRKyoOEEnlfGaO9ERlbaqgWPI6
        LO+z5z4C81Of/gqf5GE7LDKPI+h24ImJ2YNhG9GpzxCqln3Y80pOEOVtAKOKpY4nXjanHUZOV0x
        2ohKmOVXdeWXUAXi5Cck7LrqEdBXyQt6jI2fwuKNQTsW2qV3+qfyN1/RxRQ==
X-Google-Smtp-Source: ADUXVKIronl2d0EqklAHSAa4aETW9t3FtaLm5L9e9OYhDa1B0rTbhE25U59SswDv9LP/cWHTP9Id5wGMpoc=
MIME-Version: 1.0
X-Received: by 2002:a1f:b7d3:: with SMTP id h202-v6mr10044384vkf.75.1529530361405;
 Wed, 20 Jun 2018 14:32:41 -0700 (PDT)
Date:   Wed, 20 Jun 2018 14:32:27 -0700
In-Reply-To: <20180613213925.10560-1-bmwill@google.com>
Message-Id: <20180620213235.10952-1-bmwill@google.com>
References: <20180613213925.10560-1-bmwill@google.com>
X-Mailer: git-send-email 2.18.0.rc1.244.gcf134e6275-goog
Subject: [PATCH v3 0/8] ref-in-want
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     jonathantanmy@google.com, gitster@pobox.com, sbeller@google.com,
        Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changes in v3:
* Discussion seemed to settle on keeping the simplified version of
  ref-in-want where the "want-ref" line only accepts full ref names.  If
  we want to we can add patterns at a later time.
* Reverted back to v1's behavior where requesting a ref that doesn't
  exists is a hard error on the server.  I went back and forth many
  times on what the right thing to do here is and decided that a hard
  error works much cleaner for the time being.
* Some typos.

Brandon Williams (8):
  test-pkt-line: add unpack-sideband subcommand
  upload-pack: implement ref-in-want
  upload-pack: test negotiation with changing repository
  fetch: refactor the population of peer ref OIDs
  fetch: refactor fetch_refs into two functions
  fetch: refactor to make function args narrower
  fetch-pack: put shallow info in output parameter
  fetch-pack: implement ref-in-want

 Documentation/config.txt                |   7 +
 Documentation/technical/protocol-v2.txt |  28 ++-
 builtin/clone.c                         |   4 +-
 builtin/fetch.c                         | 131 ++++++++-----
 fetch-object.c                          |   2 +-
 fetch-pack.c                            |  52 +++--
 remote.c                                |   1 +
 remote.h                                |   1 +
 t/helper/test-pkt-line.c                |  33 ++++
 t/lib-httpd.sh                          |   1 +
 t/lib-httpd/apache.conf                 |   8 +
 t/lib-httpd/one-time-sed.sh             |  16 ++
 t/t5703-upload-pack-ref-in-want.sh      | 245 ++++++++++++++++++++++++
 transport-helper.c                      |   6 +-
 transport-internal.h                    |   9 +-
 transport.c                             |  34 +++-
 transport.h                             |   3 +-
 upload-pack.c                           |  64 +++++++
 18 files changed, 568 insertions(+), 77 deletions(-)
 create mode 100644 t/lib-httpd/one-time-sed.sh
 create mode 100755 t/t5703-upload-pack-ref-in-want.sh

-- 
2.18.0.rc1.244.gcf134e6275-goog


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 348351F404
	for <e@80x24.org>; Thu, 15 Mar 2018 17:31:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751687AbeCORbs (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Mar 2018 13:31:48 -0400
Received: from mail-vk0-f73.google.com ([209.85.213.73]:43582 "EHLO
        mail-vk0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750987AbeCORbr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Mar 2018 13:31:47 -0400
Received: by mail-vk0-f73.google.com with SMTP id b144so4584418vke.10
        for <git@vger.kernel.org>; Thu, 15 Mar 2018 10:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=hkleRLhKQm+Q9O9tkMumyz6IZeW1b0fa4TkUS5j7yZo=;
        b=JCbXsDfX8QA6pWSohy6t07VPlcrCHBDZ3E9UJiTS//wNWkq5Q2k5TeSrjFFL9TVUd4
         hdjYfpTIjhFp+h0Tr0KP1ui/WPl4niynmnIx8NIIgIrUxcZJ/B21jo9SteDhJkuQRIbD
         XeXxUrhH+HXr2oVwHkS8sZICjFVtwhf4qaebMZj33ujRey+3OMRHQSr8k02RYGieNlWa
         a0KmlsJ81yEnPBzUogTuexSKRQIhxaPGJf6SLrzs6YzDsyQ++URUPPkwB9J+GTNYP/o6
         mKYytJLhym7ZX3vMWpiKntgOvP2TrBAazziJzxa39TLl+ZIuUZA8KVIrIyvJPqNYWyBX
         ToDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=hkleRLhKQm+Q9O9tkMumyz6IZeW1b0fa4TkUS5j7yZo=;
        b=LdGgV0lqT+jd1jjei56muQI0TtXVBNlqmZUzbUWD11aFPg6Z2aR1wOwARVonGwFsLd
         4jQh7un7voDHxoMRxccnksSiHPdn10RUJxvzCzLGpcgEu7PCL7ZZQDGuREaGnZ5RQW+r
         +jjoCp6O06DqXUaCjUfcGDSHoUGo1USAZVkFCkVj31MYhWof/UR4bqYfh2IUhJbXa3Nk
         6sPGrzivt+PLICR33i2QORiKflylkU6Q8uDsxG7hx74L7PYeYw8TOl3Z9AIFI1Asc3ep
         BnjLBMCXD49j9A0ex9tlK3ZXDO6nNfqZlh+GvmjaEdfauxxlfBNNpS94yckqBCeAVgxU
         INDw==
X-Gm-Message-State: AElRT7Gac3NaGhdEnYDBGaaT5jJnmKGzIp5zlY6hvrEEDiFDBmcNuijG
        uTEe4BFVJ3GfbJYLjjIKAkF8XyeETugGyhNZc/hM0Ap/D/l0afNYM4NnIh8HPuCJYCcNwr9L6Hb
        v6pOFmOQkpsJ0GHc83peLXDlp9h/5W6NsBqEcbgb0kWUSfltGucRufJhPmQ==
X-Google-Smtp-Source: AG47ELuaB0dLS+jjd/yQM48tFegzyY0AcxGpRXTZphpBlKkHVAePp4jq69gjp2GIfTgm85nHR1ife+s0oUI=
MIME-Version: 1.0
X-Received: by 10.176.82.54 with SMTP id i51mr4112910uaa.29.1521135106991;
 Thu, 15 Mar 2018 10:31:46 -0700 (PDT)
Date:   Thu, 15 Mar 2018 10:31:07 -0700
In-Reply-To: <20180314183213.223440-1-bmwill@google.com>
Message-Id: <20180315173142.176023-1-bmwill@google.com>
References: <20180314183213.223440-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.2.804.g6dcf76e118-goog
Subject: [PATCH v6 00/35] protocol version 2
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     git@jeffhostetler.com, gitster@pobox.com, jrnieder@gmail.com,
        pclouds@gmail.com, peff@peff.net, sbeller@google.com,
        stolee@gmail.com, jonathantanmy@google.com,
        Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fixed the protocol-v2.txt technical document so that it builds when
running "make doc".

Brandon Williams (35):
  pkt-line: introduce packet_read_with_status
  pkt-line: allow peeking a packet line without consuming it
  pkt-line: add delim packet support
  upload-pack: convert to a builtin
  upload-pack: factor out processing lines
  transport: use get_refs_via_connect to get refs
  connect: convert get_remote_heads to use struct packet_reader
  connect: discover protocol version outside of get_remote_heads
  transport: store protocol version
  protocol: introduce enum protocol_version value protocol_v2
  test-pkt-line: introduce a packet-line test helper
  serve: introduce git-serve
  ls-refs: introduce ls-refs server command
  connect: request remote refs using v2
  transport: convert get_refs_list to take a list of ref prefixes
  transport: convert transport_get_remote_refs to take a list of ref
    prefixes
  ls-remote: pass ref prefixes when requesting a remote's refs
  fetch: pass ref prefixes when fetching
  push: pass ref prefixes when pushing
  upload-pack: introduce fetch server command
  fetch-pack: perform a fetch using v2
  fetch-pack: support shallow requests
  connect: refactor git_connect to only get the protocol version once
  connect: don't request v2 when pushing
  transport-helper: remove name parameter
  transport-helper: refactor process_connect_service
  transport-helper: introduce stateless-connect
  pkt-line: add packet_buf_write_len function
  remote-curl: create copy of the service name
  remote-curl: store the protocol version the server responded with
  http: allow providing extra headers for http requests
  http: don't always add Git-Protocol header
  http: eliminate "# service" line when using protocol v2
  remote-curl: implement stateless-connect command
  remote-curl: don't request v2 when pushing

 .gitignore                              |   1 +
 Documentation/Makefile                  |   1 +
 Documentation/gitremote-helpers.txt     |  32 ++
 Documentation/technical/protocol-v2.txt | 395 +++++++++++++++
 Makefile                                |   7 +-
 builtin.h                               |   2 +
 builtin/clone.c                         |   2 +-
 builtin/fetch-pack.c                    |  20 +-
 builtin/fetch.c                         |  21 +-
 builtin/ls-remote.c                     |  15 +-
 builtin/receive-pack.c                  |   6 +
 builtin/remote.c                        |   2 +-
 builtin/send-pack.c                     |  20 +-
 builtin/serve.c                         |  30 ++
 builtin/upload-pack.c                   |  74 +++
 connect.c                               | 364 ++++++++++----
 connect.h                               |   7 +
 fetch-pack.c                            | 339 ++++++++++++-
 fetch-pack.h                            |   4 +-
 git.c                                   |   2 +
 http-backend.c                          |   8 +-
 http.c                                  |  25 +-
 http.h                                  |   7 +
 ls-refs.c                               |  96 ++++
 ls-refs.h                               |  10 +
 pkt-line.c                              | 133 ++++-
 pkt-line.h                              |  78 +++
 protocol.c                              |   2 +
 protocol.h                              |   1 +
 refs.c                                  |  14 +
 refs.h                                  |   7 +
 remote-curl.c                           | 280 ++++++++++-
 remote.h                                |  11 +-
 serve.c                                 | 257 ++++++++++
 serve.h                                 |  15 +
 t/helper/test-pkt-line.c                |  64 +++
 t/t5701-git-serve.sh                    | 176 +++++++
 t/t5702-protocol-v2.sh                  | 273 +++++++++++
 transport-helper.c                      |  87 ++--
 transport-internal.h                    |  11 +-
 transport.c                             | 130 +++--
 transport.h                             |  18 +-
 upload-pack.c                           | 615 ++++++++++++++++++------
 upload-pack.h                           |  23 +
 44 files changed, 3317 insertions(+), 368 deletions(-)
 create mode 100644 Documentation/technical/protocol-v2.txt
 create mode 100644 builtin/serve.c
 create mode 100644 builtin/upload-pack.c
 create mode 100644 ls-refs.c
 create mode 100644 ls-refs.h
 create mode 100644 serve.c
 create mode 100644 serve.h
 create mode 100644 t/helper/test-pkt-line.c
 create mode 100755 t/t5701-git-serve.sh
 create mode 100755 t/t5702-protocol-v2.sh
 create mode 100644 upload-pack.h


base-commit: 5be1f00a9a701532232f57958efab4be8c959a29
-- 
2.16.2.804.g6dcf76e118-goog


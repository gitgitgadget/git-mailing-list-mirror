Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 72B681F404
	for <e@80x24.org>; Wed, 14 Mar 2018 18:32:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751790AbeCNScT (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Mar 2018 14:32:19 -0400
Received: from mail-yw0-f201.google.com ([209.85.161.201]:33721 "EHLO
        mail-yw0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751626AbeCNScS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Mar 2018 14:32:18 -0400
Received: by mail-yw0-f201.google.com with SMTP id d10so4816981ywe.0
        for <git@vger.kernel.org>; Wed, 14 Mar 2018 11:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:message-id:subject:from:to:cc;
        bh=ZUx9YXbXMoyHeqb9DaDsN4Jz4LzlkK8hydf9jTSx5CU=;
        b=kYWA95049piIObiO9JESBZH5rdgxAPFfr+BfI6YbevUJOumjqBt9DNnKoKrZUXgyLR
         7uY2zOdFsyQie8l5Oq+b8Ngb70jX7mVxD4ZP2To1VojCFIJKeDWM2aZmdwGfeSnqqev5
         l9M00hbV+gSOxl7w0ceuodI0332jHEaQG/s4qutgA0yjGsjVFOdXiZm6P/+T6y7HzRe+
         FONN/iPkitxSd8BVyXRTvUdvX+ChSy8x/rvSSKATX9TWF1aeG0/PRUAVca2Z+fFQd6+c
         GeKeVMkxak/8ZdIW6o1l6WGJBReL6BO3ss5rd+rDqF1iYlmvY5bv6SPh/P6uMz1qrWEX
         dtDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to:cc;
        bh=ZUx9YXbXMoyHeqb9DaDsN4Jz4LzlkK8hydf9jTSx5CU=;
        b=nImq0/r4ZsMNFsjylX21o45HMjLsrGvRuPwKRRJCfTXiUs402X/c5eW+C8DPm/LRY8
         k6lCEqMVApSBGcUzPY0Y9EaFIgCBvwMRVaVEQ5phpgwabveWUw2mwkUO3jFo3tjsXuFO
         9P9RJO+Ytc6NnnXPIB8gMUoXc7NHZQeViN/GfC1mIFaG0tfhxQkkkMlzk1wwyRR8Ab9z
         i4l0IgEn3ID3bdq/TF6FZGAmWGIsjIxATmTP6phRYnWO+0ON8D2c+y+LROFZGOPWsYFY
         oTptxCgZ/K0IYwePnPqzddE9/LidSMRUYzDr1CqkjYOnZa353g8aOzNnQ/m8Bfl1w8gG
         /9Ag==
X-Gm-Message-State: AElRT7HZjCB244V/ybFF9zqeXTRU2mhLCQf2d9/EePcrCG624ClA6Cml
        B7H3InO1DDLJdy+Pau3lqhYRp8B+fKpuHx+A/QH2OBUyRJ5HJ33NvfsOTZAVQXVRisciUc5l+ED
        N9UwTdWfF9SxbAo3M/agM3b6DzesUXricl9EhESxBrlrYUz0VrLm3WpMoYQ==
X-Google-Smtp-Source: AG47ELtZPHz/mQdVLtt7epLwpAAKn75VBsGNAEmyhk+qSAMnb+KnrMyo/1uLzGaQVAL5jjxSh9mziVXK3tE=
MIME-Version: 1.0
X-Received: by 2002:a25:ab23:: with SMTP id u32-v6mr2749510ybi.83.1521052337607;
 Wed, 14 Mar 2018 11:32:17 -0700 (PDT)
Date:   Wed, 14 Mar 2018 11:31:37 -0700
Message-Id: <20180314183213.223440-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.2.804.g6dcf76e118-goog
Subject: [PATCH v5 00/35] protocol version 2
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

Changes in v5:

 * Tweaked the API of the packet_read_with_status function so that it
   wrote the pktlen value even in the presence of non-normal reads
   (flush, delim, EOF).

 * Changed the format of ref-patterns for the ls-refs server command.
   They are now ref-prefixes and matching is done as a simple prefix
   match against refnames.

 * Tweaked the API for server commands.  Instead of the server code
   dispatching the command and passing it an argv_array of keys and
   args, I changed it so that it passes it an argv_array of keys and
   then passes off the packet_reader so that the command can do the
   reading of the remainder of the input itself.  This is to account for
   future commands (e.g. push) where the argument stream will include a
   packfile and doesn't make much sense to push into an argv_array.

 * Various documentation changes, one of which calls out that the
   protocol is stateless by default and if state needs to be introduced
   at a later point, it must be hidden behind a capability which is only
   advertised when using transports which support state on the server
   side.

v4 found at:
https://public-inbox.org/git/20180228232252.102167-1-bmwill@google.com/

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
 Documentation/technical/protocol-v2.txt | 398 +++++++++++++++
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
 44 files changed, 3320 insertions(+), 368 deletions(-)
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


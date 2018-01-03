Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 818471F428
	for <e@80x24.org>; Wed,  3 Jan 2018 00:18:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751140AbeACASm (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Jan 2018 19:18:42 -0500
Received: from mail-io0-f182.google.com ([209.85.223.182]:32984 "EHLO
        mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751062AbeACASl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Jan 2018 19:18:41 -0500
Received: by mail-io0-f182.google.com with SMTP id t63so478646iod.0
        for <git@vger.kernel.org>; Tue, 02 Jan 2018 16:18:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=4igR61UAFLI67cnbiiiO6oau9Zhr2CN04IjqPGGxMk4=;
        b=vOaazRqPhmyHHZa/J9a/yR7P6z0FcoAu8JaJDtwiC2sL01KumYCBdv6vp+rE7hEHTF
         +XwI30PjHmHD0XeW0TuOLzBUd6KGKBb9mN0ii2PgwMO98P3vWMOaDxr8T6RCp79/F/tU
         iSAUCcTU+BeMWYawB+fWgM6+1hHxgd6d78tUul09T/vH4fdIwK8ykxS/+8YrFzzRMNAT
         p1TfHM9HBdTxkCIfpZXZPUfY08ZJwleKLCfu77Yjl/aiGOea5plUdpugt5wPJUUmMds3
         sByeYe0MKWocxbFuKKrQ+0aRh8AkGeNr24nCnxEXbFL6oSU+Wajsk+glokU1I4aq1AAS
         RVtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=4igR61UAFLI67cnbiiiO6oau9Zhr2CN04IjqPGGxMk4=;
        b=VMrdbTuoSiF7Z2t/1xy3FZvbKFc7FS/r0E9mlnl1tjnL46QKguQyYPiTr03xuWXVCe
         aVraPbJE8DTlKmPu+R4zMXXKhKEiQqefqB4lfRAsYmpJZJwx3ElXCnZA6+S8QJX28pvT
         8v49MI0+K7s2/AE8krycjLDfnzaI1N8Ahm6xWNdbTb7rOnllD0xBAK/+xFIBHuIyU6fc
         3TuYOFyky74wjy6n+SX0EHKWh6QkSFdJ5zxIuqgB6+BG5V5y83QhLaaSJQAKvJLHZCJx
         FjBtxz/0sIgSvGrNgNEdWsA9untJ5YFxTJPSGb5SQFHfzYw/At4nLYsM+DB2SEtFYFWK
         fTwg==
X-Gm-Message-State: AKGB3mJjOt+id+CFfUPbCZSpZ9B1MKeWVJmJOVtfW9SNhhkW8asm5gYn
        T6sHOvSQjbYsRv6sJV3MINddY/ybkpM=
X-Google-Smtp-Source: ACJfBotWgaVHw+aWRAucBrlo7Tx7KW1cOXaQXmnynHX2jtEQm8NP3gM+CSXp3w36HDP80IGFDcOn8A==
X-Received: by 10.107.20.194 with SMTP id 185mr36970096iou.116.1514938719978;
        Tue, 02 Jan 2018 16:18:39 -0800 (PST)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id q2sm12679ite.17.2018.01.02.16.18.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 02 Jan 2018 16:18:39 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, gitster@pobox.com, peff@peff.net,
        philipoakley@iee.org, stolee@gmail.com, jrnieder@gmail.com,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH 00/26] protocol version 2
Date:   Tue,  2 Jan 2018 16:18:02 -0800
Message-Id: <20180103001828.205012-1-bmwill@google.com>
X-Mailer: git-send-email 2.15.1.620.gb9897f4670-goog
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The following patches extend what I sent out as an WIP
(https://public-inbox.org/git/20171204235823.63299-1-bmwill@google.com/) and
implement protocol version 2.

Some changes from that series are as follows:
 * Lots of various cleanup on the ls-refs and fetch command code, both server
   and client.
 * Fetch command now supports a stateless-rpc mode which enables communicating
   with a half-duplex connection.
 * Introduce a new remote-helper command 'connect-half-duplex' which is
   implemented by remote-curl (the http remote-helper).  This allows for a
   client to establish a half-duplex connection and use remote-curl as a proxy
   to wrap requests in http before sending them to the remote end and
   unwrapping the responses and sending them back to the client's stdin.
 * The transport code is refactored for ls-remote, fetch, and push to provide a
   list of ref-patterns (based on the refspec being used) when requesting refs
   from the remote end.  This allows the ls-refs code to send this list of
   patterns so the remote end and filter the refs it sends back.

This series effectively implements protocol version 2 for listing a remotes
refs (ls-remote) as well as for fetch for the builtin transports (ssh, git,
file) and for the http/https transports.  Push is not implemented yet and
doesn't need to be implemented at the same time as fetch since the
receive-pack code can default to using protocol v0 when v2 is requested by the
client.

Any feedback is appreciated! Thanks!
	Brandon

Brandon Williams (26):
  pkt-line: introduce packet_read_with_status
  pkt-line: introduce struct packet_reader
  pkt-line: add delim packet support
  upload-pack: convert to a builtin
  upload-pack: factor out processing lines
  transport: use get_refs_via_connect to get refs
  connect: convert get_remote_heads to use struct packet_reader
  connect: discover protocol version outside of get_remote_heads
  transport: store protocol version
  protocol: introduce enum protocol_version value protocol_v2
  serve: introduce git-serve
  ls-refs: introduce ls-refs server command
  connect: request remote refs using v2
  transport: convert get_refs_list to take a list of ref patterns
  transport: convert transport_get_remote_refs to take a list of ref
    patterns
  ls-remote: pass ref patterns when requesting a remote's refs
  fetch: pass ref patterns when fetching
  push: pass ref patterns when pushing
  upload-pack: introduce fetch server command
  fetch-pack: perform a fetch using v2
  transport-helper: remove name parameter
  transport-helper: refactor process_connect_service
  transport-helper: introduce connect-half-duplex
  pkt-line: add packet_buf_write_len function
  remote-curl: create copy of the service name
  remote-curl: implement connect-half-duplex command

 .gitignore                              |   1 +
 Documentation/technical/protocol-v2.txt | 131 ++++++++++
 Makefile                                |   6 +-
 builtin.h                               |   2 +
 builtin/clone.c                         |   2 +-
 builtin/fetch-pack.c                    |  21 +-
 builtin/fetch.c                         |  14 +-
 builtin/ls-remote.c                     |   7 +-
 builtin/receive-pack.c                  |   6 +
 builtin/remote.c                        |   2 +-
 builtin/send-pack.c                     |  20 +-
 builtin/serve.c                         |  30 +++
 connect.c                               | 226 +++++++++++++-----
 connect.h                               |   3 +
 fetch-pack.c                            | 267 ++++++++++++++++++++-
 fetch-pack.h                            |   4 +-
 git.c                                   |   2 +
 ls-refs.c                               |  97 ++++++++
 ls-refs.h                               |   9 +
 pkt-line.c                              | 147 +++++++++++-
 pkt-line.h                              |  76 ++++++
 protocol.c                              |   2 +
 protocol.h                              |   1 +
 remote-curl.c                           | 209 +++++++++++++++-
 remote.h                                |   9 +-
 serve.c                                 | 243 +++++++++++++++++++
 serve.h                                 |  15 ++
 t/t5701-protocol-v2.sh                  | 117 +++++++++
 transport-helper.c                      |  84 ++++---
 transport-internal.h                    |   4 +-
 transport.c                             | 119 ++++++---
 transport.h                             |   9 +-
 upload-pack.c                           | 412 ++++++++++++++++++++++++++++----
 upload-pack.h                           |   9 +
 34 files changed, 2108 insertions(+), 198 deletions(-)
 create mode 100644 Documentation/technical/protocol-v2.txt
 create mode 100644 builtin/serve.c
 create mode 100644 ls-refs.c
 create mode 100644 ls-refs.h
 create mode 100644 serve.c
 create mode 100644 serve.h
 create mode 100755 t/t5701-protocol-v2.sh
 create mode 100644 upload-pack.h

-- 
2.15.1.620.gb9897f4670-goog


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5B6141F404
	for <e@80x24.org>; Wed, 28 Feb 2018 23:23:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964930AbeB1XXS (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Feb 2018 18:23:18 -0500
Received: from mail-ot0-f201.google.com ([74.125.82.201]:44774 "EHLO
        mail-ot0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964783AbeB1XXQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Feb 2018 18:23:16 -0500
Received: by mail-ot0-f201.google.com with SMTP id s52so2287956ota.11
        for <git@vger.kernel.org>; Wed, 28 Feb 2018 15:23:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=SHJs0/FWvUcN0olJETp834bvbBRrjCQxL92O5TNLrJ8=;
        b=eUfxEt7/WyWXbOgvyJ/H7P5u6S+BbacmTzmbmmRiM1Ny6xH/5+OHoKOTR5jWfj6pe2
         wwqMTriI57Td1aQ2MIjmIoZ9ZgKaCTd79ROcvtD9FoLTHfqwoonCiL8CBdkNjA/iq5mE
         Nies+k3kUDuYuaM9TUvgSDltIN+6S0iAXM4zjlbs1KB05TtqNmsB6JDcvEE/QxZcpBda
         J343Iq8MkoC+ss4qlo1z8nOzG3laxc6BMnMo1m43aW7sLOJOziq5JJV1/hWC4E6XhC7X
         ImFZkuwm5AveK5zsd4wzLaWfR4EnI0eZwX5UeGQq8j7KC1QQrfDxsx8bv0hAaqpH/V+B
         NDcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=SHJs0/FWvUcN0olJETp834bvbBRrjCQxL92O5TNLrJ8=;
        b=ll/06jiLTobc+O0qD/dioKbbpB6XLZa/qpoOtqP9Kbl62vN8aqqSfkrGPnzJDRT7mo
         IPFcbsYqh037r7ojfjqGs6kzE5DjdMtl315Q43++Olt/HrzxArhJyDHJkJztuSB64APG
         n9vgt3VRH3mVjcA5p7bb1PfHluQsmdtpmeGdvzsF1xZWeL8zPgyFqb01FTjSlDgtKUcp
         Rm59PRx3pOAlYNm+QsPxuU4nh8X4/ER4yRB/mvEIyufO/edtsZ/H8ndBANAYGDoQTz96
         ulKuTcDwkgmzGIqx4lC8AnZo+747JyywLd0CUkQckidY1maXQnVTXUehkbeVDiaVTdHg
         UO5g==
X-Gm-Message-State: APf1xPCTHzGz1OiaSd/SduBtLT4DNg172z20ZLgapRpemPVgUYwyPd9R
        3lGIM3xP4ueXz85F0bfdjRZ95crTPDi+NS8DaFnzUInutVOzy7h59x4Wm4AAA11cdf2NrLuO2um
        SeP/mCh884xmGGibLytciyNPoGud3mkhygN9YoXiOa1IYMBc4CQeR6dPqkA==
X-Google-Smtp-Source: AG47ELvTZqdsEulwCT5Mj4IlSf+O00u23N++rpvOOA0ZdWB7kqmBCKkOepE6pR7FtQvVWwLk5QGK3IYC7Hk=
MIME-Version: 1.0
X-Received: by 10.157.9.138 with SMTP id q10mr10489782otd.75.1519860195553;
 Wed, 28 Feb 2018 15:23:15 -0800 (PST)
Date:   Wed, 28 Feb 2018 15:22:17 -0800
In-Reply-To: <20180207011312.189834-1-bmwill@google.com>
Message-Id: <20180228232252.102167-1-bmwill@google.com>
References: <20180207011312.189834-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.1.107.gffe1b9127
Subject: [PATCH v4 00/35] protocol version 2
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     git@jeffhostetler.com, gitster@pobox.com, jrnieder@gmail.com,
        pclouds@gmail.com, peff@peff.net, sbeller@google.com,
        stolee@gmail.com, Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Lots of changes since v3 (well more than between v2 and v3).  Thanks for
all of the reviews on the last round, the series is getting more
polished.

 * Eliminated the "# service" line from the response from an HTTP
   server.  This means that the response to a v2 request is exactly the
   same regardless of which transport you use!  Docs for this have been
   added as well.
 * Changed how ref-patterns work with the `ls-refs` command.  Instead of
   using wildmatch all patterns must either match exactly or they can
   contain a single '*' character at the end to mean that the prefix
   must match.  Docs for this have also been added.
 * Lots of updates to the docs.  Including documenting the
   `stateless-connect` remote-helper command used by remote-curl to
   handle the http transport.
 * Fixed a number of bugs with the `fetch` command, one of which didn't
   use objects from configured alternates.

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
  transport: convert get_refs_list to take a list of ref patterns
  transport: convert transport_get_remote_refs to take a list of ref
    patterns
  ls-remote: pass ref patterns when requesting a remote's refs
  fetch: pass ref patterns when fetching
  push: pass ref patterns when pushing
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
 Documentation/gitremote-helpers.txt     |  32 ++
 Documentation/technical/protocol-v2.txt | 401 +++++++++++++++
 Makefile                                |   7 +-
 builtin.h                               |   2 +
 builtin/clone.c                         |   2 +-
 builtin/fetch-pack.c                    |  20 +-
 builtin/fetch.c                         |  18 +-
 builtin/ls-remote.c                     |  12 +-
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
 ls-refs.c                               | 144 ++++++
 ls-refs.h                               |   9 +
 pkt-line.c                              | 147 +++++-
 pkt-line.h                              |  78 +++
 protocol.c                              |   2 +
 protocol.h                              |   1 +
 refs.c                                  |  14 +
 refs.h                                  |   7 +
 remote-curl.c                           | 278 ++++++++++-
 remote.h                                |  11 +-
 serve.c                                 | 260 ++++++++++
 serve.h                                 |  15 +
 t/helper/test-pkt-line.c                |  64 +++
 t/t5701-git-serve.sh                    | 176 +++++++
 t/t5702-protocol-v2.sh                  | 273 +++++++++++
 transport-helper.c                      |  87 ++--
 transport-internal.h                    |   9 +-
 transport.c                             | 125 +++--
 transport.h                             |  18 +-
 upload-pack.c                           | 616 ++++++++++++++++++------
 upload-pack.h                           |  21 +
 43 files changed, 3370 insertions(+), 368 deletions(-)
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

-- 
2.16.2.395.g2e18187dfd-goog


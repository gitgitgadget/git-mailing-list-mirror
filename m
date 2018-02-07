Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 499261F404
	for <e@80x24.org>; Wed,  7 Feb 2018 01:13:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754222AbeBGBNT (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Feb 2018 20:13:19 -0500
Received: from mail-qk0-f201.google.com ([209.85.220.201]:38690 "EHLO
        mail-qk0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754189AbeBGBNS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Feb 2018 20:13:18 -0500
Received: by mail-qk0-f201.google.com with SMTP id b67so3136958qkh.5
        for <git@vger.kernel.org>; Tue, 06 Feb 2018 17:13:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=BTVkQzmi9dJEUIKuYO+WYKZMMpI1FeXtgdlL7Jn7WiE=;
        b=IJLU/3PV1xU3SZz6pegWEl0LNhz00KvlO42McdCWniRmrKExShhH6QO3QCNcMW1jox
         QfkMLsJ43Z9Ufwfm/Bup44+4TX3pcPwilnbGCmWsOOZ0PQWjy1EQZTBFRPJlQYs73Lhp
         pgYfD2uTrjodBLUsKYON2Uy4GTQQdwh60P9KcmnTDRhkfXrnWFHEyYV9txAc2zNukXZZ
         EmFQ8y8RZcPAOfXMLFp0YwOd3bwXPcnbScDjtY0Q2oPqozzJ5Z/p2RhF4V0pF13es0xe
         W5+702MU2s2oxRfTKmGZbDxzN+lDI3zyxt+AF7HpCFuiqWcIzXGsKREm/dA0DF/Q3gVj
         yYFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=BTVkQzmi9dJEUIKuYO+WYKZMMpI1FeXtgdlL7Jn7WiE=;
        b=kX+u4WxthxwW3RMgQiyYxvOpj/kdpibGhMbzFp+Dq3Ow2ARlhrOn10paxXVv7liDsi
         2fhqmq+hI5CtYk7SbBDOgFpEkhPvdDPQumrOaKs6sMP7JfEeck8qI/2UHeje7kzHlOk1
         cya6EJvk2YgTAuZxXqu/b7X2rt2ch+A2n7WW2OrvNyuJydDEziDyfqJ/Va78paU3+kGi
         pEkuiu3oQQ61nakniLDTWU11WaameTb6vuVX39jg3x7gVln9PjsYF9MUd1oW1rbaWfE7
         YGDmCziMuvr4UHjvn9aPAeBDe6/acy2E2uhwYY0f/6uj/sxj/sGV2EIt6jqM6kXrVUKA
         SSOQ==
X-Gm-Message-State: APf1xPAkd+fmz9dHI46gsZpPWb4EDQoLsACJuR8cBDi1s8r/v5vTGn9G
        CEeFvq/oDcUGhKYUbUcBo0lwcYAIF8fD+DazXAaFWyj7UcPOgNpqv+4VXqs3BZtqp+Ww+HFuaRh
        r/CqhpnnPQE6Z+OFv3z0/i9rLlsRYrQLtA+D3qoZYTWWqlZnwvpKCd7ORXA==
X-Google-Smtp-Source: AH8x225m/zihlaRnPHTuDmiNhS6Z7yY3fGXQ8i1K4EgtQVJhHri0S062M+Z6BQNxt35r/Kf4eag1/OZoCww=
MIME-Version: 1.0
X-Received: by 10.237.36.182 with SMTP id t51mr3367970qtc.12.1517965997171;
 Tue, 06 Feb 2018 17:13:17 -0800 (PST)
Date:   Tue,  6 Feb 2018 17:12:37 -0800
In-Reply-To: <20180125235838.138135-1-bmwill@google.com>
Message-Id: <20180207011312.189834-1-bmwill@google.com>
References: <20180125235838.138135-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.0.rc1.238.g530d649a79-goog
Subject: [PATCH v3 00/35] protocol version 2
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, peff@peff.net, gitster@pobox.com,
        jrnieder@gmail.com, stolee@gmail.com, git@jeffhostetler.com,
        pclouds@gmail.com, Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changes in v3:
 * There were some comments about how the protocol should be designed
   stateless first.  I've made this change and instead of having to
   supply the `stateless-rpc=true` capability to force stateless
   behavior, the protocol just requires all commands to be stateless.
 
 * Added some patches towards the end of the series to force the client
   to not request to use protocol v2 when pushing (even if configured to
   use v2).  This is to ease the roll-out process of a push command in
   protocol v2.  This way when servers gain the ability to accept
   pushing in v2 (and they start responding using v2 when requests are
   sent to the git-receive-pack endpoint) that clients who still don't
   understand how to push using v2 won't request to use v2 and then die
   when they recognize that the server does indeed know how to accept a
   push under v2.

 * I implemented the `shallow` feature for fetch.  This feature
   encapsulates the existing functionality of all the shallow/deepen
   capabilities in v0.  So now a server can process shallow requests.

 * Various other small tweaks that I can't remember :)

After all of that I think the series is in a pretty good state, baring
any more critical reviewing feedback.

Thanks!

Brandon Williams (35):
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
  upload-pack: support shallow requests
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
  remote-curl: implement stateless-connect command
  remote-curl: don't request v2 when pushing

 .gitignore                              |   1 +
 Documentation/technical/protocol-v2.txt | 338 +++++++++++++++++
 Makefile                                |   7 +-
 builtin.h                               |   2 +
 builtin/clone.c                         |   2 +-
 builtin/fetch-pack.c                    |  21 +-
 builtin/fetch.c                         |  14 +-
 builtin/ls-remote.c                     |   7 +-
 builtin/receive-pack.c                  |   6 +
 builtin/remote.c                        |   2 +-
 builtin/send-pack.c                     |  20 +-
 builtin/serve.c                         |  30 ++
 builtin/upload-pack.c                   |  74 ++++
 connect.c                               | 352 +++++++++++++-----
 connect.h                               |   7 +
 fetch-pack.c                            | 319 +++++++++++++++-
 fetch-pack.h                            |   4 +-
 git.c                                   |   2 +
 http.c                                  |  25 +-
 http.h                                  |   2 +
 ls-refs.c                               |  96 +++++
 ls-refs.h                               |   9 +
 pkt-line.c                              | 149 +++++++-
 pkt-line.h                              |  77 ++++
 protocol.c                              |   2 +
 protocol.h                              |   1 +
 remote-curl.c                           | 257 ++++++++++++-
 remote.h                                |   9 +-
 serve.c                                 | 260 +++++++++++++
 serve.h                                 |  15 +
 t/helper/test-pkt-line.c                |  64 ++++
 t/t5701-git-serve.sh                    | 176 +++++++++
 t/t5702-protocol-v2.sh                  | 239 ++++++++++++
 transport-helper.c                      |  84 +++--
 transport-internal.h                    |   4 +-
 transport.c                             | 116 ++++--
 transport.h                             |   9 +-
 upload-pack.c                           | 625 ++++++++++++++++++++++++--------
 upload-pack.h                           |  21 ++
 39 files changed, 3088 insertions(+), 360 deletions(-)
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
2.16.0.rc1.238.g530d649a79-goog


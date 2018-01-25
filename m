Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E158F1F404
	for <e@80x24.org>; Thu, 25 Jan 2018 23:58:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751434AbeAYX6o (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Jan 2018 18:58:44 -0500
Received: from mail-yw0-f201.google.com ([209.85.161.201]:53515 "EHLO
        mail-yw0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751187AbeAYX6n (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jan 2018 18:58:43 -0500
Received: by mail-yw0-f201.google.com with SMTP id n70so5960941ywd.20
        for <git@vger.kernel.org>; Thu, 25 Jan 2018 15:58:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=0akZzDYAE2rfOftqjZhbmbiNZgs1nFe4VsKyaBcxfLg=;
        b=jy3Qr5fV0A2TlhVcqgilV8yEUy2tFmvji+wJJ0CO8r1VZh1sV0CT5IXpimlO7UvxIV
         jIOD0QdHh5/y5evOf67OQqV+68pAJgewG7OfE+V162pAuM9168ZHdIXM7Fs08Fv2HRns
         afnI5FRLpDjMac90DFMJQloZDpoP8kSyVetcd7RIJh4Xu7TbToBdTgC3fj+IAbeOvIRS
         7eq92TEvmqKo6sLJGcUKbKqaTNoQNbedjZVfeVjhxdawEtSVv2zXYOu0eHA/ur07cy2V
         ZFijRzXgsuPglAYJ2rDR5zsgaTtSc+5BGaVUjZxvSpNW172CQnN5VfW3CAAg5bTaGFoE
         SiGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=0akZzDYAE2rfOftqjZhbmbiNZgs1nFe4VsKyaBcxfLg=;
        b=jjS9wBiwVxm6/MswoTjVrhmGPkkVb9uqVJnRScH/s8pY3upRbylK/FUv1AX1w49i4g
         rQaTqBZJo4QNrsTmT+A1Ky4EKpwYAH2YiNeg2Vm7Fhf6lGdYceF+7eoQAC4IiVn7wKxF
         zjctH9mHmqUVX8ULauj/U3RmiJYDS06lsrqGMK1Af8GxxbPJZvZVKza2aw7E8wnEnD0H
         Q4o0Ap1vSLUNUJ4KRj24s5sHP1FWml02liEqPgJyip2zkoPrgLByPHgWk3JTvFGuEux6
         T1Lyn0qCIxCCh54LGfPRU1DwMXdnRPvQ5nm22NXLLjB2+Do3cLrkNZMjvFODYXxbOHo8
         YYoQ==
X-Gm-Message-State: AKwxytesG1LDxtpgUxDkbtFSVHmTWggmppwg0nr2oGBp+oQ4QKbtInLH
        +esSBFcnLpus5kCRubcdmxmn3ViPdms18OjkAXU5FTx6b+5FT+SDKxxRgLsAIg3nJMwVmokb6nI
        ib+eQqjB+aEvAhmHNAL7I7uKTwY/Mdx3VFqXO2P1yHyRu6oX4KAUaGrGo6w==
X-Google-Smtp-Source: AH8x225glhBWS3lIh1GCQSyIAkNf0AUPSazKf+/1TWM1gRMCRuI4Sh5qinYCUBBrQSXcT1K8baMmarDbGpE=
MIME-Version: 1.0
X-Received: by 10.37.199.130 with SMTP id w124mr5947943ybe.30.1516924722503;
 Thu, 25 Jan 2018 15:58:42 -0800 (PST)
Date:   Thu, 25 Jan 2018 15:58:11 -0800
In-Reply-To: <20180103001828.205012-1-bmwill@google.com>
Message-Id: <20180125235838.138135-1-bmwill@google.com>
References: <20180103001828.205012-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.0.rc1.238.g530d649a79-goog
Subject: [PATCH v2 00/27] protocol version 2
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, gitster@pobox.com, peff@peff.net,
        philipoakley@iee.org, stolee@gmail.com, jrnieder@gmail.com,
        Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changes in v2:
 * Added documentation for fetch
 * changes #defines for state variables to be enums
 * couple code changes to pkt-line functions and documentation
 * Added unit tests for the git-serve binary as well as for ls-refs

Areas for improvement
 * Push isn't implemented, right now this is ok because if v2 is requested the
   server can just default to v0.  Before this can be merged we may want to
   change how the client request a new protocol, and not allow for sending
   "version=2" when pushing even though the user has it configured.  Or maybe
   its fine to just have an older client who doesn't understand how to push
   (and request v2) to die if the server tries to speak v2 at it.

   Fixing this essentially would just require piping through a bit more
   information to the function which ultimately runs connect (for both builtins
   and remote-curl)

 * I want to make sure that the docs are well written before this gets merged
   so I'm hoping that someone can do a through review on the docs themselves to
   make sure they are clear.

 * Right now there is a capability 'stateless-rpc' which essentially makes sure
   that a server command completes after a single round (this is to make sure
   http works cleanly).  After talking with some folks it may make more sense
   to just have v2 be stateless in nature so that all commands terminate after
   a single round trip.  This makes things a bit easier if a server wants to
   have ssh just be a proxy for http.

   One potential thing would be to flip this so that by default the protocol is
   stateless and if a server/command has a state-full mode that can be
   implemented as a capability at a later point.  Thoughts?

 * Shallow repositories and shallow clones aren't supported yet.  I'm working
   on it and it can be either added to v2 by default if people think it needs
   to be in there from the start, or we can add it as a capability at a later
   point.

Series can also be found on on github: https://github.com/bmwill/git/tree/protocol-v2

Brandon Williams (27):
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
  transport-helper: remove name parameter
  transport-helper: refactor process_connect_service
  transport-helper: introduce stateless-connect
  pkt-line: add packet_buf_write_len function
  remote-curl: create copy of the service name
  remote-curl: implement stateless-connect command

 .gitignore                              |   1 +
 Documentation/technical/protocol-v2.txt | 270 +++++++++++++++++
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
 builtin/upload-pack.c                   |  74 +++++
 connect.c                               | 295 ++++++++++++++-----
 connect.h                               |   3 +
 fetch-pack.c                            | 277 +++++++++++++++++-
 fetch-pack.h                            |   4 +-
 git.c                                   |   2 +
 ls-refs.c                               |  96 ++++++
 ls-refs.h                               |   9 +
 pkt-line.c                              | 149 +++++++++-
 pkt-line.h                              |  77 +++++
 protocol.c                              |   2 +
 protocol.h                              |   1 +
 remote-curl.c                           | 209 ++++++++++++-
 remote.h                                |   9 +-
 serve.c                                 | 253 ++++++++++++++++
 serve.h                                 |  15 +
 t/helper/test-pkt-line.c                |  62 ++++
 t/t5701-git-serve.sh                    | 172 +++++++++++
 t/t5702-protocol-v2.sh                  | 117 ++++++++
 transport-helper.c                      |  84 +++---
 transport-internal.h                    |   4 +-
 transport.c                             | 119 ++++++--
 transport.h                             |   9 +-
 upload-pack.c                           | 501 ++++++++++++++++++++++++--------
 upload-pack.h                           |  18 ++
 37 files changed, 2646 insertions(+), 297 deletions(-)
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


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 956DC1F424
	for <e@80x24.org>; Mon, 23 Apr 2018 22:46:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932558AbeDWWqd (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Apr 2018 18:46:33 -0400
Received: from mail-ot0-f201.google.com ([74.125.82.201]:37231 "EHLO
        mail-ot0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932514AbeDWWqc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Apr 2018 18:46:32 -0400
Received: by mail-ot0-f201.google.com with SMTP id a13-v6so11671091oti.4
        for <git@vger.kernel.org>; Mon, 23 Apr 2018 15:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:message-id:subject:from:to:cc;
        bh=CaTcUrz/OdKVi5A50kO9pQuaWrA+0lTk/P7sQ4qF62U=;
        b=rJREdnokoBisiPheThX4nahDUSgEpy13TSWxKeiC1DiyWRtsSQXNEqM7keiG6xCqTQ
         Zr14tcBbRXIzQdY9ZNWAwe3q4wEUVpS9DfqOoHZ51FdPrzRiQgi/PI4qyxd1ee3pR4kJ
         DQq6lERebZzwpvdZwE2wCwbrTxBaCBN+I0gGmjnslqh1pq5+KVKivQJ++W61yEtKmvoQ
         BpZSYfHV3/D4W4J6vDVXsXO9JjdrzVF/RvLnKF2VCQhM7LhThe89CeHPJSs8iSFmxxXS
         R/FgRjGqU+AK0crsaMRscwDflm/d/Y6jt0LQjpCuuH+XDQ0xaO0PnP7gtHzu0RAZPGBF
         ED5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to:cc;
        bh=CaTcUrz/OdKVi5A50kO9pQuaWrA+0lTk/P7sQ4qF62U=;
        b=NLw01/84cjVCape05MccmaImZu7KHK/C72O8ypJ8d7GpQIS74FQaWo0kr/2qwl8ASd
         CjLKybcgE6QZG9E4e5EjeQJFbai2hvzjaIS5Ta5mqVE7PjVYmd2rLC6Ay2hNZtT9HlpT
         499Up64YCiUb0sawPICO/KXWGUn0y4xOpvx5om2zxMVZwcaaxUZq6EgppcNdS5BCwHXQ
         +WXCLDR+KMcV6KX73BnkgSDUC+ELgur4gkVg71JIp8WFvVUgVDamgmWRIrEXTOhsZok6
         D9np9MPBLBmJVuzf1CtwhC7TgGwukQDNZYasf1LqX/ftLO7IjSmGPjaAXnKw3XPleSUV
         k9ag==
X-Gm-Message-State: ALQs6tDWdiM+ongV0CZT1s4X38jrBJnA+T9+raxpToIp8o0cqsxbAkKi
        ltm1AZw05mI5jgwNj25UStXa6DywUCNxGcx/OxQ5mo+ukp8a6VQDq96SPrzeL4ZX9vKAuqvbSjq
        deErs2hbT4vDAordFQJXYvHk0omX7tqQ7r8sqTUrYsVChNjm9UWD0kKBRFg==
X-Google-Smtp-Source: AIpwx4+0JmcJg3vFXtkrMXuERMWoRzYp69nc17+MajnWMZr+seRtZQaU3PXVEnycIlKWnhyRDgc0fPdzqys=
MIME-Version: 1.0
X-Received: by 2002:a9d:1a6f:: with SMTP id u44-v6mr9258570otu.74.1524523591432;
 Mon, 23 Apr 2018 15:46:31 -0700 (PDT)
Date:   Mon, 23 Apr 2018 15:46:21 -0700
Message-Id: <20180423224624.213341-1-bmwill@google.com>
X-Mailer: git-send-email 2.17.0.484.g0c8726318c-goog
Subject: [PATCH 0/3] optionally send server-options when using v2
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org, bmwill@google.com
Cc:     Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Building on top of protocol version 2 this series adds the ability to
optionally send server specific options when using protocol v2. This
resembles the "push-options" feature except server options are sent as
capability lines during a command request allowing for all current and
future commands to benefit from sending arbitrary server options (and
not requiring that sending server specific options be re-implemented for
each and every command that may want to make use of them in the future).

These options can be provided by the user via the command line by giving
"-o <option>" or "--server-option=<option>" to either ls-remote or
fetch.

Command request example:

	command=fetch
	server-option=hello
	server-option=world
	0001
	want A
	want B
	have X
	have Y
	0000

These options are only transmitted to the remote end when communicating
using protocol version 2.

Brandon Williams (3):
  serve: introduce the server-option capability
  ls-remote: send server options when using protocol v2
  fetch: send server options when using protocol v2

 Documentation/fetch-options.txt         |  8 +++++++
 Documentation/git-ls-remote.txt         |  8 +++++++
 Documentation/technical/protocol-v2.txt | 10 ++++++++
 builtin/fetch.c                         |  5 ++++
 builtin/ls-remote.c                     |  4 ++++
 connect.c                               |  9 ++++++-
 fetch-pack.c                            |  7 ++++++
 fetch-pack.h                            |  1 +
 remote.h                                |  4 +++-
 serve.c                                 |  1 +
 t/t5701-git-serve.sh                    | 21 ++++++++++++++++
 t/t5702-protocol-v2.sh                  | 32 +++++++++++++++++++++++++
 transport.c                             |  3 ++-
 transport.h                             |  6 +++++
 14 files changed, 116 insertions(+), 3 deletions(-)

-- 
2.17.0.484.g0c8726318c-goog


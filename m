Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 04C8520A1E
	for <e@80x24.org>; Wed, 12 Dec 2018 00:25:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726229AbeLLAZW (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Dec 2018 19:25:22 -0500
Received: from mail-io1-f74.google.com ([209.85.166.74]:44471 "EHLO
        mail-io1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726201AbeLLAZW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Dec 2018 19:25:22 -0500
Received: by mail-io1-f74.google.com with SMTP id v8so15632803ioh.11
        for <git@vger.kernel.org>; Tue, 11 Dec 2018 16:25:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Wa1KUjJXedlG03185JrNXvDZASnjTveVbxMFtAGfSJo=;
        b=LmEWVRNZqY9XkOpCUBvYoKZi2ONaN7B9Ydo6pSrlFpuHiuUZ6B/Mk/2NugwHLkyA+c
         GrmxbqIDIzK6qbxhQVyjiGD5W10U7rZUqWM3pHaTiA521LWQ8za/bs0NJzBh7Ug5l404
         GZdu4HA23c+Zr8yN2g2FhmqZlSHF1oxvDcnTVKrTstfY/mb0UN54UGC3jleXQjbPWbi2
         RmcRiF+AE95bRN30ZhvK4zSgRUoXjJ3jq1QZo4abhRRtdK8bKNeh6wTC/wLc1zuS/55S
         kvaGNjm4WN1E89nSvr5494KS5OO/CR7kqjDENH0H+HrqiX2RWhStWMUeOYij90Tcmu+c
         ckgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Wa1KUjJXedlG03185JrNXvDZASnjTveVbxMFtAGfSJo=;
        b=j3MjgOgVAE0O9+PeeNq9kKmBWWxJv4WIWGXiwJUftGvH8q8p404KwabW9H3VkQIKpw
         hExN+mOmm45kTJCG6PYfjs3qmZ2qG3Nkta5LtJDdTPU65v51QY71lkjgtFc9zKL5MO/e
         BGh6ClWxl6TgSS9Yuv6ceM5mCvSbBRw1Mowdw1roIgVzaIeBUVjtAItynKUUMwoypVxw
         zv0/h/BrtQxRhF1kCRJYl74u0+m9PnjgV7B9qCbK+Lnap6bWYozGQjvEr9fsa3P0HDg9
         U5rM7mK1vGP7aREiEQQM/juyTb/JxgF8iJvID0CEzzBkc1ghcN3eh5gWExPbVsKp0nSj
         WERg==
X-Gm-Message-State: AA+aEWYBXjAanrc2/OKqcY0v5NJ42W56cUc649/EMGEdB0FIP3y+D0VW
        sYP8k6QIclW82w0cT8lnubfwLrMtrngZ9r2igdEAuq6eeenZg2SetB4UsGkV0T3HQsZn8EFT+ue
        6ap5qMXhyzUOc3GQv3dK81pJkcgWqSQhIqIY3AQMdcZaXMdZdGc2BsWZ1CQjz4kY=
X-Google-Smtp-Source: AFSGD/VecFvCLvS0OOlKVy4HQNvmsXKmgX5JQVLh7TQxRL3cW9YMX6Q5rIAezUzyeqSw1R1QXvbXFWI1ofRPpw==
X-Received: by 2002:a24:16d3:: with SMTP id a202mr3274540ita.21.1544574321118;
 Tue, 11 Dec 2018 16:25:21 -0800 (PST)
Date:   Tue, 11 Dec 2018 16:25:14 -0800
In-Reply-To: <20181116084427.GA31493@sigill.intra.peff.net>
Message-Id: <cover.1544572142.git.steadmon@google.com>
Mime-Version: 1.0
References: <20181116084427.GA31493@sigill.intra.peff.net>
X-Mailer: git-send-email 2.20.0.rc2.403.gdbc3b29805-goog
Subject: [PATCH v3 0/4] Unify pkt-line error handling and refactor smart-http
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, gitster@pobox.com, masayasuzuki@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a reroll of js/smart-http-detect-remote-error that also includes
a fixed version of ms/proto-err-packet-anywhere [1].

The first patch clarifies the use of ERR messages in the pkt-line
protocol and unifies error handling in pkt-line.c

The second patch refactors smart-http discovery in remote-curl.c. Among
other improvements, it makes more use of the pkt-line functions, which
allows us to catch remote errors that were previously ignored.

The third patch makes the version check in remote-curl more strict.

The final patch adds a test to verify that the fix in patch #2 does
actually catch remote HTTP errors.

[1]: https://public-inbox.org/git/20181127045301.103807-1-masayasuzuki@google.com/

Jeff King (2):
  remote-curl: refactor smart-http discovery
  remote-curl: tighten "version 2" check for smart-http

Josh Steadmon (1):
  lib-httpd, t5551: check server-side HTTP errors

Masaya Suzuki (1):
  pack-protocol.txt: accept error packets in any context

 Documentation/technical/pack-protocol.txt | 20 ++---
 builtin/archive.c                         |  2 -
 connect.c                                 |  3 -
 fetch-pack.c                              |  2 -
 pkt-line.c                                |  4 +
 remote-curl.c                             | 93 ++++++++++++++---------
 t/lib-httpd.sh                            |  1 +
 t/lib-httpd/apache.conf                   |  4 +
 t/lib-httpd/error-smart-http.sh           |  3 +
 t/t5551-http-fetch-smart.sh               |  5 ++
 t/t5703-upload-pack-ref-in-want.sh        |  4 +-
 11 files changed, 89 insertions(+), 52 deletions(-)
 create mode 100644 t/lib-httpd/error-smart-http.sh

-- 
2.20.0.rc2.403.gdbc3b29805-goog


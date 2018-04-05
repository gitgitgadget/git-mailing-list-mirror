Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F3B811F404
	for <e@80x24.org>; Thu,  5 Apr 2018 02:58:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751270AbeDEC6w (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Apr 2018 22:58:52 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:34740 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750890AbeDEC6t (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Apr 2018 22:58:49 -0400
Received: by mail-pl0-f67.google.com with SMTP id u11-v6so17164344plq.1
        for <git@vger.kernel.org>; Wed, 04 Apr 2018 19:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=W3WzHt/QvuDf2mvDoYyuUe7MLyZ7ovCQgOK4f07xvPY=;
        b=hWzyfJmZaHTa9KLYJ0z9N7Fkk3mfsF21swOqBACAMCctm3cdRw1Ww9Djb7cY/n4rMD
         uMcN7LHGnSeWoUZWKAtI1PWxy57uNgRX7rL4aulSaUEIRGrkYkh4P7gsNh9QqyytzUZj
         oa3OM1cPGZV4p4WJio08EyUQmY48eUqmDKLWWn0up7tPuzLSE6ZXgY4Zf3DCvPwd2iXl
         fqhvWU0OH++G23gB+NEe5YDUwjVc+WIVhPsKeZO331KtC3H+8uiL3W6C3qDp4fQkBYI+
         CWk1AayNW3zPYXsPLBi5khi0XkILShcvajhvT2ktzLc30RbkfziAMIrW+GV9d5qtwYAc
         fN3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=W3WzHt/QvuDf2mvDoYyuUe7MLyZ7ovCQgOK4f07xvPY=;
        b=EvAAf5AbMQPDD1KDjBy80/HEWfEjCDOrRWVrZZwlxpPb/0rC5taH8JAC7jUJb9ndEi
         HR7DgfmKWWG1ty9FJpqbJDvZ1iF4rp6c0HBF5rH+GDvng2tk9cjtq/1gvWVy8PZQxQKi
         sILJk7Wq8jwltdMST+9/PVsuejeU7VjFvmxgo5RfWag1kwBXm3tv+AHbhzJePr4AQhPP
         I6mk+1lw2VRuJsrCooLNad+EGWaPxEY1voCHJTV1G1jSlrR5b8MiMyLWg+cR355+J6Sg
         kcmLY0gbAbLLqyFQ+9CoXWmWAXQweCHOQN6YPoAEq2gszqv0FNzuFXKpFCwV3bTFW+aG
         ikDg==
X-Gm-Message-State: AElRT7GabK/rRNdVlrs1FpBIsUpPMwqzDyctkpJrnfeb9W6X1oIX7Edj
        4hz9a8XFpI1pbgBHpfh52p2myUU7q5eCJA==
X-Google-Smtp-Source: AIpwx4+Oa1GV0l+tSqdOstWszRsLl7wolHpp9W7rQYBGIzvDItsfvinV5rKjwY08Iblvv4rbUrR3Ow==
X-Received: by 10.99.112.80 with SMTP id a16mr13506376pgn.371.1522897128463;
        Wed, 04 Apr 2018 19:58:48 -0700 (PDT)
Received: from localhost ([2601:602:9500:3a4f:dc75:c2ae:e99:b3d1])
        by smtp.gmail.com with ESMTPSA id e3sm10359139pgr.80.2018.04.04.19.58.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Apr 2018 19:58:46 -0700 (PDT)
Date:   Wed, 4 Apr 2018 19:58:45 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, sunshine@sunshineco.com
Subject: [PATCH v4 0/3] Teach `--default` to `git-config(1)`
Message-ID: <20180405025845.GA49902@syl.local>
References: <20180329011634.68582-1-me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180329011634.68582-1-me@ttaylorr.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Attached is a fourth re-roll of my series to add "--default" and
"--type=color" to "git config" in order to replace:

  $ git config --get-color <variable> [default]

with

  $ git config [--default=<default>] --type=color <variable>

Since the last revision, I have:

  - Rebased it upon the latest changes from my series to add
    "--type=<type>" in favor of "--<type>".

  - Fixed various incorrect hunks mentioning "--color" (which does not
    exist), cc: Eric, Junio.

  - Fixed referencing "slot" when the correct spelling is "variable".
    cc: Junio.

As always, thank you for your helpful feedback. This process is still
new to me, so I appreciate an extra degree of scrutiny :-).

I am hopeful that this series is ready for queueing.


Thanks,
Taylor

Taylor Blau (3):
  builtin/config: introduce `--default`
  config.c: introduce 'git_config_color' to parse ANSI colors
  builtin/config: introduce `color` type specifier

 Documentation/git-config.txt | 14 +++++++++----
 builtin/config.c             | 33 +++++++++++++++++++++++++++++++
 config.c                     | 10 ++++++++++
 config.h                     |  1 +
 t/t1300-repo-config.sh       | 30 ++++++++++++++++++++++++++++
 t/t1310-config-default.sh    | 38 ++++++++++++++++++++++++++++++++++++
 6 files changed, 122 insertions(+), 4 deletions(-)
 create mode 100755 t/t1310-config-default.sh

--
2.17.0

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A73051F403
	for <e@80x24.org>; Sat, 16 Jun 2018 19:26:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933022AbeFPT0U (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Jun 2018 15:26:20 -0400
Received: from mail-pl0-f45.google.com ([209.85.160.45]:39123 "EHLO
        mail-pl0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932554AbeFPT0T (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Jun 2018 15:26:19 -0400
Received: by mail-pl0-f45.google.com with SMTP id f1-v6so6981146plt.6
        for <git@vger.kernel.org>; Sat, 16 Jun 2018 12:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=content-transfer-encoding:mime-version:from:to:cc:subject
         :message-id:date;
        bh=d4qRoxUmlwto9BQkGaev6W7s0X/N3ypRDxf4+mhn/hE=;
        b=BN6UFwmiS2HsJ07gL2+XYzuqlbBHBcHs644IDggHF3B8VmhdsAew1xWUhqr4BeV/qr
         M9eol6YJ52Htqncb9P3o4QzTSSs0VAH49j0RmdVhBqvORST5ElsKjGKV89N15PfK3l1x
         bf4Oozl6vKbnmhcJZ4kSRAWi8m4/J/TmnVY84mC10s0fi9HmwkiWq+9PmDyzgRvkgHWn
         UnCfZ14wjZ8QFTXezaU6/I20b7rjp9lEWNpIBiu1W9p7Rv7bUhTVBK/vpZTYVHgIMlUo
         VGueNRyma3QFgbjSd9WcZTNlq+KngUCRPk7/LyKvZOgpW99zkpfeyHY7hlUrth3XiDR+
         1OaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:mime-version:from:to
         :cc:subject:message-id:date;
        bh=d4qRoxUmlwto9BQkGaev6W7s0X/N3ypRDxf4+mhn/hE=;
        b=WucAubOS5Y1EUo5LwBoMYQCZU8UCEv8u2H1yt/UvWoAuuS1BXI7DQG4HJQ5+ohUHah
         cM5Xeqlr2kRoXr7Z260MK7WSkAcSgizjOmkBs3EalwdyRv/mvMCx7qELdzisf9T8MAp9
         Tmv/gbYmik0DC/R9T4kulcaY+Mv0jeydfSsPwYCZCBtbDcHyrTwmP3etYp5BocUsxser
         vXfkvp69QYfU3J6mPAW+gaXR8oV5HX/lxz3/QrcdW470cnhgQNdqtED7ZBt+1VhQjtia
         hKYe0EnpoutayOVJr3AZNfZKnV1ETX7q1ZowceBGwe1D1+CyUZVZpZ5hvFGkFlUk/+ew
         zx7g==
X-Gm-Message-State: APt69E0wWL5AH12cgdAVFhZEl2ThzfQ+5oJT6AX31b9BF8JtdkzwEvIT
        oKkG/EpH1p7eu7wGPSLgzMlNPaS2
X-Google-Smtp-Source: ADUXVKKkywexexcD5Oe19T6n/HhsLszgZkzitnwAJlvo42XQf/cq8DdNvraSEAIaNutnvik5pf8HOg==
X-Received: by 2002:a17:902:7406:: with SMTP id g6-v6mr7499553pll.90.1529177178619;
        Sat, 16 Jun 2018 12:26:18 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.139.85])
        by smtp.gmail.com with ESMTPSA id g12-v6sm15651532pfh.164.2018.06.16.12.26.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 16 Jun 2018 12:26:17 -0700 (PDT)
Content-Type: text/plain
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
To:     git@vger.kernel.org
Cc:     GitGitGadget <gitgitgadget@gmail.com>
Subject: [PATCH 0/2] rebase --root: fix `reword` on a root commit
Message-ID: <pull.3.git.gitgitgadget@gmail.com>
Date:   Sat, 16 Jun 2018 19:26:16 +0000
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: GitGitGadget <gitgitgadget@gmail.com>

Todd Zullinger reported this =
bug in https://public-inbox.org/git/20180615043111.GS3094@zaya.teonanacatl.=
net/: when calling git rebase --root and trying to reword the root commit's=
 message, a BUG is reported.

This fixes that.

IMO the bug fix is trivial enough to qualify for inclusion into v2.18.0, =
still.

Johannes Schindelin (1):
  rebase --root: fix amending root commit =
messages

Todd Zullinger (1):
  rebase --root: demonstrate a bug while =
amending root commit messages

 sequencer.c                   | 2 +-
 t/t3404-rebase-interactive.sh | 9 +++++++++
 2 files changed, 10 =
insertions(+), 1 deletion(-)


base-commit: 68372c88794aba15f853542008cda39=
def768372
--=20
2.17.0.windows.1

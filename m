Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 075EA1F404
	for <e@80x24.org>; Wed, 29 Aug 2018 07:06:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727482AbeH2LBr (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Aug 2018 07:01:47 -0400
Received: from mail-yb0-f193.google.com ([209.85.213.193]:33134 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727054AbeH2LBr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Aug 2018 07:01:47 -0400
Received: by mail-yb0-f193.google.com with SMTP id d4-v6so1634001ybl.0
        for <git@vger.kernel.org>; Wed, 29 Aug 2018 00:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jYBeQs+7adkdZ1VQGHzdPL0PfPulHiOWeTtgg0tKj10=;
        b=FcS+9Np8duROmgptfNsh2kE5FHXxo6dD7IPk+doMxNOFilUsf/W4qSsIMTlqhb570y
         /NEK5FY+j7coKaBx+Qkeeg3RDwf4y6Kgaf/HXMH5Hz6cV+8eGbnqszHr9KayMPJJzijW
         wIKrj1MiJKkaJAxC42UW8dMnIYqh34eKsmkqB+frv7p0kweT7UbhsUigIzLCA87z1Dfk
         hiJP4sjJC8IGSIsqhuKUT38fHsNVH+unz0qyeoOmUuusvgZV4guq2eVQ3p+hEpyeIhMb
         tOHHi1Q8+XR+WjJSeYTnWWI12zvcU1uuTzcEMchNf9VscRUE59nVkBt3Xol1JAXfVINA
         +TSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jYBeQs+7adkdZ1VQGHzdPL0PfPulHiOWeTtgg0tKj10=;
        b=sA4tpXBn89d0PbU76s1enPcW6uHseqEVDmqDC3PI4ilBwvG5rgkaEmvdDTxhcRJo5D
         jKgM0fu+ByUHvz1HUgra3FquUkKFQlYWoUPD9TAxc8l5gt5zbCmv2oDgx7ADUHp5hlr7
         DMLjdYY5ppGRKgJVRs4TgH2P6ymvRGSXjbcqguC/T05E3dqDQULrWHsE1bWhiEXnOZwc
         IEhI/8d8LZB0/5JvqFlNibUD2liUhRuxEzgOty5s1mN+oZARl7hEYR2J6UUnZ6U/Tgfb
         YeQOt5DX80aa62jor9Pz2u4rorSCrIm4c2Ignb1h7PMQqS+EJcm9KZdAMVKH91V2T1qf
         wY9Q==
X-Gm-Message-State: APzg51BCsf4wE9JLCdPDJ4dS1KsSGxuS6LrC8+mwQKJYOUEIgpLXXLUB
        b2iLIBzBts+gidbjDAKHoTN2Gsk0
X-Google-Smtp-Source: ANB0VdZJIlhD3m80FJhMCCS4Z4so0uHRefEl0g90Cgq1WZdtBRg2v8d3PPXuPc30TOZjqwrG+alwJQ==
X-Received: by 2002:a25:df96:: with SMTP id w144-v6mr763455ybg.210.1535526380436;
        Wed, 29 Aug 2018 00:06:20 -0700 (PDT)
Received: from tiger.attlocal.net ([2602:30a:2c28:20f0:7c1a:85e3:2ea9:5d7e])
        by smtp.gmail.com with ESMTPSA id n6-v6sm1269794ywe.89.2018.08.29.00.06.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 Aug 2018 00:06:19 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, corrmage@gmail.com, avarab@gmail.com,
        Johannes.Schindelin@gmx.de, sbeller@google.com,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH 0/3] Turn off directory rename detection in am -3
Date:   Wed, 29 Aug 2018 00:06:10 -0700
Message-Id: <20180829070613.11793-1-newren@gmail.com>
X-Mailer: git-send-email 2.18.0.12.g97a29da30a
In-Reply-To: <xmqqh8jeh1id.fsf@gitster-ct.c.googlers.com>
References: <xmqqh8jeh1id.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 28, 2018 at 9:58 AM Junio C Hamano <gitster@pobox.com> wrote:
> Elijah Newren <newren@gmail.com> writes:
>
> >   - Add a flag to turn off directory rename detection, and set the
> > flag for every call from am.c in order to avoid problems like this.
>
> I'd say this is the only practical solution, before you deprecate
> the "pipe format-patch output to am -3" style of "git rebase" (and
> optionally replace with something else).
>
> The whole point of "am -3" is to do _better_ than just "patch" with
> minimum amount of information available on the pre- and post- image
> blobs, without knowing the remainder of the tree that the patch did
> not touch.  It is not surprising that the heuristics that look at
> the unchanging part of the tree to infer renames that may or may not
> exist guesses incorrectly, either with false positive or negative.
> In the context of "rebase", we always have all the trees that are
> involved.  We should be able to do better than "am -3".

Here are patches to do so; they are built on the top of
en/rebase-consistency, since I wanted to re-use some test code and the
testfile introduced in that series, and to keep similar tests
together.

Elijah Newren (3):
  t3401: add another directory rename testcase for rebase and am
  merge-recursive: add ability to turn off directory rename detection
  am: avoid directory rename detection when calling recursive merge
    machinery

 builtin/am.c                    |   1 +
 merge-recursive.c               |  18 ++++--
 merge-recursive.h               |   1 +
 t/t3401-rebase-and-am-rename.sh | 110 +++++++++++++++++++++++++++++++-
 4 files changed, 124 insertions(+), 6 deletions(-)

-- 
2.18.0.12.g97a29da30a

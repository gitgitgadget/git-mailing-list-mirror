Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 534121F42D
	for <e@80x24.org>; Sun, 20 May 2018 10:18:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751109AbeETKSV (ORCPT <rfc822;e@80x24.org>);
        Sun, 20 May 2018 06:18:21 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:45767 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750928AbeETKST (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 May 2018 06:18:19 -0400
Received: by mail-wr0-f195.google.com with SMTP id w3-v6so5483747wrl.12
        for <git@vger.kernel.org>; Sun, 20 May 2018 03:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dzKSC7YPy7A0LG/pkeDAJkyX+JSzgbGds+PLE9E3a6Y=;
        b=IVCaZBKhBWJy2lPvGq3wxSvnK3XEM59to2Tjcsfl7tRMKVdlXtb+vrznnEh6B9LZIq
         /N8K0d/FLUl0y9/QkWJcZ6qm2HcpZbtfxPxAjSlbYzfZ2Qa4OnFD+QfML7TU/1tWX1y8
         6iaEnybdsGtxq7okr6NdfHZEAgWmG+Xd/7Q3DjCSiwRDRJ3bYNRrxu4Wjc6MYVxUE81n
         ZPS1AqaengPc3Md6Et7b/Jpbe2f+uHC1hjDu7mVJT0heojCgizfv7RLJ1UUBOlg+rXVX
         DMCNAt1bFus6kIrfXWdvO28lEYBfREM+gEaTS17lfggZ7tguSsnT6XeGLOLUIUFbAEds
         wA/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dzKSC7YPy7A0LG/pkeDAJkyX+JSzgbGds+PLE9E3a6Y=;
        b=UNL4GirHltKBMuj2ciWxImdttai7JpyCA56PL0n78hzv8oHB+JwK3/Tb9QVm+Am9RJ
         e6CxH2PGqsaCxAJkqqcPFYnHapxMg1mjbWB5/GeQQLWWDkd0/IpwI3xZauAbsb0YR8sQ
         WSCzGps8i9njjKhIHjVpkTO+aJH8dYWWyOZvHD6UubtsJVXEDGjAHxlmEV5jPk4C9Xdj
         CSfxMYQeTZme8Mb5Wv7AEEwuQlBlq0rBXtMvLmqymSCKCzd0wzvyc4uqDHvZ0yOtZAMX
         UunAEgmku6woehP4OCuxQras+7/9E43MBcUhbPO1bWA57lV25w+Mq+EHwiSc52+N4tb+
         pE/A==
X-Gm-Message-State: ALKqPwdthMkjGPZuoauON0ZTDU9USpe4kDguqV08MinOIIaqKjx32uiP
        6kX1vWXiZqUthJ19lSx2iT5OUGQ1OIo=
X-Google-Smtp-Source: AB8JxZqw6katQIjkwgBTn+yOwXDO0JkH7HLn22VUpycxwW01JHxZRra7TrHdJHtmRGG7r1nQsuMCHQ==
X-Received: by 2002:adf:ac28:: with SMTP id v37-v6mr13073621wrc.56.1526811498156;
        Sun, 20 May 2018 03:18:18 -0700 (PDT)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:c938:fbb7:46f8:2405])
        by smtp.gmail.com with ESMTPSA id t189-v6sm10210374wmf.22.2018.05.20.03.18.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 20 May 2018 03:18:17 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Phillip Wood <phillip.wood@talktalk.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 0/4] unpack_trees_options: free messages when done
Date:   Sun, 20 May 2018 12:17:33 +0200
Message-Id: <cover.1526810549.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.17.0.840.g5d83f92caf
In-Reply-To: <CAN0heSp7DqxOy-UeLgj8t_T_4f-fNthMpGNS8oUbcs7+NvS-zw@mail.gmail.com>
References: <CAN0heSp7DqxOy-UeLgj8t_T_4f-fNthMpGNS8oUbcs7+NvS-zw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is v4 of my series for taking care of the memory allocated by
`setup_unpack_trees_porcelain()`. As before, this is based on
bp/merge-rename-config.

On 19 May 2018 at 08:13, Martin Ågren <martin.agren@gmail.com> wrote:
> On 19 May 2018 at 03:02, Jeff King <peff@peff.net> wrote:
>>
>>> > would become:
>>> >
>>> >   msgs[ERROR_WOULD_OVERWRITE] = msgs[ERROR_NOUPTODATE_FILE] =
>>> >         string_list_appendf(&opts->msgs_to_free, msg, cmd, cmd)->string;
>>> >
>>> > I don't know if that's worth it or not (I suspect that there are other
>>> > places where appendf would be handy, but I didn't poke around).
>
> I'll look into this over the weekend. Thanks for the suggestion.

The difference to v3 is indeed the new patch 3/4, which introduces
`string_list_appendf()`. I think that makes patch 4/4 clearer and the
resulting code less surprising.

There is an obvious candidate for using this new function in bisect.c,
but I refrained from doing that conversion in this series. While
converting that user to use this new function would be trivial and safe,
such a change might not look entirely sane on its own. The reason is
that the user does the whole `strdup_strings`-dance that I did in v3.

I think it would be much better to do that conversion as a part of a
"let's not play with strdup_strings"-patch. I have one prepared and it
looks quite ok to me. I should be able to be able to collect more
`strdup_string`-cleanups soonish and submit a series later (say, when/if
this here series has matured).

Elijah Newren (1):
  merge-recursive: provide pair of `unpack_trees_{start,finish}()`

Martin Ågren (3):
  merge: setup `opts` later in `checkout_fast_forward()`
  string-list: provide `string_list_appendf()`
  unpack_trees_options: free messages when done

 string-list.h      |  9 +++++++++
 unpack-trees.h     |  6 ++++++
 builtin/checkout.c |  1 +
 merge-recursive.c  | 30 ++++++++++++++++--------------
 merge.c            | 35 ++++++++++++++++++++---------------
 string-list.c      | 13 +++++++++++++
 unpack-trees.c     | 20 +++++++++++++++++---
 7 files changed, 82 insertions(+), 32 deletions(-)

-- 
2.17.0.840.g5d83f92caf


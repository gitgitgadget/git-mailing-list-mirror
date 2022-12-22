Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B62DAC4332F
	for <git@archiver.kernel.org>; Thu, 22 Dec 2022 09:30:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235166AbiLVJaa (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Dec 2022 04:30:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234942AbiLVJa2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Dec 2022 04:30:28 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 158E2F5AC
        for <git@vger.kernel.org>; Thu, 22 Dec 2022 01:30:28 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id w37so958036pga.5
        for <git@vger.kernel.org>; Thu, 22 Dec 2022 01:30:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y+bvGOi7Id+B48aNwPwiW+c5HI9b9rhHOxvqPkXCkD0=;
        b=U4ql4jhIFBKDY88z7ZpeFQk5cRX+8M442F+cyjNdyfqjnPwyWunXyBfnJAd4mOiTCn
         Tw5VDK3u1CVbMbWHgttCTCrbxR48COkx25yzNV5ZszMsWPFD6SKROODPp29vvjgod4Du
         Es1yBm+efJHGr/xnacbPHFZFm2rkhQP37H430X8ruWPyxKQ5cZkoCwu0WRmpoHgjCE/Y
         ZWV/X1RNgRR8Xx+bHnrb71SFAXF2dw2RaTjOSY0EmYOoMDqciBZ6lckn4Z6Sh/UCaNUN
         qEC+9LpM6dW60J1qhoDCUbbQSy2Za3xrPsuLOqlYlI9xIYsa03I+g1U5iCHMYxl8NZ7y
         aB/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y+bvGOi7Id+B48aNwPwiW+c5HI9b9rhHOxvqPkXCkD0=;
        b=8FH/nExkB+r5Y8UxpyFEjlcsNFefuzcFO2FRgIrtfIt1uFEpQxQaEZrBADQmRwmskT
         LZ/qssr3szwigFRICCn8s3kZxrDq2Xh5pgc8vr8Q4urCDLqFQuz4aFt5y/J/pkQGqPBG
         8EbzmkooulXIYfw4lMd56HbgSPNVV1QsI4PlVgXeq+AFsaDF+es6J124z7A48RLZVf5A
         2XnfeypEAOUf0XLcTtFsqMHFpvlN97W6AIjL9E7KhqnD/yC++aIoh6KQUwm11sule5XJ
         Y4EIbiOFO2HWBSSZ4ggizH5oFTF2FDHMZfHCdocxAK8KPpG0Pwnk+UnsRJV0I4CyPbgH
         EdYQ==
X-Gm-Message-State: AFqh2krVaS8e1EJ3hBuvMOX0NyHUKARfUHV7ZtpRbNQYwJpzSQ262rqx
        dpadMQ8y8IOHKv4SHVaUyDY=
X-Google-Smtp-Source: AMrXdXtlJZdpVgsV3aw/GT5G7jseMPvxvB2FTxkbkyDDImyncqdcK1TfHfU93RF56Twhs8sErufncg==
X-Received: by 2002:a05:6a00:158f:b0:566:900d:51d8 with SMTP id u15-20020a056a00158f00b00566900d51d8mr7052335pfk.7.1671701427426;
        Thu, 22 Dec 2022 01:30:27 -0800 (PST)
Received: from localhost.localdomain ([47.246.101.55])
        by smtp.gmail.com with ESMTPSA id i184-20020a6287c1000000b00574ee8d8779sm246462pfe.65.2022.12.22.01.30.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Dec 2022 01:30:26 -0800 (PST)
From:   Teng Long <dyroneteng@gmail.com>
X-Google-Original-From: Teng Long <tenglong.tl@alibaba-inc.com>
To:     sunshine@sunshineco.com
Cc:     avarab@gmail.com, dyroneteng@gmail.com, git@vger.kernel.org,
        gitster@pobox.com, tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v3 0/5] notes.c: introduce "--no-blank-line" option
Date:   Thu, 22 Dec 2022 17:30:21 +0800
Message-Id: <20221222093021.5251-1-tenglong.tl@alibaba-inc.com>
X-Mailer: git-send-email 2.38.1.386.g196e80358e8.dirty
In-Reply-To: <CAPig+cRcezSp4Rqt1Y9bD-FT6+7b0g9qHfbGRx65AOnw2FQXKg@mail.gmail.com>
References: <CAPig+cRcezSp4Rqt1Y9bD-FT6+7b0g9qHfbGRx65AOnw2FQXKg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> Taking a step back, perhaps think of this in terms of "separator". The
> default behavior is to insert "\n" as a separator between notes. If
> you add a --separator option, then users could supply their own
> separator, such as "----\n" or, in your case, "" to suppress the blank
> line.

There is another question for me, if the separator we passed contains "\n"
string , the argument the cmd receives will need to tranfer to '\n' character
instead to make sure it's a linebreak but not a "\n" instead.

So maybe like:

diff --git a/builtin/notes.c b/builtin/notes.c
index f38e6e8b04..64ee64eff7 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -559,15 +559,52 @@ static int copy(int argc, const char **argv, const char *prefix)
        return retval;
 }

+static void insert_separator(struct strbuf *message, const char *separator)
+{
+       struct strbuf transfered = STRBUF_INIT;
+
+       if (!separator)
+               strbuf_insertstr(message, 0, "\n");
+       else if (!strcmp("", separator))
+               return;
+       else {
+               while (*separator) {
+                       if (*separator == '\\'){
+                               switch (separator[1]) {
+                                       case 'n':
+                                               strbuf_addstr(&transfered, "\n");
+                                               separator++;
+                                               break;
+                                       case 'r':
+                                               strbuf_addstr(&transfered, "\r");
+                                               separator++;
+                                               break;
+                                       case 't':
+                                               strbuf_addstr(&transfered, "\t");
+                                               separator++;
+                                               break;
+                                       default:
+                                               strbuf_addch(&transfered, *separator);
+                               }
+                       } else {
+                               strbuf_addch(&transfered, *separator);
+                       }
+                       separator++;
+               }
+               strbuf_insertstr(message, 0, transfered.buf);
+               strbuf_release(&transfered);
+       }
+}
+
 static int append_edit(int argc, const char **argv, const char *prefix)
 {
        int allow_empty = 0;
-       int blankline = 1;
        const char *object_ref;
        struct notes_tree *t;
        struct object_id object, new_note;
        const struct object_id *note;
        char *logmsg = NULL;
+       const char *separator = NULL;
        const char * const *usage;
        struct note_data d = { .buf = STRBUF_INIT };
        struct option options[] = {
@@ -585,8 +622,8 @@ static int append_edit(int argc, const char **argv, const char *prefix)
                        parse_reuse_arg),
                OPT_BOOL(0, "allow-empty", &allow_empty,
                        N_("allow storing empty note")),
-               OPT_BOOL(0, "blank-line", &blankline,
-                       N_("insert paragraph break before appending to an existing note")),
+               OPT_STRING(0, "separator", &separator, N_("text"),
+                       N_("insert <text> as separator before appending to an existing note")),
                OPT_END()
        };
        int edit = !strcmp(argv[0], "edit");
@@ -621,8 +658,8 @@ static int append_edit(int argc, const char **argv, const char *prefix)
                enum object_type type;
                char *prev_buf = read_object_file(note, &type, &size);

-               if (blankline && d.buf.len && prev_buf && size)
-                       strbuf_insertstr(&d.buf, 0, "\n");
+               if (d.buf.len && prev_buf && size)
+                       insert_separator(&d.buf, separator);
                if (prev_buf && size)
                        strbuf_insert(&d.buf, 0, prev_buf, size);
                free(prev_buf);
--

If the above is understood correctly, is there an api that handles escape
characters already in the existing code (I haven't found one so far, so I need
to confirm and replace it if there is one). In addition, the insert_separator
function above handles three special characters \t\n\r. Do we need more?

Thanks

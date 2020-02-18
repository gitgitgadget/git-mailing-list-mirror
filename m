Return-Path: <SRS0=PlGQ=4G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9B2AC34026
	for <git@archiver.kernel.org>; Tue, 18 Feb 2020 09:31:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DBDE206EF
	for <git@archiver.kernel.org>; Tue, 18 Feb 2020 09:31:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pqe/TetU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726383AbgBRJbF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Feb 2020 04:31:05 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:33072 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726295AbgBRJbF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Feb 2020 04:31:05 -0500
Received: by mail-qt1-f195.google.com with SMTP id d5so14045900qto.0
        for <git@vger.kernel.org>; Tue, 18 Feb 2020 01:31:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=2HvBVKZEi0oNawWhGZUAekLbOv+nWDNMMDI+SnmAF0c=;
        b=Pqe/TetUENzFKp4kEAuQmYdWPwnXTxKEq+yhCOZ0SMVOGCS5Wj2xPlunj5C9fam2qN
         kzu8UlMq/W8zqaPZ1hOFYcI55GJjWEKdheMoYv2yn/TIeWpIOuFswDrxzz9i8P70i7qx
         CyjvrS4FXdz0zV4iT6rqBpfS+GTxh4m2F21AfYXlNJ4rOb1n6Ui5tx9pxdrG9/6E2j5a
         +yp2VqEFI4boYgz8GEri5ThxzlCmJI14llhqqwO29rNppHabuTIqQbwnfjjMJCorivFN
         Uwr48mVedxb8gDkeAs+UfZBN9nc4anFat+9swoe1tD2pIqeg4oOVWib20n6DxB3vzRSy
         unVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=2HvBVKZEi0oNawWhGZUAekLbOv+nWDNMMDI+SnmAF0c=;
        b=JzJ0syASQsZMz2NnPsoV3KmmMcGF/ea6RwNnU2x+Ha2ht8aS+SS/gKCCYs8fpKLPpa
         44epxON68CKt7kY4MwfJEV5fzTwMLFxExcm4sNni4YV/GEszWxgXSFmbwz03Wx4lH5Xe
         +wEEpOJ/tOUjiyywu3YmCFMmbiV58z8FvIzUqDGpPVwvXWT+Ag5Lj5CBENgJFJ3bIhvU
         zIEokrT1z6y3RODWoulq/h98zvpfg5WznaeuDZhzw9bLCExEn3VaKwCFIl8RIZSNijzb
         IKVJg0CAJVkaFt3aBp32xuhyoenSGBLuuxZPs0xjVU5ZINk7riSeMbKmGS/cZrv6Vge3
         8WsQ==
X-Gm-Message-State: APjAAAUzJbAI+0B/ingCeIGAcp2W02TKEU3k8rNddtmP1VwkzuGbW8L3
        oXDtslp/ayx/woSBJFfNQyYq+yoYHFuCKKmrEjE=
X-Google-Smtp-Source: APXvYqyjwaCXc2Tqu4CKFfmV+RHdjuTo3R8CilH/aqIgO8CoSPLAUvE7Kf2LtU1Pl2UM5gfeZKFNNPFHBtY/koMySWs=
X-Received: by 2002:ac8:2939:: with SMTP id y54mr16374160qty.109.1582018262254;
 Tue, 18 Feb 2020 01:31:02 -0800 (PST)
MIME-Version: 1.0
From:   Abhishek Kumar <abhishekkumar8222@gmail.com>
Date:   Tue, 18 Feb 2020 15:00:00 +0530
Message-ID: <CAHk66fskrfcJ0YFDhfimVBTJZB4um7r=GdQuM8heJdZtF8D7UQ@mail.gmail.com>
Subject: Re: [GSoC][RFC][PATCH 2/2] STRBUF_INIT_CONST: Adapting strbuf_* functions
To:     rwagih.rw@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, l.s.r@web.de,
        pclouds@gmail.com, peff@peff.net, predatoramigo@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Greetings Robear,

I don't have the expertise to talk about the larger picture here, but
I have the following suggestions if you do go with it.

I don't agree with this patchset being two different patches - The
changes in the second patch eliminate possibly buggy behavior of using
the new function.

I would also prefer the term "immutable" over "const" since const
already has implications in C programming.

> STRBUF_INIT_CONST: a new way to initialize strbuf

Use imperative mood and be more specific in the commit title -
`strbuf: Teach strbuf to initialize immutable strings`

> In a previous commit, a new function `STRBUF_INIT_CONST(const_str)`,
> which would allow for the quick initialization of constant `strbuf`s,
> was introduced.

Redundant if you merge both patches.

In this commit, I check through the strbuf_* functions to edit the ones
that would try to edit the passed `strbuf` so that they are guaranteed to
behave in a predictable way when met with a constant.

> Added Functions:
>   `strbuf_make_var`
>
> Updated Functions:
>   `strbuf_grow`
>   `strbuf_setlen`
>   `strbuf_trim`
>    `strbuf_trim_trailing_dir_sep`
>    `strbuf_trim_trailing_newline`
>    `strbuf_tolower`
>    `strbuf_splice`
>
> Functions where comments were added to clarify the expected behavior:
>    `strbuf_getcwd`

I feel this is self-explanatory when you go through the diff.

Signed-off-by: Robear Selwans <robear.selwans@outlook.com>
---
 strbuf.c | 25 +++++++++++++++++++++++++
 strbuf.h | 14 ++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/strbuf.c b/strbuf.c
index f19da55b07..48af039b6e 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -89,6 +89,8 @@ void strbuf_attach(struct strbuf *sb, void *buf,
size_t len, size_t alloc)

 void strbuf_grow(struct strbuf *sb, size_t extra)
 {
+    if (sb->len > sb->alloc)
+        strbuf_make_var(sb);
     int new_buf = !sb->alloc;
     if (unsigned_add_overflows(extra, 1) ||
         unsigned_add_overflows(sb->len, extra + 1))
@@ -100,8 +102,18 @@ void strbuf_grow(struct strbuf *sb, size_t extra)
         sb->buf[0] = '\0';
 }

+void strbuf_make_var(struct strbuf *sb)
+{
+    char* str_cpy;
+    ALLOC_ARRAY(str_cpy, sb->len + 1);
+    memcpy(str_cpy, sb->buf, sb->len);
+    strbuf_attach(sb, str_cpy, sb->len, sb->len + 1);
+}
+
 void strbuf_trim(struct strbuf *sb)
 {
+    if (sb->len > sb->alloc)
+        strbuf_make_var(sb);
     strbuf_rtrim(sb);
     strbuf_ltrim(sb);
 }
@@ -115,6 +127,8 @@ void strbuf_rtrim(struct strbuf *sb)

 void strbuf_trim_trailing_dir_sep(struct strbuf *sb)
 {
+    if (sb->len > sb->alloc)
+        strbuf_make_var(sb);
     while (sb->len > 0 && is_dir_sep((unsigned char)sb->buf[sb->len - 1]))
         sb->len--;
     sb->buf[sb->len] = '\0';
@@ -122,6 +136,9 @@ void strbuf_trim_trailing_dir_sep(struct strbuf *sb)

 void strbuf_trim_trailing_newline(struct strbuf *sb)
 {
+    if (sb->buf[sb->len - 1] == '\n')
> +        if (sb->len > sb->alloc)
> +            strbuf_make_var(sb);

Enclose this explicitly in braces.

     if (sb->len > 0 && sb->buf[sb->len - 1] == '\n') {
         if (--sb->len > 0 && sb->buf[sb->len - 1] == '\r')
             --sb->len;
@@ -158,6 +175,8 @@ int strbuf_reencode(struct strbuf *sb, const char
*from, const char *to)

 void strbuf_tolower(struct strbuf *sb)
 {
+    if (sb->len > sb->alloc)
+        strbuf_make_var(sb);
     char *p = sb->buf, *end = sb->buf + sb->len;
     for (; p < end; p++)
         *p = tolower(*p);
@@ -234,6 +253,8 @@ void strbuf_splice(struct strbuf *sb, size_t pos,
size_t len,
         die("`pos' is too far after the end of the buffer");
     if (pos + len > sb->len)
         die("`pos + len' is too far after the end of the buffer");
+    if (sb->len > sb->alloc)
+        strbuf_make_var(sb);

     if (dlen >= len)
         strbuf_grow(sb, dlen - len);
@@ -572,6 +593,10 @@ int strbuf_readlink(struct strbuf *sb, const char
*path, size_t hint)

 int strbuf_getcwd(struct strbuf *sb)
 {
+    /*
+     * If sb was a constant, then an error would lead to
+     * strbuf_release() being called on the sb.
+     */
     size_t oldalloc = sb->alloc;
     size_t guessed_len = 128;

diff --git a/strbuf.h b/strbuf.h
index 1a1753424c..a33bc4d90e 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -128,6 +128,10 @@ static inline void strbuf_swap(struct strbuf *a,
struct strbuf *b)
     SWAP(*a, *b);
 }

> +/**
> + * Constant string buffer is turned into a variable one.
> + */
> +void strbuf_make_var(struct strbuf *sb);

Use imperative mood - Convert an immutable string buffer to a variable
string buffer.

 /**
  * Functions related to the size of the buffer
@@ -160,6 +164,16 @@ void strbuf_grow(struct strbuf *sb, size_t amount);
  */
 static inline void strbuf_setlen(struct strbuf *sb, size_t len)
 {
> +    if (sb->len > sb->alloc)
> +    {
> +        if (!len)
> +        {
> +            sb->buf = strbuf_slopbuf;
> +            return;
> +        }
> +        else
> +            strbuf_make_var(sb);
> +    }

Use braces on the same line as the condition.

     if (len > (sb->alloc ? sb->alloc - 1 : 0))
         die("BUG: strbuf_setlen() beyond buffer");
     sb->len = len;
--
2.17.1

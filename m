Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 58F94208CD
	for <e@80x24.org>; Wed, 16 Aug 2017 03:21:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753373AbdHPDVe (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Aug 2017 23:21:34 -0400
Received: from mail-ua0-f195.google.com ([209.85.217.195]:38121 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752958AbdHPDVc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Aug 2017 23:21:32 -0400
Received: by mail-ua0-f195.google.com with SMTP id x24so1232411uah.5
        for <git@vger.kernel.org>; Tue, 15 Aug 2017 20:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=thTUtlLwjrBKrBcN69WBTmg9/8Z8wgxHvf81u3nw+88=;
        b=Ju2M8qPARXDus1ChwxlAzC+NM2nCi3T9cHmgF/E4t3Iy2HyRW/NbhkIrv1pTS66HGd
         i7om8EAedWRAEzZkEKwdnu8pDQcyGkjs2H3SRXDuZ9S1oBS7TkXHU59W9bT92hkIn7MY
         4RhIbLE55jLf8OFiO3hkmCfk1fmUhJqOggwx7jzswzxiDCtgM67FZjT4AubRNJ8g+Ndh
         yrdLD7ceQiACrHTzO5QjWxAjYzZMYImB1mZPQgBB9Mw0vV9AoCDbIsyPaZqlUVIYpeNa
         Avk4OKuMf9tQGyVJzdB3a8ojV8yFuSQew99ovUC3gv0VsExI+SWpgEnNSuDrYqWL+ght
         kJxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=thTUtlLwjrBKrBcN69WBTmg9/8Z8wgxHvf81u3nw+88=;
        b=ozGuPo3dlUMTzWFfxYyD1gDxELv6d+XpJLOW2+skpoxoFuTUX8vb9BaUG74G2cvHlR
         uqSEy7S7lci2BBorQlgkJPDvFTn6WFosWQaYmEn6Xh/4XZJuF+YqENJaS0CmJWn6ae6Z
         J05SFBfLHO11DR7EHH7w6Q3mgobxGsHXU8YoA4niDWqX5xT96h53NjdWgdIjhX724Sx/
         ge8RFnpXo0G5pTX3BfUeehIyzJD82o8YgTKCnTuGIECP2SHuSKlWmESCu0rag2JFZuSz
         QIXh1Y3FpJf988P3ciLrxDlQE8TPsFib7sMB0O3AorQjmiIaU9n40i/eotqIRO2hVzIK
         zbmw==
X-Gm-Message-State: AHYfb5jYrKvslgXh5dQkKg9daAXgQhdu3dT4oMRWstyaTWh9OHUXwuDt
        vgLSvM0atLvGM1JwyUYM+ABWIOdTbSzZ
X-Received: by 10.176.83.110 with SMTP id y43mr181275uay.118.1502853690946;
 Tue, 15 Aug 2017 20:21:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.2.114 with HTTP; Tue, 15 Aug 2017 20:21:10 -0700 (PDT)
From:   ryenus <ryenus@gmail.com>
Date:   Wed, 16 Aug 2017 11:21:10 +0800
Message-ID: <CAKkAvazj28RR1nHEWNNeZeyE6mpkb3opk6kvrxP6Lau6tcCbJQ@mail.gmail.com>
Subject: [PATCH] fix revisions doc about quoting for ':/' notation
To:     Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To make sure the `<text>` in `:/<text>` is seen as one search string,
one should quote/escape `<text>` properly.

Especially, the example given in the manual `:/fix nasty bug` does not
work because of missing quotes. The examples are now corrected, and a
note about quoting/escaping is added as well.
---
 Documentation/revisions.txt | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/revisions.txt b/Documentation/revisions.txt
index 61277469c..fdfdde0ad 100644
--- a/Documentation/revisions.txt
+++ b/Documentation/revisions.txt
@@ -169,14 +169,14 @@ existing tag object.
   and dereference the tag recursively until a non-tag object is
   found.

-'<rev>{caret}{/<text>}', e.g. 'HEAD^{/fix nasty bug}'::
+'<rev>{caret}{/<text>}', e.g. 'HEAD^{/"fix nasty bug"}'::
   A suffix '{caret}' to a revision parameter, followed by a brace
   pair that contains a text led by a slash,
   is the same as the ':/fix nasty bug' syntax below except that
   it returns the youngest matching commit which is reachable from
   the '<rev>' before '{caret}'.

-':/<text>', e.g. ':/fix nasty bug'::
+':/<text>', e.g. ':/"fix nasty bug"'::
   A colon, followed by a slash, followed by a text, names
   a commit whose commit message matches the specified regular expression.
   This name returns the youngest matching commit which is
@@ -185,7 +185,8 @@ existing tag object.
   e.g. ':/^foo'. The special sequence ':/!' is reserved for modifiers to what
   is matched. ':/!-foo' performs a negative match, while ':/!!foo' matches a
   literal '!' character, followed by 'foo'. Any other sequence beginning with
-  ':/!' is reserved for now.
+  ':/!' is reserved for now. And make sure to quote/escape for the text to be
+  seen as one search string.

 '<rev>:<path>', e.g. 'HEAD:README', ':README', 'master:./README'::
   A suffix ':' followed by a path names the blob or tree
--
2.14.1

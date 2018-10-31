Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C6C11F453
	for <e@80x24.org>; Wed, 31 Oct 2018 02:06:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728661AbeJaLBz (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Oct 2018 07:01:55 -0400
Received: from mail-oi1-f175.google.com ([209.85.167.175]:43942 "EHLO
        mail-oi1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728341AbeJaLBz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Oct 2018 07:01:55 -0400
Received: by mail-oi1-f175.google.com with SMTP id j202-v6so11866345oih.10
        for <git@vger.kernel.org>; Tue, 30 Oct 2018 19:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=IXFuAJv2x3z9t6xSq/0fA9vWg1Qv/vaC1gaMl8zNi8U=;
        b=Up2CSJ+ItzubGT7ipJjfX9El7g1Fy8I5he4AMTdx3M92VutUAllDJKOY0lZXpYZDN3
         9T7xJl3tOoih0895cc4lKXcQiX3Cc7qeOjPDRQDNQ7Lca+cit2XXPnSMZiFu0/bNB/UC
         kyGaPCh39PipsNYacZmt6JC/oZ3uKcBHWcTxyF3XV/w0LKGGlO14em8FSxKwI4qPN/Pj
         f8c9/RiCyGCdQOtpq6FE/mZao5dy1OoyIApmr07rxfdy4w4x0XCUtGSdBBVagHYPMEkS
         7Lo/DTLJb4KmrT6rWHXee6SgAHbMBe47LToSjS3dDxF9L+HWj/l1YUabApnXwViPu+/1
         nFyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=IXFuAJv2x3z9t6xSq/0fA9vWg1Qv/vaC1gaMl8zNi8U=;
        b=Cp5KD0ir9pel81yBVa5QKNUA8eOwt26DCzx0tLloJm+h0adCWhdV6vRYyMwwLiGqas
         6EfrQMb9JKTVgnz0nc6WnE7jD3v9vDcSCVho7BLlW/sIz4rpl0nZyVJDwmBU2SEpowo6
         SMiKhXzTeKMMI1wR1wXboh89vmKwZ+IuN1XqBidQ+CD6Pkcz6hcJ1kBDRhQ0UdabS6gM
         mdxgYKdk3rUSTVCci8urhmz8LQ0ayGqQ9fRm6toxLvI+Zs74yxXilUPEJ7FS2+kgRxop
         W/SkYGc5KK+2p7Ef5Sbg+YCxthaNY9VFH+Fk4dmcHCrrYsghPgbhGKGOPhjnRGhX/Ebd
         lI4Q==
X-Gm-Message-State: AGRZ1gL18YI16JN241j3K/E1vRY4rnb8RGdG23fSECILZ6SgML5EnFNs
        31hvuTy9AClZGJ4Do5yWGpN47tt0PmQSSW9jPfDyUd5Z
X-Google-Smtp-Source: AJdET5eOLCgX8Uq7iUoKhLSL4o6RnqqCyC41MQU840tD4goV3U31O4Korm0xsWnrUV+hS03RgnLHaYmAUuk8aV0Lj10=
X-Received: by 2002:aca:5fc6:: with SMTP id t189-v6mr698518oib.103.1540951559380;
 Tue, 30 Oct 2018 19:05:59 -0700 (PDT)
MIME-Version: 1.0
From:   james harvey <jamespharvey20@gmail.com>
Date:   Tue, 30 Oct 2018 22:05:48 -0400
Message-ID: <CA+X5Wn76N34oBhRZvXKOwP0L_pF=LYbT6ugTgtPYSvnHg=MZVw@mail.gmail.com>
Subject: Using --word-diff breaks --color-moved
To:     git@vger.kernel.org
Cc:     sbeller@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If you use both "--word-diff" and "--color-moved", regardless of the
order of arguments, "--word-diff" takes precedence and "--color-moved"
isn't allowed to do anything.

I think "--color-moved" should have precedence over "--word-diff".  I
cannot think of a scenario where a user would supply both options, and
actually want "--word-diff" to take precedence.  If I'm not thinking
of a scenario where this wouldn't be desired, perhaps whichever is
first as an argument could take precedence.

(The same behavior happens if 4+ lines are moved and
"--color-moved{default=zebra}" is used, but below
"--color-moved=plain" is used to be a smaller testcase.)

Given the following setup:

$ cat << EOF > file
> a
> b
> c
> EOF
$ git add file
$ git commit -m "Added file."
$ cat << EOF > file
> b
> c
> a
> EOF

You can have moved lines colorization:
$ git diff --color-moved=plain
...
[oldMovedColor]-a
b
c
[newMovedColor]+a

You can diff based on words:
$ git diff --word-diff
...
[oldColor][-a-]
b
c
[newColor][+a+}

But, you cannot diff based on words, and have moved lines colorization:
$ git diff --color-moved=plain --word-diff
$ git diff --word-diff
...
[oldColor][-a-]
b
c
[newColor][+a+}

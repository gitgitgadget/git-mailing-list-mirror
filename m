Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 942EA209FD
	for <e@80x24.org>; Fri, 26 May 2017 05:51:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1163634AbdEZFvg (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 May 2017 01:51:36 -0400
Received: from mail-oi0-f49.google.com ([209.85.218.49]:36258 "EHLO
        mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965226AbdEZFvf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 May 2017 01:51:35 -0400
Received: by mail-oi0-f49.google.com with SMTP id h4so1277413oib.3
        for <git@vger.kernel.org>; Thu, 25 May 2017 22:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=/BJdNp2wIjNcI9p8BYUWSb+Y3yXYfFRe2bNGWEkk1F0=;
        b=Q5t5gWTTSeHAZeSjRneCuRGjVeJPEIJ3bKQA5JtnXwOx2ln0tqriHg75vR52zBGxLH
         VBSW2n1oL6tdrYvo0MqFs1MLVbo94kVKms6xIEPf4Zi7ttghTnsYzjGvBIrhGxvQpy7r
         nhQEaaen59FHbUy8SIPBgMqtjpwQEciOjqalfvL92gpv8JFOVJabLmC0dzB70bEYI2BD
         phnhMTwrKnS+jDG7UML+0ScgguOX4kaGwfK5SriYBxKC3k+oGgRcHs5WSLbCuLwxrYlv
         rAv/Oe0u+pADSw1zadSOXIEuWYgee3quS2cBh3ZA6PBpMrOeK3oLl4TDeiGFiI611InN
         qtXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=/BJdNp2wIjNcI9p8BYUWSb+Y3yXYfFRe2bNGWEkk1F0=;
        b=kSrKxy+M4I5PSgIYNcIc5qH+mZSmQjXL1mYY77eTnJzZrIbMGqL9ihkg29K+RBpEEQ
         lb56RuSK1QyadyKYwjD4bz7k4gQd5ugVqI0zuUGPrNJlMztzos3GvO9MPd5pu2jPPq0n
         rTWgDD4NQA8Izf5KJ4UiGsL6XAtfl6Mqb1KOCJNjx7Q36wXzAOSNC3HgZQeZNNrr8mPy
         sAZ/4qLnDed/w66pg+usSUy1ULM0+JpYps+mXHlTeDwI0yjLVKalTncj6DG8izB+Lwjk
         W4YXKNK4k6AKTHVk7dF3lIi1Z98T+nDfVso0cskIc5OWLHsRFYbFO+Wt1ZTY3faneJVr
         FfrQ==
X-Gm-Message-State: AODbwcCDtJQrD+7FbUFlVK3tz5r6wVd6fb3iNA+MuBNTULWydkuMxk3u
        1F/9vpve5vqEBYCksaFKSeVmvwCQbWLk
X-Received: by 10.202.244.86 with SMTP id s83mr117242oih.116.1495777894363;
 Thu, 25 May 2017 22:51:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.157.11.214 with HTTP; Thu, 25 May 2017 22:51:34 -0700 (PDT)
From:   Yu-Hsuan Chen <davidchen9568@gmail.com>
Date:   Fri, 26 May 2017 13:51:34 +0800
Message-ID: <CACX31FFFk1aSn+X9VO6PkCofXPE1fjB6pugLcm+srjXFDJkmyg@mail.gmail.com>
Subject: Bug report: Corrupt pack file after committing a large file (>4 GB?)
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear maintainer,

There is a bug where committing a large file corrupts the pack file in
Windows. Steps to recreate are:

1. git init
2. stage and commit a file larger than 4 GB (not entirely sure about this size)
3. git checkout -f

The file checked out is much smaller than the original file size.

This behavior is surprising. If git does not support large files, I
would at least expect an error message when staging or committing. I
have post a question on StackOverflow regrading this issue, and has
been confirmed by another user. (question id: 44022897)

Best regards,

David Chen

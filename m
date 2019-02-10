Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 36D0A1F453
	for <e@80x24.org>; Sun, 10 Feb 2019 16:03:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726231AbfBJQDo (ORCPT <rfc822;e@80x24.org>);
        Sun, 10 Feb 2019 11:03:44 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:36052 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbfBJQDo (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Feb 2019 11:03:44 -0500
Received: by mail-qt1-f193.google.com with SMTP id r9so9528708qtt.3
        for <git@vger.kernel.org>; Sun, 10 Feb 2019 08:03:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=zz15FdaRNZnmfzMWzaXDE+hM5TrpuD79gqiiZQgoH3U=;
        b=LVCQLf7DRtBOntrPWZrXKdRiumBh9sS/vXHPNpB4S6LQclUjqfgBjcA31Mb4oNN9Wv
         wVXlP6utoE6vDsOS3NEV9Rw5zDlzEbzMCa30/Phh1+1ssvrKJtFcxsp1bsfGHFlcv7iz
         a/c9wtctQmvi5/a5QUI3I6q2MCrJr4iyBA/SXkvbK7pJrVZI+U36sRWAj63QJFxNp333
         tOUXDR//ScM0hXWCJy/lgZKNjF6p3ObqXgJgVHGbQhhR+xor0CpvqS2rGOXONJhUHGrE
         rQ8hy/kIfNuSSoFCsyWe/ZVq8qZ0fF8snAqmn4xlhQO8N/MsujTBRQ/297mu41cStwTn
         yCwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=zz15FdaRNZnmfzMWzaXDE+hM5TrpuD79gqiiZQgoH3U=;
        b=Y72p0iWvRLSqFFSAtlXZit7q8UHVN41K0abgB1tPNaIXvbjfHHHGr2KjE9jUIlkgfN
         JXQJPHNvqftyBNwUlQ1PsitThcCgiZgO8cxi2cYxifeJNp/KHQHYI8pYG9WjlzbEDJZu
         GuH+L+VycOd5dwQdFKoyojur5Eo4iEDrStnAGBFDEpOWwvAsJiWa8ouclf7wLMHlI6Iw
         R8W/Vmtablu/ksOLZwFCIMp4upE4Jt3pMTTKAZ4cgNLEVVBQdynt2uPv+xDcpnahIGme
         4RZxATb1KGnkz8E9zNHxZd1XT19+cI+oWKl39CQgAigJ0IENtkNROnsgj7gW1GVcQBjV
         hyDQ==
X-Gm-Message-State: AHQUAuZ0SWmCZ2urmPVYHy+oymFPzXIFARPTJ332HWIDWxPQaiGFmKjQ
        OUsW7x0dBi1Rjb3v66Sima7YXS+VvOp/9PrpFxvh/SgM
X-Google-Smtp-Source: AHgI3IaQBI2E3J3Pm3k6zI3lULT0mg2G7MRwUxMAUPkmK/SbLTa5qfs8ryzfN7tTzlVNN3dzNT9PmEkNI1dCY+stKTs=
X-Received: by 2002:a0c:bd8b:: with SMTP id n11mr24308025qvg.0.1549814622990;
 Sun, 10 Feb 2019 08:03:42 -0800 (PST)
MIME-Version: 1.0
From:   Florian Steenbuck <steenbuckflorian@gmail.com>
Date:   Sun, 10 Feb 2019 17:02:16 +0100
Message-ID: <CAA4q8U5JD1tA0KH1nxAhN1AuqYeB-Y5UGqXzichx-ZCipDKsgQ@mail.gmail.com>
Subject: Confusion about the PACK format
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello to all,

I try to understand the git protocol only on the server site. So I
start without reading any docs and which turns to be fine until I got
to the PACK format (pretty early failure I know).

I have read this documentation:
https://raw.githubusercontent.com/git/git/c4df23f7927d8d00e666a3c8d1b3375f1dc8a3c1/Documentation/technical/pack-format.txt

But their are some confusion about this text.

The basic header is no problem, but somehow I got stuck while try to
read the length and type of the objects, which are ints that can be
resolved with 3-bits and 4-bits. The question is where and how ?

I try to parse the int from the beginning of the bits:
1 | 2 | 3 | 4 | 5 | 6 | 7 | 8
1 - 3 = type
4 - 7 = len
(I using a python way to convert it to a int which is equal to:
int('{0:08b}'.format(raw_objects[offset])[x:y], 2)
)
As mentioned in the doc n is part of the len calculation. Question of
interest why ? And what is n ?
I interpreted it as the type as it is a number and prefixed with n-byte.

This requires me to do one more step:
len = (type-1)*len

Which ends in a endless loop, because my byte offset never hits the
end of, caused by often type that is 0.

I then try to interpret it in a different way so I now take two bytes
and on every byte I take the end of the bits for get the type and len:

byte a (equal to [offset+0])
1 | 2 | 3 | 4 | 5 | 6 | 7 | 8
6 - 8 = type

byte b (equal to [offset+1])
1 | 2 | 3 | 4 | 5 | 6 | 7 | 8
5 - 8 = len

Which in my case stops the endless loop, but seems to not get correct
typing, zero and five types appears everywhere, and not get the
correct size of the object, I use the length that I calculate before.
Their are multiple errors that appears while try to decompress the
data.

Now to complete other topic error handling, what is the suggest way to
handle a type 0 or type 5 and what is with type < 0 and type > 5 ?

Type 0 is invalid, should the parsing fail here ?
Type 5 is reserved for future expansion, where should we continue then ?

Also I do not understand this:
`a negative relative offset from the delta object's position in the
pack if thisis an OBJ_OFS_DELTA object`
What relative offset I need to check here ?

Kind Regards
Florian

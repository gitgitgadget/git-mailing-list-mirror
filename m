Return-Path: <SRS0=PYw/=CU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 147FAC433E2
	for <git@archiver.kernel.org>; Fri, 11 Sep 2020 12:31:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA70F21D92
	for <git@archiver.kernel.org>; Fri, 11 Sep 2020 12:31:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=boukeversteegh-nl.20150623.gappssmtp.com header.i=@boukeversteegh-nl.20150623.gappssmtp.com header.b="d9i4aX02"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725900AbgIKMbu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Sep 2020 08:31:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbgIKMa6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Sep 2020 08:30:58 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE67FC061573
        for <git@vger.kernel.org>; Fri, 11 Sep 2020 05:30:57 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id b6so10782862iof.6
        for <git@vger.kernel.org>; Fri, 11 Sep 2020 05:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=boukeversteegh-nl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=ip5gFbx+zpx8x0gpbTfd07IYSHdHmmbCu4OKPF4vbPM=;
        b=d9i4aX02tob6vqLcq5wn4vCloPmO024euIjHCslRgRLLidn9KSQG1Q2kkzndNitkAi
         woyFsvQ9N+/VU53nhnMGV6rJWzlRJ4NXd/6E5ooXHz948bGvnLDdCVZFqs3dwyLEf/ed
         Jaun5YYg8PVKxTp+egZHw/yGHF2wwuDW3Wm6bTJeqSpQxsPnqU50AJFWjMzwlK0DnuYg
         WtnigoMTymI6MjhXifoPI2Z0ZVyIBzKhveGMX+g8KIJlXLiFFCPZIEKZd50CbtIQ0zYr
         eZRctKPqyeMu93rkEWxhSL4455EZdNpt2B6tV/54ivnh3BT290vJiJl1rTlv5q3zKI+6
         sz7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=ip5gFbx+zpx8x0gpbTfd07IYSHdHmmbCu4OKPF4vbPM=;
        b=jeR5vqx0TE5MR9qc2lr06fahwJlvKO35fDsVgFoscg/uCk/BYcjXTrPjdgsjyfG6No
         XnxDylk9vXLPEu6Q0otw2is9p/mGBn5bwzQv/dp8IY6x110Z6gsimzYFOyo+Weh8EqNn
         XYSobU08zkd4xPC5LbAywobkUyufgDNYhO+6tUzbshI/2yoAqSeBAG5XDNSx/GeFZWi4
         1kRKio0uloUVyojyG9+FkPvh7V4lBX01f61ckZPGhYsSWwJyzDFkaJKhtW+0XJK7j2NK
         SOASiTCTwPbH5NfAx71h+9zPyi0rzRNvyBOf2UU5kJAeXPPDx+opDaPSFOqQPgGy7Yau
         DYDA==
X-Gm-Message-State: AOAM531j4yQ/EbkLjP4GO2QKqeWfl5vaV1bG9Fc32g0t4PwbzJH1qEyE
        UkkXbEKI3knr4TZ0EU4HkP7X8e/4El7hAUbUlbwTohoIYNxm15Ug
X-Google-Smtp-Source: ABdhPJwQnbNwzxfD+TXhp33ncGWeaH1rekqS4qB/5wGq1PQVLdIfIxgum+schjHeNEZESCvtwG5aig1p7cEYZSoxRUI=
X-Received: by 2002:a6b:680f:: with SMTP id d15mr1531924ioc.198.1599827456412;
 Fri, 11 Sep 2020 05:30:56 -0700 (PDT)
MIME-Version: 1.0
From:   Bouke Versteegh <info@boukeversteegh.nl>
Date:   Fri, 11 Sep 2020 14:30:20 +0200
Message-ID: <CAFag0172JvkTgzXs2ieq2kSfnNRy_8n5YsP87uQ-Pyf5vB+yfw@mail.gmail.com>
Subject: Docs: possible incorrect diagram of Delta Copy instruction
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear maintainers of git documentation,

While working on an implementation of git in dart, I've noticed a
possible error in the documentation. I hope I'm using the correct
channel to report this issue.

On [pack format](https://git-scm.com/docs/pack-format#_instruction_to_copy_from_base_object)
a diagram is shown, that explains the format of a Copy instruction
inside a Deltified pack entry:

+----------+---------+---------+---------+---------+-------+-------+-------+
| 1xxxxxxx | offset1 | offset2 | offset3 | offset4 | size1 | size2 | size3 |
+----------+---------+---------+---------+---------+-------+-------+-------+

The documentation specifies that diagrams follow the RFC950
(https://www.ietf.org/rfc/rfc1950.txt) format.
That means that the left bit is MSB, and the right bit is LSB, so the
OpCode is MSB (1xxxxxxx), which is correct and matches other sources.
It also would mean that offset 1-4 should be read from bit 7, 6, 5 and
4 (i.e. 0x40, 0x20, 0x10, 0x08)

However, looking at the git source-code and other documentation (see
[1] [2]), I see that offset [1-4] are read from the LOWEST 4 bits, and
the SIZE  bits are stored right after MSB (opcode).

https://github.com/git/git/blob/54e85e7af1ac9e9a92888060d6811ae767fea1bc/patch-delta.c#L49-L55

  PARSE_CP_PARAM(0x01, cp_off, 0);
  PARSE_CP_PARAM(0x02, cp_off, 8);
  PARSE_CP_PARAM(0x04, cp_off, 16);
  PARSE_CP_PARAM(0x08, cp_off, 24);
  PARSE_CP_PARAM(0x10, cp_size, 0);
  PARSE_CP_PARAM(0x20, cp_size, 8);
  PARSE_CP_PARAM(0x40, cp_size, 16);

From this source code, I would conclude that the diagram should look
like this instead:

+----------+---------+---------+---------+---------+-------+-------+-------+
| 1xxxxxxx | size3 | size 2 | size1 | offset4 | offset3 | offset2 | offset1 |
+----------+---------+---------+---------+---------+-------+-------+-------+

Please let me know if I misunderstood the diagram instead.

Kind regards, Bouke

[1] https://shop.jcoglan.com/building-git/
[2] https://codewords.recurse.com/issues/three/unpacking-git-packfiles#applying-deltas

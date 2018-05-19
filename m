Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 620641F51C
	for <e@80x24.org>; Sat, 19 May 2018 03:07:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752059AbeESDHs (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 May 2018 23:07:48 -0400
Received: from mail-ua0-f177.google.com ([209.85.217.177]:44413 "EHLO
        mail-ua0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751117AbeESDHr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 May 2018 23:07:47 -0400
Received: by mail-ua0-f177.google.com with SMTP id h15-v6so6624989uan.11
        for <git@vger.kernel.org>; Fri, 18 May 2018 20:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=o9rBj/HSB6D6XPiExpk0qZQxEiZIK7X9FwchHgUpLGQ=;
        b=mEcucma7v+nbM7vq6VDhAMVGsEaQR9EbTf5fLHr5maizjfogrePALRl4+f/2CPpfT4
         X9TLwyQ34jOuJb2dsUhlSTpVvdHqXk9PqysVZRvIfQCmXRXJvstwBuEUJjvbSS4Jte9V
         LQYW9VVmn/BKGYjtPXeQYRQ6Dw/vkQIXt2WmThdiZN68JmVdIt+xequLeycPuMlCCDhg
         nuha+W4TaTP+iXphvi5xUiuTEE4M3alMxzcJnGhIQ3bGtIsHErcj0yQdh6AeoU3B+ncU
         9JK5qpW07//qQJgGRUpKnUZ+ZuqfYe4yWS6QteyilgIK57FAdAL1WsI6FoXM4oIADReE
         MFyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=o9rBj/HSB6D6XPiExpk0qZQxEiZIK7X9FwchHgUpLGQ=;
        b=jCTC2gEEGRs7T5nC/FISaKcvXD6er+/FP4Nt1FEga2SQJid4gGJC8a2gtbfwVanf92
         L2txTDUOnG7CiNia3wU/sFc798c6HE7cPkRcVe/Yq87vRPerVrdmd/WqRzt290RCYbLx
         CEEsXCf4aa+kupLbbTzT+Xr0TIm4YZZ04J+8JW3uhhkSs4omOB/dDIpx9D13PtS67ZcD
         WORkdb0gU8hKJkwPEK15wigtHIEBDEL0vpkr8xM7QOwsCS15yabtdvsaISUwbqpCWDpw
         2JmWZGN4VOC+pasL3L46PiJ0/SkU3f4L3wZEbuoXo2GOAmkOJwGtiSzggA+oQ+99eiiG
         FljA==
X-Gm-Message-State: ALKqPwc9V686q/rkHqD6wkYXzFQC74ukQ41GPPy5YAV62LAaL6YnoGO5
        riMpCyPtAdzehZDiK+X4QAA7uEMgAAZ8OLN2oSqLsg==
X-Google-Smtp-Source: AB8JxZpovtnj/su//rbu7ncaJafGIcNanOV6nCQ7xLngp3vZjSbPS2OuksAfNOg/g/+jAC9SD7kWZ+gKehszWk1o368=
X-Received: by 2002:ab0:a1a:: with SMTP id q26-v6mr9234970uah.23.1526699266360;
 Fri, 18 May 2018 20:07:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.95.4 with HTTP; Fri, 18 May 2018 20:07:45 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 18 May 2018 20:07:45 -0700
Message-ID: <CABPp-BFc1OLYKzS5rauOehvEugPc0oGMJp-NMEAmVMW7QR=4Eg@mail.gmail.com>
Subject: Fun puzzle: successful merge's contents depends on...commit timestamps?
To:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Check this out; I merge another branch successfully:
  $ git merge -m F $othersha; echo $?
  0

This is just a simple test repo:
  $ git log --oneline
  18f5e65 (HEAD -> master) F
  7472b46 E
  ea0d801 D
  4486f96 C
  7727e3b B
  ee47c13 A

Below it is important to note that one commit was made at 1526194997,
and this value doesn't appear anywhere else in fast-export output:
  $ git fast-export --no-data master | grep 1526194997
  author Elijah Newren <newren@gmail.com> 1526194997 -0700
  committer Elijah Newren <newren@gmail.com> 1526194997 -0700

Let's create a new branch and rewrite history ONLY changing that one timestamp:
  $ git checkout -b redo
  $ git fast-export --no-data redo | \
       sed -e s/1526194997/1500000000/ | \
       git fast-import --quiet --force

At this point, the trees for 'master' and 'redo' match, as you'd expect:
  $ git diff --quiet master HEAD; echo $?
  0

Let's redo that merge, shall we?:
  $ git checkout --quiet 'redo^1'
  $ git merge -m newF 'redo^2'; echo $?
  $ 0

Did we get the same merge result?  Nope:
  $ git diff --quiet master HEAD; echo $?
  1


I believe there are about half a dozen solutions to this puzzle.  Can you find
at least one?

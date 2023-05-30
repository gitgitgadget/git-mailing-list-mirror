Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17E0BC77B73
	for <git@archiver.kernel.org>; Tue, 30 May 2023 10:43:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231630AbjE3KnN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 May 2023 06:43:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231618AbjE3KnI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 May 2023 06:43:08 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EFCD127
        for <git@vger.kernel.org>; Tue, 30 May 2023 03:42:55 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id D56B83200708;
        Tue, 30 May 2023 06:42:54 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 30 May 2023 06:42:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
         h=cc:cc:content-transfer-encoding:content-type:content-type
        :date:date:from:from:in-reply-to:message-id:mime-version
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1685443374; x=
        1685529774; bh=6xfJ7EJhLu6AoIWX4oqKQrRCtAuceEAND8UneaCZwJ8=; b=V
        NfXwQgZXJkHE1OC0xc0BKcZGwMH0IlT1Dg3Wq1UlvNa7bX60+78wuVcc/eA7rJ04
        CvbdOFzwXb1qf/x7OZ1w3Hwoa+6q86SVtDRwWTWIU23XXuclXDedlkt2IGpoFqi7
        LbfU3wxJKEZhLDFGvAL5wMtbpWxXt/gcEVT0gppPleXYLwJw0ECkA8O45BB6AhWF
        +gi8iBU8yMGuYDSqGBbhLSCs8QaEiQO9/vpAw/Af8/mtvBuzbpwfuHZena1BQyXJ
        Mz/CYKL6qrkSUooPIRFHyN2QsjvXQZJDkQO706SOZCfuMlJ3U93Utzel16W66uvy
        9TjDaarw0SNkLnKRndd9A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:message-id:mime-version:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; t=1685443374; x=1685529774; bh=6
        xfJ7EJhLu6AoIWX4oqKQrRCtAuceEAND8UneaCZwJ8=; b=SwxqmBGGv4DOSIPVI
        aTetzjXFFB4raKqfam5j1SCOT9kobO3MOA/AiRdEbs0sjrM8Dzn6raFjvB7wyqN2
        Vv6Pah/hShgEzQgrIWo02+o7XiDiktkqW0U2Nvhgm8nke4KXcHZowNqODnqjbY/E
        eyCdak4jyuIgxgsCa1RC6lGdg1yIie5Ht/ipgtbeQeXWSe9sSVZhnYu0WBTWedlg
        4cN4FPmzFiBeFVqSECMBFX/3W4JbGZUyLvE6Bznx3rrwNTfPUQs39XL1sMafVLE7
        yE/vzZ8GQ5dbYliXe7dquv2PAhiLSipfXgRK9mgHaSx0leZvKTg/AF0YhyP/bRSA
        jmqZA==
X-ME-Sender: <xms:LtN1ZN86oa-RIqH76-R0OkuHDcKOSfnDwYbkSeqUmf47e2fdRowF9Hs>
    <xme:LtN1ZBuHFJJF8La8VfX-nEAQv8pyw11b2PUeoMnkCk34qlpODt7D4AFKRxXf7IPU4
    J3qCnEL73yYlTxlXQ>
X-ME-Received: <xmr:LtN1ZLAgZJIXcYjRZ8GHMejEZbeqyubA8Gj0RMEffRurHQjCsA7HqWXw3590-OJMqs4rhwMgM9C-HRezDtrr2Cd2oR2VaNoF3Mo1YRU2VitvgbIZ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeekjedgfedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofggtgfgsehtkeertdertdejnecuhfhrohhmpefmrhhishht
    ohhffhgvrhcujfgruhhgshgsrghkkhcuoegtohguvgeskhhhrghughhssggrkhhkrdhnrg
    hmvgeqnecuggftrfgrthhtvghrnhepteegtdegheeiheefjedtlefhueeuieettdetgfet
    hfevveeutdelvdefjeehveejnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegtohguvgeskhhh
    rghughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:LtN1ZBd3I1H0yFFhj1Ku-Dl_Gd3_JpIFSgfsMUob7SmprlJIi8yMUA>
    <xmx:LtN1ZCMjkGD2bBtiHtK8z0qKsRDFp51UhaDoJ29md2HV463eyISOtw>
    <xmx:LtN1ZDkEG9ySXDmO4QkrcwUcFE-rcsQ0DOjFcicF9W-WgkZgYGXNmQ>
    <xmx:LtN1ZPpXABBtv3Y4vLrRd3FVaRnUAB2l_l3Nw2ON3m0Rvx5IYKOvOg>
Feedback-ID: i2671468f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 May 2023 06:42:53 -0400 (EDT)
From:   Kristoffer Haugsbakk <code@khaugsbakk.name>
To:     git@vger.kernel.org
Cc:     Kristoffer Haugsbakk <code@khaugsbakk.name>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Denton Liu <liu.denton@gmail.com>
Subject: [RFC PATCH 0/3] range-diff: treat notes like `log`
Date:   Tue, 30 May 2023 12:41:28 +0200
Message-ID: <cover.1685441207.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.41.0.rc2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently, `range-diff` shows the default notes if no notes-related
arguments are given. This is also how `log` behaves. But unlike
`range-diff`, `log` does *not* show the default notes if
`--notes=<custom>` are given.

These changes are supposed to make `format-range` behave like `log` with
regards to notes.

These changes also fixes an issue with notes being shared in the cover
letter via `range-diff`, and that’s really the main motivation for
making these changes.

§ How `log` works

`log` shows the default notes if no notes arguments are given. But if
you give it specific notes to show then it forgets about the default
notes. Further, there is the convenience `--notes` option which will
show the default notes again. These options are cumulative. For example:

    git log --notes --notes=custom

Will show the default notes as well as the `custom` notes.

See discussion in: https://lore.kernel.org/git/20110329143357.GA10771@sigill.intra.peff.net/

§ How `range-format` works

`range-format` passes `--notes` to `log`, which means that it does not
have the default behavior of `log` (forget the default logs if you say
e.g. `--notes=custom`). However, the man page says that (under
`--[no-]notes[=<ref>]`):

> This flag is passed to the git log program (see git-log(1)) that generates the patches.

This makes me (at least) think that `range-format` is supposed to work
just like `log` with regards to notes.

§ `format-patch` and the difference between showing and sharing

`format-patch` has a different default: it shows no notes. This makes
sense in my opinion since `format-patch` is meant to be used to share
changes with others, and you might be surprised if your notes (which
might have only been notes to yourself) are sent out in your emails
(keep in mind that notes refs are *not* pushed by default).

But the slightly faulty behavior of `range-diff` bleeds through to
`format-patch` since the latter calls the former; if you have default
notes they can be shared in the range-diff on the cover letter, even
though `format-patch` isn’t supposed to show them.

§ Code layout and approach to the problem

As I’ve said, my focus was on fixing `format-patch`, so I’ve considered
how `format-patch` calls `range-diff` which in turn calls `log`.

`format-patch` is a command which is defined in `builtin/log.c`. For
notes in particular it in fact has some explicit logic for handling
notes based on the value of `rev`. (There seems to be no issues with
this part of the code; only the code in `range-diff.c` which passes the
default argument to `log`.) It then calls
`range-diff.c:show_range_diff`. That function on `master` loads some
default arguments, among them `--notes`. It then eventually calls `log`
as a subprocess.

My change consists of co-opting the deprecated `--standard-notes` and
changing its behavior so that it can be used in
`range-diff.c:show_range_diff`.

Using a special switch/option was the only way I found in order to fix
this problem.

I could have also created a new option but I thought that doing a
smaller change initially would be better.

§ RFC

This is marked as RFC since I chose to co-opt a deprecated option in
order to get `range-format` to work, in my opinion, as it should.

§ Carbon copy

Based on `contrib/contacts/git-contacts master..@`.

Kristoffer Haugsbakk (3):
  range-diff: treat notes like `log`
  doc: pretty-options: remove documentation for deprecated options
  revision: comment `--no-standard-notes` as deprecated

 Documentation/pretty-options.txt |  1 -
 range-diff.c                     |  2 +-
 revision.c                       |  8 ++++++--
 t/t3206-range-diff.sh            | 28 ++++++++++++++++++++++++++++
 4 files changed, 35 insertions(+), 4 deletions(-)

-- 
2.41.0.rc2


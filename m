Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E11C1C7EE22
	for <git@archiver.kernel.org>; Sun, 14 May 2023 13:19:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234023AbjENNTz (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 May 2023 09:19:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbjENNTy (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 May 2023 09:19:54 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 091031FD2
        for <git@vger.kernel.org>; Sun, 14 May 2023 06:19:52 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 941B15C004F;
        Sun, 14 May 2023 09:19:50 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Sun, 14 May 2023 09:19:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
         h=cc:cc:content-transfer-encoding:content-type:content-type
        :date:date:from:from:in-reply-to:message-id:mime-version
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1684070390; x=
        1684156790; bh=LgLlAOjATzPtoGle2syhxx8xoY/l5PJxmYcXrkHfgJo=; b=E
        r305IBjzYhHHESYce3Xgvc96NWGoOTTQRx4Ix3PWKEpyik0wKzcI50cq2Jz70qSY
        uZOw/5lnlnp/W0fVo/YbNzV0gmVZxeWjvZXR0MbWtgFiKJfZlnTGI73SJC6HrPeu
        PoFC4OsnrXCdqH1ASngyXqnaNE94E9v6DTnSaul2jx2aqa5WOeCHikerWPgvtCkU
        Y6X3GKsKVv/e7HaaWXr1W2/17Bq8WC3+fOGGCIE4qN7BOajQJkdXPCvLShBjyxAa
        Qo64IBY1jnSPahXOE4J8dPTS5b+2qXA6Icvb/479TvjXY+0BkjtY6xtMUp7oQSgP
        Oes8Yda00CND7IeA+mPlg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:message-id:mime-version:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; t=1684070390; x=1684156790; bh=L
        gLlAOjATzPtoGle2syhxx8xoY/l5PJxmYcXrkHfgJo=; b=viw3peloDVu57sOL0
        EJ1xY3RyiU5HZaHgByyEPmXO+0jWHiLFH8hgPNoz+5AvRWcBqRzy8VHWboJd3xnU
        iNEPogYjeDd6iDGMNlS2Hret8QR1MHcDpAG0lTAJbwetJv8DScdkoe92ET7dBb+E
        hD7Dbn1HFupn8DHtMj+NR9zrZbFf/jRGbx7QX91G5q/dsnW8LK55TnCuoGe+0BJy
        wEMFB3eciaNqJrflKWBOxxiVPjbIyzuBLEqmPeGxUWlQh6FMDVojk22gkglmYxPA
        A0kGTQd5AlisbcjrkxrTyBlp1SwjytxodW1kq/iVqgYH3b3lBRxfgc1hu0dAC+oh
        qIZaw==
X-ME-Sender: <xms:9t9gZBP-ZrdzEIF-4gKiVZP5j5C3Dr1KgR8Stnz6OhrwWD7zWS1d1GU>
    <xme:9t9gZD9cmZp2nxGHXPZXb-JDitxDf5EaaiCBY9fzEEuo_O9v9320J-8zA4GnePuG4
    WjiB4RuvngKf5jWcA>
X-ME-Received: <xmr:9t9gZAQ5oT8S9E644sbufEvuhZI0s3igPtewjLbQkQX1v-MAwrnwDSdF-KbqqAblZr843TUVB3MSOYAgMlEAtt1UTVANE6hUbeVMbAt2IclROYlVyEM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeehhedgieegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffogggtgfesthekre
    dtredtjeenucfhrhhomhepmfhrihhsthhofhhfvghrucfjrghughhssggrkhhkuceotgho
    uggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpedvteeivd
    etveelheelffdvleejhfetieejvdfgieeijeelvddvkeefleelkeevhfenucffohhmrghi
    nhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgv
X-ME-Proxy: <xmx:9t9gZNtKcj0RNac1wkFTlrjpJl_0_i6m1wCdiRmaPVlVioo3NZxw6Q>
    <xmx:9t9gZJdlEgGUuIlDKdJWP16pQHiMMzBwDttBRQJZECOgk6lD_5T91Q>
    <xmx:9t9gZJ2HNRZlMGBtpImN-cIzt9BFOLsqTzRJLR-ublcLTak7P98A_g>
    <xmx:9t9gZJG2N9psSmVevOH2FbyJybw0BM-1eU52R4JxcNg46wLvqSLSUA>
Feedback-ID: i2671468f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 14 May 2023 09:19:49 -0400 (EDT)
From:   Kristoffer Haugsbakk <code@khaugsbakk.name>
To:     git@vger.kernel.org
Cc:     peff@peff.net, Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: [PATCH 0/3] tag: keep the message file in case ref transaction fails
Date:   Sun, 14 May 2023 15:17:57 +0200
Message-Id: <cover.1684067644.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The ref transaction can fail after the message has been written using the
editor. The ref transaction is attempted after the message file (`TAG_EDITMSG`)
has been unlinked, so there is no backup tag message file to retry the
command.[1]

This is unfortunate if someone has written more than e.g. “v1.99.4” in the
editor. (I don’t know if people write long tag messages in practice.)

Hold on to the tag message file until after the ref transaction in order
to preserve the backup.

† 1: On commit 91428f078b (The eighteenth batch, 2023-05-10)

§ Reproduction script

```
cd /tmp
dir=$(mktemp -d)
cd $dir
git init
git commit --allow-empty -mInit
git tag release/v1
# Fails
git tag -a release
```

Error message:

```
fatal: cannot lock ref 'refs/tags/release': 'refs/tags/release/v1' exists; cannot create 'refs/tags/release'
```

Better error message and behavior:

```
The tag message has been left in .git/TAG_EDITMSG
fatal: cannot lock ref 'refs/tags/release': 'refs/tags/release/v1' exists; cannot create 'refs/tags/release'
```

§ Alternatives considered

My first thought was to find a way to “dry run” the ref update before opening
the editor (the edge case of the ref update command succeeding the first time
but not the second *real* time seemed incredibly unlikely to happen by
happenstance, so I saw no reason to consider that). However that seemed like it
would involve more code and conditionals, and I don’t know if the dry-run mode
is even supported.

A benefit of this alternative approach would be to error out immediately instead
of opening the editor. But trying to create a tag which collides with an
existing “namespace” seems very unlikely to happen in practice.[2] Losing a file
is much worse than being inconvenienced to retry the command, so I decided to
just focus on the former problem.

Most importantly though this approach was within my ability to implement.

† 2: Just observe my “Reproduction script”: one tries to create `release` after
    someone else made `release/v1`. But what is just “release”? What follows
    (next version) that? But why am I arguing against my change…

§ CI

https://github.com/LemmingAvalanche/git/actions/runs/4972149825

§ Carbon copy

The suggested contacts seemed too long:

```
$ ./contrib/contacts/git-contacts v2.40.1..
Junio C Hamano <>
René Scharfe <>
Jonathan Tan <>
Jonathan Nieder <>
Jeff King <>
Stefan Beller <>
Denton Liu <>
Robert Dailey <>
```

So I added only Jeff King based on commit 3927bbe9a4 (tag: delete TAG_EDITMSG
only on successful tag, 2008-12-06).

§ Patches

1. Test the happy case
2. Test the unhappy case (fails without the next patch)
3. The change

—

Cheers.

Kristoffer Haugsbakk (3):
  t/t7004-tag: add regression test for existing behavior
  t/t7004-tag: add failing tag message file test
  tag: keep the message file in case ref transaction fails

 builtin/tag.c  | 24 +++++++++++++++---------
 t/t7004-tag.sh | 19 +++++++++++++++++++
 2 files changed, 34 insertions(+), 9 deletions(-)

-- 
2.40.1


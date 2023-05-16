Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 121C6C77B7A
	for <git@archiver.kernel.org>; Tue, 16 May 2023 17:56:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231712AbjEPR4a (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 May 2023 13:56:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbjEPR41 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 May 2023 13:56:27 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 727452105
        for <git@vger.kernel.org>; Tue, 16 May 2023 10:56:25 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id E2A755C00EA;
        Tue, 16 May 2023 13:56:24 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 16 May 2023 13:56:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
         h=cc:cc:content-transfer-encoding:content-type:content-type
        :date:date:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to;
         s=fm3; t=1684259784; x=1684346184; bh=rWaRkXq2G5DmoK52Uqmeku+AG
        UQx53Z6MPllfJdZRww=; b=c13bv7T0I4DSd/u/qLWCF+dtkpeHAw6je7cZc+j3V
        8t2rTckTGJX2RXE1j1B+Ci3NX6GrN5Us7RSYqHneh52ckQPYg8xl9eJuk1M/Z5+b
        dDNm39aDENUoux+mHKE0nmJltLQWgoHcZ9wAGo7yVgk8mXqykeoo740ckfOsvW4+
        Z0gfeGImMM6IJJaWOXcpxZdlHmPonVGv53e5ZWROPOBQdT6DAyBZTQZvWsduujrB
        ekVyjsPnPKFIU05nu5by79or7cdS9oQHl8FE3ha+C6abRx1gdokqApoFeFi/xP+o
        wA4Kfre41eJ7UOyWh2SBHP6fn2a9bItVK5B18kTOISXnQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1684259784; x=1684346184; bh=rWaRkXq2G5DmoK52Uqmeku+AGUQx53Z6MPl
        lfJdZRww=; b=xtT7cfAic/ehNf9r1zkeeQENUlPdrOmO3RrYOnedXSzuqdl2PVx
        ywtAhS5UlgMCQYsX552d1Nww245PYD8rDQwNMdbpqWwdHl2nd5ZcdHKTe3Z/hN2w
        kqZp7buYKwEu0BU6o20HEOS0GdmGX+Q4Ax5ak4mmfSnOAWO8SZmqB3wp10RYWUz1
        aww/qGVFRQWakaRrREZXQ2NKiXwsXrjy+e5Bz2T7GKpiS7RrVlL5M7A0xURqiKwM
        HzcKTodRm/CUbOCLpou6MdXW4RfYZxp0KCktI2BLSNxbgwqRLp4lw2QP+47doPt2
        3ndJWqP1Dbm5CViBzEmDcxZITCEDwS+pQjA==
X-ME-Sender: <xms:yMNjZDE2dxXjsT1oUDJHjrUahuCerdAv2QYu54Fqzla7P88AfKNDYQw>
    <xme:yMNjZAU1lPn3mb5DHCFjLz1gLBnsRMTpXzgS8CnIaafsqouUAZhn74jX89gIYUxM_
    _WwEB_T_THgruaBUA>
X-ME-Received: <xmr:yMNjZFJpuZk02rgssExXLqKVs3s36535ioq0xRuxIhNj_eM6UnwJaHWhjHnb6MrjYrV9rm25SUhzzgbFhQTu9TD4TNxH6aG0vnzzLsmtItnMrPIa>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeehledguddukecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhggtgfgse
    htkeertdertdejnecuhfhrohhmpefmrhhishhtohhffhgvrhcujfgruhhgshgsrghkkhcu
    oegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvgeqnecuggftrfgrthhtvghrnhepve
    fgleevieekgeejieekueevhfelieduvdelgeefkeejtdekvedttefgffevtedtnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptghouggvsehkhh
    gruhhgshgsrghkkhdrnhgrmhgv
X-ME-Proxy: <xmx:yMNjZBHwDIHjL1hdIAwtiy7mspfw0t4-Vcoj-M8kvSsGjcfNGIZrcQ>
    <xmx:yMNjZJVBIdwP5u0JEnXXrxRsA6F6gEdSpJdjBSFm7BJ6xBGNAJPhHw>
    <xmx:yMNjZMNmV8ekt9V6JlarK3sjyRzQabHHJEMvYe2EQNpvPrMQFJzGCg>
    <xmx:yMNjZGgMWcqMMtNFnWUASegLZvP3hZ1CAFyREeZ_fe3ZquFHVp7Cmg>
Feedback-ID: i2671468f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 16 May 2023 13:56:23 -0400 (EDT)
From:   Kristoffer Haugsbakk <code@khaugsbakk.name>
To:     git@vger.kernel.org
Cc:     peff@peff.net, gitster@pobox.com,
        Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: [PATCH v3 0/3] tag: keep the message file in case ref transaction fails
Date:   Tue, 16 May 2023 19:55:43 +0200
Message-Id: <cover.1684258780.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1684067644.git.code@khaugsbakk.name>
References: <cover.1684067644.git.code@khaugsbakk.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

§ Introduction (v3)

The first part of this material is the same as v1 and v2; skip to “Based
on” and onwards for the new things.

Cheers.

―

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

§ Based on (base commit)

`v2.40.1`

§ Changes compared to the previous round

• Replace `! test_path_exists` with `test_path_is_missing`

Other:

• Drop “Cc” trailers (but keep Cc list)

§ Patches

Same number and order as last round.

1. Document `TAG_EDITMSG`
2. Test successful tag creation
   • New: Use `test_path_is_missing`
3. The main change plus a regression test

Kristoffer Haugsbakk (3):
  doc: tag: document `TAG_EDITMSG`
  t/t7004-tag: add regression test for successful tag creation
  tag: keep the message file in case ref transaction fails

 Documentation/git-tag.txt | 10 ++++++++++
 builtin/tag.c             | 24 +++++++++++++++---------
 t/t7004-tag.sh            | 19 +++++++++++++++++++
 3 files changed, 44 insertions(+), 9 deletions(-)

Range-diff against v2:
1:  0e0e592853d ! 1:  882008e32a4 doc: tag: document `TAG_EDITMSG`
    @@ Commit message
                in case of error.
     
         Suggested-by: Junio C Hamano <gitster@pobox.com>
    -    Cc: Jeff King <peff@peff.net>
         Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
     
     
2:  aabeb4568ee ! 2:  d1490b8f0b7 t/t7004-tag: add regression test for successful tag creation
    @@ Commit message
     
         Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
     
      ## t/t7004-tag.sh ##
     @@ t/t7004-tag.sh: test_expect_success 'Does --[no-]contains stop at commits? Yes!' '
      	test_cmp expected actual
    @@ t/t7004-tag.sh: test_expect_success 'Does --[no-]contains stop at commits? Yes!'
     +	echo Message >.git/TAG_EDITMSG
     +	EOF
     +	GIT_EDITOR=./fakeeditor git tag -a foo &&
    -+	! test_path_exists .git/TAG_EDITMSG
    ++	test_path_is_missing .git/TAG_EDITMSG
     +'
     +
      test_done
3:  e67b6416b7e ! 3:  81bca0673d8 tag: keep the message file in case ref transaction fails
    @@ Commit message
         Hold on to the message file for a little longer so that it is not
         unlinked before the fatal error occurs.
     
    -    Cc: Jeff King <peff@peff.net>
         Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
     
    @@ builtin/tag.c: int cmd_tag(int argc, const char **argv, const char *prefix)
     
      ## t/t7004-tag.sh ##
     @@ t/t7004-tag.sh: test_expect_success 'If tag is created then tag message file is unlinked' '
    - 	! test_path_exists .git/TAG_EDITMSG
    + 	test_path_is_missing .git/TAG_EDITMSG
      '
      
     +test_expect_success 'If tag cannot be created then tag message file is not unlinked' '
-- 
2.40.1


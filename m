Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7735C77B7D
	for <git@archiver.kernel.org>; Mon, 15 May 2023 20:30:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245383AbjEOUao (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 May 2023 16:30:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245382AbjEOUam (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 May 2023 16:30:42 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 881451162E
        for <git@vger.kernel.org>; Mon, 15 May 2023 13:30:38 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id E593E5C020D;
        Mon, 15 May 2023 16:30:37 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 15 May 2023 16:30:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
         h=cc:cc:content-transfer-encoding:content-type:content-type
        :date:date:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to;
         s=fm3; t=1684182637; x=1684269037; bh=9V84KXo053fgMy81yY/wT2ysT
        6018qscMmQurjEkXgI=; b=aHhK/xgvrFUQQ3RJEq9AoorJ0VEbgZ9fzN/blol5d
        e1ZIxhgDOPXnNG7Nvua9Wv+Ot9oSzwrw+c5SPrM+j1c+3hfP03PzOzTwjaS4gAPj
        AADraO+HyiCMO37qcZwW+7oMm7Xy1VXn+c9CdiMZVZ73R1PYmEIrQqKQ7jvKPnf7
        wF+kxyVs43kz7ufAa1VV0qlP6ORDu3Nuts/0lXuLppS3OZBr/1Q0CL/FpEM/bPq5
        6oEusIf1oxuXTHPqChsQcaYrNtGFHEEgXzGh/BjvReWvCeDZN0lxhQgJ+dZPf2r3
        GNti7X5RicgMWO1mf52SZ+n0gPrLWQCz8e324hgB0G2bw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1684182637; x=1684269037; bh=9V84KXo053fgMy81yY/wT2ysT6018qscMmQ
        urjEkXgI=; b=s6BeXr8IgrXME9JPSU6T/Dg5kVZsWXcRAxQ6ZcofzdUVp25u3ft
        TA11MoX4RVB1GrvFR8rJ6/WvA/14awf/N9qyJ+mxQFBCWhdkThbDd1GbbHj+Mryf
        AwaWGmxE+e3EinrjU/mFez4vFdnQpiJzEQPBnKM2SOvp3Rbsh+JiZXxZa0dpKtFl
        1RHZgdfHmMwuWO1C8wCtYCBlgUvp8csPgiC6xbX/D3es28OX/hQqOxs4jr/OwYR+
        ytOSbFdf7i8ZDVC84tYvADaTZCNqfnk5j146XLogiHa+MNkZ5du/xT8lcbKKVsDt
        Agsu5u35eNVTnlanrdYRu779CH8E/XR7EZw==
X-ME-Sender: <xms:bZZiZHXN5cq_IpTp9Mq-abRIK4y5E4J2xiiMKXUy3yIum6_r_rm2wpU>
    <xme:bZZiZPm0QQCT9rnCJDyQtu3U1XCPy81nJyJB_KfJYgSb0hBuQUV6E6E8XNx6YO9Gf
    S77wm0R7q9EOBbLRA>
X-ME-Received: <xmr:bZZiZDYcft-HKoL2CW6RuHiDdNmmjxF4rYe9Lj2W7_Aam24yzxg_K-B-3zV2v1sT5uoJ_lATKs_cXDCDr2X13rfoz-xO4D0MOiQyIscw3m_oA4QnRwo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeehjedgudehvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhggtgfgse
    htkeertdertdejnecuhfhrohhmpefmrhhishhtohhffhgvrhcujfgruhhgshgsrghkkhcu
    oegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvgeqnecuggftrfgrthhtvghrnhepue
    ejueekieelhffgvdfgffelhefghfeitefggfffgffhheejvdejieefjeduueefnecuffho
    mhgrihhnpehgihhthhhusgdrtghomhdpkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptghouggvsehkhhgruhhgshgs
    rghkkhdrnhgrmhgv
X-ME-Proxy: <xmx:bZZiZCXztZDZHT8OrM8cfFOAYeFVVqlFn78dnaw48h9-xfI_shxP_g>
    <xmx:bZZiZBmJS44krNgO-phj_Jxb_Gw7p7yTy62vFqdLfheeWvE-YFno-Q>
    <xmx:bZZiZPdxSAVa2pa3mkFxsEjOWWk7hqUUODVyvRKoyF3efHjnGZeIFQ>
    <xmx:bZZiZBteKOQwCLk-MXaLsIywrWibFOfq3kax0v-U5oiRfeSqlR6JZw>
Feedback-ID: i2671468f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 May 2023 16:30:37 -0400 (EDT)
From:   Kristoffer Haugsbakk <code@khaugsbakk.name>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: [PATCH v2 0/3] tag: keep the message file in case ref transaction fails
Date:   Mon, 15 May 2023 22:29:32 +0200
Message-Id: <cover.1684181855.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1684067644.git.code@khaugsbakk.name>
References: <cover.1684067644.git.code@khaugsbakk.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

§ Introduction (v2)

The following material is the same compared to v1 up to but not
including “Changes from the previous round (v1)”

(The CI link is also new.)

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

§ CI

https://github.com/LemmingAvalanche/git/actions/runs/4984100467

§ Changes compared to the previous round

• Document `TAG_EDITMSG`
• Improve test structure
• Combine/squash the regression test for the change and the actual change
  • In the previous round the regression test commit would fail the test
    suite since it’s a `test_expect_success` and it comes before the
    actual change

§ Patches (compared to previous round)

1. (new) Document `TAG_EDITMSG`
  • So that we match `COMMIT_EDITMSG`
2. (was [1/3]) Test successful tag creation
  • Tweak commit message subject
  • Also remove `.git/TAG_EDITMSG` in `test_when_finished`
3. (was [2–3/3]) The main change plus a regression test
  • Tweak commit message and reflow paragraphs
  • Not a change but add a question for the reviewers (see the “Note”)

Kristoffer Haugsbakk (3):
  doc: tag: document `TAG_EDITMSG`
  t/t7004-tag: add regression test for successful tag creation
  tag: keep the message file in case ref transaction fails

 Documentation/git-tag.txt | 10 ++++++++++
 builtin/tag.c             | 24 +++++++++++++++---------
 t/t7004-tag.sh            | 19 +++++++++++++++++++
 3 files changed, 44 insertions(+), 9 deletions(-)

Range-diff against v1:
-:  ---------- > 1:  0e0e592853 doc: tag: document `TAG_EDITMSG`
1:  87b709d856 ! 2:  aabeb4568e t/t7004-tag: add regression test for existing behavior
    @@ Metadata
     Author: Kristoffer Haugsbakk <code@khaugsbakk.name>
     
      ## Commit message ##
    -    t/t7004-tag: add regression test for existing behavior
    +    t/t7004-tag: add regression test for successful tag creation
     
         The standard tag message file is unlinked if the tag is created.
     
    @@ t/t7004-tag.sh: test_expect_success 'Does --[no-]contains stop at commits? Yes!'
     +	echo Message >.git/TAG_EDITMSG
     +	EOF
     +	GIT_EDITOR=./fakeeditor git tag -a foo &&
    -+	! test -e .git/TAG_EDITMSG
    ++	! test_path_exists .git/TAG_EDITMSG
     +'
     +
      test_done
2:  1f24aa43f7 < -:  ---------- t/t7004-tag: add failing tag message file test
3:  999af290af ! 3:  e67b6416b7 tag: keep the message file in case ref transaction fails
    @@ Metadata
      ## Commit message ##
         tag: keep the message file in case ref transaction fails
     
    -    The ref transaction can fail after the user has written their tag message. In
    -    particular, if there exists a tag `foo/bar` and `git tag -a foo` is said then
    -    the command will only fail once it tries to write `refs/tags/foo`, which is
    -    after one has closed the editor.
    +    The ref transaction can fail after the user has written their tag
    +    message. In particular, if there exists a tag `foo/bar` and `git tag -a
    +    foo` is said then the command will only fail once it tries to write
    +    `refs/tags/foo`, which is after the file has been unlinked.
     
    -    Hold on to the message file for a little longer so that it is not unlinked
    -    before the fatal error occurs.
    +    Hold on to the message file for a little longer so that it is not
    +    unlinked before the fatal error occurs.
     
    +    Cc: Jeff King <peff@peff.net>
         Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
     
     
      ## Notes (series) ##
    -    I tried to maintain the proper formatting by using `clang-format` via Emacs on
    -    the affected lines.
    +    I duplicated this message (this isn’t obvious in the diff):
    +
    +        fprintf(stderr,
    +                _("The tag message has been left in %s\n"),
    +                path);
    +
    +    Should this be factored into a static function instead?
    +
    +    § Changes from previous round
    +
    +    Squash (combine) the update to `tag.c` with the test so that the fix and
    +    the regression test is added in one step.
    +
    +    This makes more sense than what I was going for since the test suite
    +    would fail on patch 2/3 of the previous round.
    +
    +    Link: https://lore.kernel.org/git/xmqq4joeaxgw.fsf@gitster.g/T/#u
     
      ## builtin/tag.c ##
     @@ builtin/tag.c: static const char message_advice_nested_tag[] =
    @@ builtin/tag.c: int cmd_tag(int argc, const char **argv, const char *prefix)
      	ref_transaction_free(transaction);
      	if (force && !is_null_oid(&prev) && !oideq(&prev, &object))
      		printf(_("Updated tag '%s' (was %s)\n"), tag,
    +
    + ## t/t7004-tag.sh ##
    +@@ t/t7004-tag.sh: test_expect_success 'If tag is created then tag message file is unlinked' '
    + 	! test_path_exists .git/TAG_EDITMSG
    + '
    + 
    ++test_expect_success 'If tag cannot be created then tag message file is not unlinked' '
    ++	test_when_finished "git tag -d foo/bar && rm .git/TAG_EDITMSG" &&
    ++	write_script fakeeditor <<-\EOF &&
    ++	echo Message >.git/TAG_EDITMSG
    ++	EOF
    ++	git tag foo/bar &&
    ++	test_must_fail env GIT_EDITOR=./fakeeditor git tag -a foo &&
    ++	test_path_exists .git/TAG_EDITMSG
    ++'
    ++
    + test_done
-- 
2.40.1


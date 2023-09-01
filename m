Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 248D3CA0FE4
	for <git@archiver.kernel.org>; Fri,  1 Sep 2023 16:20:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344111AbjIAQUc (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Sep 2023 12:20:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232030AbjIAQUc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Sep 2023 12:20:32 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4840DE66
        for <git@vger.kernel.org>; Fri,  1 Sep 2023 09:20:28 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 2B4505C0121;
        Fri,  1 Sep 2023 12:20:25 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 01 Sep 2023 12:20:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
         h=cc:cc:content-transfer-encoding:content-type:content-type
        :date:date:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to;
         s=fm3; t=1693585225; x=1693671625; bh=5Wb+jxV7xo3u2uWIbuu3ElQYh
        C8mBnQwrOcE5lT+FEY=; b=SCLhm3qJwMCt71Fq/F/pXQY6exE3kTfJO+NDXkxIF
        xh34OW7NPycZzbSFK4eVWXMIZMMV9vPx5HIWWnxCbxZ5CBn8qkWicHQOvEafjbnN
        EMyePzNfciPz9cV0Fcy8mHhTEGc3I1CmD8Ap7XFXyjqN9Rcj8aqpf+Wquka80o/4
        sq/jOe/146vtcomh9uw3QM3shzpegv+0ghTOJx4ErUPQYF54xW6BFwY3vBPHzefE
        AQz+GBvSAaYNf+zvraeJ2guPIOQg9I5PfGBEeKbFQqAkHnbfjFW0rFJ1NzseQ+RK
        xFGORrj0d4x869mVcuNiDLrr9sC910N0TmTeuyeRcj4Jg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1693585225; x=1693671625; bh=5Wb+jxV7xo3u2uWIbuu3ElQYhC8mBnQwrOc
        E5lT+FEY=; b=xbg/HTXqA7I9uMGVUeXKgfXuz1F8aPPbojUgeenWTc7iQEX0+lk
        WcCM5Zllm62bKrfp4cFe0hUJWZuUuSI+emrMuDGAOsiTljOOIbp8OFFxb8ZdtAgM
        9xI8dvSCVT4ZY6MQYhRG1Z4oTEqUIk7UnosH325rwzQqWlb8hNpOt98cozv3hW2B
        kXUVuSMwWOwkGY/RhT62AM1RNYKQUzJxxoHj+EXzweb7Ompf8EKi3idg8M8AVP3i
        Sv+wL77nBmZYjuB1UJZmB3WZRHUAhf0P5nM93JNF6er4iniogX6rQIijJwWD2bhH
        VYm6WoakykuhQ9TE5RlLqqTn7X+6W89ghKw==
X-ME-Sender: <xms:SA_yZN7IEcr2wjOuXWsCp2YcHPH3KKVS2m6aCdrAMqoLQEXgaqcwWew>
    <xme:SA_yZK4WqPy56VEn5gklmalOEkHeWR9D6e97FVAuqmjpo4KHXWOHWMVYzhRamXCWd
    vIwLAet-HkgiIvtuA>
X-ME-Received: <xmr:SA_yZEdUuluzT7KT99QpIj9RYFuLRiewdjPtBLjCLY3GPiBO-63pzdVCPy1_gzeSuqzGEsVhK7LMGlk_m0jZCJGGn9uvbqDuyMXIsZi0vw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudegvddgleelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhggtgfgsehtkeertdertdejnecuhfhrohhmpefmrhhi
    shhtohhffhgvrhcujfgruhhgshgsrghkkhcuoegtohguvgeskhhhrghughhssggrkhhkrd
    hnrghmvgeqnecuggftrfgrthhtvghrnhepfffhgfdutddttdfhieelvdetudefgfejleef
    ueeikeeugfeftdduiedvhfevgfetnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpgh
    hithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghi
    lhhfrhhomheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgv
X-ME-Proxy: <xmx:SQ_yZGIYZf59dpaw9-LoWDgMTxdiWxwagRJ59ZXH0VN6MDKx43_Cvg>
    <xmx:SQ_yZBIyj9ea1kDbLKeYn7bWGXn_QHxsshGgJoir85O7lLUPZlVyvg>
    <xmx:SQ_yZPwZc7RcvqedrMLr8PQXOTGy_YFCd5pBu61-pNQtolMOBhT7hw>
    <xmx:SQ_yZB1DDuuuPKZKhZ6ij7sfnz4XvpJ17jHBN2KjO9hPixm6ir_pkg>
Feedback-ID: i2671468f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 1 Sep 2023 12:20:23 -0400 (EDT)
From:   Kristoffer Haugsbakk <code@khaugsbakk.name>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Denton Liu <liu.denton@gmail.com>, Jeff King <peff@peff.net>,
        Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: [PATCH v2 0/3] range-diff: treat notes like `log`
Date:   Fri,  1 Sep 2023 18:18:59 +0200
Message-ID: <cover.1693584310.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1686505920.git.code@khaugsbakk.name>
References: <cover.1686505920.git.code@khaugsbakk.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The following cover letter is identical to the previous one up to but not
including section “Changes since version 1”.

Cheers

🙛 🙙

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

§ Changes since version 1

Patch 3: change comment placement based on feedback.

§ Rebase on upstream

Rebased on `master` (fc6bba66bc (Merge branch
'js/allow-t4000-to-be-indented-with-spaces', 2023-08-14)).

§ CI

https://github.com/LemmingAvalanche/git/actions/runs/5868463450

Kristoffer Haugsbakk (3):
  range-diff: treat notes like `log`
  doc: pretty-options: remove documentation for deprecated options
  revision: comment `--no-standard-notes` as deprecated

 Documentation/pretty-options.txt |  1 -
 range-diff.c                     |  2 +-
 revision.c                       |  8 ++++++--
 t/t3206-range-diff.sh            | 28 ++++++++++++++++++++++++++++
 4 files changed, 35 insertions(+), 4 deletions(-)

Range-diff against v1:
1:  6a4fe606cf = 1:  e9a5910831 range-diff: treat notes like `log`
2:  fbc1c47b92 = 2:  f7308b7abf doc: pretty-options: remove documentation for deprecated options
3:  9141f5a86e ! 3:  80245bbb7e revision: comment `--no-standard-notes` as deprecated
    @@ Metadata
      ## Commit message ##
         revision: comment `--no-standard-notes` as deprecated

    -    We still use `--standard-notes` but this option has no use and is no
    -    longer documented anywhere.
    +    `--standard-notes` used to be deprecated but is now (since 6a4fe606cf[1])
    +    used internally. Its negation `--no-standard-notes`, however, is still
    +    deprecated even for internal use.
    +
    +    Mark this option as such.
    +
    +    † 1: range-diff: treat notes like `log`, 2023-05-19

         Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>

    +
    + ## Notes (series) ##
    +    • Move comment: https://lore.kernel.org/git/xmqqbkhk724x.fsf@gitster.g/
    +    • Tweak commit message so that it's clearer why we are only commenting
    +      “no” as deprecated and not the other option as well
    +
      ## revision.c ##
     @@ revision.c: static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
    - 		enable_default_display_notes(&revs->notes_opt,
      					     &revs->show_notes);
      		revs->notes_opt.use_default_notes = -1;
    -+		/* Deprecated */
      	} else if (!strcmp(arg, "--no-standard-notes")) {
    ++		/* Deprecated */
      		revs->notes_opt.use_default_notes = 0;
      	} else if (!strcmp(arg, "--oneline")) {
    + 		revs->verbose_header = 1;
--
2.41.0

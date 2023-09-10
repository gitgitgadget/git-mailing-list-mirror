Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9402FEE49A4
	for <git@archiver.kernel.org>; Sun, 10 Sep 2023 22:07:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231839AbjIJWHL (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 10 Sep 2023 18:07:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231664AbjIJWHK (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Sep 2023 18:07:10 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54898136
        for <git@vger.kernel.org>; Sun, 10 Sep 2023 15:07:05 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id AC6785C00F3;
        Sun, 10 Sep 2023 18:07:01 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Sun, 10 Sep 2023 18:07:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
         h=cc:cc:content-transfer-encoding:content-type:content-type
        :date:date:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to;
         s=fm3; t=1694383621; x=1694470021; bh=TVpiD0evR5EdKf2HzfBjUmTCp
        eNpVs6Lx1EhpZWyZ8I=; b=rOTPLEyyGigcM59Gtc/9pEU7ficjsgQBlutbZmY57
        1H60blSL3SogDg7xbYkaFpomIhjus8fOKZOduZrtzBpyzoCsiJRVMbhAkE90Dlye
        DZuu+Ni0rJ8Pc8Ut7ptoDw7yAj+NGAUozzHY4Crw8/EiiKPZvo8S9V9R/CJtlHCN
        PDlhHpU6zAgyQm2YTxVAW7w1jHHbqtD2azc6vp9nYrqmhWujXs/OYUrMbZ2ocdOp
        SSeFSUY/Dy60Gy4QckbXER4wAlK18rnCiDb05phxLgLAebFwFrUIcM8mBbi6ueoV
        SAslwMa3U9Z2beB+irLbQpCahsMyCpP1kLeddG29LNEHA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1694383621; x=1694470021; bh=TVpiD0evR5EdKf2HzfBjUmTCpeNpVs6Lx1E
        hpZWyZ8I=; b=IKYZYk/wkfMrorfA1lGj47z2VEQz8Ep7vMHF9KiT+pw47vA57dS
        cUV/ydlprBXFY3622vcdK8WHops9Vtp2ErXM+MNJ5kPfE5omepfWLSyDdBBWRQuS
        YnFlJw+BX+spq7Q1s+T4AGuK+BU2yHd8bhNtmhRFmV/L/F3H6lbWTDoY90c/5tYQ
        fGIIgMumiKqk5zydjwqqRG36O43gfn6T7Ba6/ZCAWs2kU8V0z7WA7Qnr5amcXi0p
        5fYgiGCvhlbdgCqi7uINHU+wQJvhZtX4RIhhweIl07GBZWusSZr439SrqlkHmqbl
        SwRTe3x07s1Jg8lumfI9QcA5Z4E/5A/FwEw==
X-ME-Sender: <xms:BT7-ZJFIdw6ZKND0_H49EOtW-S0CRdJ_x9eIaWEwiBeaY4kD-6Gnqi4>
    <xme:BT7-ZOVHnj-yu09Q1vQw-Nkxt08Ub6EMU3BuhSi6rN3pvBOJlw15sVew12QH-GzHR
    iq1AUeIKjoeKA5pJA>
X-ME-Received: <xmr:BT7-ZLKyeB_ZpVAamaNtM2-EafXX5C2podx8fgLQDkWJufssXeEMMSndMxe5OyEKWnflITIHm2SwQIKLtFsX3uVyAxXKKdaCvdBypZqgD1GY-8AXQRTM3dhIYA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudeifedgtdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhggtgfgsehtkeertdertdejnecuhfhrohhmpefmrhhi
    shhtohhffhgvrhcujfgruhhgshgsrghkkhcuoegtohguvgeskhhhrghughhssggrkhhkrd
    hnrghmvgeqnecuggftrfgrthhtvghrnhepfffhgfdutddttdfhieelvdetudefgfejleef
    ueeikeeugfeftdduiedvhfevgfetnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpgh
    hithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghi
    lhhfrhhomheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgv
X-ME-Proxy: <xmx:BT7-ZPFt6zMzYy1RIndzUGLHf4TRWAyJYjkmRsd8Mta2a_6TDv8-5A>
    <xmx:BT7-ZPUZdDQ-bG-Tm0JI1iUWjKmiRN2j_EphkF8_zlYC6brheE4KiQ>
    <xmx:BT7-ZKPHg4mEQwnAwawSR7xJfCCAYPFxogrTbWGaVnMriKDNRVysiw>
    <xmx:BT7-ZKReMpD5y2urig_W6H2nu5-X6xvjPD3K2Gk1nxiwFC3Pvfi2rw>
Feedback-ID: i2671468f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 10 Sep 2023 18:06:59 -0400 (EDT)
From:   Kristoffer Haugsbakk <code@khaugsbakk.name>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Denton Liu <liu.denton@gmail.com>, Jeff King <peff@peff.net>,
        Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: [PATCH v3 0/1] range-diff: treat notes like `log`
Date:   Mon, 11 Sep 2023 00:06:22 +0200
Message-ID: <cover.1694383247.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1693584310.git.code@khaugsbakk.name>
References: <cover.1693584310.git.code@khaugsbakk.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi

The cover letter up until the “Changes” section is mostly the same except
I deleted the justification for my approach to the problem since we don't
use that approach any more.

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

§ Changes since version 2

Dscho provided an [alternative] solution. My three patches and his patch
have been squashed into one.

🔗 alternative: https://lore.kernel.org/git/94b9535b-8c2a-eb8f-90fb-cd0f998ec57e@gmx.de/

§ CI

https://github.com/LemmingAvalanche/git/actions/runs/6139150031


Kristoffer Haugsbakk (1):
  range-diff: treat notes like `log`

 range-diff.c          | 13 +++++++++++--
 t/t3206-range-diff.sh | 28 ++++++++++++++++++++++++++++
 2 files changed, 39 insertions(+), 2 deletions(-)

Range-diff against v2:
1:  e9a5910831 ! 1:  a37dfb3748 range-diff: treat notes like `log`
    @@ Commit message
             git log --notes --notes-custom

         This can’t be how the user expects `range-diff` to behave given that the
    -    man page for `range diff` under `--[no-]notes[=<ref>]` says:
    +    man page for `range-diff` under `--[no-]notes[=<ref>]` says:

    -    > This flag is passed to the git log program (see git-log(1)) that
    +    > This flag is passed to the `git log` program (see git-log(1)) that
         > generates the patches.

         This behavior also affects `format-patch` since it uses `range-diff` for
    @@ Commit message
         to say about the changes to the default notes, since that will be shown
         in the cover letter.

    -    Remedy this by co-opting the `--standard-notes` option which has been
    -    deprecated since ab18b2c0df[2] and which is currently only documented in
    -    `pretty-options`.
    +    Remedy this by only conditionally passing in `--notes` to `range-diff`.
    +
    +    § Root cause
    +
    +    8cf51561d1e (range-diff: fix a crash in parsing git-log output,
    +    2020-04-15) added `--notes` in order to deal with a side-effect of
    +    `--pretty=medium`:
    +
    +    > To fix this explicitly set the output format of the internally executed
    +    > `git log` with `--pretty=medium`. Because that cancels `--notes`, add
    +    > explicitly `--notes` at the end.
    +
    +    § Authors
    +
    +    • Fix by Johannes
    +    • Tests by Kristoffer

         † 1: See e.g. 66b2ed09c2 (Fix "log" family not to be too agressive about
             showing notes, 2010-01-20).
    -    † 2: log/pretty-options: Document --[no-]notes and deprecate old notes
    -        options, 2011-03-30

    +    Co-authored-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
         Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>

      ## range-diff.c ##
    +@@ range-diff.c: static int read_patches(const char *range, struct string_list *list,
    + 	struct child_process cp = CHILD_PROCESS_INIT;
    + 	struct strbuf buf = STRBUF_INIT, contents = STRBUF_INIT;
    + 	struct patch_util *util = NULL;
    +-	int in_header = 1;
    ++	int i, implicit_notes_arg = 1, in_header = 1;
    + 	char *line, *current_filename = NULL;
    + 	ssize_t len;
    + 	size_t size;
    + 	int ret = -1;
    +
    ++	for (i = 0; other_arg && i < other_arg->nr; i++)
    ++		if (!strcmp(other_arg->v[i], "--notes") ||
    ++		    starts_with(other_arg->v[i], "--notes=") ||
    ++		    !strcmp(other_arg->v[i], "--no-notes")) {
    ++			implicit_notes_arg = 0;
    ++			break;
    ++		}
    ++
    + 	strvec_pushl(&cp.args, "log", "--no-color", "-p", "--no-merges",
    + 		     "--reverse", "--date-order", "--decorate=no",
    + 		     "--no-prefix", "--submodule=short",
     @@ range-diff.c: static int read_patches(const char *range, struct string_list *list,
      		     "--output-indicator-context=#",
      		     "--no-abbrev-commit",
      		     "--pretty=medium",
     -		     "--notes",
    -+		     "--standard-notes",
      		     NULL);
    ++	if (implicit_notes_arg)
    ++		     strvec_push(&cp.args, "--notes");
      	strvec_push(&cp.args, range);
      	if (other_arg)
    -
    - ## revision.c ##
    -@@ revision.c: static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
    - 		disable_display_notes(&revs->notes_opt, &revs->show_notes);
    - 		revs->show_notes_given = 1;
    - 	} else if (!strcmp(arg, "--standard-notes")) {
    --		revs->show_notes_given = 1;
    --		revs->notes_opt.use_default_notes = 1;
    -+		disable_display_notes(&revs->notes_opt, &revs->show_notes);
    -+		revs->show_notes_given = 0;
    -+		enable_default_display_notes(&revs->notes_opt,
    -+					     &revs->show_notes);
    -+		revs->notes_opt.use_default_notes = -1;
    - 	} else if (!strcmp(arg, "--no-standard-notes")) {
    - 		revs->notes_opt.use_default_notes = 0;
    - 	} else if (!strcmp(arg, "--oneline")) {
    + 		strvec_pushv(&cp.args, other_arg->v);

      ## t/t3206-range-diff.sh ##
     @@ t/t3206-range-diff.sh: test_expect_success 'range-diff with multiple --notes' '
2:  f7308b7abf < -:  ---------- doc: pretty-options: remove documentation for deprecated options
3:  80245bbb7e < -:  ---------- revision: comment `--no-standard-notes` as deprecated
--
2.42.0

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 488D6CE79A9
	for <git@archiver.kernel.org>; Tue, 19 Sep 2023 18:06:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232156AbjISSGT (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Sep 2023 14:06:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231929AbjISSGR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Sep 2023 14:06:17 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AED7197
        for <git@vger.kernel.org>; Tue, 19 Sep 2023 11:06:10 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 17B48320094E;
        Tue, 19 Sep 2023 14:06:08 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Tue, 19 Sep 2023 14:06:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
         h=cc:cc:content-transfer-encoding:content-type:content-type
        :date:date:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to;
         s=fm1; t=1695146767; x=1695233167; bh=UeriJcc+dnyy51IaMyGkH3m3F
        ZseQI3ijy/8wNuzLbE=; b=HNamohrEG6R6xGuwN8Iikqqs+M7PhOm3ayWUl1/Ib
        QqdvOVg0t8ckDbVF3SMgCW0FTH02SnfMdXGYFtAPQywWfAMFFG2p1Ofgmrme5JwC
        tqvCrcd4mnWehC1lRCuLEFG//ID9/OLaQYuOZXiZSxLW/DbTbRB3ca866JGN0FQX
        tgF07i7XmzGWrJkFF5D1buFbODL6OGr8qCrPghQaEMuH1zgKJC5KKrl4IxRo5+Rm
        VZda2pQtnuLoYxQKF/cwbAftDqHACFFhe82CdwevJuYlooT3puY8rRGTaZhFrRi1
        h0aArsAoSFkbn88TJVXz5K96kYEz3X/mVeyp8J3+GF2Mw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1695146767; x=1695233167; bh=UeriJcc+dnyy51IaMyGkH3m3FZseQI3ijy/
        8wNuzLbE=; b=HtoxgwNttHUatW8OdYbRuCJwGp4+jaRkZPMEpYLQKUQ/Kp7LYZ8
        WuMRDlq5vC7tUuNK1/yfV1pJpWh0yWn82fdLBmRo2yQrKp8PSG39ZMV1p3z4gSMB
        pyRFh6O7IXqKzMmNvOQIq1gKSfLeadu405OySbNG5O3flAWxb4tNfPftTnRNM10z
        bvay6ZehIeHT4Vvx5QhSg20i4iaenQDwzgmSySPVbjh/iiNrdt0I4k/1D3HGCpvW
        Cz5I9haI2aYOlCG/uLpVjRy4FXFFEVVAtbtzTQW1LjuRIbVEenhN414taO6NRK6G
        NXEH0Wt23QTKsI+cuCXyDE9ZxxsxQCFcBpw==
X-ME-Sender: <xms:D-MJZeaabR1TFZ8nc3I4k6vMds4C0gzpTdL4wLUVbmaPvXPkuvFlUf8>
    <xme:D-MJZRa004jb2HEA5OAHSmxdUSxMJvLHBYkmmKoVU-hH8LiKG549vRSaN9spVhjly
    2XiwBUG6T6S5xIzvA>
X-ME-Received: <xmr:D-MJZY_Jl4XxtbMDDnx1EieuljcFsBnJ91Yk6LW3ZNlCnjaRrpvw9Y6HQQa_mHONPpq4cFOvDRewYG7bS25rKEhru2gQZpmjfuag1rLzbA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudekuddgkeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhggtgfgsehtkeertdertdejnecuhfhrohhmpefmrhhi
    shhtohhffhgvrhcujfgruhhgshgsrghkkhcuoegtohguvgeskhhhrghughhssggrkhhkrd
    hnrghmvgeqnecuggftrfgrthhtvghrnhepfffhgfdutddttdfhieelvdetudefgfejleef
    ueeikeeugfeftdduiedvhfevgfetnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpgh
    hithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghi
    lhhfrhhomheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgv
X-ME-Proxy: <xmx:D-MJZQq4bldmHEeKoiSGhdsctS1sHfs6hg4Oi9gmB-cnXKMVUdY47A>
    <xmx:D-MJZZoc-UTcGvooK1_icNAgG0pVsZaiYHPJ4dllQzgYDTx6kq7tUQ>
    <xmx:D-MJZeQloph3RaYJh5MjuJBbYitdRUAGC5KTcYGoPyENZXo-vjHbUg>
    <xmx:D-MJZQXkC146nD8wJ6dmIBWRn_fImtlq4vhxccrYep3N0W9vH1MqPg>
Feedback-ID: i2671468f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 19 Sep 2023 14:06:06 -0400 (EDT)
From:   Kristoffer Haugsbakk <code@khaugsbakk.name>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Denton Liu <liu.denton@gmail.com>, Jeff King <peff@peff.net>,
        Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: [PATCH v4 0/1] range-diff: treat notes like `log`
Date:   Tue, 19 Sep 2023 20:05:31 +0200
Message-ID: <cover.1695144790.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1694383247.git.code@khaugsbakk.name>
References: <cover.1694383247.git.code@khaugsbakk.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi

Same cover letter up until but not including “Changes ...”.

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

§ Changes since version 3

Dscho [rewrote] the fix: introduce a new option to pass to `git log`.

🔗 rewrote: https://lore.kernel.org/git/dd2958c5-58bf-86dd-b666-9033259a8e1a@gmx.de/

§ CI (WIP)

https://github.com/LemmingAvalanche/git/actions/runs/6238806624

Kristoffer Haugsbakk (1):
  range-diff: treat notes like `log`

 Documentation/pretty-options.txt |  4 ++++
 range-diff.c                     |  2 +-
 revision.c                       |  7 +++++++
 revision.h                       |  1 +
 t/t3206-range-diff.sh            | 28 ++++++++++++++++++++++++++++
 5 files changed, 41 insertions(+), 1 deletion(-)

Range-diff against v3:
1:  a37dfb3748 ! 1:  244e102cc4 range-diff: treat notes like `log`
    @@ Commit message
         to say about the changes to the default notes, since that will be shown
         in the cover letter.

    -    Remedy this by only conditionally passing in `--notes` to `range-diff`.
    +    Remedy this by introducing `--show-notes-by-default` that `range-diff` can
    +    use to tell the `log` subprocess what to do.

         § Root cause

    @@ Commit message
         Co-authored-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
         Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>

    - ## range-diff.c ##
    -@@ range-diff.c: static int read_patches(const char *range, struct string_list *list,
    - 	struct child_process cp = CHILD_PROCESS_INIT;
    - 	struct strbuf buf = STRBUF_INIT, contents = STRBUF_INIT;
    - 	struct patch_util *util = NULL;
    --	int in_header = 1;
    -+	int i, implicit_notes_arg = 1, in_header = 1;
    - 	char *line, *current_filename = NULL;
    - 	ssize_t len;
    - 	size_t size;
    - 	int ret = -1;
    + ## Documentation/pretty-options.txt ##
    +@@ Documentation/pretty-options.txt: message by 4 spaces (i.e.  'medium', which is the default, 'full',
    + and 'fuller').

    -+	for (i = 0; other_arg && i < other_arg->nr; i++)
    -+		if (!strcmp(other_arg->v[i], "--notes") ||
    -+		    starts_with(other_arg->v[i], "--notes=") ||
    -+		    !strcmp(other_arg->v[i], "--no-notes")) {
    -+			implicit_notes_arg = 0;
    -+			break;
    -+		}
    + ifndef::git-rev-list[]
    ++--show-notes-by-default::
    ++	Show the default notes (see `--notes`) unless subsequent arguments
    ++	are used to display specific notes.
     +
    - 	strvec_pushl(&cp.args, "log", "--no-color", "-p", "--no-merges",
    - 		     "--reverse", "--date-order", "--decorate=no",
    - 		     "--no-prefix", "--submodule=short",
    + --notes[=<ref>]::
    + 	Show the notes (see linkgit:git-notes[1]) that annotate the
    + 	commit, when showing the commit log message.  This is the default
    +
    + ## range-diff.c ##
     @@ range-diff.c: static int read_patches(const char *range, struct string_list *list,
      		     "--output-indicator-context=#",
      		     "--no-abbrev-commit",
      		     "--pretty=medium",
     -		     "--notes",
    ++		     "--show-notes-by-default",
      		     NULL);
    -+	if (implicit_notes_arg)
    -+		     strvec_push(&cp.args, "--notes");
      	strvec_push(&cp.args, range);
      	if (other_arg)
    - 		strvec_pushv(&cp.args, other_arg->v);
    +
    + ## revision.c ##
    +@@ revision.c: static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
    + 		revs->break_bar = xstrdup(optarg);
    + 		revs->track_linear = 1;
    + 		revs->track_first_time = 1;
    ++	} else if (!strcmp(arg, "--show-notes-by-default")) {
    ++		revs->show_notes_by_default = 1;
    + 	} else if (skip_prefix(arg, "--show-notes=", &optarg) ||
    + 		   skip_prefix(arg, "--notes=", &optarg)) {
    + 		if (starts_with(arg, "--show-notes=") &&
    +@@ revision.c: int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
    + 	if (revs->expand_tabs_in_log < 0)
    + 		revs->expand_tabs_in_log = revs->expand_tabs_in_log_default;
    +
    ++	if (!revs->show_notes_given && revs->show_notes_by_default) {
    ++		enable_default_display_notes(&revs->notes_opt, &revs->show_notes);
    ++		revs->show_notes_given = 1;
    ++	}
    ++
    + 	return left;
    + }
    +
    +
    + ## revision.h ##
    +@@ revision.h: struct rev_info {
    + 			shown_dashes:1,
    + 			show_merge:1,
    + 			show_notes_given:1,
    ++			show_notes_by_default:1,
    + 			show_signature:1,
    + 			pretty_given:1,
    + 			abbrev_commit:1,

      ## t/t3206-range-diff.sh ##
     @@ t/t3206-range-diff.sh: test_expect_success 'range-diff with multiple --notes' '
--
2.42.0

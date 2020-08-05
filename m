Return-Path: <SRS0=VMi1=BP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7231DC433DF
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 01:19:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C8FA2075D
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 01:19:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tZnv5oXW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbgHEBTO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Aug 2020 21:19:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726762AbgHEBTL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Aug 2020 21:19:11 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9D09C06174A
        for <git@vger.kernel.org>; Tue,  4 Aug 2020 18:19:10 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id k20so4653578wmi.5
        for <git@vger.kernel.org>; Tue, 04 Aug 2020 18:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=H+m+5+gsGGNvDRm3q5fL+U6ssJOOdcCcMUFwp6J9ros=;
        b=tZnv5oXWcc7cKMTNE6cEELyvn2ZLyJdseAEbsyqdf+iG3GTRMnxnb6fw8URMwi6zRk
         tf/a1I87gMBGBe8M+koxveJV1PJfbjofm1CbQZ0wAbbMl3GIcvTBbzhAXXXh7m6L2ARk
         5olLMwNojp2a7oFRdpRoiCMQ7XppCYr4shNTb0odX15WmObwkAtEyT8FUJ9ofr2sXJv3
         XfWqQYxjXTtuGZ5e/t2zYTR82oJ9WG/drSgiN6rf8b/uDB4OWDtCYgTrvca2JtGBvM8K
         tEQVEhSMz8BZPRNCyp40zRC8Tx55U0KVz5l+DZHq8Ry5BD6tgj3XFF8CgTpVLYkYhlk6
         cBkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=H+m+5+gsGGNvDRm3q5fL+U6ssJOOdcCcMUFwp6J9ros=;
        b=AwQ+ewphxNbjjMh5aPLroIydfIXSJeYM1B7KbGzwUVSXWWVBKL/9K6jEfeEE8jYsIY
         o7T44Trnag9RYn4gwJKKV7e8vyaJhY5o0VTSZ56VJQIz4VQLfr8joNPmRHHvzXK0lX5b
         zQylDxdFaV33A6VoM5Yd99/WQzCt4AzUlQWQKqp5YFbwDQfxw8YNG2+8LGF3TBE6ihE/
         MQddR0+IgE6eo6gv81BYEBs9XOgYApdYMNZfbWyJQ7iWkM/omWhi13uzHo1zTfJIaYyO
         JdoPmU6t5f81ZE3Ne3Ia7Sw9NXua0qL8tF5tOivEVc852QrO/O2u/fXD1f1weIgw5sMr
         3E1A==
X-Gm-Message-State: AOAM5306Bihl1s8wQlyb7fOx62y5mQ7WVILBqEs4mLWma2dBoY1az4rr
        2raqv1KTnPdw4DrYvPKpfd/Qlcc0
X-Google-Smtp-Source: ABdhPJxPc2GmqwxrZjjAGcz9QOrI+3sBl9/ntDd1kI/7SLVaV0mSiZiU8mFpVdtgZjMmMbCqqHJQ6Q==
X-Received: by 2002:a1c:9e11:: with SMTP id h17mr931183wme.106.1596590349285;
        Tue, 04 Aug 2020 18:19:09 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k13sm647404wmj.14.2020.08.04.18.19.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2020 18:19:08 -0700 (PDT)
Message-Id: <pull.691.v3.git.1596590347.gitgitgadget@gmail.com>
In-Reply-To: <pull.691.v2.git.1596500459.gitgitgadget@gmail.com>
References: <pull.691.v2.git.1596500459.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 05 Aug 2020 01:19:03 +0000
Subject: [PATCH v3 0/4] List all guides in git(1)
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc?= Duy 
        <pclouds@gmail.com>, Philip Oakley <philipoakley@iee.email>,
        Eric Sunshine <sunshine@sunshineco.com>,
        SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changes since v2:

 * Split the third commit following Junio's suggestion

Question for Junio: Since the new commit 3/4 comes entirely from your
suggestion, I've attributed authorship to you, but I've added my own
sign-off because Gitgitgadget requires sign-off on each commit. Please let
me know if I should have proceeded differently.

v2:

 * Incorporated Junio's suggestion to reduce duplication.

v1: This series adds a list of the guides to git(1).

The first commit adds the misssing guides 'gitcredentials' and
'gitremote-helpers' to command-list.txt. The only missing guide after this
change is 'gitweb.conf', but I think this one is obscure anough, and already
linked to in 'gitweb.txt', that it does not matter much.

The second commit drops the usage of 'common' and 'useful' for guides. This
was suggested as one of two ways forward by Duy in [1] but was not commented
on. I'm CC'ing the people that were CC'ed on that message.

The third commit tweaks 'Documentation/cmd-list.perl' so that it also
generates a list of the guides, which gets included in 'git.txt'. I chose to
put this list just after the end of the list of commands.

[1] 
https://lore.kernel.org/git/CACsJy8ADj-bTMYDHxRNLOMppOEdPbVwL49u3XCfNBCmoLLZo+A@mail.gmail.com/

Junio C Hamano (1):
  Documentation: don't hardcode command categories twice

Philippe Blain (3):
  command-list.txt: add missing 'gitcredentials' and 'gitremote-helpers'
  help: drop usage of 'common' and 'useful' for guides
  git.txt: add list of guides

 Documentation/Makefile           |  4 +++-
 Documentation/cmd-list.perl      | 27 ++++++++++++++-------------
 Documentation/git-help.txt       |  6 +++---
 Documentation/git.txt            |  7 +++++++
 Documentation/gitcredentials.txt |  2 +-
 builtin/help.c                   |  2 +-
 command-list.txt                 |  2 ++
 help.c                           |  4 ++--
 help.h                           |  2 +-
 9 files changed, 34 insertions(+), 22 deletions(-)


base-commit: e8ab941b671da6890181aea5b5755d1d9eea24ec
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-691%2Fphil-blain%2Flist-guides-in-git.1-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-691/phil-blain/list-guides-in-git.1-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/691

Range-diff vs v2:

 1:  2bd473e0aa = 1:  2bd473e0aa command-list.txt: add missing 'gitcredentials' and 'gitremote-helpers'
 2:  f49cf08f4f = 2:  f49cf08f4f help: drop usage of 'common' and 'useful' for guides
 -:  ---------- > 3:  552444a842 Documentation: don't hardcode command categories twice
 3:  4394bb357b ! 4:  840371fb4b git.txt: add list of guides
     @@ Commit message
          `Documentation/cmd-list.perl` script to generate a file `cmds-guide.txt`
          which gets included in git.txt.
      
     -    Instead of hard-coding the list of command categories in both
     -    `Documentation/Makefile` and `Documentation/cmd-list.perl`, make the
     -    Makefile the authoritative source and tweak `cmd-list.perl` so that it
     -    receives the list of command categories as argument.
     -
          Also, do not hard-code the manual section '1'. Instead, use a regex so
          that the manual section is discovered from the first line of each
          `git*.txt` file.
      
     -    This addition was hinted at in 1b81d8cb19 (help: use command-list.txt for
     -    the source of guides, 2018-05-20).
     +    This addition was hinted at in 1b81d8cb19 (help: use command-list.txt
     +    for the source of guides, 2018-05-20).
      
          Helped-by: Junio C Hamano <gitster@pobox.com>
          Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
     @@ Documentation/Makefile: cmds_txt = cmds-ancillaryinterrogators.txt \
       	cmds-purehelpers.txt \
       	cmds-foreignscminterface.txt
       
     -@@ Documentation/Makefile: $(cmds_txt): cmd-list.made
     - 
     - cmd-list.made: cmd-list.perl ../command-list.txt $(MAN1_TXT)
     - 	$(QUIET_GEN)$(RM) $@ && \
     --	$(PERL_PATH) ./cmd-list.perl ../command-list.txt $(QUIET_STDERR) && \
     -+	$(PERL_PATH) ./cmd-list.perl ../command-list.txt $(cmds_txt) $(QUIET_STDERR) && \
     - 	date >$@
     - 
     - mergetools_txt = mergetools-diff.txt mergetools-merge.txt
      
       ## Documentation/cmd-list.perl ##
      @@ Documentation/cmd-list.perl: sub format_one {
     @@ Documentation/cmd-list.perl: sub format_one {
       		if ($attr =~ / deprecated /) {
       			print $out "(deprecated) ";
       		}
     -@@ Documentation/cmd-list.perl: sub format_one {
     - 	}
     - }
     - 
     --while (<>) {
     -+my ($input, @categories) = @ARGV;
     -+
     -+open IN, "<$input";
     -+while (<IN>) {
     - 	last if /^### command list/;
     - }
     - 
     - my %cmds = ();
     --for (sort <>) {
     -+for (sort <IN>) {
     - 	next if /^#/;
     - 
     - 	chomp;
     -@@ Documentation/cmd-list.perl: sub format_one {
     - 	$attr = '' unless defined $attr;
     - 	push @{$cmds{$cat}}, [$name, " $attr "];
     - }
     -+close IN;
     - 
     --for my $cat (qw(ancillaryinterrogators
     --		ancillarymanipulators
     --		mainporcelain
     --		plumbinginterrogators
     --		plumbingmanipulators
     --		synchingrepositories
     --		foreignscminterface
     --		purehelpers
     --		synchelpers)) {
     --	my $out = "cmds-$cat.txt";
     -+for my $out (@categories) {
     -+	my ($cat) = $out =~ /^cmds-(.*)\.txt$/;
     - 	open O, '>', "$out+" or die "Cannot open output file $out+";
     - 	for (@{$cmds{$cat}}) {
     - 		format_one(\*O, $_);
      
       ## Documentation/git.txt ##
      @@ Documentation/git.txt: users typically do not use them directly.

-- 
gitgitgadget

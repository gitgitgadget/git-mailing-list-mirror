Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D75E61F461
	for <e@80x24.org>; Mon, 24 Jun 2019 18:39:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729109AbfFXSjh (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Jun 2019 14:39:37 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42562 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728496AbfFXSjg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jun 2019 14:39:36 -0400
Received: by mail-wr1-f66.google.com with SMTP id x17so14970922wrl.9
        for <git@vger.kernel.org>; Mon, 24 Jun 2019 11:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=ITvHSiy79mOfFoRXNBxON33rlA+ZloUANLSB7KLbsgo=;
        b=tdfGQqvmm+1Cxqp7eERrSp2aE2DhrmThtheuQtRczLRz4vwvCDA4JV2BZFLef5Ogde
         94eWU0K3M1HnHyNeH2GHFmBJSahKNwvBJ14M2w5Un5ZhNqcwQuFMM3q042Ome1C1wSH2
         hOys1HQYyBvpc8V/ZeVNNySEtSKgELZqCGrRR8kOUGakNjiQw5xOBOUiLTxM6aYkl4nE
         c7uYfB8Q4P2Jw8RmcEDzDC4rHaOWF3eqyDvieSONvFDyU+p3e47oIInknDhA22bShR05
         AMaMqaPh/T95z7FKwbRYetgnr/Gq5T1vun+LuwzfmceokyaVONdgqwhpDmlwmksaaGlz
         igHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=ITvHSiy79mOfFoRXNBxON33rlA+ZloUANLSB7KLbsgo=;
        b=F4wKmRBhIB8+Gi8Gwwg+ruyrWg6mKpWNcLsVFKmsD9wy7U0xtQTZHG4xGsitfbnarZ
         MtOToDSsZGyHMeBpsII3pgIrmYyFLAC1n4tugzEw1JO5ggMscRX+nZCk6zKde1VcmHEB
         HHwD9aglEZtSCU1X9rqGgf0qWkY6zICFzQuKwJTl9P3Xp4O1H7xkPLCXxpiG6VNN4bky
         91RdamX1IBFXrktJySBkMOwjqHgJG42wH83IuIMtlbrdd2QkGirzItRpfteUMcd/x/16
         h0nrfC2MpJtJhI+xxlBJyEDRtuxL6k98EgEvvUp1FF1aeGEn4Rbq6F9vAFILr4QGbXgn
         zU4Q==
X-Gm-Message-State: APjAAAU9/Q0MhzQU65LLqQRyDAw9x+eBwq/Ld/X5ioda2+Xg25Te32m6
        g66deyxQslEwH0nrG+E1ASE=
X-Google-Smtp-Source: APXvYqyqxwIHrcxAtHoxDToROJHx87Sb/j1ZQM7xL91RTSZrIdzMecfZb3ln7whcojZ9uGlAQU2bSw==
X-Received: by 2002:a5d:4949:: with SMTP id r9mr50851610wrs.289.1561401573602;
        Mon, 24 Jun 2019 11:39:33 -0700 (PDT)
Received: from szeder.dev (x4db9a89d.dyn.telefonica.de. [77.185.168.157])
        by smtp.gmail.com with ESMTPSA id f197sm438204wme.39.2019.06.24.11.39.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Jun 2019 11:39:32 -0700 (PDT)
Date:   Mon, 24 Jun 2019 20:39:27 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH v2 3/4] rebase: fix garbled progress display with '-x'
Message-ID: <20190624183927.GA10853@szeder.dev>
References: <20190430142556.20921-1-szeder.dev@gmail.com>
 <20190611130320.18499-1-szeder.dev@gmail.com>
 <20190611130320.18499-4-szeder.dev@gmail.com>
 <xmqq36kflv0f.fsf@gitster-ct.c.googlers.com>
 <20190611211151.GG4012@szeder.dev>
 <nycvar.QRO.7.76.6.1906122056570.789@QRFXGBC-DHN364S.ybpnyqbznva>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <nycvar.QRO.7.76.6.1906122056570.789@QRFXGBC-DHN364S.ybpnyqbznva>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 12, 2019 at 09:14:40PM +0200, Johannes Schindelin wrote:
> Hi,
> 
> On Tue, 11 Jun 2019, SZEDER Gábor wrote:
> 
> > On Tue, Jun 11, 2019 at 01:36:16PM -0700, Junio C Hamano wrote:
> > > SZEDER Gábor <szeder.dev@gmail.com> writes:
> > >
> > > > -Rebasing (1/4)QRebasing (2/4)QRebasing (3/4)QRebasing (4/4)QSuccessfully rebased and updated refs/heads/missing-commit.
> > > > +Rebasing (1/4)QRebasing (2/4)QRebasing (3/4)QRebasing (4/4)QQ                                                                                QSuccessfully rebased and updated refs/heads/missing-commit.
> > > >  EOF
> > >
> > > Yuck,
> >
> > Oh yeah...
> >
> > >... but I do not see how else/better this test can be written
> > > myself, which makes it a double-yuck X-<
> >
> > Perhaps hiding those spaces behind a helper variable e.g.
> > 'dump_term_clear_line=Q<80-spaces>Q' and embedding that in the here
> > docs specifying the expected output in these three tests could make it
> > ever so slightly less yuck...
> >
> > > Are we forcing out test to operate under dumb terminal mode and with
> > > a known number of columns?
> >
> > 'test-lib.sh' sets TERM=dumb relatively early on, and in these tests
> > we don't use 'test_terminal' to run 'git rebase', so...  yeah.  And
> > term_columns() defaults to 80.
> >
> > However, if the terminal were smart, then we would have to deal with
> > ANSI escape suddenly popping up...
> 
> And I fear that is *exactly* what makes
> https://dev.azure.com/gitgitgadget/git/_build/results?buildId=10539&view=ms.vss-test-web.build-test-results-tab
> fail...
> 
> You cannot easily see it in that output (probably because of incorrectly
> encoded Escape sequences in the `.xml` output), so I'll paste what I see
> here, locally, when running `t3404-*.sh -i -V -x`:
> 
> -- snip --
> [...]
> ok 99 - rebase -i respects rebase.missingCommitsCheck = ignore
> 
> expecting success:
>         test_config rebase.missingCommitsCheck warn &&
>         rebase_setup_and_clean missing-commit &&
>         set_fake_editor &&
>         FAKE_LINES="1 2 3 4" \
>                 git rebase -i --root 2>actual &&
>         test_i18ncmp expect actual &&
>         test D = $(git cat-file commit HEAD | sed -ne \$p)

[...]

> ++ test_cmp expect actual
> ++ GIT_ALLOC_LIMIT=0
> ++ test-tool cmp expect actual
> diff --git a/expect b/actual
> index 05fcfcb..9555e34 100644
> --- a/expect
> +++ b/actual
> @@ -6,4 +6,4 @@ To avoid this message, use "drop" to explicitly remove a commit.
>  Use 'git config rebase.missingCommitsCheck' to change the level of warnings.
>  The possible behaviours are: ignore, warn, error.
> 
> -Rebasing (1/4)^MRebasing (2/4)^MRebasing (3/4)^MRebasing (4/4)^M                                                                                ^MSuccessfully rebased and updated refs/heads/missing-commit.
> +Rebasing (1/4)^MRebasing (2/4)^MRebasing (3/4)^MRebasing (4/4)^MESC[KSuccessfully rebased and updated refs/heads/missing-commit.
> error: last command exited with $?=1
> not ok 100 - rebase -i respects rebase.missingCommitsCheck = warn
> #
> #               test_config rebase.missingCommitsCheck warn &&
> #               rebase_setup_and_clean missing-commit &&
> #               set_fake_editor &&
> #               FAKE_LINES="1 2 3 4" \
> #                       git rebase -i --root 2>actual &&
> #               test_i18ncmp expect actual &&
> #               test D = $(git cat-file commit HEAD | sed -ne \$p)
> #
> -- snap --
> 
> (I copy-pasted this from the output of `less` so that the control sequences can be seen.)
> 
> To be utterly honest, I really fail to see a reason why a test case that
> purports to verify that `git rebase -i` respects
> `rebase.missingCommitsCheck=warn` should fail when the progress is shown in an
> unexpected format.
> 
> It strikes me as yet another poorly written test case that fails to catch the
> intended regressions, instead it catches a bug *in the test case itself* when
> legitimate changes are made to the progress code.
> 
> Nothing in a test suite is worse than a test that fails (or succeeds) for the
> wrong reasons.
> 
> To make things even worse, the code that generates that `expect` file is
> outside the test case.
> 
> Here it is, in its full "glory":
> 
> -- snip --
> q_to_cr >expect <<EOF
> Warning: some commits may have been dropped accidentally.
> Dropped commits (newer to older):
>  - $(git rev-list --pretty=oneline --abbrev-commit -1 master)
> To avoid this message, use "drop" to explicitly remove a commit.
> 
> Use 'git config rebase.missingCommitsCheck' to change the level of warnings.
> The possible behaviours are: ignore, warn, error.
> 
> Rebasing (1/4)QRebasing (2/4)QRebasing (3/4)QRebasing (4/4)QQ                                                                                QSuccessfully rebased and updated refs/heads/missing-commit.
> EOF
> -- snap --
> 
> May I please *strongly* suggest to fix this first? It should
> 
> - completely lose that last line,
> - be inserted into the test case itself so that e.g. disk full problems are
>   caught and logged properly, and
> - the `test_i18ncmp expect actual` call in the test case should be replaced
>   by something like:
> 
> 	sed "\$d" <actual >actual-skip-progress &&
> 	test_i18ncmp expect actual-skip-progress
> 
> This should obviously be made as a separate, introductory patch (probably with
> a less scathing commit message than my comments above would suggest).
> 
> And that would also remove the double-yuck.

Unfortunately, this addresses only one of the "Yuck"s; see v3 of this
patch series [1].

The other yucks affect the following four tests in
't3420-rebase-autostash.sh':

  16 - rebase --merge --autostash: check output
  23 - rebase --merge: check output with conflicting stash
  26 - rebase --interactive --autostash: check output
  33 - rebase --interactive: check output with conflicting stash

These tests come from commits b76aeae553 (rebase: add regression tests
for console output, 2017-06-19) and 7d70e6b902 (rebase: add more
regression tests for console output, 2017-06-19), and are specifically
about checking the (whole) console output of 'git rebase', so I left
the updates to them as they were.

In any case, Cc-ing Phillip to discuss whether something could be done
about them (now perhaps preferably (for me :) as a follow-up, and not
another preparatory patches).


[1] https://public-inbox.org/git/20190624181318.17388-3-szeder.dev@gmail.com/T/#u


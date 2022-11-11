Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9E40C433FE
	for <git@archiver.kernel.org>; Fri, 11 Nov 2022 07:35:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232943AbiKKHfA (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Nov 2022 02:35:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232773AbiKKHe7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Nov 2022 02:34:59 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C84BB79D12
        for <git@vger.kernel.org>; Thu, 10 Nov 2022 23:34:57 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id o30so2480540wms.2
        for <git@vger.kernel.org>; Thu, 10 Nov 2022 23:34:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gHyRH4K012Z0ZW/0oLSoZCDd+HfMh8kJHr10cBlTBO0=;
        b=c2F4DCeCa6im1D87+H14z8H3I4wX7gy3yLuK07cTukYdDA31/UHanTxVDeyHbKbaYW
         EGfbA21nol80BytG+dycExB1ARGyA+qWgdu90P+QKQCINHxciY78MRubiN9FhCC//TVc
         xLLnoC7CukN5lQUXklSSOXA2vHFEenFXrNJyqogfAh6miXQLe2VgGaL1AOgrseBBxfCQ
         rqf9APjJYUNXy9xLwqh+esxvjVgk18zPxMbw/sAZD5CDADhSXPDGJ7zw5IHWWodCvWqZ
         9mwW17M4wvukc62Gly4hW2b3CjYq22Xn0qtaeZ28frZBnPh+8o1obUZYPt6dLKIgyRwo
         79/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gHyRH4K012Z0ZW/0oLSoZCDd+HfMh8kJHr10cBlTBO0=;
        b=UpXWibpry31AG3GUm0GuG6p9Y71KsSY2C212qPX89IuBwUnhVOEpufbSXqweUmnZQa
         eVczqDTEXBgZa/QYH/9Ad4849bHtj4HWaIreIn+ACsiWgOZy+tshGXhSWLLC9i46k60K
         Cbe40CtqdyMLLjOU7/qrKaJ5xh+9SMQgl3TJn5D2hrX0oIlsAgRi2DrjiJ4q/LGAd1fh
         4TfPwy94folgmqzLjfn9WHUsQdHi7DT3SUQR+YQVtUAb9Q0BHcECYB177HrrhPzW3wig
         88GIzE+MXAso4pk0muouwNY6sO5D8CFtkA31QYY10aCKgZqPCFvCB3NyKOFzHylJUAKl
         TTKw==
X-Gm-Message-State: ANoB5pk/rerO8zwK+YL+NfJB7nMtTk1hpmeuF8QO1cGBG+vGqWd3D2Yc
        nXGar+CnAHP2JO6t2Bu+0DbhL0ezomk=
X-Google-Smtp-Source: AA0mqf5qFd/RfsrwW2pvxNa/tMUC9TKBNFR8qn0huXO+TxwxsXTQdoF2612V9gelP8jmc5XTDbckdw==
X-Received: by 2002:a05:600c:21cc:b0:3cf:8b32:a52 with SMTP id x12-20020a05600c21cc00b003cf8b320a52mr360416wmj.72.1668152096026;
        Thu, 10 Nov 2022 23:34:56 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k33-20020a05600c1ca100b003cf6c2f9513sm2286969wms.2.2022.11.10.23.34.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 23:34:55 -0800 (PST)
Message-Id: <pull.1413.v2.git.1668152094.gitgitgadget@gmail.com>
In-Reply-To: <pull.1413.git.1668013114.gitgitgadget@gmail.com>
References: <pull.1413.git.1668013114.gitgitgadget@gmail.com>
From:   "Eric Sunshine via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 11 Nov 2022 07:34:51 +0000
Subject: [PATCH v2 0/3] chainlint: emit line numbers alongside test definitions
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Taylor Blau <me@ttaylorr.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a re-roll of "es/chainlint-lineno"[1] which makes chainlint.pl
output line numbers alongside annotated test definitions in which problems
have been discovered.

Changes since v1:

Limit sidestepping of impoverished Apple "terminfo" entries to specific
terminal types known to be problematic and in common use on macOS, rather
than sledge-hammer matching all "xterm" since some old "xterm" variants may
legitimately not support ANSI capabilities (suggested by brian[2]).

Fix incorrect line number computation when swallowing here-doc bodies. v1
incorrectly incremented the line number by two regardless of the here-doc
body's actual size. I very much would like to add tests to catch this sort
of problem, however, the current chainlint self-test framework validates
chainlint behavior in relation only to test bodies, whereas this problem
manifested when a here-doc was present at the script level outside of any
test. It may be possible to expand the self-test framework in the future to
allow such testing, but that may be some time off, and needn't hold up this
series.

FOOTNOTES

[1]
https://lore.kernel.org/git/pull.1413.git.1668013114.gitgitgadget@gmail.com/
[2]
https://lore.kernel.org/git/Y2xkpJj4jLqfsggL@tapette.crustytoothpaste.net/

Eric Sunshine (3):
  chainlint: sidestep impoverished macOS "terminfo"
  chainlint: latch line numbers at which each token starts and ends
  chainlint: prefix annotated test definition with line numbers

 t/Makefile     |  2 +-
 t/chainlint.pl | 70 ++++++++++++++++++++++++++++++++++----------------
 2 files changed, 49 insertions(+), 23 deletions(-)


base-commit: 73c768dae9ea4838736693965b25ba34e941ac88
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1413%2Fsunshineco%2Fchainlintline-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1413/sunshineco/chainlintline-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1413

Range-diff vs v1:

 1:  b85b28e5a6b ! 1:  de482cf9cf1 chainlint: sidestep impoverished macOS "terminfo"
     @@ Commit message
          chainlint: sidestep impoverished macOS "terminfo"
      
          Although the macOS Terminal.app is "xterm"-compatible, its corresponding
     -    "terminfo" entry neglects to mention capabilities which Terminal.app
     +    "terminfo" entries -- such as "xterm", "xterm-256color", and
     +    "xterm-new"[1] -- neglect to mention capabilities which Terminal.app
          actually supports (such as "dim text"). This oversight on Apple's part
          ends up penalizing users of "good citizen" console programs which
          consult "terminfo" to tailor their output based upon reported terminal
          capabilities (as opposed to programs which assume that the terminal
     -    supports ANSI codes).
     +    supports ANSI codes). The same problem is present in other Apple
     +    "terminfo" entries, such as "nsterm"[2], with which macOS Terminal.app
     +    may be configured.
      
          Sidestep this Apple problem by imbuing get_colors() with specific
     -    knowledge of "xterm" capabilities rather than trusting "terminfo" to
     -    report them correctly. Although hard-coding such knowledge is ugly,
     -    "xterm" support is nearly ubiquitous these days, and Git itself sets
     -    precedence by assuming support for ANSI color codes. For non-"xterm",
     -    fall back to querying "terminfo" via `tput` as usual.
     +    knowledge of capabilities common to "xterm" and "nsterm", rather than
     +    trusting "terminfo" to report them correctly. Although hard-coding such
     +    knowledge is ugly, "xterm" support is nearly ubiquitous these days, and
     +    Git itself sets precedence by assuming support for ANSI color codes. For
     +    other terminal types, fall back to querying "terminfo" via `tput` as
     +    usual.
     +
     +    FOOTNOTES
     +
     +    [1] iTerm2 FAQ suggests "xterm-new": https://iterm2.com/faq.html
     +
     +    [2] Neovim documentation recommends terminal type "nsterm" with
     +        Terminal.app: https://neovim.io/doc/user/term.html#terminfo
      
          Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
      
     @@ t/chainlint.pl: my @NOCOLORS = (bold => '', rev => '', reset => '', blue => '',
      -		   green => `tput setaf 2`,
      -		   red   => `tput setaf 1`);
      -	chomp(%COLORS);
     -+	if ($ENV{TERM} =~ /\bxterm\b/) {
     ++	if ($ENV{TERM} =~ /xterm|xterm-\d+color|xterm-new|xterm-direct|nsterm|nsterm-\d+color|nsterm-direct/) {
      +		%COLORS = (bold  => "\e[1m",
      +			   rev   => "\e[7m",
      +			   reset => "\e[0m",
 2:  c8a316426be ! 2:  84ddc6707fb chainlint: latch line numbers at which each token starts and ends
     @@ t/chainlint.pl: sub scan_balanced {
       }
       
      @@ t/chainlint.pl: sub swallow_heredocs {
     + 	my $b = $self->{buff};
     + 	my $tags = $self->{heretags};
       	while (my $tag = shift @$tags) {
     ++		my $start = pos($$b);
       		my $indent = $tag =~ s/^\t// ? '\\s*' : '';
       		$$b =~ /(?:\G|\n)$indent\Q$tag\E(?:\n|\z)/gc;
     -+		my $body = $&;
     ++		my $body = substr($$b, $start, pos($$b) - $start);
      +		$self->{lineno} += () = $body =~ /\n/sg;
       	}
       }
 3:  380b146abd1 ! 3:  3cb4ff4d330 chainlint: prefix annotated test definition with line numbers
     @@ t/chainlint.pl: if (eval {require Time::HiRes; Time::HiRes->import(); 1;}) {
       sub get_colors {
       	return \%COLORS if %COLORS;
      @@ t/chainlint.pl: sub get_colors {
     - 	if ($ENV{TERM} =~ /\bxterm\b/) {
     + 	if ($ENV{TERM} =~ /xterm|xterm-\d+color|xterm-new|xterm-direct|nsterm|nsterm-\d+color|nsterm-direct/) {
       		%COLORS = (bold  => "\e[1m",
       			   rev   => "\e[7m",
      +			   dim   => "\e[2m",

-- 
gitgitgadget

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C80D11F424
	for <e@80x24.org>; Tue, 24 Apr 2018 05:07:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755600AbeDXFHi (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Apr 2018 01:07:38 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:35504 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751603AbeDXFHh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Apr 2018 01:07:37 -0400
Received: by mail-pg0-f65.google.com with SMTP id j11so9964475pgf.2
        for <git@vger.kernel.org>; Mon, 23 Apr 2018 22:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gyYETS5Z9IH5cBYCUY4xL65xbrAx55xfFZayf5pWhHM=;
        b=jFWDQn8iKNpGi8jbfz7RJZp91pOD8BBEbocWcM35vy8UD9kTIPWJJTyxcQMIAllOqo
         /M+qciHDMyhhb4S9LZKnUhMK2Wg28FrkijDQgVLpK5WaF7kQFP7sbAvS597IQZdJ4iMD
         xv0LQ0OuQ45eUwtdneAq7iOqWzQREaYyUqjHq/r3n3bqh6HhBQ7ZCAb02VwB+/4uhNSX
         3p/3GDsCOVIBAyQAxatoxWwnbVgSragW9sL1KjwYF1d9u7o/s/SZTFl9NayvKFmQ72Ql
         ar4beAeBDzTWr0P88ew/jLIhen0x7PprBirFNiMS0+IN/VDsyvXr1b6JTioiMTMZPiMG
         XULA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gyYETS5Z9IH5cBYCUY4xL65xbrAx55xfFZayf5pWhHM=;
        b=eQTsgvtFc7pmpKSoVukpx4eIyzniVUscHzp8RT4hyDA25PlWnFbGgGB6u+K0XHCTr4
         O9YcQradW6klTHPFksa8P5t/wPJOt9aa7AJEXvaLNS6eEc4CySaZIHpMP1gklBXDo/Xj
         L0ZI/iwCCpeIMEgr1JhdDPF4BGDJty8qpEgWMn0O3lqxTiH1dDg44H+r4j01l6ge8dcU
         rBa2cHaBHk9sfj485hkQtbPh/XuA/8iwg3ic5voYdSEwVXsdVHCXW7GO7heXUklkF2Tc
         Y9qijZiY8Za5Kb9zUmBDnwrL1Zu654z8yZe94WTxt8o4ulYI16YY9OFalj5h+otZHbrZ
         M8iQ==
X-Gm-Message-State: ALQs6tCUReogim1jKVAIrLc3Zt+unsPJLLkqLziY8exwuOvPh5yD4W8X
        F9+Xw75pHpwmArjmKI9fcJQcno4RcluFRQ==
X-Google-Smtp-Source: AIpwx4+g5fU4D+7rSiuAerYwGUijeJs+62JOAg+acQ8Qgs7gDiHH9BCNYvFbMVxuQTjVvqgwPkeP+g==
X-Received: by 10.98.77.2 with SMTP id a2mr22539526pfb.213.1524546456242;
        Mon, 23 Apr 2018 22:07:36 -0700 (PDT)
Received: from localhost ([2601:602:9500:1120:3dfa:3e1b:ab89:1ffb])
        by smtp.gmail.com with ESMTPSA id r75sm32268567pfb.98.2018.04.23.22.07.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Apr 2018 22:07:35 -0700 (PDT)
Date:   Mon, 23 Apr 2018 22:07:34 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, gitster@pobox.com, l.s.r@web.de,
        martin.agren@gmail.com, peff@peff.net, sunshine@sunshineco.com
Subject: [PATCH v3 0/7] Teach '--column-number' to 'git-grep(1)'
Message-ID: <cover.1524545768.git.me@ttaylorr.com>
References: <20180421034530.GB24606@syl.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180421034530.GB24606@syl.local>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Attached is v3 of my series to teach '--column-numbers' to 'git-grep(1)'.

Since last time, I have:

  * Removed '-m' in a few places that I forgot to during v2 [1] [2].

  * Expanded upon the definition of '--column-number' in 'git grep
    --help'. [3]

  * Initialized some new fields in grep_opt to 0 that would be avoided
    by memset(). [4]

  * Block comment to indicate the desired use of 'cno' in grep.c's
    'show_line()' [5], [6].

  * Annotated the new tests with the permutation that they are testing.

The most notable change since last time is reorganizing the series to
match Eric's suggestion, which I hope makes the reviewing experience a
little easier. I will strive to apply these lessons in future series.

Little has changed on the implementation front since v2, so I think that
the most outstanding further discussion will be centered around --column
vs --column-number. I have posted some thoughts about that in [7].

Thanks as always for your review :-).


Thanks,
Taylor

[1]: https://public-inbox.org/git/878t9eewu2.fsf@evledraar.gmail.com
[2]: https://public-inbox.org/git/877eoyewss.fsf@evledraar.gmail.com
[3]: https://public-inbox.org/git/878t9eewu2.fsf@evledraar.gmail.com
[4]: https://public-inbox.org/git/CAPig+cRXkSrPHPyEEhp6_ndRBNW3hE7HkspSk1atPSE5pn_sMw@mail.gmail.com
[5]: https://public-inbox.org/git/CAPig+cQ2+wTTXE0mhnGnp2pZug=Po0SCVwCO_2agxUDaOsFRLw@mail.gmail.com
[6]: https://public-inbox.org/git/CAPig+cR0unM2uKcapHyAFrvMyPx4VgsW4wDswb_GNwE4EcYb8Q@mail.gmail.com
[7]: https://public-inbox.org/git/20180424043140.GA82406@syl.local

Taylor Blau (7):
  Documentation/config.txt: camel-case lineNumber for consistency
  grep.c: expose matched column in match_line()
  grep.[ch]: extend grep_opt to allow showing matched column
  grep.c: display column number of first match
  builtin/grep.c: add '--column-number' option to 'git-grep(1)'
  grep.c: add configuration variables to show matched option
  contrib/git-jump/git-jump: jump to match column in addition to line

 Documentation/config.txt   |  7 ++++++-
 Documentation/git-grep.txt |  8 +++++++-
 builtin/grep.c             |  1 +
 contrib/git-jump/git-jump  |  2 +-
 grep.c                     | 39 +++++++++++++++++++++++++++++---------
 grep.h                     |  2 ++
 t/t7810-grep.sh            | 22 +++++++++++++++++++++
 7 files changed, 69 insertions(+), 12 deletions(-)

Inter-diff (since v2):

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 1645fcf2ae..8a2893d1e1 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1711,7 +1711,7 @@ grep.lineNumber::
 	If set to true, enable `-n` option by default.

 grep.columnNumber::
-	If set to true, enable `-m` option by default.
+	If set to true, enable the `--column-number` option by default.

 grep.patternType::
 	Set the default matching behavior. Using a value of 'basic', 'extended',
diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index b75a039768..c5c4d712e6 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -45,7 +45,7 @@ grep.lineNumber::
 	If set to true, enable `-n` option by default.

 grep.columnNumber::
-	If set to true, enable `-m` option by default.
+	If set to true, enable the `--column-number` option by default.

 grep.patternType::
 	Set the default matching behavior. Using a value of 'basic', 'extended',
diff --git a/builtin/grep.c b/builtin/grep.c
index 23ce97f998..512f60c591 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -829,7 +829,7 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 			    GREP_PATTERN_TYPE_PCRE),
 		OPT_GROUP(""),
 		OPT_BOOL('n', "line-number", &opt.linenum, N_("show line numbers")),
-		OPT_BOOL(0, "column-number", &opt.columnnum, N_("show column numbers")),
+		OPT_BOOL(0, "column-number", &opt.columnnum, N_("show column number of first match")),
 		OPT_NEGBIT('h', NULL, &opt.pathname, N_("don't show filenames"), 1),
 		OPT_BIT('H', NULL, &opt.pathname, N_("show filenames"), 1),
 		OPT_NEGBIT(0, "full-name", &opt.relative,
diff --git a/contrib/git-jump/git-jump b/contrib/git-jump/git-jump
index 2706963690..8bc57ea0f8 100755
--- a/contrib/git-jump/git-jump
+++ b/contrib/git-jump/git-jump
@@ -52,7 +52,7 @@ mode_merge() {
 # editor shows them to us in the status bar.
 mode_grep() {
 	cmd=$(git config jump.grepCmd)
-	test -n "$cmd" || cmd="git grep -n -m"
+	test -n "$cmd" || cmd="git grep -n --column-number"
 	$cmd "$@" |
 	perl -pe '
 	s/[ \t]+/ /g;
diff --git a/grep.c b/grep.c
index 23250e60d0..7284dec155 100644
--- a/grep.c
+++ b/grep.c
@@ -46,6 +46,7 @@ void init_grep_defaults(void)
 	color_set(opt->color_filename, "");
 	color_set(opt->color_function, "");
 	color_set(opt->color_lineno, "");
+	color_set(opt->color_columnno, "");
 	color_set(opt->color_match_context, GIT_COLOR_BOLD_RED);
 	color_set(opt->color_match_selected, GIT_COLOR_BOLD_RED);
 	color_set(opt->color_selected, "");
@@ -1404,6 +1405,11 @@ static void show_line(struct grep_opt *opt, char *bol, char *eol,
 		output_color(opt, buf, strlen(buf), opt->color_lineno);
 		output_sep(opt, sign);
 	}
+	/**
+	 * Treat 'cno' as the 1-indexed offset from the start of a non-context
+	 * line to its first match. Otherwise, 'cno' is 0 indicating that we are
+	 * being called with a context line.
+	 */
 	if (opt->columnnum && cno) {
 		char buf[32];
 		xsnprintf(buf, sizeof(buf), "%d", cno);
diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
index 7349c7fadc..bbce57c8b1 100755
--- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -99,7 +99,7 @@ do
 		test_cmp expected actual
 	'

-	test_expect_success "grep -w $L" '
+	test_expect_success "grep -w $L (with --column-number)" '
 		{
 			echo ${HC}file:5:foo mmap bar
 			echo ${HC}file:14:foo_mmap bar mmap
@@ -110,7 +110,7 @@ do
 		test_cmp expected actual
 	'

-	test_expect_success "grep -w $L" '
+	test_expect_success "grep -w $L (with --{line,column}-number)" '
 		{
 			echo ${HC}file:1:5:foo mmap bar
 			echo ${HC}file:3:14:foo_mmap bar mmap

--
2.17.0

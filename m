Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13827C38A2D
	for <git@archiver.kernel.org>; Sat, 22 Oct 2022 01:20:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbiJVBU0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Oct 2022 21:20:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbiJVBUW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2022 21:20:22 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CE6212B34A
        for <git@vger.kernel.org>; Fri, 21 Oct 2022 18:20:16 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 7C62F5C00A8;
        Fri, 21 Oct 2022 21:20:15 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Fri, 21 Oct 2022 21:20:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mcclimon.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1666401615; x=1666488015; bh=kU
        fW5qgtEQf0TbHLNqjiV6zEYSOeR1qSLQ0AWWfJ5eY=; b=D1OiNOcFmVGBiNb33u
        wJi9DZ4Mbjfo6K9G4xUqCnPvHQ3tfnFLtX01mnZN3782U4blPCICj34ADv4udLc0
        7DJmdGH+bhFBnW+u331rZgKkXzkCYdobidYS5dP0uaATa3TLBKtybPbgzcP8mujd
        xvSV3hVOK6Xm5hCJKIHNWzqrPx+glSnsRxuzEMGznshg5unv/8jxVjXORS7SiYeH
        zi6WupfiyLd8gLhHwmlBG/FamgchCMXCEKpmctSBg1/vMkfB0eGoxXWaCtw2OCaE
        U1xX/8WFzvLc4AnDDEge1ZhxHZ/v2eESTV2r3uBapj9vbBTKCuy1OOz3SZ3mXkbn
        9/og==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1666401615; x=1666488015; bh=kUfW5qgtEQf0T
        bHLNqjiV6zEYSOeR1qSLQ0AWWfJ5eY=; b=FXcuWuKN9HzU1sR19lmVzegMz1ZvH
        z78UF8vcMcawOBdM3yArlDlIeewgbhhrsRUABENoH4XzsKnjoVDkGFKhoJVpBw/B
        H1NGmdEbWPeWz10Je0/3WYtFjMfc6yyL7lofUa0w1kKAsyQc00FJSPh9OZ4fyJ+W
        Xr/+EhAllcTpB5SLXjbq/ctAyeReVh7r2oZnGTxCeRp/m4EV7Dqjhzyc2FuzVa6x
        iJWtSs7YEFWCadAuk76UT7c1eU6pArhS/R96MseDwbKEMEO0tWuHYFP0wXUKC8UX
        x0dcnhbtJenxtb+l/KFvn8oYOPnu2Kr9IiCQjj6QxVeXvtClKIFUM17cQ==
X-ME-Sender: <xms:T0VTY4myZHXcYApkKaDmTx6NEZvcjsuhS4xMFRszQImrI2hTXGP3lw>
    <xme:T0VTY302iSDxgNgLp8ze1Z7R3MpsNoJ3Hf77ubJvXh16aJRFskjtJDZdvyBe8w5n1
    ZZKSagIK5rf2PTZ1Ag>
X-ME-Received: <xmr:T0VTY2rZ_Lkypz441DeDaKxV_YuogFFUgdSqCLfIewO_fuXUccU4KBWvzRqy2tW5eU6vsIlkGM2RqmyBOn5kCUF-ojYoSdvO-OSw1j6K4r6m>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeelledgfeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpefoihgthhgrvghlucfotgevlhhimhhonhcuoehmihgthhgr
    vghlsehmtggtlhhimhhonhdrohhrgheqnecuggftrfgrthhtvghrnhepveegfeelffdufe
    eiudelieevhfehudelveegvdeltdegtdfgvedugfeuffduhfelnecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhhitghhrggvlhesmhgttghlih
    hmohhnrdhorhhg
X-ME-Proxy: <xmx:T0VTY0k6mfrGYJ1lZWxpKi7Q5rJKPCWjPtk3J6lIPHeogygu1nJ9yQ>
    <xmx:T0VTY20rK6P0QbjdmIk-ws2CHpZ9cl3_AzPBVUMjwkUr6UKzhUPQ-g>
    <xmx:T0VTY7sHyFHPuFFuHyI3W10c31s0OpL7AR0XrMvTt0TXgUAGIO4fjg>
    <xmx:T0VTY7_5P2-hPt7Fo0YChPoqHVvOznRvtKXbdGfGFzLPr2N8uzmBAQ>
Feedback-ID: i9dc944d1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 21 Oct 2022 21:20:15 -0400 (EDT)
From:   Michael McClimon <michael@mcclimon.org>
To:     git@vger.kernel.org
Cc:     Michael McClimon <michael@mcclimon.org>
Subject: [PATCH v2 2/2] setup: allow Git.pm to do unsafe repo checking
Date:   Fri, 21 Oct 2022 21:19:32 -0400
Message-Id: <20221022011931.43992-3-michael@mcclimon.org>
X-Mailer: git-send-email 2.38.1.130.g45c9f05c
In-Reply-To: <20221022011931.43992-1-michael@mcclimon.org>
References: <20221016212236.12453-1-michael@mcclimon.org>
 <20221022011931.43992-1-michael@mcclimon.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The previous commit exposes a security flaw: it is possible to bypass
unsafe repository checks by using Git.pm, where before the syntax error
accidentally prohibited it. This problem occurs because Git.pm sets
GIT_DIR explicitly, which bypasses the safe repository checks.

Fix this by introducing a new environment variable,
GIT_PERL_FORCE_OWNERSHIP_CHECK, which we set true in Git.pm. In setup.c,
if that environment variable is true, force ownership checks even if
an explicit GIT_DIR is provided.

Signed-off-by: Michael McClimon <michael@mcclimon.org>
---
 perl/Git.pm         |  1 +
 setup.c             |  3 +++
 t/t9700-perl-git.sh |  4 ++++
 t/t9700/test.pl     | 18 ++++++++++++++++++
 4 files changed, 26 insertions(+)

diff --git a/perl/Git.pm b/perl/Git.pm
index cf15ead6..002c29bb 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -1674,6 +1674,7 @@ sub _cmd_exec {
 sub _setup_git_cmd_env {
 	my $self = shift;
 	if ($self) {
+		$ENV{GIT_PERL_FORCE_OWNERSHIP_CHECK} = 1;
 		$self->repo_path() and $ENV{'GIT_DIR'} = $self->repo_path();
 		$self->repo_path() and $self->wc_path()
 			and $ENV{'GIT_WORK_TREE'} = $self->wc_path();
diff --git a/setup.c b/setup.c
index cefd5f63..33d4e6fd 100644
--- a/setup.c
+++ b/setup.c
@@ -1250,6 +1250,9 @@ static enum discovery_result setup_git_directory_gently_1(struct strbuf *dir,
 	 */
 	gitdirenv = getenv(GIT_DIR_ENVIRONMENT);
 	if (gitdirenv) {
+		if (git_env_bool("GIT_PERL_FORCE_OWNERSHIP_CHECK", 0) &&
+		    !ensure_valid_ownership(NULL, NULL, gitdirenv, report))
+			return GIT_DIR_INVALID_OWNERSHIP;
 		strbuf_addstr(gitdir, gitdirenv);
 		return GIT_DIR_EXPLICIT;
 	}
diff --git a/t/t9700-perl-git.sh b/t/t9700-perl-git.sh
index 4aa5d90d..b14a40b1 100755
--- a/t/t9700-perl-git.sh
+++ b/t/t9700-perl-git.sh
@@ -45,6 +45,10 @@ test_expect_success \
      git config --add test.pathmulti bar
      '
 
+test_expect_success 'set up bare repository' '
+     git init --bare bare.git
+'
+
 test_expect_success 'use t9700/test.pl to test Git.pm' '
 	"$PERL_PATH" "$TEST_DIRECTORY"/t9700/test.pl 2>stderr &&
 	test_must_be_empty stderr
diff --git a/t/t9700/test.pl b/t/t9700/test.pl
index e046f7db..1c91019f 100755
--- a/t/t9700/test.pl
+++ b/t/t9700/test.pl
@@ -142,6 +142,24 @@ sub adjust_dirsep {
 		     "abc\"\\ \x07\x08\x09\x0a\x0b\x0c\x0d\x01 ",
 		     'unquote escape sequences');
 
+# safe directory
+{
+	local $ENV{GIT_TEST_ASSUME_DIFFERENT_OWNER} = 1;
+	# Save stderr to a tempfile so we can check the contents
+	open our $tmpstderr2, ">&STDERR" or die "cannot save STDERR";
+	my $tmperr = "unsafeerr.tmp";
+	open STDERR, ">", "$tmperr" or die "cannot redirect STDERR to $tmperr";
+	my $failed = eval { Git->repository(Directory => "$abs_repo_dir/bare.git") };
+	ok(!$failed, "reject unsafe repository");
+	like($@, qr/not a git repository/i, "unsafe error message");
+	open TEMPFILE, "<", "$tmperr" or die "Can't open $tmperr $!";
+	my $errcontents;
+	{ local $/; $errcontents = <TEMPFILE>; }
+	like($errcontents, qr/dubious ownership/, "dubious ownership message");
+	close STDERR or die "cannot close temp stderr";
+	open STDERR, ">&", $tmpstderr2 or die "cannot restore STDERR";
+}
+
 printf "1..%d\n", Test::More->builder->current_test;
 
 my $is_passing = eval { Test::More->is_passing };
-- 
2.38.1.130.g45c9f05c


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 373251F404
	for <e@80x24.org>; Sun, 25 Mar 2018 18:29:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753948AbeCYS3A (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Mar 2018 14:29:00 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:41937 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753703AbeCYS2e (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Mar 2018 14:28:34 -0400
Received: by mail-wr0-f194.google.com with SMTP id f14so16702128wre.8;
        Sun, 25 Mar 2018 11:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vMCTmlY+RkpWk/4Fg/80G2Eqe0+8KkEHQkPhEsjNjQc=;
        b=TnzRVx6SSzKD68Modeu4EYePDx7XQ0+IdEdOtEXVIwy8ev1BjFy7GYRZNWXezk4sxf
         MOjAS9rhRE+QMMnWhUhjWQbFZIj2FQ4a/38Gni740yyifSsJVrFB1WtVcY9jctx+ncF5
         /lqHuerIwJHLCoB4UGupkWPeubkt8ChUaHwTEsXin0emMSs5e2lhQzXiAinGnstoej3/
         dzm7kw+Mv6rs4aj81EcaHjmkxaD1UEk9k5L7mxDG2x79cORb7adD7dhTF1/FbqP4Z8OR
         WtYMgtrevfs59Y2XiMspp61DFOT+onuxmlZvUtFNxAqd/Zsz6ZgC/7hlhRFyuFvwRslG
         lWJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vMCTmlY+RkpWk/4Fg/80G2Eqe0+8KkEHQkPhEsjNjQc=;
        b=Ew5Ilo68PiqPPO6Ct1oAEllR/9LAPoHWaVmuw2drujg7pw49HOe3OFoR5VOsyPuMFD
         HCeA1C0nMUBajIEtoA4ct000QRLikXzFtl9ccsDAIU1hW64AaxsLhiWS+k7Tn8bzjjtl
         9nBHW4I2qhtUHEkGpL9tp5qJpKbZUB8VWBgWgFKCyttJDzBdSJk9Q3o1K1piHATYpBzD
         aRuTpMzqzdyC4aNCeOyS1dA7N899pw0LskUh5x/5ioVj1wBmGzod5WHGpEHC+OXCqjvm
         itX7ADyVwhYDSYKQNUtBVfqnT2yAvTalHSfNjggfz0OY16cc4+BaAG6tWMiE6yuUeT8W
         JdLw==
X-Gm-Message-State: AElRT7HVK1ZBI9JQ0YidgWmvyetL2PZy2x/3cfoqp/O8YFNjxLgDgNVV
        8X2E5m6opcghM1yP55qitJnYmY6q
X-Google-Smtp-Source: AG47ELu+YJQcB5EXyxiDegBBKt76ApEwI6yK4Z0cMaJ7JchSNYKpG0FV2eUV14h8yjBdngoiN7N9lA==
X-Received: by 10.223.185.25 with SMTP id k25mr26792589wrf.237.1522002512966;
        Sun, 25 Mar 2018 11:28:32 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id x10sm14451762wrc.64.2018.03.25.11.28.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 25 Mar 2018 11:28:32 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/2] send-email: add an option to impose delay sent E-Mails
Date:   Sun, 25 Mar 2018 18:28:02 +0000
Message-Id: <20180325182803.30036-2-avarab@gmail.com>
X-Mailer: git-send-email 2.17.0.rc1.37.g46b2b28759
In-Reply-To: <20180325182803.30036-1-avarab@gmail.com>
References: <20180325182803.30036-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer-Send-Delay: 1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a --send-delay option with a corresponding sendemail.smtpSendDelay
configuration variable. When set to e.g. 2, this causes send-email to
sleep 2 seconds before sending the next E-Mail. We'll only sleep
between sends, not before the first send, or after the last.

This option is useful because certain popular E-Mail clients
completely ignore the "Date" header, which format-patch is careful to
set such that the patches will be displayed in order, and instead sort
by the time the E-mail was received.

Google's GMail is a good example of such a client. It ostensibly sorts
by some approximation of received time (although not by any "Received"
header). It's more usual than not to see patches showing out of order
in GMail. To take a few examples of orders seen on recent patches on
the Git mailing list:

    1 -> 3 -> 4 -> 2 -> 8 -> 7 (completion by Nguyễn Thái Ngọc Duy)
    2 -> 0 -> 1 -> 3 (pack search by Derrick Stolee)
    3 -> 2 -> 1 (fast-import by Jameson Miller)
    2 -> 3 -> 1 -> 5 -> 4 -> 6 (diff-highlight by Jeff King)

My own patches to Git are always in order because this bothers me
enough that I never use the "all" option to send-email, instead I wait
a second and manually type "y" for each one, so I have years of
anecdotal data showing that this works with GMail. This new option
will allow me to set a config to do what I've been doing manually.

I've also noticed that E-Mail from some other contributors tends to be
in order, e.g. Michael Haggerty's usually are. When I asked him about
he just uses the "all" option, but digging further revealed that the
details of his mail routing were imposing a similar delay, so his
mails similarly arrived at Google with some delay.

The reason to add the new "X-Mailer-Send-Delay" header is to make it
easy to tell what the imposed delay was, if any. A subsequent change
will seek to make this option the default, being able to see from the
headers how long the sleep was.

The reason for why the getopt format is "send-delay=s" instead of
"send-delay=d" is because we're doing manual validation of the value
we get passed, which getopt would corrupt in cases of e.g. float
values before we could show a sensible error message.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/config.txt         |  6 ++++
 Documentation/git-send-email.txt |  4 +++
 git-send-email.perl              | 14 ++++++--
 t/t9001-send-email.sh            | 55 ++++++++++++++++++++++++++++++++
 4 files changed, 77 insertions(+), 2 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index ce9102cea8..f155d349c0 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -3068,6 +3068,12 @@ sendemail.smtpReloginDelay::
 	Seconds wait before reconnecting to smtp server.
 	See also the `--relogin-delay` option of linkgit:git-send-email[1].
 
+sendemail.smtpSendDelay::
+	Seconds wait in between message sending before sending another
+	message. Set it to 0 to impose no extra delay, defaults to 0.
++
+See also the `--send-delay` option of linkgit:git-send-email[1].
+
 showbranch.default::
 	The default set of branches for linkgit:git-show-branch[1].
 	See linkgit:git-show-branch[1].
diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index 71ef97ba9b..169ad78a2b 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -268,6 +268,10 @@ must be used for each option.
 	with --batch-size option.  Defaults to the `sendemail.smtpReloginDelay`
 	configuration variable.
 
+--send-delay=<int>::
+	Wait $<int> between sending emails. Defaults to the
+	`sendemail.smtpSendDelay` configuration variable.
+
 Automating
 ~~~~~~~~~~
 
diff --git a/git-send-email.perl b/git-send-email.perl
index 2fa7818ca9..013277ede2 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -89,6 +89,7 @@ git send-email --dump-aliases
     --batch-size            <int>  * send max <int> message per connection.
     --relogin-delay         <int>  * delay <int> seconds between two successive login.
                                      This option can only be used with --batch-size
+    --send-delay            <int>  * ensure that <int> seconds pass between two successive sends.
 
   Automating:
     --identity              <str>  * Use the sendemail.<id> options.
@@ -225,7 +226,7 @@ my ($cover_cc, $cover_to);
 my ($to_cmd, $cc_cmd);
 my ($smtp_server, $smtp_server_port, @smtp_server_options);
 my ($smtp_authuser, $smtp_encryption, $smtp_ssl_cert_path);
-my ($batch_size, $relogin_delay);
+my ($batch_size, $relogin_delay, $send_delay);
 my ($identity, $aliasfiletype, @alias_files, $smtp_domain, $smtp_auth);
 my ($validate, $confirm);
 my (@suppress_cc);
@@ -259,6 +260,7 @@ my %config_settings = (
     "smtpauth" => \$smtp_auth,
     "smtpbatchsize" => \$batch_size,
     "smtprelogindelay" => \$relogin_delay,
+    "smtpsenddelay" => \$send_delay,
     "to" => \@initial_to,
     "tocmd" => \$to_cmd,
     "cc" => \@initial_cc,
@@ -373,6 +375,7 @@ $rc = GetOptions(
 		    "no-xmailer" => sub {$use_xmailer = 0},
 		    "batch-size=i" => \$batch_size,
 		    "relogin-delay=i" => \$relogin_delay,
+		    "send-delay=s" => \$send_delay,
 	 );
 
 usage() if $help;
@@ -484,6 +487,8 @@ if ($confirm_unconfigured) {
 };
 die sprintf(__("Unknown --confirm setting: '%s'\n"), $confirm)
 	unless $confirm =~ /^(?:auto|cc|compose|always|never)/;
+die sprintf(__("Invalid --send-delay setting: '%s'\n"), $send_delay)
+	if defined $send_delay and $send_delay !~ /^[0-9]+$/s;
 
 # Debugging, print out the suppressions.
 if (0) {
@@ -1552,7 +1557,8 @@ $references = $initial_in_reply_to || '';
 $subject = $initial_subject;
 $message_num = 0;
 
-foreach my $t (@files) {
+foreach my $i (0 .. $#files) {
+	my $t = $files[$i];
 	open my $fh, "<", $t or die sprintf(__("can't open file %s"), $t);
 
 	my $author = undef;
@@ -1732,6 +1738,10 @@ foreach my $t (@files) {
 	if (defined $xfer_encoding or $has_content_type) {
 		unshift @xh, 'MIME-Version: 1.0' unless $has_mime_version;
 	}
+	if ($send_delay && $i > 0) {
+		push @xh, "X-Mailer-Send-Delay: $send_delay";
+		sleep $send_delay;
+	}
 
 	$needs_confirm = (
 		$confirm eq "always" or
diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index e80eacbb1b..fafa61c5d6 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -1702,6 +1702,61 @@ test_expect_success '--dump-aliases must be used alone' '
 	test_must_fail git send-email --dump-aliases --to=janice@example.com -1 refs/heads/accounting
 '
 
+test_expect_success '--send-delay expects whole non-negative seconds' '
+	test_must_fail git send-email --send-delay=-1 HEAD~ 2>errors &&
+	test_i18ngrep "Invalid --send-delay setting" errors &&
+	test_must_fail git send-email --send-delay=1.5 HEAD~ 2>errors &&
+	test_i18ngrep "Invalid --send-delay setting" errors &&
+	test_must_fail git -c sendemail.smtpSendDelay=-1 send-email HEAD~ 2>errors &&
+	test_i18ngrep "Invalid --send-delay setting" errors &&
+	test_must_fail git -c sendemail.smtpSendDelay=1.5 send-email HEAD~ 2>errors &&
+	test_i18ngrep "Invalid --send-delay setting" errors
+'
+
+test_expect_success $PREREQ "there is no default --send-delay" '
+	clean_fake_sendmail &&
+	rm -fr outdir &&
+	git format-patch -3 -o outdir &&
+	git send-email \
+		--from="Example <nobody@example.com>" \
+		--to=nobody@example.com \
+		--smtp-server="$(pwd)/fake.sendmail" \
+		outdir/*.patch \
+		2>stderr >stdout &&
+	test $(grep -c "X-Mailer:" stdout) = 3 &&
+	test $(grep -c "X-Mailer-Send-Delay:" stdout) = 0
+'
+
+test_expect_success $PREREQ '--send-delay adds a X-Mailer-Send-Delay header to affected E-Mails' '
+	clean_fake_sendmail &&
+	rm -fr outdir &&
+	git format-patch -3 -o outdir &&
+	git send-email \
+		--from="Example <nobody@example.com>" \
+		--to=nobody@example.com \
+		--smtp-server="$(pwd)/fake.sendmail" \
+		--send-delay=2 \
+		outdir/*.patch \
+		2>stderr >stdout &&
+	test $(grep -c "X-Mailer:" stdout) = 3 &&
+	test $(grep -c "X-Mailer-Send-Delay:" stdout) = 2
+'
+
+test_expect_success $PREREQ '--send-delay=0 disables any imposed delay on E-Mail sending' '
+	clean_fake_sendmail &&
+	rm -fr outdir &&
+	git format-patch -3 -o outdir &&
+	git -c sendemail.smtpSendDelay=3 send-email \
+		--from="Example <nobody@example.com>" \
+		--to=nobody@example.com \
+		--smtp-server="$(pwd)/fake.sendmail" \
+		--send-delay=0 \
+		outdir/*.patch \
+		2>stderr >stdout &&
+	test $(grep -c "X-Mailer:" stdout) = 3 &&
+	test $(grep -c "X-Mailer-Send-Delay:" stdout) = 0
+'
+
 test_sendmail_aliases () {
 	msg="$1" && shift &&
 	expect="$@" &&
-- 
2.16.2.804.g6dcf76e118


Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08FF6C433F5
	for <git@archiver.kernel.org>; Fri, 22 Apr 2022 08:36:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1445562AbiDVIjj (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Apr 2022 04:39:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1445547AbiDVIjh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Apr 2022 04:39:37 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B05A0532CA
        for <git@vger.kernel.org>; Fri, 22 Apr 2022 01:36:41 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 7C66F3204C77;
        Fri, 22 Apr 2022 04:36:40 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 22 Apr 2022 04:36:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alyssa.is; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1650616599; x=
        1650702999; bh=rNpC09SMmblo5NdmZLY9RnMQ/NhHiXSPYi+cy5egrIU=; b=r
        f1jZ8xXpVNzZ2l1tKHlD7euJAP6Y1BO9Xg2JvXBsjOGBLIBKYbVGeXMFnn1f4IBa
        nthza3U5IHViaWS88om55BTQfuHdH+mKHZ0egIckMlW/f9qguVMvb5FSRwvXzYt7
        /oFEIxFmSKn2+smDewyTcT7EJK2e/8DGp7jNtdf2yKEWQ/vWCjtlG1+f+fH6MRBr
        lbYui7IslyIt6X0grOkKyXPaV9ng2avcB560I/jTmI7/Ttao18eIqbYUrHcORIuS
        tKj6VZF3mdZN08LX6+t/Du463FJ52DTuXoCdJsOHGzYfKoWc8/tP63zsubXXQgwE
        4mEPUDozu98ON32Kz6NsA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1650616599; x=1650702999; bh=rNpC09SMmblo5
        NdmZLY9RnMQ/NhHiXSPYi+cy5egrIU=; b=iDU8xbQrlU5Hy9ExjP8gAJ/MBqTeP
        bShDAKf+O9S5Tb9NE/cRHSxe0HIkKHgrjm8nDLbAW0zoVOlqDhRpE1EU+0OYeZOM
        2QQu46o8RtGJgJ25NPk+u2agMZ8QZ89c7DDY/2VQUcRMlSJkgvmbGGlRtEKREWYA
        fb44CwKnpr2SAViazzrrngzcXj/9Zf9sEWcoAwwcp8ycPdzXXoZ17hDLYpQW6ZZ6
        1NVmLF4kNrTRGOThbpX79O1t+4XzAltgPazLTOZ7lYaDUXfspHA3c9feIyGxAuvt
        nglInm8OFBvjZfB47/WvEcHRCXpEMzt/WM8r3+4ChVE3/U5mPeqfEnJ5A==
X-ME-Sender: <xms:F2liYh3zWbEjjccx7gh7UMu6u3ITjJY9oPW5JY7aUNW7bvJzMk-qpQ>
    <xme:F2liYoGtauA2A0jj9G9No6D_p99p58iTriwpf5qwpmEPjJuzMMOD9MGMKrQ0BUnZG
    T0BwshPAlhuYFuGVQ>
X-ME-Received: <xmr:F2liYh4emi2tm3G0p37Z1Z7NeKqPTlpvx77Z_h9tNze7c25kwyELS4049t21MfkIw_qbi7Ip-PRiToUPRj1LR56g1o9egbA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrtdeggddtgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhggtgfgsehtke
    ertdertdejnecuhfhrohhmpeetlhihshhsrgcutfhoshhsuceohhhisegrlhihshhsrgdr
    ihhsqeenucggtffrrghtthgvrhhnpeelfeeufeefheeitedtveelleduhfehgefhleelgf
    fgffffledvvdeiudetledvfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpehqhihlihhsshesvghvvgdrqhihlhhishhsrdhnvght
X-ME-Proxy: <xmx:F2liYu0yOe79NvubYZ-VshAEvRY9hwyvDNa-r8LY7yuZHNFVVygrYw>
    <xmx:F2liYkFh24a18id-UNUnHMUet7lC_HBdpWTjVQBDWusieaq6svJ9Nw>
    <xmx:F2liYv9qmwvqVOZSXKo0wFeu7sUScrV27hAga2sogcxBb3Uulov_Cg>
    <xmx:F2liYuPOmOZ8B3A2q9buBiRnSx412HITTDeqDmklKIXfW3wYoLQUOA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 22 Apr 2022 04:36:39 -0400 (EDT)
Received: by eve.qyliss.net (Postfix, from userid 1000)
        id 92C0F31B; Fri, 22 Apr 2022 08:36:38 +0000 (UTC)
From:   Alyssa Ross <hi@alyssa.is>
To:     git@vger.kernel.org,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Alyssa Ross <hi@alyssa.is>
Subject: [PATCH] send-email: always confirm by default
Date:   Fri, 22 Apr 2022 08:36:29 +0000
Message-Id: <20220422083629.1404989-1-hi@alyssa.is>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <220421.86tuam5hoi.gmgdl@evledraar.gmail.com>
References: <220421.86tuam5hoi.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

For novice users, it can be very intimidating for git send-email to send
off a lot of mail without prompting for confirmation.  These users are
likely to not know it's even possible to configure git to behave
differently.  So let's set a novice-friendly default — expert users who
don't need to be prompted every time will be able to set
sendemail.confirm to their preference, although from my small sample it
sounds plenty of expert users already rely on sendemail.confirm =
always.

I think this is a better idea than defaulting to --dry-run, because
having to specify on the command line that you _really_ want to send the
patches now would mean the --no-dry-run version would quickly end up
being replayed unthinkingly from shell history, and because always
confirming has the nice side effect of making it easy to add patch
commentary.

I also think this approach is better than forbidding the all-in-one
format-patch + send-email, because it wouldn't give an accurate preview
of recipients, because automatic CCs are added by send-email, not
format-patch.  Additionally, teaching git send-email is hard enough
without having to also teach format-patch, and to make sure to clean up
afterwards, etc!

Signed-off-by: Alyssa Ross <hi@alyssa.is>
---

[[ Whoops, sent to the list this time! ]]

Ævar, thanks for encouraging me to send a patch.  At your suggestion,
I've trawled through the list archives looking for any previous
discussion of this default, but I didn't find anything.

 Documentation/git-send-email.txt |  3 +--
 git-send-email.perl              |  2 +-
 t/t9001-send-email.sh            | 14 ++++----------
 3 files changed, 6 insertions(+), 13 deletions(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index 41cd8cb424..b791d83bb7 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -407,8 +407,7 @@ Administering
 --
 +
 Default is the value of `sendemail.confirm` configuration value; if that
-is unspecified, default to 'auto' unless any of the suppress options
-have been specified, in which case default to 'compose'.
+is unspecified, default to 'always'.
 
 --dry-run::
 	Do everything except actually send the emails.
diff --git a/git-send-email.perl b/git-send-email.perl
index 5861e99a6e..4aa7d83cdc 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -606,7 +606,7 @@ sub config_regexp {
 # Set confirm's default value
 my $confirm_unconfigured = !defined $confirm;
 if ($confirm_unconfigured) {
-	$confirm = scalar %suppress_cc ? 'compose' : 'auto';
+	$confirm = 'always';
 };
 # Please update $__git_send_email_confirm_options in
 # git-completion.bash when you add new options.
diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 42694fe584..e11730f3dc 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -74,8 +74,8 @@ check_no_confirm () {
 	return 0
 }
 
-test_expect_success $PREREQ 'No confirm with --suppress-cc' '
-	test_no_confirm --suppress-cc=sob &&
+test_expect_success $PREREQ 'No confirm with --confirm=compose --suppress-cc' '
+	test_no_confirm --confirm=compose --suppress-cc=sob &&
 	check_no_confirm
 '
 
@@ -1032,16 +1032,10 @@ test_expect_success $PREREQ '--confirm=compose' '
 	test_confirm --confirm=compose --compose
 '
 
-test_expect_success $PREREQ 'confirm by default (due to cc)' '
+test_expect_success $PREREQ 'confirm by default' '
 	test_when_finished git config sendemail.confirm never &&
 	git config --unset sendemail.confirm &&
-	test_confirm
-'
-
-test_expect_success $PREREQ 'confirm by default (due to --compose)' '
-	test_when_finished git config sendemail.confirm never &&
-	git config --unset sendemail.confirm &&
-	test_confirm --suppress-cc=all --compose
+	test_confirm --suppress-cc=all
 '
 
 test_expect_success $PREREQ 'confirm detects EOF (inform assumes y)' '

base-commit: 6cd33dceed60949e2dbc32e3f0f5e67c4c882e1e
-- 
2.35.1


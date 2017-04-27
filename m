Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D0DD1207E4
	for <e@80x24.org>; Thu, 27 Apr 2017 06:38:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751958AbdD0GiO (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Apr 2017 02:38:14 -0400
Received: from a7-11.smtp-out.eu-west-1.amazonses.com ([54.240.7.11]:33308
        "EHLO a7-11.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751191AbdD0GiM (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 27 Apr 2017 02:38:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=shh3fegwg5fppqsuzphvschd53n6ihuv; d=amazonses.com; t=1493275080;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=gf+akqx9iR8gELPPBWOl1j7nvX2GVs1VG3mmf9u/ZlU=;
        b=YxIUdYQ0CZWnAvXxciNIhhm/PRUAXpfH8yaGHByFSnSkNrWhOKNqX7oeEVp5Tbuc
        t0I7Muo12K0QhWff1Pr/izAj6KS/Tp/kciXRS9z9LMckRf8ySHa4mnNbTNzIxevud5x
        OT5nZRHfvBDl9PwjaYkHf2q6yIXSAbhGAWFiLZIw=
From:   Sebastian Schuberth <sschuberth@gmail.com>
To:     git@vger.kernel.org
Message-ID: <0102015bae2176a2-8239cc7d-6510-4903-856b-e4fb0ef0cc71-000000@eu-west-1.amazonses.com>
In-Reply-To: <0102015aa974d7a6-46afa73b-4378-4b01-9db4-723fb9e41d65-000000@eu-west-1.amazonses.com>
References: <0102015aa974d7a6-46afa73b-4378-4b01-9db4-723fb9e41d65-000000@eu-west-1.amazonses.com>
Subject: [PATCH v2] git-gui--askpass: generalize the wording
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Thu, 27 Apr 2017 06:38:00 +0000
X-SES-Outgoing: 2017.04.27-54.240.7.11
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git-gui--askpass is not only used for SSH authentication, but also for
HTTPS. In that context it is confusing to only rfer to "OpenSSH", also
because another SSH client like PuTTY might be in use. So generalize
wording and also say which parent process, i.e. Git, requires
authentication.

Signed-off-by: Sebastian Schuberth <sschuberth@gmail.com>
---
 git-gui/git-gui--askpass | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/git-gui/git-gui--askpass b/git-gui/git-gui--askpass
index 4277f30..4e3f00d 100755
--- a/git-gui/git-gui--askpass
+++ b/git-gui/git-gui--askpass
@@ -2,7 +2,7 @@
 # Tcl ignores the next line -*- tcl -*- \
 exec wish "$0" -- "$@"
 
-# This is a trivial implementation of an SSH_ASKPASS handler.
+# This is a trivial implementation of an GIT_ASKPASS / SSH_ASKPASS handler.
 # Git-gui uses this script if none are already configured.
 
 package require Tk
@@ -12,7 +12,7 @@ set yesno  0
 set rc     255
 
 if {$argc < 1} {
-	set prompt "Enter your OpenSSH passphrase:"
+	set prompt "Enter your password / passphrase:"
 } else {
 	set prompt [join $argv " "]
 	if {[regexp -nocase {\(yes\/no\)\?\s*$} $prompt]} {
@@ -60,7 +60,7 @@ proc finish {} {
 	set ::rc 0
 }
 
-wm title . "OpenSSH"
+wm title . "Git Authentication"
 tk::PlaceWindow .
 vwait rc
 exit $rc

--
https://github.com/git/git/pull/195

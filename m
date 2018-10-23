Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4670A1F453
	for <e@80x24.org>; Tue, 23 Oct 2018 03:24:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727014AbeJWLpx (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Oct 2018 07:45:53 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:46315 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726438AbeJWLpx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Oct 2018 07:45:53 -0400
Received: by mail-yb1-f194.google.com with SMTP id o8-v6so17077357ybk.13
        for <git@vger.kernel.org>; Mon, 22 Oct 2018 20:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wBzkUbosDVdc0hsHVEsLzKHUSsypz6bIar83otzmKn8=;
        b=oNED74JRd2K+55akfP0ZyPJEHMktUAgSjbAMRoVhZ8mID6qcWFY+a/j/E+NjFENu9z
         mtp8KbAFlFMgtOkxCIBXrynXPWqud4g9JiuQH+7OHkWvWP6GEY1bKzP6+Hb3btbqHhah
         k23mHEycpECmcFxzryshqLCESDAAKxsaviPul0EN7nr0XAuRoLDNuvHX946QL65Bv2iM
         7duq062GnGcTfIJimaAXnfhK1Sgx2Sq2TZ/hV0BeOz65yeW8+vcoiJ0thxhIvAsp7A4Z
         oAP/Lvqnx9U9A1JAVUbZLVCTQf8hnz8tqn0goT5UYOeL5HSraz1mzqQ51fdA3riEke+Z
         rmyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wBzkUbosDVdc0hsHVEsLzKHUSsypz6bIar83otzmKn8=;
        b=S3LbYNgpHzxDKgJ8d0cEXslXcR3t3XdRo6pFdQ+G2od+PaZvlggsVDB0Sv24RMarDT
         PdTK1B6aly80Mu6Evvyb46ouOGaavYa7DMFdAAtfKrEVAvktqVR/DkSEbHqHYbqdaFGu
         c9izc/TF2EsEWDFbB7orpn1mpe7QG9VFuXCySBuCXq6pynqu2KNZYTy9ajrZ3O9YgQHz
         SYLCMU0mAgvUuDBWrIr0D5YHmwikYazzDuXyefD4E6Cv+eZpTpFRkI+FYb+QHLMYpm1E
         HbQDeLeOhniTfZtibObWYghPXGqtA8YNbNk5opD6wFgOfg9xgQu4qj15vM/avzTNg4dV
         IU+Q==
X-Gm-Message-State: AGRZ1gLp6DfeAkvOg7oIovfcfecFfRp5dkVUHelh7GsBoMytzMQuxK8B
        engPVS7YMmD35IA2CbWtN63Le5XV
X-Google-Smtp-Source: AJdET5dfYtsRHOmvnkCbg97dF/GUILnjlmWE3vvf1RDpcJrwq7UxrySzuZHngJqOpzLnncPiIHscjg==
X-Received: by 2002:a25:be41:: with SMTP id d1-v6mr4333989ybm.499.1540265068692;
        Mon, 22 Oct 2018 20:24:28 -0700 (PDT)
Received: from localhost.localdomain ([2605:a601:21d1:5200:620a:c230:ada8:3135])
        by smtp.gmail.com with ESMTPSA id k189-v6sm8580829ywf.37.2018.10.22.20.24.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 Oct 2018 20:24:28 -0700 (PDT)
From:   Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Joshua Watt <JPEWhacker@gmail.com>
Subject: [PATCH v3] send-email: explicitly disable authentication
Date:   Mon, 22 Oct 2018 22:24:25 -0500
Message-Id: <20181023032425.9608-1-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.19.1.543.g838de3e23.dirty
In-Reply-To: <20181022175248.3940-1-JPEWhacker@gmail.com>
References: <20181022175248.3940-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It can be necessary to disable SMTP authentication by a mechanism other
than sendemail.smtpuser being undefined. For example, if the user has
sendemail.smtpuser set globally but wants to disable authentication
locally in one repository.

--smtp-auth and sendemail.smtpauth now understand the value 'none' which
means to disable authentication completely, even if an authentication
user is specified.

The value 'none' is lower case to avoid conflicts with any RFC 4422
authentication mechanisms.

The user may also specify the command line argument --no-smtp-auth as a
shorthand for --smtp-auth=none

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 Documentation/git-send-email.txt | 7 ++++++-
 git-send-email.perl              | 8 ++++++--
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index 465a4ecbe..17993e3c9 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -190,7 +190,9 @@ $ git send-email --smtp-auth="PLAIN LOGIN GSSAPI" ...
 If at least one of the specified mechanisms matches the ones advertised by the
 SMTP server and if it is supported by the utilized SASL library, the mechanism
 is used for authentication. If neither 'sendemail.smtpAuth' nor `--smtp-auth`
-is specified, all mechanisms supported by the SASL library can be used.
+is specified, all mechanisms supported by the SASL library can be used. The
+special value 'none' maybe specified to completely disable authentication
+independently of `--smtp-user`
 
 --smtp-pass[=<password>]::
 	Password for SMTP-AUTH. The argument is optional: If no
@@ -204,6 +206,9 @@ or on the command line. If a username has been specified (with
 specified (with `--smtp-pass` or `sendemail.smtpPass`), then
 a password is obtained using 'git-credential'.
 
+--no-smtp-auth::
+	Disable SMTP authentication. Short hand for `--smtp-auth=none`
+
 --smtp-server=<host>::
 	If set, specifies the outgoing SMTP server to use (e.g.
 	`smtp.example.com` or a raw IP address).  Alternatively it can
diff --git a/git-send-email.perl b/git-send-email.perl
index 2be5dac33..a70679484 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -82,8 +82,11 @@ sub usage {
                                      Pass an empty string to disable certificate
                                      verification.
     --smtp-domain           <str>  * The domain name sent to HELO/EHLO handshake
-    --smtp-auth             <str>  * Space-separated list of allowed AUTH mechanisms.
+    --smtp-auth             <str>  * Space-separated list of allowed AUTH mechanisms, or
+                                     "none" to disable authentication.
                                      This setting forces to use one of the listed mechanisms.
+    --no-smtp-auth                   Disable SMTP authentication. Shorthand for
+                                     `--smtp-auth=none`
     --smtp-debug            <0|1>  * Disable, enable Net::SMTP debug.
 
     --batch-size            <int>  * send max <int> message per connection.
@@ -341,6 +344,7 @@ sub signal_handler {
 		    "smtp-debug:i" => \$debug_net_smtp,
 		    "smtp-domain:s" => \$smtp_domain,
 		    "smtp-auth=s" => \$smtp_auth,
+		    "no-smtp-auth" => sub {$smtp_auth = 'none'},
 		    "identity=s" => \$identity,
 		    "annotate!" => \$annotate,
 		    "no-annotate" => sub {$annotate = 0},
@@ -1241,7 +1245,7 @@ sub smtp_host_string {
 # (smtp_user was not specified), and 0 otherwise.
 
 sub smtp_auth_maybe {
-	if (!defined $smtp_authuser || $auth) {
+	if (!defined $smtp_authuser || $auth || (defined $smtp_auth && $smtp_auth eq "none")) {
 		return 1;
 	}
 
-- 
2.19.1.543.g838de3e23.dirty


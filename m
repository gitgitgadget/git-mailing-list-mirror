Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BEA9F1F4F8
	for <e@80x24.org>; Wed, 21 Sep 2016 11:44:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933630AbcIULot (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Sep 2016 07:44:49 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35061 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933502AbcIULos (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Sep 2016 07:44:48 -0400
Received: by mail-wm0-f68.google.com with SMTP id 133so8117000wmq.2
        for <git@vger.kernel.org>; Wed, 21 Sep 2016 04:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0qF1HRInCdcaiI3f4oBY7H6sI4YGK9HVmAKSc6C595w=;
        b=HnPeTOuUoIdAz3Lv4RQrV4xqR04H5c5I/11s7OsrkH3zB7p6jSieUjqSpZaPsfPB9A
         hWA6Y2sOhDUa318HqOCRSDvZR5fk5Ps9el9sxSyGNgUDzUd3D2dlAv65NCQjew9Tb7QZ
         /ZKUcF+uupqMuI9UbF4Zv1f+j1HeCYqxviVR4e7RVQjMGDU+WiEBN7r7b37nSSq34Y6u
         RfPcPplO4c3Zpj1mePVGVoCS7QyQDem8INk+rwQqLwGGtXhs0pqj06cu6Ksncezof4l5
         Qg5G+AUwu+7NBnb1qi1oRiTYQ9MlWHR4099rfYlEyvsvBIK47/HGiLeG/7vzbarUCKWU
         ODWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0qF1HRInCdcaiI3f4oBY7H6sI4YGK9HVmAKSc6C595w=;
        b=B/Ta1ezvQ/JN/FmpPLbGAODYIZGkGmVrLoUUa6sKC0GX3q+wZTsccNNsJ4slxBRNIf
         hPDslc0xwZwpLNXnVJKnrBlIoPMZED9xPYthVDahUkG1lof/B7geN7J6pD+SRBXQk03K
         2IuhDLCalvXam2yQFMlH3/Citn6clCzeyQ1r5oZC/ft9Apt26abX8UplKMfkVej/U2Dk
         WMBbbe0yy0m4617oJkjrXlne/92UOYED47rTSM6t4ogPrI9oB+nyT9is6V3CULajrNxG
         YXGb9v405HQUle9ti/uxsVScnksx+KeR54mWCH4ZNeTw4bbZM2W/ICFcQAo4tEw1Vz1b
         RXjA==
X-Gm-Message-State: AE9vXwOoWpixoim13Um+9ULEtjrRLL2L4riONTjFVU6oXUEkMLdJBPvF2zbzM7blveni4A==
X-Received: by 10.28.19.194 with SMTP id 185mr2686494wmt.51.1474458286872;
        Wed, 21 Sep 2016 04:44:46 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id au10sm33165171wjc.12.2016.09.21.04.44.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 21 Sep 2016 04:44:46 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Kay Sievers <kay.sievers@suse.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 3/3] gitweb: Link to "git describe"'d commits in log messages
Date:   Wed, 21 Sep 2016 11:44:28 +0000
Message-Id: <20160921114428.28664-3-avarab@gmail.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20160921114428.28664-1-avarab@gmail.com>
References: <20160921114428.28664-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the log formatting function to know about "git describe" output
like v2.8.0-4-g867ad08 in addition to just plain 867ad08.

This also fixes a micro-regression in my change of the minimum SHA1
length from 8 to 7, which is that dated tags like
hadoop-20160921-113441-20-g094fb7d would start thinking the "20160921"
part was a commit.

There are still many valid refnames that we don't link to
e.g. v2.10.0-rc1~2^2~1 is also a valid way to refer to
v2.8.0-4-g867ad08, but I'm not supporting that with this commit,
similarly it's trivially possible to create some refnames like
"æ/var-gf6727b0" or whatever which won't be picked up by this regex.

There's surely room for improvement here, but I just wanted to address
the very common case of sticking "git describe" output into commit
messages without trying to link to all possible refnames, that's going
to be a rather futile exercise given that this is free text, and it
would be prohibitively expensive to look up whether the references in
question exist in our repository.
---
 gitweb/gitweb.perl | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 101dbc0..3a52bc7 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2036,10 +2036,24 @@ sub format_log_line_html {
 	my $line = shift;
 
 	$line = esc_html($line, -nbsp=>1);
-	$line =~ s{\b([0-9a-fA-F]{7,40})\b}{
+	$line =~ s{
+        \b
+        (
+            # The output of "git describe", e.g. v2.10.0-297-gf6727b0
+            # or hadoop-20160921-113441-20-g094fb7d
+            (?<!-) # see strbuf_check_tag_ref(). Tags can't start with -
+            [A-Za-z0-9.-]+
+            (?!\.) # refs can't end with ".", see check_refname_format()
+            -g[0-9a-fA-F]{7,40}
+            |
+            # Just a normal looking Git SHA1
+            [0-9a-fA-F]{7,40}
+        )
+        \b
+    }{
 		$cgi->a({-href => href(action=>"object", hash=>$1),
 					-class => "text"}, $1);
-	}eg;
+	}egx;
 
 	return $line;
 }
-- 
2.1.3


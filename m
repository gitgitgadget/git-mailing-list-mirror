Return-Path: <SRS0=5D3W=ZY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49528C43215
	for <git@archiver.kernel.org>; Mon,  2 Dec 2019 19:26:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F64921774
	for <git@archiver.kernel.org>; Mon,  2 Dec 2019 19:26:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Re4eVgJ6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728002AbfLBT0Y (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Dec 2019 14:26:24 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:47025 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727686AbfLBT0Y (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Dec 2019 14:26:24 -0500
Received: by mail-pj1-f67.google.com with SMTP id z21so149256pjq.13
        for <git@vger.kernel.org>; Mon, 02 Dec 2019 11:26:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=XK+ggEAv1wMCtvaXAFMO5/AQSd0QeAH4QVz4SA3GvXs=;
        b=Re4eVgJ6TGt4MRbYh+EwJRUoFsMcaNbzAQO4Qu9cl0Qc1N3uLQjr/tVK2tpM6JWIsZ
         6oEivCW8edifZF9CIs/bPA78WW5lsDy067knvdfo3165ovZutcin8eyQl7wv1kSZUf6J
         7P8HO6mDuT0658fqJnlx1RDnyOFZJQtOIRaKe/Pq0zfy47cg6HUElEEEIZeE4zzLQ1d4
         cYyxQxphJgAoxfIAssbaGu1S/35T92ylGBUzyaAOcGCHVjq4/tt6Ad0LYafAGnBpG4nP
         Eb116eS4Zujiy2vdKYqGNuYo3OKJg8mGvcaUZETTAKyzTBaaLl5H5UD6RnjxfuEy2Kz3
         jYyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=XK+ggEAv1wMCtvaXAFMO5/AQSd0QeAH4QVz4SA3GvXs=;
        b=Tl9JuioVF7GjkMFV28TeX6wON79nw/v6rn2Q8C52Mdz3SwXpsBUwTnWHPskiV7oUBC
         8z6AuJFyV4QPmN985XMpD1p1sz6i24qVKy1gZCU7W9X/R1FmZQ6Os66lmvp5VZc9NCDh
         vIWoWlL+x41BC1l04cL1xUK5Stu0vG8zQQF5pdvJdFHuQPvhrxh1drhHcsO+X651P3Vf
         HMjF2ERVjzYaRz+KhhKWZTQGU6Y+70m/wF+NNgTqq983mc0IQmhe2mNZ6rFTFmvGG3yZ
         ZmcFXQa/rD7Yh7JigQwaKx063UYpTYPTVvcE4d4hLFtgLia9b7F68xD0SuGQ3z4n6oip
         YS7g==
X-Gm-Message-State: APjAAAX2fo3afgoXli+5PzbPMVEolc/AVftn4ovZ6m6erjXJXOfsL5JK
        nm3uXOgcdr7l35bZrAuYjGAgk26b
X-Google-Smtp-Source: APXvYqxY3wRkRJTiLWqM5B0GSR7/P+gpyXqZWWw+mSsfuuzGqagBjsXZbXA+kQ6VO0UKxDsRVKf3fg==
X-Received: by 2002:a17:902:7594:: with SMTP id j20mr890697pll.62.1575314782717;
        Mon, 02 Dec 2019 11:26:22 -0800 (PST)
Received: from generichostname ([204.14.239.138])
        by smtp.gmail.com with ESMTPSA id 2sm344702pgo.79.2019.12.02.11.26.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2019 11:26:22 -0800 (PST)
Date:   Mon, 2 Dec 2019 11:26:20 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Eric Wong <e@80x24.org>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 2/3] RelNotes: replace Gmane with real Message-IDs
Message-ID: <cad77e09890e7e5b50be0dd4d9586a85ec18ab77.1575314676.git.liu.denton@gmail.com>
References: <cover.1574882812.git.liu.denton@gmail.com>
 <cover.1575314676.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1575314676.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The only references to Gmane that remain are in RelNotes. Although these
are definitely not in active use, they might be of historical interest
for future readers so let's ensure that mail references are more robust.

Replace links to Gmane with links to lore.kernel.org (which is our new
preferred mailing list archive and has the Message-ID in the URL) and
bare Gmane ID references with Message-IDs.

The Message-IDs were found by searching for "gmane:<id>" on
https://public-inbox.org/git/ and taking the resulting message.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 Documentation/RelNotes/1.6.2.txt | 2 +-
 Documentation/RelNotes/1.6.3.txt | 2 +-
 Documentation/RelNotes/1.6.4.txt | 2 +-
 Documentation/RelNotes/1.6.5.txt | 2 +-
 Documentation/RelNotes/1.6.6.txt | 2 +-
 Documentation/RelNotes/1.8.4.txt | 2 +-
 Documentation/RelNotes/2.5.0.txt | 3 ++-
 Documentation/RelNotes/2.8.3.txt | 4 ++--
 Documentation/RelNotes/2.9.0.txt | 2 +-
 9 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/Documentation/RelNotes/1.6.2.txt b/Documentation/RelNotes/1.6.2.txt
index ad060f4f89..980adfb315 100644
--- a/Documentation/RelNotes/1.6.2.txt
+++ b/Documentation/RelNotes/1.6.2.txt
@@ -11,7 +11,7 @@ push running this release will issue a big warning when the
 configuration variable is missing.  Please refer to:
 
   http://git.or.cz/gitwiki/GitFaq#non-bare
-  http://thread.gmane.org/gmane.comp.version-control.git/107758/focus=108007
+  https://lore.kernel.org/git/7vbptlsuyv.fsf@gitster.siamese.dyndns.org/
 
 for more details on the reason why this change is needed and the
 transition plan.
diff --git a/Documentation/RelNotes/1.6.3.txt b/Documentation/RelNotes/1.6.3.txt
index 418c685cf8..4bcff945e0 100644
--- a/Documentation/RelNotes/1.6.3.txt
+++ b/Documentation/RelNotes/1.6.3.txt
@@ -11,7 +11,7 @@ push running this release will issue a big warning when the
 configuration variable is missing.  Please refer to:
 
   http://git.or.cz/gitwiki/GitFaq#non-bare
-  http://thread.gmane.org/gmane.comp.version-control.git/107758/focus=108007
+  https://lore.kernel.org/git/7vbptlsuyv.fsf@gitster.siamese.dyndns.org/
 
 for more details on the reason why this change is needed and the
 transition plan.
diff --git a/Documentation/RelNotes/1.6.4.txt b/Documentation/RelNotes/1.6.4.txt
index 7a904419f7..a2a34b43a7 100644
--- a/Documentation/RelNotes/1.6.4.txt
+++ b/Documentation/RelNotes/1.6.4.txt
@@ -11,7 +11,7 @@ push running this release will issue a big warning when the
 configuration variable is missing.  Please refer to:
 
   http://git.or.cz/gitwiki/GitFaq#non-bare
-  http://thread.gmane.org/gmane.comp.version-control.git/107758/focus=108007
+  https://lore.kernel.org/git/7vbptlsuyv.fsf@gitster.siamese.dyndns.org/
 
 for more details on the reason why this change is needed and the
 transition plan.
diff --git a/Documentation/RelNotes/1.6.5.txt b/Documentation/RelNotes/1.6.5.txt
index ee141c19ad..6c7f7da7eb 100644
--- a/Documentation/RelNotes/1.6.5.txt
+++ b/Documentation/RelNotes/1.6.5.txt
@@ -22,7 +22,7 @@ push running this release will issue a big warning when the
 configuration variable is missing.  Please refer to:
 
   http://git.or.cz/gitwiki/GitFaq#non-bare
-  http://thread.gmane.org/gmane.comp.version-control.git/107758/focus=108007
+  https://lore.kernel.org/git/7vbptlsuyv.fsf@gitster.siamese.dyndns.org/
 
 for more details on the reason why this change is needed and the
 transition plan.
diff --git a/Documentation/RelNotes/1.6.6.txt b/Documentation/RelNotes/1.6.6.txt
index c50b59c495..3ed1e01433 100644
--- a/Documentation/RelNotes/1.6.6.txt
+++ b/Documentation/RelNotes/1.6.6.txt
@@ -64,7 +64,7 @@ users will fare this time.
    Please refer to:
 
    http://git.or.cz/gitwiki/GitFaq#non-bare
-   http://thread.gmane.org/gmane.comp.version-control.git/107758/focus=108007
+   https://lore.kernel.org/git/7vbptlsuyv.fsf@gitster.siamese.dyndns.org/
 
    for more details on the reason why this change is needed and the
    transition process that already took place so far.
diff --git a/Documentation/RelNotes/1.8.4.txt b/Documentation/RelNotes/1.8.4.txt
index 02f681b710..255e185af6 100644
--- a/Documentation/RelNotes/1.8.4.txt
+++ b/Documentation/RelNotes/1.8.4.txt
@@ -58,7 +58,7 @@ Foreign interfaces, subsystems and ports.
    credential helper interface from Git.pm.
 
  * Update build for Cygwin 1.[57].  Torsten Bögershausen reports that
-   this is fine with Cygwin 1.7 ($gmane/225824) so let's try moving it
+   this is fine with Cygwin 1.7 (cf. <51A606A0.5060101@web.de>) so let's try moving it
    ahead.
 
  * The credential helper to talk to keychain on OS X (in contrib/) has
diff --git a/Documentation/RelNotes/2.5.0.txt b/Documentation/RelNotes/2.5.0.txt
index 87044504c5..84723f912a 100644
--- a/Documentation/RelNotes/2.5.0.txt
+++ b/Documentation/RelNotes/2.5.0.txt
@@ -172,7 +172,8 @@ Performance, Internal Implementation, Development Support etc.
    incorrect patch text to "git apply".  Add tests to demonstrate
    this.
 
-   I have a slight suspicion that this may be $gmane/87202 coming back
+   I have a slight suspicion that this may be
+   cf. <7vtzf77wjp.fsf@gitster.siamese.dyndns.org> coming back
    and biting us (I seem to have said "let's run with this and see
    what happens" back then).
 
diff --git a/Documentation/RelNotes/2.8.3.txt b/Documentation/RelNotes/2.8.3.txt
index fedd9968e5..a63825ed87 100644
--- a/Documentation/RelNotes/2.8.3.txt
+++ b/Documentation/RelNotes/2.8.3.txt
@@ -55,8 +55,8 @@ Fixes since v2.8.2
    This is necessary to use Git on Windows shared directories, and is
    already enabled for the MinGW and plain Windows builds.  It also
    has been used in Cygwin packaged versions of Git for quite a while.
-   See http://thread.gmane.org/gmane.comp.version-control.git/291853
-   and http://thread.gmane.org/gmane.comp.version-control.git/275680.
+   See https://lore.kernel.org/git/20160419091055.GF2345@dinwoodie.org/
+   and https://lore.kernel.org/git/20150811100527.GW14466@dinwoodie.org/.
 
  * "git replace -e" did not honour "core.editor" configuration.
 
diff --git a/Documentation/RelNotes/2.9.0.txt b/Documentation/RelNotes/2.9.0.txt
index b61d36712f..991640119a 100644
--- a/Documentation/RelNotes/2.9.0.txt
+++ b/Documentation/RelNotes/2.9.0.txt
@@ -368,7 +368,7 @@ notes for details).
    This is necessary to use Git on Windows shared directories, and is
    already enabled for the MinGW and plain Windows builds.  It also
    has been used in Cygwin packaged versions of Git for quite a while.
-   See http://thread.gmane.org/gmane.comp.version-control.git/291853
+   See https://lore.kernel.org/git/20160419091055.GF2345@dinwoodie.org/
 
  * "merge-octopus" strategy did not ensure that the index is clean
    when merge begins.
-- 
2.24.0.504.g3cd56eb17d


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E65F1F403
	for <e@80x24.org>; Wed, 13 Jun 2018 07:48:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934669AbeFMHsW (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Jun 2018 03:48:22 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:42868 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934563AbeFMHsU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jun 2018 03:48:20 -0400
Received: by mail-wr0-f193.google.com with SMTP id w10-v6so1614167wrk.9
        for <git@vger.kernel.org>; Wed, 13 Jun 2018 00:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8gixl877lk7ClNdWeX9A9QgrM2wC91ZRPsfiNxk0Q7U=;
        b=gtVoFpY7Sg6+sqvV1zHG/ldMD7Kw+SpW4Q2Q8d7hFQJkA5QtOGYmKA/skL6SjeoRyp
         HSBJ7Z/9smehGFWap4b0KFWcJGSvVl7aeGBKtdw08/m7axFa/kdtf0mkvTshbrxP2B3s
         w0fWRFY+kZRuLVDxv7ptchuluVU1MErvCP8/gyU24az8cGKqPxSIC+RTQgOHk/0wQCFd
         I5uERfGoa0o5RrmVCehwEyEcGI47JKuRybvCsSl+xZrwausgMSCBQT77svRHU0VeZLDc
         Jj+CtIUGXnXpbSWKN/WjAdHbvDKXdgfCZWiYs5lKSrGFH/k5b24GK64QSBeJqOmeaOR8
         91Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8gixl877lk7ClNdWeX9A9QgrM2wC91ZRPsfiNxk0Q7U=;
        b=ciXcVPxc6jk1vn7nAQ6I/46AkJKNMVb2fNar9Ze7Sap+0PpWr9hJ7uiUOmc3/a8/bj
         YkxHB1yk8jF4OFXYMnAlJZcb1zS1y8bbAnvmj0+QprFU7Dwp+oHs2lpUJG9BoFQPQi5t
         IxolfbDqxenMgP3jZor6BZx5JWgqxYCE9wyBWXvDAg5d0pijzTHMN+RHqTts1Fe0Jfkx
         u9AuV54LTaWol9osLYKk1LwV0hRgzNxZJuxJCEnFiGfpBQYkmNbhE46KUoRv4JHKbEOw
         Bg7tSww0mSzaFW052SPPGhzBorWWfPg3URuujjzJD8eFs909PdsGkfYoiTknNXc49NrF
         VleA==
X-Gm-Message-State: APt69E1AMyFjgS28c+o3n0fbyYJ5RfoA+EWjfix8fl1pQudE6OYJl0lh
        vi1pzSHKZOUL+26bHZHHewGpbhhr
X-Google-Smtp-Source: ADUXVKJ7Sp2cXmwQdeGij8shMKXtiESr9sU8wovM6WrieoF9b2FKv2j4BTFD9WcLH0IipHgDR3546A==
X-Received: by 2002:adf:9769:: with SMTP id r96-v6mr3339902wrb.57.1528876098660;
        Wed, 13 Jun 2018 00:48:18 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id v68-v6sm3262147wmd.12.2018.06.13.00.48.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Jun 2018 00:48:18 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Luis Marsano <luis.marsano@gmail.com>,
        Ted Zlatanov <tzz@lifelogs.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] git-credential-netrc: remove use of "autodie"
Date:   Wed, 13 Jun 2018 07:48:10 +0000
Message-Id: <20180613074810.5358-1-avarab@gmail.com>
X-Mailer: git-send-email 2.17.0.290.gded63e768a
In-Reply-To: <CAHqJXRE8OKSKcck1APHAHccLZhox+tZi8nNu2RA74RErX8s3Pg@mail.gmail.com>
References: <CAHqJXRE8OKSKcck1APHAHccLZhox+tZi8nNu2RA74RErX8s3Pg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The "autodie" module was added in Perl 5.10.1, but our INSTALL
document says "version 5.8 or later is needed".

As discussed in <87efhfvxzu.fsf@evledraar.gmail.com> this script is in
contrib/, so we might not want to apply that policy, however in this
case "autodie" was recently added as a "gratuitous safeguard" in
786ef50a23 ("git-credential-netrc: accept gpg option",
2018-05-12) (see
<CAHqJXRE8OKSKcck1APHAHccLZhox+tZi8nNu2RA74RErX8s3Pg@mail.gmail.com>).

Looking at it more carefully the addition of "autodie" inadvertently
introduced a logic error, since having it is equivalent to this patch:

    @@ -245,10 +244,10 @@ sub load_netrc {
     	if ($gpgmode) {
     		my @cmd = ($options{'gpg'}, qw(--decrypt), $file);
     		log_verbose("Using GPG to open $file: [@cmd]");
    -		open $io, "-|", @cmd;
    +		open $io, "-|", @cmd or die "@cmd: $!";
     	} else {
     		log_verbose("Opening $file...");
    -		open $io, '<', $file;
    +		open $io, '<', $file or die "$file: $!$!;
     	}

     	# nothing to do if the open failed (we log the error later)

As shown in the context the intent of that code is not do die but to
log the error later.

Per my reading of the file this was the only thing autodie was doing
in this file (there was no other code it altered). So let's remove it,
both to fix the logic error and to get rid of the dependency.

1. <87efhfvxzu.fsf@evledraar.gmail.com>
   (https://public-inbox.org/git/87efhfvxzu.fsf@evledraar.gmail.com/)
2. <CAHqJXRE8OKSKcck1APHAHccLZhox+tZi8nNu2RA74RErX8s3Pg@mail.gmail.com>
   (https://public-inbox.org/git/CAHqJXRE8OKSKcck1APHAHccLZhox+tZi8nNu2RA74RErX8s3Pg@mail.gmail.com/)

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 contrib/credential/netrc/git-credential-netrc | 1 -
 1 file changed, 1 deletion(-)

diff --git a/contrib/credential/netrc/git-credential-netrc b/contrib/credential/netrc/git-credential-netrc
index 0b9a94102e..ebfc123ec6 100755
--- a/contrib/credential/netrc/git-credential-netrc
+++ b/contrib/credential/netrc/git-credential-netrc
@@ -2,7 +2,6 @@
 
 use strict;
 use warnings;
-use autodie;
 
 use Getopt::Long;
 use File::Basename;
-- 
2.17.0.290.gded63e768a


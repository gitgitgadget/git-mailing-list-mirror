Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 05DAD1F4F8
	for <e@80x24.org>; Wed, 21 Sep 2016 11:44:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933636AbcIULop (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Sep 2016 07:44:45 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36819 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933502AbcIULoo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Sep 2016 07:44:44 -0400
Received: by mail-wm0-f67.google.com with SMTP id b184so8115394wma.3
        for <git@vger.kernel.org>; Wed, 21 Sep 2016 04:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TDF2eViSABZuCfVAlWW7Aa+FOVnfRy93rDC6Wpu4WEk=;
        b=gCVxsljDXNTn6Al6YX+FLnpk0L4U05dcrTz5G/ZW0Uw8S1ZhI2kZOpet/EOLxGgi+e
         N/Acsl5+mxvnDbPw7kFoKSUagZ58ieo7hZIlwE11nfvo4oKa/qWyLNfVQm+nvBGIyIRX
         gwMLDcn5uzkj2uLQNLqBQGA7Y7Y2FCfDe3uyaiVTqiRf1Ereyz67Vu1mykcsPuMz7BeG
         h+W0tq+dvvmkXH4t1fBGp6xJbDz9YDTQpXTZrHeq72eybW8PzIu0PfMg272StDOdyglV
         oYyaOXZ88YpJ6aPZ/rbSYCS6g+rtAgaLS7yremOmnXcyVOSsKQ/kajmDR0C8gxN2vOL7
         Uz0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TDF2eViSABZuCfVAlWW7Aa+FOVnfRy93rDC6Wpu4WEk=;
        b=PeSpd/7KVohRN5toefFrHj0M90WQ57tIx1pjiBuZofqqV+KIBGT4ZNfqfzVgSNZkFv
         ljsGrA4MaRWjZ59ywZORtGD6Wk15QML3u+5IePTTg0VkTVJP4t0II153K3ODSArMG/d6
         Xy9s2T+0N/vQKezJ17wQctUDF1CgKxvI02W38y4Nm2P5g8nWMtHg84hNybsAnqt+uun0
         32Vs4NzpA4qK54HZddYGLjHkP+vDAgWuf5o2ZmcHWIvsYnQhk9net4hTnjWNrqhzvJmf
         ssOWkiMyFaVqpkSiXqeTRsXOQUqbMRbAsZsWy1WeaTJ8Rm69P5x/AzeHM7Wj5NAbJO+y
         3syA==
X-Gm-Message-State: AE9vXwP+62GC6ObEozsPO1oCK7NoEsOzDcx9vO/1ARvnTFJmIcKNj6ttmQh2jpzk9Dymww==
X-Received: by 10.28.221.213 with SMTP id u204mr3056740wmg.117.1474458283387;
        Wed, 21 Sep 2016 04:44:43 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id au10sm33165171wjc.12.2016.09.21.04.44.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 21 Sep 2016 04:44:42 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Kay Sievers <kay.sievers@suse.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 2/3] gitweb: Link to 7-character SHA1SUMS in commit messages
Date:   Wed, 21 Sep 2016 11:44:27 +0000
Message-Id: <20160921114428.28664-2-avarab@gmail.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20160921114428.28664-1-avarab@gmail.com>
References: <20160921114428.28664-1-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the minimum length of a commit we'll link to from 8 to 7.

This arbitrary minimum length of 8 was introduced in
v1.4.4.2-151-gbfe2191, but as seen in e.g. v1.7.4-1-gdce9648 the
default abbreviation length is 7.

It's still possible to reference SHA1s down to 4 characters in length,
see v1.7.4-1-gdce9648's MINIMUM_ABBREV, but I can't see how to make
git actually produce that, so I doubt anyone is putting that into log
messages in practice, but people definitely do put 7 character SHA1s
into log messages.

I think it's fairly dubious to link to things matching [0-9a-fA-F]
here as opposed to just [0-9a-f], that dates back to the initial
version of gitweb from 161332a. Git will accept all-caps SHA1s, but
didn't ever produce them as far as I can tell.
---
 gitweb/gitweb.perl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 9473daf..101dbc0 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2036,7 +2036,7 @@ sub format_log_line_html {
 	my $line = shift;
 
 	$line = esc_html($line, -nbsp=>1);
-	$line =~ s{\b([0-9a-fA-F]{8,40})\b}{
+	$line =~ s{\b([0-9a-fA-F]{7,40})\b}{
 		$cgi->a({-href => href(action=>"object", hash=>$1),
 					-class => "text"}, $1);
 	}eg;
-- 
2.1.3


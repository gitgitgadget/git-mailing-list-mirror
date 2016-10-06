Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2BEB020987
	for <e@80x24.org>; Thu,  6 Oct 2016 09:12:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967051AbcJFJMf (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Oct 2016 05:12:35 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36508 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967112AbcJFJMb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Oct 2016 05:12:31 -0400
Received: by mail-wm0-f68.google.com with SMTP id 123so2471795wmb.3
        for <git@vger.kernel.org>; Thu, 06 Oct 2016 02:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ipxDqrG5p0ujC2ir09+3VI4zClVDJ/n4AyxNCeQCmb4=;
        b=0dD1Qm7hKtzmjxZQJCl/VWbLVK2lUKqIuiHl/jtpIlFCHJUt2vNOdnisSijrb3Zixl
         mSt8GvqJhY6aX7Hmsfq0gvFIgVV71Eev/5+C4K+4KNQa6WfnE+rhqPcAsHy7bYCCGbVG
         XYdMHUUCKSBbqSP52YYjqFP5N01yMY9D3F+eUrAw6QiUXDLeN5rtcqjSTqoy+iPp8rWd
         qRljh26rEpGm6qIaFtIptbRG9wjZJlZmb+Uo5nw+6BpYTRfc5YsyFifioftMmDxDLsxi
         gsZPgg8ZAO9u25zDhyaQA10LahrGNqjnOe6knB95EQW/PdLyeM5B2bwNGeZyJM+/dX9M
         iBVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ipxDqrG5p0ujC2ir09+3VI4zClVDJ/n4AyxNCeQCmb4=;
        b=L9/jVX90UxAnlqVdVF80cF4861PSDrlrJ1OlivzRxBpgM4iiks9lM6zg04Lov3nAOz
         YJ2G4peJUv8PvrxI1+w0U1QKz/Xl400BB1OQ6RH5685yu5Dt3/2BBBv1y2mPgXkFHZa5
         4srhjk0ahW29Tj5bS+R1+/y2yttja2eTQlrYwdcWA30RQ5M6aF96hQUVw642AUSy/h9L
         7ZtKpWSniVPG53fylQo5Dn0kuWUAZNdhsc5soG5P1+Ji3aMDDJha9fzHyXObrq1cjiRB
         P5wXWaaAK05nSqAWWJvW5GkXhLc0eRVaFzd6DzATXkdvVSCg+4aJzZpoB5REB/UMEKf2
         EnWQ==
X-Gm-Message-State: AA6/9RkURSCKRxUqNzT1DeUIcoSVWLMKqvvS4rzVENHh8KKOiwKVSjRWbBpIzbjnx3EIKw==
X-Received: by 10.28.141.6 with SMTP id p6mr13268943wmd.110.1475745150409;
        Thu, 06 Oct 2016 02:12:30 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id 137sm34169946wmi.16.2016.10.06.02.12.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 06 Oct 2016 02:12:28 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 3/3] gitweb: Link to "git describe"'d commits in log messages
Date:   Thu,  6 Oct 2016 09:11:35 +0000
Message-Id: <20161006091135.29590-4-avarab@gmail.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20161006091135.29590-1-avarab@gmail.com>
References: <20161006091135.29590-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the log formatting function to know about "git describe" output
such as "v2.8.0-4-g867ad08", in addition to just plain "867ad08".

There are still many valid refnames that we don't link to
e.g. v2.10.0-rc1~2^2~1 is also a valid way to refer to
v2.8.0-4-g867ad08, but I'm not supporting that with this commit,
similarly it's trivially possible to create some refnames like
"æ/var-gf6727b0" or which won't be picked up by this regex.

There's surely room for improvement here, but I just wanted to address
the very common case of sticking "git describe" output into commit
messages without trying to link to all possible refnames, that's going
to be a rather futile exercise given that this is free text, and it
would be prohibitively expensive to look up whether the references in
question exist in our repository.

There was on-list discussion about how we could do better than this
patch. Junio suggested to update parse_commits() to call a new
"gitweb--helper" command which would pass each of the revision
candidates through "rev-parse --verify --quiet". That would cut down
on our false positives (e.g. we'll link to "deadbeef"), and also allow
us to be more aggressive in selecting candidate revisions.

That may be too expensive to work in practice, or it may
not. Investigating that would be a good follow-up to this patch.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 gitweb/gitweb.perl | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 92b5e91..7cf68f0 100755
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
2.9.3


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1637E20986
	for <e@80x24.org>; Thu,  6 Oct 2016 09:12:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967117AbcJFJM2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Oct 2016 05:12:28 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35218 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967112AbcJFJM1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Oct 2016 05:12:27 -0400
Received: by mail-wm0-f66.google.com with SMTP id f193so2470167wmg.2
        for <git@vger.kernel.org>; Thu, 06 Oct 2016 02:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=D/v8ZCRJZ7gWeDMepwJibf0glx87tauOeMDgrFIeep4=;
        b=sS+mts+7qFKu+FTzyXTTe7/3pm6J1K10uYJ+7wtr9trtKb2UtJtFeiRzRKYRd8j6CT
         NwPd8/Wzn7YmL5Umlto8bPz7JjFIvGkGuKwCnBwocNGP/62DkR700sAZNC5J+1t3bSwz
         ZQUBH2+Urju9e8dod62kNUuB7yGlPzuFXQS650icRXeJqNAHp/G9ZVATGIeicw51qZKR
         6H6SZp67KL6La7NybjWwzIaC3oEUy72X4StQc67VJmwM6xvdJmAFwAeDNPAqTL4nOXmO
         iI1y4pWBIGNMauS7ti/KKkkq7GBwRlIXDNDBDuxhdqkG1vQC0J1d5IRpSzoVDnibq2K3
         hZbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D/v8ZCRJZ7gWeDMepwJibf0glx87tauOeMDgrFIeep4=;
        b=NgrAxvu3XfcjRPnF7DLnv4r0PbX7N8TO8E0yazC+POFuTrd7L47QlgSaObie3KTN9h
         6tLothTjFppky7UOXkXhprUVye83eOnMUlY+ilq7UHGb9h6/5RnoS5UI3eZLOMegDSQH
         tyDBjfRDvhf06Vf8bkoFVHkD9jlREJ1Bp/ZjQnMK6Aj5nx81NBHnaRksK6Au1hcBmo7n
         oE6OVEbK5PYMngjlksBPPQ77GYr31Rjn86U2VNP8Dgf0aX/O71INxBROAPPh2BVmV836
         Oeu2vbHE0ibwbAg7gorfGgRYOvVAcurgZv+zvF1ynVlNP+fsyF+DPHDBTNdYcj3Z1F0R
         0thQ==
X-Gm-Message-State: AA6/9Rmey67TBMLpDAiZwk+ogQPe7RCn9jtDaUK1BIchsqIZn6pXanTLPvX5ijeQ6pIW5Q==
X-Received: by 10.194.118.131 with SMTP id km3mr11095610wjb.173.1475745145317;
        Thu, 06 Oct 2016 02:12:25 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id 137sm34169946wmi.16.2016.10.06.02.12.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 06 Oct 2016 02:12:24 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 2/3] gitweb: Link to 7-char+ SHA1s, not only 8-char+
Date:   Thu,  6 Oct 2016 09:11:34 +0000
Message-Id: <20161006091135.29590-3-avarab@gmail.com>
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

Change the minimum length of an abbreviated object identifier in the
commit message gitweb tries to turn into link from 8 hexchars to 7.

This arbitrary minimum length of 8 was introduced in bfe2191 ("gitweb:
SHA-1 in commit log message links to "object" view", 2006-12-10), but
the default abbreviation length is 7, and has been for a long time.

It's still possible to reference SHA1s down to 4 characters in length,
see v1.7.4-1-gdce9648's MINIMUM_ABBREV, but I can't see how to make
git actually produce that, so I doubt anyone is putting that into log
messages in practice, but people definitely do put 7 character SHA1s
into log messages.

I think it's fairly dubious to link to things matching [0-9a-fA-F]
here as opposed to just [0-9a-f], that dates back to the initial
version of gitweb from 161332a ("first working version",
2005-08-07). Git will accept all-caps SHA1s, but didn't ever produce
them as far as I can tell.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 gitweb/gitweb.perl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index cba7405..92b5e91 100755
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
2.9.3


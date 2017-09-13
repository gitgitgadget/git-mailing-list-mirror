Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4409A20286
	for <e@80x24.org>; Wed, 13 Sep 2017 21:25:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751422AbdIMVZd (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Sep 2017 17:25:33 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:37725 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751121AbdIMVZc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Sep 2017 17:25:32 -0400
Received: by mail-pg0-f65.google.com with SMTP id v5so650993pgn.4
        for <git@vger.kernel.org>; Wed, 13 Sep 2017 14:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mEt3+fAlKQRLCQSzuSgdflz269FGVmd41g4kF6lXa3k=;
        b=fKHtp+xp+N01Q6/g8KQ+zYrlgF6xfmIbTSofyPMt8nS9zVqd0MmMdoe5SWJsZsFNWU
         lr7SWKa6UQtqceM/2YdVq9sw1wTcZ4NFG9YhATFhwWOFnng+BbPms3lF+y/Tv0e/pPdl
         CNRWA+ixarhUpbOS0k0c60gjOPD6U0UhcgrnGtQ3XYJFvY0LGWZRPqQDZ+pAktfGc++2
         s75+hwaQh+lHjtgzzNZPmlQF66WS3DIx2u8OinnS4YGNf1IRhjTDyZcrnKWVtGILRH9Q
         rp59AsHb3nS6LFkg8G8KM7TkcG4fpTuWG2xB9e4Hc6oED6jZXARZjZq6nJK962sL9zGJ
         Z+oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mEt3+fAlKQRLCQSzuSgdflz269FGVmd41g4kF6lXa3k=;
        b=Ic2nDkVd379fg+CmHpydSQKV7o9zRkHG8r1tuR/hcchs5X4NnxwUQ96qEyC+cYMcoD
         0zytYGzsJXoha87cBgAkstC1vVQ5L9DBfM0Adlnn3J9bh4GoC5Gm/LlF43OQpxbwhEUl
         DEG/yUVkG3E9l8S3bIyW6922R0/V3BDfSnoxxqK7nn9+s7QE3wJB749w3PheoP2MDoz0
         Wfw02GxXTzBOZO/92iWAoRlzWwxx1TmZ8+b11gklVWDeIrHaEN5tDume7E6E0mWdfGVN
         O73wlhhlmGBhMBMSqvl8w9c1n/d4ihQCK9g4D+2gqeAfz4CUY0YoRPc3mdodJdT8awx/
         kT9w==
X-Gm-Message-State: AHPjjUgy+/LU12Xg7WTpf6KtYtN3FKzgmsJuxKK2RW3S9hLVJyBHtjMH
        XCwtvfCpkWTK1A==
X-Google-Smtp-Source: ADKCNb4QKytH5mmm36H3EuPTomCSMYkfg96EFzIteKzole1l9ZTUbrWMDUz9LX0TVs6S8hhQTTikrg==
X-Received: by 10.84.229.75 with SMTP id d11mr21647409pln.411.1505337931449;
        Wed, 13 Sep 2017 14:25:31 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:d132:98b:3ff1:a635])
        by smtp.gmail.com with ESMTPSA id y16sm34361374pge.92.2017.09.13.14.25.30
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 13 Sep 2017 14:25:30 -0700 (PDT)
Date:   Wed, 13 Sep 2017 14:25:28 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     demerphq <demerphq@gmail.com>, Git <git@vger.kernel.org>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 7/7] config: flip return value of store_write_*()
Message-ID: <20170913212528.GO27425@aiede.mtv.corp.google.com>
References: <20170913170807.cyx7rrpoyhaauvol@sigill.intra.peff.net>
 <20170913171756.v7vzu3a77g2khq7x@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170913171756.v7vzu3a77g2khq7x@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Jeff King wrote:

> The store_write_section() and store_write_pairs() functions
> are basically high-level wrappers around write(). But their
> return values are flipped from our usual convention, using
> "1" for success and "0" for failure.
>
> Let's flip them to follow the usual write() conventions and
> update all callers. As these are local to config.c, it's
> unlikely that we'd have new callers in any topics in flight
> (which would be silently broken by our change). But just to
> be on the safe side, let's rename them to just
> write_section() and write_pairs().  That also accentuates
> their relationship with write().
>
> Signed-off-by: Jeff King <peff@peff.net>

The caller only cares if it succeeded, right?  Could this return
the customary 0 vs -1 instead of the number of bytes written?

That would look like the following (as a patch to squash in):

With or without that tweak,
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

diff --git i/config.c w/config.c
index 272a32aac0..8f92d452bf 100644
--- i/config.c
+++ w/config.c
@@ -2297,11 +2297,10 @@ static int write_error(const char *filename)
 	return 4;
 }
 
-static ssize_t write_section(int fd, const char *key)
+static int write_section(int fd, const char *key)
 {
 	const char *dot;
-	int i;
-	ssize_t ret;
+	int i, ret;
 	struct strbuf sb = STRBUF_INIT;
 
 	dot = memchr(key, '.', store.baselen);
@@ -2317,16 +2316,15 @@ static ssize_t write_section(int fd, const char *key)
 		strbuf_addf(&sb, "[%.*s]\n", store.baselen, key);
 	}
 
-	ret = write_in_full(fd, sb.buf, sb.len);
+	ret = write_in_full(fd, sb.buf, sb.len) < 0 ? -1 : 0;
 	strbuf_release(&sb);
 
 	return ret;
 }
 
-static ssize_t write_pair(int fd, const char *key, const char *value)
+static int write_pair(int fd, const char *key, const char *value)
 {
-	int i;
-	ssize_t ret;
+	int i, ret;
 	int length = strlen(key + store.baselen + 1);
 	const char *quote = "";
 	struct strbuf sb = STRBUF_INIT;
@@ -2366,7 +2364,7 @@ static ssize_t write_pair(int fd, const char *key, const char *value)
 		}
 	strbuf_addf(&sb, "%s\n", quote);
 
-	ret = write_in_full(fd, sb.buf, sb.len);
+	ret = write_in_full(fd, sb.buf, sb.len) < 0 ? -1 : 0;
 	strbuf_release(&sb);
 
 	return ret;
@@ -2499,8 +2497,7 @@ int git_config_set_multivar_in_file_gently(const char *config_filename,
 		}
 
 		store.key = (char *)key;
-		if (write_section(fd, key) < 0 ||
-		    write_pair(fd, key, value) < 0)
+		if (write_section(fd, key) || write_pair(fd, key, value))
 			goto write_err_out;
 	} else {
 		struct stat st;
@@ -2623,10 +2620,10 @@ int git_config_set_multivar_in_file_gently(const char *config_filename,
 		/* write the pair (value == NULL means unset) */
 		if (value != NULL) {
 			if (store.state == START) {
-				if (write_section(fd, key) < 0)
+				if (write_section(fd, key))
 					goto write_err_out;
 			}
-			if (write_pair(fd, key, value) < 0)
+			if (write_pair(fd, key, value))
 				goto write_err_out;
 		}
 
@@ -2820,7 +2817,7 @@ int git_config_rename_section_in_file(const char *config_filename,
 					continue;
 				}
 				store.baselen = strlen(new_name);
-				if (write_section(out_fd, new_name) < 0) {
+				if (write_section(out_fd, new_name)) {
 					ret = write_error(get_lock_file_path(lock));
 					goto out;
 				}

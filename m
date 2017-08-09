Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 95A1D1F991
	for <e@80x24.org>; Wed,  9 Aug 2017 13:49:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752619AbdHINtt (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Aug 2017 09:49:49 -0400
Received: from mail-wm0-f46.google.com ([74.125.82.46]:38445 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752459AbdHINts (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Aug 2017 09:49:48 -0400
Received: by mail-wm0-f46.google.com with SMTP id m85so31716078wma.1
        for <git@vger.kernel.org>; Wed, 09 Aug 2017 06:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=w1Rx53XgvvE/uE1H+qX5A51rRDnRaEgE89BQJGKZdI0=;
        b=XU9Tm1f9txAJqr0TQQ8IA6G2u/KxajZSw8uGZ8UdHrCTXpbFPqQ1+IA0Ft+0yRt/eJ
         /7gsYN/v6toh7BHtwKXNPa+MqOju+ceTDJ655Yn7e/x6RjwXPnH+ItQuMRfjgO3O2Vnl
         cRcJnNKrB/04IFBD+DQZ5SSJPOXkhvUNSmllL9YBGteOfWcfsaOEuP5eqwGGQdY8D3vx
         bih08OWHKqMn4zejhxX5LHGuN1aQlZzQvfYXkGDJX+l7qogP9+7TatD7PLOsmpjNcWNh
         2O6X5wVClNkbBs4i2gOInqNAWDuS79BzMYgkCN/6QiGXFV7fyKR4cBIhEyWujw6HcRS6
         tX5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w1Rx53XgvvE/uE1H+qX5A51rRDnRaEgE89BQJGKZdI0=;
        b=kJXZBfqFMDmSN7yJAWp6mfJBYOIGh9KlgYJNLzCfhH06kCip+0TWANDRxaw/hqi2e0
         l5klFs87WraUNPdM2VqW6f0jO/ucyKvsf3eSNCHCKp2Bh3vBYLeyw1u8FXhWQT4ztqj8
         nqGghwH2fpwJ3Tg67SRTyANX4fulrWr4KCtblcSk0B9GzSX0aaiAyKnyuuuULXcIE1O2
         2PwNYZT2z58v070aUad5eBj8zvDRcK/Bmw7ymhjX8NWg7C9VWBu88IIa6IHF+QfaWya1
         yES8ZBMVUMkTkpYVGoV1nwrnh2jCsSebGJ1uAnF7CERia3husgvfWrNydD/n3kKfSHiy
         jVew==
X-Gm-Message-State: AHYfb5j9y6Qcx8bgSTmWwhjLSMWCaSb6XnWQmMYo8rB7wN/S2vb+Zyv0
        HDCw6E9gY78WASp9JA0=
X-Received: by 10.80.140.65 with SMTP id p59mr8332329edp.0.1502286586575;
        Wed, 09 Aug 2017 06:49:46 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id e34sm1967138edb.9.2017.08.09.06.49.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Aug 2017 06:49:44 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 5/4] curl: remove ifdef'd code never used with curl >=7.19.4
Date:   Wed,  9 Aug 2017 13:49:37 +0000
Message-Id: <20170809134937.10725-1-avarab@gmail.com>
X-Mailer: git-send-email 2.14.0.rc1.383.gd1ce394fe2
In-Reply-To: <20170809133844.3h7plxm6nzoheckv@sigill.intra.peff.net>
References: <20170809133844.3h7plxm6nzoheckv@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As the LIBCURL_VERSION_NUM check at the top of http.h shows we require
curl >= 7.19.4. This means we can remove previously added ifdef's
needed to support older curl versions.

The CURLAUTH_DIGEST_IE macro conditionally used since [1] was added in
7.19.3 (see CURLOPT_HTTPAUTH(3)).

The CURLOPT_USE_SSL macro used since [2] was added in 7.16.4 (see
CURLOPT_USE_SSL(3)).

1. 40a18fc77c ("http: add an "auto" mode for http.emptyauth",
   2017-02-25)
2. 4bc444eb64 ("Support FTP-over-SSL/TLS for regular FTP", 2013-04-07)

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

On Wed, Aug 9, 2017 at 3:38 PM, Jeff King <peff@peff.net> wrote:
> On Wed, Aug 09, 2017 at 03:14:22PM +0200, Ævar Arnfjörð Bjarmason wrote:
>
>> This whole series looks good to me. As I commented on in the thread you
>> referenced in 0/4 I think this is the right trade-off, and people like
>> me who occasionally compile git on older systems can just easily package
>> a newer curl as well if we need it.
>>
>> My reading of the curl history/docs is that you should squash this into
>> this last patch. It's code that's now dead since we require
>> 7.19.4.
>>
>> CURLAUTH_DIGEST_IE was added in 7.19.3, and as a comment this squash
>> removes indicates CURLOPT_USE_SSL hasn't been needed since 7.16.4:
>> https://curl.haxx.se/libcurl/c/CURLOPT_USE_SSL.html
>
> Thanks. Do you mind formatting this as a patch on top instead of a
> squash? I think it's sufficiently subtle that it should be separate from
> the main cleanup, which is just dropping our own internal #ifdefs.

No problem. Here it is. Intended to be placed after your 4/4 since the
commit message references the new error message in http.h.

 http.c | 4 ----
 http.h | 9 ---------
 2 files changed, 13 deletions(-)

diff --git a/http.c b/http.c
index 5280511c74..527bc56dc2 100644
--- a/http.c
+++ b/http.c
@@ -103,9 +103,7 @@ static int http_auth_methods_restricted;
 /* Modes for which empty_auth cannot actually help us. */
 static unsigned long empty_auth_useless =
 	CURLAUTH_BASIC
-#ifdef CURLAUTH_DIGEST_IE
 	| CURLAUTH_DIGEST_IE
-#endif
 	| CURLAUTH_DIGEST;
 
 static struct curl_slist *pragma_header;
@@ -706,10 +704,8 @@ static CURL *get_curl_handle(void)
 	if (curl_ftp_no_epsv)
 		curl_easy_setopt(result, CURLOPT_FTP_USE_EPSV, 0);
 
-#ifdef CURLOPT_USE_SSL
 	if (curl_ssl_try)
 		curl_easy_setopt(result, CURLOPT_USE_SSL, CURLUSESSL_TRY);
-#endif
 
 	/*
 	 * CURL also examines these variables as a fallback; but we need to query
diff --git a/http.h b/http.h
index 29acfe8c55..66d2d3c539 100644
--- a/http.h
+++ b/http.h
@@ -16,15 +16,6 @@
 
 #define DEFAULT_MAX_REQUESTS 5
 
-/*
- * CURLOPT_USE_SSL was known as CURLOPT_FTP_SSL up to 7.16.4,
- * and the constants were known as CURLFTPSSL_*
-*/
-#if !defined(CURLOPT_USE_SSL) && defined(CURLOPT_FTP_SSL)
-#define CURLOPT_USE_SSL CURLOPT_FTP_SSL
-#define CURLUSESSL_TRY CURLFTPSSL_TRY
-#endif
-
 struct slot_results {
 	CURLcode curl_result;
 	long http_code;
-- 
2.14.0.rc1.383.gd1ce394fe2


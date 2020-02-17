Return-Path: <SRS0=dbxk=4F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB71FC7619F
	for <git@archiver.kernel.org>; Mon, 17 Feb 2020 09:31:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C02682070B
	for <git@archiver.kernel.org>; Mon, 17 Feb 2020 09:31:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L3GEmgJO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728743AbgBQJbD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Feb 2020 04:31:03 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:46799 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726397AbgBQJbD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Feb 2020 04:31:03 -0500
Received: by mail-qv1-f68.google.com with SMTP id y2so7269183qvu.13
        for <git@vger.kernel.org>; Mon, 17 Feb 2020 01:31:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=kMz0TYWLLb/l8LRxxXaGiixRX38i39CjKpKfDhnoqUI=;
        b=L3GEmgJO0xqstpTMXOOJSQ+sgaADkY9YUQ/HuQGj9G1yREjYfdYH+ee5b5tmnWwQ4z
         hsMyggInEZcc9127zHjcjAC53AIiq7KftUNdJiXscDfY0saibGaq+hBNoNMFlyyOQc6A
         v4+hSGbfA4mMTFx1RComQPg8jc3YAp52svpgsQmIp3J/2tGEC2KaPeztp8vcyaycSkPW
         dTXFh8UGQSN3MIhWiXa0LHRlKwDJZMpBO4hHWKzJclRmzosOL00wi5xExwAo3uUlT1Oy
         tc/vVhwWkqWs4uB7TLed3jzsHD0h8kBx5Ebfthqdc1UmiB5Iiv/G9YrWhDGmHdujtvD4
         +PQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=kMz0TYWLLb/l8LRxxXaGiixRX38i39CjKpKfDhnoqUI=;
        b=rHbFO8aZe9jOgUuJtld8WinlIrsxhYhGs6ecZCx45j5TBP3eeYWbGVGKmydRC0Us/C
         l8qdrHrjFGIu6NUVSw+kuOK4rOf/C8cjw93Turkl9jgw3Ja0enR/9ThgIFt5e1hElQTL
         XkC1yB94uDjqp0GrZLU3X2VMgyZikUaWio6PgBQXVutG5ON0AdYoxMa7HvWT89D+9lKH
         OL/Qi9+xTeoJhO6zHDMZKSWfhwNhprV6KBmkcmtHOqTGWfc9N99vR5+ArJC1UFKCrUD8
         tCNKe3N2QXSHpkK1na3UuxXHmx0vrQahxenGqA/maqv3xvJp7jUGlG1JJY6mICuGxXEh
         C2YA==
X-Gm-Message-State: APjAAAVizubB9eUg1Ex/sxguBfZLDEal+dN+uq/iSi74KwEigjywBmXM
        tGLGmrPNIrDqEfNG/vzkEDjxW1H/JiGlsCbGnoQ=
X-Google-Smtp-Source: APXvYqxw0u2GjSMNjHbQaNxXmwXWPX1oSm9IWFoabyMBs+aUwYbgBuS4uOByh8GW/NETZZI/2CTWAI3gRcH4ag+sLOQ=
X-Received: by 2002:ad4:518d:: with SMTP id b13mr11667950qvp.141.1581931861744;
 Mon, 17 Feb 2020 01:31:01 -0800 (PST)
MIME-Version: 1.0
From:   Abhishek Kumar <abhishekkumar8222@gmail.com>
Date:   Mon, 17 Feb 2020 15:00:00 +0530
Message-ID: <CAHk66fvt-1RaLK8E7SDpocWM9OMAcA-gP5hjHq6r5N_FbATNgA@mail.gmail.com>
Subject: Re: Facing error in git-imap-send while compiling Git
To:     nirmalhk7@gmail.com
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        dev+git@drbeat.li, git@vger.kernel.org, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Greetings Nirmal

> what imap-send does (in words simpler than ones in manpages).

IMAP is a protocol that stores email messages on a mail server but
allows end-user to view and manipulate them as local files.

imap-send sends a collection of patches from stdin to an IMAP folder.
You create patches using `git format-patch`, edit them and once
satisfied, send them to your drafts folder using `git imap-send`.

**Note**: This does not mean that they are sent out, but rather they
are (usually) in your email service's draft folder.

As for your diff, I have some suggestions -
---
diff --git a/imap-send.c b/imap-send.c
index 6c54d8c29d..3248bc2123 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -41,7 +41,9 @@ typedef void *SSL;
 /* We don't have curl, so continue to use the historical implementation */
 #define USE_CURL_DEFAULT 0
 #endif
-
> +#ifndef SSL_library_init
> +       #define SSL_library_init();
> +#endif

If the macro does not exist, you define it to - nothing, really. You
might have meant this. [1]
```
#ifndef SSL_libary_init
#define SSL_library_init() OPENSSL_init_ssl(0, null)
#endif
```
Regardless, you do check below for the version (hence indirectly
whether the macro exists). You can safely remove these lines.

 static int ssl_socket_connect(struct imap_socket *sock, int
use_tls_only, int verify)
 {
-#if (OPENSSL_VERSION_NUMBER >= 0x10000000L)
-       const SSL_METHOD *meth;
-#else
-       SSL_METHOD *meth;
-#endif
-       SSL_CTX *ctx;
-       int ret;
-       X509 *cert;
-
-       SSL_library_init();
-       SSL_load_error_strings();
> +       #if (OPENSSL_VERSION_NUMBER >= 0x10000000L)
> +               const SSL_METHOD *meth;
> +       #else
> +               SSL_METHOD *meth;
> +       #endif

Maintain zero indentation for macros for consistency.
Also define `METHOD_NAME` as `SSLv23_method` and `TLS_method` to
reduce noise below.

+               SSL_CTX *ctx;
+               int ret;
+               X509 *cert;
+
> +       #if OPENSSL_VERSION_NUMBER >= 0x10100000L ||
> + defined(LIBRESSL_VERSION_NUMBER)
> +               OPENSSL_init_ssl(0, NULL);

This will be executed if openssl version >= 1.1 or has libressl
installed - which means it will *also* be executed for
openssl < 1.1 and libressl installed. OPENSSL_init_ssl hasn't been
defined for older versions and will throw an undefined reference as well. [2]
+               meth = TLS_method();
+       #else
+               SSL_library_init();
+               SSL_load_error_strings();
+               meth = SSLv23_method();
+       #endif

-       meth = SSLv23_method();
        if (!meth) {
-               ssl_socket_perror("SSLv23_method");
> +       #if (OPENSSL_VERSION_NUMBER >= 0x10100000L)
> +                       ssl_socket_perror("TLS_method");
> +       #else
> +                       ssl_socket_perror("SSLv23_method");
> +       #endif

Use `METHOD_NAME` defined above.

                return -1;
        }

As a general note for this patch - I would rather make OpenSSL 1.1 the
common case, using directives to make it compatible with the older
versions. Do consult with Junio and Johannes over the larger picture
here.
---

Regards
Abhishek

[1]: https://github.com/openssl/openssl/blob/8083fd3a183d4c881d6b15727cbc6cb7faeb3280/include/openssl/ssl.h#L1995
[2]: https://www.openssl.org/docs/man1.1.0/man3/OPENSSL_init_ssl.html

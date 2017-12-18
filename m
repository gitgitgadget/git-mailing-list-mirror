Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DBF391F424
	for <e@80x24.org>; Mon, 18 Dec 2017 18:26:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S938102AbdLRS0U (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Dec 2017 13:26:20 -0500
Received: from mail-pg0-f53.google.com ([74.125.83.53]:43099 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935112AbdLRS0P (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Dec 2017 13:26:15 -0500
Received: by mail-pg0-f53.google.com with SMTP id b18so9466201pgv.10
        for <git@vger.kernel.org>; Mon, 18 Dec 2017 10:26:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to;
        bh=EwoV/6vfrc/Ut6TotVboCxZjGKKX9CW8ekFVDDWpswU=;
        b=LaIkNhJsy67L9Pzh4sXGsYg7ulMvsNCeUgDJwHtftU/iZswN8SqSuk8kPlI+sj/Lfr
         jF+7bEoQwk/JRWavUBdmeUwld3vvyUCZhPmT4vDsz340wyHJQNvycMRCLBbiDbDBgahQ
         q9ib9TZhPZ8LboF1S/wwapr3fHPLh4ZH8G+qGx1YzcaxfFKxRZyA8hJVc7RineK2MZqW
         RhgQ/OdljGdGR7UVZ7B/MfuNvwgLaLdHGZ0W18CjMc7oJonrC2zDURSLhDLtP+CmDCTO
         I09FZE2a77oAodHxbJMl2J+980oDgw1/evPrCyW+/s5c0CpscjqEAeL9VgQ+GHRTG1w8
         rJpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to;
        bh=EwoV/6vfrc/Ut6TotVboCxZjGKKX9CW8ekFVDDWpswU=;
        b=B65a9iNsfKmAbx4269nQT80anvheRXvvvz2/F4U0VsVLoqE3LMavZeipnJDf8gqbay
         wF+SoMhd5quPNKO9bRPiWKZXpc2PqK/r19n+jzUxnl2vbRQtgY9+Pb7zOsqa8i3EcKd5
         vpBRjn7O9lkPcHmhdUa9nYeS5xq5DCaZdXeJDI8QEhgAdKd7DQM0ux7UDuFBSnTGdOEg
         zQcHYhCKGtT3kdJSTg8hei9vBAIMk25AvV1aifQm9mjzG0ha9eh2QFQv6aTLpsz53yf4
         CnxLKHAsUf+VmXnOQJgVq2MpHgALYhJT72Ka0EZYbhCvRJ0x3CFuY4qdVtfBRmjlCkVy
         Na2Q==
X-Gm-Message-State: AKGB3mJKgdWWOJyC/LmBshhM8vvl1cnH/W+CQC2g+RxdmBybMchwaW7z
        CpL+rFkJCwUya1E6SLCrsm8NWFK4
X-Google-Smtp-Source: ACJfBouBT8HqiHhuTfQ4XHmUfYDOBuLsp16j1/oqzZVsPnNzMMMVm85ltK3+7ZxLcy/mI/1GdlA03g==
X-Received: by 10.101.97.138 with SMTP id c10mr526413pgv.105.1513621575245;
        Mon, 18 Dec 2017 10:26:15 -0800 (PST)
Received: from unique-pc.sce.com ([117.242.82.246])
        by smtp.gmail.com with ESMTPSA id v15sm27356176pfa.68.2017.12.18.10.26.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Dec 2017 10:26:14 -0800 (PST)
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To:     Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Cc:     Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
        Git List <git@vger.kernel.org>,
        Doron Behar <doron.behar@gmail.com>,
        Nicolas Morey-Chaisemartin <NMoreyChaisemartin@suse.com>
Subject: [PATCH v2] imap-send: URI encode server folder
Date:   Mon, 18 Dec 2017 23:55:46 +0530
Message-Id: <20171218182546.9962-1-kaartic.sivaraam@gmail.com>
X-Mailer: git-send-email 2.15.1.620.gb9897f467
In-Reply-To: <CAPig+cSEYHfupRt+-0sZK6H3_WcT_=wdNB2FfdYuB6geGQYZ3A@mail.gmail.com>
References: <CAPig+cSEYHfupRt+-0sZK6H3_WcT_=wdNB2FfdYuB6geGQYZ3A@mail.gmail.com>
In-Reply-To: <CAPig+cSEYHfupRt+-0sZK6H3_WcT_=wdNB2FfdYuB6geGQYZ3A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>

When trying to send a patch using 'imap-send' with 'curl' and the
following configuration:

[imap]
	folder = "[Gmail]/Drafts"
	host = imaps://imap.gmail.com
	port = 993
	sslverify = false

resulted in the following error,

    curl_easy_perform() failed: URL using bad/illegal format or missing URL

That was a consequence of the not URI encoding the folder portion of
the URL which contained characters such as '[' which are not
allowed in a URI. According to RFC3986, these characters should be
"URI encoded".

So, URI encode the folder portion of the URL to ensure it doesn't
contain characters that aren't allowed in a URI.

Reported-by: Doron Behar <doron.behar@gmail.com>
Signed-off-by: Nicolas Morey-Chaisemartin <NMoreyChaisemartin@suse.com>
---

I came across the same issue that lead to this patch recently and found
that this patch didn't make it in. So, I thought I could help out and
hence this v2.

Eric Sunshine <sunshine@sunshineco.com> writes:
> For someone reading this commit message in the future -- someone who
> didn't follow the email thread which led to this patch -- "this fixes"
> doesn't say much about the actual problem being addressed. Can you
> expand the commit message a bit to make it more self-contained? At
> minimum, perhaps show the error message you were experiencing, and
> cite (as Daniel pointed out) RFC 3986 and the bit about a "legal" URL
> not containing brackets.

I guess I covered this part.


> Also, a natural question which pops into the head of someone reading
> this patch is whether other parts of the URL (host, user, etc.) also
> need to be handled similarly. It's possible that you audited the code
> and determined that they are handled fine already, but the reader of
> the commit message is unable to infer that. Consequently, it might be
> nice to have a sentence about that, as well ("other parts of the URL
> are already encoded, thus are fine" or "other parts of the URL are not
> subject to this problem because ...").

I'm not sure about this one. I guess the host and user don't need encoding
as I suspect they wouldn't contain characters that aren't allowed. I might
be wrong, though. Let me know if I'm missing something.


Thanks,
Kaartic

 imap-send.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/imap-send.c b/imap-send.c
index 54e6a80fd..36c7c1b4f 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -1412,6 +1412,7 @@ static CURL *setup_curl(struct imap_server_conf *srvc, struct credential *cred)
 {
 	CURL *curl;
 	struct strbuf path = STRBUF_INIT;
+	char *uri_encoded_folder;
 
 	if (curl_global_init(CURL_GLOBAL_ALL) != CURLE_OK)
 		die("curl_global_init failed");
@@ -1429,7 +1430,12 @@ static CURL *setup_curl(struct imap_server_conf *srvc, struct credential *cred)
 	strbuf_addstr(&path, server.host);
 	if (!path.len || path.buf[path.len - 1] != '/')
 		strbuf_addch(&path, '/');
-	strbuf_addstr(&path, server.folder);
+
+	uri_encoded_folder = curl_easy_escape(curl, server.folder, 0);
+	if (!uri_encoded_folder)
+		die("failed to encode server folder");
+	strbuf_addstr(&path, uri_encoded_folder);
+	curl_free(uri_encoded_folder);
 
 	curl_easy_setopt(curl, CURLOPT_URL, path.buf);
 	strbuf_release(&path);
-- 
2.15.1.620.gb9897f467


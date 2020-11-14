Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4019C55ABD
	for <git@archiver.kernel.org>; Sat, 14 Nov 2020 21:53:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C057222C4
	for <git@archiver.kernel.org>; Sat, 14 Nov 2020 21:53:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="dQnK+akc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726146AbgKNVxR (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 14 Nov 2020 16:53:17 -0500
Received: from mout.web.de ([212.227.15.3]:36457 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726112AbgKNVxQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Nov 2020 16:53:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1605390785;
        bh=BW6+Zyouru13QKQ/2WaetShIH1tuVWFgRKAqCxY2fpg=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:References:Date:In-Reply-To;
        b=dQnK+akcqAuMqAUc2mL5iO/4BHLSoNYbtwY5FIh10VM1eHH8Nayl5xaKqPuMgCLoq
         vC+BC4kiMsv2p8ovFRZJaytEd7Ofsmkve0T4YLNf0h4FcA3SULsgR+82x4udUsYYO8
         2uhMlVd3wjv3dJgivsNl1UPbxDFfhqrD6gIKzkPI=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([79.203.17.45]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LrbHJ-1kHLVU3LJN-013LN8; Sat, 14
 Nov 2020 22:53:05 +0100
Subject: Re: [PATCH] chdir-notify: UNLEAK registrated callback entries
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
References: <8a9cf9ba-f615-3ff5-8d35-c24c22d5d859@web.de>
Message-ID: <58f36a04-afa7-3cf3-ce0a-ad53004dd774@web.de>
Date:   Sat, 14 Nov 2020 22:53:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <8a9cf9ba-f615-3ff5-8d35-c24c22d5d859@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ETAc0IHKBbDD1U9TJaiTQQUqaWyBhCWujF/E63J5RrlArmc67p7
 ZWyPzzEnORerQR86nFZUTka5ISvftsAO1e39e0r5Nk5/Z/7d1qy+uFYXZzWk4tznxPxHWR8
 wSk/kF1QEpLy8P6TjhUbMHT4Gf60ANVF/RNYzzThlEOGKqNv/qAxcz4unsUB2rDPZJP4MPy
 SMyH9Kh6QbkUTrQ/SFepw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:DZfvPEzMqTI=:0GLdB4Y72rh0YMXPEqE5Fy
 oSkEzAjpE6rOX1lJoz3x/1WMyj+5eACMYXEEIfLq5ojOvzQCfEk0yhM1FRQyAAt62yF5d/29/
 LVKa0sck4d1mItPT40GnlHkO6gqaQktLFJPEy3Hp1sGW04OMlwY+kXYHwiQL1AtZ9nHAallE/
 MHGJzvYKkv3hHHCUE3BbKdnVnJSLoaP9QE2MtbDlJqX9HDK+SV/vho58+xVQPyjPLYwGnBAQ7
 5+j7j4AYlmp/RW3nScgmFy3lICxJzB5pu/8Yj6n0oJzrv1EOBWi4DIkggG1wRVZUzxRnfvT0t
 leDzcMHGXDbpZdAJXjHnwM4py0LU8J9JnlCKzkFvUDg5O5kpKONASXkilFkoa949F58abFJ4/
 xMny/Mcp9cY827fV7TcXCv6gyXS9A67Te8syocdA6ygeDruOA8pZfaMyvfgycLoZgGF/2cC2a
 C/ptZ8azGRHoMTLWdVcF9sTytiQO9fTMSumGiNI+Ln40EbsxWdSxIYu8ISIZaY1srrHnXNrQT
 nSdeTv0/zPLHuKOUIXHnvtOgadPuhXpCNyE5graiyfYuSwL+6aHlZVqr1Xl/TwXKCdnJiBDqn
 V1MnQIp/S/mw2nHmnY16Ue3pg72XepCjY645B9BtzGH0vwGxCWl41+Px6zUJlh2vR4/vRQzNj
 JTCxYC+uVCm2f8+dtFa+84PQVMoaC/+BeTNQjmos1hgLpuOkBLGqyk8IRIDdvqS99CF8YKyXU
 UomTlWoXDWzPFmVtcCxtapI6yk0fxZ3WzropEkhFTMncTv8lHTkURZcpla637eMVsVs2MyX9q
 GhY6l/fTQsrKoC0FDnmc6UL76h4Hbd8CmGBoZ0qNy40fpvIOQoMr+cfVdONDB0h/HE+erCA9z
 swwgI8WiQDqvqpJ1lsQw==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 14.11.20 um 22:40 schrieb Ren=C3=A9 Scharfe:
> chdir_notify_register() allows registering functions to notify when
> chdir() is called.  There is no way to unsubscribe or shut this
> mechanism down, so these entries are present until the program ends.
>
> Valgrind reports allocations for these registrations as "possibly lost",
> probably because it doesn't see through list.h's offsetof tricks.

Right, avoiding list.h like below lets Valgrind classify the memory as
"still reachable", without UNLEAK.  Not sure if it's worth it, though.

Note my somewhat concerning knee-jerk reaction to write some macros. ;)

=2D--
 chdir-notify.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/chdir-notify.c b/chdir-notify.c
index b236288416..4ce1f1120b 100644
=2D-- a/chdir-notify.c
+++ b/chdir-notify.c
@@ -1,26 +1,32 @@
 #include "cache.h"
 #include "chdir-notify.h"
-#include "list.h"
 #include "strbuf.h"

 struct chdir_notify_entry {
 	const char *name;
 	chdir_notify_callback cb;
 	void *data;
-	struct list_head list;
 };
-static LIST_HEAD(chdir_notify_entries);
+
+#define VECTOR_TYPE(elemtype) struct { elemtype *v; size_t alloc, nr; }
+#define VECTOR_FOR_EACH(x, p) for (p =3D (x)->v; p < (x)->v + (x)->nr; p+=
+)
+#define VECTOR_NEW_ENTRY(x, p) do {			\
+	ALLOC_GROW_BY((x)->v, (x)->nr, 1, (x)->alloc);	\
+	p =3D (x)->v + (x)->nr - 1;			\
+} while (0)
+
+static VECTOR_TYPE(struct chdir_notify_entry) chdir_notify_entries;

 void chdir_notify_register(const char *name,
 			   chdir_notify_callback cb,
 			   void *data)
 {
-	struct chdir_notify_entry *e =3D xmalloc(sizeof(*e));
-	UNLEAK(e);
+	struct chdir_notify_entry *e;
+
+	VECTOR_NEW_ENTRY(&chdir_notify_entries, e);
 	e->name =3D name;
 	e->cb =3D cb;
 	e->data =3D data;
-	list_add_tail(&e->list, &chdir_notify_entries);
 }

 static void reparent_cb(const char *name,
@@ -52,7 +58,7 @@ void chdir_notify_reparent(const char *name, char **path=
)
 int chdir_notify(const char *new_cwd)
 {
 	struct strbuf old_cwd =3D STRBUF_INIT;
-	struct list_head *pos;
+	struct chdir_notify_entry *e;

 	if (strbuf_getcwd(&old_cwd) < 0)
 		return -1;
@@ -67,11 +73,8 @@ int chdir_notify(const char *new_cwd)
 			 "setup: chdir from '%s' to '%s'",
 			 old_cwd.buf, new_cwd);

-	list_for_each(pos, &chdir_notify_entries) {
-		struct chdir_notify_entry *e =3D
-			list_entry(pos, struct chdir_notify_entry, list);
+	VECTOR_FOR_EACH(&chdir_notify_entries, e)
 		e->cb(e->name, old_cwd.buf, new_cwd, e->data);
-	}

 	strbuf_release(&old_cwd);
 	return 0;
=2D-
2.29.2

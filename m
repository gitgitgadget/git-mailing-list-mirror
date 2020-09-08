Return-Path: <SRS0=ga/5=CR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21A39C2D0E2
	for <git@archiver.kernel.org>; Tue,  8 Sep 2020 20:52:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E23E52145D
	for <git@archiver.kernel.org>; Tue,  8 Sep 2020 20:52:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="SfuNjeOe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730369AbgIHUwr (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Sep 2020 16:52:47 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62517 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730104AbgIHUwj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Sep 2020 16:52:39 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7D20B8B6C6;
        Tue,  8 Sep 2020 16:52:35 -0400 (EDT)
        (envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=sasl; bh=ROfCNOzMFGP0ILtWEJfnlBEUG
        OA=; b=SfuNjeOeunycyIARvJsFb/RsLUgQf4mEHbPsJbjk9m0OxBOpp2aw9/EPY
        Hy3+S6prEYQSyJTb+WJF/BbZLKwVjJPPiGV0Y5G3O7tXzGaimyshcS1Gsz8JnMZo
        cXJb/y6dC4peXs1sJ4P1BPVdPUuAIwd1hCthCsxiXWfLUip+8c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; q=dns; s=sasl; b=KeID8r2ApmbOfjP5Kph
        qcxQAZi8P1nC+EPWtpItbh6XHtt3RGg9NjYUetmaGI0YBCExitwZsbkqK5CJ3jpr
        Jl/HvVx8634LFzSTinnRXULQ+eyi3RdLW61he7i4gbsYiXUQnCO/174g4IJQPXte
        CM3j8oSOpE72iNVxH8mUo96s=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 73F388B6C5;
        Tue,  8 Sep 2020 16:52:35 -0400 (EDT)
        (envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E49D48B6C4;
        Tue,  8 Sep 2020 16:52:34 -0400 (EDT)
        (envelope-from gitster@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH 5/6] quote: rename misnamed sq_lookup[] to cq_lookup[]
Date:   Tue,  8 Sep 2020 13:52:23 -0700
Message-Id: <20200908205224.4126551-6-gitster@pobox.com>
X-Mailer: git-send-email 2.28.0-539-g66371d8995
In-Reply-To: <20200908205224.4126551-1-gitster@pobox.com>
References: <20200908013013.1099937-1-sandals@crustytoothpaste.net>
 <20200908205224.4126551-1-gitster@pobox.com>
MIME-Version: 1.0
X-Pobox-Relay-ID: 38CF05D6-F215-11EA-B067-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This table is used to see if each byte needs quoting when responding
to a request to C-quote the string, not quoting with single-quote in
the shell style.  Similarly, sq_must_quote() is fed each byte from
the string being C-quoted.

No behaviour change intended.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 quote.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/quote.c b/quote.c
index aa9a37b1b1..016ebf8873 100644
--- a/quote.c
+++ b/quote.c
@@ -210,7 +210,7 @@ int sq_dequote_to_strvec(char *arg, struct strvec *ar=
ray)
  */
 #define X8(x)   x, x, x, x, x, x, x, x
 #define X16(x)  X8(x), X8(x)
-static signed char const sq_lookup[256] =3D {
+static signed char const cq_lookup[256] =3D {
 	/*           0    1    2    3    4    5    6    7 */
 	/* 0x00 */   1,   1,   1,   1,   1,   1,   1, 'a',
 	/* 0x08 */ 'b', 't', 'n', 'v', 'f', 'r',   1,   1,
@@ -223,9 +223,9 @@ static signed char const sq_lookup[256] =3D {
 	/* 0x80 */ /* set to 0 */
 };
=20
-static inline int sq_must_quote(char c)
+static inline int cq_must_quote(char c)
 {
-	return sq_lookup[(unsigned char)c] + quote_path_fully > 0;
+	return cq_lookup[(unsigned char)c] + quote_path_fully > 0;
 }
=20
 /* returns the longest prefix not needing a quote up to maxlen if positi=
ve.
@@ -235,9 +235,9 @@ static size_t next_quote_pos(const char *s, ssize_t m=
axlen)
 {
 	size_t len;
 	if (maxlen < 0) {
-		for (len =3D 0; !sq_must_quote(s[len]); len++);
+		for (len =3D 0; !cq_must_quote(s[len]); len++);
 	} else {
-		for (len =3D 0; len < maxlen && !sq_must_quote(s[len]); len++);
+		for (len =3D 0; len < maxlen && !cq_must_quote(s[len]); len++);
 	}
 	return len;
 }
@@ -291,8 +291,8 @@ static size_t quote_c_style_counted(const char *name,=
 ssize_t maxlen,
 		ch =3D (unsigned char)*p++;
 		if (maxlen >=3D 0)
 			maxlen -=3D len + 1;
-		if (sq_lookup[ch] >=3D ' ') {
-			EMIT(sq_lookup[ch]);
+		if (cq_lookup[ch] >=3D ' ') {
+			EMIT(cq_lookup[ch]);
 		} else {
 			EMIT(((ch >> 6) & 03) + '0');
 			EMIT(((ch >> 3) & 07) + '0');
--=20
2.28.0-539-g66371d8995


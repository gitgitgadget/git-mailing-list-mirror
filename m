Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3A47E574
	for <git@vger.kernel.org>; Tue,  6 Feb 2024 05:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707196366; cv=none; b=m9cCsB8aeYq7yp33lyPnpWRCPu47S8V9sSuqYiYweOBtdIsuFbU6edCF+EZXdxpIRNqd8sILjNUKgxYozC/IvSpHKK0whrb/WLNwU3GUEyGpY2BO3sWz4C/w/nypQAcGpaD3afR2QJE+f5S7VqTtMDBQRZ4DQEl38/MM/6sdlkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707196366; c=relaxed/simple;
	bh=xg9DmrlP8CZiA29lppB385p+cV6w4th3X+6z9RyxKVw=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=oMtlhmSEtOHPvYmfjrIveGA5xB70Dq8tcNZ9g2z5k88GyKtg92oe4ogjI6IrUKTnVgAa+G4Yhfq8yzWSRYICXZnXMDUN8eTgR8FO5PaISgzESOWof++/Kd+mwq2dSBBIt919Ok3l1vXCl5TcDlOYTZ+6jM8E06kAFg2s3yoFoQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y0ef1FKB; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y0ef1FKB"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-33b0f36b808so3357292f8f.3
        for <git@vger.kernel.org>; Mon, 05 Feb 2024 21:12:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707196363; x=1707801163; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xS9QkJvX6g6toL4d2+AnC/AfdgHX48SvVCnk6yON2dk=;
        b=Y0ef1FKB0jqUkJUCTL8b+6tWU3DOQ76taAJEOM4ebXf9RxWkXTNPXvHRFKcDy4YyMe
         uoZnokp7jEYyCwkSeqq7SIM7CjRuWL2N0Sm+dM5E0r5GSxkNraaCEkj9f/JaOJKiDQAz
         91JuGXSbk0IGCWiY2U0JwWnJ8KSKFDg8cL0DWbFoxeHB2ENrQWpuAa8/UtJzzkxwD1O1
         l+hfWL6kY6l+CSa8jUXyrgutQGogNwUN9Ht5vEccdjpiWiwSrNaQLiqL7Mlha6x/l9rj
         aDsFNpYZjwlR4DuN+zqkNv0RBdT6RVAp3+uEyROE33AeEYqIkmXO6cLFQjROyi6be69f
         HNOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707196363; x=1707801163;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xS9QkJvX6g6toL4d2+AnC/AfdgHX48SvVCnk6yON2dk=;
        b=VbT33/ZnMVnQRNr33XteWERT1A6FOByjdBNn3ZCXePlBoT1NJ97QWRD8vgWLT9ajxU
         01lBRwLrAwAvYMumA1LmpiITBLCMNplLRXC+Ap+oxSwgJPuLoXVjh57y7bJb4el/hjgp
         oy5eQ1KtlX9RMaaDRMz5O4ax9t/0S+JUtiKuRrppMsG0js6MHvaFkTdulACr5X2tXg9q
         UA4N7TNFZ5KM9sRJ5XPNznmBpzLJwrhdp4yiFMmSyHpXmlIEnBBp8oQXnqRIKtavKZ3Z
         fjKuMVcdQHXLOv4arDigYYjoyepdhX/LAA2s2wlRjw7r/ruRpozq8fmlFRikeQoyUjyH
         gsNw==
X-Gm-Message-State: AOJu0YyUAaQxZ/Cr2BueqZOT3++B8nABxYClezktcYkY5H1f1+LFXj36
	SYLoYC7yjGNSPDpWFgozfP8V/28TUE4V6TLc3pKzp8DPrOw2QGBLLgQG66YF
X-Google-Smtp-Source: AGHT+IHM1UYfv0rm+O0/ypxNyT5o5LwAuQpCQBx40cv+a4HLV4qlhYtAHCvBFpgJFjlbH5fam7evKg==
X-Received: by 2002:a05:6000:184a:b0:33b:3559:2815 with SMTP id c10-20020a056000184a00b0033b35592815mr482312wri.0.1707196363164;
        Mon, 05 Feb 2024 21:12:43 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUdOy7TQkpFtOEz2FteLj10aj3VG42u3nqvrYQYC9KH5+U+6MB4eaOal0vZNNdX60b7ybSLIrNzwFV/rMjAMXK76kevj1e4lRqDIff//FcRRbgLpVjKJRxp9P4FZXIm8FsGsrje62hXT1h9d1Fb5ka3janACfDsFEmnmIO0dCdRrHOpYf2nVFo/1HreTq5asudws2q8zm1+Ow==
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u21-20020a05600c139500b0040e813f1f31sm645646wmf.25.2024.02.05.21.12.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 21:12:42 -0800 (PST)
Message-ID: <11f854399db2b0da5d82cad910c3b86ca9c2e0db.1707196348.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1632.v4.git.1707196348.gitgitgadget@gmail.com>
References: <pull.1632.v3.git.1706664144.gitgitgadget@gmail.com>
	<pull.1632.v4.git.1707196348.gitgitgadget@gmail.com>
From: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 06 Feb 2024 05:12:14 +0000
Subject: [PATCH v4 14/28] format_trailer_info(): teach it about
 opts->trim_empty
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Christian Couder <chriscool@tuxfamily.org>,
    Junio C Hamano <gitster@pobox.com>,
    Emily Shaffer <nasamuffin@google.com>,
    Josh Steadmon <steadmon@google.com>,
    "Randall S. Becker" <rsbecker@nexbridge.com>,
    Linus Arver <linusa@google.com>,
    Linus Arver <linusa@google.com>

From: Linus Arver <linusa@google.com>

This fixes 4 tests in t7513 to go from

    t7513-interpret-trailers.sh  (Wstat: 256 (exited 1) Tests: 94 Failed: 55)
      Failed tests:  2-5, 8, 14, 24-28, 31-37, 43-62, 66-74
                    77-80, 82-85

to

    t7513-interpret-trailers.sh  (Wstat: 256 (exited 1) Tests: 94 Failed: 51)
      Failed tests:  2-5, 14, 24-28, 31-32, 36-37, 43-62, 66-74
                    77-80, 82-85

. The next patch will fix the remaining broken test cases in t7513 and
t7502.

Even though the next patch fixes the vast majority of these test cases,
we have to position that patch after this one to avoid breaking the
build because of the way these patches delete relevant (and obsolete)
code.

Signed-off-by: Linus Arver <linusa@google.com>
---
 trailer.c | 23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/trailer.c b/trailer.c
index f4defad3dae..c28b6c11cc5 100644
--- a/trailer.c
+++ b/trailer.c
@@ -162,20 +162,6 @@ static void print_tok_val(struct strbuf *out, const char *tok, const char *val)
 		strbuf_addf(out, "%s%c %s\n", tok, separators[0], val);
 }
 
-static void format_trailers(const struct process_trailer_options *opts,
-			    struct list_head *trailers,
-			    struct strbuf *out)
-{
-	struct list_head *pos;
-	struct trailer_item *item;
-	list_for_each(pos, trailers) {
-		item = list_entry(pos, struct trailer_item, list);
-		if ((!opts->trim_empty || strlen(item->value) > 0) &&
-		    (!opts->only_trailers || item->token))
-			print_tok_val(out, item->token, item->value);
-	}
-}
-
 static struct trailer_item *trailer_from_arg(struct arg_item *arg_tok)
 {
 	struct trailer_item *new_item = xcalloc(1, sizeof(*new_item));
@@ -1101,6 +1087,15 @@ void format_trailer_info(const struct process_trailer_options *opts,
 			strbuf_addstr(&tok, item->token);
 			strbuf_addstr(&val, item->value);
 
+			/*
+			 * Skip key/value pairs where the value was empty. This
+			 * can happen from trailers specified without a
+			 * separator, like `--trailer "Reviewed-by"` (no
+			 * corresponding value).
+			 */
+			if (opts->trim_empty && !strlen(item->value))
+				continue;
+
 			if (!opts->filter || opts->filter(&tok, opts->filter_data)) {
 				if (opts->separator && out->len != origlen)
 					strbuf_addbuf(out, opts->separator);
-- 
gitgitgadget


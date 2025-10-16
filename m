Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A5B920322
	for <git@vger.kernel.org>; Thu, 16 Oct 2025 01:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760576701; cv=none; b=W65mETYCt74rQCsOlslVFxRcxT/uA7XthRwAntiNgedtaKHcJys1iPqa9fBV5Ou7zYU3b0queo91qQvDqbqLKIVHwSNDyW66V0NM0EkZ16rSHZmbt8oPaWZqpMmm/8/6OAZsJkiOlm5DmQ0RsGm4XMlsXZLRRFb4Y3AAduQU23M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760576701; c=relaxed/simple;
	bh=ZtTNV3Y11iKLKtYTdkwOsCySLKXsfxig4HuhiaFy/6I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=If3fDY1VKBZin4SQDBxTBirTZf+TAeN8eOC2ys8paZepvSkhBAG1M20lat/8ZSYoOh2t8r412CUNIBUl1yje+lwNPziEKk3GbPNCcPRqiHfUaUhFv4JZpLdkRbu1fFMmw8iY7jgjrLsJJxy8KepoVkV4Ibu4uRnFYXm64FGCmKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Prq4YVuY; arc=none smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Prq4YVuY"
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-63bcfcb800aso247414d50.0
        for <git@vger.kernel.org>; Wed, 15 Oct 2025 18:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760576699; x=1761181499; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UnmS6kR9mPxUh0ulykIXbSqV0U5hnu+l592jF12yuDw=;
        b=Prq4YVuYFPG8DZDHEUvML9xxIC3D98RW97NMn4TpU6V/lQfquVCpa15dVyvThNMn+y
         Toh9AzCoeZgHeuhmVuyXZnzLLdB9KxI6BxkZ+IR14mDQrW+VPzTX029ibn4j5xvQazr7
         LH3XDfh2OWsie3gIixHjTtrlrtD9sK46ev9gnzWy6YrHSlIuTaJqTnSewHbPPOrduV0t
         OfgE8Ju8svnMZAifFm80GI8zfEOH2Nd8jiM3MFEnddsPRTjd6HA4bdwun+ilZsvaoXMh
         nj7jLUvJLVzZpw1B/AB2oxqyQTxBstXPlcFKXO4xkzQIV1gH3jWGZELvoZ7Z6xVvclu/
         x2PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760576699; x=1761181499;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UnmS6kR9mPxUh0ulykIXbSqV0U5hnu+l592jF12yuDw=;
        b=J1Ah7keulzXM3mptUjxHtjmDT584OLkJnzfg7IsOxLxam/poZ/lW5B8iFhhmWgchAa
         twWQ8XLPuaDXWWwPaQO5JNgvH259r/Q1oiWGI2N4+QD5+vsUzyZ6X7QW0uGZP6yz2pBC
         Y612cLavaRwPJnxFLcCELTqaVTGJbRHf5UPk+w1LmNOCCkMF2Zf6/XmhKMZZ6gsqKqde
         UC25FUHAAFi/GUnQwMtN7Up5DUX8B+f1pI+r1gy0IAM2VIx20nTu9Fy4N63RX2Q6cQTh
         FE0du7zeaRZJ4R1rsnNtrZAqUvjOTVJdEs5rIpjGIQHLxQC8b4HKfL54xe1WbhL+iSFU
         P+3g==
X-Gm-Message-State: AOJu0Ywu1v0EyQuswWaWowop7O8fQ+z3CfcwlnePpiVguZoQhvuK/uPI
	jL3awX46CoztOBfgUJKuj2iQ0Lc/BLC1H5kUR5xtV+9nHpr3QaB8lxRC
X-Gm-Gg: ASbGnctQ7ArranlIcIhhJcooqRXMvjshPQuPNHZU7ebp7YeYQk8w23UryqLbtY/g5T7
	10QTFauVUyQFszuiqyfbgajZ1jlg2EeA4JUYx+JRwKvhjbuKoKlAgHrQlVbqHp5UWQkQudrb/cC
	LcptkXWmGcPBAZmjLbTateFFJIeBB5oFslu3UBP3RM21iVsjLOU1A2OZz/st1UzHaZuwpXUA0PC
	uKzMgN7mwstx6XFWs+8CAbRXcFseYESOe+dxAx02Tk7bxFn8GZrOBDt6/uipRDWcgFrz4HwfHsj
	y14DP1UuC+WxJzC/w0sS4993bSclL3I932FqZmV+QK+TxEfHJmZEyYsHdVljc4VLDthhvtig0kh
	dbKV7MKAQNPLNy73UDA90461frA9gqOpvuW5iadGFndumLQTtYUUrQSYGV5H/DSTviYb2tDURUz
	3q1Uze
X-Google-Smtp-Source: AGHT+IHPo+l5qLEzMNG4h+EYwAPqb2WzJH9R7KHbNE0r486XKPUyAZ9ePs2mXqTC3ugcOVO19yWi9w==
X-Received: by 2002:a53:acc2:0:10b0:63c:f332:974e with SMTP id 956f58d0204a3-63cf332b078mr13487486d50.12.1760576698660;
        Wed, 15 Oct 2025 18:04:58 -0700 (PDT)
Received: from ubuntu ([105.117.3.242])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-782935fdacasm3478537b3.57.2025.10.15.18.04.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 18:04:58 -0700 (PDT)
From: Olamide Caleb Bello <belkid98@gmail.com>
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
	gitster@pobox.com,
	usmanakinyemi202@gmail.com,
	Olamide Caleb Bello <belkid98@gmail.com>
Subject: [Outreachy PATCH v2 1/2] gpg-interface: replace strbuf_split_max() with string_list_split()
Date: Thu, 16 Oct 2025 01:03:53 +0000
Message-ID: <818ca6b104cf25ebe4c60145d046029f057f4db1.1760571220.git.belkid98@gmail.com>
X-Mailer: git-send-email 2.51.0.463.g79cf913ea9
In-Reply-To: <cover.1760571220.git.belkid98@gmail.com>
References: <cover.1760571220.git.belkid98@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In get_ssh_finger_print(), the output of the `ssh-keygen` command is
put into `fingerprint_stdout

The string in fingerprint_stdout is then split into 3 strbufs using
strbuf_split_max(), however they are not modified after the split thereby
not making use of the strbuf API as the fingerprint token is merely
returned as a char * and not a strbuf, hence they do not need to be strbufs.

Use string_list_split() instead for simplicity.

Note that strbuf_split_max() uses 3 to specify the number of tokens to
extract from the string, while string_list_split() uses 2 because it specifies
the number of times the split will be done on the string, so 2 gives 3 tokens
as it is in the original instance.

Signed-off-by: Olamide Caleb Bello <belkid98@gmail.com>
---
 Changes in v2
   - Reword the commit message for clarity
   - Add () to the function names
   - Change the test to ensure the number of tokens appended to the
    list by string_list_split() equals 3
 gpg-interface.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/gpg-interface.c b/gpg-interface.c
index 2f4f0e32cb..989dca7d14 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -14,6 +14,7 @@
 #include "sigchain.h"
 #include "tempfile.h"
 #include "alias.h"
+#include "string-list.h"
 
 static int git_gpg_config(const char *, const char *,
 			  const struct config_context *, void *);
@@ -821,7 +822,7 @@ static char *get_ssh_key_fingerprint(const char *signing_key)
 	struct child_process ssh_keygen = CHILD_PROCESS_INIT;
 	int ret = -1;
 	struct strbuf fingerprint_stdout = STRBUF_INIT;
-	struct strbuf **fingerprint;
+	struct string_list split = STRING_LIST_INIT_DUP;
 	char *fingerprint_ret;
 	const char *literal_key = NULL;
 
@@ -845,13 +846,12 @@ static char *get_ssh_key_fingerprint(const char *signing_key)
 		die_errno(_("failed to get the ssh fingerprint for key '%s'"),
 			  signing_key);
 
-	fingerprint = strbuf_split_max(&fingerprint_stdout, ' ', 3);
-	if (!fingerprint[1])
+	if (string_list_split(&split, fingerprint_stdout.buf, " ", 2) != 3)
 		die_errno(_("failed to get the ssh fingerprint for key '%s'"),
 			  signing_key);
 
-	fingerprint_ret = strbuf_detach(fingerprint[1], NULL);
-	strbuf_list_free(fingerprint);
+	fingerprint_ret = xstrdup(split.items[1].string);
+	string_list_clear(&split, 0);
 	strbuf_release(&fingerprint_stdout);
 	return fingerprint_ret;
 }
-- 
2.51.0.463.g79cf913ea9


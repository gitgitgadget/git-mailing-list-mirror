Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA4E1DE2D7
	for <git@vger.kernel.org>; Thu, 16 Oct 2025 01:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760576706; cv=none; b=C97WyHz5TDp2k0wfomzIR7Rt70M7qOjB3qd5Dp257IqVw1nGTtSkrAdEi3Od8XX97MbFeZP/AlvlKf7KBJ5ySupImweZDCzSM8vpGa1gS7JlScx6SJwxPSHvmB7/r+UI10xpV2ze9GTBSo3n3DsuLTOwlCoysnsDIR+zpB8q4CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760576706; c=relaxed/simple;
	bh=mDYjpUBeaQJBuGjpBpUiohzVoQ/pXxDWlm0oUgUcJFE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gKdgixhsBuJ3ccAwutgh4N0nit1zRf0orJKptNU4O13w5r7r8k19v9bGXkNt1jPe5QG/sIIFQfGE9IoWh0SuEDcbQtLHXAX/9wWP8+Xa4EaO62R/LN9f+6XvFkK+Vxn/ZsmGyjZ257j1xZNMTLngLdxAvzFONP88nAg77kJ+Zvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J3nz56bZ; arc=none smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J3nz56bZ"
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-635401a8f5aso168951d50.1
        for <git@vger.kernel.org>; Wed, 15 Oct 2025 18:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760576703; x=1761181503; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KdB+Vjs+k5FtiN6KjPGHVeB1wW/XzKTKw2dPtPbzxfE=;
        b=J3nz56bZjFfpnkS/usbv0Si6f7mGrnsFZDvvoO8s+87zacmCYRxPCtA/IOREKmciwP
         kiCHAAfd1T3KD/MfzcMDbnxjFbi4+iWfP8iXtz1hO70fKSEnM2cu111HFL7iYnw0dk+F
         4IeLlZApJPghQgCG2IwsPNebXjHYW0+95I3ycCQH8fY3/ilT9qYV8fm4EsfX8rc/bwyg
         54Ue3umdSMC+t0FEbaMvxAVgCrKpWnMOpppaS9fQPxqgl7LGXCq0ISaYb6YMIga1mbk9
         f1KLHT+u+BVd3so08qki9nAq8Kgb12/E/ZsIPuDxopLboNnXhHCMC+ghCA6BOwQHlW9T
         cxig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760576703; x=1761181503;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KdB+Vjs+k5FtiN6KjPGHVeB1wW/XzKTKw2dPtPbzxfE=;
        b=f2y+6Tk9tcnxwiIGiOrmzqXx7ObRQcrDTGQpNpnDVM/iV8JCd0WNVCrBiYI3Mo6qPT
         kfLUou9GLlErp1dSqhPMmap8qHXBlF7Yq+44rvYjWxEPTAp4MIZboBKiV7y894mRu06g
         vSdtZzltiawlUN6OzhEAxLjblMCI/Xw2ZsEiWdjTBuTG76Hkw//z4Vn0Rfl8MHqD8A+s
         jC1buOSrXo3FC5IY3A6aep6T+AZt+MgmliqPzhFDFRhtBq0sYoEdbD4tEhUAHiLwbG1N
         v3G/BaAJMgDLBFrXKzlpDWiOvg5rOLtBVHOYDWgch85BoNQRbXVDDDna6cX4MIiG0MGq
         VSXg==
X-Gm-Message-State: AOJu0YydzPkPg8Of/Bafe2JFtpQC2xEWC6KWwyFYRukCIjVbpRhEjS+g
	gqo7s5P3fU3uOpBcHdADN005y+lr+sTt7CEhkge+YRbwIo2X0PK94gyC
X-Gm-Gg: ASbGncttktSUntLHZ25TJguMY6Zyj5tb+JeJNFWN+i7YqYAE7Ez/ioYCjObY1hfdcUt
	3VfLlkZ5cLPzGP8iN1+HCd5pZMW5AmYu3OigQlpX4hWvTOzNq78cz9X8VLZkwnZdDAQStytnkbu
	rRUuEBK+sLc4art1Yor7KQ2lxTO4qf0B/lfIRhLBuWvP8phu1ENvW441MmDbd35/jc3bs1VVT7p
	QZJ9nvmV2IYkGH/53pRUfVBlcvsqUrlONUsYrcQcElm4JmDh2X2rCjan/o0VhgVZXTiTGm6PjgV
	IRFGOxerCbqD0da4yXTycuFzyCvT9mWH3BLVybshkq+iqWXk/TiOGlaObxHaPGp96Dg9quMGmn8
	SD+PTbfKrZlwUBaT3TXtjyfxhoje2qMokj5nE9pAuKeWQNrhAaWdWEFaouOV6y7IAfhXIFQ==
X-Google-Smtp-Source: AGHT+IEtRBwXLByavEYVyFhp4bnD1esKezOK+hTl7nCJ2MlufFZ2P7TABIu6pecYMas48Puy0qnBlA==
X-Received: by 2002:a05:690e:4142:b0:63c:f4eb:1b0d with SMTP id 956f58d0204a3-63cf4eb1b25mr15228425d50.22.1760576702829;
        Wed, 15 Oct 2025 18:05:02 -0700 (PDT)
Received: from ubuntu ([105.117.3.242])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7828cdd2764sm3692407b3.6.2025.10.15.18.05.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 18:05:02 -0700 (PDT)
From: Olamide Caleb Bello <belkid98@gmail.com>
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
	gitster@pobox.com,
	usmanakinyemi202@gmail.com,
	Olamide Caleb Bello <belkid98@gmail.com>
Subject: [Outreachy PATCH v2 2/2] gpg-interface: use string_list_split() instead of strbuf_split_max()
Date: Thu, 16 Oct 2025 01:03:54 +0000
Message-ID: <024a44a242394f5a067f17ec97a99c61232898fe.1760571220.git.belkid98@gmail.com>
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

In get_default_ssh_signing_key(), the default ssh signing key is
retrieved in `key_stdout`, which is then split using
strbuf_split_max() into two tokens

The string in `key_stdout` is then split using strbuf_split_max() into
two tokens at a new line and the first token is returned as a `char *`
and not a strbuf.
This makes the function lack the use of strbuf API as no edits are
performed on the split tokens.

Replace strbuf_split_max() with string_list_split() for simplicity.

Note that strbuf_split_max() uses `2` to indicate the number of tokens
to extract from the string, while string_list_split() uses `1` to specify
the number of times the split will be done on the string, so 1 gives 2
tokens as it is in the original instance.

Signed-off-by: Olamide Caleb Bello <belkid98@gmail.com>
---
Changes in v2
 - Reword the commit message for clarity
 - Replace the comment removed in v1
 - Change the test to ensure the number of tokens added to the list by
   string_list_split() equals 2
 - Add () to function names

 gpg-interface.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/gpg-interface.c b/gpg-interface.c
index 989dca7d14..ab7b8b46e5 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -862,7 +862,7 @@ static char *get_default_ssh_signing_key(void)
 	struct child_process ssh_default_key = CHILD_PROCESS_INIT;
 	int ret = -1;
 	struct strbuf key_stdout = STRBUF_INIT, key_stderr = STRBUF_INIT;
-	struct strbuf **keys;
+	struct string_list keys = STRING_LIST_INIT_DUP;
 	char *key_command = NULL;
 	const char **argv;
 	int n;
@@ -884,19 +884,19 @@ static char *get_default_ssh_signing_key(void)
 			   &key_stderr, 0);
 
 	if (!ret) {
-		keys = strbuf_split_max(&key_stdout, '\n', 2);
-		if (keys[0] && is_literal_ssh_key(keys[0]->buf, &literal_key)) {
+		if (string_list_split(&keys, key_stdout.buf, "\n", 1) == 2 &&
+			is_literal_ssh_key(keys.items[0].string, &literal_key)) {
 			/*
 			 * We only use `is_literal_ssh_key` here to check validity
 			 * The prefix will be stripped when the key is used.
 			 */
-			default_key = strbuf_detach(keys[0], NULL);
+			default_key = xstrdup(keys.items[0].string);
 		} else {
 			warning(_("gpg.ssh.defaultKeyCommand succeeded but returned no keys: %s %s"),
 				key_stderr.buf, key_stdout.buf);
 		}
 
-		strbuf_list_free(keys);
+		string_list_clear(&keys, 0);
 	} else {
 		warning(_("gpg.ssh.defaultKeyCommand failed: %s %s"),
 			key_stderr.buf, key_stdout.buf);
-- 
2.51.0.463.g79cf913ea9


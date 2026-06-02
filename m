Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE0A2EA173
	for <git@vger.kernel.org>; Tue,  2 Jun 2026 18:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780425813; cv=none; b=Rafvy0tbw4WYxTygnPv0JSJEQ26t8NBPMYpBSPBBDket5ad2gS2EuiGTWZKGOI7/mwVmBmDc2ELZ+yr29brYO+e/kFlLOagdrewB9SuEsUn2oUjvqaxyHxIr+c2doknABZdKiSQ6NpwlIpLVetwkGAYuvabHij+Pfa9xVIE+f/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780425813; c=relaxed/simple;
	bh=Diy+dhsHi0+hfJBrjHouOaZ63hy9yli9sJkz+0+XKrw=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=uwmGBKfGQfAfi/u8Eu52CXnF5FaAfPOlwcvIaPdMYyVpvLYCnrqbZVsbK6C2umCSub+7gREIoPMxXVFH8hCmJYNug0J2iIR7c1cco0+gRonCuvhp7D1pGXO15PgffwT8fRxwZrqw8/MQ6D2mxO302pVxtfxlG2Qp+o3jwEJ+28g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pFWLLUPX; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pFWLLUPX"
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-69d60694c9bso7057789eaf.2
        for <git@vger.kernel.org>; Tue, 02 Jun 2026 11:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780425811; x=1781030611; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Aid0+5VdKCyQe7twMw1YmB4cypadMvxga9wH8bn1Aus=;
        b=pFWLLUPXglM4Nr2NPvoVkn3msgP2VrvbhJJm12S7HVYLBJCVlbxeY2VmBa9+W6WEr3
         GPcCkLjYdpXDZRvauuOLRHAomX+owWQLVLr3llESN+MOmKBXfbLEsm33QQsOYnJWhhgQ
         g2reufP8oL2mQgMakz/fnaadP/YOcubFu0lVqhh0DCfxQlIpYOedV0P1vPH6fQVem6NC
         Tf+XNYjXaLgtRbFKpTtZ3vBIC4C/XiR2I8U7jzjZ3R0ArPbtemfR2Jy1Zm8KS/6cNVqb
         bOoIZ/5IqAWFvSRBfE0w/FdaeIUHJZkSrtEyWp/Y2nTEb/qeJGprck2/I1SceWQ9cJce
         jggQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780425811; x=1781030611;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Aid0+5VdKCyQe7twMw1YmB4cypadMvxga9wH8bn1Aus=;
        b=DbwmTvu99FNAI8+y3exU465rgDW/UfNCU5xUXQN5vWwoh1a13ZEMuqZXqx1XlkxJad
         Tkle03q5LSswfnplVsdgoQvdcnhLgvkIR+7MjteFQt8o6Ak2mRL8iZtGihB5gCk3jhZB
         x2Arrgii/q2fY7l7UIFjAEXHV7lgwil2rzUpXWE03rCWDDE677UILfvg8f7e/Rf26uHv
         d0jXpBt/kwV/bheyUYDVkY3yFwOkVqxp37hau+E945jnZvm9aLTtBPyOiIwiBX10caDx
         kf0XTTDoNSwJjGBTkqbWXZ+Fb0Eh5cZOHgw5R3/I/wFBXFRLKNUSzBaJqwFr8VrwtxBm
         G0mg==
X-Gm-Message-State: AOJu0Yzd3NqbQp85Tv3FqZUVMRMolLidkCPuMhWC3AODrBosLetSclhX
	5Y8iuqVHeFOQISHPi1YKbBOaoRwn0/eRcRQL5DKQKz4P4UjT+/CVsJ/q/4i+bQ==
X-Gm-Gg: Acq92OH39S3gepjblgCnH1TezhwsYsX06BUWNQd3MrsNmAVuACtByeeHZKSCTxKz5lR
	gjpnyw451xtt1VwFX9/AOgktc3dgM6XNMlD6G5MjuO4jdEUY/Vxfsiywh93b1n91B50JBHNoqEx
	aVMGlZYGZ+ts0/4MOAX5SwXbi+fxeYEsbmGO5dyKRVob5KoBsikHT0dutOm8AVMb5a3lbMO/ZlL
	znmV05qD2GkfaZQvE1Vu4EdpxZerG+p3QNH8tIFnayUXP/QXuJ2vUrwjio4Oo68SIGrTsWNG21V
	rQcVJejndBehbQ8txN9EEvWnS0xIbceRgpwwqNipvMV9T+YqckGjg+pWlTXRXZH+BK9PpvdVsCG
	VZ3yN7AKmvjoGp5Gl2lVWXLuQPB7YZrDA0Ce8jopzTCBiBuGi0Bvac8TC0K80O7MI+DCh0NF5RJ
	jQHAbArv7BmSUdO0q8HL2DBIH/hMJeEVNmYYsv
X-Received: by 2002:a4a:d8d3:0:b0:69d:c156:b9e with SMTP id 006d021491bc7-69e47eb97b9mr149414eaf.20.1780425811233;
        Tue, 02 Jun 2026 11:43:31 -0700 (PDT)
Received: from [127.0.0.1] ([20.80.108.168])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-69e46404817sm403974eaf.11.2026.06.02.11.43.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 11:43:30 -0700 (PDT)
Message-Id: <7400ca41bbacab40c28f21f63327a9808e568e05.1780425808.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2302.v6.git.git.1780425808.gitgitgadget@gmail.com>
References: <pull.2302.v5.git.git.1780407557.gitgitgadget@gmail.com>
	<pull.2302.v6.git.git.1780425808.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 02 Jun 2026 18:43:27 +0000
Subject: [PATCH v6 1/2] config: add git_config_key_is_valid() for quiet
 validation
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
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

Move the body of git_config_parse_key() into a static helper
do_parse_config_key() that takes a "quiet" flag and treats
store_key as optional.  git_config_parse_key() becomes a thin
wrapper.

Add git_config_key_is_valid() for callers that only need to
know whether a key is well-formed.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 config.c | 38 +++++++++++++++++++++++++++++---------
 config.h |  2 ++
 2 files changed, 31 insertions(+), 9 deletions(-)

diff --git a/config.c b/config.c
index a1b92fe083..45144f73c5 100644
--- a/config.c
+++ b/config.c
@@ -536,11 +536,14 @@ static inline int iskeychar(int c)
  * -2 if there is no section name in the key.
  *
  * store_key - pointer to char* which will hold a copy of the key with
- *             lowercase section and variable name
+ *             lowercase section and variable name, can be NULL to skip
+ *             allocation when only validation is needed
  * baselen - pointer to size_t which will hold the length of the
  *           section + subsection part, can be NULL
+ * quiet - when non-zero, suppress error() reports on rejection
  */
-int git_config_parse_key(const char *key, char **store_key, size_t *baselen_)
+static int do_parse_config_key(const char *key, char **store_key,
+			       size_t *baselen_, int quiet)
 {
 	size_t i, baselen;
 	int dot;
@@ -552,12 +555,14 @@ int git_config_parse_key(const char *key, char **store_key, size_t *baselen_)
 	 */
 
 	if (last_dot == NULL || last_dot == key) {
-		error(_("key does not contain a section: %s"), key);
+		if (!quiet)
+			error(_("key does not contain a section: %s"), key);
 		return -CONFIG_NO_SECTION_OR_NAME;
 	}
 
 	if (!last_dot[1]) {
-		error(_("key does not contain variable name: %s"), key);
+		if (!quiet)
+			error(_("key does not contain variable name: %s"), key);
 		return -CONFIG_NO_SECTION_OR_NAME;
 	}
 
@@ -568,7 +573,8 @@ int git_config_parse_key(const char *key, char **store_key, size_t *baselen_)
 	/*
 	 * Validate the key and while at it, lower case it for matching.
 	 */
-	*store_key = xmallocz(strlen(key));
+	if (store_key)
+		*store_key = xmallocz(strlen(key));
 
 	dot = 0;
 	for (i = 0; key[i]; i++) {
@@ -579,24 +585,38 @@ int git_config_parse_key(const char *key, char **store_key, size_t *baselen_)
 		if (!dot || i > baselen) {
 			if (!iskeychar(c) ||
 			    (i == baselen + 1 && !isalpha(c))) {
-				error(_("invalid key: %s"), key);
+				if (!quiet)
+					error(_("invalid key: %s"), key);
 				goto out_free_ret_1;
 			}
 			c = tolower(c);
 		} else if (c == '\n') {
-			error(_("invalid key (newline): %s"), key);
+			if (!quiet)
+				error(_("invalid key (newline): %s"), key);
 			goto out_free_ret_1;
 		}
-		(*store_key)[i] = c;
+		if (store_key)
+			(*store_key)[i] = c;
 	}
 
 	return 0;
 
 out_free_ret_1:
-	FREE_AND_NULL(*store_key);
+	if (store_key)
+		FREE_AND_NULL(*store_key);
 	return -CONFIG_INVALID_KEY;
 }
 
+int git_config_parse_key(const char *key, char **store_key, size_t *baselen_)
+{
+	return do_parse_config_key(key, store_key, baselen_, 0);
+}
+
+int git_config_key_is_valid(const char *key)
+{
+	return !do_parse_config_key(key, NULL, NULL, 1);
+}
+
 static int config_parse_pair(const char *key, const char *value,
 			     struct key_value_info *kvi,
 			     config_fn_t fn, void *data)
diff --git a/config.h b/config.h
index bf47fb3afc..31fe3e2961 100644
--- a/config.h
+++ b/config.h
@@ -343,6 +343,8 @@ void repo_config_set(struct repository *, const char *, const char *);
 
 int git_config_parse_key(const char *, char **, size_t *);
 
+int git_config_key_is_valid(const char *);
+
 /*
  * The following macros specify flag bits that alter the behavior
  * of the repo_config_set_multivar*() methods.
-- 
gitgitgadget


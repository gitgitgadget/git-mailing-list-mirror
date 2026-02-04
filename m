Received: from mail-oa1-f68.google.com (mail-oa1-f68.google.com [209.85.160.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FCC041B340
	for <git@vger.kernel.org>; Wed,  4 Feb 2026 14:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770214820; cv=none; b=O66zMVngyVZukPomDcVWlYwazyfixppAnMsRStzi+H6IfAyu48id09dCPyK3/UrToeJmILTXw7XycJQzuvrK16AYCPBOTPqygB0APWqaDfxEpGW3oKfPFJMqqgzt2u6HKuwUa+UYOBp4sK0oIBE7OfIsA+Icyli1h5DnYkXw7jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770214820; c=relaxed/simple;
	bh=1nSk1PwYfp3MSvTiGzNzZ9VEPSwAE0KoNQNw48TtnRM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Cn0byJCVngtQHDihDirUWBOhHw6tDcmK6SLuhRNbTA/gmzlAajuoMgNVhlrG2rrjd39tIQxTCPc8b2MoQZV1CJCcux3Noc9i5ch1YcYhLBAR9dZEaEDTsllFaZlB/twIuOI7H7SmWTJOkiX4gzvXBbZHuwnuhGnX8SV0HekiVVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J+kUKWGo; arc=none smtp.client-ip=209.85.160.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J+kUKWGo"
Received: by mail-oa1-f68.google.com with SMTP id 586e51a60fabf-4096aab5521so4745364fac.3
        for <git@vger.kernel.org>; Wed, 04 Feb 2026 06:20:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770214818; x=1770819618; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lIlU4yxcQaNZcDPfb/7IpA3K09CmZk4/BfU0jTM59GI=;
        b=J+kUKWGo+2fGTvxw7G8e3gTK4nbXUgijPXPdegq+n8Cb8439zUzfJEm/3xZtWSXeF1
         300LA65pvJVoUWhsn84iHrrteEpHnOgs3ZUCtdOAz4tKaN71hPFJPFNzM8A/It4cnIvN
         9xU7SLfiVapImdiZ+1gwcdvcqy4QemLE0WAP1zuhD2w12W3e/FV2ordvN8QXdGTHmIe0
         eAWlMGUG5cSYhPxQxYrFixrvjCkibfUNT21MeetcUITF/4qGw5PgufZdv5SuGWxJvYQL
         9qF2NppO9TxIHYGozCiCOtnMuGhTnJtb4+fBJv8V7/0UeuaVanvXc60t5ZYbLbIrKy3U
         K/3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770214818; x=1770819618;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lIlU4yxcQaNZcDPfb/7IpA3K09CmZk4/BfU0jTM59GI=;
        b=nWfdEZCHwrUrvSfzwVGUtjkxRlXnGF15B8NCDGJYAsp+5JPXDmXGqncqamKELKhl5b
         TtFjmBTpV1OMjY8JHJiGwVT4tZZgIG7w0VzPXOU5nN+vKBGK4ak2DAi/vDeU9mgG7yPv
         I954fDUvV4kU6o5QF+OlDRID7aSXLodH+oguM6R0Dxoc8MI0KXL5weawCyUvaBK2Wsjx
         OoSOBFqo796awdbkES0TNAe9QLtK6pAswTvhXVpWRr2zqx73eEBYv76lu/VRVTko62x9
         09uBPppQBzDmazgLYhJ3Kb5x3296PLdYEl5EW0Ia6aGAOMXurUk/VeWLRBLFWwvcgdpw
         wtpw==
X-Gm-Message-State: AOJu0Yx0kA0Umcin7pAfNel07Od/EV+Qg0X37CXfjmnanbhRiM1DrPOE
	COdNDYTDWxAi0trNgeefoyb4hFMgekg5QBQTpwmq4KcfkFIxc0keXkcBWc15qUd9
X-Gm-Gg: AZuq6aIoWLAz9NA8pPKkMRUX4wDHDvjdmlX1JgGwsp2ALAeACGaA9kC2pMxQ5hON2GP
	psX4L5A6dyWKrXCOl7/OrSQD53We2WrXUr9CYhSYulrAT9+Tlx9OU4utFKU/sDZJA0E0+w6QiWl
	HrD0gySTztz4hHiwabqvtcdagPN5Pdr2gpzlVBqZ4jGE3gkpC1wpJEfXIuPnjFy4nJQLkqUZi4r
	mPaP0POfPmcEEYIguVPfuTo85DLKUznfErCydeRvVjNFnZCApjBddukAjFsDLyeA78CxJ3fujPq
	KEeMPboaxYPCPQNHjeAfa7pWlPq1/9ZROypEWslfqgFSba7J0ImUawKJ5vpsnvD5U6jZDOZxSpb
	I9ifYPngnD7aBLBlkc6cXLitLQgL6gflz3CgfOAwTLqJoBCemfAbj0x/fMG9UgcNB3GjYJC/rCn
	nDj2BMZH5zmgsGFQ==
X-Received: by 2002:a05:6870:96a8:b0:409:57ae:54e4 with SMTP id 586e51a60fabf-40a53aaee7emr1600844fac.9.1770214818396;
        Wed, 04 Feb 2026 06:20:18 -0800 (PST)
Received: from [127.0.0.1] ([52.173.182.164])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-40a5417f14esm1718826fac.3.2026.02.04.06.20.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 06:20:17 -0800 (PST)
Message-Id: <60443c56f456ca794e299ae8d8bbea23793780b5.1770214803.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2033.git.1770214803.gitgitgadget@gmail.com>
References: <pull.2033.git.1770214803.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 04 Feb 2026 14:20:00 +0000
Subject: [PATCH 08/11] config-batch: pass prefix through commands
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
Cc: gitster@pobox.com,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

The 'help' and 'get' commands of 'git config-batch' have not needed the
prefix parameter from the builtin entrance point, but an upcoming
command will need it in order to identify the location of the
appropriate config file. Pass it through the appropriate functions and
function pointers.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 builtin/config-batch.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/builtin/config-batch.c b/builtin/config-batch.c
index 2c48c4ea37..9829b16c6f 100644
--- a/builtin/config-batch.c
+++ b/builtin/config-batch.c
@@ -67,9 +67,11 @@ static int command_parse_error(const char *command)
  * Return 0 on success.
  */
 typedef int (*command_fn)(struct repository *repo,
+			  const char *prefix,
 			  char *data, size_t data_len);
 
 static int unknown_command(struct repository *repo UNUSED,
+			   const char *prefix UNUSED,
 			   char *data UNUSED, size_t data_len UNUSED)
 {
 	return emit_response(UNKNOWN_COMMAND, NULL);
@@ -176,6 +178,7 @@ static size_t parse_token(char **data, size_t *data_len,
 }
 
 static int help_command_1(struct repository *repo,
+			  const char *prefix UNUSED,
 			  char *data, size_t data_len);
 
 enum value_match_mode {
@@ -292,6 +295,7 @@ static int parse_scope(const char *str, enum config_scope *scope)
  * [N*] indicates optional parameters that are not needed.
  */
 static int get_command_1(struct repository *repo,
+			 const char *prefix UNUSED,
 			 char *data,
 			 size_t data_len)
 {
@@ -402,6 +406,7 @@ static struct command commands[] = {
 #define COMMAND_COUNT ((size_t)(sizeof(commands) / sizeof(*commands)))
 
 static int help_command_1(struct repository *repo UNUSED,
+			  const char *prefix UNUSED,
 			  char *data UNUSED, size_t data_len UNUSED)
 {
 	struct strbuf fmt_str = STRBUF_INIT;
@@ -424,7 +429,8 @@ static int help_command_1(struct repository *repo UNUSED,
 	return 0;
 }
 
-static int process_command_nul(struct repository *repo)
+static int process_command_nul(struct repository *repo,
+			       const char *prefix)
 {
 	static struct strbuf line = STRBUF_INIT;
 	char *data, *command, *versionstr;
@@ -476,7 +482,7 @@ static int process_command_nul(struct repository *repo)
 		if (!commands[i].name[0] ||
 		    (!strcmp(command, commands[i].name) &&
 		     commands[i].version == version)) {
-			res = commands[i].fn(repo, data, data_len);
+			res = commands[i].fn(repo, prefix, data, data_len);
 			goto cleanup;
 		}
 	}
@@ -484,14 +490,15 @@ static int process_command_nul(struct repository *repo)
 	BUG(_("scanned to end of command list, including 'unknown_command'"));
 
 parse_error:
-	res = unknown_command(repo, NULL, 0);
+	res = unknown_command(repo, prefix, NULL, 0);
 
 cleanup:
 	strbuf_release(&line);
 	return res;
 }
 
-static int process_command_whitespace(struct repository *repo)
+static int process_command_whitespace(struct repository *repo,
+				      const char *prefix)
 {
 	static struct strbuf line = STRBUF_INIT;
 	struct string_list tokens = STRING_LIST_INIT_NODUP;
@@ -536,7 +543,7 @@ static int process_command_whitespace(struct repository *repo)
 		if (!commands[i].name[0] ||
 		    (!strcmp(command, commands[i].name) &&
 		     commands[i].version == version)) {
-			res = commands[i].fn(repo, data, data_len);
+			res = commands[i].fn(repo, prefix, data, data_len);
 			goto cleanup;
 		}
 	}
@@ -559,11 +566,12 @@ cleanup:
  *
  * Returns negative value on other catastrophic error.
  */
-static int process_command(struct repository *repo)
+static int process_command(struct repository *repo,
+			   const char *prefix)
 {
 	if (zformat)
-		return process_command_nul(repo);
-	return process_command_whitespace(repo);
+		return process_command_nul(repo, prefix);
+	return process_command_whitespace(repo, prefix);
 }
 
 int cmd_config_batch(int argc,
@@ -586,7 +594,7 @@ int cmd_config_batch(int argc,
 
 	repo_config(repo, git_default_config, NULL);
 
-	while (!(res = process_command(repo)));
+	while (!(res = process_command(repo, prefix)));
 
 	if (res == 1)
 		return 0;
-- 
gitgitgadget


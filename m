Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D4E410D15
	for <git@vger.kernel.org>; Wed,  4 Feb 2026 14:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770214814; cv=none; b=qZVtIeEFXFFXuJdqVC2MAelohmZ0nhGE4aC7fPXocVtf4WbXv62RGY3/vFg3hHQ/AoIdQOYuj6qwuGxM45pQGtQBvpDtS9q0CMARlpHGaXjB1PlygVComqf0jPSTJbT1tNWZOUNmJEJzMfK1WYLa5DAaYqcEwIdIiVYMaKs18V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770214814; c=relaxed/simple;
	bh=tH1HtzmqGv06Pr2Cfzc3xGKUvgQACThgnaPDRv6rCog=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=LRMuc8sHnRLg8vgxNyZVUMAVMl6PsYFw13HBBH9XzDIF8/OVa7Cz8Mu2Mxi+SWZW+OqhFAoZXwSHoqlEUQ6QIonvmAIcPf+3ZvgMk1UNUt7JlYSnrVNiern7CEAgw7HDNZOmwZhwBrKnVcbqMDo5AjcjbZ4eI1K5mpfNqpZ6jNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UL4gQiF6; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UL4gQiF6"
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-4094f6f4b7bso2409591fac.2
        for <git@vger.kernel.org>; Wed, 04 Feb 2026 06:20:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770214813; x=1770819613; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A6EdXsCeuOyiilFp/CPrIKluzKduj/Q84NkMbdQ7me4=;
        b=UL4gQiF6V4HMA+70Mzh4GsieqW15+0W0ufhHWWKGVnw6PW4BE3hOgr3wiQ9U8yiBak
         C3u57amq4pBEuzOHTYGJWXGDFqymGsTxC90nsp9vDfU8CMxaK4/mEkugEIFkcThKbC6t
         sapIOw3eAkarY8dU0RgpSKgiiApSPSd2iWldBiEpq6VVOCZPBQ7IO7pQHHp9IqXBqk2J
         pkn5lDoBUr7DUrbtivCpCZp076OUaM8XmhPCXJW6mp0dR7xBbaX3/K5XYAFY+t/cQcTc
         7w1SJ/DilJEBrfAahvu65jcRfL+CF4hIT5GWp6cXO6dUZsG7S1VwHB26yDovJv0vrApH
         x+9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770214813; x=1770819613;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=A6EdXsCeuOyiilFp/CPrIKluzKduj/Q84NkMbdQ7me4=;
        b=Q359BBGKEYoOzDM6e+Pk2V1PJI/kWBfK19APJPmh+puc/upHD9GLpZzfhAjNFwsYj9
         cVlORP26EeVs8H7lKapIt+lzZEaiO7Mihm4bUW6H48dXzP5T2GlCIxmQKZ0tUnjw/HCa
         OSTXflyCLQ49hQlFk/OqBW92LvuvrB/Y6gqGYM9MHpasjVuHxE/y6Ez5XkDpr0eUjPqe
         nKfJ6GAV0N1F2UDvLM7yDDxuEk5Is8KL3RiRWIHrpvHsKnXBGjDc1fW88C9db/9C5ZvL
         px0G/E3g1+JrS8OGiLIAW8zLIcefdbACdMOq/85wxBIs5lKzuNXgn+tQD0HqtGWO9wUE
         957g==
X-Gm-Message-State: AOJu0Yy5EhCO2G0TFe+8ahVqsjgZYOweO7GRs75dJ7oNfXcUR6sI1y3n
	UjhZ3Y3sKKkNzfm6inDbgdIr64kxctATprpLssBIIfr9oOPULnoo6wi516aNdw==
X-Gm-Gg: AZuq6aJ00+CuAxp/lKTXqvknK9Hh29Ce6pCwU3f9YChk2BNn0MrcxtsioVckDPLT86v
	C4uRfIv7CWreTP8JSgh4Gm2+ibp2TNRRCZE/dlrt3OxKySCAB053DtXew/tqSaRS7ZTKhBO5+kI
	XnsQoqXan/GToCvzQVrxR6PaZaKrqRsd4RY01FQN4eNrXi9Gjb7p9AGLsB4OUotTSyRgLShw0eL
	8vQ2qq4/GM2+73Y/IU3MrXWy9mUC+R8l+wBlbuBIb30NcA6FAMf3BuaSFwWEL4ZJnfsU/DpDziV
	wuFh/BrVlcBeA4iamqKXHv+Dg6nhxSBCZ0x9ClTpXcqnY8Hk98P31MV2vIQUDz3ou8Bg2hWj1wP
	lWpVsVPHJHL+17mVE/CVLhqMFu3Bo00UQuNcdT/iJlAlOv7CCMBUah/8eu2V3TRDZ9X4gLA7SN4
	CK4pLeIWzXNHgJcGPku1gGAnYI
X-Received: by 2002:a05:6871:2b02:b0:404:31c3:9b8e with SMTP id 586e51a60fabf-40a53c21b8emr1640335fac.16.1770214812744;
        Wed, 04 Feb 2026 06:20:12 -0800 (PST)
Received: from [127.0.0.1] ([52.173.182.164])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-40a544e77fdsm1781454fac.21.2026.02.04.06.20.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 06:20:11 -0800 (PST)
Message-Id: <d5e0c32497581e6ac4890c6e71c5c33b92d67d51.1770214803.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2033.git.1770214803.gitgitgadget@gmail.com>
References: <pull.2033.git.1770214803.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 04 Feb 2026 14:19:56 +0000
Subject: [PATCH 04/11] config-batch: create 'help' command
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

Tools that use the 'git config-batch' tool will want to know which commands
are available in the current Git version. Having a 'help' command assists
greatly to give a clear set of available commands and their versions.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 Documentation/git-config-batch.adoc | 17 +++++++++++++++
 builtin/config-batch.c              | 32 +++++++++++++++++++++++++++++
 t/t1312-config-batch.sh             | 13 ++++++++++++
 3 files changed, 62 insertions(+)

diff --git a/Documentation/git-config-batch.adoc b/Documentation/git-config-batch.adoc
index 31dd42f481..1fff68a13c 100644
--- a/Documentation/git-config-batch.adoc
+++ b/Documentation/git-config-batch.adoc
@@ -38,6 +38,23 @@ unknown_command LF
 
 These are the commands that are currently understood:
 
+`help` version 1::
+	The `help` command lists the currently-available commands in
+	this version of Git. The output is multi-line, but the first
+	line provides the count of possible commands via `help count <N>`.
+	The next `<N>` lines are of the form `help <command> <version>`
+	to state that this Git version supports that `<command>` at
+	version `<version>`. Note that the same command may have multiple
+	available versions.
++
+Here is the currentl output of the help text at the latest version:
++
+------------
+help 1 count 2
+help 1 help 1
+help 1 get 1
+------------
+
 `get` version 1::
 	The `get` command searches the config key-value pairs within a
 	given `<scope>` for values that match the fixed `<key>` and
diff --git a/builtin/config-batch.c b/builtin/config-batch.c
index 5782004080..1c19e4889f 100644
--- a/builtin/config-batch.c
+++ b/builtin/config-batch.c
@@ -12,6 +12,7 @@ static const char *const builtin_config_batch_usage[] = {
 };
 
 #define UNKNOWN_COMMAND "unknown_command"
+#define HELP_COMMAND "help"
 #define GET_COMMAND "get"
 #define COMMAND_PARSE_ERROR "command_parse_error"
 
@@ -104,6 +105,9 @@ static size_t parse_token(char **data, size_t *data_len,
 	return parse_whitespace_token(data, data_len, token, err);
 }
 
+static int help_command_1(struct repository *repo,
+			  char *data, size_t data_len);
+
 enum value_match_mode {
 	MATCH_ALL,
 	MATCH_EXACT,
@@ -302,6 +306,11 @@ struct command {
 };
 
 static struct command commands[] = {
+	{
+		.name = HELP_COMMAND,
+		.fn = help_command_1,
+		.version = 1,
+	},
 	{
 		.name = GET_COMMAND,
 		.fn = get_command_1,
@@ -316,6 +325,29 @@ static struct command commands[] = {
 
 #define COMMAND_COUNT ((size_t)(sizeof(commands) / sizeof(*commands)))
 
+static int help_command_1(struct repository *repo UNUSED,
+			  char *data UNUSED, size_t data_len UNUSED)
+{
+	struct strbuf fmt_str = STRBUF_INIT;
+
+	strbuf_addf(&fmt_str, "%"PRIu32, (uint32_t)(COMMAND_COUNT - 1));
+	emit_response(HELP_COMMAND, "1", "count", fmt_str.buf, NULL);
+	strbuf_reset(&fmt_str);
+
+	for (size_t i = 0; i < COMMAND_COUNT; i++) {
+		/* Halt at unknown command. */
+		if (!commands[i].name[0])
+			break;
+
+		strbuf_addf(&fmt_str, "%d", commands[i].version);
+		emit_response(HELP_COMMAND, "1", commands[i].name, fmt_str.buf, NULL);
+		strbuf_reset(&fmt_str);
+	}
+
+	strbuf_release(&fmt_str);
+	return 0;
+}
+
 /**
  * Process a single line from stdin and process the command.
  *
diff --git a/t/t1312-config-batch.sh b/t/t1312-config-batch.sh
index e638b54d13..6b550a0e76 100755
--- a/t/t1312-config-batch.sh
+++ b/t/t1312-config-batch.sh
@@ -23,6 +23,19 @@ test_expect_success 'completely broken input' '
 	test_grep "an unrecoverable error occurred during command execution" err
 '
 
+test_expect_success 'help command' '
+	echo "help 1" >in &&
+
+	cat >expect <<-\EOF &&
+	help 1 count 2
+	help 1 help 1
+	help 1 get 1
+	EOF
+
+	git config-batch >out <in &&
+	test_cmp expect out
+'
+
 test_expect_success 'failed to parse version' '
 	echo "bogus BAD_VERSION line of tokens" >in &&
 	test_must_fail git config-batch 2>err <in &&
-- 
gitgitgadget


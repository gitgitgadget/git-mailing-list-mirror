Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C32410D3A
	for <git@vger.kernel.org>; Wed,  4 Feb 2026 14:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770214816; cv=none; b=l0b2hDgBzWXnucW9kGMsuMmgzDPnfaDfUll8SlOyig63AMILNMk8pDE95kbfEm9ei2mszHNjUBCpBYsDURHbqSGaB+U9wMmI2TUOJrWA6pHKYrLLZ6lKxvH3ndkY67rUcLwSdVdosAhmpsLaJhjkEWevxcRgbib09AFQZPSAUWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770214816; c=relaxed/simple;
	bh=UYdM+3zndmEFYebM/rOoRdfk6N4URzXItIgR9NREkf8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=u3S0R5Hz5IH1sel8TgLdVrdPgnpfx+Pa078YQwgaTQ6CUEXRKeS3SuJwKhbi9XM/bB+PclTwWfyKucswpNJ1vaYigceXN1hxmBDb6QOWqhSlNWV95cC2IfxXWOrdTLKKpB4d0DmILrOB1v/IX0/wRGmDmaWP6B7Du/WdJYlfabs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ge/xAzCN; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ge/xAzCN"
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-66a68106cc6so288798eaf.1
        for <git@vger.kernel.org>; Wed, 04 Feb 2026 06:20:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770214814; x=1770819614; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wrLxaEudCpRvrJ0xyoluY3+JfjFI5o22W+xmenW7HUk=;
        b=Ge/xAzCNdRPEE1OJODjwQAiAhHm+OTOiiexu18t4kJ/bipqbT7lfF37bzFDyf/FN5y
         No7Oi3CO0PHLJNXnDhplZ+NAbSPxqlnLcvZX4P1+Vc+5O3x+vgG8J8NhqahmgKrpzp6o
         nLJZaENVepYtILz7Eu1Ji/sl5vysmIMqdq8/uVUDTaKcuRlgZR1AaJNplgkSjOiNEGoH
         oVl9dgPNSLGPTOZts/qoyaWThU0nus920jbK5+dsOBAml6bPhl18NV/I+ro4WlmHR6wS
         Vl5+seh1mqfZFW+j0YsdnYP5YvPIjbm3R7NEpd1Z6NXN3M3F9rqigE+O2atzxJXD8T6g
         vTHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770214814; x=1770819614;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wrLxaEudCpRvrJ0xyoluY3+JfjFI5o22W+xmenW7HUk=;
        b=Q4M7g+QW28DO61Z9xzrCwRSm5KobJ5+y9e5gbbFEkFqFmVrfD5hdC2TbF7sjyvwJlt
         D/+kHelVI/YmubGhIiPl9VUkHx2nb+ly70pBSwpyNt3Kr1T7iKfHdBpdqe6AvSc6WhlV
         S9eh5OYd5mOdWC7y8UQ4fGqQjBM7sPOalYWd8VHqsW3LHdPwVYO95mI5+dEo4OMklm2v
         Vnj/WfObBWIJn+uSjtE6gJcBFYRvpxHF8QbYXHhM4PRNdppERPglbhTUr+bkU5s254GS
         LkT0LIU1Yaxrc/vCrmnasaHhKho5YzpCfxnd/8p8zNk6bKoiwFhyGYbOC4l0bFUvbhtS
         I9bQ==
X-Gm-Message-State: AOJu0Yzj//z77hbf8nzUfHQdUdUa18zGpNlhxqj+8u8zU7HC3RBMQXfA
	vzadeABDYHrTWrR5DnArxXUcL/FNrlvtbbP4aUCtUfL9hQZjqtdiZrFNv3KXlw==
X-Gm-Gg: AZuq6aJZLxCwHSg4OKJv05inkpGftJVRwvpmZF92jW2KWq3DwK+ntDm14Frd0sDZ6+F
	NpejM9ZvvKQXCwUX8Azkpj51erH2revZN9SKJqR0tDcdaK3RF/2e8XDLq167AxKaupS8b/N70hU
	gtVZlOiZj8Lh6ADveIIdaDqAjYHdTnF4Ox+mWW+7hFCcYMdNQwmXToxRZey9eLRojUmTm5SVEaY
	KM3JrkXAZKzw1asosItICQyVhhmWXFqUHms23+hfaa+ZwWlYNEyuGrnQibi6GlC319dOtn556xd
	AfJZi4+weO1/NlcEvlb0BmnldlCtmMEIP0m+MQqq9c1UMmkrKouQTDGltLas/m/rkYeHSuy+LRF
	3vot1YZMivCeZTc+JBZU/YA52YxOqb9Mi4Y20C46I34A513hjC4CB1gUNs7EMyf4kiXQ1YnHTbZ
	1S7MD1LjUjC9E93d10gCyAtpcC
X-Received: by 2002:a05:6820:4689:b0:662:fe0b:d763 with SMTP id 006d021491bc7-66a21903268mr1129638eaf.37.1770214814124;
        Wed, 04 Feb 2026 06:20:14 -0800 (PST)
Received: from [127.0.0.1] ([52.173.182.164])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-66a35d7b8ddsm1411858eaf.15.2026.02.04.06.20.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 06:20:13 -0800 (PST)
Message-Id: <33faa3f134c81761631c34600477dcbf82e619e5.1770214803.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2033.git.1770214803.gitgitgadget@gmail.com>
References: <pull.2033.git.1770214803.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 04 Feb 2026 14:19:57 +0000
Subject: [PATCH 05/11] config-batch: add NUL-terminated I/O format
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

When using automated tools, it is critical to allow for input/output formats
that include special characters such as spaces and newlines. While the
existing protocol for 'git config-batch' is human-readable and has some
capacity for some spaces in certain positions, it is not available for
spaces in the config key or newlines in the config values.

Add the '-z' option to signal the use of NUL-terminated strings. To
understand where commands end regardless of potential future formats, use
two NUL bytes in a row to terminate a command. To allow for empty string
values, each token is provided in a <length>:<value> format, making "0:"
the empty string value.

Update the existing 'help' and 'get' commands to match this format. Create
helper methods that make it easy to parse and print in both formats
simultaneously.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 Documentation/git-config-batch.adoc |  57 ++++++++-
 builtin/config-batch.c              | 188 +++++++++++++++++++++++++---
 t/t1312-config-batch.sh             |  69 ++++++++++
 3 files changed, 293 insertions(+), 21 deletions(-)

diff --git a/Documentation/git-config-batch.adoc b/Documentation/git-config-batch.adoc
index 1fff68a13c..3c9a3bb763 100644
--- a/Documentation/git-config-batch.adoc
+++ b/Documentation/git-config-batch.adoc
@@ -21,6 +21,15 @@ multiple configuration values, the `git config-batch` command allows a
 single process to handle multiple requests using a machine-parseable
 interface across `stdin` and `stdout`.
 
+OPTIONS
+-------
+
+`-z`::
+	If specified, then use the NUL-terminated input and output
+	format instead of the space and newline format. This format is
+	useful when the strings involved may include spaces or newlines.
+	See PROTOCOL for more details.
+
 PROTOCOL
 --------
 By default, the protocol uses line feeds (`LF`) to signal the end of a
@@ -41,13 +50,13 @@ These are the commands that are currently understood:
 `help` version 1::
 	The `help` command lists the currently-available commands in
 	this version of Git. The output is multi-line, but the first
-	line provides the count of possible commands via `help count <N>`.
-	The next `<N>` lines are of the form `help <command> <version>`
+	line provides the count of possible commands via `help 1 count <N>`.
+	The next `<N>` lines are of the form `help 1 <command> <version>`
 	to state that this Git version supports that `<command>` at
 	version `<version>`. Note that the same command may have multiple
 	available versions.
 +
-Here is the currentl output of the help text at the latest version:
+Here is the current output of the help text at the latest version:
 +
 ------------
 help 1 count 2
@@ -102,6 +111,48 @@ get 1 missing <key> [<value-pattern>|<value>]
 where `<value-pattern>` or `<value>` is only supplied if provided in
 the command.
 
+NUL-Terminated Format
+~~~~~~~~~~~~~~~~~~~~~
+
+When `-z` is given, the protocol changes in some structural ways.
+
+First, each command is terminated with two NUL bytes, providing a clear
+boundary between commands regardless of future possibilities of new
+command formats.
+
+Second, any time that a space _would_ be used to partition tokens in a
+command, a NUL byte is used instead. Further, each token is prefixed
+with `<N>:` where `<N>` is a decimal representation of the length of
+the string between the `:` and the next NUL byte. Any disagreement in
+these lengths is treated as a parsing error. This use of a length does
+imply that "`0:`" is the representation of an empty string, if relevant.
+
+The decimal representation must have at most five numerals, thus the
+maximum length of a string token can have 99999 characters.
+
+For example, the `get` command, version 1, could have any of the
+following forms:
+
+------------
+3:get NUL 1:1 NUL 5:local NUL 14:key.with space NUL NUL
+3:get NUL 1:1 NUL 9:inherit NUL 8:test.key NUL 9:arg:regex NUL 6:.*\ .* NUL NUL
+3:get NUL 1:1 NUL 6:global NUL 8:test.key NUL 15:arg:fixed-value NUL 3:a b NUL NUL
+------------
+
+The output is modified similarly, such as the following output examples,
+as if the input has a parse error, a valid `help` command, a `get`
+command that had a match, and a `get` command that did not match.
+
+------------
+15:unknown_command NUL NUL
+4:help NUL 1:1 NUL 5:count NUL 1:2 NUL NUL
+4:help NUL 1:1 NUL 4:help NUL 1:1 NUL NUL
+4:help NUL 1:1 NUL 3:get NUL 1:1 NUL NUL
+3:get NUL 1:1 NUL 5:found NUL 8:test.key NUL 5:value NUL NUL
+3:get NUL 1:1 NUL 7:missing NUL 8:test.key NUL NUL
+------------
+
+
 SEE ALSO
 --------
 linkgit:git-config[1]
diff --git a/builtin/config-batch.c b/builtin/config-batch.c
index 1c19e4889f..2c48c4ea37 100644
--- a/builtin/config-batch.c
+++ b/builtin/config-batch.c
@@ -11,24 +11,40 @@ static const char *const builtin_config_batch_usage[] = {
 	NULL
 };
 
+static int zformat = 0;
+
 #define UNKNOWN_COMMAND "unknown_command"
 #define HELP_COMMAND "help"
 #define GET_COMMAND "get"
 #define COMMAND_PARSE_ERROR "command_parse_error"
 
+static void print_word(const char *word, int start)
+{
+	if (zformat) {
+		printf("%"PRIu32":%s", (uint32_t)strlen(word), word);
+		fputc(0, stdout);
+	} else if (start)
+		printf("%s", word);
+	else
+		printf(" %s", word);
+}
+
 static int emit_response(const char *response, ...)
 {
 	va_list params;
 	const char *token;
 
-	printf("%s", response);
+	print_word(response, 1);
 
 	va_start(params, response);
 	while ((token = va_arg(params, const char *)))
-		printf(" %s", token);
+		print_word(token, 0);
 	va_end(params);
 
-	printf("\n");
+	if (zformat)
+		fputc(0, stdout);
+	else
+		printf("\n");
 	fflush(stdout);
 	return 0;
 }
@@ -59,6 +75,52 @@ static int unknown_command(struct repository *repo UNUSED,
 	return emit_response(UNKNOWN_COMMAND, NULL);
 }
 
+/*
+ * Parse the next token using the NUL-byte format.
+ */
+static size_t parse_ztoken(char **data, size_t *data_len,
+			   char **token, int *err)
+{
+	size_t i = 0, token_len;
+
+	while (i < *data_len && (*data)[i] != ':') {
+		if ((*data)[i] < '0' || (*data)[i] > '9') {
+			goto parse_error;
+		}
+		i++;
+	}
+
+	if (i >= *data_len || (*data)[i] != ':' || i > 5)
+		goto parse_error;
+
+	(*data)[i] = 0;
+	token_len = atoi(*data);
+
+	if (token_len + i + 1 >= *data_len)
+		goto parse_error;
+
+	*token = *data + i + 1;
+	*data_len = *data_len - (i + 1);
+
+	/* check for early NULs. */
+	for (i = 0; i < token_len; i++) {
+		if (!(*token)[i])
+			goto parse_error;
+	}
+	/* check for matching NUL. */
+	if ((*token)[token_len])
+		goto parse_error;
+
+	*data = *token + token_len + 1;
+	*data_len = *data_len - (token_len + 1);
+	return token_len;
+
+parse_error:
+	*err = 1;
+	*token = NULL;
+	return 0;
+}
+
 static size_t parse_whitespace_token(char **data, size_t *data_len,
 				     char **token, int *err UNUSED)
 {
@@ -93,15 +155,23 @@ static size_t parse_whitespace_token(char **data, size_t *data_len,
  * The returned value is the length of the token that was
  * discovered.
  *
- * 'err' is ignored for now, but will be filled in in a future
- * change.
+ * The 'token' pointer is used to set the start of the token.
+ * In the whitespace format, this is always the input value of
+ * 'data' but in the NUL-terminated format this follows an "<N>:"
+ * prefix.
+ *
+ * In the case of the NUL-terminated format, a bad parse of the
+ * decimal length or a mismatch of the decimal length and the
+ * length of the following NUL-terminated string will result in
+ * the value pointed at by 'err' to be set to 1.
  */
 static size_t parse_token(char **data, size_t *data_len,
 			  char **token, int *err)
 {
 	if (!*data_len)
 		return 0;
-
+	if (zformat)
+		return parse_ztoken(data, data_len, token, err);
 	return parse_whitespace_token(data, data_len, token, err);
 }
 
@@ -255,7 +325,13 @@ static int get_command_1(struct repository *repo,
 			goto parse_error; /* unknown arg. */
 
 		/* Use the remaining data as the value string. */
-		gc_data.value = data;
+		if (!zformat)
+			gc_data.value = data;
+		else {
+			parse_token(&data, &data_len, &gc_data.value, &err);
+			if (err)
+				goto parse_error;
+		}
 
 		if (gc_data.mode == MATCH_REGEX) {
 			CALLOC_ARRAY(gc_data.value_pattern, 1);
@@ -348,17 +424,74 @@ static int help_command_1(struct repository *repo UNUSED,
 	return 0;
 }
 
-/**
- * Process a single line from stdin and process the command.
- *
- * Returns 0 on successful processing of command, including the
- * unknown_command output.
- *
- * Returns 1 on natural exit due to exist signal of empty line.
- *
- * Returns negative value on other catastrophic error.
- */
-static int process_command(struct repository *repo)
+static int process_command_nul(struct repository *repo)
+{
+	static struct strbuf line = STRBUF_INIT;
+	char *data, *command, *versionstr;
+	size_t data_len, token_len;
+	int res = 0, err = 0, version = 0, getc;
+	char c;
+
+	/* If we start with EOF it's not an error. */
+	getc = fgetc(stdin);
+	if (getc == EOF)
+		return 1;
+
+	do {
+		c = (char)getc;
+		strbuf_addch(&line, c);
+
+		if (!c && line.len > 1 && !line.buf[line.len - 2])
+			break;
+
+		getc = fgetc(stdin);
+
+		/* It's an error if we reach EOF while parsing a command. */
+		if (getc == EOF)
+			goto parse_error;
+	} while (1);
+
+	data = line.buf;
+	data_len = line.len - 1;
+
+	token_len = parse_ztoken(&data, &data_len, &command, &err);
+	if (!token_len || err)
+		goto parse_error;
+
+	token_len = parse_ztoken(&data, &data_len, &versionstr, &err);
+	if (!token_len || err)
+		goto parse_error;
+
+	if (!git_parse_int(versionstr, &version)) {
+		res = error(_("unable to parse '%s' to integer"),
+			    versionstr);
+		goto parse_error;
+	}
+
+	for (size_t i = 0; i < COMMAND_COUNT; i++) {
+		/*
+		 * Run the ith command if we have hit the unknown
+		 * command or if the name and version match.
+		 */
+		if (!commands[i].name[0] ||
+		    (!strcmp(command, commands[i].name) &&
+		     commands[i].version == version)) {
+			res = commands[i].fn(repo, data, data_len);
+			goto cleanup;
+		}
+	}
+
+	BUG(_("scanned to end of command list, including 'unknown_command'"));
+
+parse_error:
+	res = unknown_command(repo, NULL, 0);
+
+cleanup:
+	strbuf_release(&line);
+	return res;
+}
+
+static int process_command_whitespace(struct repository *repo)
 {
 	static struct strbuf line = STRBUF_INIT;
 	struct string_list tokens = STRING_LIST_INIT_NODUP;
@@ -416,6 +549,23 @@ cleanup:
 	return res;
 }
 
+/**
+ * Process a single line from stdin and process the command.
+ *
+ * Returns 0 on successful processing of command, including the
+ * unknown_command output.
+ *
+ * Returns 1 on natural exit due to exist signal of empty line.
+ *
+ * Returns negative value on other catastrophic error.
+ */
+static int process_command(struct repository *repo)
+{
+	if (zformat)
+		return process_command_nul(repo);
+	return process_command_whitespace(repo);
+}
+
 int cmd_config_batch(int argc,
 		     const char **argv,
 		     const char *prefix,
@@ -423,6 +573,8 @@ int cmd_config_batch(int argc,
 {
 	int res = 0;
 	struct option options[] = {
+		OPT_BOOL('z', NULL, &zformat,
+			 N_("stdin and stdout is NUL-terminated")),
 		OPT_END(),
 	};
 
diff --git a/t/t1312-config-batch.sh b/t/t1312-config-batch.sh
index 6b550a0e76..f7a74ddc2c 100755
--- a/t/t1312-config-batch.sh
+++ b/t/t1312-config-batch.sh
@@ -4,6 +4,26 @@ test_description='Test git config-batch'
 
 . ./test-lib.sh
 
+# usage: test_zformat <command> <args> <in >out
+#
+# Let 'in' be a z-format input but with " NUL " between tokens in
+# a single command and " NUL NUL" trailing each line.
+#
+# The values in 'out' will be space- and newline-delimited where
+# NUL-bytes would normally be output.
+test_zformat () {
+	sed -e "s/\ NUL\ /!/g" >nullin1 &&
+	sed -e "s/NUL//g" <nullin1 >nullin2 &&
+
+	tr "!" "\0" <nullin2 >nullin3 &&
+	tr "\n" "\0" <nullin3 >zin &&
+
+	$* <zin >zout &&
+
+	tr "\0" " " <zout >outspace &&
+	sed "s/\ \ /\n/g" <outspace
+}
+
 test_expect_success 'no commands' '
 	echo | git config-batch >out &&
 	test_must_be_empty out
@@ -36,6 +56,23 @@ test_expect_success 'help command' '
 	test_cmp expect out
 '
 
+test_expect_success 'help -z' '
+	cat >in <<-\EOF &&
+	4:help NUL 1:1 NUL NUL
+	5:bogus NUL 2:10 NUL NUL
+	EOF
+
+	cat >expect <<-\EOF &&
+	4:help 1:1 5:count 1:2
+	4:help 1:1 4:help 1:1
+	4:help 1:1 3:get 1:1
+	15:unknown_command
+	EOF
+
+	test_zformat git config-batch -z >out <in &&
+	test_cmp expect out
+'
+
 test_expect_success 'failed to parse version' '
 	echo "bogus BAD_VERSION line of tokens" >in &&
 	test_must_fail git config-batch 2>err <in &&
@@ -136,4 +173,36 @@ test_expect_success 'get config with arg:fixed-value' '
 	test_cmp expect out
 '
 
+test_expect_success 'get config with -z' '
+	test_when_finished git config --unset-all test.key &&
+	GIT_CONFIG_SYSTEM=system-config-file &&
+	GIT_CONFIG_NOSYSTEM=0 &&
+	GIT_CONFIG_GLOBAL=global-config-file &&
+	export GIT_CONFIG_SYSTEM &&
+	export GIT_CONFIG_NOSYSTEM &&
+	export GIT_CONFIG_GLOBAL &&
+
+	git config --system test.key on1e &&
+	git config --global test.key t2wo &&
+	git config test.key "thre3e space" &&
+	git config --worktree test.key 4four &&
+
+	cat >in <<-\EOF &&
+	3:get NUL 1:1 NUL 9:inherited NUL 8:test.key NUL NUL
+	3:get NUL 1:1 NUL 6:global NUL 8:test.key NUL 9:arg:regex NUL 3:2.* NUL NUL
+	3:get NUL 1:1 NUL 5:local NUL 8:test.key NUL 15:arg:fixed-value NUL 12:thre3e space NUL NUL
+	3:get NUL 1:1 NUL 9:inherited NUL 11:key.missing NUL NUL
+	EOF
+
+	cat >expect <<-\EOF &&
+	3:get 1:1 5:found 8:test.key 8:worktree 5:4four
+	3:get 1:1 5:found 8:test.key 6:global 4:t2wo
+	3:get 1:1 5:found 8:test.key 5:local 12:thre3e space
+	3:get 1:1 7:missing 11:key.missing
+	EOF
+
+	test_zformat git config-batch -z >out <in &&
+	test_cmp expect out
+'
+
 test_done
-- 
gitgitgadget


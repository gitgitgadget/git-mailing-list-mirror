Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4071521FF4C
	for <git@vger.kernel.org>; Wed,  4 Feb 2026 14:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770214812; cv=none; b=Ft7MHi3p9bnSztH+yB4C8H3nSAUFhmD4LUpfmINM4yzpHfEgMxrq2XcvLgdrs/YwS0gOkbF2d0IjIMEPt+CGqkdp3YHauvtgKlh3CgIHfL3M2/M2Kyp5gp8aUNWaiGgtlc7+BskYqkggORxvbs5DK9Zk48fUOlILsDTcZWOlIpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770214812; c=relaxed/simple;
	bh=qxIRJRcBB7hL2opOx/7aclVJ39myew4HMq27d6csVqk=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=KfWGTow2lmp5BkAx6f15YxsuqUSrsrfLiY0YNqKZDUr3ULnQBKEifdZM4u4j8u6z3Qg+zzeuytFt2+S4PFmRd3vzHU7v+1Ha13BV3GFkGElhvI+QFRhFq6scazHngsb8+owVi8KGMx7X2CRjbEclLLUygwVu59rY5C+zwZ4J3hY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CyFYD0sW; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CyFYD0sW"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7cfd6f321b5so4378474a34.2
        for <git@vger.kernel.org>; Wed, 04 Feb 2026 06:20:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770214811; x=1770819611; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZDLGnKOyQ8YrKOUkc8A9rt2Q9oR/+T7IB6v266HRd+g=;
        b=CyFYD0sWKKIaxrkkir7j92i0kY5ih7NPot0utMd6moCW4QWDm8UVZDIWZtpI7xOArN
         WDTbPIgy3GfNArb3zmlIdskqRczgolKktlcfLkI1xw8JWg/1zwsnjK/++JvYEvPwKtpZ
         576Gi4N35BZsAoKiMKsNb6bUB3HY62SAxF1/vORHvmOx1iXFU2gVP4ihIhfFMAHTT/VQ
         98yTKoKi7j+DT9BUGSM/iEbcJ2XqxLCguC4P03H+xYajIMA/DKSreLZEcTJYG6W9QFgX
         wes4aM54UUBW2SbygAFYwNxi5NnyV2WLcySwnMfQxgDsxcZZblI1PopiJyXgNO3whvn4
         GiJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770214811; x=1770819611;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZDLGnKOyQ8YrKOUkc8A9rt2Q9oR/+T7IB6v266HRd+g=;
        b=GvABIYeSqu3A2VqlpxAXxraJOgYxsKOLwVupNHk1s/qSSPDSflMjgnKDXNSfukXE7J
         1QsqRYMAN/vVrYsz6lA/JQ21CgYOmry+3UBr4qhc4yxcm1exz6d8fHFS21BgNBgjNWcR
         +eldx0vitYxztmPRXE50PsKM/ZcV+j1svMwiHAh5LjgYzISFkmW5prCz6CKh6gTGQeKH
         3jOoJX817Yo98olQ6vh6M8hL8dbbnZtLXzk1FGfUVwngA+ngtGeDhj1MKfY+lXaPbyvd
         PKrn+447uNQWYSPfzZrnuNtOeLwnAZuTDKXZJFBod70+8qUZKGlenfPQomy7zJdxChXv
         IoSg==
X-Gm-Message-State: AOJu0Yx0wrk5jy++r3CMkWENHFpqx8b4fxotonYw9Ei/8vtoVz4wyyj3
	3oos/evkMy3rwZzyE0dU9lllTYfnb7lTUasCFwspZ4FuQzClXRbhI12vUpV0fA==
X-Gm-Gg: AZuq6aL3oK3PoOS2BM8A+ZcQDJsmAZOViM/WnI4Obzhn4LloQWeLSoq9CQs4Hc+w1C4
	M3Xaaf5NPMrXbdsYw+VfmXfd+PnrtE9pWlsXutgZqSENWQp7hP1PP4Wvf5/7rxnUxXByJ/O/2oE
	o5UamClvwx/YG3wWifjhpvTqI44U6WuW5211SrFWXbzMroMo7+4/jYNzlGHKnmkpytRebi2JBUr
	vKn7XIoLFrSesnAaRIl2IdnuuwN85XPCI7Ho3Mh3jZ9GZO/guNMUmoNHBoTAkVFBgonDW8Rjbu6
	U4SaMSBGcLrE0S++DJUBRrMGHIHRqPHH3LOTX+Z819Qd09cn0CQ6pbxbAdnG/6fVG/is03Jnn9g
	vwyvP+diS/2JaTJxbUfK9cbzZXs24XQ4uvzNg3grrc7t0OWp7zMW3QnGqkO4Q4rnEEMfPexEyLo
	d3JkBiLfZnwEK/Zw==
X-Received: by 2002:a05:6830:34a4:b0:7c7:827f:872f with SMTP id 46e09a7af769-7d448af97fbmr1741259a34.37.1770214810476;
        Wed, 04 Feb 2026 06:20:10 -0800 (PST)
Received: from [127.0.0.1] ([52.173.182.164])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d4490f3c06sm1741473a34.2.2026.02.04.06.20.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 06:20:09 -0800 (PST)
Message-Id: <3de1bba3b10668f0200e27def9128571f51c1f68.1770214803.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2033.git.1770214803.gitgitgadget@gmail.com>
References: <pull.2033.git.1770214803.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 04 Feb 2026 14:19:55 +0000
Subject: [PATCH 03/11] config-batch: implement get v1
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

The 'get' command for the 'git config-batch' builtin is the first command
and is currently at version 1. It returns at most one value, the same as
'git config --get <key>' with optional value-based filtering.

The documentation and tests detail the specifics of how to format requests
of this format and how to parse the results.

Future versions could consider multi-valued responses or regex-based key
matching.

For the sake of incremental exploration of the potential in the 'git
config-batch' command, this is the only implementation being presented in
the first patch series.

Future extensions could include a '-z' parameter that uses NUL bytes in the
command and output format to allow for spaces or newlines in the input or
newlines in the output.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 Documentation/git-config-batch.adoc |  53 +++++-
 builtin/config-batch.c              | 251 +++++++++++++++++++++++++++-
 config.h                            |   3 +
 t/t1312-config-batch.sh             | 101 +++++++++++
 4 files changed, 405 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-config-batch.adoc b/Documentation/git-config-batch.adoc
index 9ca04b0c1e..31dd42f481 100644
--- a/Documentation/git-config-batch.adoc
+++ b/Documentation/git-config-batch.adoc
@@ -32,9 +32,58 @@ set. Thus, if the Git version includes the `git config-batch` builtin
 but doesn't understand an input command, it will return a single line
 response:
 
-```
+------------
 unknown_command LF
-```
+------------
+
+These are the commands that are currently understood:
+
+`get` version 1::
+	The `get` command searches the config key-value pairs within a
+	given `<scope>` for values that match the fixed `<key>` and
+	filters the resulting value based on an optional `<value-filter>`.
+	This can either be a regex or a fixed value. The command format
+	is one of the following formats:
++
+------------
+get 1 <scope> <key>
+get 1 <scope> <key> arg:regex <value-pattern>
+get 1 <scope> <key> arg:fixed-value <value>
+------------
++
+The `<scope>` value can be one of `inherited`, `system`, `global`,
+`local`, `worktree`, `submodule`, or `command`. If `inherited`, then all
+config key-value pairs will be considered regardless of scope. Otherwise,
+only the given scope will be considered.
++
+If no optional arguments are given, then the value will not be filtered
+by any pattern matching. If `arg:regex` is specified, then the rest of
+the line is considered a single string, `<value-pattern>`, and is
+interpreted as a regular expression for matching against stored values,
+similar to specifying a value to `get config --get <key> "<value-pattern>"`.
+If `arg:fixed-value` is specified, then the rest of the line is
+considered a single string, `<value>`, and is checked for an exact
+match against the key-value pairs, simmilar to `git config --get <key>
+--fixed-value "<value>"`.
++
+At mmost one key-value pair is returned, that being the last key-value
+pair in the standard config order by scope and sequence within each scope.
++
+If a key-value pair is found, then the following output is given:
++
+------------
+get 1 found <key> <scope> <value>
+------------
++
+If no matching key-value pair is found, then the following output is
+given:
++
+------------
+get 1 missing <key> [<value-pattern>|<value>]
+------------
++
+where `<value-pattern>` or `<value>` is only supplied if provided in
+the command.
 
 SEE ALSO
 --------
diff --git a/builtin/config-batch.c b/builtin/config-batch.c
index dffedb8ca2..5782004080 100644
--- a/builtin/config-batch.c
+++ b/builtin/config-batch.c
@@ -12,6 +12,8 @@ static const char *const builtin_config_batch_usage[] = {
 };
 
 #define UNKNOWN_COMMAND "unknown_command"
+#define GET_COMMAND "get"
+#define COMMAND_PARSE_ERROR "command_parse_error"
 
 static int emit_response(const char *response, ...)
 {
@@ -30,6 +32,11 @@ static int emit_response(const char *response, ...)
 	return 0;
 }
 
+static int command_parse_error(const char *command)
+{
+	return emit_response(COMMAND_PARSE_ERROR, command, NULL);
+}
+
 /**
  * A function pointer type for defining a command. The function is
  * responsible for handling different versions of the command name.
@@ -46,11 +53,248 @@ typedef int (*command_fn)(struct repository *repo,
 			  char *data, size_t data_len);
 
 static int unknown_command(struct repository *repo UNUSED,
-			  char *data UNUSED, size_t data_len UNUSED)
+			   char *data UNUSED, size_t data_len UNUSED)
 {
 	return emit_response(UNKNOWN_COMMAND, NULL);
 }
 
+static size_t parse_whitespace_token(char **data, size_t *data_len,
+				     char **token, int *err UNUSED)
+{
+	size_t i = 0;
+
+	*token = *data;
+
+	while (i < *data_len && (*data)[i] && (*data)[i] != ' ')
+		i++;
+
+	if (i >= *data_len) {
+		*data_len = 0;
+		*data = NULL;
+		return i;
+	}
+
+	(*data)[i] = 0;
+	*data_len = (*data_len) - (i + 1);
+	*data = *data + (i + 1);
+	return i;
+}
+
+/**
+ * Given the remaining data line and its size, attempt to extract
+ * a token. When the token delimiter is determined, the data
+ * string is mutated to insert a NUL byte at the end of the token.
+ * The data pointer is mutated to point at the next character (or
+ * set to NULL if that exceeds the string length). The data_len
+ * value is mutated to subtract the length of the discovered
+ * token.
+ *
+ * The returned value is the length of the token that was
+ * discovered.
+ *
+ * 'err' is ignored for now, but will be filled in in a future
+ * change.
+ */
+static size_t parse_token(char **data, size_t *data_len,
+			  char **token, int *err)
+{
+	if (!*data_len)
+		return 0;
+
+	return parse_whitespace_token(data, data_len, token, err);
+}
+
+enum value_match_mode {
+	MATCH_ALL,
+	MATCH_EXACT,
+	MATCH_REGEX,
+};
+
+struct get_command_1_data {
+	/* parameters */
+	char *key;
+	enum config_scope scope;
+	enum value_match_mode mode;
+
+	/* optional parameters */
+	char *value;
+	regex_t *value_pattern;
+
+	/* data along the way, for single values. */
+	char *found;
+	enum config_scope found_scope;
+};
+
+static int get_command_1_cb(const char *key, const char *value,
+			    const struct config_context *context,
+			    void *data)
+{
+	struct get_command_1_data *d = data;
+
+	if (strcasecmp(key, d->key))
+		return 0;
+
+	if (d->scope != CONFIG_SCOPE_UNKNOWN &&
+	    d->scope != context->kvi->scope)
+		return 0;
+
+	switch (d->mode) {
+	case MATCH_EXACT:
+		if (strcasecmp(value, d->value))
+			return 0;
+		break;
+
+	case MATCH_REGEX:
+		if (regexec(d->value_pattern, value, 0, NULL, 0))
+			return 0;
+		break;
+
+	default:
+		break;
+	}
+
+	free(d->found);
+	d->found = xstrdup(value);
+	d->found_scope = context->kvi->scope;
+	return 0;
+}
+
+static const char *scope_str(enum config_scope scope)
+{
+	switch (scope) {
+	case CONFIG_SCOPE_UNKNOWN:
+		return "unknown";
+
+	case CONFIG_SCOPE_SYSTEM:
+		return "system";
+
+	case CONFIG_SCOPE_GLOBAL:
+		return "global";
+
+	case CONFIG_SCOPE_LOCAL:
+		return "local";
+
+	case CONFIG_SCOPE_WORKTREE:
+		return "worktree";
+
+	case CONFIG_SCOPE_SUBMODULE:
+		return "submodule";
+
+	case CONFIG_SCOPE_COMMAND:
+		return "command";
+
+	default:
+		BUG("invalid config scope");
+	}
+}
+
+static int parse_scope(const char *str, enum config_scope *scope)
+{
+	if (!strcmp(str, "inherited")) {
+		*scope = CONFIG_SCOPE_UNKNOWN;
+		return 0;
+	}
+
+	for (enum config_scope s = 0; s < CONFIG_SCOPE__NR; s++) {
+		if (!strcmp(str, scope_str(s))) {
+			*scope = s;
+			return 0;
+		}
+	}
+
+	return -1;
+}
+
+/**
+ * 'get' command, version 1.
+ *
+ * Positional arguments should be of the form:
+ *
+ * [0] scope ("system", "global", "local", "worktree", "command", "submodule", or "inherited")
+ * [1] config key
+ * [2*] multi-mode ("regex", "fixed-value")
+ * [3*] value regex OR value string
+ *
+ * [N*] indicates optional parameters that are not needed.
+ */
+static int get_command_1(struct repository *repo,
+			 char *data,
+			 size_t data_len)
+{
+	struct get_command_1_data gc_data = {
+		.found = NULL,
+		.mode = MATCH_ALL,
+	};
+	int res = 0, err = 0;
+	char *token;
+	size_t token_len;
+
+	if (!parse_token(&data, &data_len, &token, &err) || err)
+		goto parse_error;
+
+	if (parse_scope(token, &gc_data.scope))
+		goto parse_error;
+
+	if (!parse_token(&data, &data_len, &gc_data.key, &err) || err)
+		goto parse_error;
+
+	token_len = parse_token(&data, &data_len, &token, &err);
+	if (err)
+		goto parse_error;
+
+	if (token_len && !strncmp(token, "arg:", 4)) {
+		if (!strcmp(token + 4, "regex"))
+			gc_data.mode = MATCH_REGEX;
+		else if (!strcmp(token + 4, "fixed-value"))
+			gc_data.mode = MATCH_EXACT;
+		else
+			goto parse_error; /* unknown arg. */
+
+		/* Use the remaining data as the value string. */
+		gc_data.value = data;
+
+		if (gc_data.mode == MATCH_REGEX) {
+			CALLOC_ARRAY(gc_data.value_pattern, 1);
+			if (regcomp(gc_data.value_pattern, gc_data.value,
+				    REG_EXTENDED)) {
+				FREE_AND_NULL(gc_data.value_pattern);
+				goto parse_error;
+			}
+		}
+	} else if (token_len) {
+		/*
+		 * If we have remaining tokens not starting in "arg:",
+		 * then we don't understand them.
+		 */
+		goto parse_error;
+	}
+
+	repo_config(repo, get_command_1_cb, &gc_data);
+
+	if (gc_data.found)
+		res = emit_response(GET_COMMAND, "1", "found", gc_data.key,
+				    scope_str(gc_data.found_scope),
+				    gc_data.found,
+				    NULL);
+	else
+		res = emit_response(GET_COMMAND, "1", "missing", gc_data.key,
+				    gc_data.value, NULL);
+
+	goto cleanup;
+
+
+parse_error:
+	res = command_parse_error(GET_COMMAND);
+
+cleanup:
+	if (gc_data.value_pattern) {
+		regfree(gc_data.value_pattern);
+		free(gc_data.value_pattern);
+	}
+	free(gc_data.found);
+	return res;
+}
+
 struct command {
 	const char *name;
 	command_fn fn;
@@ -58,6 +302,11 @@ struct command {
 };
 
 static struct command commands[] = {
+	{
+		.name = GET_COMMAND,
+		.fn = get_command_1,
+		.version = 1,
+	},
 	/* unknown_command must be last. */
 	{
 		.name = "",
diff --git a/config.h b/config.h
index ba426a960a..966a228f0e 100644
--- a/config.h
+++ b/config.h
@@ -44,6 +44,9 @@ enum config_scope {
 	CONFIG_SCOPE_WORKTREE,
 	CONFIG_SCOPE_COMMAND,
 	CONFIG_SCOPE_SUBMODULE,
+
+	/* Must be last */
+	CONFIG_SCOPE__NR
 };
 const char *config_scope_name(enum config_scope scope);
 
diff --git a/t/t1312-config-batch.sh b/t/t1312-config-batch.sh
index f60ef35e38..e638b54d13 100755
--- a/t/t1312-config-batch.sh
+++ b/t/t1312-config-batch.sh
@@ -16,10 +16,111 @@ test_expect_success 'unknown_command' '
 	test_cmp expect out
 '
 
+test_expect_success 'completely broken input' '
+	echo "not_even_two_tokens" >in &&
+	test_must_fail git config-batch 2>err <in &&
+	test_grep "expected at least 2 tokens" err &&
+	test_grep "an unrecoverable error occurred during command execution" err
+'
+
 test_expect_success 'failed to parse version' '
 	echo "bogus BAD_VERSION line of tokens" >in &&
 	test_must_fail git config-batch 2>err <in &&
 	test_grep BAD_VERSION err
 '
 
+test_expect_success 'get inherited config' '
+	test_when_finished git config --unset test.key &&
+
+	git config test.key "test value with spaces" &&
+
+	echo "get 1 inherited test.key" >in &&
+	echo "get 1 found test.key local test value with spaces" >expect &&
+	git config-batch >out <in &&
+	test_cmp expect out &&
+
+	echo "get 1 global test.key" >in &&
+	echo "get 1 missing test.key" >expect &&
+	git config-batch >out <in &&
+	test_cmp expect out
+'
+
+test_expect_success 'set up worktree' '
+	test_commit A &&
+	git config extensions.worktreeconfig true &&
+	git worktree add --detach worktree
+'
+
+test_expect_success 'get config with arg:regex' '
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
+	get 1 inherited test.key arg:regex .*1.*
+	get 1 inherited test.key arg:regex [a-z]2.*
+	get 1 inherited test.key arg:regex .*3e s.*
+	get 1 inherited test.key arg:regex 4.*
+	get 1 inherited test.key arg:regex .*5.*
+	get 1 inherited test.key arg:regex .*6.*
+	EOF
+
+	cat >expect <<-\EOF &&
+	get 1 found test.key system on1e
+	get 1 found test.key global t2wo
+	get 1 found test.key local thre3e space
+	get 1 found test.key worktree 4four
+	get 1 found test.key command five5
+	get 1 missing test.key .*6.*
+	EOF
+
+	git -c test.key=five5 config-batch >out <in &&
+	test_cmp expect out
+'
+
+test_expect_success 'get config with arg:fixed-value' '
+	test_when_finished git config --unset-all test.key &&
+	GIT_CONFIG_SYSTEM=system-config-file &&
+	GIT_CONFIG_NOSYSTEM=0 &&
+	GIT_CONFIG_GLOBAL=global-config-file &&
+	export GIT_CONFIG_SYSTEM &&
+	export GIT_CONFIG_NOSYSTEM &&
+	export GIT_CONFIG_GLOBAL &&
+
+	git config --system test.key one &&
+	git config --global test.key two &&
+	git config test.key "three space" &&
+	git config --worktree test.key four &&
+
+	cat >in <<-\EOF &&
+	get 1 inherited test.key arg:fixed-value one
+	get 1 inherited test.key arg:fixed-value two
+	get 1 inherited test.key arg:fixed-value three space
+	get 1 inherited test.key arg:fixed-value four
+	get 1 inherited test.key arg:fixed-value five
+	get 1 inherited test.key arg:fixed-value six
+	EOF
+
+	cat >expect <<-\EOF &&
+	get 1 found test.key system one
+	get 1 found test.key global two
+	get 1 found test.key local three space
+	get 1 found test.key worktree four
+	get 1 found test.key command five
+	get 1 missing test.key six
+	EOF
+
+	git -c test.key=five config-batch >out <in &&
+	test_cmp expect out
+'
+
 test_done
-- 
gitgitgadget


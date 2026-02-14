Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0F4DF59
	for <git@vger.kernel.org>; Sat, 14 Feb 2026 00:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771030712; cv=none; b=AgvbSY8rmoMicATVGRf0+fSV6j1t0KTVH73QKC5ToAPbT1Bu6MrxHJeF1t2mLLQABuQGTDpSIFuTTck1jgKZ2N37qLOWjByqVM97sPlnPPItb+FnXdFJHPPaqeduqxTtAkLkcObyJNY3CF1iHqwUGsSvIwDW9KVtEx/xZS1KbFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771030712; c=relaxed/simple;
	bh=g5LXe1f3PuuUic80WBXE9ACFaSFlkzxH63FQI+PlCoI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tx8zArHmb6+k9cvHcIt1iYvoDgEnIWWICykdaf5hLwZQMRwhi4VBAjE7vmndfaKNe+FIvPodJSzPYriStfvoR4mvGZ+1k/JCOvyu/WrsJkrSfroDQI7B9qbIH0RYtwwcMiLXWYhLSoPnv6MlCqc3Q+fDjN/Q1PxuvXxwI6UvAGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OE+XBLUs; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OE+XBLUs"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-79495b1aaa7so15738207b3.1
        for <git@vger.kernel.org>; Fri, 13 Feb 2026 16:58:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771030710; x=1771635510; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Ve6RGELOMc+yAgkn7dPa0mdVV+JVbjGfmTSPxtK2vw=;
        b=OE+XBLUsC/k6ZFNIZo8aiSzg4dGOKBsoFX2C5mKQtmeF4YDc6FD6uPd2b+5tHwMy85
         nuWYR9PqIE0yfqK5yhYCGBf73NnFEaImP13EH6Jyu7KibpDavH8gVwaqNAboYTlFjHy7
         ineMBohaDRQMhhnr+Ni2yk46+pwvGmF2qSwHczXjBcJ5S5BsFLgTL078Z5hhJR0MJxtd
         cxtFTFDCnQdY5kyR2Hn7dyVm01MvZbpcpAneH/7n/rPXp44LRLaY7ppyBdXe26ZJncYE
         ydLE4Lq/obZrkPRcv3KVxs7myn5IDzMl9b/gHQxZyHbM/wEk2qNt9OZfhb2W7t7LfWF+
         hGmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771030710; x=1771635510;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3Ve6RGELOMc+yAgkn7dPa0mdVV+JVbjGfmTSPxtK2vw=;
        b=A5Y1JC80c36ni1W3X72Wgp2JGF0JbhY8afvzEgTLHcB0YM0WI+WkwDmwj76pDedj5N
         BTvvLWy0BFEv8wXXBiC7Pis0cgClpgnMc5zw5w152ceQMTGDTVZDTayN057GbKX1eI6e
         FIWSG2320vSjK64+MFW8OFkmwgk4ShCCfZ9+8IHjgeac+aoqgIAvUg9zNWiQhNIQ70+5
         7Ptxaz9VtcqUaVEI7A77BjyDhyHk55TRzMB8rbYuTckJ6AthdZf+uNOjifvUhMHYlMjv
         tmxkR94Dtz+fSdZVeB13AzicBoWqY1JqULJaTakyCzxjhUDz2WmptzntlEQ+pxN1hGn7
         mFUA==
X-Gm-Message-State: AOJu0YwTGeTszu6k5xPv7/ev4paj5SQW6NN8Tuo9Bdt2CuId+mhwKfrx
	y05OJYikP12qkeeEF5qwDJdVivRGMJLHJ27fYLi2eAHxD95dWXdOrdWaVBX1pw==
X-Gm-Gg: AZuq6aLuu5d0mAomPPcEEtfuOpCRFvDYZr586YFeb3IgCwgyjwiW3p09ltn02cfi19Y
	SSyhdYULp/jnvzvwu/C21fyUEexy2QnA2PlcdLFygW65g2a6Fd9zG8IDLmxVd1CQ0BQlU9SF52V
	tI9uMPUI2wGikXljTQt7Kk9+9wE5kf7IMm4HzOjL7uxGMzaGNUhfhwffSnWWAXKK7H7NGw0V9XS
	vyVcfVQaOeyFV7P+d8ZjzFfE3VibEq0h2uLzf5rk0BRzgmN9TwJ2+U0lCEyfiSxcEx430Os7wFi
	pxP85jYfhpvGCbWZqu6FaNz1TQ5+SH3+Ue7WRb5MHNhXAr66dGd5YBl0RwjtsWUngrrzuCDtol2
	Yuoo6b+n9nocfT12maIs8CmcMKcBspI8/vRJtVuX8Pix7V/gYzW2/LFw6/nAf15dnu8qecGoquw
	GXNiDhDl0Ag1IRgCB/fYhG4LbWwYmNivdkGvb10phErVi/PQyJ5LUVkKF33Up8Dg==
X-Received: by 2002:a05:690c:660f:b0:794:f92a:1063 with SMTP id 00721157ae682-7979e7f0b64mr40737567b3.16.1771030709607;
        Fri, 13 Feb 2026 16:58:29 -0800 (PST)
Received: from localhost.localdomain ([177.118.182.126])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7966c2533ccsm77824947b3.36.2026.02.13.16.58.27
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 13 Feb 2026 16:58:29 -0800 (PST)
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	gitster@pobox.com,
	jltobler@gmail.com,
	avila.jn@gmail.com,
	Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Subject: [PATCH v6 0/2] repo: add --keys and rename "keyvalue" to "lines"
Date: Fri, 13 Feb 2026 21:35:14 -0300
Message-ID: <20260214005818.37349-1-lucasseikioshiro@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251207190532.67107-1-lucasseikioshiro@gmail.com>
References: <20251207190532.67107-1-lucasseikioshiro@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi!

This v6 addresses these issues raised by Patrick:

- It renames `FORMAT_LINES` to `FORMAT_NEWLINE_TERMINATED`
- Change the commit messsage of the first patch (I'm using Patrick's
  suggestion)
- It capitalizes the new paragraphs

There was a discussion about the name of the new format ("lines" vs
"newline") [1]. Personally I prefer "lines" instead of "newline" because
I understand the --format flag expects a format name (e.g. `table`,
`lines`) instead of the delimiter, being `nul` only a short form of
"nul-terminated". But, of course, I'm open to other opinions about it
:-).

Thanks

[1] aXhiHAFNFxgsXa0S@pks.im

Lucas Seiki Oshiro (2):
  repo: rename the output format "keyvalue" to "lines"
  repo: add new flag --keys to git-repo-info

 Documentation/git-repo.adoc | 32 +++++++++++++++--------
 builtin/repo.c              | 51 ++++++++++++++++++++++++++++++-------
 t/t1900-repo.sh             | 44 ++++++++++++++++++++++----------
 t/t1901-repo-structure.sh   |  4 +--
 4 files changed, 97 insertions(+), 34 deletions(-)

Range-diff against v5:
1:  f5448ce915 ! 1:  6f5b4a577e repo: rename "keyvalue" to "lines"
    @@ Metadata
     Author: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
     
      ## Commit message ##
    -    repo: rename "keyvalue" to "lines"
    +    repo: rename the output format "keyvalue" to "lines"
     
    -    The output format name "keyvalue" isn't so descriptive. Rename it to
    -    "lines", since it describes better the syntax of the output format and
    -    it isn't tied to key-value pairs.
    +    Both subcommands in git-repo(1) accept the "keyvalue" format. This
    +    format is newline-delimited, where the key is separated from the
    +    value with an equals sign.
     
    +    The name of this option is suboptimal though, as it is both too
    +    limiting while at the same time not really indicating what it
    +    actually does:
    +
    +      - There is no mention of the format being newline-delimited, which
    +        is the key differentiator to the "nul" format.
    +
    +      - Both "nul" and "keyvalue" have a key and a value, so the latter
    +        is not exactly giving any hint what makes it so special.
    +
    +      - "keyvalue" requires there to be, well, a key and a value, but we
    +        want to add additional output that is only going to be newline
    +        delimited.
    +
    +    Taken together, "keyvalue" is kind of a bad name for this output
    +    format.
    +
    +    Luckily, the git-repo(1) command is still rather new and marked as
    +    experimental, so things aren't cast into stone yet. Rename the
    +    format to "lines" instead to better indicate that the major
    +    difference is that we'll get newline-delimited output. This new name
    +    will also be a better fit for a subsequent extension in git-repo(1).
    +
    +    Helped-by: Patrick Steinhardt <ps@pks.im>
         Signed-off-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
     
      ## Documentation/git-repo.adoc ##
    @@ builtin/repo.c: typedef int get_value_fn(struct repository *repo, struct strbuf
      enum output_format {
      	FORMAT_TABLE,
     -	FORMAT_KEYVALUE,
    -+	FORMAT_LINES,
    ++	FORMAT_NEWLINE_TERMINATED,
      	FORMAT_NUL_TERMINATED,
      };
      
    @@ builtin/repo.c: static void print_field(enum output_format format, const char *k
      {
      	switch (format) {
     -	case FORMAT_KEYVALUE:
    -+	case FORMAT_LINES:
    ++	case FORMAT_NEWLINE_TERMINATED:
      		printf("%s=", key);
      		quote_c_style(value, NULL, stdout, 0);
      		putchar('\n');
    @@ builtin/repo.c: static int parse_format_cb(const struct option *opt,
     -	else if (!strcmp(arg, "keyvalue"))
     -		*format = FORMAT_KEYVALUE;
     +	else if (!strcmp(arg, "lines"))
    -+		*format = FORMAT_LINES;
    ++		*format = FORMAT_NEWLINE_TERMINATED;
      	else if (!strcmp(arg, "table"))
      		*format = FORMAT_TABLE;
      	else
    @@ builtin/repo.c: static int parse_format_cb(const struct option *opt,
      			 struct repository *repo)
      {
     -	enum output_format format = FORMAT_KEYVALUE;
    -+	enum output_format format = FORMAT_LINES;
    ++	enum output_format format = FORMAT_NEWLINE_TERMINATED;
      	int all_keys = 0;
      	struct option options[] = {
      		OPT_CALLBACK_F(0, "format", &format, N_("format"),
    @@ builtin/repo.c: static int cmd_repo_info(int argc, const char **argv, const char
      	argc = parse_options(argc, argv, prefix, options, repo_usage, 0);
     -	if (format != FORMAT_KEYVALUE && format != FORMAT_NUL_TERMINATED)
     +
    -+	if (format != FORMAT_LINES && format != FORMAT_NUL_TERMINATED)
    ++	if (format != FORMAT_NEWLINE_TERMINATED && format != FORMAT_NUL_TERMINATED)
      		die(_("unsupported output format"));
      
      	if (all_keys && argc)
    @@ builtin/repo.c: static int cmd_repo_structure(int argc, const char **argv, const
      		stats_table_print_structure(&table);
      		break;
     -	case FORMAT_KEYVALUE:
    -+	case FORMAT_LINES:
    ++	case FORMAT_NEWLINE_TERMINATED:
      		structure_keyvalue_print(&stats, '=', '\n');
      		break;
      	case FORMAT_NUL_TERMINATED:
2:  16bc72afe1 ! 2:  53503e1433 repo: add new flag --keys to git-repo-info
    @@ Documentation/git-repo.adoc: supported:
     +	through the flag `--format`. The following formats are supported:
     ++
     +`lines`:::
    -+	output the keys one per line. This is the default.
    ++	Output the keys one per line. This is the default.
     +
     +`nul`:::
    -+	similar to `lines`, but using a _NUL_ character after each value.
    ++	Similar to `lines`, but using a _NUL_ character after each value.
     +
      `structure [--format=(table|lines|nul) | -z]`::
      	Retrieve statistics about the current repository structure. The
    @@ builtin/repo.c: static int print_all_fields(struct repository *repo,
     +	char sep;
     +
     +	switch (format) {
    -+	case FORMAT_LINES:
    ++	case FORMAT_NEWLINE_TERMINATED:
     +		sep = '\n';
     +		break;
     +	case FORMAT_NUL_TERMINATED:
    @@ builtin/repo.c: static int print_all_fields(struct repository *repo,
      {
     @@ builtin/repo.c: static int cmd_repo_info(int argc, const char **argv, const char *prefix,
      {
    - 	enum output_format format = FORMAT_LINES;
    + 	enum output_format format = FORMAT_NEWLINE_TERMINATED;
      	int all_keys = 0;
     +	int show_keys = 0;
      	struct option options[] = {
    @@ builtin/repo.c: static int cmd_repo_info(int argc, const char **argv, const char
     +	if (show_keys)
     +		return print_keys(format);
     +
    - 	if (format != FORMAT_LINES && format != FORMAT_NUL_TERMINATED)
    + 	if (format != FORMAT_NEWLINE_TERMINATED && format != FORMAT_NUL_TERMINATED)
      		die(_("unsupported output format"));
      
     
-- 
2.50.1 (Apple Git-155)


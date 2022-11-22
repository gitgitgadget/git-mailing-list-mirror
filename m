Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33735C433FE
	for <git@archiver.kernel.org>; Tue, 22 Nov 2022 14:23:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232833AbiKVOXz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Nov 2022 09:23:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232695AbiKVOXs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Nov 2022 09:23:48 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A14DFB7CD
        for <git@vger.kernel.org>; Tue, 22 Nov 2022 06:23:46 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id n3so8396864wrp.5
        for <git@vger.kernel.org>; Tue, 22 Nov 2022 06:23:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OjTt2M84DtyHTIJtbFC8v/9H6UEBI8EVVQlzwMXA7HY=;
        b=BSnQwLZeGQe81yR5r54Exiarc6q/JJUBrWkmPScD8Ap2sURmGPbIsM319PKHv/hksP
         l3GML5b7ttAITuRzq8Vrmm9l2J1nx/dVbbgGYMJ66sM1L1o5aH6ie0t4ctKnBi1r+9nJ
         JPUODI+y2IqSzh46uedDxMbqY81/RhTX1siMYWP8R8KHV5BJp5iM8la7WLg43Ql/2saZ
         u0eO6BMq8Gyd2GzGHeFX/D6+gwbFd3/GOE8Oqa1yZDli+wiyXcE29q8utfXbF3krfL09
         sxdpJOXU2itvu5RWqrPNlRPZxBnAJRxFvGTlnf3sceAiL7Lp88zl7u5WdOjdjMfxw9ol
         8R4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OjTt2M84DtyHTIJtbFC8v/9H6UEBI8EVVQlzwMXA7HY=;
        b=4e7a/bPYN7rW7sKZeWV0pReId+GzgxDQgKrGr/p9QTqzTf0N4N/qOi89aBG7KeZft0
         O1UqviaWgzy8i7UmkHtttwSysMoACP3wM6sFBpKKoKVgmkQgMaWhESThsLuYzPdyncyu
         f1UUN68n9kmjEw9bCr6/q5MjNXuvRaLb0T6CUpip9+pOFuHKDgXFhtvG5xDIo+EqdXxx
         3IHBZNQo281R5dTCr69Y84SsPAYnv3F21Uos6n+jdc+FVP1AGPEcgMcz+mcjdsyRF1Om
         5XtLaOtuCiFIBSVWsTizJ/hwMwhR+9vueHm5yqT9LB4QSLJnzQXE5sEBRX4B6uyMWGkb
         ggww==
X-Gm-Message-State: ANoB5pmC+Eu6/0mF4lpueynRmk8Jba+H1Ap9IrxpDGJiwlr21WlWU446
        c0LRyIQd4r5gwbsom2aHPQ0=
X-Google-Smtp-Source: AA0mqf4AL0yIISJdj9KRIBinP3cZZ/r3W8zpPAi9d2YSsXbV6Z+D0vHONwjAZpp8ZwDjHq92af5qeg==
X-Received: by 2002:a5d:4ccb:0:b0:236:d611:4fcf with SMTP id c11-20020a5d4ccb000000b00236d6114fcfmr3699983wrt.192.1669127025035;
        Tue, 22 Nov 2022 06:23:45 -0800 (PST)
Received: from [192.168.1.74] ([31.185.185.212])
        by smtp.gmail.com with ESMTPSA id q14-20020a05600c46ce00b003c5571c27a1sm21646425wmo.32.2022.11.22.06.23.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Nov 2022 06:23:44 -0800 (PST)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <4b6dc149-ae7a-575d-97a5-0f421d7f9bb2@dunelm.org.uk>
Date:   Tue, 22 Nov 2022 14:23:41 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3] range-diff: support reading mbox files
Content-Language: en-US
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.1420.v2.git.1668899471058.gitgitgadget@gmail.com>
 <pull.1420.v3.git.1669108102092.gitgitgadget@gmail.com>
In-Reply-To: <pull.1420.v3.git.1669108102092.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho

On 22/11/2022 09:08, Johannes Schindelin via GitGitGadget wrote:
 > [...]
>      Changes since v2:
>      
>       * Fixed two leaks
>       * Avoided dropping a patch just because it does not end in a "-- " line
>       * Empty lines in the middle of a diff are now treated as context lines
>         (newer GNU diff versions generate those)

Oh, well spotted, I should have thought of that myself.

>       * We now warn when a parsed diff is incomplete (i.e. when the ranges in
>         the hunk header do not line up with the number of parsed lines), but
>         still follow Postel's Law i.e. being kind and accepting.

This version looks good to me, thanks for working on it.

Best Wishes

Phillip

>      Changes since v1:
>      
>       * We no longer leak allocated memory in the struct patch instance
>       * Made strtost() a bit more stringent
>       * Postel [https://en.wikipedia.org/wiki/Postel%27s_Law]ized the mbox
>         parser substantially, together with a couple more cosmetic fixes,
>         based on Phillip Wood's excellent review of v1.
>       * Extended the test case to cover mboxes containing CR/LF and in-body
>         From: lines
> 
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1420%2Fdscho%2Frange-diff-from-mbox-v3
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1420/dscho/range-diff-from-mbox-v3
> Pull-Request: https://github.com/gitgitgadget/git/pull/1420
> 
> Range-diff vs v2:
> 
>   1:  485249ddfb3 ! 1:  ac4d8704068 range-diff: support reading mbox files
>       @@ range-diff.c: struct patch_util {
>        +
>        +		len = find_next_line(line, size);
>        +
>       -+		if (state == MBOX_BEFORE_HEADER ||
>       -+		    (state == MBOX_IN_DIFF && line[0] == 'F')) {
>       ++		if (state == MBOX_BEFORE_HEADER) {
>       ++parse_from_delimiter:
>        +			if (!skip_prefix(line, "From ", &p))
>        +				continue;
>        +
>       ++			if (util)
>       ++				BUG("util already allocated");
>        +			util = xcalloc(1, sizeof(*util));
>        +			if (get_oid_hex(p, &util->oid) < 0)
>        +				oidcpy(&util->oid, null_oid());
>       @@ range-diff.c: struct patch_util {
>        +			}
>        +		} else if (state == MBOX_IN_DIFF) {
>        +			switch (line[0]) {
>       -+			case '\0':
>       -+				continue; /* ignore empty lines after diff */
>       ++			case '\0': /* newer GNU diff, an empty context line */
>        +			case '+':
>        +			case '-':
>        +			case ' ':
>       @@ range-diff.c: struct patch_util {
>        +				strbuf_addch(&buf, '\n');
>        +				util->diffsize++;
>        +				continue;
>       ++			default:
>       ++				if (old_count || new_count)
>       ++					warning(_("diff ended prematurely (-%d/+%d)"),
>       ++						(int)old_count, (int)new_count);
>       ++				break;
>        +			}
>        +
>        +			if (util) {
>        +				string_list_append(list, buf.buf)->util = util;
>       ++				util = NULL;
>        +				strbuf_reset(&buf);
>        +			}
>       -+			util = xcalloc(1, sizeof(*util));
>       -+			oidcpy(&util->oid, null_oid());
>       -+			util->matching = -1;
>       -+			author = subject = NULL;
>        +			state = MBOX_BEFORE_HEADER;
>       ++			goto parse_from_delimiter;
>        +		}
>        +	}
>        +	strbuf_release(&contents);
>       @@ range-diff.c: int show_range_diff(const char *range1, const char *range2,
>         	struct rev_info revs;
>         
>        +	if (skip_prefix(arg, "mbox:", &path)) {
>       ++		free(copy);
>        +		if (!strcmp(path, "-") || file_exists(path))
>        +			return 1;
>        +		error_errno(_("not an mbox: '%s'"), path);
> 
> 
>   Documentation/git-range-diff.txt |   3 +-
>   range-diff.c                     | 338 ++++++++++++++++++++++++++++++-
>   t/t3206-range-diff.sh            |  27 +++
>   3 files changed, 366 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/git-range-diff.txt b/Documentation/git-range-diff.txt
> index 0b393715d70..e2c4661acde 100644
> --- a/Documentation/git-range-diff.txt
> +++ b/Documentation/git-range-diff.txt
> @@ -37,7 +37,8 @@ There are three ways to specify the commit ranges:
>   
>   - `<range1> <range2>`: Either commit range can be of the form
>     `<base>..<rev>`, `<rev>^!` or `<rev>^-<n>`. See `SPECIFYING RANGES`
> -  in linkgit:gitrevisions[7] for more details.
> +  in linkgit:gitrevisions[7] for more details. Alternatively, the
> +  patches can be provided as an mbox-formatted file via `mbox:<path>`.
>   
>   - `<rev1>...<rev2>`. This is equivalent to
>     `<rev2>..<rev1> <rev1>..<rev2>`.
> diff --git a/range-diff.c b/range-diff.c
> index 124dd678c38..c391ffa603b 100644
> --- a/range-diff.c
> +++ b/range-diff.c
> @@ -12,6 +12,7 @@
>   #include "userdiff.h"
>   #include "apply.h"
>   #include "revision.h"
> +#include "dir.h"
>   
>   struct patch_util {
>   	/* For the search for an exact match */
> @@ -26,6 +27,313 @@ struct patch_util {
>   	struct object_id oid;
>   };
>   
> +static inline int strtost(char const *s, size_t *result, const char **end)
> +{
> +	unsigned long u;
> +	char *p;
> +
> +	errno = 0;
> +	/* negative values would be accepted by strtoul */
> +	if (!isdigit(*s))
> +		return -1;
> +	u = strtoul(s, &p, 10);
> +	if (errno || p == s)
> +		return -1;
> +	if (result)
> +		*result = u;
> +	*end = p;
> +
> +	return 0;
> +}
> +
> +static int parse_hunk_header(const char *p,
> +			     size_t *old_count, size_t *new_count,
> +			     const char **end)
> +{
> +	size_t o = 1, n = 1;
> +
> +	if (!skip_prefix(p, "@@ -", &p) ||
> +	    strtost(p, NULL, &p) ||
> +	    /* The range is -<start>[,<count>], defaulting to count = 1 */
> +	    !(*p == ' ' || (*p == ',' && !strtost(p + 1, &o, &p))) ||
> +	    !skip_prefix(p, " +", &p) ||
> +	    strtost(p, NULL, &p) ||
> +	    /* The range is +<start>[,<count>], defaulting to count = 1 */
> +	    !(*p == ' ' || (*p == ',' && !strtost(p + 1, &n, &p))) ||
> +	    !skip_prefix(p, " @@", &p))
> +		return -1;
> +
> +	*old_count = o;
> +	*new_count = n;
> +	*end = p;
> +
> +	return 0;
> +}
> +
> +/*
> + * This function finds the end of the line, replaces the newline character with
> + * a NUL, and returns the offset of the start of the next line.
> + *
> + * If no newline character was found, it returns the offset of the trailing NUL
> + * instead.
> + */
> +static inline int find_next_line(const char *line, size_t size)
> +{
> +	char *eol;
> +
> +	eol = memchr(line, '\n', size);
> +	if (!eol)
> +		return size;
> +
> +	*eol = '\0';
> +
> +	return eol + 1 - line;
> +}
> +
> +static int read_mbox(const char *path, struct string_list *list)
> +{
> +	struct strbuf buf = STRBUF_INIT, contents = STRBUF_INIT;
> +	struct strbuf long_subject = STRBUF_INIT;
> +	struct patch_util *util = NULL;
> +	enum {
> +		MBOX_BEFORE_HEADER,
> +		MBOX_IN_HEADER,
> +		MBOX_IN_COMMIT_MESSAGE,
> +		MBOX_AFTER_TRIPLE_DASH,
> +		MBOX_IN_DIFF
> +	} state = MBOX_BEFORE_HEADER;
> +	char *line, *current_filename = NULL;
> +	int len;
> +	size_t size, old_count = 0, new_count = 0;
> +	const char *author = NULL, *subject = NULL;
> +
> +	if (!strcmp(path, "-")) {
> +		if (strbuf_read(&contents, STDIN_FILENO, 0) < 0)
> +			return error_errno(_("could not read stdin"));
> +	} else if (strbuf_read_file(&contents, path, 0) < 0)
> +		return error_errno(_("could not read '%s'"), path);
> +
> +	line = contents.buf;
> +	size = contents.len;
> +	for (; size; size -= len, line += len) {
> +		const char *p;
> +
> +		len = find_next_line(line, size);
> +
> +		if (state == MBOX_BEFORE_HEADER) {
> +parse_from_delimiter:
> +			if (!skip_prefix(line, "From ", &p))
> +				continue;
> +
> +			if (util)
> +				BUG("util already allocated");
> +			util = xcalloc(1, sizeof(*util));
> +			if (get_oid_hex(p, &util->oid) < 0)
> +				oidcpy(&util->oid, null_oid());
> +			util->matching = -1;
> +			author = subject = NULL;
> +
> +			state = MBOX_IN_HEADER;
> +			continue;
> +		}
> +
> +		if (starts_with(line, "diff --git ")) {
> +			struct patch patch = { 0 };
> +			struct strbuf root = STRBUF_INIT;
> +			int linenr = 0;
> +			int orig_len;
> +
> +			state = MBOX_IN_DIFF;
> +			old_count = new_count = 0;
> +			strbuf_addch(&buf, '\n');
> +			if (!util->diff_offset)
> +				util->diff_offset = buf.len;
> +
> +			orig_len = len;
> +			/* `find_next_line()`'s replaced the LF with a NUL */
> +			line[len - 1] = '\n';
> +			len = len > 1 && line[len - 2] == '\r' ?
> +				error(_("cannot handle diff headers with "
> +					"CR/LF line endings")) :
> +				parse_git_diff_header(&root, &linenr, 1, line,
> +						      len, size, &patch);
> +			if (len < 0) {
> +				error(_("could not parse git header '%.*s'"),
> +				      orig_len, line);
> +				release_patch(&patch);
> +				free(util);
> +				free(current_filename);
> +				string_list_clear(list, 1);
> +				strbuf_release(&buf);
> +				strbuf_release(&contents);
> +				strbuf_release(&long_subject);
> +				return -1;
> +			}
> +
> +			if (patch.old_name)
> +				skip_prefix(patch.old_name, "a/",
> +					    (const char **)&patch.old_name);
> +			if (patch.new_name)
> +				skip_prefix(patch.new_name, "b/",
> +					    (const char **)&patch.new_name);
> +
> +			strbuf_addstr(&buf, " ## ");
> +			if (patch.is_new)
> +				strbuf_addf(&buf, "%s (new)", patch.new_name);
> +			else if (patch.is_delete)
> +				strbuf_addf(&buf, "%s (deleted)", patch.old_name);
> +			else if (patch.is_rename)
> +				strbuf_addf(&buf, "%s => %s", patch.old_name, patch.new_name);
> +			else
> +				strbuf_addstr(&buf, patch.new_name);
> +
> +			free(current_filename);
> +			if (patch.is_delete)
> +				current_filename = xstrdup(patch.old_name);
> +			else
> +				current_filename = xstrdup(patch.new_name);
> +
> +			if (patch.new_mode && patch.old_mode &&
> +			    patch.old_mode != patch.new_mode)
> +				strbuf_addf(&buf, " (mode change %06o => %06o)",
> +					    patch.old_mode, patch.new_mode);
> +
> +			strbuf_addstr(&buf, " ##\n");
> +			util->diffsize++;
> +			release_patch(&patch);
> +		} else if (state == MBOX_IN_HEADER) {
> +			if (!line[0]) {
> +				state = MBOX_IN_COMMIT_MESSAGE;
> +				/* Look for an in-body From: */
> +				if (skip_prefix(line + 1, "From: ", &p)) {
> +					size -= p - line;
> +					line += p - line;
> +					len = find_next_line(line, size);
> +
> +					while (isspace(*p))
> +						p++;
> +					author = p;
> +				}
> +				strbuf_addstr(&buf, " ## Metadata ##\n");
> +				if (author)
> +					strbuf_addf(&buf, "Author: %s\n", author);
> +				strbuf_addstr(&buf, "\n ## Commit message ##\n");
> +				if (subject)
> +					strbuf_addf(&buf, "    %s\n\n", subject);
> +			} else if (skip_prefix(line, "From: ", &p)) {
> +				while (isspace(*p))
> +					p++;
> +				author = p;
> +			} else if (skip_prefix(line, "Subject: ", &p)) {
> +				const char *q;
> +
> +				while (isspace(*p))
> +					p++;
> +				subject = p;
> +
> +				if (starts_with(p, "[PATCH") &&
> +				    (q = strchr(p, ']'))) {
> +					q++;
> +					while (isspace(*q))
> +						q++;
> +					subject = q;
> +				}
> +
> +				if (len < size && line[len] == ' ') {
> +					/* handle long subject */
> +					strbuf_reset(&long_subject);
> +					strbuf_addstr(&long_subject, subject);
> +					while (len < size && line[len] == ' ') {
> +						line += len;
> +						size -= len;
> +						len = find_next_line(line, size);
> +						strbuf_addstr(&long_subject, line);
> +					}
> +					subject = long_subject.buf;
> +				}
> +			}
> +		} else if (state == MBOX_IN_COMMIT_MESSAGE) {
> +			if (!line[0]) {
> +				strbuf_addch(&buf, '\n');
> +			} else if (strcmp(line, "---")) {
> +				int tabs = 0;
> +
> +				/* simulate tab expansion */
> +				while (line[tabs] == '\t')
> +					tabs++;
> +				strbuf_addf(&buf, "%*s%s\n",
> +					    4 + 8 * tabs, "", line + tabs);
> +			} else {
> +				/*
> +				 * Trim the trailing newline that is added
> +				 * by `format-patch`.
> +				 */
> +				strbuf_trim_trailing_newline(&buf);
> +				state = MBOX_AFTER_TRIPLE_DASH;
> +			}
> +		} else if (state == MBOX_IN_DIFF) {
> +			switch (line[0]) {
> +			case '\0': /* newer GNU diff, an empty context line */
> +			case '+':
> +			case '-':
> +			case ' ':
> +				/* A `-- ` line indicates the end of a diff */
> +				if (!old_count && !new_count)
> +					break;
> +				if (old_count && line[0] != '+')
> +					old_count--;
> +				if (new_count && line[0] != '-')
> +					new_count--;
> +				/* fallthrough */
> +			case '\\':
> +				strbuf_addstr(&buf, line);
> +				strbuf_addch(&buf, '\n');
> +				util->diffsize++;
> +				continue;
> +			case '@':
> +				if (parse_hunk_header(line, &old_count,
> +						      &new_count, &p))
> +					break;
> +
> +				strbuf_addstr(&buf, "@@");
> +				if (current_filename && *p)
> +					strbuf_addf(&buf, " %s:",
> +						    current_filename);
> +				strbuf_addstr(&buf, p);
> +				strbuf_addch(&buf, '\n');
> +				util->diffsize++;
> +				continue;
> +			default:
> +				if (old_count || new_count)
> +					warning(_("diff ended prematurely (-%d/+%d)"),
> +						(int)old_count, (int)new_count);
> +				break;
> +			}
> +
> +			if (util) {
> +				string_list_append(list, buf.buf)->util = util;
> +				util = NULL;
> +				strbuf_reset(&buf);
> +			}
> +			state = MBOX_BEFORE_HEADER;
> +			goto parse_from_delimiter;
> +		}
> +	}
> +	strbuf_release(&contents);
> +
> +	if (util) {
> +		if (state == MBOX_IN_DIFF)
> +			string_list_append(list, buf.buf)->util = util;
> +		else
> +			free(util);
> +	}
> +	strbuf_release(&buf);
> +	strbuf_release(&long_subject);
> +	free(current_filename);
> +
> +	return 0;
> +}
> +
>   /*
>    * Reads the patches into a string list, with the `util` field being populated
>    * as struct object_id (will need to be free()d).
> @@ -41,6 +349,10 @@ static int read_patches(const char *range, struct string_list *list,
>   	ssize_t len;
>   	size_t size;
>   	int ret = -1;
> +	const char *path;
> +
> +	if (skip_prefix(range, "mbox:", &path))
> +		return read_mbox(path, list);
>   
>   	strvec_pushl(&cp.args, "log", "--no-color", "-p", "--no-merges",
>   		     "--reverse", "--date-order", "--decorate=no",
> @@ -424,6 +736,19 @@ static void output_pair_header(struct diff_options *diffopt,
>   
>   		strbuf_addch(buf, ' ');
>   		pp_commit_easy(CMIT_FMT_ONELINE, commit, buf);
> +	} else {
> +		struct patch_util *util = b_util ? b_util : a_util;
> +		const char *needle = "\n ## Commit message ##\n";
> +		const char *p = !util || !util->patch ?
> +			NULL : strstr(util->patch, needle);
> +		if (p) {
> +			if (status == '!')
> +				strbuf_addf(buf, "%s%s", color_reset, color);
> +
> +			strbuf_addch(buf, ' ');
> +			p += strlen(needle);
> +			strbuf_add(buf, p, strchrnul(p, '\n') - p);
> +		}
>   	}
>   	strbuf_addf(buf, "%s\n", color_reset);
>   
> @@ -554,6 +879,9 @@ int show_range_diff(const char *range1, const char *range2,
>   	if (range_diff_opts->left_only && range_diff_opts->right_only)
>   		res = error(_("options '%s' and '%s' cannot be used together"), "--left-only", "--right-only");
>   
> +	if (!strcmp(range1, "mbox:-") && !strcmp(range2, "mbox:-"))
> +		res = error(_("only one mbox can be read from stdin"));
> +
>   	if (!res && read_patches(range1, &branch1, range_diff_opts->other_arg))
>   		res = error(_("could not parse log for '%s'"), range1);
>   	if (!res && read_patches(range2, &branch2, range_diff_opts->other_arg))
> @@ -575,10 +903,18 @@ int show_range_diff(const char *range1, const char *range2,
>   int is_range_diff_range(const char *arg)
>   {
>   	char *copy = xstrdup(arg); /* setup_revisions() modifies it */
> -	const char *argv[] = { "", copy, "--", NULL };
> +	const char *argv[] = { "", copy, "--", NULL }, *path;
>   	int i, positive = 0, negative = 0;
>   	struct rev_info revs;
>   
> +	if (skip_prefix(arg, "mbox:", &path)) {
> +		free(copy);
> +		if (!strcmp(path, "-") || file_exists(path))
> +			return 1;
> +		error_errno(_("not an mbox: '%s'"), path);
> +		return 0;
> +	}
> +
>   	init_revisions(&revs, NULL);
>   	if (setup_revisions(3, argv, &revs, NULL) == 1) {
>   		for (i = 0; i < revs.pending.nr; i++)
> diff --git a/t/t3206-range-diff.sh b/t/t3206-range-diff.sh
> index 459beaf7d9c..89ef9a5ffc4 100755
> --- a/t/t3206-range-diff.sh
> +++ b/t/t3206-range-diff.sh
> @@ -783,6 +783,33 @@ test_expect_success 'ranges with pathspecs' '
>   	! grep "$topic_oid" actual
>   '
>   
> +test_expect_success 'compare range vs mbox' '
> +	git format-patch --stdout topic..mode-only-change >mbox &&
> +	git range-diff topic...mode-only-change >expect &&
> +
> +	git range-diff mode-only-change..topic mbox:./mbox >actual &&
> +	test_cmp expect actual &&
> +
> +	sed -e "/^From: .*/{
> +		h
> +		s/.*/From: Bugs Bunny <bugs@bun.ny>/
> +		:1
> +		N
> +		/[ -z]$/b1
> +		G
> +	}" <mbox >mbox.from &&
> +	git range-diff mode-only-change..topic mbox:./mbox.from >actual.from &&
> +	test_cmp expect actual.from &&
> +
> +	append_cr <mbox >mbox.cr &&
> +	test_must_fail git range-diff \
> +		mode-only-change..topic mbox:./mbox.cr 2>err &&
> +	grep CR/LF err &&
> +
> +	git range-diff mode-only-change..topic mbox:- <mbox >actual.stdin &&
> +	test_cmp expect actual.stdin
> +'
> +
>   test_expect_success 'submodule changes are shown irrespective of diff.submodule' '
>   	git init sub-repo &&
>   	test_commit -C sub-repo sub-first &&
> 
> base-commit: b75747829f4c277323c78b1c5973ad63ea038a2d

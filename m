Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CAF2C433FE
	for <git@archiver.kernel.org>; Wed, 16 Nov 2022 14:41:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233254AbiKPOlJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Nov 2022 09:41:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233545AbiKPOk6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Nov 2022 09:40:58 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5490391DC
        for <git@vger.kernel.org>; Wed, 16 Nov 2022 06:40:52 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id a14so30275642wru.5
        for <git@vger.kernel.org>; Wed, 16 Nov 2022 06:40:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uS6csVoNK2gsCcegz/LKf0ND28m8k3ik4yB6UpCTA5c=;
        b=BzTCV0Fp0E2howyBgNPX3WvIEm6+OnbYVWHD4+2WT63t9RrtAZak4JtB1Ga+eeMpsZ
         WQmu2SJqLLd81oybv/L7WOPNiw7pzL/eLvxwbqov0NsMzQ7pcE4S/tKg/mYR6Gc4NqpV
         MwVK7i7G13DIG26qj9k0Vn4SAR21+/p9ijz86eUmPxlaz8s7uSNxBl/qexsd7jRBXjOF
         QltMfii0KUHmJOKvW2EFlX2/DPI71I6v2eZ7bpIMoJnJ5M1npfSLObBDb9Vp51UnnhDL
         5o3y2hBoedPO5GeSoiwbDFt5vxV5ib4V819P0h5HYYSFEuSkp2+905lZS4JnVcg4aViq
         +3mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uS6csVoNK2gsCcegz/LKf0ND28m8k3ik4yB6UpCTA5c=;
        b=BydUsvxtkfpBsxK4oUDGZkxPl3jwUjnu8nBHPRto2wNedJ3Klj1c/6mb/+cqBMCxhj
         H/YPTGmV61E1vx4NNydmYK1LzMJILesU0ffH5iT/kkNVGGosJwq/LPR/HDvZRIhya+Yv
         +OIQ84Mxzn0de6FPf7sc9kveRj0EMqq34Z1IAdE0lZZ/CLbk7Zqxb787mm4HLrNZD7H4
         CB8YgHh0kBwJD4kdefXqMpaAWG5nGIiKIOUr8kNGuRFUCsfH/N/PXn32wLgizp//E24K
         4X1lqljnos8aQgBAZAoU7tUaLyhQOUZJS6hDOYNJv00vYgpwm1/zLop3yV5KYsbc6Y+n
         Okmg==
X-Gm-Message-State: ANoB5pnsb1S4fhrzDPN6j4Qilm49+SbDxR/y0C8rgZ77I0XhpjMoLZgH
        Qd3O7bAvbR8TX6usPRG+cRs=
X-Google-Smtp-Source: AA0mqf4BvyICt7FbDyJbI9kT0vEjtMGz0nA2fn+WbtsrKYAjbEGeIESKTMQMXb+liJdiC6LcM7XZiw==
X-Received: by 2002:a5d:4912:0:b0:236:a68f:23e2 with SMTP id x18-20020a5d4912000000b00236a68f23e2mr13528860wrq.521.1668609650851;
        Wed, 16 Nov 2022 06:40:50 -0800 (PST)
Received: from [192.168.1.74] ([31.185.185.212])
        by smtp.gmail.com with ESMTPSA id s3-20020adfecc3000000b0022e653f5abbsm15242317wro.69.2022.11.16.06.40.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Nov 2022 06:40:50 -0800 (PST)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <dfe0190c-1d2e-804a-5312-877b7b2f5822@dunelm.org.uk>
Date:   Wed, 16 Nov 2022 14:40:49 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] range-diff: support reading mbox files
Content-Language: en-US
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Taylor Blau <me@ttaylorr.com>
References: <pull.1420.git.1668536405563.gitgitgadget@gmail.com>
In-Reply-To: <pull.1420.git.1668536405563.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho

On 15/11/2022 18:20, Johannes Schindelin via GitGitGadget wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> Internally, the `git range-diff` command spawns a `git log` process and
> parses its output for the given commit ranges.
> 
> This works well when the patches that need to be compared are present in
> the local repository in the form of commits.
> 
> In scenarios where that is not the case, the `range-diff` command is
> currently less helpful.
> 
> The Git mailing list is such a scenario: Instead of using Git to
> exchange commits, the patches are sent there as plain-text and no commit
> range can be specified to let `range-diff` consume those patches.
> 
> Instead, the expectation is to download the mails, apply them locally
> and then use `range-diff`. This can be quite cumbersome e.g. when a
> suitable base revision has to be found first where the patch applies
> cleanly.

That's a good motivation for this change.

> Let's offer a way to read those patches from pre-prepared MBox files
> instead when an argument "mbox:<filename>" is passed instead of a commit
> range.
> 
> For extra convenience, interpret the filename `-` as standard input.
> This makes it easy to compare contributions on the mailing list with the
> actual commits that were integrated into Git's main branch. Example:
> 
> 	commit=5c4003ca3f0e9ac6d3c8aa3e387ff843bd440411
> 	mid=bdfa3845b81531863941e6a97c28eb1afa62dd2c.1489435755.git.johannes.schindelin@gmx.de
> 	curl -s https://lore.kernel.org/git/$mid/raw |
> 	git range-diff mbox:- $commit^!
> 
> This addresses https://github.com/gitgitgadget/git/issues/207
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>      range-diff: support reading mbox files
>      
>      I frequently find myself wanting to look at the range-diff between some
>      local commits and the patches on the Git mailing list, but unwilling to
>      go through the process of finding an appropriate base revision to apply
>      the patches onto (just to throw the generated patches away afterwards,
>      anyway).
>      
>      So I came up with this patch. May it be helpful to other developers,
>      too.
>      
>      This patch contains a home-rolled mbox parser. Initially, I wrote a
>      really basic parser and it worked well enough, but, you know, as things
>      go it became more complex than that in order to provide actually useful
>      range-diffs for existing commits and their corresponding mails (because
>      of in-body From: headers, because of -- trailers and long subjects, just
>      to name a few reasons). In hindsight, it might have made sense to try to
>      to reuse the parser that is available in mailinfo.c, which I had
>      initially dismissed as overly complex and unnecessary for this use case.
>      If anyone feels up to it, I would invite them to adjust this code to
>      replace the mbox parser with one based on the mailinfo.c. Incrementally,
>      of course, because the perfect is the enemy of the good.
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1420%2Fdscho%2Frange-diff-from-mbox-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1420/dscho/range-diff-from-mbox-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/1420
> 
>   Documentation/git-range-diff.txt |   3 +-
>   range-diff.c                     | 317 ++++++++++++++++++++++++++++++-
>   t/t3206-range-diff.sh            |   9 +
>   3 files changed, 327 insertions(+), 2 deletions(-)
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
> index 124dd678c38..7c84cdbeffa 100644
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
> @@ -26,6 +27,293 @@ struct patch_util {
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
> +	if (*s == '-')
> +		return -1;

I think it is right to treat the input as untrusted and so look for 
malformed hunk headers. However This test is not sufficient for that, we 
expect a digit so I think

	if (!isdigit(*s))
		return -1;

would be safer. The use of strtoul() looks good as we set errno to zero 
before the call and check both errno and endp afterwards.

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
> +	    (*p != ' ' && (*p != ',' || strtost(p + 1, &o, &p))) ||

It took me a minute to understand the double negatives but it is 
correctly checking if we have ' ' or ',<digits>'

> +	    !skip_prefix(p, " +", &p) ||
> +	    strtost(p, NULL, &p) ||
> +	    (*p != ' ' && (*p != ',' || strtost(p + 1, &n, &p))) ||
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
> +static inline int find_eol(const char *line, size_t size)
> +{
> +	char *eol;
> +
> +	eol = memchr(line, '\n', size);
> +	if (!eol)
> +		return size;
> +
> +	if (eol != line && eol[-1] == '\r')
> +		eol[-1] = '\0';
> +	else
> +		*eol = '\0';
> +
> +	return eol + 1 - line;

We return the offset to the start of the next line, not the length of 
the line. This will be important later.

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
> +	for (; size > 0; size -= len, line += len) {

size is unsigned so we're effectively testing 'size != 0' which means if 
we're off by one somewhere we'll have an undetected buffer overflow. 
Using a signed type wouldn't prevent the buffer overflow but it would 
limit its extent.

> +		const char *p;
> +
> +		len = find_eol(line, size);

Here len is not the length of line if it originally ended "\r\n".

> +		if (state == MBOX_BEFORE_HEADER) {
> +			if (!skip_prefix(line, "From ", &p))
> +				continue;
> +
> +			util = xcalloc(1, sizeof(*util));
> +			if (get_oid_hex(p, &util->oid) < 0)
> +				oidcpy(&util->oid, null_oid());
> +			util->matching = -1;
> +			author = subject = NULL;
> +
> +			state = MBOX_IN_HEADER;

I wondered if there should there be a `continue;` here but I think it 
probably needs to "fall-through" to the MBOX_IN_HEADER handling below. A 
comment to clarify that would be helpful.

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
> +			line[len - 1] = '\n';

Here the line will still be NUL terminated if it originally ended "\r\n" 
which presumably messes up the call to parse_git_diff_header() below. I 
have not checked if parse_git_diff_header() can handle "\r\n" when it is 
parsing the rest of the diff header.

> +			orig_len = len;
> +			len = parse_git_diff_header(&root, &linenr, 1, line,
> +						    len, size, &patch);
> +			if (len < 0) {
> +				error(_("could not parse git header '%.*s'"),
> +				      orig_len, line);
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

I think this is fine for now but we might want to support other prefixes 
in the future. If it is not a copy or rename then the filename can be 
deduced by finding the common tail of patch.old_name and patch.new_name 
and stripping anything before the first '/'. If it is a copy or rename 
then I suspect there is no prefix (though I've not checked)

> +			strbuf_addstr(&buf, " ## ");
> +			if (patch.is_new > 0)

`patch.is_now` and `patch.is_delete` are booleans like `patch.is_rename` 
so we don't need the '> 0'

> +				strbuf_addf(&buf, "%s (new)", patch.new_name);
> +			else if (patch.is_delete > 0)
> +				strbuf_addf(&buf, "%s (deleted)", patch.old_name);
> +			else if (patch.is_rename)
> +				strbuf_addf(&buf, "%s => %s", patch.old_name, patch.new_name);
> +			else
> +				strbuf_addstr(&buf, patch.new_name);
> +
> +			free(current_filename);
> +			if (patch.is_delete > 0)
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
> +		} else if (state == MBOX_IN_HEADER) {
> +			if (!line[0]) {
> +				state = MBOX_IN_COMMIT_MESSAGE;
> +				/* Look for an in-body From: */
> +				if (size > 5 && skip_prefix(line + 1, "From: ", &p)) {

The "size > 5" seems a bit unnecessary as we're using skip_prefix()

> +					size -= p - line;
> +					line += p - line;

This is good, we're accounting for reading the next line.

> +					len = find_eol(line, size);
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
> +						len = find_eol(line, size);
> +						strbuf_addstr(&long_subject, line);

Looks good

> +					}
> +					subject = long_subject.buf;
> +				}
> +			}
> +		} else if (state == MBOX_IN_COMMIT_MESSAGE) {
> +			if (!*line)

Not a big issue elsewhere you've used "!line[0]"
Style: there should be braces on this branch.

> +				strbuf_addch(&buf, '\n');
> +			else if (strcmp(line, "---")) {
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
> +			case '\0':
> +				continue; /* ignore empty lines after diff */
> +			case '+':
> +			case '-':
> +			case ' ':
> +				if (!old_count && !new_count)
> +					break;

This shouldn't happen in a well formed diff. Below we happily accept bad 
counts, is there a reason to reject them here?

> +				if (old_count && line[0] != '+')
> +					old_count--;
> +				if (new_count && line[0] != '-')
> +					new_count--;

The diff is malformed if old_count == 0 and we see '-' or ' ' or 
new_count == 0 and we see '+' or ' '. The code is careful not to 
decrement the count in that case so I think it is harmless to accept 
diffs with bad line counts in the hunk header.

> +				/* fallthrough */
> +			case '\\':
> +				strbuf_addstr(&buf, line);
> +				strbuf_addch(&buf, '\n');
> +				util->diffsize++;

I think this might be a better place to break if old_count and new_count 
are both zero.

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
> +			}

This is effectively the `default:` clause as it is executed when we 
don't handle the line above. We ignore the contents of this line which 
makes me wonder what happens if it is the start of another diff. Do we 
have tests that alter more than one file in a single commit?

I think this is a useful addition, it could perhaps benefit from more 
tests though. Having tests for bad input, "\r\n" line endings and 
getting the author from a From: header as well as an in-body From: line 
would give a bit more reassurance about how robust the parser is.

Best Wishes

Phillip

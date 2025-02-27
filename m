Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E298270024
	for <git@vger.kernel.org>; Thu, 27 Feb 2025 09:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740648930; cv=none; b=e5mZ8KIsyYrIg+KBgF7nAH0BTzzk5zx+/0shJxcsuvmpGQo5ZrojQ3w4T+jJQ3S3YOfs4GiDjFR17HJGIclg+p00h34RufgyWtew5chjP+TUryVMV8llzNdMPkU4CygvaH+JP66tn4lwjAjiFAIgSg+T8ebHmKLS89vyInEfEW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740648930; c=relaxed/simple;
	bh=hrhAnqwMbWLiOomm1mJ74tEDYbzKD6NDpeEvihTj708=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OXMrOI53WgxMlUKKNTMeO0TBOfKFGxlcTSJsRLRF7GICWPPtakNTLmEeif95/y0YpGXwoSc7yIk9yusc9LRnznfI39IR8mWkYLdIE7lqGovrrkOlBFT4gu+EMBBnKz/rJoOL8tD3ZRxyIX5vtODjL4qa9rHXhObiK51oejNNJEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HWtjDzwI; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HWtjDzwI"
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-86714f41f5bso314391241.3
        for <git@vger.kernel.org>; Thu, 27 Feb 2025 01:35:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740648927; x=1741253727; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=QBkw3kDBiu+1ZFiiAAFORSURJvf2+QvWrG5p/CvUX0c=;
        b=HWtjDzwIJdoRxvLu95A3IQDpfW6FIcyZebneGpHgI/GUMTyOHVXHNjw+KwwZbJ7Auq
         5aJh+hzSfLlYYin7woPfIPN0TH++/9LjASTNSb5U/IS5Pn3uosdBFGr1Q/hHpbbuDWVl
         UmJ0RtR66WZ0xNGzwfpt1/Av2VXjYIbzfiOroz4TLmUKylwcd09cPw/11m+o7icUQLxK
         9U1OIpp9zY+3RUC+KTKdrZMPnAcXXS9KkZR62KMPLNg3jmzzrBnDo0deCdTRNfr45/Gy
         LMVStD4DXd7g5SpbjUkBS5KoK0eNurHryNx0H2aey79MQGSSwY0tBqJGsb5eDDfxV88B
         L3kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740648927; x=1741253727;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QBkw3kDBiu+1ZFiiAAFORSURJvf2+QvWrG5p/CvUX0c=;
        b=YVecufc9b/7A6c27Otkk7WVqT59YWEmNGQJ9tX8Ke9AGqqVnQxcHUjoUP45+GYLaUa
         PSZZkCJZ8Qakn637lMYNQFgl5rBuNudB65aPtth5Qc4M6hRhr+MXIobO2C6iikCUe5JM
         KLNN3Urj86yWlaYtN2gBPlE94C0NCdyjTfADdP8+KBbkypIpVR/O/rcsrWbY/4mUcci8
         Elone8wTDuIGtSaAczzr3RGEOe9BCkZuHXAsb9yz35Q0V+1dk6TQNgjjiJSrmpSZHRiQ
         +gfHcJ+pTaXHqmdLaBVPdpFecJJVjCsEzY5ALQ/2p6T/9NehcRKASXmXXSgLw3k5ZG0W
         Hukg==
X-Forwarded-Encrypted: i=1; AJvYcCXvs8KUUHAe8cOf+PKqOX+H5fSGICW+9m+RlwK6J6+Jy9gLQDlP2HnkBs+TJ9uevvAskXU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvEyHaVWdy4ZtNfD7AX4pBznLf6SlDzBqDzDtQZuKK0gdWNEK/
	MEceW5Ro1HA/wtby1jAXpE9FDvUI3/jrfaYu9wfzWhax17shAi9cchre9uqfSe1GQFNAvod+wFo
	EvqqI9hi7L8prCmSGXOhUWatSD5ZDkO/6
X-Gm-Gg: ASbGncv610aE2G9XOd9TEspTH6/enfExjbmF7AFxlLjUheqg7ECylNb94BLqmyuqHso
	xT4Gx/3leNrDWF/vxmnUytBtHAXXOJHRyE7tJJ9S7fMDj8XQSj0HVM8zUDzeJ+W+ME4ID/zLzEB
	rLRzEMsh1O1p6u3M0rPOYTAKZF7leYpjOQwu7HiT8W
X-Google-Smtp-Source: AGHT+IHonlnPKOKkFf9OrFw3IT8GybYEdY15B0PWKmmJq0B2EM2R0uwOjyTgJ1aGkPdS0AHNvRpqDVD/Il43qmQAaxQ=
X-Received: by 2002:a05:6102:3f4b:b0:4bb:c24b:b64c with SMTP id
 ada2fe7eead31-4c01e2c80f4mr3167882137.16.1740648927254; Thu, 27 Feb 2025
 01:35:27 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 27 Feb 2025 01:35:26 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20250225233925.1345086-3-jltobler@gmail.com>
References: <20250212041825.2455031-1-jltobler@gmail.com> <20250225233925.1345086-1-jltobler@gmail.com>
 <20250225233925.1345086-3-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 27 Feb 2025 01:35:26 -0800
X-Gm-Features: AQ5f1JpObcsRJalbFL_d_umjCVix9STyAhzkex-7OSuwFt0yn0uNB4cygBjm6lI
Message-ID: <CAOLa=ZS6yqquxAL_vCUf0FRrMbA6OLeY1VjqMv=pnxAo_17zLA@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] builtin: introduce diff-pairs command
To: Justin Tobler <jltobler@gmail.com>, git@vger.kernel.org
Cc: ps@pks.im, phillip.wood123@gmail.com, Jeff King <peff@peff.net>
Content-Type: multipart/mixed; boundary="000000000000fcf8e1062f1c6847"

--000000000000fcf8e1062f1c6847
Content-Type: text/plain; charset="UTF-8"

Justin Tobler <jltobler@gmail.com> writes:

> Through git-diff(1), a single diff can be generated from a pair of blob
> revisions directly. Unfortunately, there is not a mechanism to compute
> batches of specific file pair diffs in a single process. Such a feature
> is particularly useful on the server-side where diffing between a large
> set of changes is not feasible all at once due to timeout concerns.
>
> To facilitate this, introduce git-diff-pairs(1) which acts as a backend
> passing its NUL-terminated raw diff format input from stdin through diff
> machinery to produce various forms of output such as patch or raw.
>
> The raw format was originally designed as an interchange format and
> represents the contents of the diff_queue_diff list making it possible
> to break the diff pipeline into separate stages. For example,
> git-diff-tree(1) can be used as a frontend to compute file pairs to
> queue and feed its raw output to git-diff-pairs(1) to compute patches.
> With this, batches of diffs can be progessively generated without having

s/progessively/progressively

> to recompute rename detection or retrieve object context. Something like
> the following:
>
> 	git diff-tree -r -z -M $old $new |
> 	git diff-pairs -p -z
>
> should generate the same output as `git diff-tree -p -M`. Furthermore,
> each line of raw diff formatted input can also be individually fed to a
> separate git-diff-pairs(1) process and still produce the same output.
>
> Based-on-patch-by: Jeff King <peff@peff.net>
> Signed-off-by: Justin Tobler <jltobler@gmail.com>

[snip]

> diff --git a/builtin/diff-pairs.c b/builtin/diff-pairs.c
> new file mode 100644
> index 0000000000..9472b10461
> --- /dev/null
> +++ b/builtin/diff-pairs.c
> @@ -0,0 +1,193 @@
> +#include "builtin.h"
> +#include "commit.h"
> +#include "config.h"
> +#include "diff.h"
> +#include "diffcore.h"
> +#include "gettext.h"
> +#include "hex.h"
> +#include "object.h"
> +#include "parse-options.h"
> +#include "revision.h"
> +#include "strbuf.h"
> +

Nit: I could also compile without some of these headers, do we still
need them all?

    diff --git a/builtin/diff-pairs.c b/builtin/diff-pairs.c
    index 86e59a7e3a..1aea2ee726 100644
    --- a/builtin/diff-pairs.c
    +++ b/builtin/diff-pairs.c
    @@ -1,14 +1,9 @@
     #include "builtin.h"
    -#include "commit.h"
     #include "config.h"
    -#include "diff.h"
     #include "diffcore.h"
    -#include "gettext.h"
     #include "hex.h"
    -#include "object.h"
     #include "parse-options.h"
     #include "revision.h"
    -#include "strbuf.h"

     static unsigned parse_mode_or_die(const char *mode, const char **endp)
     {

> +static unsigned parse_mode_or_die(const char *mode, const char **endp)
> +{
> +	uint16_t ret;
> +
> +	*endp = parse_mode(mode, &ret);
> +	if (!*endp)
> +		die(_("unable to parse mode: %s"), mode);
> +	return ret;
> +}
> +
> +static void parse_oid_or_die(const char *p, struct object_id *oid,
> +			     const char **endp, const struct git_hash_algo *algop)
>

Nit: without double checking, I couldn't tell what 'p' was, can we
rename the variables here to be consistent with `parse_oid_hex_algop()`?

> +{
> +	if (parse_oid_hex_algop(p, oid, endp, algop) || *(*endp)++ != ' ')
> +		die(_("unable to parse object id: %s"), p);
> +}
> +
> +static void flush_diff_queue(struct diff_options *options)
> +{
> +	/*
> +	 * If rename detection is not requested, use rename information from the
> +	 * raw diff formatted input. Setting found_follow ensures diffcore_std()
> +	 * does not mess with rename information already present in queued
> +	 * filepairs.
> +	 */
> +	if (!options->detect_rename)
> +		options->found_follow = 1;
> +	diffcore_std(options);
> +	diff_flush(options);
> +}
> +
> +int cmd_diff_pairs(int argc, const char **argv, const char *prefix,
> +		   struct repository *repo)
> +{
> +	struct strbuf path_dst = STRBUF_INIT;
> +	struct strbuf path = STRBUF_INIT;
> +	struct strbuf meta = STRBUF_INIT;
> +	struct rev_info revs;
> +	int ret;
> +
> +	const char * const usage[] = {
> +		N_("git diff-pairs -z [<diff-options>]"),
> +		NULL
> +	};
> +	struct option options[] = {
> +		OPT_END()
> +	};
> +	struct option *parseopts = add_diff_options(options, &revs.diffopt);
> +
> +	show_usage_with_options_if_asked(argc, argv, usage, parseopts);
> +
> +	repo_init_revisions(repo, &revs, prefix);
> +	repo_config(repo, git_diff_basic_config, NULL);
> +	revs.disable_stdin = 1;
> +	revs.abbrev = 0;
> +	revs.diff = 1;
> +
> +	if (setup_revisions(argc, argv, &revs, NULL) > 1)
> +		usage_with_options(usage, parseopts);
> +
> +	/*
> +	 * With the -z option, both command input and raw output are
> +	 * NUL-delimited (this mode does not effect patch output). At present
> +	 * only NUL-delimited raw diff formatted input is supported.
> +	 */
> +	if (revs.diffopt.line_termination) {
> +		error(_("working without -z is not supported"));
> +		usage_with_options(usage, parseopts);
> +	}
> +
> +	if (revs.prune_data.nr) {
> +		error(_("pathspec arguments not supported"));
> +		usage_with_options(usage, parseopts);
> +	}
> +
> +	if (revs.pending.nr || revs.max_count != -1 ||
> +	    revs.min_age != (timestamp_t)-1 ||
> +	    revs.max_age != (timestamp_t)-1) {
> +		error(_("revision arguments not allowed"));
> +		usage_with_options(usage, parseopts);
> +	}
> +
> +	if (!revs.diffopt.output_format)
> +		revs.diffopt.output_format = DIFF_FORMAT_PATCH;
> +
> +	while (1) {
> +		struct object_id oid_a, oid_b;
> +		struct diff_filepair *pair;
> +		unsigned mode_a, mode_b;
> +		const char *p;
> +		char status;
> +
> +		if (strbuf_getline_nul(&meta, stdin) == EOF)
> +			break;
> +
> +		p = meta.buf;
> +		if (*p != ':')
> +			die(_("invalid raw diff input"));
> +		p++;
> +
> +		mode_a = parse_mode_or_die(p, &p);
> +		mode_b = parse_mode_or_die(p, &p);
> +
> +		if (S_ISDIR(mode_a) || S_ISDIR(mode_b))
> +			die(_("tree objects not supported"));
> +
> +		parse_oid_or_die(p, &oid_a, &p, repo->hash_algo);
> +		parse_oid_or_die(p, &oid_b, &p, repo->hash_algo);
> +
> +		status = *p++;
> +
> +		if (strbuf_getline_nul(&path, stdin) == EOF)
> +			die(_("got EOF while reading path"));
> +
> +		switch (status) {
> +		case DIFF_STATUS_ADDED:
> +			pair = diff_queue_addremove(&diff_queued_diff,
> +						    &revs.diffopt, '+', mode_b,
> +						    &oid_b, 1, path.buf, 0);
> +			if (pair)
> +				pair->status = status;
> +			break;
> +
> +		case DIFF_STATUS_DELETED:
> +			pair = diff_queue_addremove(&diff_queued_diff,
> +						    &revs.diffopt, '-', mode_a,
> +						    &oid_a, 1, path.buf, 0);
> +			if (pair)
> +				pair->status = status;
> +			break;
> +
> +		case DIFF_STATUS_TYPE_CHANGED:
> +		case DIFF_STATUS_MODIFIED:
> +			pair = diff_queue_change(&diff_queued_diff, &revs.diffopt,
> +						 mode_a, mode_b, &oid_a, &oid_b,
> +						 1, 1, path.buf, 0, 0);
> +			if (pair)
> +				pair->status = status;
> +			break;
> +
> +		case DIFF_STATUS_RENAMED:
> +		case DIFF_STATUS_COPIED:
> +			{

style: The general rule followed is to open the braces in the same line
as the case statement. So `case DIFF_STATUS_COPIED: {`

> +				struct diff_filespec *a, *b;
> +				unsigned int score;
> +
> +				if (strbuf_getline_nul(&path_dst, stdin) == EOF)
> +					die(_("got EOF while reading destination path"));
> +
> +				a = alloc_filespec(path.buf);
> +				b = alloc_filespec(path_dst.buf);
> +				fill_filespec(a, &oid_a, 1, mode_a);
> +				fill_filespec(b, &oid_b, 1, mode_b);
> +
> +				pair = diff_queue(&diff_queued_diff, a, b);
> +
> +				if (strtoul_ui(p, 10, &score))
> +					die(_("unable to parse rename/copy score: %s"), p);
> +
> +				pair->score = score * MAX_SCORE / 100;
> +				pair->status = status;
> +				pair->renamed_pair = 1;
> +			}
> +			break;
> +
> +		default:
> +			die(_("unknown diff status: %c"), status);
> +		}
> +	}
> +
> +	flush_diff_queue(&revs.diffopt);
> +	ret = diff_result_code(&revs);
> +
> +	strbuf_release(&path_dst);
> +	strbuf_release(&path);
> +	strbuf_release(&meta);
> +	release_revisions(&revs);
> +	FREE_AND_NULL(parseopts);
> +
> +	return ret;
> +}

[snip]

--000000000000fcf8e1062f1c6847
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 1000dca58c809895_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1mQU1kb1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mN29FQy80d2YrM1c1a2wydm5Yd1pmRTBEdVp1dTFoWgpmVkRCanJwaldQ
QTRMcmJGeU83MW84K3FmV2VaanFPS3hnUkdPTE9VVGxUb1Bja1RnbHM3NEVNdE84MzJIaVdVCklZ
ejhJY0EycGxmQmRXdmVHUXp3VXpQUVZ5S29VL0NuWFQrN3gwMmdQMW9DL1ByUzB0amRCK1kxNWRS
R3lqZEwKRnR5N3RDcVErTVg2NUJSOWk5Q1hwUHFucnQzM0ZkY1BwdHJjcURPL29scHR2QzNZWTlE
cUQ4OXZyRDRBYXBrdwpWVWFkRTVONC93d21maFpXSzVUMldpNi85NXlMSTk2ZDRMbllGbVdJajcz
dGdZcktRTHhTRVFxQWpOZE4rYzZ1ClJsRG1iZnFEQXRaRVJYY3VQTkVJbFJPdXpTbkhCR1M0d3Vp
MVBsdXdtZzRwanZJRlBNV3FFbHZxcVRwUys0RjUKbHZidG9sRDRNOFZpR2JYQjQ0OUs3UzdGNEFs
bzUxQXpzZUVUcENDRmlPVGJaS0cvZmhCY3dmMGt3SDVRbm5SKwpXUkM2bVZnK3JqZ29VOEhlVTl0
WWloc0VXWTV3NVVXeUVEY0tnb0RtdldVUFMzRTM1Qzlia2FJOXFORXdrd0pZCmxyYlZKd3JKSjFL
YzVLVjJwRXZtZ2F3K3V2SUZlZkNmZ3grRzUxbz0KPUZnVkgKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000fcf8e1062f1c6847--

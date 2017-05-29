Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F1262027C
	for <e@80x24.org>; Mon, 29 May 2017 07:16:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750854AbdE2HQu (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 May 2017 03:16:50 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:34618 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750825AbdE2HQt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 May 2017 03:16:49 -0400
Received: by mail-pg0-f65.google.com with SMTP id u187so5613976pgb.1
        for <git@vger.kernel.org>; Mon, 29 May 2017 00:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=eMDXcu3ppD99XqF5CR8+DMplsCC2vuuptRae0FcQrPM=;
        b=dc/B1IVuRnF1cfPDXYTOGVBatHKRjNBXLVz+fA7aEJS9Ad9vzPnjvFlxlI835NCvdN
         u1HtSV9K+oRoeVHRQrWcqnw+5R0Kez2gkIXToAw609mcogEFH7aQDL2iavZNQMbfBDmF
         4XRwYiYSfKnuh1RNj/LivnzllsqaCva3vAaafbBretRoxGyJTuK5rOUetUlt4czP16AP
         Uj6g/uvkUlox3vrbGcGNzviQQqiAUeowSEux+pxUCtDcM95UVAGjP6osKE5Sze69TXOZ
         4AYbjoJacegYehRcAYviTF94ZkCgXoinHAokAmJkzXBeNf4n6CULEiMWG445ndrs+YHS
         vOxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=eMDXcu3ppD99XqF5CR8+DMplsCC2vuuptRae0FcQrPM=;
        b=AZ5FIa0cujCeHlYiQLdjdwBd4ekrE2cPZ5AMLI6S3q74pY47xLA/0TeWgwrBa6+aCh
         lEMKeDOdJbiqzqkG6tChI1sMVuCfBhDdH1/xOwuLuCy/pooiJ01O9gno0LVtSwsNM7pu
         WLmVj/yKilbj9zguQuM7Ts7O9YzlmKxw+aqDSGsBRVfacsW1olFou3i9N8LdjUHNGamQ
         qfnX+GXxbrpcDek61oM5Ygi45ZIcNwGLFK+/72QGnuTgIqAeP9+Ig+Ye//0LYG5PaFUf
         B0HW2qM9s1RnFdlWVllDGWldbHEh3puy6j3ccymaT89BrciJilzuS9XsxGdrJc8OKTfE
         wBYA==
X-Gm-Message-State: AODbwcAT0FnCEKLWP5Um1C4441H5R+32Llz+I+RQjjH4soUTmZ3+c+ME
        wh+LP0DWCoDvtA==
X-Received: by 10.99.111.133 with SMTP id k127mr17109277pgc.202.1496042208816;
        Mon, 29 May 2017 00:16:48 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:393e:d787:9be9:17cc])
        by smtp.gmail.com with ESMTPSA id y78sm14928443pfd.32.2017.05.29.00.16.47
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 29 May 2017 00:16:47 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Joel Teichroeb <joel@teichroeb.net>
Cc:     git@vger.kernel.org, t.gummerer@gmail.com, peff@peff.net,
        Johannes.Schindelin@gmx.de
Subject: Re: [PATCH v3 4/4] stash: implement builtin stash
References: <20170528165642.14699-1-joel@teichroeb.net>
        <20170528165642.14699-5-joel@teichroeb.net>
Date:   Mon, 29 May 2017 16:16:47 +0900
In-Reply-To: <20170528165642.14699-5-joel@teichroeb.net> (Joel Teichroeb's
        message of "Sun, 28 May 2017 09:56:42 -0700")
Message-ID: <xmqqinkk6skg.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Joel Teichroeb <joel@teichroeb.net> writes:

> +int untracked_files(struct strbuf *out, int include_untracked,
> +		const char **argv)

Does this need to be public?  

For a caller that wants to learn if there is _any_ untracked file,
having a strbuf that holds all output is overkill.  For a caller
that wants to learn what are the untracked paths, having a strbuf
that it needs to parse is not all that helpful.  Only for a caller
that does an unusual thing, namely, just grab the output and throw
it at another command as input, without checking what the output was
itself at all, would benefit.

So the interface to this function doesn't look like a very good one
if this wants to be a public helper.  Perhaps mark it as "static"?

> +{
> +	struct child_process cp = CHILD_PROCESS_INIT;
> +	cp.git_cmd = 1;
> +	argv_array_push(&cp.args, "ls-files");
> +	argv_array_push(&cp.args, "-o");
> +	argv_array_push(&cp.args, "-z");
> +	if (include_untracked != 2)
> +		argv_array_push(&cp.args, "--exclude-standard");

This magic number "2" will be hard to grok by future readers.

> +	argv_array_push(&cp.args, "--");
> +	if (argv)
> +		argv_array_pushv(&cp.args, argv);
> +	return pipe_command(&cp, NULL, 0, out, 0, NULL, 0);
> +}
> +
> +static int check_no_changes(const char *prefix, int include_untracked,
> +		const char **argv)
> +{
> +	struct argv_array args1;
> +	struct argv_array args2;
> +	struct strbuf out = STRBUF_INIT;
> +
> +	argv_array_init(&args1);
> +	argv_array_push(&args1, "diff-index");
> +	argv_array_push(&args1, "--quiet");
> +	argv_array_push(&args1, "--cached");
> +	argv_array_push(&args1, "HEAD");
> +	argv_array_push(&args1, "--ignore-submodules");
> +	argv_array_push(&args1, "--");
> +	if (argv)
> +		argv_array_pushv(&args1, argv);
> +	argv_array_init(&args2);
> +	argv_array_push(&args2, "diff-files");
> +	argv_array_push(&args2, "--quiet");
> +	argv_array_push(&args2, "--ignore-submodules");
> +	argv_array_push(&args2, "--");
> +	if (argv)
> +		argv_array_pushv(&args2, argv);

> +	if (include_untracked)
> +		untracked_files(&out, include_untracked, argv);
> +	return cmd_diff_index(args1.argc, args1.argv, prefix) == 0 &&
> +			cmd_diff_files(args2.argc, args2.argv, prefix) == 0 &&
> +			(!include_untracked || out.len == 0);
> +}

Possible leak of out.buf here.

> +
> +static int get_stash_info(struct stash_info *info, const char *commit)
> +{

Judging from the callers of get_stash_info(), nobody passes a
"commit" as parameter; as far as they are concerned, they are
dealing with the name of one item in the stash (stash-id?).  They do
not care the fact that the item happens to be implemented as a
commit object.

Perhaps rename "commit" (parameter) to "stash_id" or something.

> +	struct strbuf w_commit_rev = STRBUF_INIT;
> +	struct strbuf b_commit_rev = STRBUF_INIT;
> +	struct strbuf i_commit_rev = STRBUF_INIT;
> +	struct strbuf u_commit_rev = STRBUF_INIT;
> +	struct strbuf w_tree_rev = STRBUF_INIT;
> +	struct strbuf b_tree_rev = STRBUF_INIT;
> +	struct strbuf i_tree_rev = STRBUF_INIT;
> +	struct strbuf u_tree_rev = STRBUF_INIT;
> +	struct strbuf commit_buf = STRBUF_INIT;
> +	struct strbuf symbolic = STRBUF_INIT;
> +	struct strbuf out = STRBUF_INIT;
> +	struct object_context unused;
> +	char *str;
> +	int ret;
> +	const char *REV = commit;

Variables and field names that are all caps become misleading.
Avoid them.

> +	struct child_process cp = CHILD_PROCESS_INIT;
> +	info->is_stash_ref = 0;
> +
> +	if (commit == NULL) {
> +		strbuf_addf(&commit_buf, "%s@{0}", ref_stash);
> +		REV = commit_buf.buf;
> +	} else if (strlen(commit) < 3) {
> +		strbuf_addf(&commit_buf, "%s@{%s}", ref_stash, commit);
> +		REV = commit_buf.buf;
> +	}
> +	info->REV = REV;
> +
> +	strbuf_addf(&w_commit_rev, "%s", REV);
> +	strbuf_addf(&b_commit_rev, "%s^1", REV);
> +	strbuf_addf(&i_commit_rev, "%s^2", REV);
> +	strbuf_addf(&u_commit_rev, "%s^3", REV);
> +	strbuf_addf(&w_tree_rev, "%s:", REV);
> +	strbuf_addf(&b_tree_rev, "%s^1:", REV);
> +	strbuf_addf(&i_tree_rev, "%s^2:", REV);
> +	strbuf_addf(&u_tree_rev, "%s^3:", REV);
> +
> +
> +	ret = (
> +		get_sha1_with_context(w_commit_rev.buf, 0, info->w_commit.hash, &unused) == 0 &&
> +		get_sha1_with_context(b_commit_rev.buf, 0, info->b_commit.hash, &unused) == 0 &&
> +		get_sha1_with_context(i_commit_rev.buf, 0, info->i_commit.hash, &unused) == 0 &&
> +		get_sha1_with_context(w_tree_rev.buf, 0, info->w_tree.hash, &unused) == 0 &&
> +		get_sha1_with_context(b_tree_rev.buf, 0, info->b_tree.hash, &unused) == 0 &&
> +		get_sha1_with_context(i_tree_rev.buf, 0, info->i_tree.hash, &unused) == 0);

Hmph.  What's the reason to use get_sha1_with_context() if you
declare the context is unused?  Wouldn't plain-vanilla get_sha1()
work better?

Having to take both commit and tree of these sounds somewhat
cumbersome.  Do we have to know all of them and do we use all of
them (not a complaint, just asking because I find it somewhat
surprising)?

> +
> +	if (!ret) {
> +		fprintf_ln(stderr, _("%s is not a valid reference"), REV);
> +		return 1;
> +	}
> +
> +
> +	info->has_u = get_sha1_with_context(u_commit_rev.buf, 0, info->u_commit.hash, &unused) == 0 &&
> +		get_sha1_with_context(u_tree_rev.buf, 0, info->u_tree.hash, &unused) == 0;

Ditto.

> +static int create_stash(int argc, const char **argv, const char *prefix)
> +{
> +	int include_untracked = 0;
> +	const char *message = NULL;
> +	struct stash_info info;
> +	struct option options[] = {
> +		OPT_BOOL('u', "include-untracked", &include_untracked,
> +			 N_("stash untracked filed")),
> +		OPT_STRING('m', "message", &message, N_("message"),
> +			 N_("stash commit message")),
> +		OPT_END()
> +	};

OPT_BOOL(), unlike its now deprecated and removed predecessor OPT_BOOLEAN(),
does not count up, so the value of include_untracked is lmited to
either 0 or 1.  So this is not the source of mysterious magic number
"2" I noticed above.

I'll stop here for now.  

Thanks for working on this.


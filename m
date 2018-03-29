Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DE6B11F404
	for <e@80x24.org>; Thu, 29 Mar 2018 20:07:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751183AbeC2UHp (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Mar 2018 16:07:45 -0400
Received: from mail-wr0-f177.google.com ([209.85.128.177]:39034 "EHLO
        mail-wr0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751082AbeC2UHo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Mar 2018 16:07:44 -0400
Received: by mail-wr0-f177.google.com with SMTP id c24so6428342wrc.6
        for <git@vger.kernel.org>; Thu, 29 Mar 2018 13:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=0zEImHGQtMj6x7NkgpnTI0/c69GJpQMcOaVLed4qmeQ=;
        b=l+TpFJgm6Ja+Jq9exNn/0enXLlm5/+jg560n48wWBCFPKfN/ajvSDaVm24675KDULE
         YBnrTWI56dIwU0Xhn+0femYVLuWPzuWT/BY+e3S6dWvA0LRS0VwWt35Doqh2ID/z4fVL
         0ZQMfoNtTpArRGfILTaw03zwFRlHvs04p0M9aIYYiH1MyEkegiuy/EpH0trJPf9RnPKp
         zIrOu3LzDxXbZnymGPcr2sWG2qzkQY2evtjjT/GQL1jSmmr9RKDsgbO/KaOkY0m6gSej
         Tb7Zm8D6+1I+IUIu9jAFjbCFQIb3ASTeG8vv9BjWx5bm9LtUTh74+xnRPpRhRthSSLns
         V5mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=0zEImHGQtMj6x7NkgpnTI0/c69GJpQMcOaVLed4qmeQ=;
        b=X0xXnQdDCF5MYr2N1tDSqfKLW1MFoZ9UqBblBMu20EV43Nw0Rp6kjm2AHh+w78A0nv
         ZSeOQ9Nnv/NLu9uCFwn7gRh1hh0Nxz2DUNqxPwx62HZHlf+8Ho4Kob8ZjFKCcx7ExNvh
         SfUTHEvif8OY+3qH6j71lZ+rEh2WusKoTOkHoXyZMTMCWo63NH/pvoNn3umrxspIm5NP
         sHJenO3i0KxM4EdnoolbCtOWviYNOkw2Al7PD7D0jMWg7uEMjuiiCouszWMrTH4GM6AZ
         ygefp4Nnz+dbsKauJQrUimcEWDS09e2MqQcpRWZRu9WN63AHKbgUXkWfNUaDS/aJ+4Sx
         43XQ==
X-Gm-Message-State: AElRT7H6+iHoCkk1UmKiVrkK2ho6iKnndOoF/jHgvOCwdX5cQrVh/bJS
        1EzdLM+gnOAu4AjEbPcVlA5JBhwG
X-Google-Smtp-Source: AIpwx4/22lvs4iNPLBMdKv6P5rMqHiKi6Rlc+gRM+aBgukNNhTwKPvVxKzRp7sfC9rEZpQAEeFYXKA==
X-Received: by 10.223.163.25 with SMTP id c25mr7885097wrb.58.1522354062970;
        Thu, 29 Mar 2018 13:07:42 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id u3sm8933220wrf.3.2018.03.29.13.07.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 29 Mar 2018 13:07:41 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Joel Teichroeb <joel@teichroeb.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v4 2/5] stash: convert apply to builtin
References: <20180328222129.22192-1-joel@teichroeb.net>
        <20180328222129.22192-3-joel@teichroeb.net>
Date:   Thu, 29 Mar 2018 13:07:41 -0700
In-Reply-To: <20180328222129.22192-3-joel@teichroeb.net> (Joel Teichroeb's
        message of "Wed, 28 Mar 2018 15:21:26 -0700")
Message-ID: <xmqqlgea63xu.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Joel Teichroeb <joel@teichroeb.net> writes:

> +static int get_stash_info(struct stash_info *info, int argc, const char **argv)
> +{

So, this roughly corresponds to parse_flags_and_rev function, it seems.

> +	struct strbuf w_commit_rev = STRBUF_INIT;
> +	struct strbuf b_commit_rev = STRBUF_INIT;
> +	struct strbuf w_tree_rev = STRBUF_INIT;
> +	struct strbuf b_tree_rev = STRBUF_INIT;
> +	struct strbuf i_tree_rev = STRBUF_INIT;
> +	struct strbuf u_tree_rev = STRBUF_INIT;
> +	struct strbuf symbolic = STRBUF_INIT;
> +	struct strbuf out = STRBUF_INIT;
> +	int ret;
> +	const char *revision;
> +	const char *commit = NULL;
> +	char *end_of_rev;
> +	info->is_stash_ref = 0;
> +
> +	if (argc > 1) {
> +		int i;
> +		struct strbuf refs_msg = STRBUF_INIT;
> +		for (i = 0; i < argc; ++i)
> +			strbuf_addf(&refs_msg, " '%s'", argv[i]);
> +
> +		fprintf_ln(stderr, _("Too many revisions specified:%s"), refs_msg.buf);
> +		strbuf_release(&refs_msg);
> +
> +		return -1;
> +	}
> +
> +	if (argc == 1)
> +		commit = argv[0];
> +
> +	strbuf_init(&info->revision, 0);
> +	if (commit == NULL) {
> +		if (have_stash()) {
> +			free_stash_info(info);
> +			return error(_("No stash entries found."));
> +		}
> +
> +		strbuf_addf(&info->revision, "%s@{0}", ref_stash);
> +	} else if (strspn(commit, "0123456789") == strlen(commit)) {
> +		strbuf_addf(&info->revision, "%s@{%s}", ref_stash, commit);
> +	} else {
> +		strbuf_addstr(&info->revision, commit);
> +	}
> +
> +	revision = info->revision.buf;
> +	strbuf_addstr(&w_commit_rev, revision);
> +	ret = !get_oid(w_commit_rev.buf, &info->w_commit);
> +	strbuf_release(&w_commit_rev);

Use of strbuf w_commit_rev looks completely pointless here.  Am I
mistaken to say that the above three lines are equivalent to:

	ret = !get_oid(revision, &info->w_commit);

> +
> +	if (!ret) {
> +		error(_("%s is not a valid reference"), revision);
> +		free_stash_info(info);
> +		return -1;
> +	}
> +
> +	strbuf_addf(&b_commit_rev, "%s^1", revision);
> +	strbuf_addf(&w_tree_rev, "%s:", revision);
> +	strbuf_addf(&b_tree_rev, "%s^1:", revision);
> +	strbuf_addf(&i_tree_rev, "%s^2:", revision);
> +
> +	ret = !get_oid(b_commit_rev.buf, &info->b_commit) &&
> +		!get_oid(w_tree_rev.buf, &info->w_tree) &&
> +		!get_oid(b_tree_rev.buf, &info->b_tree) &&
> +		!get_oid(i_tree_rev.buf, &info->i_tree);
> +
> +	strbuf_release(&b_commit_rev);
> +	strbuf_release(&w_tree_rev);
> +	strbuf_release(&b_tree_rev);
> +	strbuf_release(&i_tree_rev);

For the same reason, these strbuf's look pretty much pointless.  I
wonder if a private helper

	static int grab_oid(struct oid *oid, const char *fmt, const char *rev)
	{
		struct strbuf buf = STRBUF_INIT;
		int ret;

		strbuf_addf(&buf, fmt, rev);
		ret = get_oid(buf, oid);
		strbuf_release(&buf);
		return ret;
	}

would help here?  Then you wouldn't be writing something like the
above, and instead you'd grab four object names like so:

	if (grab_oid(&info->b_commit, "%s^1", revision) ||
	    grab_oid(&info->w_tree, "%s:", revision) ||
	    grab_oid(&info->b_tree, "%s&1:", revision) ||
	    grab_oid(&info->i_tree, "%s&2:", revision)) {
		... we found an error ...
		return -1;
	}
                
which would be a lot easier to follow, no?

> +int cmd_stash__helper(int argc, const char **argv, const char *prefix)
> +{
> +	int result = 0;
> +	pid_t pid = getpid();
> +	const char *index_file;
> +
> +	struct option options[] = {
> +		OPT_END()
> +	};
> +
> +	git_config(git_default_config, NULL);
> +
> +	argc = parse_options(argc, argv, prefix, options, git_stash_helper_usage,
> +		PARSE_OPT_KEEP_UNKNOWN|PARSE_OPT_KEEP_DASHDASH);
> +
> +	index_file = get_index_file();
> +	xsnprintf(stash_index_path, PATH_MAX, "%s.stash.%"PRIuMAX, index_file, (uintmax_t)pid);

Wouldn't it make more sense to get rid of PATH_MAX and hold it in a
strbuf instead?  I.e.

    static struct strbuf stash_index_path = STRBUF_INIT;
    ...
    strbuf_addf(&stash_index_path, "%s.stash.%" PRIuMAX, index_file, (uintmax_t)pid);

> +	cd "$START_DIR"
> +	git stash--helper apply "$@"
> +	res=$?
> +	cd_to_toplevel
> +	return $res
>  }

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 868FF1F6AC
	for <e@80x24.org>; Tue,  3 Jul 2018 21:42:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753387AbeGCVmg (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Jul 2018 17:42:36 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:45358 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753076AbeGCVmf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Jul 2018 17:42:35 -0400
Received: by mail-wr0-f196.google.com with SMTP id u7-v6so3310021wrn.12
        for <git@vger.kernel.org>; Tue, 03 Jul 2018 14:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=B+wWm6G8NRSKwwcKW8TCxBPr/YMB9nP0JauotkawCn0=;
        b=bQShEriSgpCf675a13rHftmMbf5su633sq2Slo2oe3ZlzkEaiZ9GVej8RVOxsbTn3l
         K0V3h0NELCfsoZlV7yf6xr1H/VGZuBiUB5GUXescBfnAthHM3LkJeslkt3f8P1WQpM3b
         J7Vl9sD22SQKyVdV4IOZWFkjlk1Eqzx43boSGHyjR+NcSmAiBQE9Krc83DCTLg+jxEDR
         /kkkSBNNb6MrFGo88i7AwGfYhMpKgQ3zdv1RmYQbKL7BzSiW+CA6vsjFGmlLydafoN8G
         A7Kn6HEeJtl/pDtwaIJXsG1XehJrJE079osTkuHRd2L0deGrkcDn/m1BybPRdSLDnmTm
         fHPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=B+wWm6G8NRSKwwcKW8TCxBPr/YMB9nP0JauotkawCn0=;
        b=ZYVHeooMTYB71VRVRTju7BNVAxuEvp8E1GitQUJ/X9G8E7/yy5ryfZVwkMaOeYGyoD
         aT7nMB3GVCRztN7X3qON7SFmfLTS8/6nDprSfK4/fu9yKcM5urreQ1GRUc7vM3gyqhCR
         oMqPfEKInuM3pS9ofoj4hPVxYqg7SirusKjdXhPgwWORkCWzQ+0hHFQytCPW3wX+hrEM
         sc6z73lKyYTjfk7lzmYiABKqIJiL6vn4vFzZmqUFcF8ki19q3JjI4I/93P4F4FzjJ+aB
         +QSsQFLXxlAUA8FRgcOKbkNbixu0kaTSlFt1vQz6gUSde40j7gNNynZ03D5zJmaC4MEV
         sO0g==
X-Gm-Message-State: APt69E2X5Xu4OyfWdx6JPrcm8DpzzFFUgk6HsbuIY45DGymyePuVb2dc
        JmDRcsd7Sdf9DVTKqMSOOtA=
X-Google-Smtp-Source: AAOMgpcWzkm2RhoeefS02XQZEMC4BxoEh6AHhKY/zW4DFXTjoVFppe4Z9g+hrN0SnpBYaL9I0BA6NQ==
X-Received: by 2002:adf:ff88:: with SMTP id j8-v6mr24820628wrr.137.1530654154109;
        Tue, 03 Jul 2018 14:42:34 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id u7-v6sm4607484wmd.3.2018.07.03.14.42.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Jul 2018 14:42:33 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Pratik Karki <predatoramigo@gmail.com>
Cc:     git@vger.kernel.org, christian.couder@gmail.com,
        Johannes.Schindelin@gmx.de, sbeller@google.com,
        alban.gruin@gmail.com
Subject: Re: [PATCH v2 4/4] builtin/rebase: support running "git rebase <upstream>"
References: <20180628074655.5756-1-predatoramigo@gmail.com>
        <20180702091509.15950-1-predatoramigo@gmail.com>
        <20180702091509.15950-5-predatoramigo@gmail.com>
Date:   Tue, 03 Jul 2018 14:42:33 -0700
In-Reply-To: <20180702091509.15950-5-predatoramigo@gmail.com> (Pratik Karki's
        message of "Mon, 2 Jul 2018 15:00:09 +0545")
Message-ID: <xmqqfu10nghi.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Pratik Karki <predatoramigo@gmail.com> writes:

> +static struct commit *peel_committish(const char *name)
> +{
> +	struct object *obj;
> +	struct object_id oid;

It by itself is not a big enough deal to warrant a reroll, but
please make it a habit to leave a blank line between the
declarations and the first statement (i.e. here), to help readers.

> +	if (get_oid(name, &oid))
> +		return NULL;
> +	obj = parse_object(&oid);
> +	return (struct commit *)peel_to_type(name, 0, obj, OBJ_COMMIT);
> +}
> +

> +{
> +	const char *argv[] = { NULL, NULL };
> +	struct strbuf script_snippet = STRBUF_INIT;
> +	struct argv_array env = ARGV_ARRAY_INIT;
> +	int status;
> +	const char *backend, *backend_func;
> +
> +	argv_array_pushf(&env, "upstream_name=%s", opts->upstream_name);
> +	argv_array_pushf(&env, "GIT_DIR=%s", absolute_path(get_git_dir()));
> +	argv_array_pushf(&env, "upstream=%s",
> +				oid_to_hex(&opts->upstream->object.oid));
> +	argv_array_pushf(&env, "orig_head=%s", oid_to_hex(&opts->orig_head));
> +	argv_array_pushf(&env, "onto=%s",
> +				oid_to_hex(&opts->onto->object.oid));
> +	argv_array_pushf(&env, "onto_name=%s", opts->onto_name);
> +	argv_array_pushf(&env, "revisions=%s", opts->revisions);
> +
> +	switch (opts->type) {
> +		case REBASE_AM:
> +			backend = "git-rebase--am";
> +			backend_func = "git_rebase__am";
> +			break;
> +		case REBASE_INTERACTIVE:
> +			backend = "git-rebase--interactive";
> +			backend_func = "git_rebase__interactive";
> +			break;
> +		case REBASE_MERGE:
> +			backend = "git-rebase--merge";
> +			backend_func = "git_rebase__merge";
> +			break;
> +		case REBASE_PRESERVE_MERGES:
> +			backend = "git-rebase--preserve-merges";
> +			backend_func = "git_rebase__preserve_merges";
> +			break;
> +		default:
> +			BUG("Unhandled rebase type %d", opts->type);
> +			break;

De-dent these lines so that case/default and switch all sit on the
same column, and the body of each case arm is indented one level
deeper than the case labels.

> +	}
> +
> +	strbuf_addf(&script_snippet,
> +		    ". git-rebase--common && . %s && %s",
> +		    backend, backend_func);
> +	argv[0] = script_snippet.buf;
> +
> +	status = run_command_v_opt_cd_env(argv, RUN_USING_SHELL, NULL,
> +					  env.argv);

Hmph.  These shell variables that tell rebase backend scriptlets
what rebase frontend figured out about the request and current state
used to be just plain shell variables that are not exported.  Now
they are exported and visible even to subprocesses these scriptlets
spawn.  That does not sound safe at all, especially GIT_DIR being
among these variables (git-sh-setup sets GIT_DIR but does not export
it and that has been very much deliberate).

You should actually be able to avoid exporthing them by building
these variable assignment into script_snippet (you need to quote the
values properly, using quote.c::sq_quote_buf() etc.), I think, and
that would be a more faithful-to-the-original safe covnersion.

Thanks for a pleasant read.  This step smells more like WIP, but I
can see it is already moving in the right direction.  The previous
ones (except for the issues I noticed and sent responses separately)
looked more-or-less good, too.



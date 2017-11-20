Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ABF8F20954
	for <e@80x24.org>; Mon, 20 Nov 2017 03:35:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751050AbdKTDfN (ORCPT <rfc822;e@80x24.org>);
        Sun, 19 Nov 2017 22:35:13 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64060 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750969AbdKTDfM (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Nov 2017 22:35:12 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4E6D5B765B;
        Sun, 19 Nov 2017 22:35:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=JN2GdCVpElGwjEWLS24Zmhp/veI=; b=ozIr/K
        7g6nZQojoBAIa0n1mgfUl+fFdtD4tPuoBrtK0o6sL4Zb41MUnrzC52S7d2nwo58+
        j1IEfcJiLe3bqAheUT5gfYz1ktJqnTycigx6wPskCIoku8DX+oBf/kChBDUSR73b
        KY5l1cJ/WQl3Ys+YMbC5EjvQVdfwhVgTg1Cn0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=iHz2tfCZccNhq3DpNdqyKhM3cMipH3al
        d2re91Pvw75/Gh2Y9n1grPOkS0fXHBH0cYN/lAS7ezFn58tATN31VItAopiSySe5
        I7OQM0GCRrNo9Of7Oin1pO738WeB7WMBvlJRH7NqlUnEdX6CkFNAxL3B9xlzw6G9
        /lrDfbQhCtM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4727BB765A;
        Sun, 19 Nov 2017 22:35:12 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BF320B7658;
        Sun, 19 Nov 2017 22:35:11 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ann T Ropea <bedhanger@gmx.de>
Cc:     Philip Oakley <philipoakley@iee.org>,
        Git Mailing List <git@vger.kernel.org>,
        Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH v3 1/5] checkout: describe_detached_head: remove ellipsis after committish
References: <20171113223654.27732-1-bedhanger@gmx.de>
        <83D263E58ABD46188756D41FE311E469@PhilipOakley>
        <xmqqfu9pmsx3.fsf@gitster.mtv.corp.google.com>
        <20171113223654.27732-3-bedhanger@gmx.de>
        <xmqq1sl17e1u.fsf@gitster.mtv.corp.google.com>
        <20171119184113.16630-1-bedhanger@gmx.de>
Date:   Mon, 20 Nov 2017 12:35:10 +0900
In-Reply-To: <20171119184113.16630-1-bedhanger@gmx.de> (Ann T. Ropea's message
        of "Sun, 19 Nov 2017 19:41:09 +0100")
Message-ID: <xmqqa7zhmxld.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D068904A-CDA3-11E7-B5C4-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ann T Ropea <bedhanger@gmx.de> writes:

> We do not want an ellipsis displayed following an (abbreviated) SHA-1
> value.
>
> The days when this was necessary to indicate the truncation to
> lower-level Git commands and/or the user are bygone.
>
> However, to ease the transition, the ellipsis will still be printed if
> the user (actively!) sets the environment variable PRINT_SHA1_ELLIPSIS
> to "yes" (case does not matter).

Does "(actively!)" add any value here?  For that matter, it appears
to me that "(case does not matter)" does not, either.  I thought
you'd be also reacting to Print_SHA1_Ellipsis variable, too, but the
code does not seem to be doing so (for obvious reasons).  If the users
can get what they want by setting it to "yes", that is sufficient to
say, whether your implementation accepts "Yes" as a synonym or not,
especially for something like this that we would want to remove in
an year or two.

> The transient nature of this fallback suggests that we should not prefix
> the variable by "GIT_".

Hmph.  That nature does not suggest anything like it to me.  When I
find an unfamiliar environment variable in my ~/.login I defined or
added to an existing script a few years back and forgot what it was
for, with a GIT_ prefix I would have one extra clue to help me
recall that it was once needed but no longer supported one that I
can safely remove.

I do agree that moving to an environment variable is a more useful
escape hatch for existing scripts that could be broken with this
change.

> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index 7d8bcc383351..e6d3a28fe26e 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -400,10 +400,17 @@ static void show_local_changes(struct object *head,
>  static void describe_detached_head(const char *msg, struct commit *commit)
>  {
>  	struct strbuf sb = STRBUF_INIT;
> +	const char *env_printsha1ellipsis = getenv("PRINT_SHA1_ELLIPSIS");
> +
>  	if (!parse_commit(commit))
>  		pp_commit_easy(CMIT_FMT_ONELINE, commit, &sb);
> -	fprintf(stderr, "%s %s... %s\n", msg,
> -		find_unique_abbrev(commit->object.oid.hash, DEFAULT_ABBREV), sb.buf);
> +	if (env_printsha1ellipsis && !strcasecmp(env_printsha1ellipsis, "yes")) {
> +		fprintf(stderr, "%s %s... %s\n", msg,
> +			find_unique_abbrev(commit->object.oid.hash, DEFAULT_ABBREV), sb.buf);
> +	} else {
> +		fprintf(stderr, "%s %s %s\n", msg,
> +			find_unique_abbrev(commit->object.oid.hash, DEFAULT_ABBREV), sb.buf);
> +	}
>  	strbuf_release(&sb);
>  }

I would actually have expected a helper function like

int print_sha1_ellipsis(void)
{
        static int cached_result = -1; /* unknown */

	if (cached_result < 0) {
		const char *v = getenv("PRINT_SHA1_ELLIPSIS");
                cached_result = (v && !strcasecmp(v, "yes"));
	}
	return cached_result;
}

so that you can reuse that in here and in quite a different place
like in diff.c.


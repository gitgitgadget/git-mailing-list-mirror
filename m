Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 393C42021E
	for <e@80x24.org>; Tue, 15 Nov 2016 20:43:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932333AbcKOUnM (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Nov 2016 15:43:12 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55195 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932196AbcKOUnL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Nov 2016 15:43:11 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 654664DF05;
        Tue, 15 Nov 2016 15:43:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=zRKkF2FDsghv+WglpQhH01pbG/8=; b=liquXT
        2uRW8beZpl9bbVcrPd7Q9ip93ZodRw282IKEgx/becIMaLMR0gPP7vume6mQxrZe
        UFY/aMTr71LPx+3aMNHbWTN2rYpKrY2axFRzRXJowDEyjpEvIxaYM6FXcHGqwFCi
        R8QJV++EcvCPAWVDnnDLvmuMRl5OpP6WFikfg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=jkq/OaI5yMM3A0H6l/GxbAkcfGZPdKlb
        j8GSUpKEEk35Rq1YedAq0kzKDnK8EMmikk1izRu4Jc94OY9DS6BOXHEdIi60jArF
        tMEBN2oNtpeksfhWC5GIsKlCw/EKKqM4oxaLCu1d+LXDqQFxfJ7O1RkAoANo3jES
        uPB8RihDMLU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5C2084DF04;
        Tue, 15 Nov 2016 15:43:10 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A0C734DF01;
        Tue, 15 Nov 2016 15:43:09 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Karthik Nayak <karthik.188@gmail.com>
Cc:     git@vger.kernel.org, jacob.keller@gmail.com
Subject: Re: [PATCH v7 00/17] port branch.c to use ref-filter's printing options
References: <20161108201211.25213-1-Karthik.188@gmail.com>
Date:   Tue, 15 Nov 2016 12:43:08 -0800
In-Reply-To: <20161108201211.25213-1-Karthik.188@gmail.com> (Karthik Nayak's
        message of "Wed, 9 Nov 2016 01:41:54 +0530")
Message-ID: <xmqqbmxgtqxv.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1E726E08-AB74-11E6-B917-987C12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Karthik Nayak <karthik.188@gmail.com> writes:

> This is part of unification of the commands 'git tag -l, git branch -l
> and git for-each-ref'. This ports over branch.c to use ref-filter's
> printing options.
>
> Karthik Nayak (17):
>   ref-filter: implement %(if), %(then), and %(else) atoms
>   ref-filter: include reference to 'used_atom' within 'atom_value'
>   ref-filter: implement %(if:equals=<string>) and
>     %(if:notequals=<string>)
>   ref-filter: modify "%(objectname:short)" to take length
>   ref-filter: move get_head_description() from branch.c
>   ref-filter: introduce format_ref_array_item()
>   ref-filter: make %(upstream:track) prints "[gone]" for invalid
>     upstreams
>   ref-filter: add support for %(upstream:track,nobracket)
>   ref-filter: make "%(symref)" atom work with the ':short' modifier
>   ref-filter: introduce refname_atom_parser_internal()
>   ref-filter: introduce symref_atom_parser() and refname_atom_parser()
>   ref-filter: make remote_ref_atom_parser() use
>     refname_atom_parser_internal()
>   ref-filter: add `:dir` and `:base` options for ref printing atoms
>   ref-filter: allow porcelain to translate messages in the output
>   branch, tag: use porcelain output
>   branch: use ref-filter printing APIs
>   branch: implement '--format' option

This is not a new issue, but --format='%(HEAD)' you stole from
for-each-ref is broken when you are on an unborn branch, and the
second patch from the tip makes "git branch" (no other args) on
an unborn branch to segfault, when there are real branches that
have commits.

Something like this needs to go before that step.

 ref-filter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ref-filter.c b/ref-filter.c
index 944671af5a..c71d7360d2 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1318,7 +1318,7 @@ static void populate_value(struct ref_array_item *ref)
 
 			head = resolve_ref_unsafe("HEAD", RESOLVE_REF_READING,
 						  sha1, NULL);
-			if (!strcmp(ref->refname, head))
+			if (head && !strcmp(ref->refname, head))
 				v->s = "*";
 			else
 				v->s = " ";



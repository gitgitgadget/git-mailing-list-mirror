Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 48F3E1FD99
	for <e@80x24.org>; Sun, 14 Aug 2016 22:09:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752018AbcHNWJV (ORCPT <rfc822;e@80x24.org>);
	Sun, 14 Aug 2016 18:09:21 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52269 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751788AbcHNWJU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Aug 2016 18:09:20 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id A989B33C75;
	Sun, 14 Aug 2016 18:09:19 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nh2m0ES8RzVkolIANf9TT5LooMs=; b=lqYmT4
	jcx3Y4pocxQIL5ZIpVdm+FQlic0q6MLLVQyEmr3tKbKlyiM60gyGj2Z+t75EsM8V
	ZyjOy3ICE9PGjGG3SpUpx+2eM55NouQkpToJbFxoxvz+ibLOcNq+TI23eBBHoyr4
	j5G24TnEvxdqizA8CM6+c2RFyTrV6F9w87xEA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TRExze4HdYkeZDd8mERae8Mpa6gtoLEf
	HHkWzUrgt6loZfSAuYx2YwmbC0cItPP80j8DVKmzkr7ogd8UFsOgte7pjDYrQnIN
	MRJXjp4mxYqmLyM9utuSvAD25+6Vk4O7b71pakpWE1lyCu1RbbTqG37XXwif9bcR
	szDDV0di+CQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id A14A133C74;
	Sun, 14 Aug 2016 18:09:19 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0EEDF33C73;
	Sun, 14 Aug 2016 18:09:18 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Philip Oakley <philipoakley@iee.org>
Cc:	GitList <git@vger.kernel.org>
Subject: Re: [PATCH v1 1/3] doc: commit: --fixup/--squash can take a commit revision
References: <20160814214630.1312-1-philipoakley@iee.org>
	<20160814214630.1312-2-philipoakley@iee.org>
Date:	Sun, 14 Aug 2016 15:09:16 -0700
In-Reply-To: <20160814214630.1312-2-philipoakley@iee.org> (Philip Oakley's
	message of "Sun, 14 Aug 2016 22:46:28 +0100")
Message-ID: <xmqq60r3knoz.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BF3C65F2-626B-11E6-AA72-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Philip Oakley <philipoakley@iee.org> writes:
> Be clearer that the --fixup/--squash options can take any of the
> gitrevisions methods of specifying a commit, not just a 'hash'.
>
> Signed-off-by: Philip Oakley <philipoakley@iee.org>
> ---
> ...
> @@ -81,15 +81,15 @@ OPTIONS
>  --fixup=<commit>::
>  	Construct a commit message for use with `rebase --autosquash`.
>  	The commit message will be the subject line from the specified
> -	commit with a prefix of "fixup! ".  See linkgit:git-rebase[1]
> -	for details.
> +	commit revision with a prefix of "fixup! ".  See linkgit:git-rebase[1]
> +	and linkgit:gitrevisions[7] for details.

The same comment applies to the other hunk, but rephrasing "commit"
with "commit revision" (the latter is not even in the glossary) does
not make it clearer at all.  Especially when discussing rebases and
anything that rewrites commits, it can easily be mistaken as if you
are talking about v2 of the commit by fixing up the original, but
that is not the impression you want to give.

"The specified commit" is clear enough.  It may be debatable if we
want to talk about "how" to specify the commit, though.  I think the
use of "commit" in an angle-bracket-pair in the label for the
section, i.e. "--fixup=<commit>", has been considered to be clear
enough to tell that you can use usual extended SHA-1 syntax to
specify the commit you want to talk about, but if so, that is not
limited to this entry, and I do not think this description or the
other one for the "--squash" option are particularly worse than
those for the "-c" and "-C" options.  The description for "-c" does
say "Take an existing commit object", but that's like "the specified
commit" used here.


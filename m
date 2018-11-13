Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B19891F87F
	for <e@80x24.org>; Tue, 13 Nov 2018 04:37:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730501AbeKMOdu (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Nov 2018 09:33:50 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61731 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726103AbeKMOdu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Nov 2018 09:33:50 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 37EBB10E459;
        Mon, 12 Nov 2018 23:37:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=DWBB/T511tneneaalrEs7tgIzwY=; b=dtbSGf
        8I3Ek6byHZTf2vY7M09cidnwy5iUMmNZVf73WUnat1r77PyJDgaZYpM36dKr5goU
        1+M/68up1+i1A5VO7e/OOm9UpVpdmJQ5DMDrSwcESSKM0jb5MoGHkul8leCgli1p
        NpWc2RF7MFoJzJlkAxSwUQXwCTyK6fsmdmdiM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=WxWs/14T/Aqg2CDC05WP1VrVp/jwzU2b
        vs4daqLQfLvBS+SVKnjVRwmMACk5ENCr/etqHXYATRgquOZhLEAhnWw2YagJfa0w
        ej6FEmI1HOi6yKGBx05QJge+8POrK7U4WhZu2IBdRrQwBI8QBDKw+XwUf3wxqUAa
        25usMWGb3W4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 30D1210E457;
        Mon, 12 Nov 2018 23:37:31 -0500 (EST)
Received: from pobox.com (unknown [35.187.50.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A458410E456;
        Mon, 12 Nov 2018 23:37:30 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Fredi Fowler <inredikawb@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH] Using no- for options instead of duplication
References: <01020167094ab871-ca8d8728-0102-4d93-a4ff-d554b4aec59f-000000@eu-west-1.amazonses.com>
Date:   Tue, 13 Nov 2018 13:37:29 +0900
In-Reply-To: <01020167094ab871-ca8d8728-0102-4d93-a4ff-d554b4aec59f-000000@eu-west-1.amazonses.com>
        (Fredi Fowler's message of "Mon, 12 Nov 2018 18:59:11 +0000")
Message-ID: <xmqqmuqdwq2e.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D4D80092-E6FD-11E8-AF41-BFB3E64BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fredi Fowler <inredikawb@gmail.com> writes:

Here is a space for you to justify the change and sign off your
patch (see Documentation/SubmittingPatches).

> ---

> Subject: Re: [RFC PATCH] Using no- for options instead of duplication

Try to see if you can format the title in "<area>: <explanation>"
form first, please.  I'll come back to it later.


>  Documentation/merge-options.txt | 21 +++++++--------------
>  1 file changed, 7 insertions(+), 14 deletions(-)

A quick counting (which may count false positives) tells me that

    $ git grep -e '^--no-' Documentation | wc -l
    124 
    $ git grep -e '^--\[no-' Documentation | wc -l
    44

you are standardizing to the minority way.

	A tangent that somebody might want to tackle.  It would be
	nice if we had a tool that takes a grep expression (like
	'^--no' and '^\[no-' above) and shows histograms of the ages
	of lines that match.  It might tell us that all 44 combined
	ones are more recent (some of them may even have been
	updated from the separate form) than the 124 separate ones,
	in which case we can say "we started the process of
	migrating to list options singly, like '--[no-]option', in
	commit X; let's continue doing so" in the log message.  Or
	it may turn out that we have been going in the other
	direction and most of these 44 are stale ones yet to be
	split.  Without such a tool, the above numbers are the best
	measure to go by, which is not quite ideal.

As there are tons of split ones, not just in merge-options.txt, I
suspect that the <area> of the change can just be "doc", so a good
title may be

	Subject: [PATCH] doc: list negative options as --[no-]option

or something like that.

If going in the direction of this patch were a good idea, that is.

I am actually not sure if it is a good idea, especially given that
the only change is the enumeration headers and without adjustment to
the text, though.

> diff --git a/Documentation/merge-options.txt b/Documentation/merge-options.txt
> index 63a3fc09548ab..fc1122ded51a0 100644
> --- a/Documentation/merge-options.txt
> +++ b/Documentation/merge-options.txt
> @@ -1,5 +1,4 @@
> ---commit::
> ---no-commit::
> +--[no-]commit::
>  	Perform the merge and commit the result. This option can
>  	be used to override --no-commit.
>  +
>  ...
>  With --no-commit perform the merge but pretend the merge
>  failed and do not autocommit, to give the user a chance to
>  inspect and further tweak the merge result before committing.

For example, the original for this one gives the behaviour for --commit
and --no-commit separately, and it visually makes it easier to see two
distinct header items.

Description of some other options read OK either way, which would
justify not touching the description when combining two headings
into one.  But that still does not justify the combining in the
first place.

FWIW, "git help -m merge" begins its OPTIONS section like this:

OPTIONS
       --commit, --no-commit
           Perform the merge and commit the result. This option can be used to
           override --no-commit.

           With --no-commit perform the merge but pretend the merge failed and
           do not autocommit, to give the user a chance to inspect and further
           tweak the merge result before committing.

which is different from heading with a single "--[no-]commit", but I
do not quite see why a single squished form is preferrable.  It does
not save lines, and it forces readers to split and reassemble two
options in their head while reading.

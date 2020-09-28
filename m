Return-Path: <SRS0=i2G4=DF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A850AC4727C
	for <git@archiver.kernel.org>; Mon, 28 Sep 2020 23:29:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 703CE21D43
	for <git@archiver.kernel.org>; Mon, 28 Sep 2020 23:29:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="fMvcocoA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726516AbgI1X3A (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Sep 2020 19:29:00 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:63868 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727125AbgI1X2t (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Sep 2020 19:28:49 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0924BF0F0C;
        Mon, 28 Sep 2020 18:31:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=6sGLy9wEGnoGFD4aQbhEfw4HS28=; b=fMvcoc
        oAoWO1pd40CV/9e5xRcoaXMA0d1HhDvRyY2l8heALWXeVpFifnNvFFjaQm/t7/z+
        bIjdPwmwGFEY2D7Xt1gJO3j3WTkiJ6JJuDrWgcBuJAFsgMc08y4Xk2ejzua3NnuJ
        Sof/CZsPgv33RP0rd2CeGbrgA8GpXFh4OKvq8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Bh7s5OqpX99cZzskWPFDO0re7gaE50Ff
        AdANw4nJ3bTGOfsShphKkOg1rmm0Wi2sAwBqm/Qy3V7Xaz2zCDu4DU/uTmAwFabp
        dBiNS3axTylRmZ/uaiqt2yeGbWV9gKuQPFQCD3AxsWE/DiaJuKjyjco07DBbAIN/
        AQAw6BelqvI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 01D76F0F0B;
        Mon, 28 Sep 2020 18:31:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 3A49AF0F0A;
        Mon, 28 Sep 2020 18:31:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Evan Gates <evan.gates@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2] Doc: specify exact scissors line
References: <20200925191659.31375-1-evan.gates@gmail.com>
        <20200928202035.24218-1-evan.gates@gmail.com>
Date:   Mon, 28 Sep 2020 15:31:19 -0700
In-Reply-To: <20200928202035.24218-1-evan.gates@gmail.com> (Evan Gates's
        message of "Mon, 28 Sep 2020 13:20:35 -0700")
Message-ID: <xmqqpn65jzyg.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 556B55EE-01DA-11EB-9283-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Evan Gates <evan.gates@gmail.com> writes:

> The existing wording covers most of the requirements of a scissors
> line, but there is no mention of ...
> ...
> Specify the exact line to use ("-- >8 --") instead of trying to document
> all the details.

s/most/some/;

For example, the code has fun heuristics to understand that things
like "-- >8 ---- >8 -- cut here -- >8 ---- >8 --" is a scissors
line, but we do not document it.

But what we agreed is that it is a bad idea to even attempt to
describe the heuristics down to the details and sell the feature as
"we accept anything that resembles a perforation drawn or printed on
paper".  Instead we are giving less choices to make it easier for
users to follow, and the updated text is a move in that direction.

So selling this change based on "the existing description does not
give enough" is not good.

    The text tries to say the code accepts many variations that
    looks remotely like scissors and perforation line, but gives too
    little detail for users to decide what is and what is not taken
    as a scissors line for themselves.  Instead of describing the
    heuristics more, just spell out what will always be accepted,
    namely "-- >8 --", as it would not help users to give them more
    choices and flexibility and be "creative" in their scissors
    line.

perhaps?

> Signed-off-by: Evan Gates <evan.gates@gmail.com>
> ---
> Changes in v2:
> - Specify exact line instead of adding text about 8 character minimum
>
>  Documentation/git-mailinfo.txt | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/git-mailinfo.txt b/Documentation/git-mailinfo.txt
> index 3bbc731f67..fbb7d2813f 100644
> --- a/Documentation/git-mailinfo.txt
> +++ b/Documentation/git-mailinfo.txt
> @@ -72,10 +72,9 @@ conversion, even with this flag.
>  	is useful in order to associate commits with mailing list discussions.
>  
>  --scissors::
> +	Remove everything in body before a scissors line ("-- >8 --").
> +	The line represents scissors and perforation marks, and is used to
> +	request the reader to cut the message at that line.  If that line

We want to say "e.g.", i.e. 'a scissors line (e.g. "-- >8 --")', in
order to hint that we may accept other forms [*1*], and also to hint
that we do not want to go int details.

Other than that, I like the conciseness of the updated text.


[Footnote]
*1* This is primarily to be friendly to left-handers to let them
write "-- 8< --".

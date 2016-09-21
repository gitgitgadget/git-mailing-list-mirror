Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 94FE61F935
	for <e@80x24.org>; Wed, 21 Sep 2016 15:57:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756548AbcIUP5v (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Sep 2016 11:57:51 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58704 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753152AbcIUP5u (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Sep 2016 11:57:50 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 06C663C06C;
        Wed, 21 Sep 2016 11:57:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=2zZkT5u/CGUcx9+QY1zdi6MZIHg=; b=bw+3Al
        NuREkQZ1SC/0mBKv1KN+BcipFxLzKirFsvkVwI6Q+pB7CMWK1GyQsWl8RxhZCgl1
        0nIE5tvpMXggP79Mj7qyMVR6FGTK5H5YtPTlz39tsJg6ZZUrirgiCsz8RO7nZFuV
        +llbJvw9tEO7IprezWgR+Bqozx8Bt5qciZqLQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=VVyMSMl8FxipwiTNR3H9i+U5mjyoX+jm
        1nnSPBZDMN3kkUXHYjXpq84MkJZBzBfhaLkK4xoqxprOWxAq1qi/w8dT6GxkOO+e
        DKZvQDc+BRDmXkvl6HOi/7RzpxNGeTJAHrKvzcqLg37eO0TxL9jF/plP3kn442LX
        dOVLyMSfNEI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id F35663C06B;
        Wed, 21 Sep 2016 11:57:48 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7BBB73C068;
        Wed, 21 Sep 2016 11:57:48 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Josh Triplett <josh@joshtriplett.org>
Cc:     git@vger.kernel.org,
        Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v3] format-patch: Add --rfc for the common case of [RFC PATCH]
References: <501a6bfb2a70f44f080b2f119e4503ccbf88f639.1474330487.git-series.josh@joshtriplett.org>
Date:   Wed, 21 Sep 2016 08:57:46 -0700
In-Reply-To: <501a6bfb2a70f44f080b2f119e4503ccbf88f639.1474330487.git-series.josh@joshtriplett.org>
        (Josh Triplett's message of "Mon, 19 Sep 2016 21:23:25 -0700")
Message-ID: <xmqqy42lb5z9.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 24B92436-8014-11E6-A4F9-C26412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Josh Triplett <josh@joshtriplett.org> writes:

> This provides a shorter and more convenient alias for
> --subject-prefix='RFC PATCH'.

Shorter and more convenient is quite subjective but more important
as a justification is that we believe [RFC PATCH] is used fairly
commonly (at least in certain circles).

> Includes documentation in the format-patch manpage, and a new test
> covering --rfc.

We can see that from diffstat ;-)

I'd retitle this like so:

    format-patch: add "--rfc" for the common case of [RFC PATCH]

    Add an alias for --subject-prefix='RFC PATCH', which is used
    commonly in some development communities to deserve such a
    short-hand.

    Signed-off-by: Josh Triplett <josh@joshtriplett.org>
    Reviewed-by: Jeff King <peff@peff.net>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>

> diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
> index 9624c84..9b200b3 100644
> --- a/Documentation/git-format-patch.txt
> +++ b/Documentation/git-format-patch.txt
> @@ -19,7 +19,8 @@ SYNOPSIS
>  		   [--start-number <n>] [--numbered-files]
>  		   [--in-reply-to=Message-Id] [--suffix=.<sfx>]
>  		   [--ignore-if-in-upstream]
> -		   [--subject-prefix=Subject-Prefix] [(--reroll-count|-v) <n>]
> +		   [--rfc] [--subject-prefix=Subject-Prefix]
> +		   [(--reroll-count|-v) <n>]
>  		   [--to=<email>] [--cc=<email>]
>  		   [--[no-]cover-letter] [--quiet] [--notes[=<ref>]]
>  		   [<common diff options>]
> @@ -172,6 +173,11 @@ will want to ensure that threading is disabled for `git send-email`.
>  	allows for useful naming of a patch series, and can be
>  	combined with the `--numbered` option.
>  
> +--rfc::
> +	Alias for `--subject-prefix="RFC PATCH"`. RFC means "Request For
> +	Comments"; use this when sending an experimental patch for
> +	discussion rather than application.
> +

I do not think we want to be in the business of encouragign or
discouraging the use of "[RFC PATCH]".  

	--rfc:: A short-hand for `--subject-prefix="RFC PATCH"`.
        	RFC stands for "request for comments" and such a
        	prefix is used in some development communities when
        	sending a patch primarily to illustrate an idea to
        	help discussion, rather than to be applied.

perhaps?

The code and test both look good to me.

Thanks.

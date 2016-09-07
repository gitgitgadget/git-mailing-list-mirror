Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E09E01F859
	for <e@80x24.org>; Wed,  7 Sep 2016 19:20:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752733AbcIGTUO (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Sep 2016 15:20:14 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51690 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751856AbcIGTUN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Sep 2016 15:20:13 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B8F643CB9E;
        Wed,  7 Sep 2016 15:20:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=r7GrolKuxxUA9NUb+2M0w+PC/7M=; b=uYUYw2
        MLAtuJPMKGvVsrFH6GS3hxK4wUGcS9ZTMSRd2/0bzJdKVYFWyjq6pcIx9zdAlKXn
        MGB5H9DzfdXtNVpKQNBAH9ljivrt7QwuTia4eqKvCKy2S6UgLRIl0ERPWZKGEgP9
        f9Oyb0nZJLdfyoJ7J2+jl6Z94ClfYtvVAG/pk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=kAU+kcXOmpM2c4ogwBvamu+kgHsE6rq3
        ANng3BbWownUztEhMyQFz2HpMW9eLHM3eTblrsklOAoUIHWYbdcEyjv5hRenGzzs
        5ZDgGbyFYBITXcVo5ZUDvj2VCbR73TPOQ6bnwMFMERcntkqxHf5wBeCRzO7a0fFq
        +LtWSWOo3nA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B13403CB9D;
        Wed,  7 Sep 2016 15:20:11 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3CD833CB9C;
        Wed,  7 Sep 2016 15:20:11 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     David Turner <novalis@novalis.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v2 00/38] Virtualization of the refs API
References: <cover.1473003902.git.mhagger@alum.mit.edu>
Date:   Wed, 07 Sep 2016 12:20:09 -0700
In-Reply-To: <cover.1473003902.git.mhagger@alum.mit.edu> (Michael Haggerty's
        message of "Sun, 4 Sep 2016 18:08:06 +0200")
Message-ID: <xmqqmvjjldp2.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 189E0D36-7530-11E6-B897-F7BB12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michael Haggerty <mhagger@alum.mit.edu> writes:

> This is v2 of the patch series to virtualize the references API
> (though earlier patch series similar in spirit were submitted by
> Ronnie Sahlberg and David Turner). Thanks to Junio, Eric, and Ramsay
> for their comments about v1 [1].
>
> Nobody pointed out any fundamental problems with v1, but this version
> includes the following improvements:

Curiously, many of these improvements were already in 'pu'.

> * In "rename_ref_available(): add docstring":
>
>   * Improve docstring as suggested by Junio.

I might have squashed that in myself; it is a long time ago so I
don't quite remember.

> * In "refs: create a base class "ref_store" for files_ref_store":
>
>   * Let main_ref_store and submodule_ref_stores be initialized
>     implicitly rather than initializing them explicitly to NULL.
>
>   * Add docstrings for those two variables.
>
>   * Eliminate a temporary variable in `files_downcast()`.

This was already in what has been in 'pu'.

> * In "resolve_gitlink_ref(): avoid memory allocation in many cases":
>
>   * Instead of keeping track of `orig_len`, after stripping off any
>     trailing slashes check whether `path[len - 1]` is NUL.

This was already in what has been in 'pu'.

> * In "refs: add methods for reflog":
>
>   * Don't export `files_reflog_iterator_begin()` (suggested by
>     Ramsay).

This I can see was missing in what has been in 'pu'.

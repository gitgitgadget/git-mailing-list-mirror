Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9702DC64E7C
	for <git@archiver.kernel.org>; Thu,  3 Dec 2020 00:53:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 426B2221FB
	for <git@archiver.kernel.org>; Thu,  3 Dec 2020 00:53:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbgLCAx3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Dec 2020 19:53:29 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54092 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725916AbgLCAx2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Dec 2020 19:53:28 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7616B9ABBE;
        Wed,  2 Dec 2020 19:52:46 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=v8UieEdQcwyRtf2w7eh27AYGoEE=; b=X5x2ya
        m12/+xsP23SQrZOQA+cmG7tA3VKg0vczUMZrBnOkNQYr53mxl7nZEqiXjuUVJVvT
        RHzaWc6P63wlFJSe+HorOyvbHEQUPzTX+bjp0PD1zN5GJJbSdJjwPwmnFcHtRNGT
        DirqShUDbtwqCGsWhGAwSTfQikY4gddxzHBFc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=EfVZ9UvpgCGmSGRunZjZbWhISKz3cFR1
        REhsdRYv5Fy+TJrj1wIQp6DLHD4kvJHCwpEp2snHmHPMW8/d9AAZaSIPtPazyKkg
        fXrc026BMCVBnNk+rHsybzBc9XXAuRYfSvZhALR9vaVktl2ztRvK/vtucw+mtuqC
        YMn1+7MPrsw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6E8449ABBD;
        Wed,  2 Dec 2020 19:52:46 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id F25C79ABBC;
        Wed,  2 Dec 2020 19:52:45 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        git@vger.kernel.org
Subject: Re: [PATCH v1 06/27] diff-merges: rename all functions to have
 common prefix
References: <20201101193330.24775-1-sorganov@gmail.com>
        <20201108213838.4880-1-sorganov@gmail.com>
        <20201108213838.4880-7-sorganov@gmail.com>
Date:   Wed, 02 Dec 2020 16:52:45 -0800
In-Reply-To: <20201108213838.4880-7-sorganov@gmail.com> (Sergey Organov's
        message of "Mon, 9 Nov 2020 00:38:17 +0300")
Message-ID: <xmqqeek7k8wy.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DB946606-3501-11EB-892C-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov <sorganov@gmail.com> writes:

> Use the same "diff_merges" prefix for all the diff merges function
> names.
>
> Signed-off-by: Sergey Organov <sorganov@gmail.com>
> ---
>  builtin/log.c |  4 ++--
>  diff-merges.c | 10 +++++-----
>  diff-merges.h | 15 ++++++++++-----
>  revision.c    |  6 +++---
>  4 files changed, 20 insertions(+), 15 deletions(-)
>
> diff --git a/builtin/log.c b/builtin/log.c
> index ad3092fdd854..77a7bba543ad 100644
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -599,7 +599,7 @@ static int show_tree_object(const struct object_id *oid,
>  static void show_setup_revisions_tweak(struct rev_info *rev,
>  				       struct setup_revision_opt *opt)
>  {
> -	rev_diff_merges_default_to_dense_combined(rev);
> +	diff_merges_default_to_dense_combined(rev);
>  	if (!rev->diffopt.output_format)
>  		rev->diffopt.output_format = DIFF_FORMAT_PATCH;
>  }
> @@ -724,7 +724,7 @@ static void log_setup_revisions_tweak(struct rev_info *rev,
>  	if (!rev->diffopt.output_format && rev->combine_merges)
>  		rev->diffopt.output_format = DIFF_FORMAT_PATCH;
>  
> -	rev_diff_merges_first_parent_defaults_to_enable(rev);
> +	diff_merges_first_parent_defaults_to_enable(rev);

Even with a different prefix, this name does not make it clear what
is going on to its readers.  The other name is OK, though.

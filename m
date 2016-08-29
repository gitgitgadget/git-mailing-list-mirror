Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 76CE31FD99
	for <e@80x24.org>; Mon, 29 Aug 2016 23:10:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756497AbcH2XJ6 (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Aug 2016 19:09:58 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59030 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1756386AbcH2XJ5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Aug 2016 19:09:57 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8AB953A61B;
        Mon, 29 Aug 2016 19:03:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=moV4QyIhA/mlEUgXryeVoEbdNoM=; b=VSKNj9
        2CquStxmev0YEzQzUDZAHLNG3YcF3XVg/2Cv/nhqSv0Gl39VilqB0vh2NW4VsxrC
        OFv7QKFRVU4M7hYkEHe+jFkJzcjOXoZXWqI0uP3Ww/Fnto+BHV7Fp86W87G58m1H
        FRKpBphiaZPs/sbvt8yig5BP8Yt8tsRRoWcPI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=uU25g0kkuwxfUy22m+JTPtIUAissk7gW
        PO336E8/MWKGEseP13g8/MlXJCQancX56YmUhNI6Fxk8cB6YaQqu3On34VeWTEU0
        OGFTZUeA7QkjcVYDgrvQORv6+kKSX++YlgehfE345KePvgUbrnFIwZxfdxvYXb17
        E8a7LwrN6eE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 827B63A61A;
        Mon, 29 Aug 2016 19:03:26 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 00FFF3A619;
        Mon, 29 Aug 2016 19:03:25 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 5/6] Export also the has_un{staged,committed}_changed() functions
References: <cover.1472137582.git.johannes.schindelin@gmx.de>
        <f693f6719c44c033fdaab5a6adb3b4b415d0f454.1472137582.git.johannes.schindelin@gmx.de>
Date:   Mon, 29 Aug 2016 16:03:23 -0700
In-Reply-To: <f693f6719c44c033fdaab5a6adb3b4b415d0f454.1472137582.git.johannes.schindelin@gmx.de>
        (Johannes Schindelin's message of "Thu, 25 Aug 2016 17:07:17 +0200
        (CEST)")
Message-ID: <xmqqinuj6uv8.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CAC1C8F4-6E3C-11E6-855B-F7BB12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> diff --git a/wt-status.h b/wt-status.h
> index cc4e5a3..75833c1 100644
> --- a/wt-status.h
> +++ b/wt-status.h
> @@ -115,6 +115,8 @@ void status_printf_ln(struct wt_status *s, const char *color, const char *fmt, .
>  __attribute__((format (printf, 3, 4)))
>  void status_printf(struct wt_status *s, const char *color, const char *fmt, ...);
>  
> +int has_unstaged_changes(void);
> +int has_uncommitted_changes(void);
>  int require_clean_work_tree(const char *action, const char *hint, int gently);
>  
>  #endif /* STATUS_H */

These are good interfaces, if the caller wants to know these bits
independently.

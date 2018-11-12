Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3926E1F87F
	for <e@80x24.org>; Mon, 12 Nov 2018 10:20:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728340AbeKLUNF (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Nov 2018 15:13:05 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59640 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbeKLUNF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Nov 2018 15:13:05 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9D48A10C32B;
        Mon, 12 Nov 2018 05:20:29 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9Q002qve/l4QlCuegdpmzPwT8zo=; b=JMlyOT
        oNwdptmIfOubmkxvT7JYBNy5wAQoPkMumFMLRnT11bWtuST0IeRszvcNGeCjXB3l
        g72pwaGtk6v1J4YhTbovHGlk1xUU6g25yATo+n2Fd++aa3zyDtt8x0+jrUAroBW0
        2XWAPzQtg7+xn3qJ8DZY5XRL9m1Jq+zZ5gm3w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=NXfDUkusyO3HLoxNsoUw7F4Fp1hZxaLd
        AK2aSFW3oGLIPGQ252UbSQVdLE7g5WtcoKjMnWHg6A4jRXRFJMMctWpDAEn6iiD3
        wAr2eqPQgvXaENUHKsYKS5FhPalCZc2n5obECCB6BkYzgOcYfSRyo6NFbzAMwQnG
        +3SW805Sh8U=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9508D10C329;
        Mon, 12 Nov 2018 05:20:29 -0500 (EST)
Received: from pobox.com (unknown [35.187.50.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1135610C327;
        Mon, 12 Nov 2018 05:20:28 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     nbelakovski@gmail.com
Cc:     rafa.almas@gmail.com, avarab@gmail.com, git@vger.kernel.org,
        peff@peff.net
Subject: Re: [PATCH v2 2/2] branch: Mark and colorize a branch differently if it is checked out in a linked worktree
References: <20180927204049.GA2628@rigel>
        <20181111235831.44824-1-nbelakovski@gmail.com>
        <20181111235831.44824-3-nbelakovski@gmail.com>
Date:   Mon, 12 Nov 2018 19:20:28 +0900
In-Reply-To: <20181111235831.44824-3-nbelakovski@gmail.com> (nbelakovski's
        message of "Sun, 11 Nov 2018 15:58:31 -0800")
Message-ID: <xmqqo9au1tsj.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 941CF128-E664-11E8-97EB-063AD72159A7-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

nbelakovski@gmail.com writes:

> diff --git a/color.h b/color.h
> index 98894d6a17..857653df73 100644
> --- a/color.h
> +++ b/color.h
> @@ -42,6 +42,24 @@ struct strbuf;
>  #define GIT_COLOR_FAINT_BLUE	"\033[2;34m"
>  #define GIT_COLOR_FAINT_MAGENTA	"\033[2;35m"
>  #define GIT_COLOR_FAINT_CYAN	"\033[2;36m"
> +#define GIT_COLOR_LIGHT_RED	"\033[91m"
> +#define GIT_COLOR_LIGHT_GREEN	"\033[92m"
> +#define GIT_COLOR_LIGHT_YELLOW	"\033[93m"
> +#define GIT_COLOR_LIGHT_BLUE	"\033[94m"
> +#define GIT_COLOR_LIGHT_MAGENTA	"\033[95m"
> +#define GIT_COLOR_LIGHT_CYAN	"\033[96m"
> +#define GIT_COLOR_BOLD_LIGHT_RED	"\033[1;91m"
> +#define GIT_COLOR_BOLD_LIGHT_GREEN	"\033[1;92m"
> +#define GIT_COLOR_BOLD_LIGHT_YELLOW	"\033[1;93m"
> +#define GIT_COLOR_BOLD_LIGHT_BLUE	"\033[1;94m"
> +#define GIT_COLOR_BOLD_LIGHT_MAGENTA	"\033[1;95m"
> +#define GIT_COLOR_BOLD_LIGHT_CYAN	"\033[1;96m"
> +#define GIT_COLOR_FAINT_LIGHT_RED	"\033[2;91m"
> +#define GIT_COLOR_FAINT_LIGHT_GREEN	"\033[2;92m"
> +#define GIT_COLOR_FAINT_LIGHT_YELLOW	"\033[2;93m"
> +#define GIT_COLOR_FAINT_LIGHT_BLUE	"\033[2;94m"
> +#define GIT_COLOR_FAINT_LIGHT_MAGENTA	"\033[2;95m"
> +#define GIT_COLOR_FAINT_LIGHT_CYAN	"\033[2;96m"

Hopefully you made sure that there is no other topic in-flight that
touch this area before doing this change?  Otherwise you'd be
creating pointless merge conflict by futzing with spaces.

Ditto for an earlier hunk of this patch.

Thanks.

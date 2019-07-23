Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 92C4F1F461
	for <e@80x24.org>; Tue, 23 Jul 2019 17:35:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732899AbfGWRfE (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Jul 2019 13:35:04 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:50769 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726252AbfGWRfE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jul 2019 13:35:04 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1737575930;
        Tue, 23 Jul 2019 13:35:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/d5ja5a3JXDGWss3OQ/hHuDFptE=; b=vRGZVN
        6yY269IfX06bPJFUc4UPRm3Zsaz+2cOLAeTjQHd0vaVb9DpzyWCaQ54jHb8jN1kS
        +wo9JXr4lSf/pU7vWodHmIUiFD/3ecKPZiYpqxkPeNm2ENcrlhBeA9JkUM/KqIAv
        r321P39Th2odp5c4H3qiHpapZHNfps/46y0tc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=GZcBd/tTPGeszX/7GyoAYE40LGLAg7dg
        L+NiXHWAjJRqljnEU2AqSpXfPBCX2gaGouLAn/+YJVbsid6GmRCxT5EBAIRgD2yU
        8yvuSE7uTSiOrNfOHiuoSZZ+NwknKZGCogOvmikwETNnRKp0xaVpEqmmUm9dfdnx
        4xORAljFzSU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0FAC27592F;
        Tue, 23 Jul 2019 13:35:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 1E4F57592B;
        Tue, 23 Jul 2019 13:34:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Beat Bolli <dev+git@drbeat.li>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] grep: print the pcre2_jit_on value
References: <20190722181923.21572-1-dev+git@drbeat.li>
Date:   Tue, 23 Jul 2019 10:34:57 -0700
In-Reply-To: <20190722181923.21572-1-dev+git@drbeat.li> (Beat Bolli's message
        of "Mon, 22 Jul 2019 20:19:23 +0200")
Message-ID: <xmqq1rygu01q.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3195F3F0-AD70-11E9-83A6-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Beat Bolli <dev+git@drbeat.li> writes:

> When pcre2_jit_on is neither 1 nor 0, the BUG() call printed the value
> of pcre1_jit_on.
>
> Print the value of pcre2_jit_on instead.
>
> Signed-off-by: Beat Bolli <dev+git@drbeat.li>
> ---

Thanks.


>  grep.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/grep.c b/grep.c
> index f7c3a5803e..cd952ef5d3 100644
> --- a/grep.c
> +++ b/grep.c
> @@ -559,7 +559,7 @@ static void compile_pcre2_pattern(struct grep_pat *p, const struct grep_opt *opt
>  		pcre2_jit_stack_assign(p->pcre2_match_context, NULL, p->pcre2_jit_stack);
>  	} else if (p->pcre2_jit_on != 0) {
>  		BUG("The pcre2_jit_on variable should be 0 or 1, not %d",
> -		    p->pcre1_jit_on);
> +		    p->pcre2_jit_on);
>  	}
>  }

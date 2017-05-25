Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6795120209
	for <e@80x24.org>; Thu, 25 May 2017 02:26:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755274AbdEYC0n (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 May 2017 22:26:43 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34965 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755269AbdEYC0l (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 May 2017 22:26:41 -0400
Received: by mail-pf0-f195.google.com with SMTP id u26so35927245pfd.2
        for <git@vger.kernel.org>; Wed, 24 May 2017 19:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=siV6MMkHyAyTaJHtVf6JWDEZWgTDlkf7hCV3pkV90QE=;
        b=s+3Lx4sXEti5go275Rq7bSAs8U3Elv6jcVIUIF9QIbYwa7RTDRT1Lc4FJ3YTGEjC1D
         Jrq0xfVXig27RIXq58xCBnH6+CmFL4VFw9NugRabw1fGjInhfifwT3tuGW6gDb7lZG6i
         P0ebQfKe11FcDejxEB7bXXYcLH1dgrZKBRVceJWNkLCMPOlb6m39+PyI3Qkc1B0E5UMT
         qbTQK5HCKyJO/qgBeoBAvmrxfAZuZKhTMBeWoM88YQ5eqUSmUkdtMa2M+VUqPFRjyVYX
         Of+94eGTRyZkSAZtqq3JLZ1aWtzRjgDrkj/hfRFUouY/DVcXeqbpIOsLQnP/CGZPbQGa
         3Xww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=siV6MMkHyAyTaJHtVf6JWDEZWgTDlkf7hCV3pkV90QE=;
        b=MP1KY9s6lT/fxIyVamvHLzuzkOkEbO+R6/szelgJFkEEU+5aG3pSjuQHR/E4/HdvJb
         KMhzBeS9Cio3UujReOFtQ0m3SkHFyFM3ihoZGqi+YkvGxK9jskbegnUkY1hWuSKwPWvq
         UAP+QRAzfsyxodzy9RFkHJ+IP3Uz8uvYYQhSQ+57jUS43RsxmT80z5eesgPN+WxbfiID
         REybsOrEgXZmVUOg8DsC41uJsVJZsC23gekgsXs8saGql/DFN9Sh71Rvjh0aAo69T9+n
         um7+eZJj88B1fRVr+n1lr8ZeuKNoJVDE5tiW5sEnAJEvMniFhTVsMSyvx7rfggB+QOFa
         rNCA==
X-Gm-Message-State: AODbwcBf+YBAA/43vklC3Lc+bbZhcEEBEDWPvsoibLuisywQj2exSzst
        dnFAIMzxH8PyEg==
X-Received: by 10.84.136.135 with SMTP id 7mr47569258pll.98.1495679200643;
        Wed, 24 May 2017 19:26:40 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:bc81:1d63:7e7e:dfa1])
        by smtp.gmail.com with ESMTPSA id a28sm5629743pgd.37.2017.05.24.19.26.39
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 24 May 2017 19:26:39 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, bmwill@google.com, jrnieder@gmail.com,
        jonathantanmy@google.com, peff@peff.net, mhagger@alum.mit.edu
Subject: Re: [PATCHv5 16/17] diff: buffer all output if asked to
References: <20170523024048.16879-1-sbeller@google.com/>
        <20170524214036.29623-1-sbeller@google.com>
        <20170524214036.29623-17-sbeller@google.com>
Date:   Thu, 25 May 2017 11:26:39 +0900
In-Reply-To: <20170524214036.29623-17-sbeller@google.com> (Stefan Beller's
        message of "Wed, 24 May 2017 14:40:35 -0700")
Message-ID: <xmqqo9uhfz8g.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> Introduce a new option 'use_buffer' in the struct diff_options which
> controls whether all output is buffered up until all output is available.
> ...
> Unconditionally enable output via buffer in this patch as it yields
> a great opportunity for testing, i.e. all the diff tests from the
> test suite pass without having reordering issues (i.e. only parts
> of the output got buffered, and we forgot to buffer other parts).
> The test suite passes, which gives confidence that we converted all
> functions to use emit_line for output.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>

Oh, did I?

> ---
>  diff.c | 155 ++++++++++++++++++++++++++++++++++++++++++++++++++---------------
>  diff.h |  41 +++++++++++++++++
>  2 files changed, 161 insertions(+), 35 deletions(-)
>
> diff --git a/diff.c b/diff.c
> index 514c5facd7..8e06206881 100644
> --- a/diff.c
> +++ b/diff.c
> ...
> @@ -2579,6 +2628,13 @@ static void builtin_diff(const char *name_a,
>  			xecfg.ctxlen = strtoul(v, NULL, 10);
>  		if (o->word_diff)
>  			init_diff_words_data(&ecbdata, o, one, two);
> +		if (o->use_buffer) {
> +			struct diff_line e = diff_line_INIT;

This ...

> +			e.state = DIFF_LINE_RELOAD_WS_RULE;
> ...
> +#define diff_line_INIT {NULL, NULL, NULL, 0, 0, 0}

... and this should be in all caps.   We do not say

	struct strbuf buf = strbuf_INIT;

and we should do the same for this new thing.


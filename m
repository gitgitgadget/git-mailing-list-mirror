Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 134D71F404
	for <e@80x24.org>; Thu,  6 Sep 2018 22:45:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbeIGDWv (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Sep 2018 23:22:51 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34632 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726131AbeIGDWv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Sep 2018 23:22:51 -0400
Received: by mail-pg1-f196.google.com with SMTP id d19-v6so5966223pgv.1
        for <git@vger.kernel.org>; Thu, 06 Sep 2018 15:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=CXOskUeslD+4vmjTL3SHUNiGRqrBJvbk7elbaWTDk/Y=;
        b=MkSfdAK9fMb09BcfaU7u+zqO1+Wwpuo8bSzdXBVNerQJIi//34xGdGGuuHUO+u12E1
         Nw++rvQYUB1FOl8hXu16axIABfuppDJFPvWIO+myDuPLYUO4xYDPxx++zlucxBMF6MH7
         qrnMbHZXUmiRFP5YFeeAWcttBYu6FWhy+5JwQCof15kbbZ7uxBdEUT2jjW+MqG75IiOX
         XtuySSNZqMDw0NFn+GoF72HdUOw2p5wH0hGaJc0KygPGTYt6fOQ2P93p7CXv2uz9aUtr
         DaN9/jpPpDfKZwJJHA9wlsihW1vamdcM/kWi3mhsP8lSabu5ZWsT2For+nwWg4CYytsW
         tQbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=CXOskUeslD+4vmjTL3SHUNiGRqrBJvbk7elbaWTDk/Y=;
        b=cq282x0pgD2fi1jl/4BxEE0eFVZ0vpQDQD3ScCQqNCD7wG+8YjnhuKv0aLrE96BFdE
         IB4SU703M+kgKZcKpSjAZokOtOo0V8G5xMc3HpWSHiqbosD89CbtJ54b+KburdEfhnYO
         4hQAPFCl3nXzFbB3bRyg19MVY9D+ja72HjSTIcSpxgjQlvSFb9ghD17sIz5oGyJTavWs
         9fcKyj4vpyr3twczEGqS12Hu3uorahaIdjonhPDGsWqjruRRLu0kqGO8i90Wl2nU3UYK
         AispcQVaOM876q8tCgr2KN/Bv2anvG83rwxQmFn1jLuov9kzEPhWRuMkS2xIcaWfL2ej
         bG1w==
X-Gm-Message-State: APzg51DGcBsg7nqzKTXzQnrQE9s6qR0nbx7sepavx07z3u87BHn+CUVz
        hBm5RPSw1pofqb0266lS7qIclQQF
X-Google-Smtp-Source: ANB0VdYtmMl8kFI7VYHhHvMxkcuBLRlbf03M0V0Z7e2IINPvya2KziGNllk1fNwci+JE5Lw1la5wXw==
X-Received: by 2002:a63:986:: with SMTP id 128-v6mr5269421pgj.153.1536273908252;
        Thu, 06 Sep 2018 15:45:08 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id z11-v6sm13731881pfi.4.2018.09.06.15.45.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Sep 2018 15:45:07 -0700 (PDT)
Date:   Thu, 6 Sep 2018 15:45:05 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Max Kirillov <max@max630.net>
Cc:     Jelmer =?utf-8?Q?Vernoo=C4=B3?= <jelmer@jelmer.uk>,
        git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH] http-backend: allow empty CONTENT_LENGTH
Message-ID: <20180906224505.GA81412@aiede.svl.corp.google.com>
References: <20180906061038.GA94045@aiede.svl.corp.google.com>
 <20180906193516.28909-1-max@max630.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180906193516.28909-1-max@max630.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Max Kirillov wrote:

> According to RFC3875, empty environment variable is equivalent to unset,
> and for CONTENT_LENGTH it should mean zero body to read.
>
> However, as discussed in [1], unset CONTENT_LENGTH is also used for
> chunked encoding to indicate reading until EOF, so keep this behavior also
> for empty CONTENT_LENGTH.
>
> Add a test for the case.
>
> [1] https://public-inbox.org/git/20160329201349.GB9527@sigill.intra.peff.net/
>
> Signed-off-by: Max Kirillov <max@max630.net>

Reported-by: Jelmer Vernooĳ <jelmer@jelmer.uk>

Thanks for fixing it.

Can you include a summary of [1] instead of relying on the mailing
list archive?  Perhaps just omiting "as discussed in [1]" would do the
trick.  Alternatively, if there's a point from that discussion that's
relevant to the change, please include it here.  That way, people
finding this change later can save some time by avoiding having to dig
through that mailing list thread.

For example, it's probably worth mentioning that this was discovered
using dulwich's test suite.

[...]
> This should fix it. I'm not sure should it treat it as 0 or "-1"
> At least the tests mentioned by Jeff fails if I try to treat missing CONTENT_LENGTH as "-1"
> So keep the existing behavior as much as possible

That sounds worth figuring out so we can understand and possibly
document it better.  What are the ramifications of this choice ---
what would work / not work with each choice?

[...]
> --- a/t/t5562-http-backend-content-length.sh
> +++ b/t/t5562-http-backend-content-length.sh
> @@ -152,4 +152,15 @@ test_expect_success 'CONTENT_LENGTH overflow ssite_t' '

Yay, thanks for this as well.

Sincerely,
Jonathan

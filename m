Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD767208CD
	for <e@80x24.org>; Wed, 30 Aug 2017 06:55:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750855AbdH3GzG (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Aug 2017 02:55:06 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:58170 "EHLO
        alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750756AbdH3GzF (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 30 Aug 2017 02:55:05 -0400
X-AuditID: 12074412-1e5ff7000000748d-5b-59a6614857f3
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id A3.44.29837.84166A95; Wed, 30 Aug 2017 02:55:04 -0400 (EDT)
Received: from [192.168.69.190] (p57BCC970.dip0.t-ipconnect.de [87.188.201.112])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v7U6t2mM007139
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Wed, 30 Aug 2017 02:55:03 -0400
Subject: Re: [PATCH] config: use a static lock_file struct
To:     Jeff King <peff@peff.net>
Cc:     Brandon Williams <bmwill@google.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        Git Users <git@vger.kernel.org>
References: <179AC8FB-5991-4200-9AAC-2F8D0914D5F9@gmail.com>
 <20170827232338.hm5t7t7c2xaa3zyl@sigill.intra.peff.net>
 <CAN0heSoUqcOqVspZkbPahWQdtVpSdtSZoCFWu0ZQJfN3F0mD2g@mail.gmail.com>
 <B1E291F2-86FF-4982-A092-92FAED65385C@gmail.com>
 <20170829185341.s3xlsx4uym7lcluc@sigill.intra.peff.net>
 <20170829185850.tfmjoa5u5sfuwpgi@sigill.intra.peff.net>
 <20170829190928.GD131745@google.com>
 <20170829191217.dt65wazf7qh5qs3k@sigill.intra.peff.net>
 <01375356-5d39-99af-9e91-35083ed03f42@alum.mit.edu>
 <20170830043147.culn63luzdsbpuuw@sigill.intra.peff.net>
 <20170830045555.27xczwo3ql7q4bg3@sigill.intra.peff.net>
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <3e632fd3-7db9-4c38-c524-b56a06cfaa87@alum.mit.edu>
Date:   Wed, 30 Aug 2017 08:55:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20170830045555.27xczwo3ql7q4bg3@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnleLIzCtJLcpLzFFi42IRYndR1PVIXBZpcGCpssXz9SfYLbqudDNZ
        PH64hNXi75suRosfLT3MDqweO2fdZfdYsKnU41nvHkaPz5vkAliiuGxSUnMyy1KL9O0SuDI6
        ZzxiK2gTqjgwhaeBcQlfFyMnh4SAicTrZ09Yuxi5OIQEdjBJNG+7xwSSEBK4wCTx/FYtiC0s
        YCVx4+1GdhBbREBW4vvhjYwgDcwCxxkl1u96xgjR/Z5F4v2cc2wgVWwCuhKLeprBJvEK2Et8
        e7+fFcRmEVCVaO7sApskKhAh0ff2MjtEjaDEyZlPWLoYOTg4BVwkdrVrgYSZBdQl/sy7xAxh
        i0vcejKfCcKWl2jeOpt5AqPALCTds5C0zELSMgtJywJGllWMcok5pbm6uYmZOcWpybrFyYl5
        ealFumZ6uZkleqkppZsYIeEutINx/Um5Q4wCHIxKPLw7SpdGCrEmlhVX5h5ilORgUhLltUxY
        FinEl5SfUpmRWJwRX1Sak1p8iFGCg1lJhNc5ECjHm5JYWZValA+TkuZgURLn/blY3U9IID2x
        JDU7NbUgtQgmK8PBoSTBawoyVLAoNT21Ii0zpwQhzcTBCTKcB2j4DJAa3uKCxNzizHSI/ClG
        RSlx3r/xQAkBkERGaR5cLywdvWIUB3pFmNcbpJ0HmMrgul8BDWYCGhzrtRRkcEkiQkqqgXF7
        abYd76UFWTJHlmf5JCw59WR2nrb52ivsig+dGNxzO984bNGa9MnBMeXL+e7bR7TituTLazLZ
        TG4sMlntFqbJtsdKYotf3NEguySpzt17p9iYBj118n3W9G6eYsHp2APJOecUZp779mHz1ziJ
        8iaxQ/fzGPg/la7Ne73eaMarMtPdG6Rk/iuxFGckGmoxFxUnAgCfvktYIgMAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08/30/2017 06:55 AM, Jeff King wrote:
> [...]
> Something like this, which AFAICT is about as safe as the existing code
> in its list manipulation. It retains the "active" flag as an additional
> check which I think isn't strictly necessary, but potentially catches
> some logic errors.
> 
> The strbuf_reset() calls become strbuf_release(), since we're promising
> the caller that they could now free the struct (or let it go out of
> scope) if they chose. Probably during a signal handler we should skip
> that (we know the struct is off the list and non-active at that point,
> but we could possibly hit libc's free() mutex).

This looks OK to me aside from the one caveat below.

> diff --git a/tempfile.c b/tempfile.c
> index 6843710670..a7d964ebf8 100644
> --- a/tempfile.c
> +++ b/tempfile.c
> [...]
> +static void deactivate_tempfile(struct tempfile *tempfile)
> +{
> +	struct tempfile *volatile *p;
> +
> +	if (!tempfile->active)
> +		return;
> +
> +	tempfile->active = 0;
> +	for (p = &tempfile_list; *p; p = &(*p)->next) {
> +		if (*p == tempfile) {
> +			*p = tempfile->next;
> +			break;
> +		}
>  	}
>  }

`deactivate_tempfile()` is O(N) in the number of active tempfiles. This
could get noticeable for, say, updating 30k references, which involves
obtaining 30k reference locks. I think that code adds the locks in
alphabetical order and also removes them in alphabetical order, so the
overall effort would go like O(N²). I'm guessing that this would be
measurable but not fatal for realistic numbers of references, but it
should at least be benchmarked.

There are three obvious ways to make this O(1) again:

* Make the list doubly-linked.
* Make sure that all significant callers remove items in the *reverse*
order that they were added, in which case the item to be removed would
always be found near the head of the list.
* Change this class to keep track of a tail pointer and add new items at
the end of the list, and ensure that all significant callers remove
locks in the *same* order that they were added.

The second and third options might be easy or difficult (depend on how
much current callers need to be changed) and certainly would be easy to
break again as new callers are added in the future.

> [...]

Michael

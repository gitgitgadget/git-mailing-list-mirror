Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1491D1F40E
	for <e@80x24.org>; Wed,  3 Aug 2016 22:52:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932918AbcHCWv7 (ORCPT <rfc822;e@80x24.org>);
	Wed, 3 Aug 2016 18:51:59 -0400
Received: from mail-io0-f172.google.com ([209.85.223.172]:35110 "EHLO
	mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932873AbcHCWv6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2016 18:51:58 -0400
Received: by mail-io0-f172.google.com with SMTP id m101so257043313ioi.2
        for <git@vger.kernel.org>; Wed, 03 Aug 2016 15:51:58 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=VnzRg86SdMdpC2GL7NT6/231QACcVrP8rQ6QkpdG7R4=;
        b=IDm0v+JR7oBLV21LCBM1HbBEH6tU+x3Vhftkd5a3tnTwJGpe0J74l4m59dc77Px8xh
         CEmv8RnY2Jf8w5FsXE0eNqgZvak/B6BycRkKS0ZQ73qdvvLqhkcHkON7IvemDlikW4SQ
         wxG2M/ArpyDxdc0ucZeRp936ShvbjuvLnR5OgB472wXydKaKDyhatxH+a1QldnboqXiq
         qWXKIGZ3PIb/tg5B87KQcmBnrKRRufo+gEIz86s65b0nVF4S27rkw1w9ZvpBySzzl+BG
         1Cn8F/k+dVWvVA7ErTyrz3KqUWjpJZDqIL0LWQm/AS1aw0lzAusDoWPyhLGCjLH+tBNx
         b2aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=VnzRg86SdMdpC2GL7NT6/231QACcVrP8rQ6QkpdG7R4=;
        b=J1RAL/7wN8mjh14fO975NL7JEooqBXHHcgVzn3EEy4c1gJ55ar0uuN2NcWBMH2cgcy
         2wdPvcYTaAf+Obwel5vNPKsWycbtH5l+KJVC8gv0bwpRVSGFktiCF2N1SAEUPRMMopNe
         YKCVAoAqkIzUmB7JdcGMI84SDWUFSCqCcbmTzih3h0jFrUcaKyx9wl6iHKNpitH8L20B
         VbUEU+t8NEaSG0LDGf4U/pXqx3LMqXzOwh1igFyRKAMfkW/RpahMHJWfTvGUFq5m7YDA
         xyS3/OzWGmCLycHlRmwLd7cPst4SbxCUM+o+lqmlmcq9gEPcIsP21UgegxUIhPrTyipt
         /ZuA==
X-Gm-Message-State: AEkoouslL/ant+O7hJSbTAj1Mncie3PedNiRGK87TXL1MaNQzgcbueWjHL0twrFoXInLunTGbH3K9AxaD+dNBQyU
X-Received: by 10.107.144.10 with SMTP id s10mr67200638iod.165.1470264717577;
 Wed, 03 Aug 2016 15:51:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.128.66 with HTTP; Wed, 3 Aug 2016 15:51:57 -0700 (PDT)
In-Reply-To: <bffbbd7b-3e1b-fa6d-ed53-b75a54fd6f69@alum.mit.edu>
References: <cover.1470259583.git.mhagger@alum.mit.edu> <7b0680ed7a10fc13acd8d7816a75ed05a5f9e28c.1470259583.git.mhagger@alum.mit.edu>
 <CAGZ79kbzB-bogaqco1+fbRuoQ-4a4GBwTKkuSNnpXUxTFaxcXw@mail.gmail.com> <bffbbd7b-3e1b-fa6d-ed53-b75a54fd6f69@alum.mit.edu>
From:	Stefan Beller <sbeller@google.com>
Date:	Wed, 3 Aug 2016 15:51:57 -0700
Message-ID: <CAGZ79kYs9dnRzyAV_MXXUDbRCLuxQeETHKRpVsczQMCMHkQUPw@mail.gmail.com>
Subject: Re: [PATCH 8/8] diff: improve positioning of add/delete blocks in diffs
To:	Michael Haggerty <mhagger@alum.mit.edu>
Cc:	"git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
	Jacob Keller <jacob.keller@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, Aug 3, 2016 at 3:41 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> On 08/04/2016 12:30 AM, Stefan Beller wrote:
>> On Wed, Aug 3, 2016 at 3:00 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>>
>>> +        return 10 * score - bonus;
>>
>> Would it make sense to define-ify the 10 as well
>> as this is the only hardcoded number in the
>> scoring function?
>
> I started answering this question by explaining why it is not important
> to *optimize* the number 10 (namely because scores are only ever
> compared against other scores, so an overall scaling factor makes no
> difference). The factor 10 only has to be large enough to provide enough
> dynamic range for the other (adjustable) parameters.

But it only scales the score, not the bonus. So another way to write it
would be

    score - bonus/10;

assuming the values of score and bonus are large enough.

In some prior conversation you said you take the indent and add an epsilon
for some special conditions to make one indent better than the other.

Epsilons are usually very small compared to the rest of the equation,
but if I look at the boni definitions ranging from -63..50 they are scaled up
so much that the bonus may become larger than '1' unit of 'score', i.e.
it is not an epsilon any more. Or to put it another way:
If we were to s/10/100/ the results would be worse.

Rather the 10 describes the ratio of "advanced magic" to pure indentation
based scoring in my understanding.

>
> But I think you are asking a simpler question: should we give this
> constant a name rather than hardcoding it? I don't see a strong reason
> for or against, so I'll give it a name in the next version, as you suggest.

Thanks,
Stefan

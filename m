Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 13DB1202A0
	for <e@80x24.org>; Thu, 26 Oct 2017 22:50:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932376AbdJZWuc (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Oct 2017 18:50:32 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:56842 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751639AbdJZWub (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Oct 2017 18:50:31 -0400
Received: by mail-pf0-f194.google.com with SMTP id b85so3530068pfj.13
        for <git@vger.kernel.org>; Thu, 26 Oct 2017 15:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xFa8ShvMRRy4bjk7dvhJyPWdS9IDk1IsZXd7SN/uy6E=;
        b=IBsu1+EYqlXn2npjLGjqMqxhFQlMAQf/CUsYfU7E4sksrupojAmudClpUhnYmZHmLV
         +L7NcUFdEpXsMAJoNFznGQy02Hzt/xqUkPN5qvpyJHFQ/xwipJN8VeWHikVVaU49WjVE
         CfA3UALJZKgsOKUxLT6IaOmKsOoeUFzQfDJlz8SoDjfBZZ8OSfw/ry3dD56moqhyJbZx
         fuhKer6nuLwoDPM91BaE0qhhVfaPwpHEX06CwQzOOC3IWHupEw7FyEBWGy4KpE2QAt+j
         d4jKyXEN5QKlpQ6GTjzL/sRA6xhcegoMxIApcnRkox0w8bzUDzQ2uVuOJ9OZlACeDYzu
         JeUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xFa8ShvMRRy4bjk7dvhJyPWdS9IDk1IsZXd7SN/uy6E=;
        b=HsGp84rpcsC0DagdmRmnjMgWk+ijTcApMVN01eH09bQIpAglwzBOcbH80kHYiZHzad
         iWJpYpAs+UaMcFzlmdXw5wVbEfHOCdzR95/gkBG6GEhw12+hpJ+lP/DFmCTgzMubI9Qb
         wy8jyxQcxKpUrlhyi/LCSVz6do1/EJjl4kmWtmYghL6ap03mi4MT/bE2Lnz3H1L+jhBk
         FMx4umLaTTTmuf9GsFV+ly+xjGveink/PSJXnDDd8IR058yLZ3M/SDikWEBnsxBD5NXV
         14ypyuxD16MtLwinvKzRuFO/k+g7GZD25dpux6yD2o73cq8eC4GzjVi9oo3vBzmuWMxU
         VU2w==
X-Gm-Message-State: AMCzsaVBpAnM/qZy/GNQSr6DcUSqg2aMjLK4eLuYqBmh6bcbZcwt49ne
        c5pDc+l+6dqI5uhMfQMm786wig==
X-Google-Smtp-Source: ABhQp+TrLAWPozWQmF1AuSoe3s17Jbli0ST1OFKiOX2jafzL/Znk0d/vSy8j+2O/op1LzBUfQAozNg==
X-Received: by 10.84.168.5 with SMTP id e5mr5571917plb.150.1509058231248;
        Thu, 26 Oct 2017 15:50:31 -0700 (PDT)
Received: from [172.22.44.87] ([103.233.242.9])
        by smtp.gmail.com with ESMTPSA id x4sm10665427pge.23.2017.10.26.15.50.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Oct 2017 15:50:30 -0700 (PDT)
Subject: Re: [PATCH v2] blame: prevent error if range ends past end of file
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git mailing list <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>, bturner@atlassian.com
References: <xmqqtvyme8pg.fsf@gitster.mtv.corp.google.com>
 <20171026070108.4185-1-istephens@atlassian.com>
 <CA+P7+xpk+9R9kMGNky4vTRpASf_nXM1xt0KHFjqwn8aB1NzDAQ@mail.gmail.com>
From:   Isabella Stephens <istephens@atlassian.com>
Message-ID: <f22b2cda-745b-ee00-2578-cf5cec13d050@atlassian.com>
Date:   Fri, 27 Oct 2017 09:50:26 +1100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <CA+P7+xpk+9R9kMGNky4vTRpASf_nXM1xt0KHFjqwn8aB1NzDAQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 26/10/17 7:48 pm, Jacob Keller wrote:
> On Thu, Oct 26, 2017 at 12:01 AM, Isabella Stephens
> <istephens@atlassian.com> wrote:
>> If the -L option is used to specify a line range in git blame, and the
>> end of the range is past the end of the file, at present git will fail
>> with a fatal error. This commit prevents such behaviour - instead the
>> blame is display for any existing lines within the specified range.
>>
>> Signed-off-by: Isabella Stephens <istephens@atlassian.com>
>> ---
> 
> I like this change. We might want to document L to indicate that an L
> that is outside the range of lines will show all lines that do match.
> 
> Maybe we also want it to only succeed if at least some lines are
> blamed? Could we make it so that it fails if no lines are within the
> range? (ie: the start point is too far in? or does it already do
> such?)
> 
> Thanks,
> Jake

Yep, that is exactly how it behaves now - if a range intersects the
file at all it will annotate the relevant lines, otherwise it will fail.

I'll add a clarification to the documentation in my next revision.
Thanks for reviewing!

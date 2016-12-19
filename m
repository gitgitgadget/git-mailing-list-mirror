Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 025361FF40
	for <e@80x24.org>; Mon, 19 Dec 2016 20:39:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754065AbcLSUid (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Dec 2016 15:38:33 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:33391 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753134AbcLSUib (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Dec 2016 15:38:31 -0500
Received: by mail-pg0-f65.google.com with SMTP id g1so7676902pgn.0
        for <git@vger.kernel.org>; Mon, 19 Dec 2016 12:38:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:in-reply-to:subject:references:message-id
         :content-transfer-encoding:mime-version:date:cc;
        bh=O+/K6Ku+cBbcwSpnl/5GqKCFHOufpIhqqOMHuE9x9Ow=;
        b=nzyX4fhDBirf1Tl+NiwxG8v4VTxrxyh7VGp83+hi+U6RybYz2kQCPqVosiqdzgcBG7
         H4aMOIrluzeBW2Q6G6TTBBL0Wor+4KmTwvjlJCD2FA2lq1mVvP+s08gyfgAY88H/WLYm
         5kZ7in5UEeP4ruj62dO0Ud0fIJf9jPRCGISy22cTpeQz5CO1IZv8inym8wRsWUmdAfBo
         gSxwLy1s4VCQivCBIU3WsOoiYxHNaQl4o4xSeE1qCXQ0ae4VTkSEzeDqDHpCoh/eZn2i
         yIV7GA0y2J4V1CZwEQ3WOjCQXgaLd/UZ6VadhPWM4yVpuwNs9J2C6ER3m2r/CnXQjhSZ
         28Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:in-reply-to:subject:references
         :message-id:content-transfer-encoding:mime-version:date:cc;
        bh=O+/K6Ku+cBbcwSpnl/5GqKCFHOufpIhqqOMHuE9x9Ow=;
        b=lIEM2zcwN3pRmOc2oGwQ89HbCPsCbcS8C4VNma5nZSnBmkbT0S2tXes6GvyxjqN8IF
         bsnOKdRrsJ7o2gocJbzHEoWy/8MRIXgPlvlMiRrJDuA5lV180QeK0/f83H2CQzUmEvhk
         zf3GtpfRE7fUC1LpLBgLuIV82AollIAbb8DrAlme7P2+xDe8wmSVi7QD8XiF0Qlx4YeD
         2bWvt5sqR6nYeXPe1Qqq9YBLp4TLMWfkbCgWK13Qn3ajNfwnP+dskrC/NUZQiO1oszzU
         kn6Grh+eFW4cJGgXp2n42rni6sxnIe4x4ph1SI02klZ70y2oQxpnTqTy1ZVv8yhbacXf
         fZPg==
X-Gm-Message-State: AKaTC02Ykul8ErrTp+ge6SkMTIZ/4tfGgy6Wz3O1GGHP6Qbo0+fV/aF+buER3a+7YAihGw==
X-Received: by 10.99.111.201 with SMTP id k192mr31817695pgc.176.1482179910692;
        Mon, 19 Dec 2016 12:38:30 -0800 (PST)
Received: from ?IPv6:2002:46b5:ad14::223:12ff:fe05:eebd? ([2002:46b5:ad14:0:223:12ff:fe05:eebd])
        by smtp.gmail.com with ESMTPSA id 189sm10084307pgd.48.2016.12.19.12.38.29
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 19 Dec 2016 12:38:30 -0800 (PST)
From:   "Kyle J. McKay" <mackyle@gmail.com>
To:     Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <20161219200259.nqqyvk6c72bcoaui@sigill.intra.peff.net>
Subject: Re: [PATCH] mailinfo.c: move side-effects outside of assert
References: <900a55073f78a9f19daca67e468d334@3c843fe6ba8f3c586a21345a2783aa0> <20161219200259.nqqyvk6c72bcoaui@sigill.intra.peff.net>
Message-Id: <A916CED6-C49D-41D8-A7EE-A5FEDA641F4A@gmail.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0 (Apple Message framework v936)
Date:   Mon, 19 Dec 2016 12:38:26 -0800
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git mailing list <git@vger.kernel.org>
X-Mauler: Craptastic (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Dec 19, 2016, at 12:03, Jeff King wrote:

> On Sat, Dec 17, 2016 at 11:54:18AM -0800, Kyle J. McKay wrote:
>
>> Since 6b4b013f18 (mailinfo: handle in-body header continuations,
>> 2016-09-20, v2.11.0) mailinfo.c has contained new code with an
>> assert of the form:
>>
>> 	assert(call_a_function(...))
>>
>> The function in question, check_header, has side effects.  This
>> means that when NDEBUG is defined during a release build the
>> function call is omitted entirely, the side effects do not
>> take place and tests (fortunately) start failing.
>>
>> Move the function call outside of the assert and assert on
>> the result of the function call instead so that the code
>> still works properly in a release build and passes the tests.
>>
>> Signed-off-by: Kyle J. McKay <mackyle@gmail.com>
>> ---
>>
>> Notes:
>>    Please include this PATCH in 2.11.x maint
>
> This is obviously an improvement, but it makes me wonder if we  
> should be
> doing:
>
>  if (!check_header(mi, &mi->inbody_header_accum, mi->s_hdr_data))
> 	die("BUG: some explanation of why this can never happen");
>
> which perhaps documents the intended assumptions more clearly. A  
> comment
> regarding the side effects might also be helpful.

I wondered exactly the same thing myself.  I was hoping Jonathan would  
pipe in here with some analysis about whether this is:

   a) a super paranoid, just-in-case, can't really ever fail because  
by the time we get to this code we've already effectively validated  
everything that could cause check_header to return false in this case

-or-

   b) Yeah, it could fail in the real world and it should "die" (and  
probably have a test added that triggers such death)

-or-

   c) Actually, if check_header does return false we can keep going  
without problem

-or-

   d) Actually, if check_header does return false we can keep going by  
making a minor change that should be in the patch

I assume that since Jonathan added the code he will just know the  
answer as to which one it is and I won't have to rely on the results  
of my imaginary analysis.  ;)

On Dec 19, 2016, at 09:45, Johannes Schindelin wrote:

> ACK. I noticed this problem (and fixed it independently as a part of a
> huge patch series I did not get around to submit yet) while trying  
> to get
> Git to build correctly with Visual C.

Does this mean that Dscho and I are the only ones who add -DNDEBUG for  
release builds?  Or are we just the only ones who actually run the  
test suite on such builds?

--Kyle

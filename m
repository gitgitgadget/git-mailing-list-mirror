Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD46F201A7
	for <e@80x24.org>; Mon, 15 May 2017 22:11:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751500AbdEOWLR (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 May 2017 18:11:17 -0400
Received: from mail-pg0-f53.google.com ([74.125.83.53]:34175 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751291AbdEOWLP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 May 2017 18:11:15 -0400
Received: by mail-pg0-f53.google.com with SMTP id u28so66416446pgn.1
        for <git@vger.kernel.org>; Mon, 15 May 2017 15:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=VMRXLhI+jwuj1ifxVRTFfCkDRw3mxKqLsYZUHqe4lVY=;
        b=lHKT2k3AKbqEjb2Ey6XmdwWzkahzwQUkTpI5LYeY4NIry4NACE6fMhO9Ms8e+1+OvS
         9olB216xw26UBuh1+Z4PJUAmOQqzM3DXil5IbC4XsChUJOxE9Jo5LTm/vN92aWwC4xel
         tapUOfPp1xS8yAYZBQNfgXZ7u6eVU5m5/FxYSYnlVoL0NnpLVK1SSL5Lak8iOAUkg2vl
         NGlMvclDXrlJuRJeY0R4pGXn5rEgMVLvv8XITJpNOEGxaJolOTwD5sc+RibPpVbqoMLR
         RQOP7A2qjCni4sbZk5HukJQ4HBz87zlGsTwmzM/mxR6o2ByWwXS9eG4/iwDKK5BrNFnJ
         ldOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=VMRXLhI+jwuj1ifxVRTFfCkDRw3mxKqLsYZUHqe4lVY=;
        b=Oz4u1duIHvhnIRMyWzzk+hP6wsrSb481m4e81gYhwwEZC3GTn/VuBX3bSV7ZQEwpJJ
         D1L2QOrra5hRPk47Dpi+50tS7IPKHVo/PRTuh40rnoXMDTCeh3DjwaZMX8Kdx0Oy2dga
         9dmOHYc9ZAU5Bsag1EfcoQAj0p2IY1rbINhcOmoZ2+AIIYUYRjFk62lbhB80cUnyFMNZ
         hCo6XK0mOCIkjP4BGfh+JS3g8agmUdGlBIGyyyox8ODxO8gLx4Pk/l7a/QDlJnfGXS6H
         fuo62o3Kmk3pxVE9Q2nukrLzQuPv9trosaBfX3OA/HC5hIfRfjYyI8eS88lU/xnCXziB
         BYDA==
X-Gm-Message-State: AODbwcA0twMI6jGJJCoiYIJRRPpQi6Exv11HLoUxRdikGSXlpBtvvkuN
        NXrU5dRx+oxSp4c4WPReWhVW3tgwxWroxfU=
X-Received: by 10.84.142.133 with SMTP id 5mr11448618plx.52.1494886274496;
 Mon, 15 May 2017 15:11:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.170.200 with HTTP; Mon, 15 May 2017 15:11:14 -0700 (PDT)
In-Reply-To: <847ecb20-ebbe-7f7a-e532-4e75e69c05c2@google.com>
References: <20170514040117.25865-1-sbeller@google.com> <20170514040117.25865-6-sbeller@google.com>
 <847ecb20-ebbe-7f7a-e532-4e75e69c05c2@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 15 May 2017 15:11:14 -0700
Message-ID: <CAGZ79kbyt_PsGGphWJbCs-4MqmGRh+mZaxdsNMg0iyK3P-MAJg@mail.gmail.com>
Subject: Re: [PATCH 05/19] diff.c: emit_line_0 can handle no color setting
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 15, 2017 at 11:31 AM, Jonathan Tan <jonathantanmy@google.com> wrote:
> On 05/13/2017 09:01 PM, Stefan Beller wrote:
>>
>> In a later patch, I want to propose an option to detect&color
>> moved lines in a diff, which cannot be done in a one-pass over
>> the diff. Instead we need to go over the whole diff twice,
>> because we cannot detect the first line of the two corresponding
>> lines (+ and -) that got moved.
>>
>> So to prepare the diff machinery for two pass algorithms
>> (i.e. buffer it all up and then operate on the result),
>> move all emissions to places, such that the only emitting
>> function is emit_line_0.
>>
>> In later patches we may pass lines that are not colored to
>> the central function emit_line_0, so we
>> need to emit the color only when it is non-NULL.
>
>
> The diff below seems to just make emit_line_0 allow NULL for set and reset,
> unlike what the commit message above describes. (And is that necessary?
> Couldn't the caller just pass "" if they don't want any setting and/or
> resetting?)
>

They could just give ""; but instead of having an empty system
call I thought about this short cut.

I'll reword the commit message.

Thanks,
Stefan

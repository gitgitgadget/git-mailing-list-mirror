Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F5871F404
	for <e@80x24.org>; Tue, 30 Jan 2018 23:41:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754027AbeA3XlD (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Jan 2018 18:41:03 -0500
Received: from mail-vk0-f65.google.com ([209.85.213.65]:44382 "EHLO
        mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752869AbeA3XlC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jan 2018 18:41:02 -0500
Received: by mail-vk0-f65.google.com with SMTP id q62so7936388vkb.11
        for <git@vger.kernel.org>; Tue, 30 Jan 2018 15:41:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GNIe+jbrKbLH60nSY4fFnKTSNd4aDHxZkT8i1l2uQ1Q=;
        b=mCv61hWXLK3OfjcV92DkN9E6rEf2/A/2fuBvcrivtHT2aR/tYUAfM9/5exVBKeksMx
         OqkbmxfL9XGEQpEAFK3h99Mnoj1kgwT3lbqooVc+QX6HqOAYDbaxrW/MZR57d3BZo9J4
         Z+CIWtcjINc94xRSLoupvdwUSoeemYF7O3hbl/ml37xA/fUuMEQV8xqDsll2bZRZviQy
         HFlgauT2szZWDwVWaMGgXO9PCNefJxXGrF+M4olUqfV9F6Kp+hrKOSlm+hM2P0iVvfh1
         c01WWyJRXLY7yKOxLH+q2N6BhVmJ/76P7Pmrn1iFmEsKpR6cPiYN0zdTA7Z2UlFR2sAf
         7vLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GNIe+jbrKbLH60nSY4fFnKTSNd4aDHxZkT8i1l2uQ1Q=;
        b=gKePm8BOAEl/GoA9SZNHsWk66opFxbcMC6Dmxtl5p5fy9ZcVByYY2zIZAQjBQUJXH8
         T2XXzQYHXy9RIk7ho2bgtjk03K9eL7+X2ewY3tEnrZ3R6voVMH4tj/rZXSMd83kMzuu5
         CAMJWPa4kaN7i+6PH8hXXuniAeu25friTBdSt0KUxVGtj3u7UrmyPyG2qw8HSbJn/RAO
         S9hezPHPdbNGCrnI5cZdDSdQh628k93eMRtsBWS2RGqMQK7w7E7c5XL3rroV7LNTWYx7
         wvISMBlew45WwZn/HmRoXcR0hxQk7fOyV+bh1WRxncjebbgvvFFp0JVwbgZOhom5r+Tf
         Bm9A==
X-Gm-Message-State: AKwxytcSaCrZIF9TbtPyycJuiGhpHJ/xBf+6gnrNsIExfZS077NTVta0
        ThdnnMrYDL1Kh9zF5K96Iejl3HdkssbvlvV2FwE=
X-Google-Smtp-Source: AH8x227xJRXEFVykhtjFn8sKNYZJsWIMkK05Fqlec25YIvtfkNKS8cRdoXE7s1vtZy2fZnESDrvnc3/oijCkWPWfnks=
X-Received: by 10.31.96.196 with SMTP id u187mr25431168vkb.75.1517355661233;
 Tue, 30 Jan 2018 15:41:01 -0800 (PST)
MIME-Version: 1.0
Received: by 10.176.8.83 with HTTP; Tue, 30 Jan 2018 15:41:00 -0800 (PST)
In-Reply-To: <20180130232533.25846-1-newren@gmail.com>
References: <20180130232533.25846-1-newren@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 30 Jan 2018 15:41:00 -0800
Message-ID: <CABPp-BHf9=oLGchdUiYKz-eHs7_4fOZhKS=Y7iAhDkKX7FXZ-A@mail.gmail.com>
Subject: Re: [PATCH v7 00/31] Add directory rename detection to git
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 30, 2018 at 3:25 PM, Elijah Newren <newren@gmail.com> wrote:
> This patchset introduces directory rename detection to merge-recursive.  =
See

And a meta question: Should I be trying to submit this feature some other w=
ay?

I've really appreciated all the reviews[1], and the testcases are
undoubtedly better because of them.  The code too, but the reviews
have focused almost exclusively on the testcases so far.  Is
merge-recursive just too hairy and my changes too large for folks to
stomach tackling?  Is there something different I could do?

I'm curious for any thoughts on the matter.

Thanks!
Elijah

[1] Especially Stefan who looked through all the patches, but also for
spot reviews from Junio, Johannes Schindelin, Johanness Sixt, Adam
Dinwoodie, and SZEDER G=C3=A1bor.  Also, a few interested comments from
Philip Oakley and Jacob Keller.

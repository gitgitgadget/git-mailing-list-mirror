Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 32F0D20756
	for <e@80x24.org>; Thu, 19 Jan 2017 11:19:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752334AbdASLTK (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Jan 2017 06:19:10 -0500
Received: from mail-wm0-f44.google.com ([74.125.82.44]:35313 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752220AbdASLS2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jan 2017 06:18:28 -0500
Received: by mail-wm0-f44.google.com with SMTP id r126so285033922wmr.0
        for <git@vger.kernel.org>; Thu, 19 Jan 2017 03:18:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=EXwxjHhf7yrxlTv0SYlN1VAPqRyNoRkyXqUtUQRkmjY=;
        b=NFk0idfD9R4EvHds4uk25ZulHjYR0fn4Xm6o8E2LGHxgI/8jJZA+jJdxJlMf9T0ETs
         x+9DoqusJn9AzWQ7ajuBIyQCwAyfc6vcAGsCSMj15ZO9O3ymbjyxlTPIhu7SsijFmU+3
         1MJBm6X2pWmCDk1sk+FWJU9YME8AuuGaaPh1hy97Vq60hzJ58DLwSEM/qcI9EHVsHm97
         clLGrMJzxSQ1bdSaebI8Z0moxURcEhBiikUJwUA6LkMHlAbOU/s3MbVujIKffygrOTCW
         Qe1HcyRqm82EAo14CXjwtUtBvcPxdTImqCkd7dbj8ektuHvIIK84a6Ka8MLrn+XivphK
         QWhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=EXwxjHhf7yrxlTv0SYlN1VAPqRyNoRkyXqUtUQRkmjY=;
        b=TLBOi1ZDAywB9FnnydqwztIkjwNUNW1OP71zBvg+Ei0JryFPdrbXlfrsV/8/TrZ81u
         KyIjyZQjBZ9w8GxONv+HcnB+8Sojo/2WHx8czLXtQmwnfmIIsGdzr69RE+FJ+2Ae5sGH
         ycy3I8CfWGg/mMkdd0DNp3xEXL/bGV+EVYWusyzgqOKiRcOj6XayyFFi9AvC4TDKgk8V
         vUjYHDxEmi5X5ykSvkE/BVcav8QCRaujW8tW/G6pNpr/Z8zqm+poWt08G54OQLMD2c6B
         5lVLQrWzflth+viNtUPzFV0AhybuTu5uk7l8XNMaehy2svqHRFIH2fb4tuYJzsRvXrzl
         Q5TA==
X-Gm-Message-State: AIkVDXKWd0udk+A+vlUU1nEGfUAo0XSEAX6Fr1mFEdUgViH6sr30qrX2aOBb/AwMBdcb6sH0slPqFQfG0R+Rsg==
X-Received: by 10.223.163.154 with SMTP id l26mr8361619wrb.35.1484824689843;
 Thu, 19 Jan 2017 03:18:09 -0800 (PST)
MIME-Version: 1.0
Received: by 10.28.74.209 with HTTP; Thu, 19 Jan 2017 03:18:09 -0800 (PST)
In-Reply-To: <20170113175258.e66taigy4wpokohk@sigill.intra.peff.net>
References: <CAEBDL5Uc39JagdmXUxfxh1TPSK3H5wxoTfjK-pfLRYjciBnHpA@mail.gmail.com>
 <1483825623.31837.9.camel@kaarsemaker.net> <20170108052619.4ucjamsqad4g5add@sigill.intra.peff.net>
 <CAEBDL5Vf=rvb4fZF87pNYci4sicmzhS_qPJYHHOGcnPTMBhhWg@mail.gmail.com> <20170113175258.e66taigy4wpokohk@sigill.intra.peff.net>
From:   John Szakmeister <john@szakmeister.net>
Date:   Thu, 19 Jan 2017 06:18:09 -0500
X-Google-Sender-Auth: qjn55LLaQtmcbcolwxCaUDEhN3I
Message-ID: <CAEBDL5XfZDipTNf73q1bNN+xatEvLD29uicSim-a7bqUV1Z=NQ@mail.gmail.com>
Subject: Re: [PATCH 0/6] loose-object fsck fixes/tightening
To:     Jeff King <peff@peff.net>
Cc:     Dennis Kaarsemaker <dennis@kaarsemaker.net>, git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 13, 2017 at 12:52 PM, Jeff King <peff@peff.net> wrote:
> On Fri, Jan 13, 2017 at 04:15:42AM -0500, John Szakmeister wrote:
>
>> > I did notice another interesting case when looking at this. Fsck ends up
>> > in fsck_loose(), which has the sha1 and path of the loose object. It
>> > passes the sha1 to fsck_sha1(), and ignores the path entirely!
>> >
>> > So if you have a duplicate copy of the object in a pack, we'd actually
>> > find and check the duplicate. This can happen, e.g., if you had a loose
>> > object and fetched a thin-pack which made a copy of the loose object to
>> > complete the pack).
>> >
>> > Probably fsck_loose() should be more picky about making sure we are
>> > reading the data from the loose version we found.
>>
>> Interesting find!  Thanks for the information Peff!
>
> So I figured I would knock this out as a fun morning exercise. But
> sheesh, it turned out to be a slog, because most of the functions rely
> on map_sha1_file() to convert the sha1 to an object path at the lowest
> level.

Yeah, I discovered the same thing when I took a look at it a week or so ago. :-(

> But I finally got something working, so here it is. I found another bug
> on the way, along with a few cleanups. And then I did the trailing
> garbage detection at the end, because by that point I knew right where
> it needed to go. :)

I don't know if my opinion counts for much, but the changes look good to me.

-John

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9BC5D202A0
	for <e@80x24.org>; Wed, 25 Oct 2017 11:13:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750921AbdJYLN2 (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Oct 2017 07:13:28 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:62161 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750788AbdJYLN0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Oct 2017 07:13:26 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20171025111325epoutp04897aff90e8839a487507ced6a820c922~wy9hWuW_k0517005170epoutp04Y;
        Wed, 25 Oct 2017 11:13:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20171025111325epoutp04897aff90e8839a487507ced6a820c922~wy9hWuW_k0517005170epoutp04Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1508930005;
        bh=eHI4YgOLYjGQv3+y2FwdbEGDfcmSiD2qB3F2zFCbeJ8=;
        h=Subject:To:Cc:From:Date:In-reply-to:References:From;
        b=UpN9IxtAZUExda+OxRFzC4hAD7XRKQ/7/3nTGDFT4WKxJeZqwXqyi8CIFVm93Hw0X
         aeI0KLmiONdiIVVDfLt991vuv6Y+1uygPvuI8W+npofV76+a2q2WlJqIe4U0dYdx83
         AgOO1admp66CGYdOqX9J0lKoCX1yO8pX8cAHOOws=
Received: from epsmges1p2.samsung.com (unknown [182.195.42.54]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20171025111324epcas1p23c44570bb7bdffe11c1c6f016ffb2c88~wy9gwU7-11418914189epcas1p22;
        Wed, 25 Oct 2017 11:13:24 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        D4.C8.04153.4D170F95; Wed, 25 Oct 2017 20:13:24 +0900 (KST)
Received: from epsmgms2p1new.samsung.com (unknown [182.195.42.142]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20171025111323epcas1p20b603bb34a54f00ff7815005aec2a805~wy9gC6qeR1419314193epcas1p2C;
        Wed, 25 Oct 2017 11:13:23 +0000 (GMT)
X-AuditID: b6c32a36-325ff70000001039-92-59f071d4600d
Received: from epmmp1.local.host ( [203.254.227.16]) by
        epsmgms2p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        10.C9.04095.3D170F95; Wed, 25 Oct 2017 20:13:23 +0900 (KST)
MIME-version: 1.0
Content-type: text/plain; charset="utf-8"
Received: from [106.109.129.81] by mmp1.samsung.com (Oracle Communications
        Messaging Server 7.0.5.31.0 64bit (built May  5 2014)) with ESMTPA id
        <0OYD003ARLU9YP40@mmp1.samsung.com>; Wed, 25 Oct 2017 20:13:23 +0900 (KST)
Subject: Re: [PATCH] merge-recursive: check GIT_MERGE_VERBOSITY only once
To:     Jeff King <peff@peff.net>,
        =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Stefan Beller <sbeller@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        vmiklos@frugalware.org, Junio C Hamano <gitster@pobox.com>
From:   Andrey Okoshkin <a.okoshkin@samsung.com>
Organization: Samsung RnD Institute Russia
Message-id: <c7b82a8b-a133-6310-22d1-428dbf483a24@samsung.com>
Date:   Wed, 25 Oct 2017 14:13:20 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.4.0
In-reply-to: <20171024195221.gqgtibwjaztgeel6@sigill.intra.peff.net>
Content-language: en-GB
Content-transfer-encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKKsWRmVeSWpSXmKPExsWy7bCmnu6Vwg+RBo1bZC26rnQzWTT0XmG2
        +Pumi9HiR0sPs8Xmze0sFmfeNDJaHGn/zOTA7vGkuYfFY+esu+weCzaVejzr3cPocfGSssfi
        B14enzfJBbBHcdmkpOZklqUW6dslcGW8bDzOXrBMqOL/HLMGxtd8XYycHBICJhJ9W96wdDFy
        cQgJ7GCUeNw8jQ3C+c4osfLHLyaYqp7m+YwQid2MEue/zQFL8AoISvyYfI8FxGYW0JR48WUS
        1Kj7jBLrPzcwgiSEBTwllv44zQxiiwiESyw/epkdpIhZYA+jxNpT59hBEmwCehLnf00As/kF
        tCQu/5jHDLHBTuJQ1w0wm0VAVWLN139sILaoQITE8cPLwRZwCrhIzFg3hw3iCnGJY/dvMkLY
        8hIHrzwHu0hC4DWbxLPeE0BFHECOi0TbR3eI14QlXh3fwg4Rlpa4dNQWIlwv0drxhA2itYNR
        4vOspewQCXuJLV3boXbxSbz72sMK0csr0dEmBFHiITHh6UFoyDlKHFlzHqxcSGAhs8ThOfET
        GOVnIYXdLKSwm4Xkg1lIPljAyLKKUSy1oDg3PbXYsMBIrzgxt7g0L10vOT93EyM48WiZ7WBc
        dM7nEKMAB6MSD6/A9PeRQqyJZcWVuYcYJTiYlUR4F2d/iBTiTUmsrEotyo8vKs1JLT7EKM3B
        oiTOK7r+WoSQQHpiSWp2ampBahFMlomDU6qBUfnH3w1KAqdXXgiZWDp79bMA2bILl5g61JIX
        T/apZDGR4k5LUtlZVmB5k/NImp+ji5Pu/vCt+ce08vlaD8fZTmwvs/6g8CrFpsqnSeVcyp+2
        l2FaWlMa95cX7TRYz2+qtl/EmuNFxHS+2fzf+05FHeLZtXlB5Iezuevu3iys9PrXdliDXcpG
        iaU4I9FQi7moOBEA2yKoTTgDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrLLMWRmVeSWpSXmKPExsVy+t9jAd3LhR8iDRYf0bHoutLNZNHQe4XZ
        4u+bLkaLHy09zBabN7ezWJx508hocaT9M5MDu8eT5h4Wj52z7rJ7LNhU6vGsdw+jx8VLyh6L
        H3h5fN4kF8AexWWTkpqTWZZapG+XwJXxsvE4e8EyoYr/c8waGF/zdTFyckgImEj0NM9n7GLk
        4hAS2MkocfzgCmaQBK+AoMSPyfdYuhg5OJgF1CWmTMmFqHnIKLH4/yc2kBphAU+JpT9Og9WL
        CIRLzHy3mQWkiFlgH6PEiV9/GEESQgKLmSXOLbYHsdkE9CTO/5rADmLzC2hJXP4xD2qZncSh
        rhtgNouAqsSar//AFogKREg8b37PCmJzCrhIzFg3ByzOLCAucez+TUYIW17i4JXnLBMYBWch
        uXsWwt2zkHTMQtKxgJFlFaNkakFxbnpusVGBYV5quV5xYm5xaV66XnJ+7iZGYKRsO6zVt4Px
        /pL4Q4wCHIxKPLwZM99HCrEmlhVX5h5ilOBgVhLhXZz9IVKINyWxsiq1KD++qDQntfgQozQH
        i5I47+28Y5FCAumJJanZqakFqUUwWSYOTqkGxqSZrxwFHd0ffXiwqmer1dNCjmbXbQXJUvWB
        +zgf+C1bwvu8fMbHxOtHPN/IhISmmcSV+534JyEv88g271Mkl9SLk2yCpWs5HH5eaGTif21Q
        w53htb52idy1xs2LfZ27ni+YJFShpcPyrFtQ7hnHHVHDyw9fS51I+zMz56+pS9f6PTpfat6u
        U2Ipzkg01GIuKk4EAN7xwOCQAgAA
X-CMS-MailID: 20171025111323epcas1p20b603bb34a54f00ff7815005aec2a805
X-Msg-Generator: CA
CMS-TYPE: 101P
X-CMS-RootMailID: 20171024152727epcas2p4fb7dcf147e44aadf7733098151d469a5
X-RootMTR: 20171024152727epcas2p4fb7dcf147e44aadf7733098151d469a5
References: <CGME20171024152727epcas2p4fb7dcf147e44aadf7733098151d469a5@epcas2p4.samsung.com>
        <3aed764b-388c-d163-08fc-32b294c6b9d3@samsung.com>
        <CAGZ79kaSZG9WriqX0SLbTnEDRr-4YdFRuK17+9wnxyrftfnMmg@mail.gmail.com>
        <CAPig+cRTL2amjsgdp1=T3GMZLa=favugOfnQw9XjWzC+U=v5Sw@mail.gmail.com>
        <CAN0heSp7b_6n3y=s4++oWhkPUuM=s9L7LWVx5vn8o=5aH6DKKw@mail.gmail.com>
        <20171024195221.gqgtibwjaztgeel6@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


24.10.2017 22:52, Jeff King wrote:
> On Tue, Oct 24, 2017 at 07:11:24PM +0200, Martin Ågren wrote:
> 
>> On 24 October 2017 at 18:45, Eric Sunshine <sunshine@sunshineco.com> wrote:
>>> On Tue, Oct 24, 2017 at 12:28 PM, Stefan Beller <sbeller@google.com> wrote:
>>>> On Tue, Oct 24, 2017 at 8:27 AM, Andrey Okoshkin <a.okoshkin@samsung.com> wrote:
>>>>> Add check of 'GIT_MERGE_VERBOSITY' environment variable only once in
>>>>> init_merge_options().
>>>>> Consequential call of getenv() may return NULL pointer and strtol() crashes.
>>>>> However the stored pointer to the obtained getenv() result may be invalidated
>>>>> by some other getenv() call from another thread as getenv() is not thread-safe.
>>
>> I'm having trouble wrapping my head around this. Under which
>> circumstances could the second call in the current code return NULL, but
>> the code after your patch behave in a well-defined (and correct) way?
> 
> Yeah, it's not at all clear to me this is solving a real problem. I know
> Andrey mentioned playing around with fault injection in an earlier
> thread, so I'm wondering if there is an artificial fault being injected
> into the second getenv() call. Which does not seem like something that
> should be possible in the real world.
> 
> I definitely agree with the sentiment that as few things as possible
> should happen between calling getenv() and using its result. I've seen
> real bugs there from unexpected invalidation of the static buffer.
> 
> -Peff

Thanks for your comments.

Jeff is right: there were some artificial fault injections imitating valid failures
of different functions (syscalls, libc and so on).
And yes - in the real life there is no problems with current code as there are no other
threads running.
However it's not a good practice to double call getenv() with the same argument:
* Code readability.
* Still no guaranty that the second call will be valid: some linked library may be
compromised or LD_PRELOADed with the aim to create a race with getenv(). I believe
there is no profit doing it here but it's just an explanation.

In my opinion, here it's ok to save the pointer returned from the single getnev() call
doing as few actions as possible between getenv() and strtol() calls.
I'll change the patch.

-- 
Best regards,
Andrey Okoshkin

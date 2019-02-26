Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C6DB620248
	for <e@80x24.org>; Tue, 26 Feb 2019 09:12:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbfBZJMR (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Feb 2019 04:12:17 -0500
Received: from mail-ed1-f54.google.com ([209.85.208.54]:33376 "EHLO
        mail-ed1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbfBZJMR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Feb 2019 04:12:17 -0500
Received: by mail-ed1-f54.google.com with SMTP id c55so10100148edb.0
        for <git@vger.kernel.org>; Tue, 26 Feb 2019 01:12:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=WyBKDR6ByOS5ezVySjs0JUMbdCurxhYUvBW0HLfKleM=;
        b=ewqBph/BlufeHsbOFpxA5f+WFWZqEP/Qi/Q6yoHaiZURj1SdTuFGjFasLS5kEc0poH
         6iYIgHr6YAfGan02GVT+oRgpWexs4MapkxO7U6njH+knhrlzJipey3Ctc+KIDXYycoAc
         FpmFNGaFtAtlDZ/3IiULrzHRsGFqn0XSGNXUsOBj/7S2PQWR6OUxFeSOKj+V4OR+hc6t
         NzCK9KJq8y5EuC1e9Inir7WPt2tZ/H80jyJHTr13srB4PuB9IDwVGKc6DzU8pWqwwA48
         aiVfov47cqKwMhxATCQlDWTOZfevMuxnV0krB/quYSPhTpsfdC9ovwx5nFfBxb3G7yu9
         t1HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=WyBKDR6ByOS5ezVySjs0JUMbdCurxhYUvBW0HLfKleM=;
        b=Ap0UEKemeC0/h+DFxrpYjgK4EuoWEa+7lH4vyBBbCB+ETlwZbaap7bPdSAOBNVNpJE
         HZ5cAGd5PiHPdmrh0Jzdp9all4k1AMQ0fBx5cweuKFRcHnIxG+/myW98yfcLA5ZJ4m5h
         A+qVfrmMxioh2/9+MoElc4fOn9z1KE6+AlqGlCg5krff8p/UDvhSZLZA0fQkLhgi0A8o
         sYX0evv8PtJ20AFCUds9bANuOmywpz3+h03UlT3Cep0h9/qQ0LV4luclvI4XCglcvrub
         GPGWWx/q56eYOsUGpDGxMVst3zbemfzhhWZztRPQrVAL1mONkmfy7hiFztAWQVvRktkE
         OAPQ==
X-Gm-Message-State: AHQUAuZxiXJX0/IRgZM6/sD2MAmw4LHFfJux0P2XU3Z4ywv1ZH52Yq6s
        JlvKW0NJmYs8eNP58Pm44iA=
X-Google-Smtp-Source: AHgI3IYHr73CDE4l+Wzj6DGXCF9FeOYdhVRj6r9hnPXss5/gSdaeoqPQpbaR295vxPlZ+AkYJlzyxw==
X-Received: by 2002:a50:9235:: with SMTP id i50mr3373521eda.20.1551172335072;
        Tue, 26 Feb 2019 01:12:15 -0800 (PST)
Received: from evledraar ([5.57.21.48])
        by smtp.gmail.com with ESMTPSA id 31sm676220edr.7.2019.02.26.01.12.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Feb 2019 01:12:13 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>
Subject: Re: [WIP 0/7] CDN offloading of fetch response
References: <cover.1550963965.git.jonathantanmy@google.com>
        <CAP8UFD19521P=-R1XEdRK++HPatt3BJaxWPvpPRo8LHr3eisjA@mail.gmail.com>
        <20190225234528.GD16965@google.com>
        <CAP8UFD1tKNFO9wU8CbgNnSnQyvHYPsZMk1Bit2y1jxH4vk62qQ@mail.gmail.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <CAP8UFD1tKNFO9wU8CbgNnSnQyvHYPsZMk1Bit2y1jxH4vk62qQ@mail.gmail.com>
Date:   Tue, 26 Feb 2019 10:12:13 +0100
Message-ID: <87zhqivrpu.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Feb 26 2019, Christian Couder wrote:

> Hi,
>
> On Tue, Feb 26, 2019 at 12:45 AM Jonathan Nieder <jrnieder@gmail.com> wrote:
>>
>> Christian Couder wrote:
>> > On Sun, Feb 24, 2019 at 12:39 AM Jonathan Tan <jonathantanmy@google.com> wrote:
>>
>> > Especially I'd like to know what should the client do if they find out
>> > that for example a repo that contains a lot of large files is
>> > configured so that the large files should be fetched from a CDN that
>> > the client cannot use? Is the client forced to find or setup another
>> > repo configured differently if the client still wants to use CDN
>> > offloading?
>>
>> The example from that message:
>>
>>   For example I think the Great Firewall of China lets people in China
>>   use GitHub.com but not Google.com. So if people start configuring
>>   their repos on GitHub so that they send packs that contain Google.com
>>   CDN URLs (or actually anything that the Firewall blocks), it might
>>   create many problems for users in China if they don't have a way to
>>   opt out of receiving packs with those kind of URLs.
>>
>> But the same thing can happen with redirects, with embedded assets in
>> web pages, and so on.
>
> I don't think it's the same situation, because the CDN offloading is
> likely to be used for large objects that some hosting sites like
> GitHub, GitLab and BitBucket might not be ok to have them store for
> free on their machines. (I think the current limitations are around
> 10GB or 20GB, everything included, for each user.)
>
> So it's likely that users will want a way to host on such sites
> incomplete repos using CDN offloading to a CDN on another site. And
> then if the CDN is not accessible for some reason, things will
> completely break when users will clone.
>
> You could say that it's the same issue as when a video is not
> available on a web page, but the web browser can still render the page
> when a video is not available. So I don't think it's the same kind of
> issue.
>
> And by the way that's a reason why I think it's important to think
> about this in relation to promisor/partial clone remotes. Because with
> them it's less of a big deal if the CDN is unavailable, temporarily or
> not, for some reason.

I think all of that's correct. E.g. you can imagine a CDN where the CDN
serves literally one blob (not a pack), and the server the rest of the
trees/commits/blobs.

But for the purposes of reviewing this I think it's better to say that
we're going to have a limited initial introduction of CDN where those
more complex cases don't need to be handled.

That can always be added later, as far as I can tell from the protocol
alteration in the RFC nothing's closing the door on that, we could
always add another capability / protocol extension.

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3398C433EF
	for <git@archiver.kernel.org>; Wed, 16 Feb 2022 21:07:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231319AbiBPVHe (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Feb 2022 16:07:34 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbiBPVHa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Feb 2022 16:07:30 -0500
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE994204DBA
        for <git@vger.kernel.org>; Wed, 16 Feb 2022 13:07:17 -0800 (PST)
Received: by mail-qv1-xf34.google.com with SMTP id d3so4384897qvb.5
        for <git@vger.kernel.org>; Wed, 16 Feb 2022 13:07:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version;
        bh=vvhmeou1s1JjfPbh891WgNStCKzBzPayxEbKzzUAiBc=;
        b=Nu2x6IkR9FxVHjwLDZqZhS/11c2iw/VHWltxassecaCjRLiSSXsGN2ecAphDHbfLp7
         WA7de0VA2NPuCpZhHmWI5QnFNRDMAxzO89YHyUH7SpCD99ss4JZQny1ZqhMs6lHRLir2
         sJ1V3397ZwHTlGmYUeXDUNtoiiSSo/4oPMmuhqajAEfp4xJSHLCLCT9gHh05Y3EQ7LU2
         fD5jUkgRYTlFsu3P0xlzh/J7vLpw0xRfD7iwentIOhuDODPUyXBGwmS4/xRx81iEwDS7
         yipzPjMoyvM78zs78TSYFeiRul0Uitk3h8Ecm6srVvMz91Ykvcx2axdB8tcodnkfjehk
         xjAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version;
        bh=vvhmeou1s1JjfPbh891WgNStCKzBzPayxEbKzzUAiBc=;
        b=Q59zvIhFSHUDKlcm+KAOw8IavgCaKKFXyoPlaEBJkxmcCDTvDE7d+etqdJ9zaiQwOK
         t5bQtJahSxQCid/GFL3ilX+xKRc4IZXfPzkVtpMbZfLAoN/+i45ldNHqVrXb53rl4VAI
         w3jwzZAeqJ8ugeV6mdicYjAkDKsTAojYhlIAJla1r32xsREKtLea7SLS6NQrbb2QlDsD
         k4xfV10YQyt0FkTDAQLvTrj/xLTNQ7oU0eWNCoEk+MUuRGysuYeE+Efr6iKGlOlicUzI
         12irFDTcvbf0Su8wD+/cCXtzkiKx6IXU2cEfjRe5Qw80ddr1X6X/uAFdcboRQY9f2nma
         5D0w==
X-Gm-Message-State: AOAM532R7x2Rce30Jq1wMHGmGF5hqgyplogPx+Wbs7JvwMo+J3jokwUm
        4Zpa/Dn/qQjKi+mtRyZ7Q8w=
X-Google-Smtp-Source: ABdhPJxz4LDnagBOxgg6ApvFaKU9dnrSLJ03fC8SsvBhMXamK05IdICx5b4F+0FMMp71O9g+WN8ATQ==
X-Received: by 2002:ac8:1419:0:b0:2d8:a3b2:7375 with SMTP id k25-20020ac81419000000b002d8a3b27375mr3434590qtj.420.1645045636787;
        Wed, 16 Feb 2022 13:07:16 -0800 (PST)
Received: from [10.37.129.2] ([2600:1001:b127:f167:6c0a:18db:208c:3715])
        by smtp.gmail.com with ESMTPSA id 17sm998083qka.119.2022.02.16.13.07.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Feb 2022 13:07:16 -0800 (PST)
From:   John Cai <johncai86@gmail.com>
To:     Robert Coup <robert.coup@koordinates.com>
Cc:     John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v2 0/4] [RFC] repack: add --filter=
Date:   Wed, 16 Feb 2022 16:07:14 -0500
X-Mailer: MailMate (1.14r5852)
Message-ID: <CB2ACEF7-76A9-4253-AD43-7BC842F9576D@gmail.com>
In-Reply-To: <CAFLLRpJ1aDyLb4qAoQwYDyGdP1_PH8kzLAQCKJpQwiYiapZ5Aw@mail.gmail.com>
References: <pull.1206.git.git.1643248180.gitgitgadget@gmail.com>
 <pull.1206.v2.git.git.1644372606.gitgitgadget@gmail.com>
 <CAFLLRpJ1aDyLb4qAoQwYDyGdP1_PH8kzLAQCKJpQwiYiapZ5Aw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Rob,

glad these two efforts dovetail nicely!

On 16 Feb 2022, at 10:39, Robert Coup wrote:

> Hi John,
>
> On Wed, 9 Feb 2022 at 02:41, John Cai via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>>
>> This patch series makes partial clone more useful by making it possible to
>> run repack to remove objects from a repository (replacing it with promisor
>> objects). This is useful when we want to offload large blobs from a git
>> server onto another git server, or even use an http server through a remote
>> helper.
>>
>> In [A], a --refilter option on fetch and fetch-pack is being discussed where
>> either a less restrictive or more restrictive filter can be used. In the
>> more restrictive case, the objects that already exist will not be deleted.
>> But, one can imagine that users might want the ability to delete objects
>> when they apply a more restrictive filter in order to save space, and this
>> patch series would also allow that.
>
> This all makes sense to me, and the implementation is remarkably short -
> gluing together capabilities that are already there, and writing tests.
>
> *But*, running `repack --filter` drops objects from the object db.
> That seems like
> a capability Git shouldn't idly expose without people understanding the
> consequences - mostly that they really have another copy elsewhere or they
> will lose data, and it won't necessarily be obvious for a long time. Otherwise
> it is a footgun.

Yes, great point. I think there was concern from Stolee around this as well.
>
> I don't know whether that is just around naming (--delete-filter /
> --drop-filter /
> --expire-filter ?), and/or making the documentation very explicit that
> this isn't so
> much "omitting certain objects from a packfile" as irretrievably
> deleting objects.

Yeah, making the name very clear (I kind of like --delete-filter) would certainly help.
Also, to have more protection we can either

1. add a config value that needs to be set to true for repack to remove
objects (repack.allowDestroyFilter).

2. --filter is dry-run by default and prints out objects that would have been removed,
and it has to be combined with another flag --destroy in order for it to actually remove
objects from the odb.

>
> Rob :)

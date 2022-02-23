Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BF03C433EF
	for <git@archiver.kernel.org>; Wed, 23 Feb 2022 20:04:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244599AbiBWUEw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Feb 2022 15:04:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233174AbiBWUEv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Feb 2022 15:04:51 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FFA43EA99
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 12:04:23 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id h15so28948896edv.7
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 12:04:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J0bsw5JyHVcTPx63/TRUhGLXunYHISwZi5suSnUAdy0=;
        b=WNv7BvKDrHgHrPMlrsTpr2bauLUeRcjUVo4XvYL/nAzv3qT6lduaf/qTJ5ONfqpuIW
         6pV9TpgH2Nc6wGxIXXs2arsBlXwgj5abYINmFA0BUvQyc4u/0RvviuQkE14RmSjx6c5U
         8HgeYzswNBnR3ogrs+ais/K5VNn2JYCjTceNQ1yM9/fXuNXr14Ujk2Gx6FaaxaiivRaT
         3zbbAErtIaccZrLBj6GKRP30s2vN3hz2VwCcY7J4C8Ivj/xbRURuGbKrGJlMaDpnYZpi
         MXpzH22oITm0sou60IMAl2XO/61XTYFZcBBTeOWiHguTdOpVzJ91Lyst1puyQFguYZrF
         2y4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J0bsw5JyHVcTPx63/TRUhGLXunYHISwZi5suSnUAdy0=;
        b=lrB3IrdyTa1fMPxGh3pPmxtGeMUYkIuy++4oyqENURp+Jk7nf4P06D5k3/INO6VUKM
         9sI3DdqOIgHvlzB2iGW3J213wzEvWUNn+JQMxSqLtq3Qe5HpUjORarYsucag/Vx0TAF+
         1uGEENHN+Z3NAlJxqs9CxCJWHNNqAr/e6/fCCov88ZyGHog3My91ceiDINGwUeJjIpeL
         CWvk9gnE2NX9Rvj2EzioWotyKIYqSMJp/oQXs11ZYL0k3vSKOgB6x3tcwbz4jCLSxj6F
         uYJF7Ti3bmWp2TEJqdaocJrJmPAdmmjKSO+ocOA06WnqPOTejmD6iyyiRVPwmG1J+DzW
         27nw==
X-Gm-Message-State: AOAM531ucKmAWgDYi+R+C9wRPOXKxVc9dC0NU+v2sTtgjgpBBVSg4/rG
        /qgw6Qhf/Ijtv26DNSe3xRfLzwkc467fCa6mPHaGS+4Vqc8sDbdD
X-Google-Smtp-Source: ABdhPJw5UdnGUnKbWmCh4ShrsccyzqXZdBcw1FqufX8a85bDAA+zfVbmdvrYVKe9kZGIGS2I0/3AuAo97eOZkNgz9hM=
X-Received: by 2002:a50:9eeb:0:b0:407:47ba:9a8e with SMTP id
 a98-20020a509eeb000000b0040747ba9a8emr1025257edf.225.1645646661893; Wed, 23
 Feb 2022 12:04:21 -0800 (PST)
MIME-Version: 1.0
References: <20220222114313.14921-1-shivam828787@gmail.com>
 <20220223115347.3083-1-shivam828787@gmail.com> <CAC316V57tHux-+MWMJuP5wNtwYrc2AinZj+ffnoyy-aWQWDukg@mail.gmail.com>
 <CAJyCBOTiWxAgkZPB6M5jPw=t=32zrnNH5tfnOc9Kdj9mKayrSA@mail.gmail.com> <YhZ2Zpl3XGkTKxuI@nand.local>
In-Reply-To: <YhZ2Zpl3XGkTKxuI@nand.local>
From:   Shubham Mishra <shivam828787@gmail.com>
Date:   Thu, 24 Feb 2022 01:34:10 +0530
Message-ID: <CAC316V51meeyvY=xU=a+aQ_K=m0ns=wJdqYKRDWOUmYrXX+B7w@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] avoid pipes with Git on LHS
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks to both of you, your responded were really insightful.

> The range-diff you posted is empty and doesn't look quite right to me...
> when I applied both versions of your patches locally and generated a
> range-diff myself, I got the expected (non-empty) results.

This is a new command for me, I am looking on the web about range-diff
to know what I did wrong :)

Thanks,
Shubham

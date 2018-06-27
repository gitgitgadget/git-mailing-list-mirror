Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B20D1F516
	for <e@80x24.org>; Wed, 27 Jun 2018 20:59:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934504AbeF0U73 (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Jun 2018 16:59:29 -0400
Received: from mail-yw0-f181.google.com ([209.85.161.181]:47014 "EHLO
        mail-yw0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933133AbeF0U71 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jun 2018 16:59:27 -0400
Received: by mail-yw0-f181.google.com with SMTP id g123-v6so1192467ywf.13
        for <git@vger.kernel.org>; Wed, 27 Jun 2018 13:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LGmjKARWD/ILXphjIxuCeJIIbYhz+SEGSqYyegKQu+k=;
        b=V/9aFtnRlytwWMBkH5m62oHKAGQuchZxxow00uS6YYs5jyzfV3AFKeJNI23ektxY6a
         08wyfoK2uRzmYlwQRRAX4NETrvVkdC+8j/UNVAWDf66tNO4BgmvP+Zt84kJTl8ju9jEE
         mjUyo2+uzGCi53yOut6ZNc+6+ZXRlIDT0zEaCG/UvA06/TZ3yuJBZ49SpYG5rIWm385W
         WhhO7d9v1bPj7oB76F8iN3IuMwbGqAjJJ2A3qAGbEim78DZWWSaAp5fijg37aaEyN7dv
         +dpeglZo9oOyUBCgIKWThZQOXVwVFAnH95iN/EtjaU5QViOV4Whng6XNwxfJypX08Emh
         vvRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LGmjKARWD/ILXphjIxuCeJIIbYhz+SEGSqYyegKQu+k=;
        b=GOmO9tvHQOyk6vsHlb1QMRG6Ri9rfKLMJsHcOsxLKHLvreXlHVIEGCvFnmdcrXuTvx
         vW/r45ziwFRlgGx5mNjYj9lR023LGk0odBPihpFsJCs9+JrX5gpDSDzDv+wxcAuGle2O
         LFYNqdyWSJEfxiM9X8Z6FsVEq2N6vXSE+zHzZ7ZIT5F36Gdy1AxM++9fJPvdaNsRTD4y
         9zNyAUQw0f5lpks0505wDStCByqGUeKZNd0tq2izgbY6TGBlv0Vi6Wgq1PmzB84HjiXP
         V0SwMdvjBzKjfdZ4tmtFyJOogXviNqzqlVe7lHhx1kBp7T1mkSEyvZ7YGiAT0g6U37D1
         UWDg==
X-Gm-Message-State: APt69E2oNv3ogPicTLWABZ4xqoPDg5dOhYEygJzCHdAgtJ29/3j+5BWX
        fYlcpSXulA0FRICzE2I1oudry+Q2ISYVUkYOXTzKf2Xn
X-Google-Smtp-Source: AAOMgpdwTkFlEyMxOpNhfrzonDC8h253HxMA9toY+JGFsYxUc27KW1mqKkMC4zkCGidiMkV4DKreHZorM3Zd3IvvBI0=
X-Received: by 2002:a0d:f442:: with SMTP id d63-v6mr3662073ywf.238.1530133166493;
 Wed, 27 Jun 2018 13:59:26 -0700 (PDT)
MIME-Version: 1.0
References: <20180625185332.164142-1-bmwill@google.com> <20180626205438.110764-1-bmwill@google.com>
 <20180626205438.110764-3-bmwill@google.com> <xmqqsh59i6jx.fsf@gitster-ct.c.googlers.com>
 <20180627180557.GG19910@google.com> <xmqq7emkf4da.fsf@gitster-ct.c.googlers.com>
 <20180627204630.GK19910@google.com>
In-Reply-To: <20180627204630.GK19910@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 27 Jun 2018 13:59:15 -0700
Message-ID: <CAGZ79kbsgnSK3Lqr9waqD+RdVKntbf5G77-eQv0NM-LPTNeFvg@mail.gmail.com>
Subject: Re: [PATCH v5 2/8] upload-pack: implement ref-in-want
To:     Brandon Williams <bmwill@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Yeah after thinking more about this

I wonder if we have some mental model that we want to teach to the users?
What is the fetch command (using the ref-in-want capability) supposed to do?
* update to the latest state observed by the latest remote talked to?
* update to some approximate state that is converged from multiple
  remotes?
* update to a state that the first remote had, that we talked to

Having such a model would make it easier for me to follow this discussion.

> I agree, we should have the client
> fail out and require that the server MUST not send additional refs.

This is reasoned for by the way we evolve the client, not some state
the user expects to see short or longterm?

> This can of course be loosened through a capability if we want to do
> something else in the future.  Thanks for sanity checking me :)

ok, that is a sensible way to go forward.

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71B6CC4338F
	for <git@archiver.kernel.org>; Tue, 27 Jul 2021 00:59:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 468AD60F41
	for <git@archiver.kernel.org>; Tue, 27 Jul 2021 00:59:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233821AbhG0AT3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Jul 2021 20:19:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbhG0AT2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jul 2021 20:19:28 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B1BCC061757
        for <git@vger.kernel.org>; Mon, 26 Jul 2021 17:59:55 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id l6so11144595edc.5
        for <git@vger.kernel.org>; Mon, 26 Jul 2021 17:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=unBrE6puyim8dfCJdiHpzQThxdowVZmz4X26MxftKgs=;
        b=BI1+jLMZiR6/FQZKougUAZARX1A08Q1bcCS7a0pNsywFR8Dk66vTukgfCXWKpwNPEp
         FBdhEWHT6Ic48k6AvjIcnhuO8xExJ4ep+kHjxfQJ0FRZ3m6w4dZa4sGdI+u6WifeTV8O
         JKmMXtVhvt7mnGaX1s8D7oVXP1fdxgyF4ou9zFfUpoKsd5isMbcFofG/sRZUh2VpFm0r
         5V9Ao/YZPvyIppJeGcG2Mk382PXQ/A94c1Pr7YsZZIBBE/RoRZSieP+djnSHSgkU6AVE
         VEeQBRIe/6E6Pm3uIWloKZpts9LbCYTS1KFDgb47hXrtwgfPuCWqUvyNgfLUGiIf4O9e
         FwRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=unBrE6puyim8dfCJdiHpzQThxdowVZmz4X26MxftKgs=;
        b=MUFYXGFDElpr5ItgDVS7vSMFq1R8LNFTaSgKFKDYK1QRt9Bj9aG9X/WzWdajmEzmmP
         NIeIXkD8BAiFIsjj1hX+PvsliEpfEUNT55zjN2A83fnPku40jFtjpyZhUONMd+FDU1FA
         i9JuWI5/RA7Z6DasjUG5XZ8ksVBvso/x0Py3JFSFFvisEe7N/PUFMG7Vb+b6STA4wyXl
         ljeaXakPDst7OvtyHBtFBSYelOXWbgYtwcqgPz0UyfmxNkNjgmq0hWI2NZIvH2ggMoei
         ihRYG7x8L0ZNGLViTdDP7407sE+aecfSpxGeYqpZzSGps9Pe7GVH3Lqu8GR6/ILFMxd6
         8Y8A==
X-Gm-Message-State: AOAM532AFz6Ibxc82qq1feaE90LV3Ad12s+ulb7I0dBA2Ap/iPIu5a+W
        Im1baSFB3v/VE58W3Yh67hs=
X-Google-Smtp-Source: ABdhPJxC1O7dX7JvVoGcSGq60b78AjOQrktfQ4z0c/vmQJlLvag4+tPeF0RO2G9HkZH+DsMav7wQ6g==
X-Received: by 2002:aa7:c2d7:: with SMTP id m23mr8196913edp.30.1627347593533;
        Mon, 26 Jul 2021 17:59:53 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id n13sm362085ejk.97.2021.07.26.17.59.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 17:59:53 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Evan Miller <emmiller@gmail.com>, git@vger.kernel.org
Subject: Re: Exit code 255 after large clone (32-bit PowerPC)
Date:   Tue, 27 Jul 2021 02:51:05 +0200
References: <D3C1583B-8CC8-434B-8AF5-B9827A7FD037@gmail.com>
 <YP8ykvsZie4mPE5o@camp.crustytoothpaste.net>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <YP8ykvsZie4mPE5o@camp.crustytoothpaste.net>
Message-ID: <874kcgsh94.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jul 26 2021, brian m. carlson wrote:

> [[PGP Signed Part:Undecided]]
> On 2021-07-26 at 17:54:07, Evan Miller wrote:
>> What did you do before the bug happened? (Steps to reproduce your issue)
>> 
>> $ git clone -v git@github.com:macports/macports-ports.git
>> Cloning into 'macports-ports'...
>> remote: Enumerating objects: 1223319, done.
>> remote: Counting objects: 100% (685/685), done.
>> remote: Compressing objects: 100% (341/341), done.
>> remote: Total 1223319 (delta 289), reused 608 (delta 252), pack-reused 1222634
>> Receiving objects: 100% (1223319/1223319), 244.46 MiB | 1.09 MiB/s, done.
>> Connection to github.com closed by remote host.
>
> This message is the relevant detail here.  This means that the
> connection was reset, which could be due to the remote host (GitHub),
> but is more likely due to a network issue of some sort.  You'll have to
> do normal network troubleshooting to see why that might be.
>
> It could very well be related to the fact that you're running a nearly
> 14-year old operating system, but I just can't say for certain.  It's
> not a bug in Git, however.

I'm not so sure it's not, I think the "Connection to github.com closed
by remote host" message is emitted by the C library, not Git itself (we
don't seem to have that exact wording anywhere, but maybe I missed
it).

I've seen other cases where I think OSX in particular is quite verbose
in this area, but maybe I'm misrecalling.

We've already received all objects as noted downthread, so having the
connection go away should be something we handle gracefully, and the
code in transport.c seems to try to do that.

It's also quite unusual for us to exit with code 255, I don't think we
do that intentionally anywhere (not from die, BUG etc.).

Evan: Can you run this with some of GIT_TRACE=1 /
GIT_TRACE_EVENT=/dev/stderr GIT_TRACE_PACKET=1 and see if some of those
show what's happening in/around that 255 exit?

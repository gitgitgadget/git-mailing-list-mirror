Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B2ADA20954
	for <e@80x24.org>; Fri,  1 Dec 2017 18:17:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751781AbdLASRI (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Dec 2017 13:17:08 -0500
Received: from mail-it0-f66.google.com ([209.85.214.66]:40729 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751278AbdLASRH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Dec 2017 13:17:07 -0500
Received: by mail-it0-f66.google.com with SMTP id f190so3389052ita.5
        for <git@vger.kernel.org>; Fri, 01 Dec 2017 10:17:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WNVIxH0XgVLGG2PYWfAZAMUb8D0n5/3OpnYOPvWFygg=;
        b=hluyUlC9Eb8BcuZo2VoH0OlDaSoKR/eantne7Nbv5tuxcH0IfGOJUNaXEamPgc5Nzd
         NcCg9jpEt4vbBCO3tXAUMYDoA8NURkyJmvk1G/esgP0NQjfUdOtY1J1EcCjUU90JHonr
         RB/p6dxTX3rAQpD/qyvuO88u/gX8viOTjPuzxrVKfhNJ23ksJbpqzWjDX8WO5PemLOvJ
         SaGieQGCE059hKGulngNAuKO1tujRLazGl/8Z5l4gLW00JMY/Z0QI6MriebsGOTD9ba6
         rxZWZ+Liuo82gFO5DAelhonuRl8UzPc8kaAT4r3h+ugBOaUJMuP02RZek56j12uC2RPF
         u/YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WNVIxH0XgVLGG2PYWfAZAMUb8D0n5/3OpnYOPvWFygg=;
        b=OZn2dQK0LVCP//tjiXUKz3EJQckJ45pKhI/xVA0TPh0JQQa3gF09oHMvzNYAkFwdZ8
         EjBuzRj21gTnhKX33joa72E4Cf+b5wYQoRymW9BY6ffi078sJUvTeK9HNZZMslohkC8w
         mjHTSSSlyC0n+T+KM4zwe7X0Lae1nGwz/4S9lJrbAx5LUBa+x9heSejJ4gzb/BD2mC0b
         IvKw/ilXjYgBekRsIDLNmZT0t//kpmwqKjtZdUrZKQP+NgsjscSJAJUtnLTC5CRN77kD
         iUst2CL7PAFKfYpN+bO3Gi7ZaxTTgaCmpV/uVVKW7fSyykASpZw87KU3V/fZdJJukYqf
         8oQw==
X-Gm-Message-State: AKGB3mIBXXABvOPijo/4zxHHDrgisIh5ivCcpIFFnSRe7zCIYW4LiUr5
        VQR/FfQdeF1dlwsGKiabhdg=
X-Google-Smtp-Source: AGs4zMZwVfvDApbv3M1kpTy0uZQCgyGu0W4S/LfzCkptNnG0RL7Fz998fiE6Y9T3rp8mOMixVL68eQ==
X-Received: by 10.36.125.75 with SMTP id b72mr3128799itc.16.1512152226687;
        Fri, 01 Dec 2017 10:17:06 -0800 (PST)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id s4sm395152ita.12.2017.12.01.10.17.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 01 Dec 2017 10:17:05 -0800 (PST)
Date:   Fri, 1 Dec 2017 10:16:58 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Vitaly Arbuzov <vit@uber.com>, git@vger.kernel.org,
        Konstantin Khomoutov <kostix@bswap.ru>,
        git-users@googlegroups.com, jonathantanmy@google.com,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: How hard would it be to implement sparse fetching/pulling?
Message-ID: <20171201181658.GA18220@aiede.mtv.corp.google.com>
References: <CANxXvsMbpBOSRKaAi8iVUikfxtQp=kofZ60N0pHXs+R+q1k3_Q@mail.gmail.com>
 <e2d5470b-9252-07b4-f3cf-57076d103a17@jeffhostetler.com>
 <CANxXvsNWgYda_unSWoiEnfZnEuX8ktkAD-d_ynVtsTbkOKqeCg@mail.gmail.com>
 <CANxXvsO0xk3K8Wx9pmX1qST1=43BkrKWOcCZjJ8vVcBFYVRB0A@mail.gmail.com>
 <20171130200341.GA20640@aiede.mtv.corp.google.com>
 <e93127b9-d6d6-dcf2-3d58-dc83d68d5d20@jeffhostetler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e93127b9-d6d6-dcf2-3d58-dc83d68d5d20@jeffhostetler.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Jeff Hostetler wrote:
> On 11/30/2017 3:03 PM, Jonathan Nieder wrote:

>> One piece of missing functionality that looks intereseting to me: that
>> series batches fetches of the missing blobs involved in a "git
>> checkout" command:
>>
>>   https://public-inbox.org/git/20171121211528.21891-14-git@jeffhostetler.com/
>>
>> But if doesn't batch fetches of the missing blobs involved in a "git
>> diff <commit> <commit>" command.  That might be a good place to get
>> your hands dirty. :)
>
> Jonathan Tan added code in unpack-trees to bulk fetch missing blobs
> before a checkout.  This is limited to the missing blobs needed for
> the target commit.  We need this to make checkout seamless, but it
> does mean that checkout may need online access.

Just to clarify: other parts of the series already fetch all missing
blobs that are required for a command.  What that bulk-fetch patch
does is to make that more efficient, by using a single fetch request
to grab all the blobs that are needed for checkout, instead of one
fetch per blob.

This doesn't change the online access requirement: online access is
needed if and only if you don't have the required objects already
available locally.  For example, if at clone time you specified a
sparse checkout pattern and you haven't changed that sparse checkout
pattern, then online access is not needed for checkout.

> I've also talked about a pre-fetch capability to bulk fetch missing
> blobs in advance of some operation.  You could speed up the above
> diff command or back-fill all the blobs I might need before going
> offline for a while.

In particular, something like this seems like a very valuable thing to
have when changing the sparse checkout pattern.

Thanks,
Jonathan

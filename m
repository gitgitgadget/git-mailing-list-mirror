Return-Path: <SRS0=dkLL=BK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E91FC433DF
	for <git@archiver.kernel.org>; Fri, 31 Jul 2020 16:40:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4D9221744
	for <git@archiver.kernel.org>; Fri, 31 Jul 2020 16:40:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qs4NQY9D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729490AbgGaQkG (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Jul 2020 12:40:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726502AbgGaQkF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Jul 2020 12:40:05 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83DF7C061574
        for <git@vger.kernel.org>; Fri, 31 Jul 2020 09:40:05 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id d1so17702504plr.8
        for <git@vger.kernel.org>; Fri, 31 Jul 2020 09:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=grNi96pg9+O0jn7qeG0aDO3kg+y5Oia/DWEy7OgbSJs=;
        b=qs4NQY9DDrl9tfuUM6FqOPS5rQOzEhRSZpDmT62goiC79+p2dduZcfBUUNCFr61/NX
         4o9+NFIYQyesekChEn/plq/fqbiHX26SCb9M0fYkHR+4UddnCTF5i2rA+HwpkUZlPtYY
         QFmqfcV9hbUIVq/KuPClXdXD5Gz9xkf2Uqj7VHrQ3gHzcUW1P9s++oojrn8pa3FiaNnd
         Hu/xjKhaCGTwhou/lDifJIfWrpliJoq6t4fXF1Vcb72mJvnttrLfSZkt7oFA+g44RgZM
         cE0CjzsE/eD0kX2xJoQ8F/c/KMyPbf+FZtNiu+8r6vi6ymC+SqVldcRG6zGFmiNVH7gL
         3QrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=grNi96pg9+O0jn7qeG0aDO3kg+y5Oia/DWEy7OgbSJs=;
        b=AqNvJMwkoZ51g8aT4F7mPFHUCuyTgqNCL5Vdx33raQf2ISFarCRF+Oka5HBm1iXUZ5
         5CgyR8vofk2wAvD59uU5PL7P2GVYsfM69B9AXG/qZqytMRye7SqkOKmZaJ34Jn/u7i4Q
         hosGT+Z1ueZvXE7+HT0eMXLzSdTFUGUMgSqDcH2GY6hkeOKhWDd17qPlzPkdEsyeDB4+
         ef6S2s28thA09YPxBjjYZJHirNjqeAQDgwPUiMRYJjrla2HLgTB7DFsSs0UHHtv8ZPmb
         pzYHAVzWsSWEl9xbAsl8zYV7o2BIPbBq90Pdn/DGDrer8no3+QVBE+woStR7xjf3lgBg
         strQ==
X-Gm-Message-State: AOAM530EiUx9w2NTNWqcMOaz1q2BogkCZtka2qiXn5sPNNMIwt6B6iPV
        L63GjyMR6rq+rTC90TyO7+H3VzJw
X-Google-Smtp-Source: ABdhPJzHF0zr4YeiwaRLTg9tl5Oqw3EFn39iL2RhMJkCHn9V+U7VwMUqpZF/qLcwGcpnIG4O0QRWEQ==
X-Received: by 2002:a17:90a:1682:: with SMTP id o2mr5034921pja.227.1596213604836;
        Fri, 31 Jul 2020 09:40:04 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:a28c:fdff:fee1:cedb])
        by smtp.gmail.com with ESMTPSA id t17sm10656525pgu.30.2020.07.31.09.40.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 09:40:04 -0700 (PDT)
Date:   Fri, 31 Jul 2020 09:40:01 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Johannes.Schindelin@gmx.de,
        sandals@crustytoothpaste.net, steadmon@google.com, peff@peff.net,
        congdanhqx@gmail.com, phillip.wood123@gmail.com,
        emilyshaffer@google.com, sluongng@gmail.com,
        jonathantanmy@google.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2 01/18] maintenance: create basic maintenance runner
Message-ID: <20200731164001.GA1252647@google.com>
References: <pull.671.git.1594131695.gitgitgadget@gmail.com>
 <pull.671.v2.git.1595527000.gitgitgadget@gmail.com>
 <63ec602a07756a41f8ccddd745562c567a4b3ed7.1595527000.git.gitgitgadget@gmail.com>
 <20200729221905.GB519065@google.com>
 <5cbdb559-3897-961f-4dd3-0bab11848c5b@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5cbdb559-3897-961f-4dd3-0bab11848c5b@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee wrote:
> On 7/29/2020 6:19 PM, Jonathan Nieder wrote:
> > Derrick Stolee wrote:

>>> --- /dev/null
>>> +++ b/Documentation/git-maintenance.txt
>>> @@ -0,0 +1,57 @@
>> [...]
>>> +SUBCOMMANDS
>>> +-----------
>>> +
>>> +run::
>>> +	Run one or more maintenance tasks.
>>
>> [jrnieder] How do I supply the tasks on the command line?  Are they
>> parameters to this subcommand?  If so, it could make sense for this to
>> say something like
>>
>> 	run <task>...::
>
> Hopefully this is documented to your satisfaction when the ability
> to customize the tasks is implemented.

I think my last reply to this part missed the point a little, so let
me try again.

In multi-patch series, requests to make improvements to early parts
that would be obsoleted by later parts may seem strange --- isn't this
just wasted work?  Sure, occasionally someone will stumble on the
early part using "git bisect" or "git log", but isn't that rare enough
to not be worth worrying too much about?

And I'd agree with that reaction --- for a documentation nit like this
one, that benefit alone is probably not enough to be worth the fuss of
tweaking things.

When I focus more on early parts of a series, it is for a different
reason: from a release management point of view, it is useful to get
the early part of a series "cooked" as soon as possible so it can be
exposed to users in "next" and then become a foundation for later
patches in "master".  So we try to get as much of the early part of a
series into that state as we can, and to merge the early part even
without the later part as soon as the former is ready and valuable
enough to users on its own.

Relatedly, ensuring each commit is "complete" in this sense on its own
gives us more flexibility in case a problem is discovered later: we
can revert a patch that is causing issues without having to revert the
preceding part.

I think that might be part of the context I didn't convey well, and
why I want to get this in tip-top shape and start using it.

Thanks,
Jonathan

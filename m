Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 639BAC433EF
	for <git@archiver.kernel.org>; Thu, 11 Nov 2021 00:03:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48B7D61105
	for <git@archiver.kernel.org>; Thu, 11 Nov 2021 00:03:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234334AbhKKAGp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Nov 2021 19:06:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234330AbhKKAGn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Nov 2021 19:06:43 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2F57C061203
        for <git@vger.kernel.org>; Wed, 10 Nov 2021 16:03:55 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id gt5so2849957pjb.1
        for <git@vger.kernel.org>; Wed, 10 Nov 2021 16:03:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-description:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=j5eWFVRblV4zTozqaH6zUU4gOAq+hiqhSlfchXe8218=;
        b=QLi1BuqffGaUvI5iasFPHnZSiEKxZLo4pTrg7Dgv3tKbTId9merdS1Amazk2+VD0aI
         d26VQWQOoBjOv4GrDqIdY4B5VoMYlIVlAPD7hNEZ70jAR3aG+YzZmqZVF2t/BCGPT/kQ
         xKAqNIgam9jQCL50BFR1sRiNydMWN9V8IGwnrFfkSWs4jmyyYMS2REefSy/iqUFxotWm
         BMTl+4xBmN/cRVNQaLO/+yVcN1sxXyrVtp3p688FtTzxcnNOyGFPAmC3w84lpiTSDqty
         42Q23mVjQMLRcxtr1lh+wdwBELyosxZTguwHmT/nomMPvhrHeLZSQd9pcnT9hDkAF24b
         kM8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-description:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=j5eWFVRblV4zTozqaH6zUU4gOAq+hiqhSlfchXe8218=;
        b=NqkcX2t6XRVNhhPB38ocbtWSXYgcxfKHpAPkhQpRJZ/ijRI1LoYV/FbvMs0UYidSnf
         zFNDR9wUvBt6WZ8KudBu2/1j3nOAgUNRlM5nKMGdC2ImNzx9g6sx1/C21Jui8UtSrSYk
         3f3fZR5bA4Yf5pv6N/vqmom14+ESi/nLZO2B4I8Hh9nD9rnzTCTeG/+N3nFsaTlpzqs+
         SCSlBcPjXuju22OsryKpH2z/o2umtpAlV1x9dDBpnEjjojv/MqUb6xd7n0f1egepdm66
         JGlKe2Cmu5of8m7CBdSsvFIaITj3dfCTtGD1YmPAjd0BKZTyj/FozUZCFqYGbN3rRRMT
         OB5w==
X-Gm-Message-State: AOAM530LEBkFUS8FmQNuraohH99eGoZ60rx7mE2OyhLtSdrF0PrGdabJ
        1d+aT1us6azDPwPxshmZF9XFbrLvxodHwA==
X-Google-Smtp-Source: ABdhPJy14TlQrPokjRKmcHO58efcLwD5CigwlTKJO26wVBD9TfFrMjjN0lJtVEvf+dQYEvCD12SsYQ==
X-Received: by 2002:a17:903:2445:b0:142:830:ea8e with SMTP id l5-20020a170903244500b001420830ea8emr3036584pls.54.1636589034857;
        Wed, 10 Nov 2021 16:03:54 -0800 (PST)
Received: from neerajsi-x1.localdomain (c-24-56-226-231.customer.broadstripe.net. [24.56.226.231])
        by smtp.gmail.com with ESMTPSA id m18sm698343pff.194.2021.11.10.16.03.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Nov 2021 16:03:54 -0800 (PST)
Date:   Wed, 10 Nov 2021 16:03:49 -0800
From:   Neeraj Singh <nksingh85@gmail.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>, Eric Wong <e@80x24.org>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2 3/3] refs: add configuration to enable flushing of refs
Message-ID: <20211111000349.GA703@neerajsi-x1.localdomain>
References: <dd65718814011eb93ccc4428f9882e0f025224a6.1636029491.git.ps@pks.im>
 <cover.1636544377.git.ps@pks.im>
 <d9aa96913b1730f1d0c238d7d52e27c20bc55390.1636544377.git.ps@pks.im>
 <211110.86v910gi9a.gmgdl@evledraar.gmail.com>
 <20211110191533.GA484@neerajsi-x1.localdomain>
 <211110.8635o3rbdc.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Description:  =?ISO-8859-1?Q?=20y=1B?=
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <211110.8635o3rbdc.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 10, 2021 at 09:23:04PM +0100, Ævar Arnfjörð Bjarmason wrote:
> 
> 
> Yes. I understand that we're not doing POSIX fsyncing().
> 
> I'm asking about something else, i.e. with this not-like-POSIX-sync why
> it is that when you have a directory:
> 
>     A
> 
> and files:
> 
>     A/{X,Y}
> 
> That you'd write those two, and then proceed to do the "batch flush" by
> creating and fsync()-ing a:
> 
>     B/Z
> 
> As opposed to either of:
> 
>     A/Z
> 
> Or:
> 
>     Z
> 
> I.e. why update .git/refs/* and create a flush file in .git/object/* and
> not .git/refs/* or .git/*?
> 
> Maybe the answer is just that this is WIP code copied from your
> .git/objects/ fsync() implementation, or maybe it's more subtle and I'm
> missing something.

It looks I didn't really answer your actual question before. On the filesystems
which I'm familiar with at a code level (NTFS and ReFS on Windows), fsyncing a file
or dir anywhere on the filesystem should ensure that metadata operations completed
before the fsync starts are durable when the fsync returns. So which specific directory
we put the file in shouldn't matter as long as it's on the same filesystem as the other
files we're interested in.

> 
> *nod*. See this if you haven't yet:
> https://lore.kernel.org/git/211110.86r1bogg27.gmgdl@evledraar.gmail.com/T/#u

I'll respond on that thread with my opinion. Thanks for reviewing this and pushing
for a good holistic approach.

Thanks,
Neeraj

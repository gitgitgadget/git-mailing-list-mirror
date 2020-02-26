Return-Path: <SRS0=QAHC=4O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D9B0C4BA0B
	for <git@archiver.kernel.org>; Wed, 26 Feb 2020 10:22:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6240020801
	for <git@archiver.kernel.org>; Wed, 26 Feb 2020 10:22:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q3rk3DsW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726927AbgBZKWL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Feb 2020 05:22:11 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:38094 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbgBZKWL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Feb 2020 05:22:11 -0500
Received: by mail-qt1-f193.google.com with SMTP id i23so1849504qtr.5
        for <git@vger.kernel.org>; Wed, 26 Feb 2020 02:22:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Hu+Wb/6Z8xqD9ADjs3PU9Xy1vMz+uGmAckss2IjiASs=;
        b=Q3rk3DsWITFQCDIMDXZCPTTNm4lzyvIwIf4xYs9FxWi6TdmotBT5UAAHTqSU8f2iqy
         GObN21TovuGqYThzkTW4Nan15aYEgZu8Yel2aMaalHvddzuxkbmiGsb6/q5Iht+i4z8U
         lxQOGuEIkMZYUies60HNCpybM5ffinnP7WMSJWOVrP8cTyUApCDaXJqPjebtT7Za9JGc
         3QNTAy4CQVpgjuLJSTOg0LP3IAO6vFsm9T6uNxteQhsdcrFocEw5pkMd29ICKzLuIQMA
         eNO3LHP5wHo1OCKYJWjcSM1+1OtMDVDnNZ6+4qT0745QyRzlkVjcJJDePVQzDMxahKIt
         MmEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Hu+Wb/6Z8xqD9ADjs3PU9Xy1vMz+uGmAckss2IjiASs=;
        b=t+Z6KQ4bEJQlWhjykmI9d8r84b4IUYheUAVTn5+wUV1hKybTjnGn9dISJIBh55+Laf
         zGn1ITPDjjuZw1vkEHqgLJMTtI7f72Rk5W+/72ODxZN3umQXivY2rsUE0n48geakKxhZ
         DPn/+t1zeDitmBRUFA1uluFjDacKYe9v+pnrDkJ2g2kH4V2JCIl7S6CUwPkPsbuzYASj
         Hxo/d5eL84UY415TT1147YuDBF5KA0yg4HD/XDmRiXF4i0FKlpb9pQb8FInRwKOOAn4K
         4mSj1MMVuJp0jd7A6aelJMbiKe7NNZgxYwhQI9mJCfyrKgYHeOhieb77FOvvzM4q5gFw
         ZSkQ==
X-Gm-Message-State: APjAAAXX0q2HIW9ZBpUie9h/cSgI861ZoaFrMfDsBOus+O+f9cQVyLZv
        fK6+OE8w1nAsI/Guz+eMCrcqJvvyf+u5RA9H1ad1aS+J
X-Google-Smtp-Source: APXvYqxTCcOWfFlBySahtqVVdifaECIKW3Fg3GhsbyAxsW6F8R+R7nCg9+Z/nTyZ1pz7Vmg7MEme/k7lINu+KvSopPI=
X-Received: by 2002:ac8:73c8:: with SMTP id v8mr3922452qtp.270.1582712530306;
 Wed, 26 Feb 2020 02:22:10 -0800 (PST)
MIME-Version: 1.0
References: <CAOTb1wc2uMSyc7DMau2cWrWtk=_Z94+CCovORj1dGCrwgJhL=w@mail.gmail.com>
 <20200226023909.GC7911@camp.crustytoothpaste.net> <20200226034731.GA2915944@coredump.intra.peff.net>
 <CAOTb1wfWtFsy415k+goRiuLUiVBqtizmmoyxqFdy7xsRhjnBww@mail.gmail.com> <20200226094716.GA14546@coredump.intra.peff.net>
In-Reply-To: <20200226094716.GA14546@coredump.intra.peff.net>
From:   Chris Jerdonek <chris.jerdonek@gmail.com>
Date:   Wed, 26 Feb 2020 02:21:59 -0800
Message-ID: <CAOTb1weTWOsHkbGqmj8mJ-KpkoiteHBDYDxe-j2E0yf3DccjjQ@mail.gmail.com>
Subject: Re: create reflog for reflog-less ref
To:     Jeff King <peff@peff.net>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 26, 2020 at 1:47 AM Jeff King <peff@peff.net> wrote:
> On Tue, Feb 25, 2020 at 11:18:39PM -0800, Chris Jerdonek wrote:
> > It would be
> > nice to be able to create (or append to) the reflog without having to
> > change where the ref is pointing. Or maybe I'm missing a variation
> > that will do this..
> ...
> The "touch" trick I showed would work for that, but it's not going to be
> portable going forward. I don't think it would be a bad idea to have
> some way of triggering a "noop" reflog update via update-ref, where we
> either create the reflog as empty, or insert a pointless entry going
> from the current sha1 to itself. But AFAIK that doesn't exist right now.

Thanks. By the way, this functionality does already seem to exist for ref HEAD:

$ git update-ref -m my-message HEAD HEAD
$ git reflog HEAD
3ccacdc (HEAD -> master) HEAD@{0}: my-message
...

I don't know why it would work for HEAD though and what's different
about the mechanism. I thought it might be because it's a symbolic
ref, but it didn't work for other symbolic refs when I tried (even
ones that already had a reflog).

--Chris

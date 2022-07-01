Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37B52C433EF
	for <git@archiver.kernel.org>; Fri,  1 Jul 2022 19:48:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231273AbiGATsZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Jul 2022 15:48:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231334AbiGATsX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Jul 2022 15:48:23 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 118991CB1E
        for <git@vger.kernel.org>; Fri,  1 Jul 2022 12:48:23 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id g14so1171580qto.9
        for <git@vger.kernel.org>; Fri, 01 Jul 2022 12:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rc2z24Bqq7bC35vTwAMG4rQ9MUEO9KX4cMQfGyyEf+A=;
        b=6NXkhBYRumKaaP0KPtO4JJz0lIVhEwSP+y/ag7s5BRzccNeE23NE7kiPCwlFFy89RX
         X6Isvbeu4Vi0wXeZZqKWNWFRjR+O8toDxmKE7QxgrZUeJl9Fzm5DCSbIyGeR0DnDNms6
         yWmwnpVYTuotL2RpH29oB40mK/b67stZNx0lIRVUUlpTVHth+HO1uFUCS9dbz56UL3X3
         8IUEr1axybra5BQP75AaI0fBZtYBmdhZbSB7fnMWUh057ld0ZVyYrNqmqIc1/1yYiO9h
         Xtx9MDplqbNaEFqs4NM3Q3UaFOKha7du7Kg5c2IkUZHTaaYc2OA+yIEABQQFivLlwW9g
         UPbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rc2z24Bqq7bC35vTwAMG4rQ9MUEO9KX4cMQfGyyEf+A=;
        b=HURi2iIQYiQX0U+tdiUOIetSm9vkc/MNqzwQS2VofAEhgD0jjU2Yb8hmo1EThVX6CD
         D4hpNpggm8qD0/x5CEvyHQu9rXTWnuydiy00+H7xwy1bsq2ONlL3qPptaDNxjgTExMjd
         tB9r4fHIo4aARkmlggV5T1zTU90FGKK3uLL2LF0tICZw/I40jfz8kxBW4o9u+oGvu5te
         bJguAATnMG6xwSDi6YpQVZy/vYa01mPLlikTMJxQwqJb/dyBWBFurP22zRh3wPRfxC6A
         MCplloQGi3bZWZajHB5IMpoBtROJ8y7iuvKIgZF387nracYOx8V+XmtmBKptwwVQ9Mkt
         orSg==
X-Gm-Message-State: AJIora9XMGKhwqqRPQdzKNVOgk9meges1jcmBGy0HOKiMEVCln6Xp7PI
        4Xkhi2XzAxcuFDnUfCWniP+vOj/5o4okdA==
X-Google-Smtp-Source: AGRyM1srPWEH0PEfOcUOoi0NBWtcdUX6OBUb5FA1TJUP3gwqb3stSjIPn+Ta3roVbAqI+WBa3vyoYg==
X-Received: by 2002:ac8:5c47:0:b0:31d:347d:d621 with SMTP id j7-20020ac85c47000000b0031d347dd621mr6919618qtj.524.1656704900926;
        Fri, 01 Jul 2022 12:48:20 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id cc18-20020a05622a411200b0031b7441b02asm9034916qtb.89.2022.07.01.12.48.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 12:48:20 -0700 (PDT)
Date:   Fri, 1 Jul 2022 15:48:19 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        gitster@pobox.com, pclouds@gmail.com
Subject: Re: [PATCH] pack-objects.h: remove outdated pahole results
Message-ID: <Yr9Pg9mRQWe1tgE+@nand.local>
References: <1379af2e9d271b501ef3942398e7f159a9c77973.1656440978.git.me@ttaylorr.com>
 <Yr85+tcexG2geaPP@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yr85+tcexG2geaPP@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 01, 2022 at 02:16:26PM -0400, Jeff King wrote:
> On Tue, Jun 28, 2022 at 02:30:20PM -0400, Taylor Blau wrote:
>
> > Even though this comment was written in a good spirit, it is updated
> > infrequently enough that is serves to confuse rather than to encourage
> > contributors to update the appropriate values when the modify the
> > definition of object_entry.
> >
> > For that reason, eliminate the confusion by removing the comment
> > altogether.
>
> I agree the actual numbers aren't helping anybody. We _could_ leave a
> comment that says "we store a lot of these in memory; be careful of
> where and how you add new fields to avoid increasing the struct size".
> And then people can run "pahole" before and after their changes.
>
> But then that is also true of other structs (like "struct object"), and
> we do not bother there. So it probably is fine not to annotate this
> specifically.

We have such a comment at the very type of the block comment above
`struct object_entry`'s definition:

    "The size of struct nearly determines pack-object's memory
    consumption. This struct is packed tight for that reason. When you
    add or reorder something in this struct, think a bit about this".

thanks to Duy back in 3b13a5f263 (pack-objects: reorder members to
shrink struct object_entry, 2018-04-14).

> Speaking of which, I suspect quite a lot of memory could be saved if
> "pack-objects --revs" freed the object structs it allocates during its
> traversal. Unless we're generating bitmaps, I don't think they get used
> again after the initial packing list is generated. At peak you'd
> still be storing all of the object_entry structs alongside the objects
> as you finish the traversal, but it wouldn't overlap with any memory
> used for the delta search, and of course we'd be at that peak for a much
> smaller time.
>
> Not a blocker for your patch obviously, but maybe a fun experiment in an
> adjacent area. Possibly even an ambitious #leftoverbits opportunity. :)

Challenge accepted! ;-)

Thanks,
Taylor

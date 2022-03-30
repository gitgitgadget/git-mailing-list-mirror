Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84106C433F5
	for <git@archiver.kernel.org>; Wed, 30 Mar 2022 17:30:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349307AbiC3Rca (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Mar 2022 13:32:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349300AbiC3Rc3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Mar 2022 13:32:29 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 528801114D
        for <git@vger.kernel.org>; Wed, 30 Mar 2022 10:30:41 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id h196so17209917qke.12
        for <git@vger.kernel.org>; Wed, 30 Mar 2022 10:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=v2LzPYf8NbtHXclE6HHty1u8fqaldW4pVBiaPSlDrPI=;
        b=JmBZUQNEq4eXMPzmiyqKfacfEGV1XogjtA9JVQWU6D2b5VxVGtDGHAr50NTgvn/WTc
         0IQF3/DbqlK3WnE+Ok9HL1G5scqVoShzClBalEI06tRKcq8VGCy5/dLfFoACnWBPX4KD
         yEDqZg0ZPOHvpC2Lmkb3I6GLlsPyCoB1h60Hc/rGcdpk90T13iSVPa1ydqNW2b3sH3Z2
         3hNF5uNd4SDMGgYL/AGnZX9I7aECk1VWhmCSUgO1SK6ZU1DKr+p9xRSF/bNr1+o/YzAA
         OT9K11HVTAlmjDdDLgP2U26bFu+is7m2V+e+k2a0SM4Jv7R4hVbmHJc1r9yaO0KUAno1
         Tbkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=v2LzPYf8NbtHXclE6HHty1u8fqaldW4pVBiaPSlDrPI=;
        b=MjFbC6mXWZ4IALKqAtCx0iwQLXMh0/gUeRN79VowB5Uevf5+uLuTvRWwu7aY1jWsda
         2orlpnxWqDC1782DFjTuliYQamJLGZ7RQ2qHy/DFgNnAHslDTQBwRiuNrtFY5AUKP4xN
         5+XIN0kBz+INSHkLLKLRovOQXq0SkpY7xp+UOt3su/a6PVsIii4Jg6j1wPaBc/LlGk0W
         ARh4NSq0hKr2tMw20hTU3ZqKl0vrj7cdX5hv44jmua3uBsHT8hUngUVkqW1PY93aVmxO
         ndXsVm0jq4W+TQZtyXQfAIJHAB9V9PxTEGYgBr+KhqjANUsEsfhj4t79yP2W8IUnmZhZ
         mGiQ==
X-Gm-Message-State: AOAM532LFynzyzuyIPh8wPZjJcBOcWfMVSwiOTVelNEDsf0PExHKKZWL
        0lj50fqUDG/NiYxvQcgNpB5vTQ==
X-Google-Smtp-Source: ABdhPJz+q3i0PBheuQW6FB3KTF+dNIypVjrYKwYUl8kTV3Wy+NtoSTRRSG1rVpBvrSdlAAeDoMTIJw==
X-Received: by 2002:a05:620a:45aa:b0:680:9ec6:ed42 with SMTP id bp42-20020a05620a45aa00b006809ec6ed42mr549738qkb.179.1648661440383;
        Wed, 30 Mar 2022 10:30:40 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 3-20020a370503000000b0067b03f03589sm11110175qkf.53.2022.03.30.10.30.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 10:30:39 -0700 (PDT)
Date:   Wed, 30 Mar 2022 13:30:38 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
        tytso@mit.edu, derrickstolee@github.com, larsxschneider@gmail.com
Subject: Re: [PATCH v3 01/17] Documentation/technical: add cruft-packs.txt
Message-ID: <YkSTvr42wFVAgHvp@nand.local>
References: <YjpDbHmKY9XA2p0K@google.com>
 <YjpHbaBspUasDdEy@nand.local>
 <YjpWFZ95OL7joFa4@google.com>
 <Yjpxd8qhwnAIJJma@nand.local>
 <YkICkpttOujOKeT3@nand.local>
 <xmqq8rst23w0.fsf@gitster.g>
 <YkIm7lnQsUT0JnvS@nand.local>
 <xmqqa6d8yckj.fsf@gitster.g>
 <YkO/P3xgGYmhAz2O@nand.local>
 <xmqq1qyjblxp.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq1qyjblxp.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 30, 2022 at 06:37:54AM -0700, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > The thing I think Jonathan seeks to prevent is older versions of Git
> > gc'ing a repo that has cruft packs. I think I may need you to clarify a
> > little, sorry :-(.
>
> By making controlled rollout of the use of "--cruft" option (and the
> assumption here is that a large organization setting people do not
> manually say "gc --cruft", and they can ship their maintenance
> scripts that may be run via cron or whatever with and without
> "--cruft"), you can control the number of repositories that can
> potentially see older versions of Git running gc on with cruft
> packs.  Those users, for whom it is not their turn to start using
> "--cruft" enabled version of the script, will not have cruft packs,
> so it does not matter if they keep an older version of Git somewhere
> hidden in a hermetic build of an IDE that bundles Git and gc kicks
> in for them.

Ahh, OK. Thanks for explaining: this is what I was pretty sure you
meant, but I wanted to make sure before agreeing to it.

Yes, this solution amounts to: "if you have mixed-versions of Git
mutually gc'ing a repository, then use the same rollout method used for
controlling Git itself to guard when to start creating cruft packs".

I would be very eager to hear if this works for Jonathan's case. It
should do the trick, I'd think.

Thanks,
Taylor

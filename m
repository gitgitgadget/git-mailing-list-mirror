Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2275DC433F5
	for <git@archiver.kernel.org>; Fri,  3 Dec 2021 20:47:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383115AbhLCUvB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Dec 2021 15:51:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239909AbhLCUvB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Dec 2021 15:51:01 -0500
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2E01C061751
        for <git@vger.kernel.org>; Fri,  3 Dec 2021 12:47:36 -0800 (PST)
Received: by mail-il1-x133.google.com with SMTP id z8so3945066ilu.7
        for <git@vger.kernel.org>; Fri, 03 Dec 2021 12:47:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=P1Z/9Y+Zd2YDzej6Umwg37LM6WGSDpMMiBQz0dA7gKE=;
        b=wUrEinFHoywVF06FysI6OV/ZL7sLe2Re+4GsFKD7rljuepwYRATZisrIgb27ZR5aAv
         Nw1I6+n9+dm/e9+kRIl/2MZabcs8danB5Lrk7Cc2Ueb6xdxml7AnxxfE4h/nUsRD7fuB
         Q3HveaC8OVhe2/UX1egZzhTOGAhRtahm9U9ZemHp0c7oUlJA/oBlFlPwVlr/X6iFejd5
         brSx7Y+Ufo4cccZYIsqlW2BpQ/ex+6Kpi7RqhUeEFQWJz/2+gDDWfag+4m+249ch7V0N
         /tVg2aagsZPpgMWv0eB+ef5Dzefi1o7aha/RWcy1/xnRMexUwnXphNmOGrY85qP/fnIb
         5ixg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=P1Z/9Y+Zd2YDzej6Umwg37LM6WGSDpMMiBQz0dA7gKE=;
        b=NipiDQZRTz86xZv4hy6y9QCyOeQWlcfk0Yw0wMmZn+rk9mjZPR0hnRckWZXgSvja+t
         drJra+rshD5kbT7Rvq5EcvE4dSkdEm6vchKHncn3DvIDRunWVkm60ySiGuKGSe3s38b0
         DwM+5Tl+x/9UMvooe5s+cWp472msgIimoozLgAiuY4ShFa1lMbpXhBAZRnX8dz/gf08G
         W14aaDlnlcun25KtcYaB7DM8XFCDX/3+7yzAGO4EkTzLvFbHPhY2yzdR31oZvgXE63to
         AA6qd+8EHJ6QdiVWUQCTiBc5XWKFT47Rq2hxKMxt0Z1xT6TJvlzD9OI54nGz/8WeNHCq
         vvhA==
X-Gm-Message-State: AOAM532OQSfuDRQa9p51UsbTKh/w35f+0d19aD5Z3KVW+lCjgUnZmEQI
        KE5srnNric31jJNnnxIu4R+HCQ==
X-Google-Smtp-Source: ABdhPJzlHLLU8qgIuKXjCJXyDlVdwrdoSUgjrF69QWkl9V3E5jk8lI0P3WHpAREAdTNM3fo1UkXYZA==
X-Received: by 2002:a05:6e02:4c7:: with SMTP id f7mr21070024ils.232.1638564456239;
        Fri, 03 Dec 2021 12:47:36 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id h14sm2318545ild.16.2021.12.03.12.47.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 12:47:35 -0800 (PST)
Date:   Fri, 3 Dec 2021 15:47:35 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, larsxschneider@gmail.com, peff@peff.net,
        tytso@mit.edu
Subject: Re: [PATCH 00/17] cruft packs
Message-ID: <YaqCZ7BPwuMGmkZY@nand.local>
References: <cover.1638224692.git.me@ttaylorr.com>
 <xmqq5ys5sbzc.fsf@gitster.g>
 <Yap5INmX2ACfjoda@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yap5INmX2ACfjoda@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 03, 2021 at 03:08:00PM -0500, Taylor Blau wrote:
> On Fri, Dec 03, 2021 at 11:51:51AM -0800, Junio C Hamano wrote:
> > Stepping back a bit, I do not see how we can get away without doing
> > the same .mtimes file for non-cruft packs.  An object that is in a
> > non-cruft pack may be referenced immediately after the repack that
> > created the pack, but the ref that was referencing the object may
> > have gone away and now the pack is a month old.  If we were to
> > repack the object, we do not know when was the last time the object
> > was reachable from any of the refs and index entries (collectively
> > known as anchor points).
>
> In that situation, we would use the mtime of the pack which contains
> that object itself as a proxy (or the mtime of a loose copy of the
> object, if it is more recent).
>
> That isn't perfect, as you note, since if the pack isn't otherwise
> freshened, we'd consider that object to be a month old, even if the
> reference pointing at it was deleted a mere second ago.
>
> I can't recall if Peff and I talked about this off-list, but I have a
> vague sense we probably did (and I forgot the details).

Maybe I can rephrase the problem as being orthogonal to what we're
addressing here. Modification time can be a useful-ish proxy for "last
referenced time", but they are ultimately different.

Forgetting cruft packs for a moment, our behavior today in that
situation would be to prune the object if our grace period did not cover
the time in which the pack was last modified. So if the pack was a month
old, the grace period was two weeks, but the reference pointing at some
object in that pack was deleted only a second before starting a pruning
GC, we'd prune that object before this series (just as we would do the
same thing with this series).

Aside from pruning, what happens to the value recorded in the .mtimes
file is more interesting. For the case you're talking about, we'll err
on the side of newer mtimes (either the original timestamp is recorded,
or some future time when the containing pack was rewritten). But the
more interesting case is when an object becomes re-referenced. Since the
ref-update doesn't cause the object to be rewritten, we wouldn't change
the timestamp.

Anyway, both of these are still independent from cruft packs, so we're
not changing the status quo there, I don't think.

Thanks,
Taylor

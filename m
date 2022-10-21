Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B02A7C433FE
	for <git@archiver.kernel.org>; Fri, 21 Oct 2022 21:55:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbiJUVzX (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Oct 2022 17:55:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbiJUVzV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2022 17:55:21 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B4F2139C15
        for <git@vger.kernel.org>; Fri, 21 Oct 2022 14:55:20 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id o65so3464691iof.4
        for <git@vger.kernel.org>; Fri, 21 Oct 2022 14:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=28mfXzRn3LAaVgTHE0B+FtJX9eF5JmXdGwOFlR8dh2g=;
        b=BgJF44U6WpO1VtdKSZMkz2JPIgGab1XGZFQtayR/vV/QdXOCvLeih5epNBqwezx9xf
         Y9/TI4V8iElxKTfL6cEtLkSQoyuJ60rX6UybateSR5yqhvsPRzndOkY+qXDMrUSwfX8b
         ipl/KFCNYjyc7atKKW7WqglNqJHxRHRD9Tf4dGaYs+FsFpcKi7hKvYCuUVL/n4AnEOHc
         62Qhepv3UG3rO/84kgn4/9NfjRaT3XJRYGX1AsFp80lDNxkwvPXTJPLRDytYbAV0nsXf
         UMlSOIXIJwfGUWHMZHYA8oEnbdW3/996gOeS2Pl0j2hU7KwdGrTo2udXLp+LcADy2AKu
         ggVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=28mfXzRn3LAaVgTHE0B+FtJX9eF5JmXdGwOFlR8dh2g=;
        b=x2nJAknkRoI9diIreH/eOr+CDkXd2pcnN5wpE/903zMxngJh98h0kaLU/h1C2kHE3p
         QQP3swZGlrF4JuR+LV3OE3cu9iHJ6y45aHoybLQqNbxfdiujO+k+9iZdNoXb9cYVNm/K
         FbUzKWMLHPjvvTWcq4KaGxBw6WthtvmEmKNVgEyDj5W2Eqv6J7dMD0h9ftrVjp6VjAqw
         D+WG89Btd02Bzpp/WRXEGNe7/OsZq8FUYtCh3ygK6WlIzWNQSRVwc5YQ7a734pLE6IoL
         B5wTLeJ//UWd9Pg26umwW67awT6AOZGniGI9XwAjmgaZNcIs4wnC/prPHeCxLJbxDqR6
         XWXw==
X-Gm-Message-State: ACrzQf0I8Udg4vd5S4lfIUMh34NyTbf1qJ9nP5roPOzzK157Yq0dwt/W
        w8p1hz/0i9GdMl9Wn9FlosZHuQ==
X-Google-Smtp-Source: AMsMyM4dtGPD7mIGMTyDsIkWP8uWwfTQhk/yYrgcL2goZ3+hn0iySTsopuWuCUJ9AqXxjidfaG95RQ==
X-Received: by 2002:a05:6638:12c1:b0:342:a36a:b2b1 with SMTP id v1-20020a05663812c100b00342a36ab2b1mr17316295jas.275.1666389319988;
        Fri, 21 Oct 2022 14:55:19 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id d37-20020a026065000000b00363dfbb145asm4550733jaf.30.2022.10.21.14.55.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 14:55:19 -0700 (PDT)
Date:   Fri, 21 Oct 2022 17:55:18 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, jacob@initialcommit.io, gitster@pobox.com,
        avarab@gmail.com
Subject: Re: [PATCH v2 1/6] shortlog: accept `--date`-related options
Message-ID: <Y1MVRh5flnyXiSH8@nand.local>
References: <cover.1665448437.git.me@ttaylorr.com>
 <cover.1666320509.git.me@ttaylorr.com>
 <58baccbaa8612adae55f776ce10806809861270c.1666320509.git.me@ttaylorr.com>
 <Y1Iu1x6dR6GwiA2Y@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y1Iu1x6dR6GwiA2Y@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 21, 2022 at 01:32:07AM -0400, Jeff King wrote:
> On Thu, Oct 20, 2022 at 11:11:29PM -0400, Taylor Blau wrote:
>
> > diff --git a/Documentation/git-shortlog.txt b/Documentation/git-shortlog.txt
> > index f64e77047b..311c041c06 100644
> > --- a/Documentation/git-shortlog.txt
> > +++ b/Documentation/git-shortlog.txt
> > @@ -47,6 +47,11 @@ OPTIONS
> >
> >  	Each pretty-printed commit will be rewrapped before it is shown.
> >
> > +--date=<format>::
> > +	With a `--group=format:<format>`, show dates formatted
> > +	according to the given date string. (See the `--date` options
> > +	in the "COMMIT FORMATTING" section of linkgit:git-log[1].)
>
> I like this much better than including the whole date-formats section.
> Two nits:

Thanks, both make sense.

Thanks,
Taylor

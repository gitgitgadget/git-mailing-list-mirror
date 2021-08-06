Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84C39C4338F
	for <git@archiver.kernel.org>; Fri,  6 Aug 2021 14:38:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55D95611C6
	for <git@archiver.kernel.org>; Fri,  6 Aug 2021 14:38:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239491AbhHFOil (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Aug 2021 10:38:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231739AbhHFOij (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Aug 2021 10:38:39 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A5AEC0613CF
        for <git@vger.kernel.org>; Fri,  6 Aug 2021 07:38:22 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id j1so16946424pjv.3
        for <git@vger.kernel.org>; Fri, 06 Aug 2021 07:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=T9qKNibwxC3HMZ1FfCdhQ3K+fiYUc0E1Wd2uBth4lGs=;
        b=YSLA0qpWz7w5M3vHBR/6bEC21faCgfM6txyB8eTEsuP3rDuG/ukpn+wgUmXnD7wUxq
         mjZhKhxnOWmSQu4RZ5NwQX5gIaL4fYnIZHqRUK1ThjiHO/DVfeRpwjgGgKJKEe1neeRZ
         hV4oySiTnrBZdSycu4kcTTKgclNElNt3v6Us0JtvvFzq5TOApXvAa/9v3/fWU/6faAM1
         NmePHwkHVrm1tu8gJ4SPCPWff/HIOMMB6wWTnCzz/2dGi06qy4iVYsYIw6t7LAgivajS
         ncqqRIdnK6C1Aj3NMFXYLJP6LHAY4A8ymnpknm/6MorsRch9cPfPH9ExOcm8yi3uUBvZ
         /kAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=T9qKNibwxC3HMZ1FfCdhQ3K+fiYUc0E1Wd2uBth4lGs=;
        b=WZQhdFUktsLU1yj8+FSV8YyD5p8RLyHySjVsU8lteDlImEA9Y7/Ebd9hULZU27Wqrt
         s8MEi7SnIcBn6pJedMHQk3P/8oZ+QApfTns2N+dtTkIa+xf8FIQtZgXjg2XZiQUtWUPV
         KlsjpnZClpVrXmk1gQqDlxwFYpBc4Vp52URWur+FhYtLDWgdEIr1/EpJUVoYEjS2lzP8
         TnpQgnTePP1DGiohwh8DqjgqwcVNeHdMEepkPPJnwqlDwHuWmpEI22hp9iTwTh05UlId
         yqoIbj0pPc9utyb7o2UTXcIeIyXE+zkpJ670KZbqNfum7t08pQ5ccTyh6JnDA57Y5Scq
         /CIw==
X-Gm-Message-State: AOAM530ArU3d4KMmDJ8DpSbYbtLmywSAeJFNj3K4M9wvb8ULxRfYetYa
        T4ruIiMGyZvehAQo5LHoODU=
X-Google-Smtp-Source: ABdhPJy+iFes92M839DmsJ2bqNKa95KYo8fXliS2wfcBAb1x/0bSqEz5NA3o4Omt11ohPOvFLN0KNg==
X-Received: by 2002:a17:902:d293:b029:12c:8bb3:7997 with SMTP id t19-20020a170902d293b029012c8bb37997mr9124401plc.36.1628260702134;
        Fri, 06 Aug 2021 07:38:22 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:6692:d3ab:8eba:ac7c])
        by smtp.gmail.com with ESMTPSA id z18sm6503471pfn.88.2021.08.06.07.38.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Aug 2021 07:38:21 -0700 (PDT)
Date:   Fri, 6 Aug 2021 07:38:19 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Patrick Steinhardt <ps@pks.im>,
        Christian Couder <christian.couder@gmail.com>,
        Albert Cui <albertqcui@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [RFC PATCH 00/13] Add bundle-uri: resumably clones, static
 "dumb" CDN etc.
Message-ID: <YQ1JW8hHmG8B/oE3@google.com>
References: <RFC-cover-00.13-0000000000-20210805T150534Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <RFC-cover-00.13-0000000000-20210805T150534Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Ævar Arnfjörð Bjarmason wrote:

> We're in the 2.33.0 rc cycle, and I'd hoped to have some more prep
> work for this integrated already, but for now here's something
> interesting I've been working on for early commentary/feedback.
>
> This adds the the ability to protocol v2 for servers to optimistically
> pre-seed supporting clients with one or more bundles via a new
> "bundle-uri" protocol extension.

My initial thought here is that even though this includes a comparison
to packfile URIs, I suspect you're underestimating them. :)

Would it be possible to do the same pre-seeding using the packfile
URIs protocol?  Nothing stops a server from sending more objects than
the client asked for.  Is the issue that you want the client to be
able to list "have"s based on that pack?  Can't the server obtain that
same information at the same time as it obtains the bundle URL?

The reason I ask is that this contains a number of differences
relative to packfile URIs, most noticeably the use of bundles instead
of packfiles as the format for the static content.  If we were
starting from scratch and chose this design _instead_ of packfile URIs
then that could make sense (though there are issues with the bundle
format that we can also go into), but in a world where people are also
using packfile URIs it makes for a kind of confusing UX.  Is a server
operator expected to put both kinds of files on CDN and double their
storage bill?  Is this meant as an alternative, a replacement, or
something that combines well together with the packfile URIs feature?
What does the intended end state look like?

Projects like chromium have been using packfile URIs in production for
about 11 months now and it's been working well.  Because of that, I'd
be interested in understanding its shortcomings and improving it in
place --- or in other words, I want _you_ to benefit from them instead
of having to create an alternative to them.  Alternatively, if the
packfile URIs protocol is fundamentally flawed, then I'd like us to
understand that early and act on it instead of creating a parallel
alternative and waiting for it to bitrot.

I'll try to find time to look more closely at the patches to
understand the use case in more detail, but it will take some time
since I'm currently focused on the -rc.

Thanks,
Jonathan

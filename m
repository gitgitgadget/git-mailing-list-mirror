Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE413C48BCF
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 19:05:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C54A0613C0
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 19:05:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234064AbhFHTHb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Jun 2021 15:07:31 -0400
Received: from mail-pl1-f175.google.com ([209.85.214.175]:41475 "EHLO
        mail-pl1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237790AbhFHTFZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Jun 2021 15:05:25 -0400
Received: by mail-pl1-f175.google.com with SMTP id o12so7815659plk.8
        for <git@vger.kernel.org>; Tue, 08 Jun 2021 12:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NYVYVd6skk3cVf1rIRbAE6/VysJqULIAeCITAWk5cd0=;
        b=ejlFLt9VqJXSZHIVaSxg3y0ArK5wu8QEW8Jg1Q93TFXtdI73nFIUkTErnXXDg2hUBY
         XpwUNFeCdhLIJ1+xu2ZPIqrYfhczOyMdcGnzs2yZ5AgB7wYP0dThGEEqXGbrtJ+F1GYq
         SgOSDXncdQ8LsR4PdE0lThAqzwqyQcISuroQ6MUA7UWwkvl38O2nk2jE2P63lkSh71rI
         6Z7BlDb2jSzelzPYqRT/bDNnNqlubrEa22cKllsDEIujW0atkE1rFPqP0BEKeyt47gbE
         dQm/XQ/SH2XOAqHAhI4qU8W7HlMxgfBw4UVgoTnwJ1CsmlPKg3ZMyOOjoh4sIozu3/Yo
         rwVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NYVYVd6skk3cVf1rIRbAE6/VysJqULIAeCITAWk5cd0=;
        b=l+cRregjnAsI+AtLN3TLfkUNx7lkdHGIEO2h15E/yjCwCP/Zv7R2JlvOI+z3T38Ow+
         UPM/P/Nora40NlpHfJwI/Wr6dz5jxHVrOLxddVjBRAh2pzWRy8t0Q4i9Gf5PfOKXJkR4
         ercBV69S8Ib3rgrEnEFNh1EzPQAswFQxzB+N9qWlVAnWGIfHo24HIBIOPf0KBdVA4oyr
         KiteTF50uXzPLPWoh3h/TqqjVRlrl/pvPKVPTsD5tZELXR5RhZIB4f/lO4eVjwqpwkvZ
         VRQmhZcxLqCTdZ/t0M65wBIsawD3Syofd8LGsU6dLcKgbZvDh0DjBtd8n6mXFytUCSmw
         jyyQ==
X-Gm-Message-State: AOAM532nVqECJUR16WHvwGuHnKyE3jeQ8/kXGwOLuJdgvplcsJvVNMbi
        YKXxy+qP9hjlDomE4Dcos2UNKw==
X-Google-Smtp-Source: ABdhPJz+KPaEmtRvKWhtrfXeOr6qBsaYI1/4y9h3JJbzCpzo5b48f+Tivyvrw3QMDK0sDiacPfgWPA==
X-Received: by 2002:a17:902:904a:b029:101:af84:4f55 with SMTP id w10-20020a170902904ab0290101af844f55mr1141765plz.80.1623178951546;
        Tue, 08 Jun 2021 12:02:31 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:f819:e238:f61a:a961])
        by smtp.gmail.com with ESMTPSA id c3sm11058966pfl.42.2021.06.08.12.02.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 12:02:30 -0700 (PDT)
Date:   Tue, 8 Jun 2021 12:02:24 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Atharva Raykar <raykar.ath@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] MyFirstContribution: link #git-devel to Libera Chat
Message-ID: <YL++wKvEWrvKtCp1@google.com>
References: <20210608135114.71104-1-raykar.ath@gmail.com>
 <YL+ndHSLowy/qyZV@google.com>
 <C8A2DA3C-8D30-44AD-99FF-C5394C5F3B30@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C8A2DA3C-8D30-44AD-99FF-C5394C5F3B30@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 08, 2021 at 11:34:02PM +0530, Atharva Raykar wrote:
> 
> On 08-Jun-2021, at 22:53, Emily Shaffer <emilyshaffer@google.com> wrote:
> > 
> > On Tue, Jun 08, 2021 at 07:21:14PM +0530, Atharva Raykar wrote:
> >> 
> >> It's pretty safe to say that most of the regulars on #git-devel are now
> >> on Libera Chat. This will help new contributors find the right place, if
> >> they choose to ask questions on `#git-devel`.
> >> 
> >> Since there seems to be no way to directly link Libera's web chat to
> >> `#git-devel` directly,
> > 
> > I just typed "web.libera.chat/#git-devel" and it worked perfectly fine.
> > 
> >> I have put a generic link over the text 'Libera
> >> Chat'. Users will have to manually type `#git-devel` in the webchat
> >> interface, but that should be obvious enough to not be worth mentioning.
> > 
> > Generally, this is a bad approach to take for absolute-beginner
> > documents like this one. Even if it "should" be obvious, why not just
> > say it? Some skills - like how to examine the compiler errors from your
> > C compiler and fix your code accordingly - are a necessary prerequisite
> > to be useful on the Git project; other skills - like how to use IRC -
> > are not, and we can teach them, especially in a guide like this :)
> 
> Got you. In fact, the fault in my reasoning was perfectly
> demonstrated by the fact that I did not attempt one of the most
> "obvious" ways to get the link to #git-devel directly.
> 
> I cannot decide what's obvious for other people :)

Or maybe Libera thought it was too obvious to document? :thinkyface:

Thanks again, looking forward to v2 :)

 - Emily

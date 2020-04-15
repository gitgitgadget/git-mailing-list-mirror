Return-Path: <SRS0=MaRY=57=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B327C3815B
	for <git@archiver.kernel.org>; Wed, 15 Apr 2020 18:07:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22467206D5
	for <git@archiver.kernel.org>; Wed, 15 Apr 2020 18:07:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nkl5+JQS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411692AbgDOSHg (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Apr 2020 14:07:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2404936AbgDOSHc (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 15 Apr 2020 14:07:32 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A1ABC061A0C
        for <git@vger.kernel.org>; Wed, 15 Apr 2020 11:07:32 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id f52so794765otf.8
        for <git@vger.kernel.org>; Wed, 15 Apr 2020 11:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Uranjikxaa6itGs63EfADh0GqSh/vIoKUHZ+mUHQS5o=;
        b=Nkl5+JQSdI1ZhBw68Yzaupgb0u/EWr8m5sMCdUsAw11G7UhkibSKYdmCi7SJRTFMAK
         aCEE8W9N+pKMGe3SdjblPG7Kq2ECQziMi72YIOF6uYCKAKpHjibGZsv0Gh+Pi35wkO9X
         hvNcoG+NeTYQeVFcH6Lc0vlaxBfkKOSFX7lEH2nbzdc/noiHVxMQpV0P5C/74ZS9S6ft
         CGpiX6SEOct3ZffbzYagXQvswTnxWVM4vcJvklt4k/zm8gvwLRsrrAu1rokmld/hJG6x
         u7l/w6KoZbrYN1TydkZuXdspjIhqoa9m0wTTAiNXsflQqLMkqAPbFrdxQg0W7NyCWlFf
         +j5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Uranjikxaa6itGs63EfADh0GqSh/vIoKUHZ+mUHQS5o=;
        b=FYsRLmoovut+MxEvG3sfWx+pBw1b1c7rQIUSXNL64PsExxFLmmROjF34BJfNiqMQUm
         LCoS28yPu9AJLzYJjGjrkqsEOcQqYYy5NlrVa8kve5mFLJ5w2teR1g8qu/XIbTAGMHn1
         ldQBtRuAM8KhOILix959XPTM2wa49J2Y7dx+2ZvPFyCa8aIkJFMYtw2Lg1b+sSvngzQv
         Ukv/hRHmO79CMLLX1XnEKXXRZXhBM/SLEFQw4V4mIjOwy46CXqYWYkSHv+KuC/XaqoKJ
         kny95Q03o+unTSIsbxgRB6hPwgploS6qGJVRHZU4m1mDNpZZzPPRLmYhyPosTOFjIzJF
         L/5g==
X-Gm-Message-State: AGi0PuYORX2xr4lAeIu5piQB5McHqp6VVspVbWlR0x3ncoR7zl3K65Ab
        4fRAuLPfWKJ9mxIT0IlXF/Bc47/X8TSfapgwXMegJWSz
X-Google-Smtp-Source: APiQypL8ZUkSbn0XzEOwKnZnre3swlrC7WWfjS8RECAu7TWhVrIxf0DavIhNj+zf7Oh0WOLDgZgt8xKKv2IdoUKZLKI=
X-Received: by 2002:a9d:5e0d:: with SMTP id d13mr24160861oti.162.1586974051697;
 Wed, 15 Apr 2020 11:07:31 -0700 (PDT)
MIME-Version: 1.0
References: <CABPp-BHGubUX5o9KsQaoh_UFjFh2PaMkkJhCao+5LGnFc0dQNg@mail.gmail.com>
 <aca12331-f8e3-28a2-acb6-df9d7e2e70e1@gmail.com> <20200414235057.GA6863@syl.local>
 <cdc80c0b-696f-19b8-d132-592782537b03@gmail.com>
In-Reply-To: <cdc80c0b-696f-19b8-d132-592782537b03@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 15 Apr 2020 11:07:20 -0700
Message-ID: <CABPp-BExGQXERFFB0NPk=P12rEzJ=-NvJVZyG-R3S0ziOBdzBQ@mail.gmail.com>
Subject: Re: Is fetch.writeCommitGraph (and thus features.experimental) meant
 to work in the presence of shallow clones?
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 15, 2020 at 4:55 AM Derrick Stolee <stolee@gmail.com> wrote:

> (Please allow me this brief moment to communicate my extreme dislike
> of shallow clones. There, I'm done.)

I share your extreme dislike, but I've merely succeeded in
discouraging some people from using them, not in stopping their use
altogether.


(I don't have anything to add to the review of the patches, other than
I'm happy to see folks trying to address the issue.)

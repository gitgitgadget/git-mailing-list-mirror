Return-Path: <SRS0=1eW7=DV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3979BC433DF
	for <git@archiver.kernel.org>; Wed, 14 Oct 2020 18:22:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C69692222C
	for <git@archiver.kernel.org>; Wed, 14 Oct 2020 18:22:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="In6ov30g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729851AbgJNSWE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Oct 2020 14:22:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727146AbgJNSWE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Oct 2020 14:22:04 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A57D5C061755
        for <git@vger.kernel.org>; Wed, 14 Oct 2020 11:22:04 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id ds1so185720pjb.5
        for <git@vger.kernel.org>; Wed, 14 Oct 2020 11:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DfyzOaXlzFS/fKsCqylkc+ttOvxi9s6N8zJGVjGTnkA=;
        b=In6ov30gCM2iB1jamZRPRWia7w7UCtz64s8Fic12UkY1ok8Ff7urDkpXf9V2tLGKTg
         pTQ0MAVcVcYJYLo25WWtT5WczOs8okJZnDD5lIs4Pij5xTVj1pdQp9QcUIgp3j9lYSkP
         GnCSlGzuAlZ1fCfi2xeX7mEMW2jwrCSyEeOCIRYpj+UHmwn08D47C4q4sVajRSQ93+gz
         MHei3FP4eyNUOLnejkErsgilImLVsufnDxNboVC3em+9ce5ZMs98iWfZKq8wyJnQTK9Q
         9nhQJcOzR+1WCJSJ8Vw5flxgoQ9L5ZnrPzA0HDzXyupIkvoOzj/e35xDZduNsOPJ6GSR
         x1yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DfyzOaXlzFS/fKsCqylkc+ttOvxi9s6N8zJGVjGTnkA=;
        b=oRyGnAxfNGHTXyCTf98kWXFEtnqUkzP/MFGZIZ43wzuZ1ZYXU9Y6yO4xDn+r3MvCLG
         V3PZrJMTNYy/MphFc9Ttil7GqXQ2Fh4+zZ2O7hLcrnSBxDseyKuoopy7mmHMAZWYFP+S
         3IUhq3u20O82ChpovUuM2pyYBrbt/3gitLByRNttfqURcBfhCa2occVx2ya+MRZEO77N
         oIny9CzvbVJVbmZXiCAMCCH3nX6ptKn34QZyBv23FFZHAxjhF7w+V+wUv//1kVpyY999
         R6B8CfQnNBDG9U5ZD+wGABCWK1W2gw91l81e8zcXC1XzE3MBrO/TnwYWZkucDbJjuHM8
         S1YQ==
X-Gm-Message-State: AOAM5314o3/K9ZNx9cFGUsSDSHiQkWMB5VHwOVILQKk2hUXiVpnIjOj1
        xz7KhLZQVYV+Uyb+0ZZQ1zCzCzQvXPrFk6bOwVU1Lg==
X-Google-Smtp-Source: ABdhPJx7pOunk5JTg8LrfAeW5ZD46AueDncPd/pnpb/TcPJXCEOemZOkbG9h2Pa3dK/McZ9RceRev9hq0XsOlyvlxR0=
X-Received: by 2002:a17:902:b113:b029:d3:c5c2:e667 with SMTP id
 q19-20020a170902b113b02900d3c5c2e667mr329628plr.35.1602699724045; Wed, 14 Oct
 2020 11:22:04 -0700 (PDT)
MIME-Version: 1.0
References: <20201013191729.2524700-1-smcallis@google.com> <xmqqblh5kggd.fsf@gitster.c.googlers.com>
 <CAM4o00es=6bksufcu7UvLfPxSS-9NndD2ALe74PRvQjBdHci5g@mail.gmail.com> <CAPc5daW4oqQHNJJH-jTJNaqiNJDLdtscfvNMpgQUOJhDf-Jj1Q@mail.gmail.com>
In-Reply-To: <CAPc5daW4oqQHNJJH-jTJNaqiNJDLdtscfvNMpgQUOJhDf-Jj1Q@mail.gmail.com>
From:   Sean McAllister <smcallis@google.com>
Date:   Wed, 14 Oct 2020 12:21:47 -0600
Message-ID: <CAM4o00er7HiGwP+-X4t_Z-HsEZMeihLP2x3TqTWGphCdtM-arQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] remote-curl: add testing for intelligent retry for HTTP
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Masaya Suzuki <masayasuzuki@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 14, 2020 at 12:14 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> > I modified it to use echo as the standard, it turns out apache handles
> > properly terminating lines for you
> > with CRLF.  As for the lone echo, a double CRLF signals the end of the response
> > header and the start of the body.  Curl doesn't behave properly without it.
>
> You misunderstood me.  I wasn't questioning the need for a blank line.
> I found the inconsistency puzzling that all the previous ones (above)
> were done with printf and the later one was done with echo.

Ah yes that was just sloppy on my part =D

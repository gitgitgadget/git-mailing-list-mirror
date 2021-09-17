Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.2 required=3.0 tests=BAYES_20,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DC8AC433EF
	for <git@archiver.kernel.org>; Fri, 17 Sep 2021 18:20:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A26E60F70
	for <git@archiver.kernel.org>; Fri, 17 Sep 2021 18:20:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344292AbhIQSVu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Sep 2021 14:21:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344255AbhIQSVt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Sep 2021 14:21:49 -0400
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DE06C061574
        for <git@vger.kernel.org>; Fri, 17 Sep 2021 11:20:27 -0700 (PDT)
Received: by mail-vs1-xe2c.google.com with SMTP id n17so9628069vsr.10
        for <git@vger.kernel.org>; Fri, 17 Sep 2021 11:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m7NYOzpWOw4/4mQiAO5y4s72inXaQGwMHJRU3IQ0zhk=;
        b=nwqnFOibx2GWAVFi1NwqcFZNaxXgkzsCg9WfTD9i/uKWnFcYkUOTD36ygO2iR+bXzy
         WY4bvuo6bzUzWVRRRYN/ZgFu5wdRic6YOXHXEu08HSjr5V6nwax3debyNR0BC6/Ffw/+
         /GMZB6vdYyeyGSfYn2TLzG1gGzXec+hoBNoLLRGrt+I/VuMn6nx58rE3Q5SRELJrjrx/
         ZEVNVhgC7M3+97/KaopYB/9PsiMqQE7M/cpwN3lyZu5ZCvCwWuhXcTvriKa+VwqpT0dg
         lW5Gz/zT3fW7pcoIqHf44S5Slmlbrn8mi7r2pklZxb0sByg7aYsPy79mnwTnNQynO7rD
         V2dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m7NYOzpWOw4/4mQiAO5y4s72inXaQGwMHJRU3IQ0zhk=;
        b=SNcV0DSa5hs7DCLe8we2X/heALM68k9gCa5azjjlRfL6aWivOzJcc6iSOcIlxQpCdE
         eMatANfXUj2MTbk/nBQWVpTEsrjuVBG/TiOYWRCnsFrOJFX7qMUDNx2dogcaY3IAjA92
         XqeETgRjnEjMdQBNRaNJ4F/AAIsBT4YGApvfcp4msUaSCtt7NW9k2zFQINDbWBlRIsix
         /DTMnIc4r4ww2Ckdq1U4jXRy55CWg2E52gx/BVhtQq7ZQoSe9L8bJs4Wk1M7oG24/a5g
         s+uEuPeGFN+d3SVzW0y2j/0PthTvC5LQduTqy6zihlDEDF5RCrf2AgaqdNgVza9uCOgE
         ouww==
X-Gm-Message-State: AOAM533uH+xb7OU+s9OqRD9pSFtqOQmnOaMRpE4cdoo8PZIzw/VrpBfJ
        eozcama+SJzK+mCj7aB1hp3YkCyeaeIf+rfVhAFbMJc8
X-Google-Smtp-Source: ABdhPJy7w30IQmXskNiHo8AxGshjYpYVAGfMDwT4HAnmJ+vXESqlTg5ZfTsznkU8atMwMMJYugcvMk9rBApMa93Py6U=
X-Received: by 2002:a05:6102:518:: with SMTP id l24mr9935948vsa.57.1631902825886;
 Fri, 17 Sep 2021 11:20:25 -0700 (PDT)
MIME-Version: 1.0
References: <0c68d628-e093-1cbd-e3bd-38a827545418@gmx.net>
In-Reply-To: <0c68d628-e093-1cbd-e3bd-38a827545418@gmx.net>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Fri, 17 Sep 2021 11:20:14 -0700
Message-ID: <CAPUEspjbiNtffXatzNUUFYyZKRjcqetOTVqQX+MgZf_AJq9hnA@mail.gmail.com>
Subject: Re: Should `@` be really a valid git tag name?
To:     gitmailinglist.bentolor@xoxy.net
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 17, 2021 at 7:12 AM <gitmailinglist.bentolor@xoxy.net> wrote:
>
> A SO commenter pointed out, that git-check-ref-format forbids @ and
> maybe I should report this as a potential bug. Is it?

a reference that is named "@" only is invalid, but refs/tags/@ is not.

Carlo

Return-Path: <SRS0=bNai=CE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EC69C433E1
	for <git@archiver.kernel.org>; Wed, 26 Aug 2020 01:28:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81E4120737
	for <git@archiver.kernel.org>; Wed, 26 Aug 2020 01:28:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbgHZB2m (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Aug 2020 21:28:42 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:40793 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726610AbgHZB2m (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Aug 2020 21:28:42 -0400
Received: by mail-ed1-f67.google.com with SMTP id v8so283189edl.7
        for <git@vger.kernel.org>; Tue, 25 Aug 2020 18:28:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+8bflNbMoJIaTnxjXlr5eruVzgnHiFWs8YwAyZeWhZ0=;
        b=W1H5GFb/9UojNjuYS5yckCnI8czUxNurVjQwDWdWRGV/l8Ye0lsx+1cYYFC/sKYmXn
         vrvTqFQv1JKsBNy8ufsL73OGkG5ohtPjxDnc81kLTVscV2KFtCSB+Vk/eENeuc/njhk7
         juIGwyjBEib+ApJwvH9f5/jM11rGzwVL/HkIuaS0a6GLuDagzavOvjf2ygDcR9Re3/QD
         aNuoF3xfYpxhiHvsSalUlIL/br0ZMI1y/jK/1FG/bpXpX2hRN9OtKez4xLwA8X3S+bn5
         jM8bXF22jjoHVNe/unwTeNJC94ltM2NOfb0gRYui994hz2+a2PbBOXg/h2uLjj37PTPy
         1AIw==
X-Gm-Message-State: AOAM531uq2rJSFyhnZUt3qYPxn5Ypaq/BT2PRlfwJv3vZTOHbtiWZo1K
        uEiX9lq3KRjcnsf774uDvffpG1wCEqebBzyfXm5oC2Hk
X-Google-Smtp-Source: ABdhPJzELoGK1VZfT/8JNNBlDPQHFSzJ8h7hXzqi6lnXLm3J9OdTthnJNFnK/+aPJkd0qCOBMfgEXVQkFgfrJO65EbY=
X-Received: by 2002:a05:6402:2:: with SMTP id d2mr12944908edu.221.1598405320461;
 Tue, 25 Aug 2020 18:28:40 -0700 (PDT)
MIME-Version: 1.0
References: <xmqq1rjuz6n3.fsf_-_@gitster.c.googlers.com> <20200826011718.3186597-1-gitster@pobox.com>
 <20200826011718.3186597-3-gitster@pobox.com>
In-Reply-To: <20200826011718.3186597-3-gitster@pobox.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 25 Aug 2020 21:28:29 -0400
Message-ID: <CAPig+cR-eYCVQLRa0rVhgJ8L60-zCS_aK6_nVERcrXSyApdihw@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] cvsexportcommit: do not run git programs in dashed form
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 25, 2020 at 9:17 PM Junio C Hamano <gitster@pobox.com> wrote:
> This ancient script runs "git-foo" all over the place.  A strange
> thing is that it has t9200 tests successfully running, even though
> it does not seem to futz with PATH to prepend $(git --exec-path)
> output.

t/test-lib.sh takes care of that for us, doesn't it?

> It is tempting to declare that the command must be unused,
> but that is left to another topic.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>

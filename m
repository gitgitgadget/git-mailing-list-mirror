Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 771091F405
	for <e@80x24.org>; Thu,  9 Aug 2018 22:03:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727115AbeHJAaQ (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Aug 2018 20:30:16 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41259 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726764AbeHJAaQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Aug 2018 20:30:16 -0400
Received: by mail-wr1-f66.google.com with SMTP id j5-v6so6456238wrr.8
        for <git@vger.kernel.org>; Thu, 09 Aug 2018 15:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=WHlYnE4kZv/2kCU859NIYfHGYfBeTnoMWBXk70iQ9wQ=;
        b=Exg848XcYbSGqjBoVsvZkTAEyzx8CsU3gZD2oW33G0hnp012niQNiWKfilV4GqBAsw
         1NCQaO36MwDUQmwUMleXaj6p85obJH5xFCp7pN7X7PKiQdHTSGVZPUJMU+nM6TQB64le
         aLK97Or3MyXwqnRPNxBCRRr6W+Mi77PVi5QxHoUJFIsJv4VfipFf0aucZYmbUeJw5x5+
         pVIFh1u4VHIAfzlfccn22Ar8qPZTDnEsJaCvDw+ckNFVfQBGnmnFZrVuM64lQL3UANSC
         I5AGSMglZ9czOl8FNFO1sj0vpE8UakQ7SSeqRw0EfpY7wJbnOmgyD3NcZD2U6DtORz9T
         NeoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=WHlYnE4kZv/2kCU859NIYfHGYfBeTnoMWBXk70iQ9wQ=;
        b=MjpMI1E78UKC5YiJqyw3FRCz6ZYZ8o5ws+L3ZBPPiuS8AJGixvanOCKRp4r/sQfyih
         rkcNzSj2MUegUVv0xw752BqTBIr/wls0mJ79C8VEApHrQeQ6VcP4ZyVlvnmmLq5PFKM5
         111AXR31BQfCd5XGu0GKJSIp9Z0C1cnEWWusRhhxFQYZ07Waa3JpFEBp5oCZbDKnTfYD
         Gj/bwp6fSU0IxdCOcg8gy7vGhKjXkqEDyebzf82CB9JJhJ4dJ1gmv86RoP1OKvVmRmrm
         laIrSo1HSQAfI5vov3yYq/P33I2tqwY/m/BbTMkST2+q5Y9RyzxrsDYr4pjOXq8kEF1c
         ZtDg==
X-Gm-Message-State: AOUpUlFWsx2NdAgIgTBU27d8RXs5JwnT0lwHByHbtId1ZVdlRJUKheYz
        AVPRED6YYQGQCfqRPrKXsAIWGLcn5qZ9g+9U60yX3L29Ysg=
X-Google-Smtp-Source: AA+uWPwXrHPqcc0K0d33OuhTAQa94pjZnBkP2wQrh3HP91F9P6QLReNrUj1JKp3dQDL6+6mlRjfe7GEuH5O2QpCr5NY=
X-Received: by 2002:adf:f689:: with SMTP id v9-v6mr2466096wrp.201.1533852205188;
 Thu, 09 Aug 2018 15:03:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:f00c:0:0:0:0:0 with HTTP; Thu, 9 Aug 2018 15:03:24 -0700 (PDT)
In-Reply-To: <20180808232515.GC21882@sigill.intra.peff.net>
References: <20180808231210.242120-1-jonathantanmy@google.com> <20180808232515.GC21882@sigill.intra.peff.net>
From:   Jonathan Tan <jonathantanmy@google.com>
Date:   Thu, 9 Aug 2018 15:03:24 -0700
Message-ID: <CAGf8dgK_yMEtyh+_chQ+9i2d1Uc9oAXr7Q_8ES5OPF8qF87EHw@mail.gmail.com>
Subject: Re: [RFC PATCH] packfile: iterate packed objects in pack order
To:     Jeff King <peff@peff.net>
Cc:     Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 8, 2018 at 4:25 PM, Jeff King <peff@peff.net> wrote:
> Even if you just use the oid to do a separate lookup in the object
> database, there's still a benefit in accessing the objects in pack
> order.

You're probably right, but I don't immediately see what the benefit is.

On a not completely unrelated note, I just realized that in my patch,
i should be pack_nr (ordinal in pack order) and pack_nr should be
index_nr (ordinal in index order, i.e. alphabetical order). If you run
with this, feel free to write your own patch and maybe I'll learn how
accessing objects in pack order benefits looking up the object
database through the commit message.

> I can try to pick this up and carry the cat-file bits to completion if
> you want, but probably not until tomorrow or Friday.

Thanks - feel free to do this.

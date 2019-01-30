Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD8F61F453
	for <e@80x24.org>; Wed, 30 Jan 2019 12:32:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727515AbfA3Mcy (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Jan 2019 07:32:54 -0500
Received: from mail-qt1-f173.google.com ([209.85.160.173]:41984 "EHLO
        mail-qt1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbfA3Mcy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Jan 2019 07:32:54 -0500
Received: by mail-qt1-f173.google.com with SMTP id d19so25967038qtq.9
        for <git@vger.kernel.org>; Wed, 30 Jan 2019 04:32:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ehDmaxYsMPP9Cp8UpYf3IhCZgVfUaS++WpGuiUPIZak=;
        b=ppfutp7C0jI+1ZUVEiMEvu7Uj5QSTApF9aDT4CCqxniGwsY1rckU940Od7HF0ERQZq
         3W6WrSzvkQGrhZ7u5Jd+6hTo9yUigcWYnt6lHfi6WSvjsCaiyeD4VmX9doH1oZHvHe0C
         vrNCyXYqs45wn+buYAgdWCHNmVBuFheCxYdfQkrBv3MwwdEBn3nvPYeiZ6yQbV2/PtFw
         oIWT+lkxUhFbmmNhU8N8oJJ5Ylc+NeRkhKx/g2wt4tRUycIJLCOGuEoW1QowaE3uQXiu
         PQ5oTb95jwK/7wspjP7DvRO/CfQzctqDxclBllppuK4v7gPtcgQL66w4wYkMxyuDUfeV
         87Ng==
X-Gm-Message-State: AJcUukd9an3sc0oxor7JwsQpLcDI3olhTcy6epW0Gplb+viwmgTnW7qv
        /lArhws7BEMM/sNWmVMPFO0gLHPOX5xhAo8SnEE=
X-Google-Smtp-Source: ALg8bN7R0vRNWiYoe8BSlZm8nChQHlR/tD2DmoMrQInbW5Y6UDUEd//A7CtCzCnodrUT59dPOzVr+djlgnK/+JpZfdo=
X-Received: by 2002:a0c:86c1:: with SMTP id 1mr27597589qvg.6.1548851573046;
 Wed, 30 Jan 2019 04:32:53 -0800 (PST)
MIME-Version: 1.0
References: <20190129193818.8645-1-jeremyhu@apple.com> <20190129193818.8645-2-jeremyhu@apple.com>
 <CAPig+cSkm-M7fP=KLOCO5J8OSYCEyjy950AM=VzTnP9C6AcKxw@mail.gmail.com>
 <534F20EC-2B29-46C3-BAD9-3CBE7312257F@apple.com> <CAPig+cSwMpTY0StCYBaF+oreZebyOUqFRqj1ABukHkdLY9PyEw@mail.gmail.com>
In-Reply-To: <CAPig+cSwMpTY0StCYBaF+oreZebyOUqFRqj1ABukHkdLY9PyEw@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 30 Jan 2019 07:32:42 -0500
Message-ID: <CAPig+cSFs-c_--rkf-sqx0a5Ern0GTO4K8_K97ca_6bNcxNc9Q@mail.gmail.com>
Subject: Re: [PATCH (Apple Git) 01/13] .gitignore: Remove *.s as it matches
 *.S on case insensitive filesystem
To:     Jeremy Huddleston Sequoia <jeremyhu@apple.com>
Cc:     Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 30, 2019 at 7:29 AM Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Wed, Jan 30, 2019 at 6:37 AM Jeremy Huddleston Sequoia
> <jeremyhu@apple.com> wrote:
> > > On Jan 30, 2019, at 03:33, Eric Sunshine <sunshine@sunshineco.com> wrote:
> > > On Tue, Jan 29, 2019 at 3:11 PM Jeremy Huddleston Sequoia
> > > <jeremyhu@apple.com> wrote:
> > >> This was causing problems with ppc/sha1ppc.S
> > >
> > > What problems, exactly?
> >
> > The file is ignored, but it shouldn't be.
>
> But what problem are you experiencing, exactly? .gitignore rules do
> not impact tracked files such as ppc/sha1ppc.S, even if the name
> matches an ignore-rule, so it's not clear what problem you're trying
> to solve.

I'm guessing that this has something to do with HFS+ being
case-insensitive yet case-preserving, but an actual explanation of the
misbehavior experienced would be helpful.

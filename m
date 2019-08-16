Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 735121F45A
	for <e@80x24.org>; Fri, 16 Aug 2019 22:39:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727835AbfHPWj4 (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Aug 2019 18:39:56 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:45435 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727805AbfHPWjz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Aug 2019 18:39:55 -0400
Received: by mail-vs1-f65.google.com with SMTP id j25so4678776vsq.12
        for <git@vger.kernel.org>; Fri, 16 Aug 2019 15:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VX55dHFXvJe8pyHkTCXl7TDyf2Bm7Q4NojWLcy9IIJ0=;
        b=VTxXrvOzAzjRqJ5VxxIwckLPNlaFdTMo7whcv1ZYOnFOV5GHfXHha0KOTFlyO7ox6Z
         dKk8UzvDl2nz2FvONcfZkCaS6sNers5eXMD0tXGDe8gbm4s6MEks3kjrtfqtjqzWsx1e
         4CUhEyZtVg7dJ5qyPUyD0kuv6PPPjPbON5/X8GAXZ35HYjXUQwRyPAWlAlpAuHK+ga50
         HZtxUSAGizrKo0TBa9s2M3lD0T9BNlekskT+Pt/wZXfO8gc3OJ1Jg+T0i8gyOtqHr1IO
         fhHrYsLRn4RG2GW8xq8XCzWt43jr0kBJ6YoFRBlE6N8AhwoIE+wdA8jr22xkhyPyCy7t
         XCCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VX55dHFXvJe8pyHkTCXl7TDyf2Bm7Q4NojWLcy9IIJ0=;
        b=qcuFeKePeQvs3BATI0kuKXUS7DGZjeT4Hr6rzwnXZr4NaUy0l4DKlOIZpT/3uifTWq
         T/vj1qkUxzwFwcl21khWssS11D0wdYsEgweXgXi2BuGRLRayz6mSSbSB/vVzxMSZMney
         Xc069osOU4GsGaDCHZ2Tb5YmrqY9sSUsHrj+yD/PwjPC50GQpUmae+gycmslTAvXmr2v
         C/6AH4oHdOjFn7WvovrWbzaqiErNLA8qumBJqF/qCVCUXres8gjvulx/9BL/vBF6dtBN
         U42VJixHWE0YN3wvuoTZEIfCpa+yXYV3PV+fMA6GNqcr1pO7NNk65jj1FWo8bdKlOcvm
         yaMw==
X-Gm-Message-State: APjAAAW7IeJfargcIuFALK1aV+87mmhKRV6l2KmExEZtItrU/oOttbLm
        itwouS5G+5SmmYnZDYlHaLNTlJ5WZzBIfQwayto=
X-Google-Smtp-Source: APXvYqxVMMcGxm+GNCheNV0El+NP0R4mBP7g0LjW8iLtDGzkCmCjBFGymZ8YwyytWlppxNyKjvfsQbivMqEqVwPCeUA=
X-Received: by 2002:a67:fd13:: with SMTP id f19mr7656658vsr.53.1565995194401;
 Fri, 16 Aug 2019 15:39:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190726155258.28561-1-newren@gmail.com> <20190815214053.16594-1-newren@gmail.com>
 <20190815214053.16594-13-newren@gmail.com> <xmqqlfvszs5n.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqlfvszs5n.fsf@gitster-ct.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 16 Aug 2019 15:39:40 -0700
Message-ID: <CABPp-BENt6ejUNOxorXPXywb72hsD+1Hs1Gja6ZsfrUsMrTkpA@mail.gmail.com>
Subject: Re: [PATCH v3 12/24] cache-tree: share code between functions writing
 an index as a tree
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 16, 2019 at 3:01 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> > write_tree_from_memory() appeared to be a merge-recursive special that
> > basically duplicated write_index_as_tree().  The two have a different
> > signature, but the bigger difference was just that write_index_as_tree()
> > would always unconditionally read the index off of disk instead of
> > working on the current in-memory index.  So:
> >
> >   * split out common code into write_index_as_tree_internal()
> >
> >   * rename write_tree_from_memory() to write_inmemory_index_as_tree(),
>
> Somewhat minor, but I find "inmemory_index" hard to see while
> scanning the patch.  Perhaps call it "in_core_index" instead?
>
> I originally started the above with "Very minor, ...", but as this
> is exposed to the public in a header file, the name matters a bit
> more than that.

Sounds good; will change.

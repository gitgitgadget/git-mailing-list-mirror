Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 629F91F453
	for <e@80x24.org>; Fri,  2 Nov 2018 06:15:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728410AbeKBPVf (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Nov 2018 11:21:35 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35772 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728024AbeKBPVf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Nov 2018 11:21:35 -0400
Received: by mail-wr1-f66.google.com with SMTP id z16-v6so801822wrv.2
        for <git@vger.kernel.org>; Thu, 01 Nov 2018 23:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=gVbzulx0ozAvvXjmj/rLzQQaDcDUbrjstXhevROT5Yw=;
        b=LJR0kDVRe9A4KiKwCmZ985mIdSXXACIJm1fl2/cScEp09yJAc8dg1ALfUPpc1cP0CZ
         iz+mx5lQ4IwhGBoCtWJXUBoDH/WZG3sgRSfW4BmfQNomzs2NdioH8vrRekyyegYGhUEb
         +LmFbiU8lLdf4jmzw+Dz6k5G7Sdnn8/Vp9XyVBSDh6ykzYkGs1nli8RA97qmudGJnrWJ
         IiYh6cAMx29epFfJANMd/Z2p74mjKwrYA+vSs74pJdoZCh+UmQ9OLnRNLnKDvp4h8/Nq
         vjQTBYFpNDyMk5/Jc+8YZ/Cd8hDzlcxOr1ZzP52hYhQZJloSlcLJGAADclV2NwjaUqLa
         revQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=gVbzulx0ozAvvXjmj/rLzQQaDcDUbrjstXhevROT5Yw=;
        b=dUjsjAHhReO8jWk7/mw7BBhH+LIfYeIHgn19aNOXnPvw/GNcNg5Q6omITPhYu02/Ac
         aM1ERZ6zAVHysmYfvy7Lu11/iJMdrP0doSi7+N+zF6sFqW+HCuO3GaLYC8WYYlClEJJj
         AOsGXvJ6harrIqvCiVE0pMclQHv4z0NYIuUgZni+mYmMpnTL47EEe/bqCVJ6f6cyrhX0
         0rXaRyIWEkXdy5iXBtuDzqeMZzo3H26O/iI8kv6/QAM5F1ZrSFYcop96IjqppQ71m1t6
         k6U/mZjE2v5zwnmrFWW6W+gKVGi9l80NEG/BHeu0bQTGSVnJHwjXibrZOQnD9Kzli3o+
         LpXg==
X-Gm-Message-State: AGRZ1gKYMCWLj/7QnRJJMhCESh/EO4u1RLRLvDe6tTJKZCOUCVw8B+ib
        8nM0kbgpbZzhf8bJUy/XSmU=
X-Google-Smtp-Source: AJdET5dFXnWEVdDBK5xSyGiZ5Obfku8Du4B/ZSbw1OnAr5epjyD3bhjH/4R4PqaHgAuXHuMVO52Mew==
X-Received: by 2002:adf:e1ca:: with SMTP id l10-v6mr9379706wri.36.1541139331621;
        Thu, 01 Nov 2018 23:15:31 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id x139-v6sm398158wme.3.2018.11.01.23.15.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 01 Nov 2018 23:15:30 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Farhan Khan <khanzf@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Understanding pack format
References: <CAFd4kYBDWMvVgDmNTzwOK9Q7n_Fb0NrvNAFgHtKvkLkRFWqUKw@mail.gmail.com>
Date:   Fri, 02 Nov 2018 15:15:29 +0900
In-Reply-To: <CAFd4kYBDWMvVgDmNTzwOK9Q7n_Fb0NrvNAFgHtKvkLkRFWqUKw@mail.gmail.com>
        (Farhan Khan's message of "Fri, 2 Nov 2018 01:23:15 -0400")
Message-ID: <xmqqlg6covi6.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Farhan Khan <khanzf@gmail.com> writes:

> ...Where is this in the git code? That might
> serve as a good guide.

There are two major codepaths.  One is used at runtime, giving us
random access into the packfile with the help with .idx file.  The
other is used when receiving a new packstream to create an .idx
file.

Personally I find the latter a bit too dense for those who are new
to the codebase, and the former would probably be easier to grok.

Start from sha1-file.c::read_object(), which will eventually lead
you to oid_object_info_extended() that essentially boils down to

 - a call to find_pack_entry() with the object name, and then

 - a call to packed_object_info() with the pack entry found earlier.

Following packfile.c::packed_object_info() will lead you to
cache_or_unpack_entry(); the unpack_entry() function is where all
the action to read from the packstream for one object's worth of
data and to reconstruct the object out of its deltified representation
takes place.

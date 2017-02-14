Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 33AF42013B
	for <e@80x24.org>; Tue, 14 Feb 2017 22:45:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750783AbdBNWpM (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Feb 2017 17:45:12 -0500
Received: from mail-it0-f68.google.com ([209.85.214.68]:35863 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750731AbdBNWpL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Feb 2017 17:45:11 -0500
Received: by mail-it0-f68.google.com with SMTP id f200so7754068itf.3
        for <git@vger.kernel.org>; Tue, 14 Feb 2017 14:45:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=JDx+9U17jYUzL/+iZdtnSmQBZNIHCN4+BwLRPnAGWgA=;
        b=ApzrfPxcJ7HarjtqkHXH4EBEYsQ8Z/5iR+4OCNBjQ4aHOtVhs5e4TgOKh1VOeuEWrp
         IdvA8ZwpMjHU4cLJAmZOM8gHxewROjJx7vTOI5IPJjtqvRU9rYgA/IWy+d0ZXViCE63J
         Rds6Ky9UTptSmHrNpq0NvAYyeawr7EsgXn5+1p/+5+gfjNBc4z/XbDpkZKch2NGntjpo
         5iogXTOP06PvEiScIn7hDJS4pZi7dJM4XhND85KstYGSONiVxaMjnrMA1slLkGfZH0ZS
         YiDPeTyR0bIlCuxpeIVnMvNT56rG6FadjRqwChVPvBouX15OsUilofZaUpnxqWsfA9Ky
         PyOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=JDx+9U17jYUzL/+iZdtnSmQBZNIHCN4+BwLRPnAGWgA=;
        b=cYAo8EESJmlCr8c6Ue+m5SHWUqMEcl+eMdms5tDa1yFHE13oZ+phcvHQjjyl/bpIQ0
         iiB+XwR1/AVlcII+zsodZxJE809XgQxKDFzxEKG8FkpOXNVByE0p/DemNaAxN5z1vcw/
         Ai0+OpCzIkIHDD85GsPrAUf6ZWODdUAXrbRjoWHehhqi15dP5nFC7Q6+Qaae77lR/SmU
         NDJ62AGXcN9T9+ienXQKcp4C7TzggIE/tu7jyB0knyKgpA934896iydBuosxyUTJewPO
         BPugmdX6boZkby/Hv24WiZOSuMddEj0ss0v3ejqgB8NgF4JnvwsikDEGjoiV9wnQAnHg
         r4zg==
X-Gm-Message-State: AMke39mSliharIjzvp7ITMS2xWSn64iiiirniyPbZ/d7hTnyO3gMrlke15uSuPciB7W+Lg==
X-Received: by 10.84.231.134 with SMTP id g6mr7918440plk.110.1487112310236;
        Tue, 14 Feb 2017 14:45:10 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:2447:f72c:8fdf:75c6])
        by smtp.gmail.com with ESMTPSA id n123sm3172844pga.9.2017.02.14.14.45.09
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 14 Feb 2017 14:45:09 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Cornelius Weig <cornelius.weig@tngtech.com>
Cc:     git@vger.kernel.org, szeder.dev@gmail.com,
        bitte.keine.werbung.einwerfen@googlemail.com, j6t@kdbg.org
Subject: Re: [PATCH v2 2/2] completion: checkout: complete paths when ref given
References: <4f8a0aaa-4ce1-d4a6-d2e1-28aac7209c90@tngtech.com>
        <20170214212404.31469-1-cornelius.weig@tngtech.com>
        <20170214212404.31469-2-cornelius.weig@tngtech.com>
        <xmqq8tp88nnj.fsf@gitster.mtv.corp.google.com>
        <9be8b988-f5b3-7365-ae7f-b46888253f4c@tngtech.com>
Date:   Tue, 14 Feb 2017 14:45:08 -0800
In-Reply-To: <9be8b988-f5b3-7365-ae7f-b46888253f4c@tngtech.com> (Cornelius
        Weig's message of "Tue, 14 Feb 2017 23:13:11 +0100")
Message-ID: <xmqqefz075or.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Cornelius Weig <cornelius.weig@tngtech.com> writes:

> Hmm.. I'm a bit reluctant to let go of this just yet, because it was my
> original motivation for the whole patch. I admit that it may be
> confusing to not get completion in your example. However, I think that
> once acquainted with the new behavior, a user who wants some files
> cleaned would start by having a look at the list of files from "git
> checkout HEAD <TAB><TAB>". That's probably faster than spelling the
> first few characters and hit <TAB> for a file that's already clean.

I understand that "git checkout HEAD frotz<TAB>" that gives 47 other
paths that all begin with "foo", when "frotz27" is the only one
among them that you know you changed, is not very useful to narrow
things down.  

But it is equally irritating when you know "frotz27" is the only
path that begins with "frotz" (after all, that is why you decided to
stop typing after saying "frotz" and letting the comletion kick in)
but you are not certain if you touched it.  The completion being
silent may be an indication that it is not modified, OR it may be an
indication that you mistyped the leading part "frotz", and leaves
you wondering.

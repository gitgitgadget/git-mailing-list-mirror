Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B46BC4743C
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 11:00:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 401BA6100A
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 11:00:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbhFWLDD (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Jun 2021 07:03:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230083AbhFWLCl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Jun 2021 07:02:41 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2752FC061768
        for <git@vger.kernel.org>; Wed, 23 Jun 2021 04:00:19 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id c84so1306912wme.5
        for <git@vger.kernel.org>; Wed, 23 Jun 2021 04:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=3JJDflayThANByjlKevC0NeiviVviDi5Q2Gm87AdI/I=;
        b=YrDnbfbQVhn+Ohg6VIly4bZzQMzunjpm0Ggj7r7ikIZFJNmLifxfk6PYE4xUqB9SMT
         H9KDd1MIVJ3pSwX7c5rVWm1PtFQ/6I34yI5uSnk/wB6mij46YnkL9KkvrP7oBUXwIudm
         skzSNsXaLfci876s79RIzX+nPFBI9JponwWtPctH96Ec4SK5Vwlhk7sIdDxEi/NAKwFZ
         ieS5OJ0LwVvOxzSKj2vy3TdkHTBcU600BYpVB5cncx8wuy5UNnQ1M7DLTtCzb/GJ2DHF
         AERWT2u4uyUIJPmmvJ7CQ9TR0AQXFlLTFAh7zux+PZ8JEhHT2hlM8JlgE+CUwVDWYPuh
         54Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=3JJDflayThANByjlKevC0NeiviVviDi5Q2Gm87AdI/I=;
        b=Fpl6XC1RwQ6WceqvmuJ7T0lHusM1J17v7d/quXtdrDYDlmDwCJPwZN7B/+zzMXsCmb
         Jw3XzqYM3mhqYV0P2nzplBY15zV4A8KhtT+4fqAze6oNmWyVerJmQMjjnx5G4SfKTFDX
         a40UOZJWMSvKHnfjI4C2clG6DTx2CPiKZLeywDORzXBVeRDHEUhudsxAOxQjyf1xCKaE
         fqF45Gi0kCJehzhuCcGx7qUn/QXlWfmsLh6pDH2/6G/GFBz9fyvLvzEo4ylOMN/5rnt4
         F8JohuuwV05fI55aqGUWQpfNOcm/st+tOuOThDWPTj2veDA9rC/gOeqoHzcRnyd3ymje
         +gXQ==
X-Gm-Message-State: AOAM531uAy6fyt4wjRJ/FJzQOLJ/+AipZ3NECFc0EQFvIfVvulUvCqRO
        lgYcLzCJPA3pW4JQENXgTnlY57GNHSO11tT5pMQ=
X-Google-Smtp-Source: ABdhPJzgnfEkZJ7bRf6ZlRjBH84jEC3r/c8Jq9s4ezn+Vv8D/K2508UYQYkBZUOI077F7B1AFwTW7murVdNv0Q+rQq4=
X-Received: by 2002:a05:600c:d8:: with SMTP id u24mr10447197wmm.94.1624446017670;
 Wed, 23 Jun 2021 04:00:17 -0700 (PDT)
MIME-Version: 1.0
References: <CAKuVd4DfvEhXDUvxaU_jjNk8JSZANM8jpSEOxi1cbSAp23ohjg@mail.gmail.com>
 <87czsg429h.fsf@evledraar.gmail.com> <CAKuVd4Bfykm0xe0P5FMy3W8HuECJHqP-RGo+T_VK4hn43sgEpg@mail.gmail.com>
 <YNKeq5mSu3f0A/5I@camp.crustytoothpaste.net>
In-Reply-To: <YNKeq5mSu3f0A/5I@camp.crustytoothpaste.net>
From:   Tim Hutt <tdhutt@gmail.com>
Date:   Wed, 23 Jun 2021 12:00:06 +0100
Message-ID: <CAKuVd4D1qeuY_4+4eXQsU-q5oNw0+40PP46y_65GiNZdSgddCA@mail.gmail.com>
Subject: Re: Bug: branch checkout is detached if the case doesn't match
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Tim Hutt <tdhutt@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 23 Jun 2021 at 03:38, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> I should point out that there is work underway to add a ref backend
> called reftable that doesn't store things in the file system and hence
> doesn't suffer from this problem.

Ah nice - good luck!

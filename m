Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 725D2C47093
	for <git@archiver.kernel.org>; Sun, 30 May 2021 14:30:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45163611CA
	for <git@archiver.kernel.org>; Sun, 30 May 2021 14:30:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbhE3ObT (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 30 May 2021 10:31:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbhE3ObT (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 May 2021 10:31:19 -0400
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com [IPv6:2607:f8b0:4864:20::931])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41507C061574
        for <git@vger.kernel.org>; Sun, 30 May 2021 07:29:39 -0700 (PDT)
Received: by mail-ua1-x931.google.com with SMTP id 68so5077259uao.11
        for <git@vger.kernel.org>; Sun, 30 May 2021 07:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ojrH4ntf3EZCvnMS+NWZGyepCUdbiYDJP7GC81IRgE0=;
        b=TwL6/mm2vAik2XznE8Uvks8B45b7j9//HTBthH6KnMDbi/id0xU3j1Ht+iGCaL81tY
         AqZF3PvvuONtrwtWQmsWGzav+bWNjqaENTFpa5SUP3Y2kc51eAAMBuqblkzr1kFWqu+x
         /uToi2KgBaVUq3wFiYe/CuG950pQamClApv61RxtN3htVJGWiGHhw+fyNo0IxXI9O7y6
         DfWBgEndd8EYF2Z5TMUMoEC+gHhQSj6+Bnc6YciJHPnAdpoVywXlgMlCjAyl+YzDoU6v
         6eQzB6zUkB/BS27fUDcdxfIPhh4nLir8gHerfRPF+QLO30gGIfupkmaODe0CAmqZ4Un1
         jnXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ojrH4ntf3EZCvnMS+NWZGyepCUdbiYDJP7GC81IRgE0=;
        b=gGd763GrYQBkxo0tieql1X40qzhYib+em2cG94PVoObwJuaNf4qKucP/Ev25fDY8cd
         0pciLnLq9w2kFosecjArJUh63KqAw1fbgFkl4r63MHOVv91YDu7JypyH452vqZIS/S0c
         iGa/ewyOMeQPg58TbeWy+4yockjf1rayNMULqRxGkp9F8fCqm9R7XyNENEW6ac2Q5Sgp
         dZNOAqJBVURXNaJ3bS7MAqSOO7HRVJGTtQR02ICPHvUzYif9h2HHT3ff5Oh2tTsf3YHw
         UymhSSeDg6ZwrMgqDWEsVwF778VYakMrtBMLBpnjY23gne9s+ruaRHTcJOryr7TMq9ct
         YPxg==
X-Gm-Message-State: AOAM532zjGogdfIM44qbVzg8mXGts/jseN8/CXvkmtknjrG4bKlpdotW
        FK3Mks+3kzBfka3OmnTF3zV7kAzOYf4AWgEBqP0=
X-Google-Smtp-Source: ABdhPJxBnLXmey72ahjCDe97PLnd6W0nCPfq0txJ9k+t/V8drdvP8VDbwlcvdfxzxloxmK9WmeJ4oCPQjXU9dUUYdWU=
X-Received: by 2002:ab0:4042:: with SMTP id h60mr8206576uad.133.1622384978142;
 Sun, 30 May 2021 07:29:38 -0700 (PDT)
MIME-Version: 1.0
References: <013f42a4-19f4-a935-7068-db3f7ff40446@iee.email>
 <CAOjrSZtWVEUNEuJFw8WGPAW0YNccN9LWyuHZ28aKecdjd6dp=A@mail.gmail.com>
 <7aadc622-ad4f-1d7e-a956-57ab74f18096@iee.email> <CAKiG+9U70wXm7MtTLMUpPC_aHMp58bTtJBbP=NgoAcQQmCPSuQ@mail.gmail.com>
 <7ac2c0f4-e8ed-5676-1f81-3446e33def9c@iee.email> <CAKiG+9UeT70S3_jNXUbx2KCM6UDUxPKMizFX_fUiioDo-zmp+Q@mail.gmail.com>
 <CAOjrSZtRH-sqh8RJm3W00dUWTbT-xcpzDWCQFt=3CNaVnOyVWQ@mail.gmail.com>
 <953d685c-3c89-7377-ed49-b79fb4e0acb5@iee.email> <CAOjrSZuzgBs8camWdUjEU+JOjRYwv3MVjRgnyW50pchq6rpYsQ@mail.gmail.com>
In-Reply-To: <CAOjrSZuzgBs8camWdUjEU+JOjRYwv3MVjRgnyW50pchq6rpYsQ@mail.gmail.com>
From:   Sibi Siddharthan <sibisiddharthan.github@gmail.com>
Date:   Sun, 30 May 2021 19:59:26 +0530
Message-ID: <CAKiG+9WwRHz-5JDPe6KL763kVfRP7vX5HgtDMiX-S1Je5+oWfg@mail.gmail.com>
Subject: Re: [RFH] CMake: detect if being run via Visual Studio, independent
 of build generator?
To:     Matt Rogers <mattr94@gmail.com>
Cc:     Philip Oakley <philipoakley@iee.email>,
        Git List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Danh Doan <congdanhqx@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, May 30, 2021 at 6:52 PM Matt Rogers <mattr94@gmail.com> wrote:

>
> I think the best middle of the line solution would be to just provide a manual
> knob for turning vcpkg support on/off here and offer configurations in
> CMakePresets.json for both situations.  The only downside here is that I believe
> a lot of IDE's are aggressive about running the cmake configuration step and may
> try to install vcpkg even if it is unnecessary.  But automatic
> generation can generally
> be turned off by users I guess.

I agree. I would suggest vcpkg should be used by default for Windows platforms.
This way IDE's won't complain and command line users can straight up
disable this behaviour.

Thank You,
Sibi Siddharthan

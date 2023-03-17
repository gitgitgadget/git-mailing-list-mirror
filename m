Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 261B2C6FD1D
	for <git@archiver.kernel.org>; Fri, 17 Mar 2023 23:00:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbjCQXAy (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Mar 2023 19:00:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjCQXAw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Mar 2023 19:00:52 -0400
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8AF112BCB
        for <git@vger.kernel.org>; Fri, 17 Mar 2023 16:00:30 -0700 (PDT)
Received: by mail-pl1-f182.google.com with SMTP id o11so6873502ple.1
        for <git@vger.kernel.org>; Fri, 17 Mar 2023 16:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679093902;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=4Sps1W+QGrd7nQDerct0xBF+s29GS+fdBeVh6P/dG74=;
        b=O2fTVLSfuBKI3jXN2Q3ZMj0t+w57re6c3V4T3g4jXjsrYO8e4zx9OzgYxUWgvW2jwK
         sWCIAtK1yo9zDgzZZ57LkG5EA0avkFDwKQOAzn47MH0LrpRfUANA1XiKvcnHSF5INtmP
         0gM0WMfBs8nCV0XUzwsabc0GrwT6cVy/ZOCnmCfpBAs2uKEmKhnYg148byyR6WwFVwGZ
         a47cHZyAlAjKA72CP3sM+TkUVEdrXh0c5Zdz89AChnGNKMFRJU74r8HlvcRDCjgoF6pt
         nzfKzkDh1XMuzkrG1Khef+JHbozvQNw6qk4g43tvh+F9HSM2Eqkk/K/JfP9SQrYxM3oY
         Ik/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679093902;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4Sps1W+QGrd7nQDerct0xBF+s29GS+fdBeVh6P/dG74=;
        b=KNhdwrLRynjrq64sZJ8wOXIPMU04Mmzux/ula+PojgfrWRCbuJScUm+Y8tFgAcsmEC
         p6DKAeRCAAN6u2aY9BFWWRqqWZfFne2IMR2GULQQOctTYBc/0FkAl+RncINUM1X4nbCv
         AgGsiZ+kWbdKm9GDroq+sghshA27NIrEE1LEpeaKeOeK4DRQVqUEwOEQbIRO/BGJ/8tc
         5M1I0HzeNcNPRdHRGrG+TfNnqCytorVeLM0b2u6hQtNiQXA8noxEa36iITb18ZKgwykl
         YmaqRYdUNo538C7a35lz1YvjCTNCoff22dEHt5UmF5FuyhLZMSZQqFf389rlK3WYBm14
         NyKQ==
X-Gm-Message-State: AO0yUKWaJSdf4MRP42/5XeMqCYfVuf5ioQzYNC659bqJkA78eFt+XmXH
        PhPaMSN3e6jlR6v6KGcPn+w=
X-Google-Smtp-Source: AK7set8O2716Lx9faNLCAe28hh+CWFHU8Ve6glMmmOv4csqIq1/nzC9b6rXdciNBy6XMLGrVNBhvAg==
X-Received: by 2002:a05:6a20:548d:b0:d0:44ab:e68a with SMTP id i13-20020a056a20548d00b000d044abe68amr11889491pzk.38.1679093901925;
        Fri, 17 Mar 2023 15:58:21 -0700 (PDT)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id z17-20020aa785d1000000b005a8c92f7c27sm2012159pfn.212.2023.03.17.15.58.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 15:58:21 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Kousik Sanagavarapu <five231003@gmail.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH v4] index-pack: remove fetch_if_missing=0
References: <20230313181518.6322-1-five231003@gmail.com>
        <20230317175601.4250-1-five231003@gmail.com>
Date:   Fri, 17 Mar 2023 15:58:21 -0700
Message-ID: <xmqqlejvf0j6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kousik Sanagavarapu <five231003@gmail.com> writes:

> A collision test is triggered in sha1_object(), whenever there is an
> object file in our repo. If our repo is a partial clone, then checking
> for this file existence does not lazy-fetch the object (if the object
> is missing and if there are one or more promisor remotes) when
> fetch_if_missing is set to 0.
>
> Though this global lets us control lazy-fetching in regions of code,
> it prevents multi-threading [1].

Sorry, but I really do not see the point.

We already have read_lock/read_unlock to prevent multiple threads
from stomping on the in-core object database structure either way.

If somebody needs to dynamically change the value of fetch_if_missing
after the program started and spawned multiple threads, yes, the update
to the single variable would become a problem point in multi-threading.

But that is not what we are doing, and you already discovered that
this was done as "a temporary measure" to selectively let some
programs use 0 and others use 1 for lazy-fetching, at a very early
part of these programs.

If we are to reduce this global, perhaps we should teach more
codepaths not to lazy fetch by default.  Once everybody gets
converted like so, then index-pack can lose the assignment of 0 to
the variable, as the global variable would be initialized to 0 and
nobody will flip it to 1 to "temporarily opt into lazy fetching by
default until it gets fixed".  At that point, we can lose the global
variable.

So "we want to reduce the use of this global" is not a good reason
to do this change at all, without a convincing argument that says
why everybody should do automatic lazy fetching of objects.  If
everybody should avoid doing automatic lazy fetching, a good first
step to reduce the use of this global is not to touch index-pack
that has already been fixed not to do so, no?



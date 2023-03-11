Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37D57C61DA4
	for <git@archiver.kernel.org>; Sat, 11 Mar 2023 06:22:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbjCKGWm (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Mar 2023 01:22:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjCKGWk (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Mar 2023 01:22:40 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C34F1CF4F
        for <git@vger.kernel.org>; Fri, 10 Mar 2023 22:22:39 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id x11so7825746pln.12
        for <git@vger.kernel.org>; Fri, 10 Mar 2023 22:22:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678515759;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ColE4u76+T6F7pBnDn6ZdbqqziWG2ohCFEAc9OxrK8M=;
        b=D/XawEfoF+cUfhnkK4UILWsA9M0bxdu81CMK1No0I2abg94QxVMBmHCb1wVRMeTh75
         bO8F1KPyiVnIbH1tPv3NVK6QeDvjelMVPEEd8Tn1brLCPTE2+Bihmjeho8BvqOkXgtNN
         33G+s508izFT3XXG7laROMN8BgNc+DKWme1rrRH4E7bKYvUJuSHU/ZovdQqQyc90r0Z9
         0Vw7K+f4AC9d1LtlEIMOhku12fHqLahSAcl45/lcbxdchzcK9U+ITAEQT/LmwuOHAqim
         reFtWExRiknPbXrWlmT+VVYvG5iX51sk/zF5M0MrqgHjy8Nfhxju3LvVMzOisTmF0Umf
         KSWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678515759;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ColE4u76+T6F7pBnDn6ZdbqqziWG2ohCFEAc9OxrK8M=;
        b=BPzR7EKAxdYkUxM76KS2TCEkT+TrIZy4jQ0i+ZRXMPndejcPkI42A9M2iu/nrAdB5+
         ak9vflPFQyGx3i+cRS5lAGwS/qr5kgv0XTTpYFu6axRN1tEQu0deYXajXaR77fh6+CP5
         eg80daE4A+Uyz/iruzqDjr1YQDJt4UpU8TE40veOO5Pisy74wog8sQISsRw+VDH1j+nE
         52xekh8Wv9RdOh/zn9kSM4Ai4klEh2bIyOgKZdZf1yCuQnrPemUSpT0gxgFFO60hcv1R
         KvPP9OBdtAtpO60DNtDh5pdRTxPmfh6U/iHC1Jbad0gus2EvahP2xrtjprzUiAcSC0OB
         ZjVQ==
X-Gm-Message-State: AO0yUKWnzdmKzoykJCXNd6DYQji4sfB5cjCW7Ev6RYvm99q5GHYPXWS2
        Ekv5b5HbRo0w48oYXPg0WqlUYq3ii84=
X-Google-Smtp-Source: AK7set/8krZpheT9lekrxOXqzIBcoXFI8fh5zKN23GsoSJSMMA5jZG6tF58YJDjcB9eb+PzvHq6YBw==
X-Received: by 2002:a17:902:c951:b0:19e:9807:de48 with SMTP id i17-20020a170902c95100b0019e9807de48mr30470519pla.23.1678515758684;
        Fri, 10 Mar 2023 22:22:38 -0800 (PST)
Received: from fivlite-virtual-machine.localdomain ([49.37.146.161])
        by smtp.gmail.com with ESMTPSA id jx12-20020a170903138c00b00199190b00efsm925444plb.97.2023.03.10.22.22.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 22:22:38 -0800 (PST)
From:   Kousik Sanagavarapu <five231003@gmail.com>
To:     jonathantanmy@google.com
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH] index-pack: remove fetch_if_missing=0
Date:   Sat, 11 Mar 2023 11:52:19 +0530
Message-Id: <20230311062219.22325-1-five231003@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230310211321.4135748-1-jonathantanmy@google.com>
References: <20230310211321.4135748-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, 11 Mar 2023 at 02:43, Jonathan Tan <jonathantanmy@google.com> wrote:
>
> Junio C Hamano <gitster@pobox.com> writes:
> > > Hence, use has_object() to check for the existence of an object, which
> > > has the default behavior of not lazy-fetching in a partial clone. It is
> > > worth mentioning that this is the only place where there is potential for
> > > lazy-fetching and all other cases are properly handled, making it safe to
> > > remove this global here.
> >
> > This paragraph is very well explained.
>
> It might be good if the "all other cases" were enumerated here in the
> commit message (since the consequence of missing a case might be an
> infinite loop of fetching).
>

I will make the change.

> > OK.  The comment describes the design choice we made to flip the
> > fetch_if_missing flag off.  The old world-view was that we would
> > notice a breakage by non-functioning index-pack when a lazy clone is
> > missing objects that we need by disabling auto-fetching, and we
> > instead explicitly handle any missing and necessary objects by lazy
> > fetching (like "when we lack REF_DELTA bases").  It does sound like
> > a conservative thing to do, compared to the opposite approach we are
> > taking with this patch, i.e. we would not fail if we tried to access
> > objects we do not need to, because we have lazy fetching enabled,
> > and we just ended up with bloated object store nobody may notice.
> >
> > To protect us from future breakage that can come from the new
> > approach, it is a very good thing that you added new tests to ensure
> > no unnecessary lazy fetching is done (I am not offhand sure if that
> > test is sufficient, though).
>
> I don't think the test is sufficient - I'll explain that below.
>
> > > +test_expect_success 'index-pack does not lazy-fetch when checking for sha1 collsions' '
> > > +   rm -rf server promisor-remote client repo trace &&
> > > +
> > > +   # setup
> > > +   git init server &&
> > > +   for i in 1 2 3 4
> > > +   do
> > > +           echo $i >server/file$i &&
> > > +           git -C server add file$i &&
> > > +           git -C server commit -am "Commit $i" || return 1
> > > +   done &&
> > > +   git -C server config --local uploadpack.allowFilter 1 &&
> > > +   git -C server config --local uploadpack.allowAnySha1InWant 1 &&
> > > +   HASH=$(git -C server hash-object file3) &&
> > > +
> > > +   git init promisor-remote &&
> > > +   git -C promisor-remote fetch --keep "file://$(pwd)/server" &&
> > > +
> > > +   git clone --no-checkout --filter=blob:none "file://$(pwd)/server" client &&
> > > +   git -C client remote set-url origin "file://$(pwd)/promisor-remote" &&
> > > +   git -C client config extensions.partialClone 1 &&
> > > +   git -C client config remote.origin.promisor 1 &&
> > > +
> > > +   git init repo &&
> > > +   echo "5" >repo/file5 &&
> > > +   git -C repo config --local uploadpack.allowFilter 1 &&
> > > +   git -C repo config --local uploadpack.allowAnySha1InWant 1 &&
>
> The file5 isn't committed?

That is a blunder.

>
> [...]
>
> So I think the way to do this is to have 3 repositories like the author
> is doing now (server, client, and repo), and do it as follows:
>  - create "server", one commit will do
>  - clone "server" into "client" (partial clone)
>  - clone "server" into "another-remote" (not partial clone)
>  - add a file ("new-file") to "server", commit it, and pull from "another-remote"
>  - fetch from "another-remote" into "client"
>
> This way, "client" will need to verify that the hash of "new-file" has
> no collisions with any object it currently has. If there is no bug,
> "new-file" will never be fetched from "server", and if there is a bug,
> "new-file" will be fetched.
>

So, we can lose the "promisor-remote" in the original test and make the
"server" itself a promisor-remote?

Thanks for the review

> One problem is that if there is a bug, such a test will cause an
> infinite loop (we fetch "new-file", so we want to check it for
> collisions, and because of the bug, we fetch "new-file" again, which we
> check for collisions, and so on) which might be problematic for things
> like CI. But we might be able to treat timeouts as the same as test
> failures, so this should be OK.

Return-Path: <SRS0=W4Po=BO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23D8FC433DF
	for <git@archiver.kernel.org>; Tue,  4 Aug 2020 14:42:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0556F208A9
	for <git@archiver.kernel.org>; Tue,  4 Aug 2020 14:42:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MlEVb6GG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728903AbgHDOmQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Aug 2020 10:42:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbgHDOmN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Aug 2020 10:42:13 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D733C06174A
        for <git@vger.kernel.org>; Tue,  4 Aug 2020 07:42:12 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id z188so12542530pfc.6
        for <git@vger.kernel.org>; Tue, 04 Aug 2020 07:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QTwFInuGt+nEc9ER8UIcduxvG5ZXFaPT4Ns4lJNSC10=;
        b=MlEVb6GGw1YK8lnXHmXabQGkiH6o/xgoIwpdco8jgPyKxoMLHhDG3VoECROAaYez0q
         QHAs/IiPFXSjC/caqJDVJoCihUH677g+7onNfE378kTSpKgSv+BxMs8Y0/uQeehyIGAH
         Nn9WZICgbmZHi9t/ckwa3NYMRemiQiunGXeM9EpjASptNf2pJpVtOUdy+zz4Q/mH3CQB
         J163cT1a0IhpVibANf9rsiQZDopJMEBRIxU6U+rIgNZiZ5gk25rLaVGFYcYtT71UwMz5
         J9+WGLPuGNtWNvkqYV9uyKfE85I/MPqoTFVLnWCAGc+/MoO4r+f+ZrmIMbS8Kxj204HI
         ZM1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QTwFInuGt+nEc9ER8UIcduxvG5ZXFaPT4Ns4lJNSC10=;
        b=mmRd/NLJ8ShVioUYvM2e+hxIZkHpVensUFI9x2Q/EUDhVNR01/Jb8V7GzFFb2QT7GZ
         zWi6z1SKLzvAKhdCi5dnWqrJCb49iiwNhPDvPVXcNM9AyUxciKVyZGm/K7mVTXsuvQVR
         lzTKKwEJ/h32JDJrnNfSp7efV6zV3lgodKJHo/GmJZwigKU9pObAmXRIdgcmlIDfGLI8
         Pv4KnJelD4iExLO00r+il+fYCZuovh8tczMnx6YhZUOiSPCJbDftg7Tjff9WG60RVjoq
         o8cQqqNOWWMXVfr+Ks7aP7EKnTeKn7U0ljgHSWuXRTBKqZsfR5gMPGsMuL48L6bmfSDH
         +PGw==
X-Gm-Message-State: AOAM531yW9WG9R73aU28xCwMUPCoekpPEOeRM5/sODiFTjiupPCnBfbq
        SkkieeYwRqYiMMzngoZcBlA=
X-Google-Smtp-Source: ABdhPJzsk3/7nW/dLX22D4RDP4SyoVJT4dJpP/KI1JXfKHKwZfNJ5QY96g0qUtm8AktqNwJhweJmbA==
X-Received: by 2002:aa7:92d7:: with SMTP id k23mr13078722pfa.295.1596552131651;
        Tue, 04 Aug 2020 07:42:11 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:a28c:fdff:fee1:cedb])
        by smtp.gmail.com with ESMTPSA id z1sm2908414pjn.34.2020.08.04.07.42.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2020 07:42:10 -0700 (PDT)
Date:   Tue, 4 Aug 2020 07:42:08 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Johannes.Schindelin@gmx.de,
        sandals@crustytoothpaste.net, steadmon@google.com, peff@peff.net,
        congdanhqx@gmail.com, phillip.wood123@gmail.com,
        emilyshaffer@google.com, sluongng@gmail.com,
        jonathantanmy@google.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2 01/18] maintenance: create basic maintenance runner
Message-ID: <20200804144208.GA227292@google.com>
References: <20200729221905.GB519065@google.com>
 <5cbdb559-3897-961f-4dd3-0bab11848c5b@gmail.com>
 <20200731003022.GA1029866@google.com>
 <a176ddf5-b45b-fb25-8740-96efbd324edf@gmail.com>
 <20200803174654.GA2473576@google.com>
 <20200803224631.GA73022@syl.lan>
 <20200803230134.GA58587@google.com>
 <20200803230814.GA73765@syl.lan>
 <20200803231745.GB58587@google.com>
 <aac90dbd-e885-f366-1056-0824b8b8b8fe@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aac90dbd-e885-f366-1056-0824b8b8b8fe@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee wrote:

> What is seems like you are asking instead is for me to create a tool
> in the test suite that parses each JSON line, extracts a specific
> member from that JSON object, reconstructs a command-line invocation
> from the JSON array, and reports whether that process worked for any
> line in the event output.

No, that isn't what I'm asking.

I'm asking for this patch series to take the existing "grep" lines
and put them in a function in test-lib-functions.sh, so that we can
change them in one place when the trace emitter changes.

[...]
> If this is to truly be a hard requirement for these tests to move
> forward,

Yes, from my point of view it really is.

But that "is this truly a hard requirement?" comes up tells me I have
not done a good job of communicating in this review.  A review is
about participants in the project working together to improve a patch,
not people making demands at each other.

[...]
> If I'm to spend time engineering something more complicated just to
> check "did this subcommand run with these arguments?" then

I don't see why this is more complicated than what is in patch 1.  In
fact, I think it would be a little more simple.

Jonathan

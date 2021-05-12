Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 693A0C43462
	for <git@archiver.kernel.org>; Wed, 12 May 2021 17:55:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3073361106
	for <git@archiver.kernel.org>; Wed, 12 May 2021 17:55:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240732AbhELRpD (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 May 2021 13:45:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344255AbhELRfU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 May 2021 13:35:20 -0400
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCB24C06175F
        for <git@vger.kernel.org>; Wed, 12 May 2021 10:32:18 -0700 (PDT)
Received: by mail-oo1-xc2c.google.com with SMTP id s20-20020a4ae9940000b02902072d5df239so2636407ood.2
        for <git@vger.kernel.org>; Wed, 12 May 2021 10:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=tVePl+zk0tMFSGfk3UPkj5Z30ViKeyQar5IFwo/uyjU=;
        b=RYfCJksb3atHfMt3U0RSa4lzlgnfLued1jZH7FnNijwTLeBQBdCr6MHtlZsZFDYNGD
         JXbkRYCAY9EQV723AYhUZ1cmDWbsn7YzLc18izrHo44ziAJOpne8U4SwgPhQKRChtVKZ
         YbE1qA/DGsLl54Ml2AmU/xI8m4dPg9ruFY46kGwlHguiTn0ppAQQ6H48cYrMY5CRtP3V
         4fa9PyG47SBKjLfisicNipQkEqYuRlDptPEE3z0/85N95sXLIl1sLw+AYxBlLfW/misv
         Xe4Pett0LxI9zBAT67+MkqSulKHjRskjwERl1USmPruIUoFRhRRo5dLe4L7mTeFak95r
         +ScQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=tVePl+zk0tMFSGfk3UPkj5Z30ViKeyQar5IFwo/uyjU=;
        b=cV9oRXdQnVyZDNFAFfJZweKEWMu2a4S3cNWumsWgPn8epyviIV7F5GC2WbcET58AAB
         Ujs4wSlNkAPTR5XU+2S0mSYJd/XGWJNXWC9SGyfHWO+PvOajWqhCvXlkVsHlDWboy3OG
         1Cd41ZQrAH/28A87dUOsFsjdAvSKbo3Oo5CGTqFjKaJJWmuxotpCuQnDTMtHJjaU+pGq
         QfnD4wp+DgJeJYCrsuFPMy1lqGbHXGBFzXxZiyHmej8H8W0YfERqx/u0RZIMvzkRTWSI
         E/t5TyRZ5+AtkuIVQjRyBfj9PxKSg6R+kp6gvnSTBkqmfc3uvC4qlE1WZqNH1U+7UYu/
         o8iw==
X-Gm-Message-State: AOAM532vunf0pCvdOWyrby+gi40djac2EIQtNR5KSfZq4wklWz+yV0Qm
        9Y6OyVexX8jarFLEpEQC/Rc=
X-Google-Smtp-Source: ABdhPJxZxYsT+pgy3aZoDIAhruhgcGsD0Y6HXyK18qlX9FgD/TwBYtnT9sGHuL8nge2t5tRc9AP7IQ==
X-Received: by 2002:a4a:d442:: with SMTP id p2mr10777400oos.89.1620840738303;
        Wed, 12 May 2021 10:32:18 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:638f:a2c5:89ff:fe0c:1151])
        by smtp.gmail.com with ESMTPSA id i11sm81035otk.70.2021.05.12.10.32.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 10:32:17 -0700 (PDT)
Date:   Wed, 12 May 2021 12:32:16 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     =?UTF-8?B?TWljaGFsIFN1Y2jDoW5law==?= <msuchanek@suse.de>,
        Varun Varada <varuncvarada@gmail.com>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
Message-ID: <609c112066acd_71bd1208aa@natae.notmuch>
In-Reply-To: <20210512170153.GE8544@kitsune.suse.cz>
References: <20210406092440.GZ6564@kitsune.suse.cz>
 <CAD2i4DDr3Ftk6RE8cA74iSsJTpC9nEb=Cqvr79pF51BpcWEnsA@mail.gmail.com>
 <609ae224aa509_6064920851@natae.notmuch>
 <20210511202502.GM12700@kitsune.suse.cz>
 <CAD2i4DALKgw2wG6QGs-oQhAHnS3AG1j1BSq2bxjPojVOtw+WjA@mail.gmail.com>
 <609b4eea1088a_678ff208ba@natae.notmuch>
 <20210512040926.GN12700@kitsune.suse.cz>
 <609b63e48fd49_6d7da2086@natae.notmuch>
 <20210512064733.GP12700@kitsune.suse.cz>
 <CAD2i4DBF3Tvf62Zyh0XnNH=5ifTD2QQNL5Fx01UHMzoTn3OMVw@mail.gmail.com>
 <20210512170153.GE8544@kitsune.suse.cz>
Subject: Re: [PATCH] doc: replace jargon word "impact" with "effect"/"affect"
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michal Such=C3=A1nek wrote:
> On Wed, May 12, 2021 at 11:47:15AM -0500, Varun Varada wrote:
> > So you're saying you're OK with getting rid of all instances of
> > "impact"? I'm for this, but insofar as I searched the code base, I
> > only found the ones I'm changing in my patch (save for a couple that,=

> > as a previous reviewer mentioned, are included from other repos, so I=

> > left those).
> =

> Yes, I am not opposed to the change in principle.

Good, so you accept you see nothing wrong with "affect".

> You just failed to provide any valid reason.

*In your opinion*.

In my opinion the problems with the word "impact" have been clearly
explained.

Cheers.

-- =

Felipe Contreras=

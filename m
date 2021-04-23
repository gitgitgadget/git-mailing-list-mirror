Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F20ACC433ED
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 07:48:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B243961422
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 07:48:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240393AbhDWHsj (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Apr 2021 03:48:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbhDWHsi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Apr 2021 03:48:38 -0400
Received: from mail-vk1-xa2e.google.com (mail-vk1-xa2e.google.com [IPv6:2607:f8b0:4864:20::a2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B58DC061574
        for <git@vger.kernel.org>; Fri, 23 Apr 2021 00:48:02 -0700 (PDT)
Received: by mail-vk1-xa2e.google.com with SMTP id u200so7838710vku.3
        for <git@vger.kernel.org>; Fri, 23 Apr 2021 00:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0E7P2oWFqZLdMnjtQ2iXG5Jso6wHi3j1fYMQTy9IN+Y=;
        b=TdNvlDWnGsQeXwZTW2JMF7/pC81Cj2ks8aHcsQ426mV5HwE0TqHXJZnc45ElMoqWwD
         4uXBFPooTIOmLRGk7K6uXEATYSDA34rQ/p7Hm2qDitghkseR6sM10K3QRggMi+TUB1hk
         iaNoV8DgmvinpFIiViLS5sEcw7gwNboOXtipqb/rCOpqGUA4zDa8vMRnpxOx9qN47qsc
         nFm6TobzGvn2xouxu3gsZrYbJ4EM68Vb7DGS788t/sj2ViVzROgadKsmcHWUb3p7fqpH
         tJ+uJ9Mnj4O5955LWI+rxWWlXdnRjfArXFuYE/mcTn3Vkf+9Bw2C7eOTP4u278lzHMYS
         JLQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0E7P2oWFqZLdMnjtQ2iXG5Jso6wHi3j1fYMQTy9IN+Y=;
        b=NjxR6OuXDYN2yJVUGS1GyuFhZ8T0ZYg3YYRuNv+WKIkonV9iJq3RF7wgxBP10uT0pn
         SitmwtSfdwtHkDUfAQKZYGsWlErdwQKA134kiTB5CZxKkDk0OtGhKYVWcJYFktrtktWR
         xwkhPGXCNu+Rx8ddpNhj1D+DG7iv+45IDeiQ/F5Hu42Rv+WYINTsHZDVSQ3bFDRLMXHb
         fHFkkTgJmaAGqCh5Fbc8gQUojIQmcK9JH5EipBcLlPBeK465cBjwZW6/ip/EwIpxcTzj
         oMDCt4zS8iQ/kdVODesTkUDOgpIWp+ToV578BtFpmF345f5XrgmgbEPKiyqCsqmNJvmS
         5NqQ==
X-Gm-Message-State: AOAM532Y0IeJNiNAYR7yPz8bLO3UoxERJzxblg0rBz+gnffif7YnKelv
        l/s3q2UeCA0AZECO+ICGoLP9yQYOk7jn6qr02xMI1w==
X-Google-Smtp-Source: ABdhPJwHEkDBoUu2RpyZsbnBQMHbi9ME1MPEMPxyETPzuaTo9F6TtkCCvRDFRCBATEc5ZqUE/fuOFMEFypdR+pIPvYk=
X-Received: by 2002:a1f:5c97:: with SMTP id q145mr1837569vkb.25.1619164081253;
 Fri, 23 Apr 2021 00:48:01 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1008.git.git.1618829583.gitgitgadget@gmail.com>
 <53cf1069552b6cd6161ce6f69a31c44e59091096.1618829583.git.gitgitgadget@gmail.com>
 <871rb45ftz.fsf@evledraar.gmail.com> <CAFQ2z_MMAM6jZ0+zRi+8fyS69Qw4fKQSsXgQW2zW7tcMdmN=QQ@mail.gmail.com>
 <20210422045953.GC2947267@szeder.dev> <CAFQ2z_Md=LAkJzohf3E5ogWGQHzxN_ik=yHAGmxm7bg-yT6-Zw@mail.gmail.com>
 <20210423051255.GD2947267@szeder.dev>
In-Reply-To: <20210423051255.GD2947267@szeder.dev>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Fri, 23 Apr 2021 09:47:50 +0200
Message-ID: <CAFQ2z_NgFC-7zENyD7HkEgvS6Dtc4qYqPRFL3m1LsbXnrFkPsA@mail.gmail.com>
Subject: Re: [PATCH 04/18] t1401-symbolic-ref: avoid direct filesystem access
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 23, 2021 at 7:12 AM SZEDER G=C3=A1bor <szeder.dev@gmail.com> wr=
ote:
> > I see it as the test writer's job to clean up to the extent that
> > git-symbolic-ref can reset to a sane state.
>
> No, it's the job of whoever updates the cleanup routine to make sure
> that the updated cleanup routine still works just as well as it did in
> the past.

Sorry, I don't mean to shirk my responsibility. What I mean is: is
there a way to signal "This test is fubar. Stop further execution of
test shell script".

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado

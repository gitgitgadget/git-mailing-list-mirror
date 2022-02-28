Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEF68C433F5
	for <git@archiver.kernel.org>; Mon, 28 Feb 2022 12:23:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236299AbiB1MXo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Feb 2022 07:23:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236301AbiB1MXh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Feb 2022 07:23:37 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6803017ABC
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 04:22:47 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id bd1so10531349plb.13
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 04:22:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=coup.net.nz; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HqCVLa9jVrjSuzCYkt5AppY7tYDLqcCkXRRh3TJMMdE=;
        b=PnxrVbNZYmrQ69bzAvFXwQ0xHJMHCySfXmp/X2PgDdMQv4LGGlkbvKZtPwmIazMT0K
         27Xb9GcQGdIGMktlt0Oi/rLrpDPG098k2VAPV3oopg2sfJdeIRafWIYhiv+PPnToKikM
         SOvF++MBSosc1Xme6ly2ME6g39dLwMqkEsQsk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HqCVLa9jVrjSuzCYkt5AppY7tYDLqcCkXRRh3TJMMdE=;
        b=18InIj2V/BF2C9hNSH76EwpDf94It6x6/fwZWoSKJgQGk/m7bcQCXaOc/1pNKc6XIL
         cf4cpiBwbQbwitY/UFP2rZEm/FCyDxrTmESJxfQP3Xh9IDmn9PeqsY3gRrQi05oIUWwz
         vbXedPWuSodIwyRcnzW/gqVNM25zYXtMw21rdEkc8NsoabVhgSdK9hQZ890gXC9xsfAI
         oMczmhvecbjPMBduFbeti4y7TeJQTENeqbnJssCh4slQs6o3cxo9duWZ0Je8up0QbCM9
         LLXOA5SWeR5acFkViZcyZ8RO2soW2wYFYyd2Yw8Ba8x5XIX4JZSrAFpm6fZH/KsPY9XY
         9OYQ==
X-Gm-Message-State: AOAM531CiGlCQL3zMqc5/6BRxEY+oBrhbsRamT1G+YpJXAM9a7aIQ8Qu
        VNHUmTPf51OLoP9wtbA6nhWIjjKvkmdUw85HvbamDQ==
X-Google-Smtp-Source: ABdhPJwb/7CTW6nhSLhaxNA0jpDbwixop0c9gYj+gc0RJzZJjqQWFatL97Fu+6zj4J7PUXT2Sm0A1NZDWCsFYnBpnrc=
X-Received: by 2002:a17:902:6bc5:b0:14f:ae30:3b6f with SMTP id
 m5-20020a1709026bc500b0014fae303b6fmr20576204plt.60.1646050966669; Mon, 28
 Feb 2022 04:22:46 -0800 (PST)
MIME-Version: 1.0
References: <pull.1138.git.1643730593.gitgitgadget@gmail.com>
 <pull.1138.v2.git.1645719218.gitgitgadget@gmail.com> <d146d8aaaafee91de2e7c50b3a598a470319b541.1645719218.git.gitgitgadget@gmail.com>
 <xmqqbkyvh3i3.fsf@gitster.g>
In-Reply-To: <xmqqbkyvh3i3.fsf@gitster.g>
From:   Robert Coup <robert@coup.net.nz>
Date:   Mon, 28 Feb 2022 12:22:35 +0000
Message-ID: <CACf-nVcLXcD6G_b_pYWj+7KJBu4iV6FqHWB8U6F4j6Rr72zXVg@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] fetch-negotiator: add specific noop initializor
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Robert Coup via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        John Cai <johncai86@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Fri, 25 Feb 2022 at 06:19, Junio C Hamano <gitster@pobox.com> wrote:
>
> > Add a specific initializor for the noop fetch negotiator. This is
>
> "initializer"?

Thanks. A poor translation effort to American English ;-)

> > +
> > +void fetch_negotiator_init_noop(struct fetch_negotiator *negotiator)
> > +{
> > +     noop_negotiator_init(negotiator);
> > +}
>
> Puzzling.  What makes this better than allowing noop-negotiator-init
> to be called directly?

Is simply for naming/API consistency with the regular method. Happy to
call noop_negotiator_init() if you prefer?

Rob :)

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 956D11F453
	for <e@80x24.org>; Thu, 18 Oct 2018 19:09:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726816AbeJSDLx (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Oct 2018 23:11:53 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:36245 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726173AbeJSDLx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Oct 2018 23:11:53 -0400
Received: by mail-ed1-f65.google.com with SMTP id c26-v6so29268981edt.3
        for <git@vger.kernel.org>; Thu, 18 Oct 2018 12:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kf4Dxsz64RiAFvw/JQGBtGjFFikok0hmrzPyRFkYTJM=;
        b=SpW7nQhfJZ8RJmIMGGu/sQmD9QjQFGukn588j9at/q6VzGbYHw2FvXdh4y7FiRngGH
         HJ8IVWY6kcq6VsJRt1nJelgOCncQusfnuA/Ww1d1Y/2nn2xqFTVoBUvyK/X5DmolK0m3
         PzUdPeTjVGj+4F4jBHkD1YeOMQe3/8DfJ/Kv26pMWnIPojsofP0438aVbq4vLbzy52/M
         VycQ4OJywRjCijYfRSrLEGpB12GPIhleFTrAsl0VinZ43/LjqEdreenYOTOe+BQ4pgkI
         +bdVJ2lAda56+D4rXjkRgGUZ216BaB1rcaBaWO0y9E/ymgU3hsYP+iMwT8zneq06aWY8
         clwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kf4Dxsz64RiAFvw/JQGBtGjFFikok0hmrzPyRFkYTJM=;
        b=KB17YlySX+Vw9Z1uMDngIM2IoZ1gq7PploEEoMgqgNvX3zc9Omz8qxILqh1zgHt6gf
         2htIpgQYdraNxp5ZObWD0/Mh6o8wyA5txSHarzb7k0uirzScWg4XW9RHWlQs1NMkAT71
         GdinSYFkap96CnpXFRNEY9aisb4TfEMg/KWOBpOZ9l9Hah/S8BLMcggwwmaQ7876rMyG
         W1U4rc+ndHfBlnLEDak76jNnxeZAskq24MC6MgLxHAm2zBAMPxsTXSG7hxlQQoutOPTw
         MbObV8/h9yBz3QZZ/bVs1NBA4e70Cg7szq+sXFGzroAsRKk+UJ0whHcFgZPtsytDXqYE
         O3Gw==
X-Gm-Message-State: ABuFfoijb3xnH1K2FiUWbhqAiDepQTcQt70U6kwp7FTmEfuuHrxey6YT
        eHdo7g1ENFW/n5fJ/LoYYlWJsB++95zWXOujMNDfVqgAqao=
X-Google-Smtp-Source: ACcGV61arzvi8AbmNDMHdv8SiB36WnSRG7WkQvsLT5eay/aDnkGmklz82izQSbpDQ3yHMfp45StzAPTjYCZyzS/XRa0=
X-Received: by 2002:a50:aca2:: with SMTP id x31-v6mr4205779edc.76.1539889767111;
 Thu, 18 Oct 2018 12:09:27 -0700 (PDT)
MIME-Version: 1.0
References: <20181016181327.107186-5-sbeller@google.com> <20181017212624.196598-1-jonathantanmy@google.com>
In-Reply-To: <20181017212624.196598-1-jonathantanmy@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 18 Oct 2018 12:09:16 -0700
Message-ID: <CAGZ79kZHhmoBf26z3_Lk-yQEXztpGdWX-FfsRnvaKRCwETZ9XA@mail.gmail.com>
Subject: Re: [PATCH 4/9] submodule.c: move global changed_submodule_names into
 fetch submodule struct
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 17, 2018 at 2:26 PM Jonathan Tan <jonathantanmy@google.com> wrote:
>
> > The `changed_submodule_names` are only used for fetching, so let's make it
> > part of the struct that is passed around for fetching submodules.
>
> Keep the titles of commit messages to 50 characters or under.

renamed

>
> > +static void calculate_changed_submodule_paths(
> > +     struct submodule_parallel_fetch *spf)
>
> Instead of taking the entire struct, could this just take the list of
> changed submodule names instead?

I think so, done.

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A365EC433F5
	for <git@archiver.kernel.org>; Sat,  6 Nov 2021 21:32:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8256E6124F
	for <git@archiver.kernel.org>; Sat,  6 Nov 2021 21:32:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235245AbhKFVf3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 6 Nov 2021 17:35:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235212AbhKFVfY (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Nov 2021 17:35:24 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3670DC061570
        for <git@vger.kernel.org>; Sat,  6 Nov 2021 14:32:42 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 67-20020a1c1946000000b0030d4c90fa87so8938282wmz.2
        for <git@vger.kernel.org>; Sat, 06 Nov 2021 14:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google;
        h=mime-version:content-transfer-encoding:date:message-id:cc:subject
         :from:to:references:in-reply-to;
        bh=hvzTCu3HBCuD87MHRK0drXXMklMtoifC+MqbI05KhcM=;
        b=XtDWQ4xVmKlwVRAkubTriHEYczUlZnHtUzoC5bDqJUY7LEu/XfkdkrboCUBcTnpyEi
         T3TlGQRrS8KlfS7iWaCUy8ZARLrdzEsc86StOAfoR3sCG/cNDThhLL33Ja2LrYz1CSFC
         PCGLqzB5J7gKSuhh860ffYG4iR+F+6lSw8nRhAkm8046AxXo+KiE2vhy+69bThG8C/TE
         NcP/xGpejZ2jizHmGNtoKRqdDBGYbac0kRX2qqTeXnWoIKlZ4Ju2V0kXB5x4XAXzf+xe
         29Dgj9FQPFDZYXxdjuzrBnTnpgZysS++xayce8ucwvfBj0uXpPpoHU7HvHCOPInuwMHK
         pX2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:content-transfer-encoding:date
         :message-id:cc:subject:from:to:references:in-reply-to;
        bh=hvzTCu3HBCuD87MHRK0drXXMklMtoifC+MqbI05KhcM=;
        b=JIWt6aB/YTRX4H4kM+Mqhhw+lHnOp6eSBQyCdWkuUEt/Uy9TiaHSQc023Jj73b5gAj
         pl7ibRZSG1Jk7O4ZYBZ/XwgdktqnC/OrK+2AY4tGc6y9eLGJJyfty8GZK3yr+DK4IP0i
         XD/kU1EfQwgcYqmfPhF6ozUNWKlcpq7rf7B6jXUOhQ+MyYjttMTt3Hy+ohjOPEORs3TT
         2hpIn3qAWuPB8r/W6U34KQfzNKLnaveS4uOMbkf9zAlSUpHsorH5+K+IGCOWUOhx2lmT
         nxIVLB73U+ajjUcWTAyEEIgqJW9q1omSvKGgahcpx/N+Ux2DpYUVPGbf4fu3AZyHoCwb
         Tt7A==
X-Gm-Message-State: AOAM531QNNQfWpvueQX6T7yFRP8+G0SOOWAVepbFQrCZ2eBrpZfjUVDg
        htFu22Q6hid/RBeb6QjhvzyH2w==
X-Google-Smtp-Source: ABdhPJysFxy26xFSG+U+6IgWB8vCd1zsIt/8YXVQfjyMygs+vmeJyQb38tPYj6lTR3x4HoP5iP6VKw==
X-Received: by 2002:a1c:f405:: with SMTP id z5mr41377821wma.33.1636234360862;
        Sat, 06 Nov 2021 14:32:40 -0700 (PDT)
Received: from localhost (2a01cb000f483e004bf57bbe4fddc0d6.ipv6.abo.wanadoo.fr. [2a01:cb00:f48:3e00:4bf5:7bbe:4fdd:c0d6])
        by smtp.gmail.com with ESMTPSA id r17sm7981873wmq.5.2021.11.06.14.32.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Nov 2021 14:32:40 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Sat, 06 Nov 2021 22:32:38 +0100
Message-Id: <CFJ0O7HEP2TY.NSQD8094SYCF@diabtop>
Cc:     <git@vger.kernel.org>,
        "Nicolas Dichtel" <nicolas.dichtel@6wind.com>,
        "Jan Smets" <jan.smets@nokia.com>,
        "Stephen Morton" <stephen.morton@nokia.com>,
        "Jeff King" <peff@peff.net>
Subject: Re: [RFC PATCH] receive-pack: run post-receive before reporting
 status
From:   "Robin Jarry" <robin.jarry@6wind.com>
To:     =?utf-8?q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
References: <20211104133546.1967308-1-robin.jarry@6wind.com>
 <211106.86y261g88n.gmgdl@evledraar.gmail.com>
In-Reply-To: <211106.86y261g88n.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi =C3=86var,

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason, Nov 06, 2021 at 06:03:
> FWIW we include the date when mentioning commits. E.g. ec7dbd145bd
> (receive-pack: allow hooks to ignore its standard input stream,
> 2014-09-12).

OK, noted.

> I think the discussion at [1] is current to everything you're seeing
> here.

Thanks I had missed this thread.

> tl;dr: Even with this change you're not guaranteed to run your hook.
[snip]
> But as noted in [1] there's a way forward to having our cake & eating it
> too. I.e. when we into that on the server-side we can try a little
> harder not to die, and run post-receive anyway, and in either case it
> would be nice if we'd run it after disconnecting from the client, so it
> doesn't have to wait for it.

OK, I will try to propose a v2 masking SIGPIPE when reporting status to
the client to avoid dying before running post-receive.

Cheers,

--=20
Robin

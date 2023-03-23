Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A46CC6FD1C
	for <git@archiver.kernel.org>; Thu, 23 Mar 2023 09:36:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbjCWJgi (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Mar 2023 05:36:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbjCWJgH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2023 05:36:07 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AE6835EE2
        for <git@vger.kernel.org>; Thu, 23 Mar 2023 02:34:13 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id br6so26853094lfb.11
        for <git@vger.kernel.org>; Thu, 23 Mar 2023 02:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679564051;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a+XrAkGOlnkdQ9d/UKB1J5DHf0CYhWJD27bZYinLi1M=;
        b=oehxAwrlJ1G4sQkRyBg8hPmn+bbth/Wy9L5mbgQtlcdNeNWljFUECmK/7fvFn4vXqy
         5XEfIOegPWBwIgwEUax/wz7LhOGPBe5KQUGpu15f0Hf8+tdUPGBfzqsuhdIwrU+7pD3V
         NkIHqHXK6xc3AEstQKnWFJj++gxGpm/bac4u07P4E6VyZUQWpnP7tiGjMRom/gD4EqHW
         3Ob3ZqIY13hMPA185qiFAPTfJAYIxExxJ+XsPjPv+hS9cPLhG2RXQE7oNSqKF210IIpc
         GRuAOGRJfeJG7t6hWoQVRUB/YL7YR7P/7OIWhYA6hdquE3K3jjeFh+ekT1S/5TYcPXdL
         LH1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679564051;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a+XrAkGOlnkdQ9d/UKB1J5DHf0CYhWJD27bZYinLi1M=;
        b=mvaj+ZbFWBTP9Agjp8ea3TsOGeFA2FCqp8IvcwlKEairG0HcFQ7d6UQc+lcipNozrc
         7RkwaIfTFfgSXhYxnhVoWcJDskOGh/ELvqwvdA1uY0NqbjS1lvhR9iuOr/bV1k4AlXPV
         frMoFg27KjYKjOLOXI3q93LIeh86qnqf6Cr8ahn+VOv5b+ne5wp+FIT+GCxm9THdPtEs
         cnd4/lzNZmy4NyU7ctaf+xdJTw4g/bADLC3Oq2SupZYoXWQYLHwCzHq6y5B/2g40z2R3
         Js2EprslD2oq+UaFPXKd/VWyoRDhENHspd4kRAkc+3HrdegVSFu5HrKkTCUMqoswvQ0v
         cqNQ==
X-Gm-Message-State: AO0yUKWwkc8mB1l/AFPv1TaHqFWon3gxjlh1ouh5PEfLNqcPv3Am4vrc
        ILg3UfrAQFS3dPznz50IIohz//gSVyoodCnwVPg=
X-Google-Smtp-Source: AK7set+LBWKHDnPFuLjSbJ8Na9z+pyPDcO8zH6wdLdvXQLmVe7+FoFAtfnCAlGyBqLRpk39QPGKa6iaKSXHaBe6YEyk=
X-Received: by 2002:a19:ae02:0:b0:4e8:426d:123f with SMTP id
 f2-20020a19ae02000000b004e8426d123fmr2889577lfc.11.1679564051323; Thu, 23 Mar
 2023 02:34:11 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1474.git.git.1679233875803.gitgitgadget@gmail.com>
 <pull.1474.v2.git.git.1679327330032.gitgitgadget@gmail.com>
 <xmqqlejrmj4y.fsf@gitster.g> <20230321172223.GA3119834@coredump.intra.peff.net>
 <xmqqjzzahufj.fsf@gitster.g>
In-Reply-To: <xmqqjzzahufj.fsf@gitster.g>
From:   Stanislav M <stanislav.malishevskiy@gmail.com>
Date:   Thu, 23 Mar 2023 12:33:59 +0300
Message-ID: <CAEpdKf=pMcMn6q0wGGcrFN1yi1duguSNLDkqhDmvMBeKQ--yuA@mail.gmail.com>
Subject: Re: [PATCH v2] http: add support for different sslcert and sslkey types.
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>,
        Stanislav Malishevskiy via GitGitGadget 
        <gitgitgadget@gmail.com>, git@vger.kernel.org,
        Stanislav Malishevskiy <s.malishevskiy@auriga.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I want to do some clarification there. Those changes are not related
to http or https directly.
That only configures curl to know how to access the certificate and
key locally on the client box, so if the way is wrong there is a
simple error: Certificate or key not found.

=D0=B2=D1=82, 21 =D0=BC=D0=B0=D1=80. 2023=E2=80=AF=D0=B3. =D0=B2 20:43, Jun=
io C Hamano <gitster@pobox.com>:
>
> Jeff King <peff@peff.net> writes:
>
> >   2. Add a specific "test with https" script that covers some basic
> >      tests (possibly even just including t5551, in the same way t5559
> >      does). If the platform apache doesn't support ssl, then it should
> >      fail gracefully. And then we could add more SSL specific tests
> >      to that script.
>
> Both choices sound sensible.  This second one may be simpler to
> arrange.
>
> Thanks.

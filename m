Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CA0DC47089
	for <git@archiver.kernel.org>; Thu, 27 May 2021 11:52:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 720996103E
	for <git@archiver.kernel.org>; Thu, 27 May 2021 11:52:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234410AbhE0Lxi (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 May 2021 07:53:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234421AbhE0Lxe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 May 2021 07:53:34 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D510DC061760
        for <git@vger.kernel.org>; Thu, 27 May 2021 04:52:01 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id r11so468024edt.13
        for <git@vger.kernel.org>; Thu, 27 May 2021 04:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=T60uS3q8aUg0+UV9aRGaissqnC4d5WsFq/hJlmF4BE0=;
        b=h4m1dvMS892y0jTG+g0pKEuaCrn2v89+9aI204b6ApSzHBFWRRIhbJ8SE6nXQVGrEb
         ml/v+aCV6CF5ngIcxVetO9nWl3w9rI6gl2Dy/fGYYdyWw6V+LzcSc9LvWFZBP7VIT+ij
         Fn4uHwemjFbBpGtxAtjekFbCJyPrDfj26j3mM/oBEHa+qCJXfTHVKAxozO/dszdlDqsj
         ghsqMMu087NpI2A72pUW+kjkpl3BCdkPg2s3j5uHFSzOeuM+PkIroiSSeCdSwdwPMjTo
         GZxUmQ03oEu7fTaUTSBiw0AOUI9k3oJ4YjxN+W4yejnBACI+ka/JDweN4cMEh0oiwdtq
         NfVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=T60uS3q8aUg0+UV9aRGaissqnC4d5WsFq/hJlmF4BE0=;
        b=Bx5ZqMkTRPYt+p/gFCL56ln/jYvzbqTxzLvWdthLorQopT7eqeDXMEtvkn0AVXEv53
         X/WupjStnLMl326NXkX5H4tvbJ6tvpstmTSgCEdH7yCxHKTb0znkokUzbxPDRMWGvy98
         4IofnFAT/5/7Ku4BUTSiY8dwdZpz2DLyCVu9m9HvQWqKxgeQcu6YKHimpcG3HQobWYQD
         m7Y7zHQvyV/XboNhEaLfWMxrjF05Rl4VInVcSM/ZiJa/LvHkBtyfCWhHd095vwg2gazl
         MYjV98RsqAuZuTRX8Gjyuze1QelT4VvvVGmbowVMz5bK5xmCNJlcMyH/KgfqgysdWu8f
         AvYA==
X-Gm-Message-State: AOAM533fzFc9BGClSJUZMArXsUL+iOuxp3kvYXg7glp+k6BZqb5kCsM/
        BP6qkYVAgqm9Q52e/PTRiVBT//VbtsJ+0A==
X-Google-Smtp-Source: ABdhPJw/dp8aZjnyLU2hSgyU+OfdkI+C5cce/803CR3TWj/muhzubz+m8Ym4lH1frvtiSxvRF1WQeg==
X-Received: by 2002:aa7:d70e:: with SMTP id t14mr3629608edq.377.1622116320082;
        Thu, 27 May 2021 04:52:00 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id p25sm884622eja.35.2021.05.27.04.51.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 04:51:59 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        James Ramsay <james@jramsay.com.au>,
        Jonathan Nieder <jrnieder@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Josh Steadmon <steadmon@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH v9 00/37] propose config-based hooks
Date:   Thu, 27 May 2021 13:49:42 +0200
References: <20210311021037.3001235-1-emilyshaffer@google.com>
 <20210527000856.695702-1-emilyshaffer@google.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <20210527000856.695702-1-emilyshaffer@google.com>
Message-ID: <87zgwgl7hd.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, May 26 2021, Emily Shaffer wrote:

> After much delay and $DAYJOB, here is v9.

Thanks. Haven't done any deep review of this yet. Just skimming things
from v8 & commenting as I go along...

> - Addressed nits in reviews on v8
> [...
>   =C3=86var's updated system_or_die() function
> - changed strbuf to char* in hooks_list
>   - Attempted to do so in run_command's stdout callback, but this made
>     length protection difficult, so stuck with strbuf there.

I see there's still quite a bit of that strbuf churn still in this
series, e.g. unfixed issues noted in
https://lore.kernel.org/git/87pn04g0r1.fsf@evledraar.gmail.com/ e.g. in
07/37 you're still doing this:
=09
	+	struct strbuf hookname =3D STRBUF_INIT;
	+ [...]
	+	strbuf_addstr(&hookname, argv[0]);
	+	opt.run_hookdir =3D should_run_hookdir;
	+
	+	rc =3D run_hooks(hookname.buf, &opt);
	+
	+	strbuf_release(&hookname);

So fair enough n the run_command's stdout callback, but it seems there's
still quite a bit of strbuf encapsulating for no apparent benefit.

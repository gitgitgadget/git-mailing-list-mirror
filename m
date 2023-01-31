Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 733BEC636CC
	for <git@archiver.kernel.org>; Tue, 31 Jan 2023 20:31:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbjAaUb5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Jan 2023 15:31:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbjAaUb4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jan 2023 15:31:56 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26886CC38
        for <git@vger.kernel.org>; Tue, 31 Jan 2023 12:31:55 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id t18so15407587wro.1
        for <git@vger.kernel.org>; Tue, 31 Jan 2023 12:31:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HCqZDDOdWbpi+GP4ZOPIHooLYTb9zy79+4r0hHDVMjs=;
        b=en9x2W+G0r5RcucaoNoSOt/hgIeba5/eohLqUmwuux88LX8r/ObP4fZcLSkqA29AtW
         l6+YSEfsn4OzDq56gFgd6esJoiwMdbR3A+J50A6OWh7i6mkNm+ofweK64wyocWIYfYim
         IstL60yxWtN/xzYKBj9xGqe/qDxfi/u3Br5Klb5iX60Ry62hlyG14FKlKPO345NgusDo
         vuVsSfzcxSISXc2vPI0pvpZQVjaYURC/vC33su15Ahihzcvtx6W9IK7EcRVNCcVTCqyX
         NMorsuBd0y40ci27oeRK8k6vS0lF4PLZzG9Ub3pcLt90dYI/iUawF6pvPx/Z2ark5LGG
         +IKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HCqZDDOdWbpi+GP4ZOPIHooLYTb9zy79+4r0hHDVMjs=;
        b=UXtsrzLal5NROSJgUuFVBbTnPEj0yi+/OyPKD0vomTDOWi3ldcszdd1+lK7tM8wd/X
         h7XT+USJdcWeQihczh6mEb2WqHjXrmVwDV63Asu9P0OjumoHKw4yzwC2PTR9+mmOrrZ0
         oSWLdsoURxArXYo6WG/k8kvQfAq/mDoOHRQ+7+ZsG2WG7/jJyTzHkM/bacV2k96A1MVA
         82QCItFZrQNKueeVIvPF0pjCBsQFHHFjU8U7iDJY13LLDtsdubSWPPzvZjgJ2gZFYQkX
         0mlBGFLmsKkcbwEaz6AnE8rUQYZwaK4WVCqflfCtmqyiSjVVgFVgCG2y+4P+aO/7VT3E
         abNg==
X-Gm-Message-State: AO0yUKXaJplK8CzUpU2aooBShMzyrPs1/F5hHMX04EH4qVElQbQsyVUF
        mD2fVsRpQaPwN3w60OBGsJz/2F/JNzNsns40Jjo=
X-Google-Smtp-Source: AK7set/jghTrxSXqWJDog312+zG/S+ksjui+m8hLtAyLfx2v9tRXrsISRWET/U7CqORaEt0Zt1OvqyUe4/vYAunDwbc=
X-Received: by 2002:adf:fdd2:0:b0:2bf:eb2c:367 with SMTP id
 i18-20020adffdd2000000b002bfeb2c0367mr8887wrs.663.1675197113373; Tue, 31 Jan
 2023 12:31:53 -0800 (PST)
MIME-Version: 1.0
References: <4831bbeb0ec29ec84f92e0badfc0d628ecc6921d.camel@siemens.com>
 <Y9j1RxKhNq2TnL4U@tapette.crustytoothpaste.net> <339359ee8a228ea108109cf852bcb7e145807dcf.camel@siemens.com>
In-Reply-To: <339359ee8a228ea108109cf852bcb7e145807dcf.camel@siemens.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Tue, 31 Jan 2023 12:31:41 -0800
Message-ID: <CA+P7+xpgJKojMmcN9TuGDw8oduQSQk-5nUtsWc+4Seqa+eVDJQ@mail.gmail.com>
Subject: Re: Bug: Cloning git repositories behind a proxy using the git://
 protocol broken since 2.32
To:     Florian Bezdeka <florian.bezdeka@siemens.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "greg.pflaum@pnp-hcl.com" <greg.pflaum@pnp-hcl.com>,
        "peff@peff.net" <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 31, 2023 at 4:17 AM Florian Bezdeka
<florian.bezdeka@siemens.com> wrote:
> Thanks for the super fast response, highly appreciated!
>
> I was able to get it running by switching to ncat using the --no-
> shutdown option, but I failed to bring back socat support so far.
>
> For me this is still a regression. We have to change our
> infrastructure/environment because we have a new requirement
> (independent handling of stdin/out) after updating git now. I would
> expect some noise from the yocto/OE community in the future where oe-
> git-proxy is heavily used.
>
> I guess proxy support was forgotten when the referenced change was
> made. Any chance we can avoid closing stdout when running "in proxy
> mode" to restore backward compatibility?
>
> Thanks a lot!

I had this issue in the past and i got it working with socat using "-t
10". You need a timeout that is larger than the keep alive value of 5
seconds which is sent by the git protocol.

Junio pointed out the excellent analysis from Peff regarding the
situation and the fact that socat is wrong here.

What value of -t did you try?

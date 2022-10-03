Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08B49C433FE
	for <git@archiver.kernel.org>; Mon,  3 Oct 2022 23:46:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbiJCXqG convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Mon, 3 Oct 2022 19:46:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiJCXqC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Oct 2022 19:46:02 -0400
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E86C476E0
        for <git@vger.kernel.org>; Mon,  3 Oct 2022 16:46:01 -0700 (PDT)
Received: by mail-qk1-f177.google.com with SMTP id c19so7517596qkm.7
        for <git@vger.kernel.org>; Mon, 03 Oct 2022 16:46:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=KyQscSDxPtyRYbWlKDsVC9oke5gExwFUhmQKHdaGuR8=;
        b=h/J4lV3KNrdxakD2u4155/7G0fyeRVIqffTn+epa9KTJk9jNIB69Z9hWyzKbEzsDWo
         bb5uTzZQF8xv5/TGUCM/UqaJA0kazqHwGjRlYymYcj8NkFPesTL45dITGw147J0ZqnMb
         rqfpXIc9NKgQRoDjE4KpdMUUmN+9sB+P4/b1GRTYuy8t07eflzXZjCqT5Tym+eZombhr
         HZ/DSb4ZECXXMihJx6Yo/HLcXVeWoeeMilQ0pJswmN/oGqyFYzwfhwsrXf05ihkyzHng
         btHRwef3PNPOFjsFvuUKXgneglD2NEn5bQ1UKAMxEmc5SBaMA+JaS793iEo4dUJQJ8bv
         rd7A==
X-Gm-Message-State: ACrzQf0PyQSH88cdH43Uz+3ntexj6q1vRmMG6qV1MiUoKbI4r6YaHDvZ
        f0YLt9BlYpKU4hdg/DhQsgL+BIhDMkykckEUsF4=
X-Google-Smtp-Source: AMsMyM55kWq/UGsXLJEyFGZLARw2gcR/SZW9PVlmL4OWsMIO2qte1vmPPtXaT+qpWB6sa+uX0BDf+vc2F2zHljNrKZM=
X-Received: by 2002:a37:a982:0:b0:6cf:6de9:1bee with SMTP id
 s124-20020a37a982000000b006cf6de91beemr15185095qke.423.1664840760019; Mon, 03
 Oct 2022 16:46:00 -0700 (PDT)
MIME-Version: 1.0
References: <20221003212318.3092010-1-asedeno@google.com> <YzthTugwy+eaIUxr@tapette.crustytoothpaste.net>
In-Reply-To: <YzthTugwy+eaIUxr@tapette.crustytoothpaste.net>
From:   =?UTF-8?Q?Alejandro_R=2E_Sede=C3=B1o?= <asedeno@mit.edu>
Date:   Mon, 3 Oct 2022 19:45:44 -0400
Message-ID: <CAOO-Oz2WnodBnw86mi2GZ+jLGoGy_saX=kCpwPdm2xohDO1s_Q@mail.gmail.com>
Subject: Re: [PATCH] git-compat-util.h: GCC deprecated only takes a message in
 GCC 4.5+
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?Q?Aleajndro_R_Sede=C3=B1o?= <asedeno@google.com>,
        git@vger.kernel.org,
        =?UTF-8?Q?Alejandro_R=2E_Sede=C3=B1o?= <asedeno@mit.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I'm targeting an old SunOS 5.10 with a GCC 3.4.3, for reasons that can
only be described as self-loathing. :-)
The other users of GIT_GNUC_PREREQ are used for 2.8, and 3.1, so I
figure distinguishing between 4.5+ and <4.5 should be well supported.

Regardless, there's no reason to break older compilers over something
that's this trivial to fix.

-Alejandro


On Mon, Oct 3, 2022 at 6:26 PM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> On 2022-10-03 at 21:23:18, Aleajndro R Sedeño wrote:
> > From: Alejandro R. Sedeño <asedeno@mit.edu>
> >
> > Signed-off-by: Alejandro R. Sedeño <asedeno@mit.edu>
> > Signed-off-by: Alejandro R Sedeño <asedeno@google.com>
>
> It might be helpful to explain what system you're targeting when you see
> this.  CentOS 7 has GCC 4.8, and I'm not aware of any systems with an
> older compiler receiving publicly available updates still.  We've fairly
> recently only been testing and targeting GCC 4.8 for that reason.
> --
> brian m. carlson (he/him or they/them)
> Toronto, Ontario, CA

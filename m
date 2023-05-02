Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 657FFC77B73
	for <git@archiver.kernel.org>; Tue,  2 May 2023 18:39:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233333AbjEBSje (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 May 2023 14:39:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbjEBSjc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2023 14:39:32 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3E131727
        for <git@vger.kernel.org>; Tue,  2 May 2023 11:39:28 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id 46e09a7af769-6a5dd070aa1so1661555a34.3
        for <git@vger.kernel.org>; Tue, 02 May 2023 11:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683052768; x=1685644768;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2L/ZttygfzAB1Q2dBiz+bs4X3QwXwouelZRGQqC/STs=;
        b=VS6QruTMgL3lxr5z4+ZpwHf7nB57Ioxg9qfjOYAqv5NX+icm2N6jxTYzbEYWcda5bc
         rhJWHsJbYOHCFLI+q1hhQg4oA/47h0eiKfHk4RX2FLi2Xe9tOQiXKvuj1/e5nklO6AMR
         hakWVEspFu+SOSt4s+liMynAzfsp5XLX8F4ewFJ7wr/eE+Eq0ghw+Aqx2ZCrELfCTraz
         chFIjMW92ot+eORBvaidMMwU85ycWUZD+aexwkp5jM08/kajEVC22lXU1hjCi/Xtkdmy
         q6B7M3o23GFONZo68ScDCjCfywuisITFgPrKeNAbwbOznUViWt6pCBf9uV8/7RlLjlRD
         aFng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683052768; x=1685644768;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2L/ZttygfzAB1Q2dBiz+bs4X3QwXwouelZRGQqC/STs=;
        b=bg9WmowEjkQPbflg7kbSaviM0mnsBeG4tGKuR+xn82bYra5J8iSB7rWlv/CMMG7UbZ
         lBpTRofmqIWRurosTtebCfuRPut5P0HpW5drYAFMAS1v2Ma1QTESVqZpdnWnlMX53h4d
         dR1eU6e2sTBFmC+iExM/Aw2HAoMjbE+MBf4nhGwLt0ljZKNkVz68WeFwg+IlO7vOjW6M
         oIElMC9EPp9JIIQn9Na4m9AJQf05w1Sx37IPwgaEDJMgL4VSlSN15shq56vKTSuPomDz
         SM27ByXQF+lblXpKHDAypWmLooHhAxIXmNjm2fh8YyzApNo+T4fY409xYzw0e5i27XAh
         Jvjg==
X-Gm-Message-State: AC+VfDy9BcMWepvPoL/IpyxTBLtKKgplLQpdYtmLokADCna3UvUrzsk6
        Bgd10ueYZDmcluzeDB+3iHU=
X-Google-Smtp-Source: ACHHUZ5u84uliq1aRYmHEGc5NB6oHZUCU7sCaFnZ6BiIYkQZDrSHMP9al0jGZ32WL5StEDENarpjuQ==
X-Received: by 2002:a9d:750a:0:b0:6a6:2cda:849e with SMTP id r10-20020a9d750a000000b006a62cda849emr9218191otk.5.1683052768203;
        Tue, 02 May 2023 11:39:28 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id p26-20020a9d695a000000b006a13dd5c8a2sm12982760oto.5.2023.05.02.11.39.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 May 2023 11:39:27 -0700 (PDT)
Date:   Tue, 02 May 2023 12:39:26 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Maxim Cournoyer <maxim.cournoyer@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Cc:     git@vger.kernel.org, gitster@pobox.com
Message-ID: <645158de9d0d0_1ba2d294a6@chronos.notmuch>
In-Reply-To: <87h6t3pyn1.fsf@gmail.com>
References: <xmqqh6t57x0y.fsf@gitster.g>
 <20230425162631.13684-1-maxim.cournoyer@gmail.com>
 <20230425162631.13684-2-maxim.cournoyer@gmail.com>
 <CAPig+cQ+6m35cTXr20-BNyHRsQQq2nTNERCH8N9NMsUP8Ct7mA@mail.gmail.com>
 <87h6t3pyn1.fsf@gmail.com>
Subject: Re: [PATCH v2 1/2] send-email: extract execute_cmd from
 recipients_cmd
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Maxim Cournoyer wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
> =

> > On Tue, Apr 25, 2023 at 12:46=E2=80=AFPM Maxim Cournoyer
> > <maxim.cournoyer@gmail.com> wrote:
> >> diff --git a/git-send-email.perl b/git-send-email.perl
> >> @@ -2,6 +2,7 @@
> >>  # Copyright 2002,2005 Greg Kroah-Hartman <greg@kroah.com>
> >>  # Copyright 2005 Ryan Anderson <ryan@michonline.com>
> >> +# Copyright 2023 Maxim Cournoyer <maxim.cournoyer@gmail.com>
> >
> > Let's avoid this change, please. Many people have worked on this file=

> > over the years -- often making changes far more substantial than thos=
e
> > made by this patch series -- who have not staked such a claim.
> =

> I don't mind to drop this hunk if it's unwelcome/not current practice.

In most open source projects the practice is that only the top one or two=

contributors are mentioned.

> it's still enough of a change to be protected by copyright though, but
> I don't mind too much.

My understanding is that your work is protected by copyright laws
regardless of whether or not a copyright notice exists. Not that it
would matter much in practice though, because the cases where copyright
matters in open source projects is very fringe.

Cheers.

-- =

Felipe Contreras=

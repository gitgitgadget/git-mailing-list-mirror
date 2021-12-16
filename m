Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44A14C433F5
	for <git@archiver.kernel.org>; Thu, 16 Dec 2021 15:41:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238599AbhLPPlr (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Dec 2021 10:41:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232607AbhLPPlr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Dec 2021 10:41:47 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3D84C061574
        for <git@vger.kernel.org>; Thu, 16 Dec 2021 07:41:46 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id r11so87567336edd.9
        for <git@vger.kernel.org>; Thu, 16 Dec 2021 07:41:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=bYBfr7OxOuH0dW+x+vgyE3k2fHn4rc8c+NseqNS08ag=;
        b=GMFcJswsRdaOZCm6pTDcDQvaQf6YlSyOh61wjSytK46MZkHDPKY9455qBdvzK8Sxxr
         3xDmBnBRRvM5dzgEZ9bD8dqFxnjjrdyyXHyd1tMuz/h1Tf7fAVCnS+V5XswoJyIr+4Q3
         KVHYyNMT4alndGb2LeL7kSFufulBhRw7jOu0B0yjpxZSupwRPqEBiYLis8XSso4Sypha
         6f5hAo7EZG1//tc1A6QUkXBWEf+BQ43CU6Q2Tu0Ir0ltauSepV4JPddTqwonL/+/Tx2Z
         IfVTijFHrL9gpYJRiocpLGY2sXdKHJOAOYga50xNUNa5JcKv2kaPIua2xEKmPV+34NQb
         r/4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=bYBfr7OxOuH0dW+x+vgyE3k2fHn4rc8c+NseqNS08ag=;
        b=3zL8AAkT53t0KIR7vLgriYlHJ/DTWPrOncW7wQai3jJrIKUNkD1FKLpxNbIG1d59aw
         Ng/h8GzhjJkhPUeMCwXydtZdkOyzOI8fSf7UHZWBW9BgF8sll3bQHJ6RAXHTJuoASFxs
         u/GUEcGOv+d9rmEn0D9nV9OWkfdcU+xT+ePBnitQa98rIvwmwZIcyRnRyLlvkx0Jz63V
         VPJsVhUCTEIhH0sppqp7xUyobLdHXjvwewpzR2PgJDaRrqHPbRSNPsGyIWqa+sTSg9HZ
         36/uU4xAd5tYZ3RJlENhRDSq6hBzIJMkEYNRtzRC1sMj0BiVMGmuQJw6UrD/Azco3k50
         PN7A==
X-Gm-Message-State: AOAM531vSplJG7ltK6yF30K9k4csXBO14wBfPOEj9MpwtAEBG5hQ0vuP
        hS9A1pdkJtHBYpel7j+avzhHtQu1ZcUPwg==
X-Google-Smtp-Source: ABdhPJyho1lTJpN19QoLKizSqGyOHVCp1XXIYvvigdudHUJY82ucgNFbcmcm4U/IF8rIgrkxwJj5nw==
X-Received: by 2002:a05:6402:5194:: with SMTP id q20mr21168158edd.123.1639669304272;
        Thu, 16 Dec 2021 07:41:44 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id gn26sm1957708ejc.14.2021.12.16.07.41.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 07:41:43 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mxst4-000SX8-JH;
        Thu, 16 Dec 2021 16:41:42 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: ab/run-command (was: What's cooking in git.git (Dec 2021, #04;
 Wed, 15))
Date:   Thu, 16 Dec 2021 16:38:21 +0100
References: <xmqq8rwlz3cq.fsf@gitster.g>
 <211216.868rwkbv1b.gmgdl@evledraar.gmail.com>
 <Ybtb6Shdj56ACdub@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <Ybtb6Shdj56ACdub@coredump.intra.peff.net>
Message-ID: <211216.86v8zoa761.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Dec 16 2021, Jeff King wrote:

> On Thu, Dec 16, 2021 at 12:51:55PM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>
>> Or maybe you're not interested in either case, which is also fine. It's
>> really not needed for anything other than to resolve the minor oddity
>> that we have two "struct strvec"'s, "args" and "env_array". It's just a
>> bit odd to have one with "_array" in the name, which is only because the
>> now-removed "env" was taken at the time.
>
> Yeah, FWIW I absolutely hated "env_array" when I added it, but didn't
> want to do the transition all at once, so needed another name. So I
> would be happy to see it become "env" now. ;)

Thanks.

> Turning "args" into "argv" is less important, just because the name is
> less long and ugly. And since "argv" is both the concept of the arg list
> and also the well-known main() parameter with a different type, arguably
> using it for a type besides "const char **" could be confusing (though I
> don't find it so personally).

I like that it's just "args", so I don't think I'd change it even if I
could waive the proverbial magic wand to d oit.

We also have non-run-command.h code that uses "struct strvec args =3D
STRVEC_INIT" (although most of that ends up being passed into the
run_command.c function).

Saying "argv.v" also seems a bit more strange than "args.v", IMO.

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A777C433EF
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 21:54:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 693C06103E
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 21:54:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232113AbhJVV5A (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Oct 2021 17:57:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231363AbhJVV47 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Oct 2021 17:56:59 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7632BC061764
        for <git@vger.kernel.org>; Fri, 22 Oct 2021 14:54:41 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id t9so73375lfd.1
        for <git@vger.kernel.org>; Fri, 22 Oct 2021 14:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=6qX5m/+fLkQIKekXvJ4jrbh/jnS31Uy4nYhQQU7/sYQ=;
        b=EiFnYmGFWul2dtqe5q76PosqAUXW3og1fbP/Nt3f9c10SMUQU6xApZEcxRsMrSXsOZ
         gIUyAnbuMagg9/03Cs7rcJWKMwoz6+aZ8bcduxloqoRrJTfZ4Zr3EQqG974udlCj3oXa
         rzjVMzL44YgsJmsInQh7lE1QNyKDt3RjV8MsTcj+xq4ckiUsprbzmES6zYdHwnPGXOk5
         4kcLYnYsS18LjB+2IBfhgKEb/pmS2EQcKvAIB2RCu4xdtFejoI+fvVKD9BpKsND9Sp5g
         bsH5cKaMsi3VWc3b5R0F2v1dN9gRHKvBe0diI+aCMqQSh5Plg+L8hkcGuCIcVbHDZmcN
         yBDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=6qX5m/+fLkQIKekXvJ4jrbh/jnS31Uy4nYhQQU7/sYQ=;
        b=ETqxVei+QJR319ZngolDBEtijbaVYgV6yaXSYkw6T6RUT12c+7hEgtFJQANvfS27CS
         uqSinlBedJhiaiE4UbOFvRWmp+M5smWvvP0J0iaAgWUN2ph4orEFTjNnQ48TaMbzZhDM
         XKNp7BAMk7lF5T/yAoiKrYxZBwgdYJINA/7o3Z+lgzbYBTsC9WohmxAmFhABaLt9xNnd
         SS7PFzeo6nMJ6hvxRkUX5fRXaiZ/+CnOYFkFrHyMCy/rlJ9YKyYUTDMnyDqgNmOCiscA
         FPwBV+WgJuLZd4by9QvwiYa/gbonEmvlJ8afMxXHarxRg+02xVEas4PZSr3FVtTKLnYo
         5DIw==
X-Gm-Message-State: AOAM533N1oNho5Xd+Jyq8Vsy/BijQgRWv1s6spkzpps5Nc7AnPia2XkN
        TTG8GMmDNwyUYubXJtYCFRkn3iJR6Fo=
X-Google-Smtp-Source: ABdhPJxz9ql3LuU0hM8oBMpFV83vg5C5+XyYHbyxiLBNIuHw8/nxCdZ9kTeHOiDAU5jAGlULR901lQ==
X-Received: by 2002:ac2:46ed:: with SMTP id q13mr2031023lfo.231.1634939679687;
        Fri, 22 Oct 2021 14:54:39 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id bp25sm842490lfb.64.2021.10.22.14.54.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Oct 2021 14:54:39 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     martin <test2@mfriebe.de>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org, Josh Steadmon <steadmon@google.com>
Subject: Re: changing the experimental 'git switch'
References: <nycvar.QRO.7.76.6.2110211129130.56@tvgsbejvaqbjf.bet>
        <nycvar.QRO.7.76.6.2110211150290.56@tvgsbejvaqbjf.bet>
        <211021.86wnm6l1ip.gmgdl@evledraar.gmail.com>
        <9c6b3041-a5c0-6fe1-860e-7bfcb292ae81@mfriebe.de>
        <211022.86v91pjfn7.gmgdl@evledraar.gmail.com>
Date:   Sat, 23 Oct 2021 00:54:38 +0300
In-Reply-To: <211022.86v91pjfn7.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Fri, 22 Oct 2021 16:24:49 +0200")
Message-ID: <875ytozpwh.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> On Fri, Oct 22 2021, martin wrote:
>

[...]

>> If 2 letters could be used, then -c could be given twice for "create copy"
>> -c  => create
>> -c -c  => create copy
>> -cc  => create copy

Please, no!

> Hrm, that's interesting.

Yep, Git UI is too "interesting" already.

> But probably better to have a long-option.

Definitely.

> Some short options (notable -v for --verbose) often work like that,
> but I wonder if people wouldn't just be confused by it.

I would be confused. Those options that do behave like that usually
just increase (implicit) level of verbosity or debug level, so -vv is a
way to say --verbose=2, and -vvv => --verbose=3.

An option that changes its semantic depending on its sequence number is
something that I'd avoid like a plague.

Thanks,
-- Sergey Organov
 

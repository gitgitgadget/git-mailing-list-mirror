Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17876C4361A
	for <git@archiver.kernel.org>; Sat,  5 Dec 2020 07:13:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC5C222D2B
	for <git@archiver.kernel.org>; Sat,  5 Dec 2020 07:13:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727591AbgLEHNl (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Dec 2020 02:13:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726031AbgLEHNk (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Dec 2020 02:13:40 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92B5DC0613D1
        for <git@vger.kernel.org>; Fri,  4 Dec 2020 23:12:54 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id d3so7164969wmb.4
        for <git@vger.kernel.org>; Fri, 04 Dec 2020 23:12:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=hH56Obic4ojFhmxsrdZmhA9Vxd9JeRoI/km9klEMkDc=;
        b=EbPzjFhbofMG9zDWWccL1ODdSV9w9dOuyrRq0N77IFjER7PFH+F8d6WBQHizXgGptH
         cnYQOtPD0TNMqFApaw4x/cX/L/CVWKcrVwFAaruRAKaM9XxiEIijtfTgysiRyxny1XyY
         WG72So66jpJe5we9wMOoiL/7drsDE7NgnQEibfU/EruIt9fkVtNHVVL2+1ET6gYEXRVl
         7AZXzR0BtbWjMuskDmJHhF18a3Iskuu6zginr01DBWVCvfr4gRkeBEDt+ek+4xxmkqbF
         htJg0tABLxlwpFA8D9B6MK0YIwGetG2mpTe2JjY4lN2JhKYbrEoawzUtKBL1I8z5KUmu
         jOhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hH56Obic4ojFhmxsrdZmhA9Vxd9JeRoI/km9klEMkDc=;
        b=feIrzpWqiT4NCzL0IDaxmklI1y9LUv3s8r+wz7z8eAQyh1cFJd62SQfaWB0TkiLEGT
         KPT52C6Y/qIHXTkQdwvjpgnRn4l3tLaDpXxefI4Xn78XIu7UmTEcUoSkOWIUZIWAQAUt
         zNKkfhsa9whO6RnlUxEp+5v5mhz+ETRB1be4JpaXpEI6GTeJS2Js37dz+sNJU1jKBai/
         a51oiJp23J9EaN4we8yKf4f7JnEQpf9Amqgru/f7zEiT/YhEhNmV16rKxTmGBGuzhtIR
         cpYlY7po80B7Ij9rr43KaqHjD/F/yH9nQzB1R1CwBGl+nM1eiGJI0bXbl7nZkuyJjdxA
         p6WQ==
X-Gm-Message-State: AOAM530MoG5cdKQ0S7EpBUA7EaMFnh+0CqxCwyLSd/Gv8Q10fn5f4lDU
        q/xYIlMSPYUS9Kw5+P9HrX7wW6oyFAeQvXIIhlnhZJG0OAyerg==
X-Google-Smtp-Source: ABdhPJzHaE3C3n9Fw2QGOpGBiUS6jVh5K5Agn97ML88uslPON8W8s9mGE+NvPp6C0qf5MMU/bR5smYCzTWsLJ/GDpOM=
X-Received: by 2002:a1c:f619:: with SMTP id w25mr7852399wmc.55.1607152373053;
 Fri, 04 Dec 2020 23:12:53 -0800 (PST)
MIME-Version: 1.0
References: <20201205071023.1270390-1-felipe.contreras@gmail.com>
In-Reply-To: <20201205071023.1270390-1-felipe.contreras@gmail.com>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Sat, 5 Dec 2020 01:12:42 -0600
Message-ID: <CAMP44s0xdkG5P_QHasQZbM3wNf3H99ZWCKB4qgP0Xdigpo7aoQ@mail.gmail.com>
Subject: Re: [PATCH] completion: bash: fix gitk alias regression
To:     Git <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Dec 5, 2020 at 1:10 AM Felipe Contreras
<felipe.contreras@gmail.com> wrote:
>
> Long time ago when the _git_complete helper was introduced, _gitk was
> replaced with __gitk_main, and a placeholder for backwards compatibility
> pointing to __git_wrap_main_gitk was left in place.
>
> When "__git_complete gitk __gitk_main" was called, that created the
> __git_wrap__gitk_main helper, which is just basically "__git_func_wrap
> __gitk_main" plus `complete` options.
>
> Unfortunately the commit b0a4b2d257 (completion: add support for
> backwards compatibility, 2012-05-19) missed a previous instance of a
> call to _gitk in _git_gitk
>
> So, basically we had __git_wrap__git_main -> __git_func_wrap __git_main -=
>
> __git_complete_command gitk -> _git_gitk -> _gitk ->
> __git_wrap__gitk_main -> __git_func_wrap __gitk_main -> __gitk_main.
>
> There was never any need to call __git_func_wrap twice. Since _git_gitk
> is always called inside the wrapper, it can call __gitk_main directly.
>
> And then, in commit 441ecdab37 (completion: bash: remove old compat
> wrappers, 2020-10-27) _gitk was removed, which triggers the following
> error:
>
>   _git_gitk:9: command not found: _gitk
>
> Let's call the correct function: __gitk_main.
>
> Cc: SZEDER G=C3=A1bor <szeder@ira.uka.de>

Hmmm. SZEDER G=C3=A1bor <szeder.dev@gmail.com>

--=20
Felipe Contreras

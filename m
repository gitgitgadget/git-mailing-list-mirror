Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F39A4C433E9
	for <git@archiver.kernel.org>; Fri, 12 Mar 2021 08:50:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BAE5E64FD0
	for <git@archiver.kernel.org>; Fri, 12 Mar 2021 08:50:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232499AbhCLIu2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Mar 2021 03:50:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232479AbhCLIt5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Mar 2021 03:49:57 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82111C061574
        for <git@vger.kernel.org>; Fri, 12 Mar 2021 00:49:57 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id ci14so51697652ejc.7
        for <git@vger.kernel.org>; Fri, 12 Mar 2021 00:49:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=7l7GntrHfQkI7By+6NNcqGLygUn8BiFchEv7RnB0xtY=;
        b=R/DJMneV4x60STxMajqo1rRxJiDfZmO7Og7752KoqY8XDKyaZ10zz/AHSgSsvDsDGB
         bib3zEODPpMm1lCcWOCkG3yS9G5Pw6e/0WS12VV4A1S5xBS+2x1bcQu5J0g7hXxUzo+E
         VeC83M/uWkMob9lj/s4PPAJ3d/osCrbXniF5HaymgRmYVcXlK0Xtty5SIbJFJuj+YgA5
         fzjW/kXWdeWf2cQQezm0dH27Urk8891xdvC3bOoL6Ro5WpKPNd+B4ttxztp6TyDBvwK+
         DnjZY425Kl6Z6p0IIi85i+/ui4cqJb6uUOKVrJ+B52ya51eK1tpuT94GnT0nuTCrsJ1W
         fufw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=7l7GntrHfQkI7By+6NNcqGLygUn8BiFchEv7RnB0xtY=;
        b=k/m3/Fam9ZD4QhTTAdTBQ6x7MD7HTw2O4sH7JBZx5YWjHfkvPio4Od56pu9nGv3Hci
         zjLrYNOKkDt8MidCnML3y4a4JxZXXCmKIuCs9rcZ1lhOyDgwwprP7e3IzsDsOl5jSewF
         bE0QHoo7dHtADDaMPihkumjE5MjQu830jTU9waRtMDrKLptgq6Id9KHY0TO18WpZGkTP
         qSMhJzPkhg4Cenv6zJuc8IjTDMdQACciy/fgfI1Engi5kCJBIk3MYGeFXEM47EcDLVXB
         GRpSDrewYQvr/VfFhB2DtQT642JEFlZEGvFDNxnNpcMkBDCD1FVO2N/u0Xl3k5yz+izo
         JXew==
X-Gm-Message-State: AOAM530yRsQaKRwO5o/v4SZ06lJyS3V8A+zwO8i1HoqRuvp7npSDpIB6
        dKG4FnGsz35i28QptN5o4IA=
X-Google-Smtp-Source: ABdhPJw1UX1n9taX4zRZ6PzEjeb8SFIQZQ9Zouhj9WojvoD1C6XIMdcQO7vr/g3JwDt5i5UeGbaa9w==
X-Received: by 2002:a17:906:1712:: with SMTP id c18mr7471608eje.417.1615538996082;
        Fri, 12 Mar 2021 00:49:56 -0800 (PST)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id n16sm2380378ejy.35.2021.03.12.00.49.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 00:49:55 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v8 06/37] hook: implement hookcmd.<name>.skip
References: <20210311021037.3001235-1-emilyshaffer@google.com>
 <20210311021037.3001235-7-emilyshaffer@google.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <20210311021037.3001235-7-emilyshaffer@google.com>
Date:   Fri, 12 Mar 2021 09:49:55 +0100
Message-ID: <87ft10hi30.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Mar 11 2021, Emily Shaffer wrote:

> +	cat >expected <<-EOF &&
> +	no commands configured for hook '\''pre-commit'\''
> +	EOF
> +
> +	git hook list pre-commit >actual &&
> +	test_i18ncmp expected actual
> +'
> +
> +test_expect_success 'git hook list ignores skip referring to unused hookcmd' '
> +	test_config hookcmd.abc.command "/path/abc" --add &&
> +	test_config hookcmd.abc.skip "true" --add &&
> +
> +	cat >expected <<-EOF &&
> +	no commands configured for hook '\''pre-commit'\''

ditto on the "echo" comment in a previous mail, looks like we can avoid
both of these entirely.

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74EFDC433FE
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 06:21:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32648233CF
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 06:21:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727960AbgLIGVN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Dec 2020 01:21:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726718AbgLIGVN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Dec 2020 01:21:13 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1DDDC0613CF
        for <git@vger.kernel.org>; Tue,  8 Dec 2020 22:20:32 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id t4so401672wrr.12
        for <git@vger.kernel.org>; Tue, 08 Dec 2020 22:20:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FS58iy4vHyUYs95UXjHERlN5ibRaREuXoSvrlbEU+oY=;
        b=AcD1yhJutAbf+jxisGN41moxthBWGBtcbzFOK6bi97i4YFvFNqWd9LhAxROjUY6bWu
         U/kv0WTxFn892ZdDuQAdcVwzaM7uahfkgxk6kAnF36t6NuTujLrQx1n/kfipQfzoh/hF
         NNc4iCZCjUVRC/o+oV1Pii+4uchzwH6heYYEuhufAvrM4K/WtC3DUJGeKKIYmqjq1++6
         FkDu3usd65bgDl+j3PU2YMv15bHzldEbAMghPGdCLk3yzqGmvlfKAo2c+Zs8VYh6s3nc
         1qGB9wPS4S42enbq4xN0FiQ3Jf8velTIhpXrLM3pO8UXgu/q4eH5D1HegfR05WKhIlgL
         AcSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FS58iy4vHyUYs95UXjHERlN5ibRaREuXoSvrlbEU+oY=;
        b=nqP6LYXd5erj7QLIqlKgSkfC1wCwEYos+9f8QWDGWHsvXVXWkmK1cgG0F2LuAkqcTD
         h8SKAaNtoDaG/jlTgmaDOhRcIEQ2F8VocPQPeURly5h4sFsPSv9tvs/awrJ6IiR2CRFf
         j6HUDXld2nS9so9emf7rqLRWqcjO6wdpeWxw8YNcZlOY3ykeypHMPYgfn0/+F0EDJd4s
         fQQ4tla2eUFjjKtc2wziUv3/f+ETUCVqWWMo8UC4zVSjrmPAvPUBwzfNbf1URXV3LWG/
         Rc4Mvvhn6EsLJbPpDdrDzhUw9rdlNzqjzq0J7+mTnHL556wZkjoMDDmmDslvWtnqomUj
         TCyg==
X-Gm-Message-State: AOAM5313xFuGDQEc67DN2+K5lOGh8BpEPOY4cAXf4diG8DmTuco5Fwuv
        P66Dbz6ghNfsoVOHSacqDOA3UuaDNb7r+M6iiMo=
X-Google-Smtp-Source: ABdhPJwhrOSF0NTTaHTt8g2Vu7Rz2VCBnyvCocmPtULQb+Mf+xerS4v3gw9BiO0AfSNpVmw5zoR4ckYvGDXi4YgkjKg=
X-Received: by 2002:a5d:68c9:: with SMTP id p9mr786802wrw.139.1607494831443;
 Tue, 08 Dec 2020 22:20:31 -0800 (PST)
MIME-Version: 1.0
References: <20201209002619.25468-1-felipe.contreras@gmail.com> <X9ApG0jUxJrPDK9d@generichostname>
In-Reply-To: <X9ApG0jUxJrPDK9d@generichostname>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Wed, 9 Dec 2020 00:20:20 -0600
Message-ID: <CAMP44s1fNwC+AfnPJxhG=24Zt5NFE5SoZZXpGEb-jcc+3QSg9A@mail.gmail.com>
Subject: Re: [PATCH] Add project-wide .vimrc configuration
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 8, 2020 at 7:32 PM Denton Liu <liu.denton@gmail.com> wrote:
> On Tue, Dec 08, 2020 at 06:26:19PM -0600, Felipe Contreras wrote:

> > diff --git a/.vimrc b/.vimrc
> > new file mode 100644
> > index 0000000000..d250ab26e0
> > --- /dev/null
> > +++ b/.vimrc
> > @@ -0,0 +1,9 @@
> > +augroup git
> > +  au!
> > +  au BufRead,BufNewFile */t/*.sh set ft=sharness.sh
> > +  au BufRead,BufNewFile */Documentation/*.txt set ft=asciidoc
> > +
> > +  au FileType c setl noet ts=8 sw=0 cino=(s,:0,l1,t0
> > +  au FileType sh setl noet ts=8 sw=0
> > +  au FileType asciidoc setl noet ts=8 sw=0 autoindent
> > +augroup END
>
> A couple of nits. We should tab-indent this file since the rest of the
> project uses tabs everywhere. Also, perhaps use the full name for the
> option names so that it's immediately obvious what each setting does?

All right, makes sense to me.

-- 
Felipe Contreras

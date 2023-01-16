Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9637BC46467
	for <git@archiver.kernel.org>; Mon, 16 Jan 2023 20:48:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233878AbjAPUsy (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Jan 2023 15:48:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233889AbjAPUsj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jan 2023 15:48:39 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B16452B09F
        for <git@vger.kernel.org>; Mon, 16 Jan 2023 12:48:38 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id v13-20020a17090a6b0d00b00219c3be9830so32128794pjj.4
        for <git@vger.kernel.org>; Mon, 16 Jan 2023 12:48:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uzjEHAKA9QiMPHZj0V2rs8OnxPX+P065sqZUseLBJUs=;
        b=Rswk+biqRKbpGwSkgfcmGrL0SWxdyB691BCKujCbEunaBNdRRft4lpYwcRdNwhzdzc
         z9xuMBf+c/rRtUZYuZfCozbkEDoEACID9oG8ryR6tkl5GiVrQ17XOgrOqwOiai4WPt4Z
         csGRjP83Iek99uzG8O8t3yPXfAG28gesMIY1GrJdJpgnqPxwT1i10RKPPK9L15tg5IUC
         3NBwouSBgjlefgVb2rGuEvRUEjrG3V6UatUBd1nuB+ZarCT9muTzoLXHqJryPyUBqgt1
         NdXSDVePt8dkoZCmsyk27lcbNdM8gbEok5E6VmsOZTEtkdVZNWlli/TOe7ZSu43KIgXe
         CdDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uzjEHAKA9QiMPHZj0V2rs8OnxPX+P065sqZUseLBJUs=;
        b=timq842k9F1+Fk/DZT6wjwmCkJfZwp3tL/cZSrsACFaWZXDiN0lXLpqV2ARUvIG9Wj
         FvcWI9ukLE2aKgYAuvVV9V6nxPzb89CQ72KL8DDA208bsromFBlsUYrNUyPT7qGuiSsG
         JN5S1R7bYEIb2gK+FObssW29Wrh1KQSpcD99r29y6d4lP6hjmKEn2mtkQtGIQK7GoddL
         m54McyCbToACT49sD7w2acyghndja3/EQQZGUMWCZMkQ6OLeF9eKLcOOyKPPF/qO2v3T
         I3iYRcUqfi/gRwbhMGd5Ys0C0VUEbEXVUcuCofyGenu1UZbiz4qEsNfZkB254kJUZ5El
         7JOA==
X-Gm-Message-State: AFqh2kr2vt4ykucDE9LDZpENQLxlPYzzQ0bgWM6tQ3j2VaBGDWa29lUV
        8sWk8oYHDzN3QCgmNjkYilaXxatOCwg=
X-Google-Smtp-Source: AMrXdXtKf/I/ktFlJLDsBB05xPQD1mvXAfuXQ6w+0gbt54pskvDxzTcnVbIurdAkbMBS44PlFWvDfw==
X-Received: by 2002:a17:90a:f198:b0:229:98a2:1b9c with SMTP id bv24-20020a17090af19800b0022998a21b9cmr500891pjb.39.1673902118122;
        Mon, 16 Jan 2023 12:48:38 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id p6-20020a17090a4f0600b00218f7c1a7d4sm18792128pjh.56.2023.01.16.12.48.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jan 2023 12:48:37 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v2] grep: correctly identify utf-8 characters with
 \{b,w} in -P
References: <20230108062335.72114-1-carenas@gmail.com>
        <20230108155217.2817-1-carenas@gmail.com>
        <230109.86v8lf297g.gmgdl@evledraar.gmail.com>
Date:   Mon, 16 Jan 2023 12:48:37 -0800
In-Reply-To: <230109.86v8lf297g.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Mon, 09 Jan 2023 12:35:05 +0100")
Message-ID: <xmqqr0vub3yy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> But I don't think it's safe to change the default behavior "git-grep",
> it's not a mere bug fix, but a major behavior change for existing users
> of grep.patternType=perl.
> ...
> Even for Perl, this behavior has been troublesome. Opinions differ, but
> I think many would agree (and I've CC'd the main authority on Perl's
> regex engine) that doing this by default was *probably* a mistake.
> ...
> As the example at the start shows you can already do this with "(*UCP)"
> in the pattern, so perhaps we should just link to the pcre2pattern(3)
> manual from git-grep(1)?

So, now do we have a final verdict on this patch?  If we are not
taking the "unconditonally enable ucp" patch (which I tend to agree
with a safer choice for now), it may make sense to mention (*UCP) in
our documentation somewhere, perhaps?



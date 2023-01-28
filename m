Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFB1FC38142
	for <git@archiver.kernel.org>; Sat, 28 Jan 2023 11:33:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233144AbjA1Ldg (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 28 Jan 2023 06:33:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230474AbjA1Ldf (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Jan 2023 06:33:35 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19AFAA271
        for <git@vger.kernel.org>; Sat, 28 Jan 2023 03:33:34 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id m7-20020a17090a71c700b0022c0c070f2eso10388508pjs.4
        for <git@vger.kernel.org>; Sat, 28 Jan 2023 03:33:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bgbKz13mjW/8A6k22xbdJo5QYh91cKepJoYFWynW90M=;
        b=X9x70gPUCedpro0bzfCWFLwg3IghGGF0UnQ/HoFDcrBtLAHGG02HvPrqmtWK7Nv4hl
         aDDapnEihglnNivFYPS48JkEDWQAleEODEaxSiaMz3J/AQJZGdcMG/kxA1hwPm3aG+lO
         xL6mAzQMZqx8KE/tFk5tdskVTtPBQTiUdgBwe3c6JdXUwh+BAwkxgp5dEDuLOk0Ku7q2
         9Ig3yssmj/YjoYWZlLPuzalP6P60pqgFHBDyiXwhVo21t8ZsKSbhWI78qhdl2Opa+C00
         nXbcFxr/QAoe2pqr4E10W/a6OhHghQGzzl+4UbDvnAAtAi+uP9/iouVqlKV/4QmJYKAb
         uBHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bgbKz13mjW/8A6k22xbdJo5QYh91cKepJoYFWynW90M=;
        b=7eTBTAIfSOZ00WnZwvQI1w4eviPeRnQrqDhQ6q3tfvQfn6tDLSJS0aCJQVz1BDodTd
         kvrV96uGjZ5JDc+5ZUoSMpwsJuSycOHADANOceZVAUHyAiXlTrDlBekkzoR8C69NknO1
         XH0sh9ZziIxIkSGaR3r94RUGVwsLBLBgS7F1yCUbewfH5QrNrZSBF3pKJ8SVfpze2LB2
         8LjzWz0qZnN0BtoqSpr94q78Hcciq81qGpVRY3ATYup4FoWfX4QGim5Z1gS5efgU8DFE
         l/CRCPmvK/LYCdSyugs6ebQmXVUGZlJowBVTcCf+eggACXYOy1QE0gEqUl57gdLYSpOv
         MLQg==
X-Gm-Message-State: AO0yUKUxm5Z1zbLy2XhtU4JbBKmAz0pOycX2sJHj1HaC2sRpfi8Fiplv
        KBwusj7NTbyp58GTLCCw7qFnoFxIN7NagOKU
X-Google-Smtp-Source: AK7set8f2O41yi9LPMlFEGbZ2FGgEJPjwPjaSECCC+DIMeO5d8RIlhUZlcNJsLZTgIt/INRiZxybpQ==
X-Received: by 2002:a05:6a20:1612:b0:bc:2a34:ed3 with SMTP id l18-20020a056a20161200b000bc2a340ed3mr2587353pzj.23.1674905613595;
        Sat, 28 Jan 2023 03:33:33 -0800 (PST)
Received: from localhost.localdomain ([47.246.101.60])
        by smtp.gmail.com with ESMTPSA id w17-20020a637b11000000b004ba55bd69ddsm3721624pgc.57.2023.01.28.03.33.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 28 Jan 2023 03:33:33 -0800 (PST)
From:   Teng Long <dyroneteng@gmail.com>
X-Google-Original-From: Teng Long <tenglong.tl@alibaba-inc.com>
To:     avarab@gmail.com
Cc:     dyroneteng@gmail.com, git@vger.kernel.org, sunshine@sunshineco.com,
        tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v4 2/5] notes.c: cleanup for "designated init" and "char ptr init"
Date:   Sat, 28 Jan 2023 19:33:27 +0800
Message-Id: <20230128113327.56797-1-tenglong.tl@alibaba-inc.com>
X-Mailer: git-send-email 2.39.0.198.ga38d39a4c50
In-Reply-To: <230112.867cxs2i83.gmgdl@evledraar.gmail.com>
References: <230112.867cxs2i83.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason writes:

> > From: Teng Long <dyroneteng@gmail.com>
> >
> > Let's do some cleanup for the following two places in "append_edit()".
> >
> > The first place is "char *logmsg;" need to be initialized with NULL.
> > The second place is "struct note_data d = { 0, 0, NULL, STRBUF_INIT };"
> > could be replaced with designated init format.
> >
> > Signed-off-by: Teng Long <dyroneteng@gmail.com>
> > ---
> >  builtin/notes.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/builtin/notes.c b/builtin/notes.c
> > index e57f024824..8ca55ec83e 100644
> > --- a/builtin/notes.c
> > +++ b/builtin/notes.c
> > @@ -566,9 +566,9 @@ static int append_edit(int argc, const char **argv, const char *prefix)
> >  	struct notes_tree *t;
> >  	struct object_id object, new_note;
> >  	const struct object_id *note;
> > -	char *logmsg;
> > +	char *logmsg = NULL;
>
> This change isn't needed, and the compiler will check that we have it
> init'd.
>
> It *is* needed when combined with your 3/5, but even then it's the wrong
> solution. In that change you move the commit_notes() into that "if"
> branch that needs the "logmsg", and it's correct that you need to
> NULL-init it to safely pass it to free().

You are correct, will fix.

> But let's just declare the "logmsg" in that if block then, and move the
> free() over there, that reduces the scope it's in.
>
> >  	const char * const *usage;
> > -	struct note_data d = { 0, 0, NULL, STRBUF_INIT };
> > +	struct note_data d = { .buf = STRBUF_INIT };
>
> This change is good, but then let's change the other such case in this
> file to a designated init too, and make the commit message etc. be about
> using designated init here.

OK.

Thanks.

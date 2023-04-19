Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B482C77B73
	for <git@archiver.kernel.org>; Wed, 19 Apr 2023 22:32:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbjDSWcK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Apr 2023 18:32:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233189AbjDSWcG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Apr 2023 18:32:06 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C1AA1705
        for <git@vger.kernel.org>; Wed, 19 Apr 2023 15:31:37 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-54fd5d0ad7cso10363667b3.1
        for <git@vger.kernel.org>; Wed, 19 Apr 2023 15:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681943413; x=1684535413;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OgyZH2RqSmlSYDtb3TWdlDstUMq1OmJ6joTiJl4nNSA=;
        b=j/77GEm+f/gUhCpRPllfMzBhMIz/6SobSR2iaNhuEhvOdXWkRZGlBrQuGaTpuwTZI5
         mC+z57zIqdGZw+xgdZ/oD536dS4ptTkENeOom1q/QDGEaHMAOV+ZYZBqv0/6wRuSBM6M
         1KGRNV0RALiCsGhTqfpYzacVRphUNwxyfoxNnq/Nzn00FtwS6MNC0YAeeh4aNICoAAZf
         MFeBFD64hxZb/q02X4dp15jptxEw18pUqIYPtghSEY6pCKQAjmpfIAQOFpYd6cFUuhdK
         /wW4qwGc4/gtf1kjJPVyyghShDX8EniKwvMoLqsx+P1mqwmExeInkUFBTsephjCTKuPu
         B+7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681943413; x=1684535413;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OgyZH2RqSmlSYDtb3TWdlDstUMq1OmJ6joTiJl4nNSA=;
        b=bUXTojNxWeseIH9Cy8tX5H4sOHv1F4mPoS/e4Tb2FTJl8iRaVdX1C6imfcRzA9PDWv
         yuEUMnspR7gQ6lF3zXwA09WcVoasMuCLPqLGcedJLFtRjMSSuSEs9bTVTJdsmCaOpCWZ
         vH2MmIHZ+eAGN2A4IhkAOJKlweDIsFW+1SDJ7IYHHTfA8Citi6zeffOsXfzGOHnapYF8
         GAuzpyrWauBDvAGb7Ixeo4Od1zHtnVnXQbWWUtPYfhpOZ7RdWMqw/dAy14kgLjs5GLkK
         2j3iil0dtf4TFyE1gg+RuVxvvScAvtd8RUAMg2KMD/pxVKsv6bouAXWS0N5pRGSk+58t
         3xVg==
X-Gm-Message-State: AAQBX9e4+FgmQbYKdy9TsYbkKWti/A490LFXxIG08xHbC6f/6PrTdmIC
        Adv/8q3OR0klHU6ChWko9mxVFJe5hIiNjQ==
X-Google-Smtp-Source: AKy350aVh+k1Y/O1liY4PiMJRYTW8DP6m++e4HvXA0PcVtq8pC0lJUk7Vc45Z49pzn/FFwv+w4bd2o5107Bjdg==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3a07])
 (user=chooglen job=sendgmr) by 2002:a25:cac1:0:b0:b6c:48c3:3c1c with SMTP id
 a184-20020a25cac1000000b00b6c48c33c1cmr808188ybg.13.1681943412991; Wed, 19
 Apr 2023 15:30:12 -0700 (PDT)
Date:   Wed, 19 Apr 2023 15:30:11 -0700
In-Reply-To: <230416.86mt38rl2l.gmgdl@evledraar.gmail.com>
Mime-Version: 1.0
References: <pull.1495.git.git.1681329955.gitgitgadget@gmail.com>
 <75feb18dfd8af03f5e7ba02403a16a0ed4c2edaa.1681329955.git.gitgitgadget@gmail.com>
 <230416.86mt38rl2l.gmgdl@evledraar.gmail.com>
Message-ID: <kl6lwn271p58.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH 2/2] cocci: codify authoring and reviewing practices
From:   Glen Choo <chooglen@google.com>
To:     "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>,
        Glen Choo via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Wed, Apr 12 2023, Glen Choo via GitGitGadget wrote:
>
>> +=3D=3D Authoring and reviewing coccinelle changes
>> +
>> +* When introducing and applying a new .cocci file, both the Git changes=
 and
>> +  .cocci file should be reviewed.
>> +
>> +* Reviewers do not need to be coccinelle experts. To give a Reviewed-By=
, it is
>> +  enough for the reviewer to get a rough understanding of the proposed =
rules by
>> +  comparing the .cocci and Git changes, then checking that understandin=
g
>> +  with the author.
>
> Maybe it would be useful here to add something about how you can
> reproduce the application of the coccinelle rule(s).
>
> I sometimes do this on an ad-hoc basis, something like (untested):
>
> 	git checkout HEAD^ -- ':!contrib/coccinelle' '*.[ch]'
> 	make coccicheck
> 	<apply any suggested patches>
> 	git add -A
>
> Then see if I ended up with a no-op, or if there's suggested changes.
>
> With changes that modify both the header & source files this can be
> tricky with the default of SPATCH_USE_O_DEPENDENCIES=3DY, but disabling i=
t
> will take care of any potential circular dependency issues. I.e. when
> the header doesn't contain a required construct that we're replacing.

Makes sense. I've been thinking about sending a "MyFirstCocci" guide as
a follow up, and this sounds like the kind of "Tips & Tricks" content
that would belong there.

>> +* Conversely, authors should consider that reviewers may not be coccine=
lle
>> +  experts. The primary aim should be to make .cocci files easy to under=
stand,
>> +  e.g. by adding comments or by using rules that are easier to understa=
nd even
>> +  if they are less elegant.
>
> I agree that simple things should be kept simple, but this seems to come
> quite close (or perhaps past the line of) suggesting that we use only
> the simpler features of the language when a more elegant solution would
> be available with something less well-known.
>
> I think we should clarify that that's not the intent. Just as with C,
> shellscript, Perl etc. we should aim for simplicity, but ultimately we
> should expect that we can target the full available language available
> to us.

Makes sense too. I think I'll adjust this to something to the effect of
"When using more esoteric parts of the language, be prepared to explain
what the .cocci is doing.".

>> +* .cocci rules should target only the problem it is trying to solve; "c=
ollateral
>> +  damage" is not allowed.
>
> I think what you mean here is that you should be able to apply the rule
> and still build the project.

Yes and no. Yes in that if the project doesn't build, the rule is
obviously overly broad, but no in that I think it's possible to write a
rule that affects something you didn't mean to, but still builds. I
can't think of a way to automatedly check for the latter case, so I
categorized it as something to catch at review time.

>> +* .cocci files used for refactoring should be temporarily kept in-tree =
to aid
>> +  the refactoring of out-of-tree code (e.g. in-flight topics). They sho=
uld be
>> +  removed when enough time has been given for others to refactor their =
code,
>> +  i.e. ~1 release cycle.
>
> Maybe s/should/can/? E.g. for my recent "index" and "the_repository"
> patches I think they can, but we often keep unused code in-repo for
> longer than that. If e.g. that code stayed in for more than one release
> until someone cared to remove it we'd also be fine.
>
> I also don't know if some long-running forks (e.g. GfW?) would benefit
> from the rules for longer than that...

Yeah, this is the most iffy to me too, which means it would be extra
helpful to decide on as many details as we can now instead of deciding
ad-hoc.

Post-refactor, the .cocci file is always obsolete in-tree, so I think we
can either say "always keep the patch" or "never keep the patch".

If I understand you correctly, _how long_ to keep the patch is probably
a case-by-case matter, though (makes sense to me). I think this comes
down to the cost-benefit tradeoff mentioned by others elsewhere in the
thread. Maybe I'll just mention that it depends on the cost-benefit
analysis and drop the "~1 release cycle" recommendation.

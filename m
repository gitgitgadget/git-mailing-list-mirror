Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19A28C4338F
	for <git@archiver.kernel.org>; Wed, 18 Aug 2021 08:56:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E167C60E09
	for <git@archiver.kernel.org>; Wed, 18 Aug 2021 08:56:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbhHRI4x (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Aug 2021 04:56:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbhHRI4w (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Aug 2021 04:56:52 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15929C061764
        for <git@vger.kernel.org>; Wed, 18 Aug 2021 01:56:18 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id h11so3703147ljo.12
        for <git@vger.kernel.org>; Wed, 18 Aug 2021 01:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=iD+k0Fi8Mbh1JFUSPQtUZrN+VK1xO4qT9r0ew8rrvxQ=;
        b=WI43BvxugkaijvDSUgZydDOFqU02NXB4wdOAkwHcATzUWsFmbypoUCINYzL3Gw3XBQ
         Jz76+FWGSXDxCc2Gx24oNnAEgerTfbSuUTAP6U5qCin4mj5nnNI2QpHPbwdVDs2rHBwl
         vO0YFcyywbbVEO5iB8lDpSW0FZT8aHBmQqfpa8x8K2Eiy77+9dr2DoMYGb9qvhc2gVfO
         1qIYtRcEo27OSIpm12Z3AHpld6mLpG+Hv9E+OgY/iMnbINbvWPWKvES3DJyu4FoE5fhA
         HXRbS5tBeleqcSwiKK6khoPDy9ERmsU6Iz8PkI8ar1XdMXeNs4+kgUWS9Acu7ydGIaWp
         oDmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=iD+k0Fi8Mbh1JFUSPQtUZrN+VK1xO4qT9r0ew8rrvxQ=;
        b=o9kO4nYWj86Zwf5EkosI3BARua8LK0O4b/p5hJLVQc+uh3pYpVHdCp6dUVDD7Iz9Om
         OYxYjjVhAcfR0zUS9LiFepr2TBy9Dj3GlAMKhqrQ/DiPUdwpSEjZSzSSOUm2Ch/6OZ94
         ey4XoQ6wnWyUHa4Kb/2iUn4RnnUEL11NToNUHUUOpkJLVasuN+x7vFDzCe9FN63XsBQp
         RdkNdizXGYh2g2q/w+caLtjkhW6iHKbyVSoFsUknoW0c/yCS+EfcEMGc6FmVfBuYTm4V
         j8TBJ6jhdkfFm0swnJ+cb32Jp/vgbSKdVSvM4ZBuLBZscTUxoMWy0K8RIDkXogEz+Ql4
         blpg==
X-Gm-Message-State: AOAM532tIaSEdpnO+bUz/veqiszdv5uqsS8JoTT8GrmGrmjdF+uP+uvK
        dKH6uTxR7A3YVZVyB433tck=
X-Google-Smtp-Source: ABdhPJz0OFxgbQHPVPTd1Ao9X3eQDES+I3lGQiBarhkaOkAgT8u9RTp4OLiTS3/XEjcEA0waH0L3oA==
X-Received: by 2002:a2e:3c01:: with SMTP id j1mr6862582lja.230.1629276976502;
        Wed, 18 Aug 2021 01:56:16 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id d21sm518470ljo.70.2021.08.18.01.56.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 01:56:15 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        huang guanlong <gl041188@gmail.com>, git@vger.kernel.org,
        Hudson Ayers <hudsonayers@google.com>,
        Taylor Yu <tlyu@mit.edu>, Joshua Nelson <jyn514@gmail.com>
Subject: Re: [PATCH] Revert 'diff-merges: let "-m" imply "-p"'
References: <CAMMLpeR-W35Qq6a343ifrxJ=mwBc_VcXZtVrBYDpJTySNBroFw@mail.gmail.com>
        <20210520214703.27323-1-sorganov@gmail.com>
        <20210520214703.27323-11-sorganov@gmail.com>
        <YQtYEftByY8cNMml@google.com> <YQyUM2uZdFBX8G0r@google.com>
        <xmqqh7g2ij5q.fsf@gitster.g> <xmqqczqqihkk.fsf@gitster.g>
        <YQ2UFmCxRKNMOtrD@google.com> <xmqqeeb3hlcq.fsf@gitster.g>
        <87a6lgl9gq.fsf@osv.gnss.ru> <xmqqczqb7mds.fsf@gitster.g>
Date:   Wed, 18 Aug 2021 11:56:14 +0300
In-Reply-To: <xmqqczqb7mds.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
        17 Aug 2021 15:10:55 -0700")
Message-ID: <87fsv7f7wx.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Sergey Organov <sorganov@gmail.com> writes:
>
>> So, do I get it right that there is actually no reason to use "log
>> --first-parent -m" anymore, since the time the much older commit made
>> --first-parent imply -m?
>
> It was necessary for scripts to say
>
>     git log --first-parent -m "$@"
>
> if they wanted to optionally show a first-parent diff for a merge
> when the user of the script passes "-p" in "$@" (and not to show
> patch if the user does not pass "-p").  
>
> That changed with 9ab89a24 (log: enable "-m" automatically with
> "--first-parent", 2020-07-29).

Yes, and since then it's no more needed to say "--first-parent -m" in
this case, as "--fist-parent" will do.

>
> After that commit, it no longer was needed, but it still was correct
> to expect that no patch will be shown with "--first-parent -m",
> unless you give "-p" at the same time.  The original change that the
> patch under discussion reverted broke that expectation.

>
> We need to note that the "-m" implied by "--first-parent" is "if we
> were to show some comparison, do so also for merge commits", not the
> "if the user says '-m', it must mean that the user wants to see
> comparison, period, so make it imply '-p'".  The latter is what was
> reverted.

Yes, there is minor backward incompatibility indeed, and that was
expected. This could be seen from the patch in the same series that
fixes "git stash" by removing unneeded -m.

The fix for the scripts is as simple as removing -m from "--first-parent
-m". It's a one-time change.

>
>> If so, I'd object against this particular patch as the pros of patch
>> being reverted outweighs its cons, and the original patch never meant to
>> be entirely backward compatible in the first place, when it was
>> accepted.
>
> I agree that we both (and if there were other reviewers, they too)
> mistakenly thought that the change in behaviour was innocuous enough
> when we queued the patch, but our mistakes were caught while the
> topic was still cooking in 'next', and I have Jonathan to thank for
> being extra careful.

So, what would be the procedure to get this change back, as this minor
backward incompatibility shouldn't be the show-stopper for the change
that otherwise is an improvement?

Thanks,
-- Sergey Organov

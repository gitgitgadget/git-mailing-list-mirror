Return-Path: <SRS0=lPKc=7W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A70CC433DF
	for <git@archiver.kernel.org>; Tue,  9 Jun 2020 16:28:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2542C20734
	for <git@archiver.kernel.org>; Tue,  9 Jun 2020 16:28:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pJkb6SSJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727820AbgFIQ2x (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Jun 2020 12:28:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbgFIQ2w (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Jun 2020 12:28:52 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68C51C05BD1E
        for <git@vger.kernel.org>; Tue,  9 Jun 2020 09:28:52 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id di13so4299907qvb.12
        for <git@vger.kernel.org>; Tue, 09 Jun 2020 09:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4fUmn1J8PTYoDpxoUUXs1ni2CUHmzfN0JlIWZCGE3Vc=;
        b=pJkb6SSJH8nGbuk0jze5TFZeTcTU6UB8qed4AefrL5tP+qqpMxwvXP6/glZeDucMZR
         RmePsT+rzymr+D5OUAxa3qB67lSiOha64J/55LzDpttygscWT/1OsMARUcumBn/J4BJn
         CFHDwuphPrm0bJjscHq1+T2dG4ja+BZwsoYw+ylTHmpudF19jRp29oFO8RCcmvbkE4Ex
         iUNsN3gi/iByZoQZ10pHep1nz7IHMrEf10NFLenF889jkQLbhnaKNdilawy0RA7CNbAi
         SRXYocW4ARzUC0SLGOu47FhynDKncKBZnDcKa8BzCAoyLYrn6PLY0q1kgJpdR1aWQ3wA
         dH8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4fUmn1J8PTYoDpxoUUXs1ni2CUHmzfN0JlIWZCGE3Vc=;
        b=qUT/o43a84EbhFDTpbbILe67HTx+BJHBlV33wsQ+yG2RCPAwhiPD93vmNYFO+uGSMf
         hvduxj7D1HwNkosZ5X1Mg/gcwsavPsNgin0EP6paVkW2S8BISQI6rKSOIyAV9Bj4K1JB
         vC6Xgb2nQTiBIcebQCxOGkSCO8mNBq0oOOZ2HjlJ1djCeVxAv7ljgdy21B1bxbzus2eO
         TVxvNv4/4qkMtYZr6tcDW0G0Slp+Tz1zoIna9JEdqSSw6dec6T8v/CLaZjmIRkjYpdM0
         UwIQuMWAqenR8YC9RpkxbOWajMN1SWPbSbqaeuUTUemb1/OFiCc+9vzTTAXHUiN0JhSs
         p+PA==
X-Gm-Message-State: AOAM5307k1Dy54m+ce2XULtxfxlLj6gTgZYLaOz392t2OagiMOWJY/Bc
        6s3DqLYaiBI44LSVCmtP2bPir810lr8XipjRpNY8i6jq
X-Google-Smtp-Source: ABdhPJzJHy937JMwIIm+/aRWZMYlq+bExXGOuXTmk1bqpVhIPSbPna7jwIit409xMUQT73hF2I/UUoCHmJ6rUycylM8=
X-Received: by 2002:a05:6214:144:: with SMTP id x4mr4628040qvs.229.1591720131545;
 Tue, 09 Jun 2020 09:28:51 -0700 (PDT)
MIME-Version: 1.0
References: <CAOAHyQwyXC1Z3v7BZAC+Bq6JBaM7FvBenA-1fcqeDV==apdWDg@mail.gmail.com>
 <20200505231641.GH6530@camp.crustytoothpaste.net> <CAOAHyQx=+fM1FpAv+g3M+j7j4MgLJA03=MGFmXLvZcfJKAEpGg@mail.gmail.com>
 <xmqqeeqoi5wc.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqeeqoi5wc.fsf@gitster.c.googlers.com>
From:   demerphq <demerphq@gmail.com>
Date:   Tue, 9 Jun 2020 18:28:40 +0200
Message-ID: <CANgJU+UBcT=at+W_248jWp9_SDqb_YLR0DZ6oYqrcv3id0bAVA@mail.gmail.com>
Subject: Re: Rename offensive terminology (master)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Simon Pieters <simon@bocoup.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Git <git@vger.kernel.org>, don@goodman-wilson.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 9 Jun 2020 at 18:05, Junio C Hamano <gitster@pobox.com> wrote:
>
> Simon Pieters <simon@bocoup.com> writes:
>
> > If someone is interested in helping with this, please follow up with
> > Don. But I would like to ask again for git mainline to seriously
> > consider adopting this change, given the information presented above
> > and the ongoing movement against systemic racism.
>
> I am OK in principle if a future version of Git, when used by a new
> user of Git who does not have any custom configuration, wrote a
> string other than 'master' in .git/HEAD when "git init" is run.
>
> Picking a good replacement word to mean the primary branch is
> tricky, though.  Just having a notion that one is special among
> many (i.e. the primary-ness of the thing being named with a word
> that will replace 'master') may already be offending to some folks.
>
> Also notice that the qualified statement above talks only about the
> plain vanilla experience---the change of the default should be
> designed to avoid harming workflows in existing repositories and
> tools built around them.
>
> So, I think there are two separate tasks that can run in parallel.
>
>  * Pick the new default word to replace 'master'; it may turn out
>    that the Git project choose not to pick any to avoid offending
>    anybody, in which case "git init" may force end users pick the
>    default they want to use and offer recording in the ~/.gitconfig
>    file.
>
>  * Engineering work that uses the word that replaces 'master' by
>    default (if one got chosen) when not configured, and use the word
>    the end user chose when configured (iow, allow users to override
>    the default word that will replace 'master').  This includes
>    design work to decide what to do in existing repositories (if
>    there is anything that needs to be done).
>
> Without digging deeply, I think we are pretty good about basing
> things on HEAD (e.g. "git branch -d" protects the branch by seeing
> if it is already merged to 'HEAD' or its @{upstream}, and not treats
> 'master' any specially), so it might be the matter of teaching "git
> init" (it uses 'master' by default) and "git clone" (it tries to use
> the name of the branch the HEAD at origin points at, but falls back
> to 'master' when the branch name their HEAD points at cannot be
> determined).

I work on two git repos where we renamed "master" to something else.
Both have been in heavy use for years, and I don't recall ever hearing
about any issues related to the branch rename except in dumb scripts.
FWIW we renamed because we felt talking about the "master branch" in a
distributed context would lead to confusing expressions like "the
master master". Using something else avoids this double word
formulation.  I definitely find it less confusing when talking about
the branch topology of these repos as opposed to the defaults.

Yves






-- 
perl -Mre=debug -e "/just|another|perl|hacker/"

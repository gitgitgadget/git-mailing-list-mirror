Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65AF3C433E9
	for <git@archiver.kernel.org>; Mon,  1 Mar 2021 07:45:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3974960238
	for <git@archiver.kernel.org>; Mon,  1 Mar 2021 07:45:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232598AbhCAHnr (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Mar 2021 02:43:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232523AbhCAHno (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Mar 2021 02:43:44 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 469ECC061756
        for <git@vger.kernel.org>; Sun, 28 Feb 2021 23:44:29 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id o11so8765168iob.1
        for <git@vger.kernel.org>; Sun, 28 Feb 2021 23:44:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Rbqx5FiXTbeC9HPRNr4UL4ZjQF1x6sDxTB9aHMKwW40=;
        b=JHKZhQeKE5+f0UYNgRJAuTvk+8mrugQVk/qwCjuXD9wR6orqLio+zisIrzvLmM9Edi
         eYTZ2Eihk+yo5b9bN3v98PoiZH3V2ftzCTwcJQqrSEebOATAFb8QBAMpPTr/dXY8toPD
         PYRrrClwJITR7VyR37QNmZVHd+BpRutqSSQfgNfBrSLKql5QABxNBn7cKoA6/O0oDSwi
         3kyRRfZO632w7ade1zlnPaj7fJqRawMSQXgjgNAvhACB8tyqhapPs8lvX8W0OfXrLgrM
         pHKGrgbdmmexPodDNVf/Pd+/4gu6xy7ND7SjztzzH7RMcxmbNEfREeMymkPLbn2kzlVx
         5pug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Rbqx5FiXTbeC9HPRNr4UL4ZjQF1x6sDxTB9aHMKwW40=;
        b=Q6btgIeQwz2VWSec8mupv0A5KaG2L9mlutcSNyfjh4mmMlUfznWI0dWKYGGsWa6FI5
         Q1lK/r4UjXKkltQgYT3iO6xT/c4WQhmKgj1inGkJ3ND6yAPvDnmlfz9L5jaoINcK5udh
         gDGrCaN3lGxovLB6gf2gk/4QTM7CbvaIeU10vEkrbIrk1qLoQ85m1PG5oHpHOzDJG/hY
         ricN/PWZd4EbSdlNm0F/ZQmPyXA4yj6hKWZytDDWE2VgXMlC4vguDpwywIgCqCtbQ+Z7
         8dOoGnVhNHsK7VldDvoIFgjAW4d45jdr7yxb36PRKHT+XtkUiTICmvetXTIRHP5n2Oba
         Cdzw==
X-Gm-Message-State: AOAM532Hq4TMM5hdtsvOLvw6mL2j/2YGP47ADI+43sYy/HgYccLcnmrK
        XX5dRRXaZVETMRp1xbtLlrAjC4/1coL8poySgPQ=
X-Google-Smtp-Source: ABdhPJxPlH3iNnYnwxmic/5MX2qpjhfVbAKPucEQsdu3acXajvAJJPHA+ONIWGngSoV0a3tlW7+6wACTD9G6qmbyrkA=
X-Received: by 2002:a02:c6d0:: with SMTP id r16mr14843464jan.38.1614584668808;
 Sun, 28 Feb 2021 23:44:28 -0800 (PST)
MIME-Version: 1.0
References: <CAPkN8xK7JnhatkdurEb16bC0wb+=Khd=xJ51YQUXmf2H23YCGw@mail.gmail.com>
 <CABPp-BGDB6jj+Et44D6D22KXprB89dNpyS_AAu3E8vOCtVaW1A@mail.gmail.com>
 <CAPkN8xK9__74a3aEFsevfdW_hQ-vzWE+c=QypRacTktuZOfdSw@mail.gmail.com> <87mtvolbuj.fsf@evledraar.gmail.com>
In-Reply-To: <87mtvolbuj.fsf@evledraar.gmail.com>
From:   anatoly techtonik <techtonik@gmail.com>
Date:   Mon, 1 Mar 2021 10:44:12 +0300
Message-ID: <CAPkN8xLE68d5Ngpy+LOQ8SALNgfB-+q4F3mFK-QBD=+EOKZSVg@mail.gmail.com>
Subject: Re: Round-tripping fast-export/import changes commit hashes
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Feb 28, 2021 at 1:34 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> I think Elijah means that in the general case people are using fast
> export/import to export/import between different systems or in
> combination with a utility like git-filter-repo.
>
> In those cases users are also changing the content of the repository, so
> the hashes will change, invalidating signatures.
>
> But there's also cases where e.g. you don't modify the history, or only
> part of it, and could then preserve these headers. I think there's no
> inherent reason not to do so, just that nobody's cared enough to submit
> patches etc.

Is fast-export/import the only way to filter information in `git`? Maybe th=
ere
is a slow json-export/import tool that gives a complete representation of a=
ll
events in a repository? Or API that can be used to serialize and import tha=
t
stream?

If no, then I'd like to take a look at where header filtering and serializa=
tion
takes place. My C skills are at the "hello world" level, so I am not sure I=
 can
write a patch. But I can write the logic in Python and ask somebody to port
that.
--=20
anatoly t.

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7A21C2B9F4
	for <git@archiver.kernel.org>; Fri, 25 Jun 2021 17:34:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFE2A61949
	for <git@archiver.kernel.org>; Fri, 25 Jun 2021 17:34:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbhFYRg3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Jun 2021 13:36:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbhFYRg2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Jun 2021 13:36:28 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91F6EC061574
        for <git@vger.kernel.org>; Fri, 25 Jun 2021 10:34:06 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id q10so12113382oij.5
        for <git@vger.kernel.org>; Fri, 25 Jun 2021 10:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=wewNcIcKORMoKGsQy54xupXSwnSdYljwtCFynDMNIkk=;
        b=mij/YETxzpFPgdeKHODGdV+Jp3h5a0i+Sc1r/SVmzuJauR8IZY+l0bsncUFTNgEz2P
         IpmB0yOsbNeqLUfceaD46R7LV4e4Da7ZvT6kX/srnrnIdiwpobKSZzsSShBLjUaQbaAs
         qmsSKAsfUx96qK2P6W+j3GVT/ubkBM1Oc8sS9AQTlMqAo9aSjT6rwO+v2cF7nwGGyjGT
         0sv5HFMFtl55GByVMseVF2Zz8DWnmYFdi511JM0u9gCjiyQaD213M+lIQlrAVELzcy/B
         Z36dedTM7TxNggnuythBubrr3K68wrTZOGk0inHnVutd6L3KutpajmoaXEOknmk9+TC/
         X8bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=wewNcIcKORMoKGsQy54xupXSwnSdYljwtCFynDMNIkk=;
        b=R3S0PDbfwn8Ml172Aw01JKC2JZvMhPIkHO5oyNC9ze4FguExgWaYSfGkoTiP2fUlVd
         1cor748e1q4VFWrQhybkwrhMserGcNrRb+kb2DJ4rjhHIqVKTpZbYt0ZN0z8MeKSohFr
         KpvP3ln8ySFoCy2dqPliI/Ev/VuF1BDruh4p0TB38H6jc7Bsg0QRnDSwlObfO6ff6KnM
         pUXRc0ABNcjU1e7VNFN2uonAuQN6hqnTRL1wxU0S3Hug2HHOzLdEEIxVwYHOcztvxMgJ
         BVUsFOmZulrGMREnQxzunF2vQ4sicAs7MsUgfz6r9VGo3qk8lLhOauW9oRq3hjfSUA/h
         h4pg==
X-Gm-Message-State: AOAM533q6+Hlm9b15D3OtPMb2QDM/ERQ8N36Yo8Sy1l2O9pOnhJ/BT06
        ruzphRIgSrIsz19EqLV0bhM=
X-Google-Smtp-Source: ABdhPJz+heIZ8bcqGe6ds9dLEEUQMET8lQkOCOvZMmqW5+7mPX2g+9vBA+5LwQatQ2L0Ker9/cyIOg==
X-Received: by 2002:a54:460a:: with SMTP id p10mr12485253oip.47.1624642445910;
        Fri, 25 Jun 2021 10:34:05 -0700 (PDT)
Received: from localhost (fixed-187-189-165-231.totalplay.net. [187.189.165.231])
        by smtp.gmail.com with ESMTPSA id d18sm1414058otu.71.2021.06.25.10.34.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jun 2021 10:34:05 -0700 (PDT)
Date:   Fri, 25 Jun 2021 12:34:04 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     "Kerry, Richard" <richard.kerry@atos.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Philip Oakley <philipoakley@iee.email>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        =?UTF-8?B?VsOtdCBPbmRydWNo?= <vondruch@redhat.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>
Message-ID: <60d6138c185bf_cc8d20811@natae.notmuch>
In-Reply-To: <AS8PR02MB730230DADF38B6C572CE8DC39C069@AS8PR02MB7302.eurprd02.prod.outlook.com>
References: <20210621175234.1079004-1-felipe.contreras@gmail.com>
 <20210621175234.1079004-2-felipe.contreras@gmail.com>
 <b4e612ba-21c7-3bef-d113-0f070449cd87@iee.email>
 <60d49748b8538_2fb2082c@natae.notmuch>
 <c2170f74-b93b-599b-1fb4-45b013c7bff1@iee.email>
 <60d4d75e7622c_242620854@natae.notmuch>
 <93084036-804d-4c52-2836-42efd5deba1c@iee.email>
 <60d5183a9e34d_3a20208b@natae.notmuch>
 <87im22xpp4.fsf@evledraar.gmail.com>
 <60d5b430f2f13_ba7520890@natae.notmuch>
 <87czsaxksc.fsf@evledraar.gmail.com>
 <AS8PR02MB730230DADF38B6C572CE8DC39C069@AS8PR02MB7302.eurprd02.prod.outlook.com>
Subject: RE: [PATCH 1/2] doc: pull: explain what is a fast-forward
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kerry, Richard wrote:
> =

> > From: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> > Sent: 25 June 2021 11:59

> > Perhaps, it's not like I've got much in the way of a holistic world v=
iew with
> > which to replace it.
> > =

> > I do think "perfect" would do a few things it doesn't though, imagine=
 reading
> > about it for the first time and not making the connection to tapes. I=
s it an
> > optimization? Is there a slow-forward? What if upstream rewound there=

> > branch and I merge, is that a merge-backwards?
> > =

> > It's not immediately obvious how rebase/merge/fast-forward relate or
> > if/when (e.g. merge sometimes being a merge-ff) they're incompatible
> > concepts.
> =

> On the one hand, I think fast-forward is an entirely suitable term for =
git to use, based on what it does.  Instantaneously moving the branch hea=
d pointer forward to the new head
> On the other hand I think it is distinctly different from the use with =
transport controls for linear media (ie tape - video or audio).
> For all of them fast-forward moves the play/record point relative to th=
e media, maybe to the end (or to "now"), maybe not.  There may or may not=
 be a cueing play that happens while the tape is moving.
> For a modern stream (eg podcast) player, such as BBC Sounds (via its we=
b-site) there is no fast-forward control.  There is play/pause, +20 and -=
20 seconds, go to the start of the stream and (for live broadcasts) go to=
 now.  The latter is very close to Git's fast-forward, but is not labelle=
d as such.  There is also a time-line, where the user can go to an arbitr=
ary point in time and play from there.
> Hardware players do have fast-forward controls, even for streams, or fi=
les.

Yes, but regardless of that for whatever reason it's already part of the
culture, and people are using fast-forward irrespective of the original
meaning:

  "They fast-forward to present day ten years later, where he has been
  hospitalized and is on life support." [1]

  "So then fast-forward to now and, like, six months ago, they found the
  script and called me up." [2]

This is similar to what happened with the floppy disk icon. New
generations may have no idea what it originally meant, regardless of
that today it means "save". Except the fast-forward button still exists
in many remote controls.

Same with other concepts like carbon copy. I'm not sure if newer
generations have ever seen an actual physical carbon copy take place. Or
a physical bookmark.

Words evolve beyond their original meaning, and today I think that has
already happened with fast-forward.

> So, yes, the term is very widely known in the wider world (even for tho=
se who didn't grow up with tape).
> And yes, irrespective of the above, it makes complete sense for git's u=
sage.

Indeed.

[1] https://en.wikipedia.org/wiki/I_Need_a_Doctor
[2] https://en.wikipedia.org/wiki/Predators_(film)

-- =

Felipe Contreras=

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F6C2C352A1
	for <git@archiver.kernel.org>; Wed,  7 Dec 2022 11:08:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbiLGLIo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Dec 2022 06:08:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbiLGLID (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Dec 2022 06:08:03 -0500
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23C385288C
        for <git@vger.kernel.org>; Wed,  7 Dec 2022 03:05:54 -0800 (PST)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-144bd860fdbso7732208fac.0
        for <git@vger.kernel.org>; Wed, 07 Dec 2022 03:05:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5s0Sh05c2W4o488Yqv2zkyiBqTfr5bNo1KZWFPNRwYw=;
        b=UJ1YCgo/XlSLuqTAo7DU60AOO8R9a/GQbT+RX23YGB1tCzdzOV9SMo35D55qeYBCwF
         DW1axU1FjkHo6mdOCFZS1RTqC+4xFXYRNcEu24EmtQJvu60+CY/NaxpdNMZhD5TQxetb
         sm2tgkl92eWSPlt+anujvVYR7BheGIX2uI1GD3oH7aet0m9FqZmsnLu46Q9xo3t6PJYX
         iIfa0DecA7mxjvPrAALkLWNcYHlIBltvctYQFheB4lx3H9hxNT/20KSN6aT2F0cHiHDh
         Wk64b+bu8kdhurpfSEJ5sTBjGrb0dqG4Ja9v+gec/gUepFaBa7WuM/ARZwldIX5PYFsg
         fHPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5s0Sh05c2W4o488Yqv2zkyiBqTfr5bNo1KZWFPNRwYw=;
        b=7MKHQB8B2hkz5+OIKqAdRuwkJVE6xPC6xLuKQLgsTnlZux/J9JME8qtHF7Uyzs60Eq
         fkuJhHCb8g7OKTlO6JpJM4q60ahv5FVHue29qdTQqNa2eD3RuodFiSf4EzbeNDCJrBZO
         8gOP1xsu1857J/ib7XfDjp+WimF6vRRJCWIvSFNh5bsS2LWG+KXrG2BPE4h6utJRDsAp
         ThWP2VRsTj9VsEjASeoLRYNZX7cCe6dKj11r8Gij6DK7eNra4Y1gOv2V1jejqPnhvXPJ
         CLBwTj/3+NXAWAYWv+199jb+HYfHiq14mdkLKxsuREZPo7k2d4Ou4I1t878RVx5tyLkI
         mMcg==
X-Gm-Message-State: ANoB5pmg/50713jZ+WGUCsJWLxris15x1SbRyzFnE4eiK/4UcQR3QtoF
        0SCigeTLGa/Xx+DbPLANTUPqefl7YUCJ12hffv8=
X-Google-Smtp-Source: AA0mqf5F5X/OeN+XJMQeKIHKSLSqm/mK3ukx5xjrJNh4IGL7tjf/zLkZBpoU6Q3Ez1ViPfkXOj/NrwVYDUbAkMqzsKE=
X-Received: by 2002:a05:6870:f71a:b0:144:e55e:4248 with SMTP id
 ej26-20020a056870f71a00b00144e55e4248mr607758oab.270.1670411153343; Wed, 07
 Dec 2022 03:05:53 -0800 (PST)
MIME-Version: 1.0
References: <20221206103736.53909-1-karthik.188@gmail.com> <20221206103736.53909-3-karthik.188@gmail.com>
 <xmqqedtc842m.fsf@gitster.g> <CAPig+cT_xz3m-3kkL_Scf0opNXkikU94kSF46VO8KHkNMWbGzg@mail.gmail.com>
In-Reply-To: <CAPig+cT_xz3m-3kkL_Scf0opNXkikU94kSF46VO8KHkNMWbGzg@mail.gmail.com>
From:   Karthik Nayak <karthik.188@gmail.com>
Date:   Wed, 7 Dec 2022 12:05:27 +0100
Message-ID: <CAOLa=ZTSzUh2Ma_EMHHWcDunGyKMaUW9BaG=QdegtMqLd+69Wg@mail.gmail.com>
Subject: Re: [PATCH 2/2] attr: add flag `-r|--revisions` to work with revisions
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        toon@iotcl.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey Eric,

On Wed, Dec 7, 2022 at 2:10 AM Eric Sunshine <sunshine@sunshineco.com> wrote:
>
> On Tue, Dec 6, 2022 at 7:15 PM Junio C Hamano <gitster@pobox.com> wrote:
> > Karthik Nayak <karthik.188@gmail.com> writes:
> > > Add a new flag `--revision`/`-r` which will allow it work with
> > > revisions. This command will now, instead of checking the files/index,
> > > try and receive the blob for the given attribute file against the
> > > provided revision. The flag overrides checking against the index and
> > > filesystem and also works with bare repositories.
> >
> > As "check-attr" was not invented as a user-facing subcommand but was
> > a hack for debugging, I would have minded this change, but these
> > days people seem to treat it as if it is just one of the proper
> > plumbing commands, the new command line convention bothers me a
> > bit.  No other command uses --<anything> to signal that what comes
> > after it is a rev.
> >
> > But I do not think of a better alternative without making the
> > command line ambiguous, so I'll stop at raising a concern, so that
> > others who may be better at UI can come up with one.
>
> A few minor comments...
>
> We don't usually squat on short options, such as `-r`, right from the
> start but only add the short alias once shown that there is demand.
>
> Option `-r` has strong association with "recursive" elsewhere, so I'd
> worry about giving it such a completely different meaning here.
>
> Rather than calling the option `--revision`, perhaps pattern it after
> git-restore's `--source` option which allows specifying a particular
> commit, tree, tag, etc.?


I'm okay with removing the shortform `-r`. I decided to use `-r|--revision`
because it is also used in `git svn`.

I don't have strong feeling about the naming here, but I do feel that
`-r|--revision` sounds better than `--source`, because source doesn't directly
imply a revision and in the context of `git check-attr` is a bit ambiguous
because it could imply the source regarding which `gitattributes` file to
check against (although this feature doesn't exist).

-- 
- Karthik

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5842FC433EF
	for <git@archiver.kernel.org>; Thu, 16 Jun 2022 22:33:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379000AbiFPWds (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jun 2022 18:33:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379122AbiFPWdo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jun 2022 18:33:44 -0400
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A460629378
        for <git@vger.kernel.org>; Thu, 16 Jun 2022 15:33:43 -0700 (PDT)
Received: by mail-vs1-xe2e.google.com with SMTP id n4so2512293vsm.6
        for <git@vger.kernel.org>; Thu, 16 Jun 2022 15:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nNn4r+MSOqcUH/4GXuaxA47aLynPjS67TMlBZP22od8=;
        b=q2xeVeU41pmT0MjatubgMPT5uQ3DPW22/b8t12VPa2qb3Tb/Q1Z9z3mBiirhmcc0s+
         /4tMM9krxPUOSuoh3LepFcZfk7Nt9CvrggJ9V/EqwspiFjp9DgEYEVqUs4Ic/gvB1v8b
         cFO1nS9mp5UqfPUZxMHcH7oVLjDIGH0+AVEDD2CMmQqkJ59b1lEisDFlTKMltPx201w2
         SsqOW+gJQQmo97DZ6/UKJ4L3LgW+5nc6PyqMOSxIY6efOPV+yRjncYwf/krnDCxSLVNw
         H1REf/vHGHqrAq1nDyfs3g3Hz7pDilHRQKHPHtyMhJ0MFvyjUjg34Htn9SrkdYwP4wbV
         xwDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nNn4r+MSOqcUH/4GXuaxA47aLynPjS67TMlBZP22od8=;
        b=l/GlbtU4GvJQZw/Fnq96JuTNiEFEsMRCHhlQs3wq1Xo/41NOoLOffsORXEQcIBr+8e
         JedTP+rIgp3VCN9uXbmAhfA0SXzTzzN9hIXDOfyxxPHhIksIeodAlzruFjh6pFfK7iMX
         vBViCHfW3rBJTN3wWjxPXv0VKt9X9k8zUXs2mNbdjJughWM0JpuCS8/f2WaHeEzohbXY
         gr8Zvt2hVBlMJ6qJnkIePMNQXqkxKfpu1Qp8ly9WQ9FcOGAQZwQ12UNBsPKSyNIt93/L
         HEpBq9dlf63MOMPm4ZmxujalUBQKIpAcIzUSsncePEfgEH9Iz0OYoSYOzeKniQaSa5uo
         go1A==
X-Gm-Message-State: AJIora9nRQnm4ZJdmJCm30wHZW7/3ZTu8S8FoqRxu8mc3W7COeVz8THZ
        WO1bNO8TU9SIofkw/WqmQ3/c5tfhSRmnngDEhJOH3je/
X-Google-Smtp-Source: AGRyM1v3kDz10k0LLjgzMFQmuKivbeeW6YL2IcZZj09XkdCCIKWKP4Hkg5+aUWeRgGakTpLjTY2FtioKepFgD2/CPpo=
X-Received: by 2002:a05:6102:215c:b0:34c:1e12:afa with SMTP id
 h28-20020a056102215c00b0034c1e120afamr3296438vsg.29.1655418822662; Thu, 16
 Jun 2022 15:33:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220614003251.16765-1-jacob.e.keller@intel.com>
 <xmqqzgidy52c.fsf@gitster.g> <CA+P7+xpS0v9Oi3t4S76AcNRazdzJEEj6HxzO+z+dAFDPJ=yHJA@mail.gmail.com>
 <xmqqletwqnse.fsf@gitster.g> <CA+P7+xrx-Cec0mUJvDtWn0Fxu5vLdVkTbteWKiZyouH=64pWvA@mail.gmail.com>
In-Reply-To: <CA+P7+xrx-Cec0mUJvDtWn0Fxu5vLdVkTbteWKiZyouH=64pWvA@mail.gmail.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Thu, 16 Jun 2022 15:33:33 -0700
Message-ID: <CA+P7+xrxskcnoARjc5fL6zKys312B8XdQezrT7wHuN3wPaP-sQ@mail.gmail.com>
Subject: Re: [PATCH] remote: handle negative refspecs in git remote show
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Pavel Rappo <pavel.rappo@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 16, 2022 at 3:09 PM Jacob Keller <jacob.keller@gmail.com> wrote:
>
> On Thu, Jun 16, 2022 at 2:52 PM Junio C Hamano <gitster@pobox.com> wrote:
> >
> > Jacob Keller <jacob.keller@gmail.com> writes:
> >
> > >> This is somewhat curious.  Do we really need to destroy the
> > >> fetch_map like the above?  I know by removing skipped items from the
> > >> list, the existing loop (below) can stop having to worry about them,
> > >> but the caller of get_ref_states() may later want to iterate over
> > >> the full fetch_map for other reasons (even if the current one does
> > >> not, a future version of the caller may have a reason to do so that
> > >> we do not know right now yet).
> > >>
> > >
> > > Good point. I'll fix this. I think we can just move the
> > > omit_name_by_refspec into the other loop.
> > >
> > >> > +
> > >> >       for (ref = fetch_map; ref; ref = ref->next) {
> > >> >               if (!ref->peer_ref || !ref_exists(ref->peer_ref->name))
> > >> >                       string_list_append(&states->new_refs, abbrev_branch(ref->name));
> > >>
> > >> IOW, is adding a new condition to this existing loop insufficient?
> > >>
> > >
> > > The tricky part here is that we don't have a simple check, and we're
> > > currently iterating over all of the refspecs each time. But we have to
> > > do that regardless so I think this makes sense. Will fix.
> >
> > Another thing that worries me is that get_stale_heads() will not see
> > the filtered refs with your original implementation, because you cull
> > them from the fetch_map in the extra loop upfront.
> >
>
> I think the new implementation fixed this, but I'll see about adding a test!
>
> > I do not know offhand what its effect would be, but it probably is
> > worth testing.  In your original scenario, if we locally have
> > refs/remotes/jdk19/old and refs/remotes/jdk19/pr/1 (perhaps obtained
> > before we configured ^refs/pr/* negative refspec), we'd want to see
> > that pr/1 exists here but will not be updated.
> >
>
> Yea, I will see if I can check that.
>

Ok so this raises another issue: get_stale_heads currently never
treats a refname as stale if it matches a negative refspec. The
function first queries the name against all refspecs via
query_refspecs_mutiple. It only considers a ref stale if it matches at
least one refspec but no longer exists in the remote.

The problem is that query_refspecs_multple returns no matches if the
refname matches any negative refspec. Thus, all refs matching a
negative refspec will be ignored by get_stale_heads.

The query_refspecs_multiple is only used by get_stale_heads_cb, so we
could change its implementation possibly, but that would make it not
quite match the name. I'll try to think of a better solution.

Thanks,
Jake

> >   * remote jdk19
> >     Fetch URL: git@github.com:openjdk/jdk19.git
> >     Push  URL: git@github.com:openjdk/jdk19.git
> >     HEAD branch: master
> >     Remote branches:
> >       master tracked
> >       old    stale
> >       pr/1   stale
> >       pr/2   skipped
> >       pr/3   skipped
> >     Local ref configured for 'git push':
> >       master pushes to master (fast-forwardable)

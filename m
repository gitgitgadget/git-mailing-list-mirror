Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C526C433F5
	for <git@archiver.kernel.org>; Tue, 23 Nov 2021 18:56:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231624AbhKWS77 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Nov 2021 13:59:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbhKWS77 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Nov 2021 13:59:59 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA694C061574
        for <git@vger.kernel.org>; Tue, 23 Nov 2021 10:56:50 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id w2-20020a627b02000000b0049fa951281fso94218pfc.9
        for <git@vger.kernel.org>; Tue, 23 Nov 2021 10:56:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=IKFAcSV8sKYprLfxVOMBlzdYtPVvv273t1OgHPSF5lA=;
        b=NMlKCQJcWFGb9UArCKRj4wHSp39hSzohXnK8FlXJFx129aVHTtmO0vVeEGarncq0aA
         XaTV2RA3zhbDmMLktfzTDOReQn/lF7igCejn/J4dRgixWrxDEZ0bjpJBs73wcgXJSZ2u
         XU149CB2pmo01j0J1onl0tbYUB05fPCL4AbS93lBoD9nsRrOrRbpdyjxWgPuegIUaT63
         AGfQVDVjQx0BzRppA9qYsrYQ4x4Jy+VzlWoonRNhIsihsOGRPli//s+pHN7a+C4ODpdd
         PmEypnTLKhpMuU/UxGw8AMMralakJ+OBh9QGfo8IvKl8RNfZSXR02tWp6Igi3y6iMfAk
         hFMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=IKFAcSV8sKYprLfxVOMBlzdYtPVvv273t1OgHPSF5lA=;
        b=CsLJRWSg3vWkb6b+MqKDIMHEVveBHJsQCNiGnl6tnUEIU2xgJYLbQSdlq4Hl/9YE9L
         T/mefh2eRPSSNmUBsI4Xac7LANSJFvQ8jVvfBB/TAQzUN8yKwVotVjlc4rTKe39IeCN3
         tzXkUME/Q8MKbyvDvG5sP6Febp6dhWnS6UaC982/fV55V5RGeW96mJrxcxgwD82QDA8n
         M35ljkMgxTuGKGzMdAIWtGARtylNq2YqD2JIv6kdmKkREcOug1/B5/kZiT3v4+qTEmS7
         bczihFO6akODQGMQsv8Wt1SVrVwvy8OfSLnBN/KTx25WIn2OEzmWF75nmhAvQvt+0zai
         sr1g==
X-Gm-Message-State: AOAM533yHsGL7/WktOjRitGWbICDyFe4utx27lW/FD0jRxnIwT/ChWem
        D84HO2I3Lwra6Ox5p2dmOWejRh9xG4hIOQ==
X-Google-Smtp-Source: ABdhPJwV+ysSqPqh6/zAlTVwXZPUOehuyeveMX+14WOT+wU+MnI1pOWQSO3B9DhCqiZoPwuczrAe15LIhVWesg==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a63:f51:: with SMTP id
 17mr5378705pgp.281.1637693810396; Tue, 23 Nov 2021 10:56:50 -0800 (PST)
Date:   Tue, 23 Nov 2021 10:56:48 -0800
In-Reply-To: <211123.86v90juovj.gmgdl@evledraar.gmail.com>
Message-Id: <kl6lee76k8en.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <20211122223252.19922-1-chooglen@google.com> <20211122223252.19922-5-chooglen@google.com>
 <211123.86v90juovj.gmgdl@evledraar.gmail.com>
Subject: Re: [PATCH 4/4] branch: add --recurse-submodules option for branch creation
From:   Glen Choo <chooglen@google.com>
To:     "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Mon, Nov 22 2021, Glen Choo wrote:
>
>>  	submoduleAlternateErrorStrategyDie::
>>  		Advice shown when a submodule.alternateErrorStrategy option
>>  		configured to "die" causes a fatal error.
>> +	submodulesNotUpdated::
>> +		Advice shown when a user runs a submodule command that fails
>> +		because `git submodule update` was not run.
>>  	addIgnoredFile::
>>  		Advice shown if a user attempts to add an ignored file to
>>  		the index.
>
> Does it need to be submodule*s*NotUpdated? I.e. the existing error is
> submodule.. (non-plural), and we surely error on this per-submodule?

From the user's perspective, failing on a per-submodule basis looks like
an implementation detail. As a user, I am looking for advice on errors
that could be avoided by running "git submodule update"; I'd want the
advice option to describe what "git submodule update" does, which is
update submodule*s*.

>> [...]
>> +	for (i =3D 0; i < submodule_entry_list->entry_nr; i++) {
>> +		submodules[i] =3D *submodule_from_path(
>> +			r, &super_oid,
>> +			submodule_entry_list->name_entries[i].path);
>> +
>> +		if (repo_submodule_init(
>> +			    &subrepos[i], r,
>> +			    submodule_entry_list->name_entries[i].path,
>> +			    &super_oid)) {
>> +			die(_("submodule %s: unable to find submodule"),
>> +			    submodules[i].name);
>> +			if (advice_enabled(ADVICE_SUBMODULES_NOT_UPDATED))
>> +				advise(_("You may try initializing the submodules using 'git checko=
ut %s && git submodule update'"),
>> +				       start_name);
>> +		}
>
> Uh, a call to advise() after die()? :) That code isn't reachable.
>
> It would be good to add test for what the output is in the next
> iteration, which would be a forcing function for making sure this code
> works.

Whoops. Good catch. Yes I should test that.

> One thing I find quite annoying about submodules currently is the
> verbosity of the output when we do N operations. E.g. I've got a repo
> with 15-20 small submodules, cloning it prints out the usual "git clone"
> verbosity, which isn't so much when cloning one repo, but with 15-20 it
> fills up your screen.
>
> Operations like these should also behave more like "git fetch --all",
> surely? I.e. let's try to run the operation on all, but if some failed
> along the way let's have our exit code reflect that, and ideally print
> out an error summary, not N number of error() calls.

That's a valid criticism, and one we're concerned about as well. I'm
not 100% satisfied with how I've structured the output either, but as a
practical matter, figuring out an *ideal* output format and
standardizing it takes up too much valuable iteration time that could be
spent on improving the UX instead.

So the approach here is to have output that is 'good enough' for now,
and to create better and standardized output when we've nailed down more
of the UX.

> That would also justify the plural "submodulesNotUpdated", if such an
> advise() printed out a summary of the N that failed at the end.

Fair. We could treat an uninitialized submodule the same as any other
failure and summarize all failures.

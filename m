Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB425C433EF
	for <git@archiver.kernel.org>; Wed,  8 Dec 2021 00:35:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238515AbhLHAjQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Dec 2021 19:39:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbhLHAjP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Dec 2021 19:39:15 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF578C061574
        for <git@vger.kernel.org>; Tue,  7 Dec 2021 16:35:44 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id p8-20020a17090a748800b001a6cceee8afso582083pjk.4
        for <git@vger.kernel.org>; Tue, 07 Dec 2021 16:35:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=5rlFNThUeLqTMKQ9bdpnlPbgVbglVR/Jbz3SyMG5lYA=;
        b=QNTtifufmTxyZO1p05M5KPoygdP8mfc2ve/CY3mYaVhNM0hcRtyQc5EhJRmZWvtPMZ
         Co45TcbfCXlgv+y0/V+9ndh+xaSmID2AfdNDbcBJkVt2vCwNkhnTSGmvyeq6tn29wA1T
         nPZghSDCBBxOOOtU18pymHQ0SDwX/l/UpTyDRZhIMQmW9liJUn4+VqUWQ/Dwmqa6FHEi
         asH3MfKDmzI54hJD12bcjppLXmEKwanH75VlA29fFWH97MM8a8bzP5xvv6/bvXCl5EgR
         /f35LMJVZhOu1j96KcLRPfXJRUzABzKD0AWJdXPTQKm9pMzyNDMPLDftE5Tvz6FsfRB+
         l2uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=5rlFNThUeLqTMKQ9bdpnlPbgVbglVR/Jbz3SyMG5lYA=;
        b=lUlAcTKDPyklvkgVfXKEget2dDQPUxHNgnUtMsMrp1cYNBczg3IVeJg212/OyKkYNp
         OeYOkM7jwK5qVbiuCbMYPtc2sxnR+xoQ8frB9lYUA0+Ia9c00aTl5dqq1ZzwMGcQOEo1
         v58/uPiclZpm4GLKE2UXwQVspoEFGoedVQkNSw3D+YGL524P8uyfDO6fRrYAUxM4RmNm
         jftvsdyiZYD/DS4zvqIE0paJeXpkzljzcSXuBW7cTpDvz//ftKVB5+cFCab2fgw34cgL
         /VqSQlXjYzBaTHlLKC3vlGZvkRs85fEuJ0NenPQ+wOcib2LVUBwZHJAARc+M5jeuSTfU
         VHmA==
X-Gm-Message-State: AOAM532dx4EeTgv750l5+t4pvCacTAYt5DPQ2ZGsX+JkgKIDGQW3AW3i
        4lwYBglhL8J90nCCEGdv81XrIWahn60TEw==
X-Google-Smtp-Source: ABdhPJwrHxcKT2v2uhR4BOjM4B+m7KiHnzC69j09Hk37WjTh33qYjay5et6SpB2lkcwILxLyGOXgBDXGK9esQQ==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90a:284f:: with SMTP id
 p15mr318087pjf.1.1638923743862; Tue, 07 Dec 2021 16:35:43 -0800 (PST)
Date:   Tue, 07 Dec 2021 16:35:41 -0800
In-Reply-To: <211207.86ilw0pydg.gmgdl@evledraar.gmail.com>
Message-Id: <kl6lilw0aq76.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <9628d145881cb875f8e284967e10f587b9f686f9.1631126999.git.steadmon@google.com>
 <cover.1638859949.git.steadmon@google.com> <c7e4af9a365cc61e682c3c73045fb1ee4b79cfbf.1638859949.git.steadmon@google.com>
 <211207.86ilw0pydg.gmgdl@evledraar.gmail.com>
Subject: Re: [PATCH v5 2/2] branch: add flags and config to inherit tracking
From:   Glen Choo <chooglen@google.com>
To:     "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>,
        Josh Steadmon <steadmon@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, emilyshaffer@google.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

>> @@ -10,7 +10,8 @@ enum branch_track {
>>  	BRANCH_TRACK_REMOTE,
>>  	BRANCH_TRACK_ALWAYS,
>>  	BRANCH_TRACK_EXPLICIT,
>> -	BRANCH_TRACK_OVERRIDE
>> +	BRANCH_TRACK_OVERRIDE,
>> +	BRANCH_TRACK_INHERIT
>>  };
>
> So we've got 5 items in this enum...
>
>> =20
>>  extern enum branch_track git_branch_track;
>> diff --git a/builtin/branch.c b/builtin/branch.c
>> index b23b1d1752..ebde5023c3 100644
>> --- a/builtin/branch.c
>> +++ b/builtin/branch.c
>> @@ -632,8 +632,10 @@ int cmd_branch(int argc, const char **argv, const c=
har *prefix)
>>  		OPT__VERBOSE(&filter.verbose,
>>  			N_("show hash and subject, give twice for upstream branch")),
>>  		OPT__QUIET(&quiet, N_("suppress informational messages")),
>> -		OPT_SET_INT('t', "track",  &track, N_("set up tracking mode (see git-=
pull(1))"),
>> -			BRANCH_TRACK_EXPLICIT),
>> +		OPT_CALLBACK_F('t', "track",  &track, "direct|inherit",
>> +			N_("set branch tracking configuration"),
>> +			PARSE_OPT_OPTARG | PARSE_OPT_LITERAL_ARGHELP,
>> +			parse_opt_tracking_mode),
>>  		OPT_SET_INT_F(0, "set-upstream", &track, N_("do not use"),
>>  			BRANCH_TRACK_OVERRIDE, PARSE_OPT_HIDDEN),
>
> But map --track, --track=3Ddirect --track=3Dinherit to 3/5 of them. Will =
it
> ever make sense to do the oher 2/5 (I really haven't checked)....

Reasonable question, but I believe the answer is no, it doesn't make
sense to map all the values:

* BRANCH_TRACK_REMOTE is just a default value as far as I can tell (I
  don't think this does anything?)
* BRANCH_TRACK_ALWAYS behaves like BRANCH_TRACK_EXPLICIT but it's only
  meant to be set from config files, see 9ed36cfa35 (branch: optionally
  setup branch.*.merge from upstream local branches, 2008-02-19). We're
  more lenient with _ALWAYS than with _EXPLICIT; e.g. we don't die()
  when the upstream doesn't exist.

Even one of the other options doesn't really make that much sense...

* BRANCH_TRACK_OVERRIDE used to be used to implement --set-upstream, but
  that's not necessary any more. Now it's used to make create_branch()
  *not* create a branch sometimes, but that's going away if I get my
  refactor of create_branch()
  (https://lore.kernel.org/git/xmqq1r2pcnyw.fsf@gitster.g/T/#u) :)

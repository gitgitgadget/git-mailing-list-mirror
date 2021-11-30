Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1180AC433EF
	for <git@archiver.kernel.org>; Tue, 30 Nov 2021 21:34:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240598AbhK3Vh2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Nov 2021 16:37:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235087AbhK3Vh0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Nov 2021 16:37:26 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B12EC061574
        for <git@vger.kernel.org>; Tue, 30 Nov 2021 13:34:07 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id f125so8017403pgc.0
        for <git@vger.kernel.org>; Tue, 30 Nov 2021 13:34:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=r6ohBJVWoOaZMSftsMRFbfWccCcV3T8P/8nrof7bSJI=;
        b=RfvQArFTVODZaB6pmReHV5aUtd53hWxgGffZK8BepNRMQZNVfOPKXBKedNM3PCjK3W
         jj735su7NNyBN2fTDA8D9JGYBrl5Bsz8DpkCYSyCbEK0EIGFl/hyb/uPAy6ywT8gkl8S
         a1U/A55UvZPXmsgozsErkdPqUfH0cjyC0DJhM42ty7/zVPjscxfFR2xyZ6XLBHKWV5pU
         qQgDGrZR8qymEUvOltGXdgx/2A1z8sK1qoxUfCZnARPOQu1GGCSueaPc2lFo+wzcC4LA
         EDfhWEx+BSHUXslP+892M4xsLPQiMiXqV98aZkZP+pnaCQKSV+j/ufi2EHp0F+YdaQel
         SSrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=r6ohBJVWoOaZMSftsMRFbfWccCcV3T8P/8nrof7bSJI=;
        b=udRYe9prSa9FwCbDEvT2iF/KRm8Dtgdljq7Ixb5qgeYCvUcV7SrIvMXuGf+9cexa9M
         2r6w0AQ6Ug5jmHbGxzVcM/6SHsdESJ46N2q7JQAcKLJmZxMG74SL6TtlQKCEQarK4cWJ
         3qPY14qImZFlHiXkobRjAI23EVX+7JA6J0qpWn8t7ZBa2Rw645CEzkwX8k5XdP4N6t7v
         ZyuggQYWttzTfK/BJKm3/lK26CMWTJtzI7GLHmSAPpazlpZSCouKTFOESbr8LHJw8W6t
         gwOQcNNbpje/wGRLYeIvs4TC47mXUbCsZ4X+zirYNnO0k339w2IkvrvW2osz2ookN+Y5
         Uz9g==
X-Gm-Message-State: AOAM533s8GlHq1d6+WK2tm7qX+NS6ilthPgBLmJO4MN52kUy4xS5z24i
        IkECDxwJWlNSWJFgp6xhR3aYVQ==
X-Google-Smtp-Source: ABdhPJx2YLu3cgrWudam/6rFQkKB3XW+9dv4oO+FfIyr+bUU5OBT+/wnXx45avfIwnTbktpiaZggpA==
X-Received: by 2002:a63:8449:: with SMTP id k70mr1337156pgd.27.1638308046629;
        Tue, 30 Nov 2021 13:34:06 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:5174:44bd:79e9:4429])
        by smtp.gmail.com with ESMTPSA id g10sm23964562pfc.180.2021.11.30.13.34.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 13:34:05 -0800 (PST)
Date:   Tue, 30 Nov 2021 13:34:00 -0800
From:   Josh Steadmon <steadmon@google.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, chooglen@google.com
Subject: Re: [PATCH v4] branch: add flags and config to inherit tracking
Message-ID: <YaaYyFhDrvEbenWa@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, gitster@pobox.com, chooglen@google.com
References: <9628d145881cb875f8e284967e10f587b9f686f9.1631126999.git.steadmon@google.com>
 <7ad7507f183332cb2b5fdf2eb76fbbc9dd7199ef.1637085915.git.steadmon@google.com>
 <211119.86v90o4oqw.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <211119.86v90o4oqw.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2021.11.19 07:47, Ævar Arnfjörð Bjarmason wrote:
> 
> On Tue, Nov 16 2021, Josh Steadmon wrote:
> 
> > I've addressed Glen's feedback from V3. However, this brings up a new
> > issue that was not obvious before: "branch.<name>.merge" can be
> > specified more than once. On the other hand, the existing tracking setup
> > code supports only a single merge entry. For now I'm defaulting to use
> > the first merge entry listed in the branch struct, but I'm curious what
> > people think the best solution would be. This may be another point in
> > favor of Ævar's suggestion to reuse the copy-branch-config machinery.
> 
> I haven't looked in any detail now at the "should we copy the config?"
> questions. Just some quick comments/nits below:

Thanks for the comments. They're all fixed in V5, which I'll be sending
out soon.

[snip]

> > @@ -632,8 +632,10 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
> >  		OPT__VERBOSE(&filter.verbose,
> >  			N_("show hash and subject, give twice for upstream branch")),
> >  		OPT__QUIET(&quiet, N_("suppress informational messages")),
> > -		OPT_SET_INT('t', "track",  &track, N_("set up tracking mode (see git-pull(1))"),
> > -			BRANCH_TRACK_EXPLICIT),
> > +		OPT_CALLBACK_F('t', "track",  &track, "direct|inherit",
> > +			N_("set up tracking mode (see git-pull(1))"),
> 
> Hrm, should we say "git help pull" here, on just not reference it at all
> and have a linkgit:git-pull[1]?
> 
> Or maybe git-branch.txt and git-pull.txt should be including a template?
> As we do with Documentation/rev-list-options.txt, then this
> cross-reference wouldn't be needed.

Yeah, there's nothing really helpful in git-pull(1) about "--track"
that's easily searchable (i.e. without reading it all straight through),
so I just removed the pointer in the option help string, add added
linkgit:git-pull(1) and linkgit:git-config(1) to git-branch.txt.

I briefly looked at writing a common template for both git-branch.txt
and git-pull.txt but I feel like the git-pull discussion of tracking is
so spread out in that doc that it would require a significant rewrite to
make a common template work.

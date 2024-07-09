Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224AC1586F2
	for <git@vger.kernel.org>; Tue,  9 Jul 2024 14:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720536301; cv=none; b=OgMVFQ51LBO4lIeVMHVfKm3lYp5b4ye1cDZTnjXlFhzF7n6tG4fst27v9twz15bNPfQ+6qRsi9AT/eXdDjvtLOLl6m3oQLPYadRvkATSVWKb7xXDDTxsK6Xv/YsJCT8lLw9sCEgQpgv4pcAQ74BlUAvQgudPOWsnWx8dMybNK7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720536301; c=relaxed/simple;
	bh=V1pFqqhtUpahblBKknhceRamraEBLao3Xc0SMCGxmhA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OLJ3Q5n9IakVqyQmpJxL+YE//k0+f4AVz2C25HACKPBj71/ELQEVSNLBcZRSBy8T/MdVmBaah9xJFi2nuh3KSzueYJRrUEPNDfmILUbFtDiI/1uHg0yF1jE7meOSN0ct1tkgLDtZA5B4sl86sV3nOh89xmnsP0NoyMN22Ez/I6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EtFvJ7x7; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EtFvJ7x7"
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3d938024c67so702671b6e.2
        for <git@vger.kernel.org>; Tue, 09 Jul 2024 07:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720536299; x=1721141099; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RAqPCZ9oLL4mPM/zskSyL98bKSPDFqmguz3nkbpFfIc=;
        b=EtFvJ7x7sxEOei7D4JxPoZ7cmiJAzpKMr4ukzBuxFDzftGakmknrE8Ij40a6GOcRD+
         JFBBvC8Isiqpy+m2cBsU26joZiHG9etbC6UBI3FyNEvcCPQBFBkdHjs94Kg6XWOdq2vT
         iu/YBKEjYkCbWThLSJiFK1EcbA3Ps3iKEUc+KpJGRsNYP542IpHzHCnOSn7ACyCi9LOD
         JC/5y6eNb+4u04q/9eT3ilyvUzHqnMq96We2Wf7YBWzVKlKFOQGtddJfMiSt26/U8t3C
         j2/KZqUp8BsD+4YGCkEqlbBZj4ARVov6ESuH9OyGEGXu8xfdglCBFYha/X/dE2u6njiP
         TxtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720536299; x=1721141099;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RAqPCZ9oLL4mPM/zskSyL98bKSPDFqmguz3nkbpFfIc=;
        b=nH899LvnRTmlxGgSVzRqI0k0C1INPYIIUi4Z7EyRnu4y45GsOw/IpADnOYmzP5ycez
         g4JD8E4Gq83H+FllqWHK9W8zYOsWJ7AlnlHnP/QT1TCJIyq/EXLBHyc2V3LEsb9h6VGb
         zAGfbCJdPcaBwtBWtI+1PP3lhYpLDB+5kJHpxCFPDx39702I8oIL0x7QBTGZZ1p4tb3X
         DndSgUHt3g5ffFspFzZgOcQmVfvhDEMH1qOXduxK0XFSs09GAbcFPhieuQ8VO31ONIZk
         4wGFobGM4sgaYtivd6T1zW3F/Z4Wec2evfZyHsTcRG7rvb4cmtDJEk4BYEZo6z44kk4i
         SEqA==
X-Gm-Message-State: AOJu0YzAzYOnXLqtzP95Nsz14mI5Iu/Qwtrz7bkQ9xpuBfFlgatGysaC
	qek5AWa63J3qoY6pGHsImdnsuuj1lgWi4SjWZhlicRqsOGB36w6f
X-Google-Smtp-Source: AGHT+IGKuIchYWoaM6/R9a/9H3wJgyhdO/aGyrN5t8g7TQC+NaaQYkqcZfufIS7kPbdoBM807ak4LA==
X-Received: by 2002:a05:6808:14c5:b0:3d6:32be:a8a5 with SMTP id 5614622812f47-3d93bee56ddmr3182765b6e.4.1720536298866;
        Tue, 09 Jul 2024 07:44:58 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3d93acff107sm435644b6e.7.2024.07.09.07.44.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 07:44:58 -0700 (PDT)
Date: Tue, 9 Jul 2024 09:44:28 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, chriscool@tuxfamily.org
Subject: Re: [PATCH 7/8] ci: run style check on GitHub and GitLab
Message-ID: <q4mixa3suepyjrp5lkd3wio2pcsdbjch757n2p55fzxpk3sc4u@lysauvdyiq4c>
References: <20240708092317.267915-1-karthik.188@gmail.com>
 <20240708092317.267915-8-karthik.188@gmail.com>
 <7wc2ucdbirqgtrxgij3i4eqwfib334kdogbfxtiyifje6clsat@3p3xnqkoj3ic>
 <CAOLa=ZTuBziBPY1B0P3gTWMhqThuyFsFW1aWtwUconYN4gH+aA@mail.gmail.com>
 <lu7o24bwwh5ntarnpfjkmceuvzxs6rdykcrojonqkhfcvq7vka@7h3rev4n7wxr>
 <CAOLa=ZQiHcCU9G6BFO98Y1VAPYgTDdJzbWC5bnMQwx9jsTJ0tg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZQiHcCU9G6BFO98Y1VAPYgTDdJzbWC5bnMQwx9jsTJ0tg@mail.gmail.com>

On 24/07/09 01:44AM, Karthik Nayak wrote:
> Justin Tobler <jltobler@gmail.com> writes:
> 
> > On 24/07/08 02:16PM, Karthik Nayak wrote:
> >> Justin Tobler <jltobler@gmail.com> writes:
> >>
> >> > On 24/07/08 11:23AM, Karthik Nayak wrote:
> >> >> We don't run style checks on our CI, even though we have a
> >> >> '.clang-format' setup in the repository. Let's add one, the job will
> >> >> validate only against the new commits added and will only run on merge
> >> >> requests. Since we're introducing it for the first time, let's allow
> >> >> this job to fail, so we can validate if this is useful and eventually
> >> >> enforce it.
> >> >
> >> > [snip]
> >> >
> >> >> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> >> >> index 37b991e080..65fd261e5e 100644
> >> >> --- a/.gitlab-ci.yml
> >> >> +++ b/.gitlab-ci.yml
> >> >> @@ -123,6 +123,18 @@ check-whitespace:
> >> >>    rules:
> >> >>      - if: $CI_PIPELINE_SOURCE == 'merge_request_event'
> >> >>
> >> >> +check-style:
> >> >> +  image: ubuntu:latest
> >> >> +  allow_failure: true
> >> >> +  variables:
> >> >> +    CC: clang
> >> >> +  before_script:
> >> >> +    - ./ci/install-dependencies.sh
> >> >> +  script:
> >> >> +    - ./ci/run-style-check.sh "$CI_MERGE_REQUEST_DIFF_BASE_SHA"
> >> >
> >> > One downside to using $CI_MERGE_REQUEST_DIFF_BASE_SHA is that for GitLab
> >> > merge pipeines, commits from the merge that are not part of the MR
> >> > changes are also included. This could lead to somewhat confusing
> >> > failures.
> >> >
> >>
> >> I'm not sure I follow.
> >>
> >> > Example failure occuring on this patch series:
> >> > https://gitlab.com/gitlab-org/git/-/jobs/7284442220
> >> >
> >>
> >> If you notice this job, it points to the commit: 1c6551488, and the
> >> parent commit of that commit is: 614dff2011.
> >>
> >> The parent commit [1] is a test commit I added to check the failures. So
> >> isn't this working as expected?
> >
> > Ah ok, I misunderstood the setup of that CI job, but the problem is
> > still present. Here is an example CI job I've run demonstrating it:
> >
> > CI - https://gitlab.com/gitlab-org/git/-/jobs/7291829941
> > MR - https://gitlab.com/gitlab-org/git/-/merge_requests/174
> >
> > For the MR that spawned this CI job, This patch series is the source
> > branch and the target branch is a version of master one commit ahead
> > containing a clang format error. Because this is a merge pipeline, using
> > $CI_MERGE_REQUEST_DIFF_BASE_SHA will include changes from either side of
> > the base commit. This means it would be possible for the CI job to fail
> > due to commits ahead in the target branch, but not in the source branch.
> > For the check-whitespace CI job, I specifically chose
> > $CI_MERGE_REQUEST_TARGET_BRANCH_SHA for this reason.j
> >
> 
> You're right indeed. I did some more reading about this and I think the
> solution lies somewhere in between..
> 
> >>
> >> > It might be best to use $CI_MERGE_REQUEST_TARGET_BRANCH_SHA instead.
> >> >
> >>
> >> I actually started with $CI_MERGE_REQUEST_TARGET_BRANCH_SHA, it didn't
> >> work, because the value was undefined.
> >>
> >> See: https://gitlab.com/gitlab-org/git/-/jobs/7283724903
> >>
> >> This is why I also decided to fix and change the whitespace check.
> >
> > I'm not seeing $CI_MERGE_REQUEST_TARGET_BRANCH_SHA as undefined in the
> > job. Here is a modified version on the check-style CI job printing the
> > environment variables:
> >
> 
> You can see the output
> 
>     $ ./ci/run-style-check.sh "$CI_MERGE_REQUEST_TARGET_BRANCH_SHA"
>     fatal: ambiguous argument '': unknown revision or path not in the
> working tree.
>     Use '--' to separate paths from revisions, like this:
>     'git <command> [<revision>...] -- [<file>...]'
> 
> This only happens if "$CI_MERGE_REQUEST_TARGET_BRANCH_SHA" is empty.

Ya I noticed this failure, but was wondering if it was maybe due to
something else. I have been unable to reproduce it and in all the jobs I
was running resulted in a merge pipeline with the variable defined. But 
maybe sometimes a regular pipeline gets run for some reason and 
consequently $CI_MERGE_REQUEST_TARGET_BRANCH_SHA is not defined? Was the
pipeline triggered directly from the source branch?

> 
> > https://gitlab.com/gitlab-org/git/-/jobs/7291792329#L2470
> >
> > Do you have an example of the check-whitespace job failing in GitLab CI?
> > Maybe I'm missing something, but I don't see a problem.
> >
> > -Justin
> 
> So I think I get the issue, GitLab has two kinds of pipelines it runs:
> 1. merge pipeline: Here the pipeline runs on the source branch (the
> feature branch which has to be merged).
> 2. merged pipeline: Here the pipeline creates a merge commit using the
> source and target branch and then runs the pipeline on the merged
> commit.
> 

Correct, this is my understanding.

> And "$CI_MERGE_REQUEST_TARGET_BRANCH_SHA" is only defined in the 'merged
> pipeline'. If you see the pipelines for my branch on GitLab [1]. You'll
> see only one of them is marked as 'merge results' and the others being
> marked as 'merged results'. The former includes the job I mentioned
> above, where "$CI_MERGE_REQUEST_TARGET_BRANCH_SHA" is not defined.
> 
> I'm still not sure why it marked only one of the pipelines as such, but
> this means there is chance that it could happen.

Huh, I'm guessing the CI job must have been triggered from the source
branch directly. Did you manually run the CI job? I wonder if that could
have caused it.

> 
> So I guess the best outcome is to use
> "$CI_MERGE_REQUEST_TARGET_BRANCH_SHA", but fallback to
> "$CI_MERGE_REQUEST_DIFF_BASE_SHA", if the former is not defined.

This is exactly what I think we should do too. For merge pipelines we 
will want to use $CI_MERGE_REQUEST_TARGET_BRANCH_SHA so that only the 
commits included in the MR are scanned in CI. If that variable is not 
defined, it makes sense to fallback to $CI_MERGE_REQUEST_DIFF_BASE_SHA.
Since it's not a merge pipeline it will only scan commits included from
the MR and therefore work as expected.

This should handle both cases correctly. :)

-Justin


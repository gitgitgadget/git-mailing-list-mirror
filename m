Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F3E749C4CD
	for <git@vger.kernel.org>; Tue,  6 Oct 2026 18:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791309979; cv=none; b=hw0gm+D9irpWe/w4DayH//nJmoaQHPHhbSbljAL82YTOudVhbfOr1HupQzV4Q5vAobtwfdURdzu2eADpdl4vgsV7zcgssRp8CSNAi8EF5Eo1MIsxkeyN/Z0ntQu/H+gVXVduPw53c8zjYLFLVcyjD+0j/JrjsD3U8PWJKVBn3vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791309979; c=relaxed/simple;
	bh=h9AFc4wohJHW9PIDDWYgZBriYrdOBFqIo5mrxpYdr8A=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jLgrM0NKuOgzGwsvhUHPT5JKku+wHPyOtmSVsK4KwLaVj0qumoPkcZ0WinIPaSdGN0IReerskaFcXsGsEzdMnjS2ApfPo2JTEl9dMZw7AlFpXQ7wXjOZ+O/2TAUIFQsdfBm/nFDNCVuaNeX6p2oOZPVH1RqbtvmkcUcVkZvv2Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=RAqxWE2D; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="RAqxWE2D"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-53391786e55so12785181cf.2
        for <git@vger.kernel.org>; Tue, 06 Oct 2026 11:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1791309977; x=1791914777; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:to:from:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=l7M8u4Uj6xNJ43hRCyoQHJEv9FmnTpFoLIGQnXqwajI=;
        b=RAqxWE2DUYdQ1IpbMa4+GpA0H1Gjhv2XDs7e+PSpM2T5O6OEGfdkK2pJnApH925ntQ
         DnrKONr0Lh07Na8j09xPRPmDTe0DyqSbzkdBnIo4Q13KRDqUflFM8xN0DWxQEaMxzank
         XDWg+rj/8QprJr3ZQa8Ub/jfPt/k9rtmz9Tv8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791309977; x=1791914777;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=l7M8u4Uj6xNJ43hRCyoQHJEv9FmnTpFoLIGQnXqwajI=;
        b=tMx2XyE7qYLNPjHVR2lnHSNSRcpVKRXbXhuPImQqmmXuGyIUBMggBC/eLOkPetnovq
         yv8fM00h2A0PdOD6qqvg2kCAuTrEYcQ/FfzlncN9Sj5jIPAAwmsf7BYLDFQBuqWmADen
         rD/hAtWbQ6f+VGPdMeOWo/j47pVYROfDRJQaYBm0PmrmccFHKNw9brRP7NnA/jI0U0qN
         G+TknleRLO0f2umTHxbFdG93HX8SpeCgxg9twk4g53UAH3Rq+zJZwtzGP1kzeuwmqHcl
         tUG4W1t3zN3SqCZRntT9VvRNevDaFEjVQPcS7qmH3GGEh9AEC5AJwyqMSJVGOg7qxLlP
         6eZg==
X-Gm-Message-State: AFuF++kGa/TyrkemcDkLbKVtfiyeO7gYYEEejgynWDtDgcwkl4vpn+wu
	Iz3PqjQfL/bbu4bhIeD5AdoBkjTjN2GL6naobWnq8fM9k79EKWcKxbsxV+wURuyPj30ZwGh7Xn7
	ks/1EHk0=
X-Gm-Gg: AYBFou2xn4kDBFPFPzdFw1fX8RbHbQA94Pf4KPBsFSmN2dhiRsCRLEL5VBy+8q1Yf9q
	rk9DTRDmyjjZBM15YV8CvIbH9JOEKtwdDfpJ5VMKq1+3t4pg0bvzgZDskSRsU/lfeB/wSLk/AXY
	eMcICuJoWXQ1sitX84DpI6TNjyoSndCRFqoHTsOXS2IDZs5X5L9kealWEiiY6IiAp17/biMlsBE
	8hqqtcVsaJ2J7uR8onyuKmUDCD0PeBELONb2Brceoozl0eg1506QTGxb108o3SCumMP0LVuR8DB
	wsHSA6xxR3nBVulFoKrnrQxKvZtHA84hZfFtuWL/090HEkjYNcasaR/b3Oxh9BLW/tb8hr8Au/G
	5pjUU+7SJZEVBYmnhrF4DVKAZrlZV+0MZiDcdHkEo057lU9l3dc+5PiieWq8Rx+hPoKUDQTKcbj
	eTfsxFOoCQ4XJEDOEiurCH+40BxsN2770v12o2APRxf7McR2aXzS//ehF4PtyBhw1S31nKL7xHD
	DbGPTgYI8J40iUYeglgDy3Qd+2Te3e+lYb1TGONM8r7OV3zOHeHXGbF+FVZLTHMvuJGWt7uNGKZ
	Rzwz50qqlUI=
X-Received: by 2002:ac8:5e4c:0:b0:535:1b68:75df with SMTP id d75a77b69052e-53567222901mr40136181cf.61.1791309976424;
        Tue, 06 Oct 2026 11:06:16 -0700 (PDT)
Received: from com-79390 (vpn-eastus-01.tradc-corp.com. [172.190.114.39])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-535721e3da9sm1370391cf.29.2026.10.06.11.06.15
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 11:06:15 -0700 (PDT)
Date: Tue, 6 Oct 2026 11:06:12 -0700
From: Taylor Blau <ttaylorr@openai.com>
To: git@vger.kernel.org
Subject: [NOTES 01/07] Security mailing list and security process
Message-ID: <summit-2026.94e33e9ddf234334.01@ttaylorr.com>
References: <summit-2026.94e33e9ddf234334.00@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <summit-2026.94e33e9ddf234334.00@ttaylorr.com>

Topic: Security mailing list and security process
Leader: Toon Claes
Notetaker: Peff

* Toon: We have a high influx of reports on the security list from
  outside the community, probably from people using AI. There are many
  unaddressed reports. We need a better process for addressing them, and
  to figure out who will do the work.

* Emily: How are we cutting security releases now? Are we waiting for
  the reports to stop before cutting a release?

* Taylor: There are many reports we still need to triage and determine
  which are important.

* Toon: I have been organizing the reports, and some patches have been
  sitting around for months.

* Patrick: Eventually we have to cut a release, because the influx will
  not stop.

* Peff: We should act on what we have triaged once we have enough for a
  release.

* Patrick: We get many duplicate reports from AI findings. We should be
  more willing to cut releases, with a well-defined timeline. We should
  document the process, perhaps in terms of a number of weeks after a
  report.

* Peff: I am hesitant to promise a response to reports within a fixed
  number of weeks.

* Patrick: We should try to rely on companies investing in fixes,
  without forcing volunteers to work on them.

* brian: We should document our security model. Many reports are not
  vulnerabilities, but explaining why takes work.

* Patrick: Documenting the model might also help AI tools respect it.

* Emily: Are we interested in following the Linux kernel's approach of
  not embargoing AI-found vulnerabilities?

* Patrick: I am worried about that because of vulnerabilities affecting
  forges.

* Taylor: It depends on the models; some are better than others.

* Patrick: We should fix non-security issues on the public mailing list,
  and be more proactive about moving reports there when nobody else
  replies.

* brian: Sometimes there is pushback about whether something is a
  vulnerability.

* Patrick: There should probably be a period after which it is assumed
  that a report can go public.

* Patrick: GitLab has put some resources into this, but I would like to
  see more from other companies.

* Emily: It has been difficult to get resources from companies. The
  response is often that AI could help with triage, but putting
  non-public knowledge into public AI systems feels risky.

* Taylor: We could consider using AI to help with triage and writing
  patches. It might be easier to get companies to sponsor the work if it
  is less arduous.

* brian: There are DCO questions, which I would like to leave for the AI
  discussion. At GitHub, Elijah is our only person in git-contrib. There
  is more work than we have staff for, and corporate email requirements
  make list work difficult.

* Peff: We can coordinate in the cabal repository.

* Patrick: Could we put money into a fund to pay somebody to work on
  security, perhaps using AI, and get ahead of the findings?

* Martin: The project has a bucket of money.

* Taylor: I do not have the exact figure, but probably around $100k.
  Would we hire a third party, or somebody from one of the companies?

* Patrick: We probably need somebody from the project.

* Emily: Why is there resistance to hiring a third party?

* Peff: I am skeptical because the onboarding cost and time might be
  substantial.

* Emily: There are contracting firms suited to open source. We have been
  happy with Collabora, and I am happy to explore similar options,
  though it costs a bit more.

* Adrian: Such projects are hard to pitch internally. We do address
  security issues in other projects, but at a normal rate of $200/hour,
  a $100k project is difficult to pitch.

* Peff: Toon has already made a list, and we have fixes. Can we make a
  release with what we have? The list may not be as long as we think.

* Patrick: Can we write down the process, and perhaps automate it?

* Taylor: It is not primarily a scripting issue. We need to assemble the
  required tags and have the confidence to say we have enough to cut a
  release. We should discuss it on the list. The list of reports is long
  enough that we may never get through all of it.

* Patrick: We should get more comfortable with faster releases.

* brian: Anyone should be able to propose a new release.

* Patrick: We can try to accommodate different release schedules, but
  eventually we should put our foot down.

* Taylor: Microsoft needs around seven weeks for a release.

* brian: Microsoft needs to provide staffing if it wants a particular
  schedule.

* Taylor: Does anybody object to telling Microsoft that we will not
  follow its schedule?

* [No objections recorded.]

* Patrick: Agreed. Who wants to tell them?

* Taylor: I do not want to make an ultimatum about adding resources.
  They might add a third party that does not work well with us and still
  stick with Patch Tuesday.

* Peff: I had hoped to goad Toon into handling a release.

* Toon: OK, but I mostly do not know how.

* Patrick: That is a general problem: the process is not documented, and
  we need to figure it out.

* Peff: I will see if I can dig up the resources I remember. Is it OK to
  discuss the process on the public list?

* [General agreement that discussion on the public list is OK.]

* Peff: I will write an email to the public list to start the process
  discussion.

* Taylor: Johannes, Junio, and I should contribute our experience.

* Patrick: Would scripting make it easier?

* Taylor: No, it is the work of merging fixes up through the versions.

* Junio: Fixes do not always apply to both old and new code.

* Peff: There is also the work of writing security advisories and
  obtaining CVEs.

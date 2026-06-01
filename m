Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE1A37B40A
	for <git@vger.kernel.org>; Mon,  1 Jun 2026 13:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780322108; cv=none; b=mwIdTJsGSEYhiNNUOGTpGedpvCnvTefq/N+vNsnzcBobSG9VhSlSmCfcxQtBIfqLVVPR0aw3TqpKVumZOyKLqsVGnQU6hsKUeAQsIMhezWs9uSfku3grOw9traZBkx0pdp5eJnwp/4u7JBmDOy2SxNZibz1ARonkZBDKb2NGO6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780322108; c=relaxed/simple;
	bh=YHIATr2yD19PLo72vOM+ydMmV1ECYKWDhekU4a/mfKs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sDhLCqUXyo4j607HBdW6JZx5YLIkrkBe4/yVMgpufxBHoCAgs1kLNmQ2gil0UZdoR57G2K7KW6I0KLxZdG9H0nzXEE9HUS40ZkRVrFS/PD/7X+2YX0OkuftTTbucR/A+UpkKgVXUkhAzE6VuG9q8kvgPezRN9DhBRfU1BpptjZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=JPUNvU9s; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MFhQ04Am; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="JPUNvU9s";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MFhQ04Am"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id 911F9EC00CA;
	Mon,  1 Jun 2026 09:55:05 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Mon, 01 Jun 2026 09:55:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1780322105; x=1780408505; bh=p6WyJ47mwp
	8L0sIZ0yvYehYxv7VjEMXHdxyIJxDkwqk=; b=JPUNvU9s/JCXtmdW4FqyIQK8Uc
	z9D1Hq9xmyAaK1G283O2BTe1bLC9Fppu/rYgVSRpVoxFMGxVksqIB1JVtMVR+NbG
	RRSGC5kdQYPqAhDbS1zLQ92ne+xufZW3i8z3wEhTPHRhfLnfYJTXO7r9Dea+zFYv
	wMf710JcQ2eI8qcjNTYWzo+pDvO4Ff7cpEpmcnCP7mEswqcmiL2CbDQhrJpYSp0k
	ia6q5IwqAupCn/DMhDjJ96pMPPT/n+NqUFXXc4ImQWr7DobMgxJGfQFhQ4iwiAnP
	QwI8rT0jo2y8+WiNZL8Ve9e5kDjl+d4HcHqmYYEbToFWrTqKgtNRUS9yciiQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1780322105; x=1780408505; bh=p6WyJ47mwp8L0sIZ0yvYehYxv7VjEMXHdxy
	IJxDkwqk=; b=MFhQ04Amzh5jbDt3viOZ1q3V8ESyWXNDpW8OqDlfuzpJozfWsDl
	jjTF5Y2DFGeEeiA46JXXhIIaPa3KcD1Te3jhS6e6eT5TwBrCq822H2zMlB6Q7PDu
	KyJ92obJY5H9yYk6JvBfTddupr901KtTqpAKXaxlAy8mzMUwOXdxZmKY38F6mSIX
	45myfESoFOllRJN1d+h0LhPbLwBEFOhl2BRBn1jCSNs08OpBSibN3wVQUnBR9MW/
	CfDwk84shSbey+UHH1hm9YN/i1Bf14PSMHtZTwLKQPeu0OIqIs4tRhzbh4LkcF3Z
	troU+JHsk7ntOWFtTK6Y+JVjLFooET07MZQ==
X-ME-Sender: <xms:OY8daqd0TpgzPhD0tONhrV_d8FkeTgpacg7ABRRFRb9mJ4vDchqj9Q>
    <xme:OY8darN1WBXa_wVJDcmPbKyPKXQABNcTpRT5Ep4N63nN9OxFpKPbmcXDYeh9qET5W
    VNEGpL4Pe82GXZNat78i9C-WvhIBN_Fgip58lsCzkSed81zUlIHrg>
X-ME-Received: <xmr:OY8dagj9VrmL-4-XchVt_MJHGT1aQh6gLQ0m2xlPZd_JeSWWXjFA-HjNtjaUnQ2uoyr1EAFSXUreFaUCrbmuU-8heatEA5hWM1KPapigzW9G>
X-ME-Proxy-Cause: dmFkZTFxShnUas0qojzGMMQMx9looi+zsrN/taUUmMYaL+F9Qz4zyySuGdn2LoUDZBRw8A
    tj2YBDSVfPJ4XMJ3222YaoqGbiGTiq1NT3iTBVVdGA02FsgecBa/dNwCKzSxRIDzr48Alu
    QdUSkU89BVdVOWpnaPSqXbNem265zl41YhACcw8smqwWTdP5/9oPTz7CzYtGImi2idwZrM
    qB1N0lu3OflAoPtJcws0C2jCchFuPTjLIppVNTFdMy7H7vvAOc3yn5IJxntyfWnKvLlRWo
    CEpPo7Dw6rvtczTm6s36FKLIGZcWT1HIprMU5W948iV+OvPHafASg2t//3FiImSpnyPsXp
    eocy9ZXgfKOMAhMOnjK0yWIC6havy2cA9F+Iq0zDtH73CslgE/8Wk7YDA9SjAt+aILB5EO
    0XDl6RacbMnCdg4NTBMwQ4RT9Esounx21OeavdpWmuRASegb4FVRbDkmxy/SdmsZ7RkBEK
    xy3eB4W3ryZAZOUKBlUIgwleaxzvsi48Bzac1udETGuXgta+lWN2/KL2DvJziVQTbpOYy9
    gpMdx3IKmI52AStOImpv44W5istJIIGLhCkg/LLrMAH+c9j/DJE+20z1gjWne3rsQWc8mp
    FRSo6Z5UW65aFeBxqdN8tgoFDkY9Fj5vVcoL9jTll+/AwmSukfvi2hHmpqNQ
X-ME-Proxy: <xmx:OY8dam363h0x2uKiZTMZbCCpeCi6uUo3FQD8aEK0lYips0IjEpGVCg>
    <xmx:OY8daijEqxwdsB5j-QoO4UnxvoKK3gYcPa075DdZcYkNi05y0PtPaA>
    <xmx:OY8daufC1Fo8A7lmU1hDLHXjcV_3ZpD2cZ9L9spYvp3twMKUOvo3MQ>
    <xmx:OY8datmZkVrRFTkoPP0vHTy4AHYYximVDfvZFx25jXO1t5BRFZO6pA>
    <xmx:OY8dakC9rVWw0e_XfOJyWoNlHr6Zj-2lTGP54ArP1BQgryOmHfEDvU1A>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 1 Jun 2026 09:55:04 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e5be0791 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 1 Jun 2026 13:55:00 +0000 (UTC)
Date: Mon, 1 Jun 2026 15:54:52 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 0/5] Duplicate entry hardening
Message-ID: <ah2PLBluBFy44AQI@pks.im>
References: <pull.2096.git.1776731171.gitgitgadget@gmail.com>
 <xmqqpl2a4f09.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqpl2a4f09.fsf@gitster.g>

On Mon, Jun 01, 2026 at 09:33:10PM +0900, Junio C Hamano wrote:
> "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
> > We had some corrupt trees with duplicate entries in real world repositories,
> > which triggered an assertion failure in merge-ort. Further, the corrupt tree
> > creation in the third party tool would have been avoided had verify_cache()
> > correctly checked for D/F conflicts. Provide fixes for both issues,
> > including 3 preparatory changes for the merge-ort fix.
> >
> > Elijah Newren (5):
> >   merge-ort: propagate callback errors from traverse_trees_wrapper()
> >   merge-ort: drop unnecessary show_all_errors from collect_merge_info()
> >   merge-ort: free diff pairs queue in clear_or_reinit_internal_opts()
> >   merge-ort: abort merge when trees have duplicate entries
> >   cache-tree: fix verify_cache() to catch non-adjacent D/F conflicts
> 
> This is a fix to an important corner of our system, but somehow left
> in "Needs review" state for much longer than I would have liked, so
> even though I am officially on vacation ;-), I took some time to
> read these through (by the way it was a pleasant read, thank you).

Honestly, I always shy away from the merge-related subsystems. It has a
lot of subtleties that I don't have any experience with, so I never
really consider my input to be helpful here.

> I wonder if we create a rule like
> 
>     Those of you who have more than 30 commits in our project are
>     expected to review one topic (or more) from other contributors
>     for every three patches you send and ask for reviews by others.

Heh, that would make me condense patch series into fewer patches ;)

> it would help balance the patch vs review ratio, perhaps?

It's a good question. I typically try to aim for reviewing series on the
mailing list at least every second day, and I always encourage other
folks in my team to do the same. But recently I (well, rather we)
haven't really been able to due to the current situation at GitLab,
which forces us to put almost all of our focus towards a different
project for a while.

Overall I agree that everyone who is a core contributor should also make
reviews part of their regular worflow. At least for corporate
contributors that might also make it easier to communicate this to their
respective employers. Regardless of that, my expectation is that there
will be times where it works well, and other times where it works less
well.

Patrick

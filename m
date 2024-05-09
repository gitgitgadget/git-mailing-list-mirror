Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B23770FA
	for <git@vger.kernel.org>; Thu,  9 May 2024 18:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715278227; cv=none; b=mERJq5U7gMxsDLxGATiJBjIPIvhnCbff6cKB+zX3mx28rMtsKR8r+8tyH8L5jqfgnXaZfud8ow2lFV91/01mqvq23omRugT3t9jIn1jjp6El5l51dtbVLTAGe0WRtSgSeQGjyaK0fdTCh/YzyeM5Ji1TJOuKk39F+t1w9FYN3fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715278227; c=relaxed/simple;
	bh=oUzfDBtHXVXAF9fIrnxak2xu2poep//jisTSfEKnKHw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=g56OI0A77ZCRY7UnKS23DIXTwsjdAXVjt/scQgokvsvbFMPdP8WROnoxIwrtJVCnzyciqFKxUTvgL9+Y8393a2UY11Xs+lm/Kv6tlg+KYTv4+YFhbixE5ArDPkCwBLZbh8NEh65V7BYZ5If1V7NiTfiVgtwgGit8bedd+GSwsR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Oe3JNRsw; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Oe3JNRsw"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6D4DF2343E;
	Thu,  9 May 2024 14:10:24 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=oUzfDBtHXVXAF9fIrnxak2xu2poep//jisTSfE
	KnKHw=; b=Oe3JNRswxTD9wAEMTNyIBM1agWvCxgSQobFKGBFXk+v8Fn2abhHZrZ
	BuB0bNOEAgSV+d99I6UHcLhQ5GEXadkjLP0Wnd6qRSa+9mx1chivUEHIs9DKVSal
	jC20THG6Tles4kUfmEcaCF35hK+99IaVXxBTlCeQWClAtPeuOVDME=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 63F8F2343D;
	Thu,  9 May 2024 14:10:24 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id AD4A72343C;
	Thu,  9 May 2024 14:10:23 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Josh Steadmon <steadmon@google.com>
Cc: git@vger.kernel.org,  me@ttaylorr.com,  ps@pks.im,  emrass@google.com,
  nasamuffin@google.com
Subject: Re: [PATCH v2] doc: describe the project's decision-making process
In-Reply-To: <4a829792bf16973799bf3b3db0dd8b49a1ef3815.1715212665.git.steadmon@google.com>
	(Josh Steadmon's message of "Wed, 8 May 2024 17:01:30 -0700")
References: <b2ef74c1b0c7482fa880a1519fd6ea1032df7789.1713222673.git.steadmon@google.com>
	<4a829792bf16973799bf3b3db0dd8b49a1ef3815.1715212665.git.steadmon@google.com>
Date: Thu, 09 May 2024 11:10:22 -0700
Message-ID: <xmqq34qqua9d.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 67AB4B28-0E2F-11EF-99FC-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Josh Steadmon <steadmon@google.com> writes:

> diff --git a/Documentation/DecisionMaking.txt b/Documentation/DecisionMaking.txt
> new file mode 100644
> index 0000000000..55fa3e2185
> --- /dev/null
> +++ b/Documentation/DecisionMaking.txt
> @@ -0,0 +1,122 @@
> +Decision-Making Process in the Git Project
> +==========================================
> +
> +Introduction
> +------------
> +This doc aims to describe the current decision-making process in the Git

It might not be yet ready to claim this, but when it gets ready to
do so, we would want to say "aims to describe" -> "describes".

> +General Patch Series
> +--------------------

As if there is a separate section for "Special Patch Series"?  But
more seriously, I cannot quite shake this feeling that most of these
are covered in the beginning of the SubmittingPatches document.
There probably are small things that are missing over there that can
be found here, but given the large overlap, I have a feeling that
these additions are better done over there, not here, and limit the
scope of this document to decisions beyond the "General" patch
series.  There already is SubmittingPatches::[[patch-flow]] section
that may be a better place for the material we see here.

> +Starting a Discussion
> +~~~~~~~~~~~~~~~~~~~~~
> +For most changes, discussions are started by sending a patch series to the list.
> +There is rarely any need to discuss or ask for approval prior to sending
> +patches; the merit of both the general idea behind your change and the code to
> +implement it will be discussed at the same time.

We do not say "you need no permission or pre-approval" which may be
a good thing to add to SubmittingPatches.

> +NOTE: For general guides on creating and sending a patch series to the list, see
> +link:SubmittingPatches.html[SubmittingPatches] and
> +link:MyFirstContribution.html[MyFirstContribution]. The remainder of this
> +doc will focus more on what to expect from the list discussion.

So my question is if there is anything of substance left we should
have here, or if it is better to add them to SubmittingPatches so
that readers need to read one fewer documents.

> +Because members of the Git community have a wide variety of experience,
> +backgrounds, and values, series are expected to include as much context as
> +possible.
> +
> +If the proposer is aware of individuals with an interest in the subject of the
> +change, it is helpful to CC them on the proposal to increase the likelihood of
> +receiving constructive feedback.

SubmittingPatches::[[describe-changes]] and [[patch-flow]] might be
a better home for some sentences stolen from here?

> +Engaging in Discussion
> +~~~~~~~~~~~~~~~~~~~~~~
> +Once a proposal has been made, the community will discuss it on-list. While the
> +maintainer will often participate in discussions, it is not the maintainer's
> +responsibility to guide discussion; the proposer and any other interested
> +parties are expected to stay engaged in the discussion and ensure progress is
> +made.
> +
> +Anyone with an interest in the topic is welcome to discuss the matter. It is
> +expected that all discussion will adhere to the link:../CODE_OF_CONDUCT.md[Code
> +of Conduct] rules.

Ditto for the above to SubmittingPatches::[[send-patches]] and [[patch-flow]]?

> +Finalizing a Decision
> +~~~~~~~~~~~~~~~~~~~~~
> +If the maintainer judges that positive consensus has been reached on a topic,
> +they will merge the series, usually to the 'next' integration branch. After a
> +suitable period of time for testing by the community, changes are merged from
> +'next' into 'master', from which official releases are tagged.
> +
> +If consensus has not been reached, discussion may continue, or the proposal may
> +be abandoned if no one continues discussion. More rarely, explicit negative
> +consensus may be reached if the community feels that the series is not suitable,
> +in which case the series should be dropped and discussion ended.
> +
> +There are no strict guidelines used to judge when consensus has been reached,
> +but generally we expect all points of feedback to have been addressed with
> +either a fix or an explanation on why no change is necessary.

Ditto for the above to SubmittingPatches::[[patch-flow]]?


> +Larger Discussions (with patches)
> +---------------------------------
> +As with discussions on a general patch series, starting a larger-scale
> +discussion often begins by sending a patch or series to the list. This might
> +take the form of an initial design doc, with implementation following in later
> +iterations of the series (for example,
> +link:https://lore.kernel.org/git/0169ce6fb9ccafc089b74ae406db0d1a8ff8ac65.1688165272.git.steadmon@google.com/[adding
> +unit tests] or
> +link:https://lore.kernel.org/git/20200420235310.94493-1-emilyshaffer@google.com/[config-based
> +hooks]), or it might include a full implementation from the beginning. In either
> +case, discussion progresses as described above until consensus is reached or the
> +topic is dropped.

OK.

> +Larger Discussions (without patches)
> +------------------------------------
> +Occasionally, larger discussions might occur without an associated patch series.
> +These might be very large-scale technical decisions that are beyond the scope of
> +even a single large patch series, or they might be more open-ended,
> +policy-oriented discussions (examples:
> +link:https://lore.kernel.org/git/ZZ77NQkSuiRxRDwt@nand.local/[introducing Rust]
> +or link:https://lore.kernel.org/git/YHofmWcIAidkvJiD@google.com/[improving
> +submodule UX]). In either case, discussion progresses as described above for
> +general patch series.
> +
> +For larger discussions without a patch series or other concrete implementation,
> +it may be hard to judge when consensus has been reached, as there are not any
> +official guidelines. If discussion stalls at this point, it may be helpful to
> +restart discussion with an RFC patch series or other specific implementation
> +that can be more easily debated.
> +
> +If consensus around a decision has been reached but no implementation provided,
> +it is not the maintainer's responsibility to implement any particular decision.

As it is not anybody's responsibility, it may be confusing to single
the maintainer out in this sentence.  Saying "it is not" alone will
leave readers wondering "then whose responsibility is it?".  

I would say:

    When consensus is reached that it is a good idea, the original
    proposer is expected to coordinate the effort to make it happen,
    with help from others who were involved in the discussion as
    needed.

without pretending that the issues that needs consensus are black
and white "requiring code changes" vs "non-technical" without any
other colors.  IOW, I'd drop the following two paragraphs, as the
above would be sufficient.

> +For decisions that require code changes, it is often the case that the original
> +proposer will follow up with a patch series, although it is also common for
> +other interested parties to provide an implementation (or parts of the
> +implementation, for very large changes).
> +
> +For non-technical decisions such as community norms or processes, it is up to
> +the community as a whole to implement and sustain agreed-upon changes.


> +Other Discussion Venues
> +-----------------------
> +Occasionally decision proposals are presented off-list, e.g. at the semi-regular
> +Contributors' Summit. While higher-bandwidth face-to-face discussion is often
> +useful for quickly reaching consensus among attendees, generally we expect to
> +summarize the discussion in notes that can later be presented on-list. For an
> +example, see the thread
> +link:https://lore.kernel.org/git/AC2EB721-2979-43FD-922D-C5076A57F24B@jramsay.com.au/[Notes
> +from Git Contributor Summit, Los Angeles (April 5, 2020)] by James Ramsay.
> +
> +We prefer that "official" discussion happens on the list so that the full
> +community has opportunity to engage in discussion. This also means that the
> +mailing list archives contain a more-or-less complete history of project
> +discussions and decisions.

OK.

Thanks.

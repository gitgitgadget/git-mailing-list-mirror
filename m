Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A382135B
	for <git@vger.kernel.org>; Fri, 31 May 2024 16:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717174298; cv=none; b=i64uqorXkYPDg2BQfSKS9K04PMnRL9cDNWlzHJVGiDCX2zY2ID302mHjCATmyOkcxi4BnDkIeig4+/O68yra8VwJctMKYkMj5hweih/EoiqEQGdkvgrrtZqR8LTB96xJFcYN7BL0Z592AO5Ua1hrJ+DVhJQeu/nszfGrE31cKv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717174298; c=relaxed/simple;
	bh=R7BOhMpq/QCkk70HFyySzoXJFrrlXSILnwT8yu+R0y8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=l1FGcpvqJimYLJMwxw+mbQh26wFYfEjZdPOHL64lw2be84fANIddD/Xeffxt9DUU1bPirSxSBorvvli/GBeKnZu5NET3w+IJjgC9/noZAw1bqoseMCepFnRES/lgWljx8Fi4I1C9NE8Otg9cRajn29eN6fB7VKYXxAAMXQErE4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=IEGFjthD; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="IEGFjthD"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 597F63BD80;
	Fri, 31 May 2024 12:51:30 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=R7BOhMpq/QCkk70HFyySzoXJFrrlXSILnwT8yu
	+R0y8=; b=IEGFjthDQ5OztdW1ag6nQQ+RVOmWXhEguqztptjR863+9Y0lXHxOfH
	f05C3F8T56xv34lVI3rYrKOK/7WJGwFVw5+Afu8DCAG5mVGs1gn/dDANWJML6l/r
	zXd3kFr5TBn6SPGNpTwcFp38i3jp90S/EpAFTEJjGEte5HzTzKbYU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 515733BD7F;
	Fri, 31 May 2024 12:51:30 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 6BACB3BD7E;
	Fri, 31 May 2024 12:51:27 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Johannes Schindelin <Johannes.Schindelin@gmx.de>,
  Phillip Wood <phillip.wood123@gmail.com>,  Justin Tobler
 <jltobler@gmail.com>,  Dragan Simic <dsimic@manjaro.org>,  Karthik Nayak
 <karthik.188@gmail.com>
Subject: Re: [PATCH v4 1/4] docs: introduce document to announce breaking
 changes
In-Reply-To: <993b9363484627cd828362e39f15c4905ecaf3e2.1717141598.git.ps@pks.im>
	(Patrick Steinhardt's message of "Fri, 31 May 2024 09:56:32 +0200")
References: <fc1a9fa03de7330f79dc56b0f2712834cb236b5a.1715070296.git.ps@pks.im>
	<cover.1717141598.git.ps@pks.im>
	<993b9363484627cd828362e39f15c4905ecaf3e2.1717141598.git.ps@pks.im>
Date: Fri, 31 May 2024 09:51:25 -0700
Message-ID: <xmqqr0dhgc1e.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 05B8062C-1F6E-11EF-A7BC-ACC938F0AE34-77302942!pb-smtp20.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> Over time, Git has grown quite a lot. With this evolution, many ideas
> that were sensible at the time they were introduced are not anymore and
> are thus considered to be deprecated. And while some deprecations may be
> noted in manpages, most of them are actually deprecated in the "hive
> mind" of the Git community, only.
>
> Introduce a new document that tracks such breaking changes, but also
> deprecations which we are not willing to go through with, to address
> this issue. This document serves multiple purposes:
>
>   - It is a way to facilitate discussion around proposed deprecations.
>
>   - It allows users to learn about deprecations and speak up in case
>     they have good reasons why a certain feature should not be
>     deprecated.
>
>   - It states intent and documents where the Git project wants to go,
>     both in the case where we want to deprecate, but also in the case
>     where we don't want to deprecate a specific feature.
>
> The document is _not_ intended to cast every single discussion into
> stone. It is supposed to be a living document that may change over time
> when there are good reasons for it to change.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  Documentation/BreakingChanges.md | 66 ++++++++++++++++++++++++++++++++
>  1 file changed, 66 insertions(+)
>  create mode 100644 Documentation/BreakingChanges.md
>
> diff --git a/Documentation/BreakingChanges.md b/Documentation/BreakingChanges.md
> new file mode 100644
> index 0000000000..d8a26c9bf9
> --- /dev/null
> +++ b/Documentation/BreakingChanges.md
> @@ -0,0 +1,66 @@
> +# Upcoming breaking changes
> +
> +The Git project aims to ensure backwards compatibility to the best extent
> +possible. Minor releases will not break backwards compatibility unless there is
> +a very strong reason to do so, like for example a security vulnerability.
> +
> +Regardless of that, due to the age of the Git project, it is only natural to
> +accumulate a backlog of backwards-incompatible changes that will eventually be
> +required to keep the project aligned with a changing world. These changes fall
> +into several categories:
> +
> +  - Changes to long established defaults.
> +
> +  - Concepts that have been replaced with a superior design.
> +
> +  - Concepts, commands, configuration or options that have been lacking in major
> +    ways and that cannot be fixed.

The first two are easy to imagine.  If we change the default, people
may have to retrain their fingers or rewrite their scripts.  If
"log" that came later is so good that even those who were using
"whatchanged" have long switched to it, there will come time when
nobody even notices a removal of "whatchanged".

But the third one is puzzling.  If something falls into the "cannot
be fixed" category, is it still one of "These changes" that "will
eventually be required to [be made]"?

> +The Git project will thus irregularly release major versions that deliberately
> +break backwards compatibility with older versions. This is done to ensure that
> +Git remains relevant, safe and maintainable going forward. The release cadence
> +of major versions is typically measured in multiple years.

Releases vX.Y.Z (0 < Z) are "maintenance releases", and I have been
calling vX.Y.0 "feature releases" instead of calling them "major
versions", so the above use of the phrase "major version" can fit
in, but a more descriptive name, e.g., "breaking versions", might
convey the intention better, perhaps?

It may be more assuring to cite the last time such a breaking
version happened.  Was "Git 2.0" a breaking version?  If so, when
did it happen?  Were there other breaking versions in the past?

> +The intent of this document is to track upcoming deprecations for the next
> +major Git release. Furthermore, this document also tracks what will _not_ be
> +deprecated. This is done such that the outcome of discussions documente both
> +when the discussion favors deprecation, but also when it rejects a deprecation.

We seem to focus on removals and changes; will there be a case where
an upcoming addition is equally disrupting as removing an established
thing?  If we wanted to avoid focusing on deprecation/removals too
narrowly, we could tweak the wording below, with "deprecate a given
feature" -> "make the described change", etc.

> +Items should have a self-sufficient explanation why we want or do not want to
> +deprecate a given feature. If there are alternatives to the deprecated feature,
> +those alternatives should be pointed out to our users.
> ...

OK.

> +## Git 3.0
> +
> +The following subsections document upcoming breaking changes for Git 3.0. There
> +is no planned release date for this major version yet.

"upcoming breaking changes for" -> "breaking changes we plan to make in"?

> +Proposed changes and removals only include items which are "ready" to be done.
> +In other words, this is not supposed to be a wishlist of features that should
> +be changed to or replaced in case the alternative was implemented already.

OK.

> +### Changes
> +
> +### Removals
> +
> +## Superseded features that will not be deprecated
> +
> +Some features have gained newer replacements that aim to improve the design in
> +certain ways. The fact that there is a replacement does not automatically mean
> +that the old way of doing things will eventually be removed. This section tracks
> +those superseded features.

As the title says "superseded", to help non native speakers like me,
let's use a different and easier phrase with the same meaning in the
body text.  "... tracks those features with newer alternatives",
perhaps?

Thanks.

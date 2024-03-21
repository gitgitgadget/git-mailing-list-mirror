Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B32EC3
	for <git@vger.kernel.org>; Thu, 21 Mar 2024 01:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710985005; cv=none; b=L5trPC6EmUH5z4oRbfBeXeJr7hFyW+aaHDneo/0txw0yRXrnH4kvDUdYTyx/cJW8lFRPXS7j+H37BCdKN+ZCev75CHpR19kW2h+tVUb7/nTGiSPAz1fu6/tmudGkFoUc0JLrBcRsVn3ByuhO9LEBFPBo0Kg0Mq8HZP2Fhb51ekI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710985005; c=relaxed/simple;
	bh=v0JNZyR0lHxAfRc3BKtV56zD4/8NBhma4jRe2wkEsLo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ts+HXeeK7XAC8CE5lSyP4MRkvZNXIZ6eRLY3lcd1o2EXSfz3tYtjSmkXxTznqTgzPawUUoapOEJHFZIyKObTmxadese4YlGh6fjNPS/zV2Zl1VDxzQhx+GYTgIEZ7E5VjUAG1tYPAP7iGZX7ZVlaEwpc6BhQ7ra9RnYTKftQ9Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=PA3JFyfy; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="PA3JFyfy"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id E5FA51E495D;
	Wed, 20 Mar 2024 21:36:36 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=v0JNZyR0lHxA
	fRc3BKtV56zD4/8NBhma4jRe2wkEsLo=; b=PA3JFyfyjxB2as5Unk9p8ICWSCPJ
	VBuLVxaiQ6uBTDmSYNuqR7gYwV/5fWOEdsi8OPjfDKHI8ljjCzEzT6CcUeYrjyOz
	r7Yg6oLrkRASctcCgWiPxMCUSTi1pflobNiiFTKOyWV6dplqQmJGiCNV6J5leDeK
	SfIr60oY2z2OGTU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id DD9DD1E495C;
	Wed, 20 Mar 2024 21:36:36 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4A10D1E495B;
	Wed, 20 Mar 2024 21:36:36 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Brian Lyles" <brianmlyles@gmail.com>
Cc: <git@vger.kernel.org>,  <phillip.wood123@gmail.com>,  =?utf-8?Q?Jean-N?=
 =?utf-8?Q?o=C3=ABl_AVILA?=
 <jn.avila@free.fr>
Subject: Re: What's cooking in git.git (Mar 2024, #05; Tue, 19)
In-Reply-To: <17bea28cf691d3eb.70b1dd9aae081c6e.203dcd72f6563036@zivdesk>
	(Brian Lyles's message of "Thu, 21 Mar 2024 01:13:54 +0000")
References: <17bea28cf691d3eb.70b1dd9aae081c6e.203dcd72f6563036@zivdesk>
Date: Wed, 20 Mar 2024 18:36:35 -0700
Message-ID: <xmqqfrwke57g.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 74B993E8-E723-11EE-BA8E-25B3960A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable

"Brian Lyles" <brianmlyles@gmail.com> writes:

> On Wed, Mar 20, 2024 at 11:11=E2=80=AFAM Junio C Hamano <gitster@pobox.=
com> wrote:
>
>> Very much appreciated.  I wonder if we can have a better workflow to
>> do this, like perhaps contributors write a paragraph in the cover
>> letter with the expectation that it will be used in the What's
>> cooking report (which will become an entry in the Release Notes when
>> the topic gets included in a release)?
>
> I think some more official process could be beneficial. As it is, I'm
> wholly unaware of the current process for creating release notes for
> git. Do the maintainers simply review merged changes and write release
> notes as part of cutting a release?

A few things.  There is only one maintainer.  There are development
community members, who act as contributors and as reviewers.  The
maintainer manages how the 'master' branch and other integration
branches advance, and a part of it is to update the release notes.

Documentation/howto/maintain-git.txt outlines the workflow the
current maintainer has adopted, and it has a brief mention on the
"What's cooking" report.  These days, entries in the the release
notes for each topic merged are mostly copied from "What's cooking"
but currently, as the "howto/maintain-git" document describes,
summarizing and maintaining these topic descriptions is done by the
maintainer.

In the message you responded to, I was wondering if we can
distribute the load even further to have original author of each
topic write the initial draft of the one-paragraph description of
the topic that will go in "What's cooking".  Two obvious downsides
are that having people write about their own work would may make the
result harder to read, as they inevitably are biased by the
importance of their own work ;-), and having many people write
different entries may lose the consistent voice across topics being
described, but the distribution of burden is certainly attractive.

> This way, the
> contributor of a series is responsible for creating the changelog entry
> (or entries) rather than the maintainer, which can help avoid
> inaccuracies from a maintainer with less familiarity trying to
> summarize.

It however cuts both ways.

Trying to coming up with a summary from what I can read from the
discussion and the log messages is a good opportunity to find what
is still unclear in the log messages of the commits in the topic.
Not all contributors can write a good summary of their own work in a
way that are suitable for the audience of the release notes.  Also
you would want to encourage the maintainer to familiarize with the
topics to be able to summarize them, instead of keeping them in the
dark by doing the release notes entries yourself.


Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4DB12CDB7
	for <git@vger.kernel.org>; Tue, 23 Jan 2024 00:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705971475; cv=none; b=Xu4kfZ1Fl/FzA86yho8e2FHkH4u4nihHs8QbLXZYKyeTMlnwmcQkp7VgsicePjkPivO3Gr2mRrB19bpy1cXYDGIZPdCPq1zw0BG7TIHIUuGM4d/e9yGy02m2Vdy/HY507VZVf4aKH2BAMhlgrpBA2eQhPCptImZFCjq4PzvmmJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705971475; c=relaxed/simple;
	bh=+C7NFeDpVMsLQLw4f1ItltqoXB6vxFwp54IuHKnlFQY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IgR/k2zwE6J/pth3nyAyYPrA1ygIdpDFbnoym3gWpnJbDJAs1iheLx82Hw9QbLP8fpSGak2MN6mY7eI0JBv+KEtLoCDuSmabdHEwsTgq/JX6F0iwnblAvjH41G0eTVvbGoMjsvuYvu4+WcYFCWlifuOeoDqbjhE8Z5zK/eoaMIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=PK4bbHNX; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="PK4bbHNX"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id EE8AD2CA0C;
	Mon, 22 Jan 2024 19:57:52 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=+C7NFeDpVMsLQLw4f1ItltqoXB6vxFwp54IuHK
	nlFQY=; b=PK4bbHNXV5E8U8E3WW1JkfvMD86BVk5sV78jX5AynnHibKQKTH5dp1
	nH5M7O8BVo1bNWZE+kjYM+2jteeYCadV1g2RzGqLHecZXIngohs9eRnfAtFUwsSb
	MMYGTqUHHGV89A3f6hqGBvU1vE87qF5XwQrRU0wWc6p1hg8sXhDPU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id E691B2CA0B;
	Mon, 22 Jan 2024 19:57:52 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 703A22CA09;
	Mon, 22 Jan 2024 19:57:49 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: <rsbecker@nexbridge.com>
Cc: "'Emily Shaffer'" <nasamuffin@google.com>,  "'Taylor Blau'"
 <me@ttaylorr.com>,  "'Dragan Simic'" <dsimic@manjaro.org>,  "'Git List'"
 <git@vger.kernel.org>,  "'Johannes Schindelin'"
 <Johannes.Schindelin@gmx.de>
Subject: Re: Defining a platform support policy
In-Reply-To: <038701da4d90$b1bfb010$153f1030$@nexbridge.com>
	(rsbecker@nexbridge.com's message of "Mon, 22 Jan 2024 19:11:15
	-0500")
References: <ZZ77NQkSuiRxRDwt@nand.local>
	<b2651b38a4f7edaf1c5ffee72af00e46@manjaro.org>
	<xmqqjzog96uh.fsf@gitster.g>
	<006b01da4412$96c6c500$c4544f00$@nexbridge.com>
	<ZZ8ZlX6bf+hjmhN+@nand.local>
	<007c01da4420$10a7b700$31f72500$@nexbridge.com>
	<CAJoAoZnHGTFhfR6e6r=GMSfVbSNgLoHF-opaWYLbHppiuzi+Rg@mail.gmail.com>
	<038701da4d90$b1bfb010$153f1030$@nexbridge.com>
Date: Mon, 22 Jan 2024 16:57:47 -0800
Message-ID: <xmqq34uorhmc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 6DDB3746-B98A-11EE-B7AB-A19503B9AAD1-77302942!pb-smtp21.pobox.com

<rsbecker@nexbridge.com> writes:

> I think we might want to add some considerations to the above list
> that go beyond what other projects use, OpenSSL as an example:

[jc: if you want to have a meaningful discussion on this list,
please stick to a reasonable line width.  I'll rewrap your lines
below].

> * Can support for exotic platforms be delegated to some
> "community" support concept. In NonStop's case, I currently do 99%
> of the verification that each release runs properly. If I am able
> to provide a fix, I will. We have been fortunate that most
> problems/solutions have been of general interest and impact, with
> my platforms being more of a "Canary in the Coalmine" situation
> where we just encounter it first because of edge conditions, but
> other platforms may be impacted. The problem here is time of how
> long a designated community support person(s) can keep supporting
> git and what happens when they (me) retire or get hit by a
> bus. Like all good NonStop people, I have a backup, so git does
> not need to worry about me specifically.

There are platform packagers that deliver binary releases, and we do
not have to worry about them.  We _could_ have a tier of minority
platform that we can treat pretty much the same as these packagers,
i.e. the "community supported version of Git for platform X" might
consist of many patches on top of what I release, and some patches
that are acceptable quality may be given upstream, but there may
need hacks that are too ugly to live in my tree, which the
"community edition" may have to keep outside the upstream.  Even in
such a case, if they try to engage with this list, they will often
find somebody willing to help them polish such "ugly hacks" into
acceptable patches.

> * What is the broad impact of dropping support for a platform that
> has a significant investment in git, where loss of support could
> have societal impact. There are platforms with 100 million to 1000
> million lines of code managed by git today. This type of
> investment-related impact is specific to git compared to other
> Open-Source products. Leaving debit or credit card authorizers
> without a supported git would be, let's say, "bad".

Let's say we may want to start requiring new enough version of
library that is not yet ported to a minority platform.  Do we deeply
care?  It depends but "investment-related impact" is unlikely cause
for us to personally care.  But those $CORPS who will feel the
"investment-related impact" are welcome to hire quality developers
and to these employed developers, the "impact" might become an issue
they care more deeply about.

> * Could stakeholders be consulted before changing support levels?
> Yes, I get that commercial fee-based products hit this more than
> Open-Source. Looking at other products in the Open-Source space,
> there are fee-based support models that could be developed for
> long-term support (beyond the obvious LTS-type considerations -
> see OpenSSL's model for reference).

The stakeholders are already consulted, aren't they?  Every time we
make noises like "let's raise the minimum version of Perl we
require", we discuss it here.  They have to monitor this list, of
course, and if they lack people to do so, then they may have to
invest in it.

> A related question is: "If there is a bug detected in git, what
> version is the oldest supported git version to which a fix can be
> made?"

This is a good question.  The latest security-induced maintenance
release was Git 2.40.1 done in March 2023 and the fixes go back to
the v2.30 track, and Git 2.30.0 was done at the end of 2021.  This
window was unusually generous from our usual standard, IIRC, so I
would say roughly speaking 2 years is the maximum.

> ... But this position puts pressure on the team to maintain
> platform compatibility for indefinite periods.

Sure, but I think we should just say something like "18 months to 24
months", if you want backport of a fix to older track, you can do so
yourself.

The story is probably the same if a minority platform that lacks
recent enough dependencies (e.g. libraries) and stop linking
correctly.  If you care deeply enough, you should be ready to invest
yourself in porting such dependencies.  We can help, but the primary
driving force for porting issues ought to be folks with stake in the
platform.  We as the project won't bend over backwards and keep
everybody else to an ancient version of the dependency if some
platforms cannot catch up with the time.



Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D8F61DB55D
	for <git@vger.kernel.org>; Wed,  2 Oct 2024 18:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727892897; cv=none; b=JleWDiZsvEg/wtWV+HL+h17ktVsbEQWBU4CjlO/rLDo230JiytIKDrmGAQiBted8oVBeqMa90DdKCERQiFWGzdthWU73aWHw28uxmGN27T1/0sAlwI9CT9DNO6OAg//usunrYdtaEncN/N94J7we8RNkO7E+9uA1um1B7TasixU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727892897; c=relaxed/simple;
	bh=ap9t+oWQyqWJQ/v7uuBq3KfhWag2cMSl4U7w7uazYQg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JANMylrI4uBA2E8GY9eerAWevUPMPR2VUJM8KWMvkP2nVTDg3Z/XCYx8MXRPlmIJu/A5BTqMcOae2jJMX0ojno41WNb9uSefLL4ZPgOD7WDgcUyIrx/+XohUESnugss9cua/oGwlZ58UEVGMKjK293BE89kcRoh4sKeiSW/q85M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=d2/UzSJj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Mp1HcUUv; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="d2/UzSJj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Mp1HcUUv"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1E2C711401B0;
	Wed,  2 Oct 2024 14:14:54 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Wed, 02 Oct 2024 14:14:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1727892894; x=1727979294; bh=AZNv6IpBi4
	mMo4kLtA70KhYBokWabaaIReLc/o/xfWY=; b=d2/UzSJjJQNLTonQbmBbr/3oqQ
	ROpOFYRgb+p4QT7BVt6U7ULlDqmhNVPYYzdqGnmZC3gbTVW0DQrnEiQSBT3jatqg
	fZU8jJbNwbjlVpSoZZYRHNDO2zndwRfV73WtA5pPI53+q0/JPYWJQVKCtQjrSSVJ
	5M+YbwEGOzHq2PEQPK0Bo4d/oL0lOZjSwe3fv377S07KqAsOKJPuIwycmT089NEO
	71OwAR1UohxtxvrRaJQADHQUKbudjxwsLsOef+sH4elJ6ARl739HkpNbMJFKYYTP
	l0VrTb/2vVidI5kqJmZcDgD+rr09yVtahBSARLEdvQiNbTyoNpF1W+hI3LFw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727892894; x=1727979294; bh=AZNv6IpBi4mMo4kLtA70KhYBokWa
	baaIReLc/o/xfWY=; b=Mp1HcUUv8oOi12S36T8IqM/ggHakyUzUjS3A7X7l+EwH
	gOMvjssTW+rNG0X0v/F1SUtmb1aXeUjvQ+Vog/ui+i7eLpSOwaO56sNVvlluNN+p
	/ljJD5p5OdE4WkIlJLcQsmdWATpVRJcXDPsn9k39Mg3+qSKWwlDbrVveYlUjc9eI
	QauxpAAsb20SUjmO583Ka8R6hA/Dh2FGmu707lO//k8a47gYpled3d7Hf26Gjp7f
	Zhio/GhDn6JPzww49QvooN9HY2GeOVTx1+bi7jG8cmhBFm+iasptd1pIgcmBTIpL
	7EeJU6pyWDzpprae1dW0gP7ES/SVQAcpkBUjhna54A==
X-ME-Sender: <xms:nY39Zoc9QAuGKhSRbjitDYEzKpnylOYIvkoocuT1GknN88ST4BbxRQ>
    <xme:nY39ZqOYC5RLu4NrxI2KmZuPt2AVe2dzFdKz8l9xDr3aN75FdRouNpmJOM1rMjAUu
    yA-Rib0wuKHaQVkYA>
X-ME-Received: <xmr:nY39ZpjHtnuxQCHNMOdQnu6i4sm0FjI5QLZcdsjZRLOHWquw2yUPtKQCku38HuVOOUJ06oPW_ekuFZ11fzT0VA2fgW2cAkHXWEFWObM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdduledguddukecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdfotddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeejheelteduveffjeehtefgveelteeghffh
    ueejhfetgeetffdttedtvddtfeffgfenucffohhmrghinhepthigthdrrghuthhonecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgv
    rhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouh
    htpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtsehvghgvrhdr
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepvghstghhfigrrhhtiiesghgvnhhtohhord
    horhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:nY39Zt_3KPlRb2hmZ-7rPh5BdWlmGnXRe-HouKakBk2RsV2lmXJPNw>
    <xmx:nY39Zkuo-wSrEhrhnQX1TqjQQqo12Seim2ai9LYEyeyOHv0jyWipig>
    <xmx:nY39ZkGmZOgXAU_s4n38xUXKFO2lFLuh0B-SG_yXE99_A1X2J4FgqQ>
    <xmx:nY39ZjPBwnRyHoo52GhwZWIDBIN5Xj0dgwPkl0RHiu15YmgIrEd4rw>
    <xmx:no39ZmIjavE4pjRoYnhlVMjHEKVnNTVw6C2hyEug19xg0_HIBvde0RNu>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Oct 2024 14:14:53 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Eli Schwartz <eschwartz@gentoo.org>
Subject: Re: [RFC PATCH 01/21] Documentation: add comparison of build systems
In-Reply-To: <508e3783d284fd2d3bd4840907ed0bdc20bc1b23.1727881164.git.ps@pks.im>
	(Patrick Steinhardt's message of "Wed, 2 Oct 2024 17:15:36 +0200")
References: <cover.1727881164.git.ps@pks.im>
	<508e3783d284fd2d3bd4840907ed0bdc20bc1b23.1727881164.git.ps@pks.im>
Date: Wed, 02 Oct 2024 11:14:52 -0700
Message-ID: <xmqqjzeqmkwz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> We're contemplating whether to eventually replace our build systems with
> a build system that is easier to use. Add a comparison of build systems
> to our technical documentation as a baseline for discussion.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---

Thanks for starting this.

> diff --git a/Documentation/technical/build-systems.txt b/Documentation/technical/build-systems.txt
> new file mode 100644
> index 0000000000..8fac36ce1d
> --- /dev/null
> +++ b/Documentation/technical/build-systems.txt
> @@ -0,0 +1,164 @@
> += Build Systems
> +
> +The build system is the primary way for both developers and system integrators
> +to interact with the Git project. As such, we consider it important to pick a
> +build system that fulfills our requirements while being easy to use and extend.

Maybe it is me, but this sounds as if _we_ do not need "easy to use
and extend", but "easy to use and extend" are extra afterthought
consideration we are making for others, which is a bit disturbing.

Let me try paraphrasing what I think you wanted to say

	As such, being easy to use and extend for those who are not
	directly developing Git itself is just as important as other
	requirements we have on any potential build system.

which hopefully would sound more like we are not treating those who
only build and tweak the product of our project as second-class
citizens.

> +This document outlines the different requirements that we have for the build
> +system and then compares available build systems using these criteria.
> +
> +== Requirements
> +
> +The following subsections prevent a list of requirements that we have for any

I think you meant "present".

> +potential build system. Sections are sorted by decreasing priority, even though
> +these priorities will naturally differ between users.
> +
> +=== Platform support
> +
> +The most important criterium is whether the build system supports all of the
> +platforms that Git supports. The most important platforms include:

Maybe it is just me, but when I hear "The most", I expect an
exhaustive list (hence "include" that came later somewhat surprised
me), and I consider these "the more important systems" (implying
"than others").

> +  - Linux
> +  - macOS
> +  - Windows
> +  - FreeBSD
> +  - OpenBSD
> +  - NetBSD
> +
> +The platforms which must be supported by the tool should be aligned with our
> +[platform support policy](platform-support.txt).

> +Auto-detection of the following items is considered to be important:
> +
> +  - Check for the existence of headers.
> +  - Check for the existence of libraries.
> +  - Check for the existence of exectuables.
> +  - Check for the runtime behavior of specific functions.

- Check for specific link order requirements when multiple libraries
  are involved.

> +=== Ease of use
> +
> +The build system SHOULD be both easy to use and easy to extend. While this is
> +naturally a subjective metric it is likely not controversial to say that some
> +build systems are considerably harder to use than others.

If we want to pull RFC-2119/BCP-14 with shouting "SHOULD", we
probably should use something similar in the previous "Platform
support" section.

> +=== IDE support
> +=== Out-of-tree builds

Cross platform builds (e.g., building for arm on x86-64 host)?

> +=== Rust support
> +
> +Many long-time Git contributors are nowadays in favor of adopting Rust as a
> +second language next to C. The build system SHOULD thus support Rust such that
> +we do not have to reopen the discussion once we decide to pick up Rust.

What reasons do you have in mind that, without spelling this out,
Rust will be left behind while C is fully supported?  If the build
system can keep track of dependencies by knowing foo.o is made from
foo.c and turning foo.c into foo.o takes running cc, it can do the
same for rustc.  Do you mean include file dependencies and the like?

If the reason why we say "Language X needs to be supported" is
because it is not enough to be able to run a compiler on source
files written in the language, but it is also necessary to know when
to run the compiler (i.e., by dependency tracking), it is better to
spell it out.

In any case, instead of singling out Rust in the title, name the
section "languate support", and give an enumeration of compilers
languages, processors that we care about, just like we did for
platforms.  For exaple, we may not necessarily want to treat "C
support, done as an afterthought of supporting C++" and "C support,
done natively" as equivalents (of course, the latter is better).

Shouldn't it also "support" asciidoc/asciidoctor/makeinfo for
the documentation toolchain?

Are there other things we use Makefile for in our current system
that we are forgetting in this requirements section, like "running
lint" or "running tests"?

Thanks.

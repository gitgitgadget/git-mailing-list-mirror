Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5343F1EB36
	for <git@vger.kernel.org>; Fri,  8 Mar 2024 15:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709912575; cv=none; b=HGHdtYDPOIZtXoQ9t/o1v0UXuBPKGLIEH5Dd/jmkX6bAEkHpS+9p5qFGazqM1ZF+pKwUfYK0wjSBlb8hn+A8ihz1Y0+MAYdxbiz/IvYpXo3Z8vFlc0yT94BYW0qlVgOdB0EDh15EsCulpMPdrlKbBOjgnqW9LPGfpXAFl+QmRiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709912575; c=relaxed/simple;
	bh=bll4L8W1ZH6JYFxnhhiFfBhipwTZxjQIFcg2Hau+kE0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CNOTVBbwRE3WgdviuDqk+Ionvy1zctu+2+6NvxUIEDqg8Q0VawE6qYEy22EuIgkqmWBv/v4+P3cxnagF1AHyaculENI+xSxRXZG/aH1hSq4tfHQBR7S3+Jm/dhi0zRIay2/pJaMMU4mbBJoBDcSJQnycXpo9+EL/znkzRMx8WL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=I+bom0Qd; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="I+bom0Qd"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3F0A71DFAE9;
	Fri,  8 Mar 2024 10:42:53 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=bll4L8W1ZH6JYFxnhhiFfBhipwTZxjQIFcg2Ha
	u+kE0=; b=I+bom0QdtnMgfUz8sDqO8b34Vu2PymSFGX7p1JsDUalSq+Uun/gDkq
	COkFb+fSzM6dGV6dNjqfq91fj4Lb+ORN6SCPJmpx1GWScSRw/q4RvpGY94P1yLRm
	gD2uQwOVA7Bb1ibmUtWW3sc1LYRdT+BGLBz8NB9Z7kTLCFpa1xPUQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 26B291DFAE7;
	Fri,  8 Mar 2024 10:42:53 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 751101DFAE6;
	Fri,  8 Mar 2024 10:42:52 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Mar 2024, #02; Thu, 7)
In-Reply-To: <f7cd227f-dcde-4d71-b1a6-a4d34c492cd1@gmail.com> (Phillip Wood's
	message of "Fri, 8 Mar 2024 13:56:35 +0000")
References: <xmqqplw5ihm7.fsf@gitster.g>
	<f7cd227f-dcde-4d71-b1a6-a4d34c492cd1@gmail.com>
Date: Fri, 08 Mar 2024 07:42:51 -0800
Message-ID: <xmqqttlghgqs.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 864F352E-DD62-11EE-9A21-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Phillip Wood <phillip.wood123@gmail.com> writes:

> On 08/03/2024 02:26, Junio C Hamano wrote:
>> * rs/t-ctype-simplify (2024-03-03) 4 commits
>>    (merged to 'next' on 2024-03-04 at 9bd84a8877)
>>   + t-ctype: avoid duplicating class names
>>   + t-ctype: align output of i
>>   + t-ctype: simplify EOF check
>>   + t-ctype: allow NUL anywhere in the specification string
>>   Code simplification to one unit-test program.
>>   Will merge to 'master'.
>>   source: <20240303101330.20187-1-l.s.r@web.de>
>
> I have some concerns about the last patch of this series
> c.f. <0947cb09-8b07-4fcd-bbe2-ae37c2cd5ec7@gmail.com> It might be too
> late for this series but using the internal implementation functions
> rather than TEST() is not a pattern that I would want us to encourage.

I actually think it is merely showing the lack of necessary features
in TEST() and other public macros/functions of the relatively new
low level test framework.  If a user of the framework needs to use
the "internal implementation functions", that gives an incentive to
those who are pushing for the test framework to polish and update it,
so that such a framework client does not have to go deep into the
implementation details.  When they come up with an improved framework,
they naturally have the first target to adjust to the framework to
demonstrate that they made the world a better place ;-)

And I think such an update can come after the dust settles in this
case.  It is just a single simple test that is isolated and nobody
other than the unit-test folks should care about, as the subject of
test has not seen any change for a long time.

Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D09119E992
	for <git@vger.kernel.org>; Tue, 16 Sep 2025 16:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758039376; cv=none; b=vB7Lm/0wUzJjw+HJ0ib+q8nB/C3dy5bS2JIfwluF+PmlqPn0JQmzc3vZTbV7zqGokR12ttnawKZgau7HZH8LvvFV6rUcpUHllB6afy/ZrD5wqh9fu4pbke0SFUfTJNktwkKz2XiAqUELtieVySeE6a9PBUfd3b1Jd/3DMyT9DfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758039376; c=relaxed/simple;
	bh=ade6i3Q+sgLGbWMLI0Q0UpEfjmYgMS2Rh+m35ms62wk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=k6ZxNXOAhSWy700VcemVEporJEOfcaoISw5aj2xJYpfUdr/rdszTGLsiGfjz2RbKTJSoDJcaux8E75B0tRF5Ryv9aV03IekfL4ghQkIY9k28LWrRhteQ1S0tEcaaZsh8ikqghnXDhZ2v+DlXUGhAG/8BpT/p4r7i0rst9N4+d7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=VDImQ0Jz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=V7SpWfVk; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="VDImQ0Jz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="V7SpWfVk"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 30352140021E;
	Tue, 16 Sep 2025 12:16:13 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Tue, 16 Sep 2025 12:16:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1758039373; x=1758125773; bh=DrbLqjI2iU
	N4cBxYubVvEzsm4Tntmn3GI5t4cNHy74g=; b=VDImQ0JzkvvSlvA+LKvC8aiwLc
	wySYQ34PIdx0iyVq5UKd5uXRRvhqbHnv0vAsrE+97Ex9P8NQuTCxKT8/oQK5k8Ew
	Gk8uqbZR6PLOKYXimhvrumMbHk7jGfr4pVy8wWZ+jIk7DA3HGA7FknaXt7koKcoZ
	Kdkh66AySS7df/u4ofzqWblkvmjpmYpMSXk1scXwo4p/+7aEo33+fJHds49J3ixD
	ep/L55spFPFzUacXs64oY4o/7C72L6De89ZFHurpcMXfcetq3HfMwxHXAwVNfJAT
	Nenzx4U55b8EgU5NvS3msos5sUikiUS6F6EvcgcHMETPAx3xD4My/0QVMU7Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758039373; x=1758125773; bh=DrbLqjI2iUN4cBxYubVvEzsm4Tntmn3GI5t
	4cNHy74g=; b=V7SpWfVkvenEOvk/eKUk+o/5X7scACykgXRuei+6kHV8IeMveEc
	uL/U/bO9eNugidTMFeg8cfD42vnL91Gb1Dv6s3LvLyDPX8FvRbFMSWtNlLi2k2lB
	vRFnvTk6qLb3VcGbpQ4lr4kbVo7JU73kfgAiHYLXG8dG0VTVwcGKUzUdN29Ij4yx
	Zb/6zpGpKpvGPNrSMQ6MDCqh2MMKGc+iw2SdIi8QAWGqm8jscibg2AdRzC6mUPT4
	aEJ3/hYBcW1mn6aw+RCz+n5Zk++5rweoFw3RbuESmZ4LEADK5z1t6gvqyOUIZOzL
	eQ4m6T+egT2/nuvjW5x1yYXd8uQd3Iy5o5Q==
X-ME-Sender: <xms:TI3JaGPb3RYMpDAHRfsN16AGJz9EAHRVmPsxO2mNyDaoXcwKkI48dw>
    <xme:TI3JaINjU139PiRyP98zUBIAqLi1RbFckoah9JvqNuVNBgjZM1U-6oFZNimlaLqh_
    l4yYxaJBY7K0_nGzQ>
X-ME-Received: <xmr:TI3JaGuUd-fxSgc19-t8GFaDG67kAdup932tkehtUeCqoAY4miu8hQmlioD6Oe6iQovWGbRiQVGaN2-YcFzhu5DDdvvihelVgxqyTos>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeguddtfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdfotddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeeikeeufefhtedvffdtgeefkefhffeggfefiedvudegfffgffffveevvdeileff
    udenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohig
    rdgtohhm
X-ME-Proxy: <xmx:TI3JaCXPRwSJSo8g1Ny5ABiO3rCfYHwMeVJxwcz_4HY5FmmsxBlCCg>
    <xmx:TI3JaOvxW201hBXwpZuNR6QvImT3RozTt9kgCI3fnKx--50e3WnLZw>
    <xmx:TI3JaOUs9mdqdgVgKuu4_-hn6TKy7Y8Ze36KGP-MeYut0EC3gZ7FXw>
    <xmx:TI3JaBmcccygkCQXIkSkM_0FWjdUePsgO35SjcvSRrTFitoA6m-APw>
    <xmx:TY3JaDQgymo5dQVz8gHBKfrEpXHRLp8rK_TsHoH4QUnTLwLPTXGd9vcf>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 16 Sep 2025 12:16:12 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Sep 2025, #06; Mon, 15)
In-Reply-To: <aMkJVMbSmeA4cIAy@pks.im> (Patrick Steinhardt's message of "Tue,
	16 Sep 2025 08:53:08 +0200")
References: <xmqqtt13frqm.fsf@gitster.g> <aMkJVMbSmeA4cIAy@pks.im>
Date: Tue, 16 Sep 2025 09:16:11 -0700
Message-ID: <xmqqzfaunzjo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On Mon, Sep 15, 2025 at 12:19:45PM -0700, Junio C Hamano wrote:
>> * ps/odb-clean-stale-wrappers (2025-09-12) 2 commits
>>  - fixup! odb: drop deprecated wrapper functions
>>  - odb: drop deprecated wrapper functions
>> 
>>  Code clean-up.
>> 
>>  Breaks build when merged to 'seen'.
>>  cf. <20250910153759.GA562601@coredump.intra.peff.net>
>>  source: <20250910-b4-pks-odb-drop-wrappers-v1-1-6ed660cb1eec@pks.im>
>
> Shall I send a new revision of this patch series that squashes in the
> fixup commit? I wouldn't mind doing that, but it becomes a bit weird to
> do so when the original base of the patch doesn't even the issue.

Yeah, typicall fallouts from code churn that needs to be handled
somewhere in the codebase.  *hit happens (shrug).

As this makes it necessary for that file to eventually include an
extra header, it sort of makes sense.  I am more wondering if it
should be a separate commit (i.e. give it a proper log message
instead of fixup!).  If we were to squash, we would need to mention
why a seemingly unnecessary change is included.  "In anticipation of
another topic that adds a call to function Y, whose definition this
topic shuffles around and makes it necessary for its callers to
include header X, we pre-emptively include header X that will become
needed for the other topic to use function Y when merged with this
topic".  I agree that is certainly awkward.

Adding the extra include to the other topic is not any cleaner.  It
didn't have to include that header to make calls to some functions,
and it is only because another topic shuffled things around that
made it necessary.  "In anticipation of another topic shuffling
headers around, we pre-emptively include header X that will become
needed to use function Y when merged with the other topic" would be
such an extra commit would say.  That may be slightly less awkward
but it still is so.

And it would be cumbersome to do _the_ right thing for something so
small like this: build this on top of the topics affected.  That
would allow us to say something like "We will move things around and
require header X to be included by callers of function Y in a later
commit in this series.  Do so now as a preliminary step."

So I dunno.  What's your preference?

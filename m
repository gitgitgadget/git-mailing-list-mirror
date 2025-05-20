Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC5B19EEBF
	for <git@vger.kernel.org>; Tue, 20 May 2025 15:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747754937; cv=none; b=iFLIlcEq+UxugjsA4Sxn6+jq8TxYKNsfN6RWzyhq8C1aneYMlMvPB2WMl6Y3HwLkOV4trSlBZY2/51tMMDUu7RVyx7eI9kpraE/VqKPAWXe/xOWPmv4BFzu5CkrL1EIyqBK1OUQfo4QCIAgpHCbui0rAOPo652nwKAN5l+GifZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747754937; c=relaxed/simple;
	bh=bVDrQTF44rWyDbVIH+bx+li56wlI0mw2gV9z+ijplsE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ku40SfJ6elKhLPp/mGOP/S/I7b+K3CvfVb0WHu3Bm7sUF3rffChyvToUlTjY87P3sAu2W5j3TT7H33w5RtQfKLg9XxIh75YQifD9eqcVUIQE3ygDIufpTe9P9j7/JK/0Mjr71BsTOoMKXFI8L+Id81s+lU9wDTGq0iQyFKNT29Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=f8lV7D6F; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=T0loy8cU; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="f8lV7D6F";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="T0loy8cU"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 7DF351380448;
	Tue, 20 May 2025 11:28:53 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Tue, 20 May 2025 11:28:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1747754933;
	 x=1747841333; bh=W96TmOkAcO3VZaMDDxNsANx+4eJGs71Ghvhgo1nEZO8=; b=
	f8lV7D6Fduh6IhYJmTXewsV4GZuu3mybg17hKN+Vwjp9YnOQTjqwAMIR7qIQg96R
	5ab4MqjUJxvyxbEUgoKLcZdr9P+o09QU57grnLWy6bFxRTMQC2uhbqBlTTcnqXzr
	YSwmhswl07iCEwgOfCieJybRufve00aybxVsZK4wr20cPT/jPty5gU1Ai+ohbkZb
	W6fhh72okX4Bsd1arkMHFnD/tVYJJlkaRHhhBaYsCU1hj1ELiSu3OmNtiYN4eRtw
	KsOOMSPvGEJ2qUtzAk62UpPmJr2kHTLfP9alknWD45SrMR/+d1njuR5CBLHmLbTA
	J8SLfHJLd4k0l/ML4Zavfw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1747754933; x=
	1747841333; bh=W96TmOkAcO3VZaMDDxNsANx+4eJGs71Ghvhgo1nEZO8=; b=T
	0loy8cUMXRRh3+9pPh5l3f2HoySOmGlOhW0MPxGWAW/PbqT/NT+ZyDrLJ2HOMRc4
	qGwPlWgZ8yEVhhFMwXja5+dyqEOAclbmhf0RJWRZKfnbxBBlHN8ptrv4KQcbEJo4
	/4k1wuCxswMQ0jq3SruCZH4akFIb/jGnUwzKlJ53HnzNhNQC8rkK1SRv0ymhO2dP
	xjRMezlaiHhLeVr4BomofGNejsDcMN7HRRBImgvxlJzJz2rnoune38/CZX7bFInS
	5ZVlifSqc5lCMZkcuf8ElGIgFrQcnT3SAfdUSVlx2RgEL8gIfJWv31GrQ1bAy44W
	GSzBjMH5pYYZbq6h80zBA==
X-ME-Sender: <xms:tZ8saNZ0Wfhuh_R_Om76GFJbcq2UDYlq1xZ0yF8gvE5P9BmVD29QBQ>
    <xme:tZ8saEYfTa5mKyL3KJb-mMsrz0QHqO4oYunYl-ePbO2BtqAistqtH7I4aBM_Eb5ag
    EG0eGS7AI2NhLDHIA>
X-ME-Received: <xmr:tZ8saP-M1wAkD3RluJwxvhBZw0E02U0XfBJJqWvFjgdQtW9N4ogqdKkUxycV1WvJAhhi_WqgbJ930-eNiqnyMg1t1FxfD3Mclsv6sg4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdehjeculddtuddrgeefvddrtddtmd
    cutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghn
    shhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtne
    cunecujfgurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefl
    uhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenuc
    ggtffrrghtthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdek
    heelveevfedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhm
    ohguvgepshhmthhpohhuthdprhgtphhtthhopehjrgihrghthhgvvghrthhhkhhulhhkrg
    hrnhhivddttdehsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhk
    vghrnhgvlhdrohhrghdprhgtphhtthhopehmlhgvlhhltdeksehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:tZ8saLqOa2auttL3CD2pNj1TU0K_cQVIegsybR3wI21G6Zn7aWybUQ>
    <xmx:tZ8saIqlwlkx9NLmYD6JuROE5gkCJ8-1s-_q9PqWOcJDAgj3h-Ft6g>
    <xmx:tZ8saBQUueBiqMwYowWSk4p3rN-WVD12reoKSNSe6DKxTV2qIt3egQ>
    <xmx:tZ8saAoW5UONde_Gqk2xnGUjGSyEHdL6Bn6uAday58ipdnToDFlHAg>
    <xmx:tZ8saH2CZvOIqNABGebmeucxC5ijB1bUnsIX5-Da2XYlgOEiYkFtJpAm>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 May 2025 11:28:52 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: JAYATHEERTH K <jayatheerthkulkarni2005@gmail.com>
Cc: git@vger.kernel.org,  mlell08@gmail.com
Subject: Re: [PATCH v5] submodule: prevent overwriting .gitmodules entry on
 path reuse
In-Reply-To: <CA+rGoLdbmRkk5b3LJ+n3HG6OJv7oURJaLuWs3tTymDfsbBgwjA@mail.gmail.com>
	(JAYATHEERTH K.'s message of "Tue, 20 May 2025 07:01:24 +0530")
References: <CA+rGoLfLA_s_xYN1N41w=vaOg0WPTNo_9TGKvG6ZQDqqWmzFPA@mail.gmail.com>
	<20250518075436.75139-1-jayatheerthkulkarni2005@gmail.com>
	<xmqqwmacobf0.fsf@gitster.g>
	<CA+rGoLdbmRkk5b3LJ+n3HG6OJv7oURJaLuWs3tTymDfsbBgwjA@mail.gmail.com>
Date: Tue, 20 May 2025 08:28:51 -0700
Message-ID: <xmqqsekzjo7g.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

JAYATHEERTH K <jayatheerthkulkarni2005@gmail.com> writes:

> On Mon, May 19, 2025 at 9:11 PM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> K Jayatheerth <jayatheerthkulkarni2005@gmail.com> writes:
>>
>> > When a submodule is added, Git writes submodule.<name>.active = true
>> > to the repository configuration to mark it as active. This happens even
>> > when the submodule path already matches a pattern in submodule.active.
>> > This results in redundant configuration entries that are unnecessary
>> > and clutter the config, especially when pattern-based activation is used.
>> >
>> > Avoid writing the submodule.<name>.active entry if the path is already
>> > covered by a pattern in submodule.active.
>>
>> This explains why the part of the change that deals the .active bit
>> makes sense.
>>
>
> Hmm, I look at it this way,
> active and path problem are not different,
> It's just that this has to follow t7413
> submodule active too.
> Therefore the submodule.<name>.active = true
> logic exists
>  > >Avoid writing the submodule.<name>.active entry if the path is already
>  > >covered by a pattern in submodule.active.
> I think this order makes sense to me, but I could change if you want me to.

Do you mean the problem "we add a submodule at 'foo/' but the name
'foo' is taken already" does *not* happen when submodule.active
patterns are *not* used?  If so, I understand that these two
problems are linked together, but I got an impression that it is not
what is happening.

And that is where this question ...

>> Stepping back a bit, perhaps this patch addresses two independent
>> issues, both of which can trigger with"submodule add"?  If so, would
>> it make sense to have it in two separate patches?

... comes from.  The added test does not use submodule.active
pattern, so I assumed that the pattern-based activation is a
separate issue.

The solution to pattern-based activation may have to happen by
updating the same code path and it may turn out to be that having a
single helper function that deals with both is the cleanest
solution, but still if they are two different problems, a single
patch should not try to solve both of them at the same time.  Solve
one by introducing a helper function and make sure that the fix for
that one problem will not get broken by adding tests, and then on
top, solve the other, perhaps by modifying the same helper function,
and make sure that the fix for the other problem will not get broken
by adding further tests, prehaps?

> This would be the case if I wrote a separate helper function I guess
> but the core issue still lies at the if else block
> And the active part is just written to mark the submodule.<name>.active = true
> So I think these are a part of the same problem.
>
>> > +test_expect_success 'submodule add fails when name is reused' '
>> > +     git init test-submodule &&
>> > +     (
>> > +             cd test-submodule &&
>> > +             git commit --allow-empty -m "initial commit" &&
>> > +
>> > +             git init ../child-origin &&
>> > +             git -C ../child-origin commit --allow-empty -m "initial commit" &&
>> > +
>> > +             git submodule add ../child-origin child &&
>> > +             git commit -m "Add submodule child" &&
>> > +
>> > +             git mv child child_old &&
>> > +             git commit -m "Move child to child_old" &&
>> > +
>> > +             # Create another submodule repo
>> > +             git init ../child2-origin &&
>> > +             git -C ../child2-origin commit --allow-empty -m "initial commit" &&
>> > +
>> > +             test_must_fail git submodule add ../child2-origin child
>> > +     )
>> > +'
>>
>> The test seems to be about "the other issue".  Shouldn't we also
>> have a test about "we no longer add redundant configuration entries"?

> Actually t7413 has a detailed coverage of the _active_ logic.
> I actually didn't consider submodule.<name>.active = true
> but looking what failed in 7413 made me realise we have to
> solve the core issue and then
> submodule.<name>.active = true it too.
> Therefore I didn't add extra test case too.

When we re-read what you wrote as a proposed log message, you said
that adding a new submodule that would match the "submodule.active"
pattern will result in redundant configuration entries that are
unnecessary.

If you perceive it as a problem to be solved (and you do---otherwise
you wouldn't have written that there), the existing tests do *not*
consider it as a problem, so even if they have tests that does the
pattern-based activation, they would not have any tests that make
sure they do not create redundant configuration entries, would they?
If we fixed that issue, then now we need to make sure that future
changes will not break the fix and start adding redundant
configuration entries, but because there is no test that does so
(otherwise, you wouldn't have found a need to fix that "redundant
configuration entries" problem in the first place), the patch that
fixes the problem needs to add tests to do so, no?

What "redundant" entries do you exactly mean?  If it is "we end up
with the same submodule.<name>.active appearing twice", then the
test should make sure the resulting .git/config file has only one
(perhaps with "git config --get-all"), for example.


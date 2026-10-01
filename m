Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E6BB3E40E8
	for <git@vger.kernel.org>; Thu,  1 Oct 2026 20:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790885506; cv=none; b=MA8SRZ/OdsrNuLagyb0jFDzITmGvz6OMkd4094Z4y5GOwv6QtiQXk39UMF2XJ1goEwtOLBHIyqjwgqq8U5BB6M7svlmxBemNXrquyoZtTKmhBWE2JBAfHmbBFeA2vhbntBLgkWfTV+tP5iwrdgPFaDGwMv0RzIFKWfTBLZw4s4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790885506; c=relaxed/simple;
	bh=UW5UUeVBiHw+AXY4qICGMeaYkAXnCZuo0NT34bDEauY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fKMpZEklMJdXUAVzOdfjURliuZxLiQEMJDWEWe5+woADPwIG/muNoI9GEqoyJVGPKHFUZUZ6MAibgS2B0NvysQNJG5o8jHOEBWZQi3fyc/Z4UOwPteRntLGqQ7GbjgnZRHi94Wdhm2ArYPqQZXCQZ2MLsQhQkjnmBscoh2LcA2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=UuBQ5gW6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gwzKbGFj; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="UuBQ5gW6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gwzKbGFj"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 88D3D1400138
	for <git@vger.kernel.org>; Thu,  1 Oct 2026 16:11:43 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Thu, 01 Oct 2026 16:11:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1790885503; x=1790971903; bh=8Nh1Xe2+lp
	NfojzVtQ+hd9qUqMdyx2t1y8D8EBWtxNQ=; b=UuBQ5gW6vUc/F7KDH51yvXKfiX
	segc87YoV/qQNORHKn3ocYJ1aFOEG9wvkST1481vBwedQy/tOoJY5UhuEhxpVGDg
	Petv0M5AzNvLBZz94l9uU9SNWkjzv8aqMIEU9Sq2jHF9vau+fED1KrJrxHuXYDQH
	T4ACMzx/5mbfV6C0gVYPfBRDXJYw7iDEXNxF+zYGfe5ZzJY+8qujbEV0R61tqGpE
	vrVz9i+ULxeD8mrpTqeq6pNfItNdW5YTN8tH6oZipYVhuc5JUzLnNiaqPYVGvQL0
	pLvx/MrkK3vYxHMy8nkHLLZFR1sNPltqfT9i++zpNU1DtvuKd7h21WjMj91A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790885503; x=1790971903; bh=8Nh1Xe2+lpNfojzVtQ+hd9qUqMdyx2t1y8D
	8EBWtxNQ=; b=gwzKbGFjaqGMBLGbIdQF1x5AoeVSSDhTHIg8kfMtW82nyC+D5lf
	5xahJvrDHP72JhIvy8xIiRT7f7yXiz1vpYVjjCHCuiGfs4aMP3jR8x6+3kUD9R2K
	utz4D6QeQO51QmVznI5LleMoXDjT1fXYdmylkizzpyMxHcdr2abjlqkoP0Fffqw7
	FAiGa/1qRFQ3zIjPU1IrnlNQhKQJswUAAkd0ytSVt2GkFDu4gYG0j2U8ktUPbDg6
	cWuGIOrfB/aBweiR9R41Ncsb035Xd+brMfcrpYoJXldstfq7WRMi5/jw5gwxz87O
	aEmG87bmvRDIefyzlCZ1t6F8FLyfP6K/sAg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1790885503; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:oPJkE0WYaTxszytTnIoV0zkYrBbyaCI+QeAgsj0f24Mfvv2
	XO8CYEESZxr3U5qeLlrkRHMHEWS/xM5RDN4gsQT6c7PZnSmvPmqs7k6dyNnEX5f2
	/fiwekNFpnOdtkWn19gJ4YTheYAwdg07ohE0Dgh0WLJyj5lYQpfeSZuov5iGMCG0
	If+HVAUvL0BRuqefmmDXXmlBIu+uVd0XMsl8mgwhv5elE2GFNUuGbBInxSzfpzG8
	yFOs+gFBzU0GrRNXtxG9eb4EqkNGXwZ+l+H106BUTnCJRXNzhtWq//qawGyTsLuc
	OUa1UJkuVuTdZvhqkmMet/kvJLJgp5cIhb0ox7w==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:Cn6IH7bQFZEXWhdNe54ifSMyp+w3dO1rfgRjlS2YbqE=:UW5UUeVBiHw+AXY4qICGMeaYkAXnCZuo0NT34bDEauY=;
X-ME-Sender: <xms:f76-amd-6UNNE8PDSWxpGucjuc6GBE1skznO6_hKymbBJIqSFPWhlw>
    <xme:f76-aoq2stMnubUvQhXDG7nJnnmmE9sHAKxF6AelKcNBLJ3Of52a-vzEwkrjBvObN
    OXQOtkQ1ln4SZEDjQGuugpmY5AM97dIpOC141yLSqj6cakd3_f5B-A>
X-ME-Received: <xmr:f76-an8kPYqTfx2XXGlOcq5GI6-pNXznjgT0F-2E37Fob0JtNycg-gIxmSsJWTLkfxNOIQOvKEa8xSb-GHzTTuTQ8_TFy7uXzakU>
X-ME-Proxy-Cause: dmFkZTGNr3oH8T7oQKPk3oceqkV+wsZF/F5ihLPavvZUWLTdP3dF/DYfr7PYsM9yWlqCvo
    YwGzMtLq0yIx+PXUZf8sSCXSS60eKNZtZsEcfw3JiSD1jtngB4fRhZ+bf/me4nZULmvvnZ
    rPrTimMBwro5I3bdtF+AOnl3M56iyMy1hKdmgdT+ZHQ6FuyiLXyhL1/D15vg7MTqoj/fut
    6/7JiD8SWTvThtR/w7ngQsVSFL7cQSK79qHKIDkzZTCawfixD/vkZK9alyoMmvivlW0S9N
    yePe3nCSxTcjzOD9JMSKBWLjGV00HkTOZniRf0/QlsuLuoeuwy15TIpXTgiDX5rwDJ5Ys3
    SfIKTrculsw0t74NvAqfJZ36yikywlAlEyqr+qy13zsFUiG+ldBHl+V8L+ylXF3sN/3zb4
    3W4Gi7+vMr6kM+0mKQaISffoJvkJz4o5EwDrnJN2+SQxehgC8V0JK+LLO6UGHugXEJ5MIz
    5vYfcPqc4QmfeGNpNfGdFQmRJSHn/+RAhk+mnk14CVbeN+7D6N77wNOQi3q38e4NafYc/p
    A4NLvx7gcApX8kk7jc5VeJR1DfTnXJkWg5qTJfDM9NuUGmM+QGYaNgWel3Dv0ET6uDQPPz
    RQLjh75rDa8i3pJOS1WwbtQx83JGQdeAPfiRNM5+Ad8lWsM2BwAxpTXawMwQ
X-ME-Proxy: <xmx:f76-akdzXPgGJrv5_fgvkxgZzLTH4A3tgsvRNCjMso3OTkAN4TrN7Q>
    <xmx:f76-ahL-kjXYpxr9UI-QaHbeP85Wby1DX7OD6tW2Dj1-GwmwaaypqA>
    <xmx:f76-akjQesJkOSXwWA4TflmbX5OstCTJf3z78gZR_pzwvEPSSDamKw>
    <xmx:f76-avRimZa2WasdCkUo_nJ823l5MXzkLPmpMln2H6GqLNJFqjCpoQ>
    <xmx:f76-asB8IfB59evsNsbZekXQIQ4RVV5K6_tM_IZl8XAL4_hC0P3lVdSy>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 Oct 2026 16:11:43 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Ben Knoble <ben.knoble@gmail.com>,  Harald Nordgren
 <haraldnordgren@gmail.com>
Subject: Re: [PATCH v4 2/2] ci: point test failures and fixed known
 breakages at their file and line
In-Reply-To: <0e0972b7-65a2-46ce-84a9-7e403620802a@gmail.com> (Phillip Wood's
	message of "Thu, 1 Oct 2026 20:49:08 +0100")
References: <pull.2419.git.git.1790362443893.gitgitgadget@gmail.com>
	<pull.2419.v4.git.git.1790880255.gitgitgadget@gmail.com>
	<8ec2b53d8265e1219b5f1279cadda2ac44c96ae0.1790880255.git.gitgitgadget@gmail.com>
	<0e0972b7-65a2-46ce-84a9-7e403620802a@gmail.com>
Date: Thu, 01 Oct 2026 13:11:41 -0700
Message-ID: <xmqqld8h41vm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> Hi Harald
>
> On 01/10/2026 19:44, Harald Nordgren via GitGitGadget wrote:
>> From: Harald Nordgren <haraldnordgren@gmail.com>
>> 
>> A test failure or a fixed known breakage gets an annotation that names
>> the test but says nothing about where it's defined, so a reviewer has
>> to search the script by hand to find it.
>
> I'm afraid I'm still not clear what this does in practical terms. What 
> appears in the test output that the user sees that didn't before?
>
>> Find the line a test is defined on by searching the script for its
>> description as a fixed string, using the first match. Fall back to
>> line 1 when the description is not found verbatim, which happens when
>> a test builds its description at runtime instead of writing it out
>> literally.

I agree this is still hard to read.  My interpretation of the above
is

    We only say "the t1234 script failed" (in the first paragraph
    that makes an observation of the status quo), and we try to find
    the test_expect_success block and show it as the finer-grained
    clue (the second paragraph).

but that may be way off the mark.

>> A GitHub annotation is a single line, so a `%` in a test description
>> has to be percent-encoded as `%25`, or GitHub misreads it as its own
>> escape sequence. for-each-ref's format atoms use plenty of them, e.g.
>> `%(raw)`.
>
> That's a useful example of why we want to escape the output which makes 
> it all the more puzzling that we don't escape the existing annotations 
> that I mentioned last time.
>
> Thanks
>
> Phillip

Thanks.

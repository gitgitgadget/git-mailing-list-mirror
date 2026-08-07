Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 925EF34E766
	for <git@vger.kernel.org>; Fri,  7 Aug 2026 15:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786117844; cv=none; b=hCOG4zmvj5F/cv5ggtpObD3DRCJKvbCLRtZhpkoEWTMSacSwRBDYOdK1YJQnlb/xU0Vuw+EPyt4WAp1K18z2v7wVpkS273NO0t5kew3vKwH2+xyWpUJN/xH+1hJt8sFKfS31pyFRpUGA38YlyVIDlzSNjN8v7oAFWwG7bw7FDKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786117844; c=relaxed/simple;
	bh=J3/Nl+/43rtG345T0mXhSFBWELW42B8RZj/NEMAe6so=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eJU2pRjATYtSc2PnBLAjj6ppWfEYML1WoHIT0ajNs8lhJ33TWpe3tTfp2MewOrg40nCXdXwg9NEfxqE+VXs56C1QgZzt4Hub/VEa3Dybo1DspqydGOUHDFriOs0zn0f8rzoQT+n+8XRgdEoIO/dMCOE6k88TIC3wMsfeGS3/NAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=B1wFpioe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jW6d/eGX; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="B1wFpioe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jW6d/eGX"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id B1A621D000DB;
	Fri,  7 Aug 2026 11:50:41 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Fri, 07 Aug 2026 11:50:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1786117841; x=1786204241; bh=ZaZZKyuxKo
	Y64uE+Fm2vEA8FR5vgHmqZ0EOjvXADl4U=; b=B1wFpioeNUJBzhCElWVGQqgmLk
	SwT/I4YW48/wzT9nQKOXeshnGWQ/O7LH3p59+OYRp93FHE67WPqjHlhSTDwKChrX
	67+6XsF91QBykzPdogcuiYGwr2Mivy7UQnM1a0PoyZmoYjbo9un6sGyWhUYoq9Ha
	fhFUQan0rjOP2hIKkT/NK1EUUHQ1282GaDBpkE0EeBg8gedDZzP4OzMCCmp5Sx5y
	43nNBp2mpmVywLgwFyoovQxKfKGOYy+acppOVi/EvU11/rGgPWucqmvvn5ZJK8Yb
	3PNdc+17e4AT+ar0xFGorSHLkeT8E8QRd5c0m0o3Olddjtk2ZxuhInk2E4ZA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1786117841; x=1786204241; bh=ZaZZKyuxKoY64uE+Fm2vEA8FR5vgHmqZ0EO
	jvXADl4U=; b=jW6d/eGXzWJ8jcDbMUK/pfXSWW0EKlMIgbvbcqKZPq3EXJUI+VZ
	bAql1ckgnHmkHZGxr2BpKZS2C/VzZ2uuTuJvwxPSikFEsIcfCPjjxMTquSZMd0Ib
	fQLnV+2idTU5GDXZAJb0TJy9pg9iHkZO5q8thBDQpqoIJaUPBITs14oPqsI5SN/t
	EhLu1jDn8iIbfKtarD6ud8BvMR9AMYIzfmUSxRz6Lds9qYYTue6zRK6B7nuy11UA
	590zwimye5dM/McET9cGsFARHFx4W2MhZYIu5w4adTCcqVCiYrJS8GyUgb5YMV+n
	CysOQK8fFqHqoVvLKMwjh5GM2+2YvtlNHiw==
X-ME-Sender: <xms:0f51asynZoUJ1pf3pYFbsjL_Ux5eHy5d22GFJSesGePtW23xNSHyrw>
    <xme:0f51aj_795awmKn1IKwW8vvTXGITbofLbZjWgAYcAo3EYehS7rHrZJgpbiM4p0Ioe
    kZDkvijFpbcmk9tfpmC-GOycWtRF75ZCMN9lXhg4KIJWrxsoAttnw>
X-ME-Received: <xmr:0f51aoLuJ5wmfC9FhC4nrjsdOFRBhwSUchmv4tQqhmvtDmHsNlTZZovJwsr9MlTviEsv4WZVqOoEN4psZCdsWBaPeLVArKt2Dw>
X-ME-Proxy-Cause: dmFkZTGLBzilrc34VJZkSsCVF1uureP9zDgy3LCxt6oVSaZwIM2fY6UHFEDaAOg3OsgZ/W
    KNjKAkfw13YV06aLY8Pv22IJTsBDFWaGzOKPG1lihijhdKIlK/ROgm86XOK69ctz+pYawu
    WxLxnJtA27TuLpTvqs7XEBMM87BpY+qDNndx5Jq0C50610/8ZvQXT+k4GK8tJfaZPii5km
    MxXvRJlPvDAamhUnOyL6BmAa29eYKfp5sjFjPDj0qOd6ph6VbJaYc1IO3dGQVtnJsM0z0H
    2wGMTZ72nt3zPWJShWU3LEJgwCt4OP6xENf0PUcyUojX4wpm/iYBHwpTJ0bQUf7nJdW6ZL
    ajptBSRTGkM4Ts8fQiK2zerimNzaUs0cmzf9FasrlbnZf7IWlSBaR7oSZOoxxNhaIxaLBo
    kXvF3mdwoKENRz5nMR/NCmPiOyhpb4Y/Af1W9zTzalsAn/szLGQZCEQzRMSASj+hWXLGl+
    7QAIYofxzehaeN6gAIwyd2jJFezZ2IbtZZ1WOFtyeMNAPRxCk6cjKIY2A3i79V+R2GGZWi
    DS4sMJw0V0mnnCguJpm27rlhyggyrkOLwxjLNeR6pWwtE38gUDV1t+8Q5OA9Baae7AoqDr
    /3rsrdnMgFaC8VEf7LzRZqNQvpO9PriOzGfIciVciSX8BY04rO8mPTd5EnDA
X-ME-Proxy: <xmx:0f51ahfJDt2qsgpJOwqJ_I086Hj0gnRPobP8iTCsgr6qMoU7o6tWzw>
    <xmx:0f51av8XoCGuugswqmRbhz09chVoIsezJKbMsVzXCjaiQpNG1-wcww>
    <xmx:0f51ampw_fa9Cq1RZm19F-OAXJCqCPGaG2xnBC4gvMoVu07eoTDSNg>
    <xmx:0f51asCPqHib4vL6PFJcu9SSBkJoo8hVPWrmNqeWR13viJapTj71MA>
    <xmx:0f51ahhN2RrzG85X0N0e1GAT38F8Ve8dmdxupFgfgdaSDO8AmTICD5Kl>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Aug 2026 11:50:41 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Christian Couder
 <christian.couder@gmail.com>,  "schacon@gmail.com" <schacon@gmail.com>
Subject: Re: Can we do better than "git checkout/add -p"
In-Reply-To: <CALnO6CBu8ZBDk9YwLW2jVJtBUk1=pvai5QHiLN6XLOOL-3KA=g@mail.gmail.com>
	(D. Ben Knoble's message of "Fri, 7 Aug 2026 07:24:45 -0400")
References: <xmqq8q6ih924.fsf@gitster.g>
	<CALnO6CBu8ZBDk9YwLW2jVJtBUk1=pvai5QHiLN6XLOOL-3KA=g@mail.gmail.com>
Date: Fri, 07 Aug 2026 08:50:39 -0700
Message-ID: <xmqqfr0qexps.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"D. Ben Knoble" <ben.knoble@gmail.com> writes:

> I raise this as the kind of interface we could learn from: emulating
> it might be a bit heavier (a full TUI?), but is certainly more
> convenient to use than the prompt-loop over hunks.

Yes, the 'one hunk at a time' model was easy to implement and start
using, but its limitations are apparent.  Users want to be able to
jump around, starting in the middle and returning to the top later,
for example.

It is more or less orthogonal to the reason I started this
discussion, though, which is that limiting the direction in which
modifications flow restricts the workflow, burdens the user, and
makes the process error-prone.

When I see a hunk, I can immediately tell if it is one of three
kinds (i.e., those we want to add, those we want to leave in the
working tree, and those we want to discard from the working tree).
But with 'git add -p' (especially with the original version of the
feature, before the 'e' (edit) command was introduced), the third
kind must be treated the same way as the second.  Then, after I am
done with 'git add -p', I must go through the remaining hunks, sift
them into two categories (those we want to keep in the working tree
and those we want to discard), and run 'git checkout -p' to deal
with the latter.

We should be able to improve this workflow without deviating from
the 'one hunk at a time' model.

Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD2227FB1C
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 22:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792015705; cv=none; b=HhUmNKLrkuqF9cmauOKO1Jbr0U6kfEtis+I99S9O2w0idFca8uCH9Wh67MUXu36svp2q15Qqw+mjJx39TC0PZK69U+aOwgZxzCRrp/s6JyxghBlZfp9259WXl/Etj8IgGWTIngVMgLVWhCeKzfpSrXIM9nTPxcLcMgvoDvHxWPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792015705; c=relaxed/simple;
	bh=UyW3lxGpGFEjz19m6HpvgihQAjEuYMJWJUwso9ynw1Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=upUTfHhv69Tszat5VCxWdRo3srGwEPy/MhWLGEu0xUB9wSOhQcS7v3xP0Zrs+1slSyCTKffMFpAOVVIjF68Q3JWhINPh2gld+hBJVeAzvUaYNEi26oB6/0IM9b3DFatcF4shUsSE3r9J0G+DPZysvO9m3Nnep6hg8tupVVZUMYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=PVnOGhfy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lnPYCSHv; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="PVnOGhfy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lnPYCSHv"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 6627BEC01D4
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 18:08:23 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Wed, 14 Oct 2026 18:08:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1792015703; x=1792102103; bh=L/rfTqx6no
	VlN4Kup2VBSPTfGgt1QQWrobhqNQE25XU=; b=PVnOGhfyJmD7kWd18TQ6+/0UV/
	t6nRET7APTHGo2UogeE9e2nrM7NPu0ScziqooSrE9sPnfj6KuEM28S8VDP0xHYGp
	zI49Wlfy3rHD6DL+Z0ntcVX9PasIjgQGCkcwc5AXru0YYz22mySW/659CjVpdWNc
	uvvFbyO53ndCbYI1ucpb5aHJsbsOQjYRVbHW7xSCaPLc93T7LBBNzr3IFPbUd+aK
	B405pggumIUTbD92gyy/DsoJ35gCYvu9IDIP4GzUsdA6AuzOC7inmeMfML9zvb2n
	Ow8LBFW3fw/mGk9IvjmpNMzSi50k9/HvHqzEYJOhh0RehmYhDO1kHW2fu3/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792015703; x=1792102103; bh=L/rfTqx6noVlN4Kup2VBSPTfGgt1QQWrobh
	qNQE25XU=; b=lnPYCSHvjCg5V9Y/7f1Sz02N6DLccMnjA7nCY9z/+IWT+Sq7toR
	FQ4rOFx868fjoSjirgFx+aGZxjYIPg9GVp+ogEoWAhKhQ+N0OGqbNV6y+9fuMUYe
	mzZqw40uh4w4Rzz8lurI3SavPnV/WMaVGudviftdon40iCTfnTgT+NLwsDIUhWLt
	sfgpzjSWT7Umm9nqYENNW7sPhgM2b5Ru9s8WgFZ9kul5xgjD6azv4sa42PejE4i/
	GkkwiXUUoWoNpL8jxgPlFCA0kTRpTB3I4o8810Bt8A6BeglcpWKFWi7G9SAJaP2k
	nPoLWRptZm3WsaaSjN84Elz5l2FytASpa3g==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792015703; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:oP4Ihc9bI3rSuTPu2fKNoykEJUE09tQJMDrQwjzMbhXQbNI
	RnzvkpGUJpwaZd+jcWrieKdWDrMAWh7YGBskwZ/GfcOhhFT2pP+TjfuNfkSutcuq
	jZuCoECOM0f0hQnIASX+O5v3rvrsv9v7QSVNE6817VgpZmo/2CKgNl0IjAZbprp1
	CI1ya9Q0EHVZtEjvitjM4F8bazueu/qC/Lr2gcc8gKv9K/HmnrkOvreiRpS1cxsb
	fy4DOfr4uKYM6aUm1ziN8S/Q2oO6A/GylMC57HdVFZ5411AOKiQILcJLR22FHp4x
	+1F3Y0RqN+qddYopCPKYFgVc+gIIHzl51MqjSuQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:wLbop9nP7ueNhfPQhswkfsbhsm0zpld29cEGYMXIrM8=:UyW3lxGpGFEjz19m6HpvgihQAjEuYMJWJUwso9ynw1Y=;
X-ME-Sender: <xms:V_3Pavwka7Fq4M5e2F5BpLv6B3_5IM82tGAJXxLuyv9ZE5CEwIrdmg>
    <xme:V_3Papgr92w4ZjIeBc0J1lnLXvyJt4a2gbPjoiaEAVvsklwNHMxhanXKbdAZS0U-i
    Ht5d-y8KTycqKXbvHM8Sryla1CvcKWwaETfSvLCHBxiMVgcHc6ibw>
X-ME-Received: <xmr:V_3Parn7y2EZpAZGHWe1KZ4fXNve9GYqLgmEDwj8gCiJO6Eoi1AiCUbDo3ABW9OvCErhFFnbhyDrzzBT2PIrleOIfWQiq9PnNBUo>
X-ME-Proxy-Cause: dmFkZTFk/lVagqE8MQMIwpJqqMdHKrKHFggJDKIji8wfb7yyN0KjADFh0cSJO70NGXZapZ
    4TuYLIdA+sU2Yk9OT/TTqusB8tNZiwnhGWVju2rG3CVjhRY2EhtA0MbIE/I7oCtmY11fnQ
    f8wVJGIqw05UAzrEXD7VRLufiJGnJrWWmd16PHGrBnTEV25hMAJThDsYSlyAESPiLbI7LC
    71Dr852nUt/MAvyVYgjSxTxhJU4Zslo6kAmBX++MeJIV6FG1lYh/8VSyIILuMK+oeAA7NL
    bg1gxOFbm7MGOJn/z5FMcDeC4LEqKwKj7kOhBGOdwL0KMLin1MurpYDWPsSrQqJalxSdK1
    gLHk0HaX9FMUZf5DIn0VXNI9S4YgtjPK9uXHGwHU7wiQYAO/pVUM5aD/x2/AE2Iy+0mwVR
    DlsJ/Ay/6f91+tG3e31R5Ew2vJBcLKupvGta+Wi8PkRPP288c5YsPNLOYdB6SdfoLw+1QC
    bgM9D8p/Q+cAZlbqu51WIzlU+cQgK5nqUcPETcTURbKUXkXcamMUTAYtiaFusCFYgXD4k5
    mDVjgDeT9rpphuP5htxCvMwzUxg0b+K69QHdacDSmfElt3vWG6HfL1c1Opmw76PP6NQjdQ
    VnxA5bIZ0fb8s9zfu5qocU2gFd/BgaRxiHaDWy1ctzLuh3n+0K4SrHx9MwIg
X-ME-Proxy: <xmx:V_3PavjRPfOubukuKVsKZmDth-RjEHjA9Uam2giIfLJF7HMzmJSy2w>
    <xmx:V_3Pav0KTATUooYq2Y5161torR9-BT4DOYAXgW6hnYN1MlJe2CwAHQ>
    <xmx:V_3PaoJbyf-H-Txpk3xzUTuPQ5NpGI0jCJl2oNSAdZThoIJjIaE2IA>
    <xmx:V_3PavwdpVyuYiYl6pzctzD9JJQlIXgT63Dxxm1oE1FlxchQCDP3DQ>
    <xmx:V_3ParmSHGOvp_C9enX50U1pUzHfx9HSwZycIdllq3sdqg9OvGTFmR9x>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Oct 2026 18:08:22 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Julia Evans" <julia@jvns.ca>
Cc: "Julia Evans" <gitgitgadget@gmail.com>,  git@vger.kernel.org,  "Patrick
 Steinhardt" <ps@pks.im>,  "Jeff King" <peff@peff.net>,  "D. Ben Knoble"
 <ben.knoble@gmail.com>
Subject: Re: [PATCH v3 1/6] doc: add new gitmergeconflicts man page
In-Reply-To: <89df0444-1447-4267-9e28-bc4dc70b0478@app.fastmail.com> (Julia
	Evans's message of "Wed, 14 Oct 2026 15:24:13 -0400")
References: <pull.2237.git.1790261062.gitgitgadget@gmail.com>
	<pull.2237.v3.git.1791816795.gitgitgadget@gmail.com>
	<7aa0ae7ec3c1d02aa1533c27fa40f4815c03ba6e.1791816795.git.gitgitgadget@gmail.com>
	<xmqqwlrm7pii.fsf@gitster.g>
	<89df0444-1447-4267-9e28-bc4dc70b0478@app.fastmail.com>
Date: Wed, 14 Oct 2026 15:08:21 -0700
Message-ID: <xmqqv774orze.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Julia Evans" <julia@jvns.ca> writes:

>> I do not know "because it's awkward" is a good justification,
>> though.  "awkward" why?
>
> It's because `apply` and `am` can also apply patches, and that's a whole
> separate topic than explaining the 3-way merge. I think explaining the
> difference between applying a patch and doing a 3-way merge could
> be interesting to do in the future but this is already quite a big patch
> series.

I do not quite follow.  "apply -3" is making a 3-way merge among the
state _your_ working tree is in, the state shown as the preimage in
the patch (i.e., before the patch author had the change they gave
you in the patch), and the state shown as the postimage in the patch
(i.e., after the patch author made the change).

It is no different from the case where cherry-picking the change the
patch author had stopped in conflict if (1) the machinery did find
the necessary preimage blobs and (2) the 3way application did stop
in a conflict.

>> I however agree that it is better to avoid appearing to be complete
>> and leaving others (including future ones we add) with "any other
>> command that does a merge" as this round of document gives.

Thanks.

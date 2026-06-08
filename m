Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62756377016
	for <git@vger.kernel.org>; Mon,  8 Jun 2026 12:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780920396; cv=none; b=YYxJ/EDqPZLrtlzahPkkoflpUjWl5lpZWe4RRo540dTwU1Wi9kq4Q+kAGECS/28cEOw509FxdkqVkzevQyE2oP1bEDfFRpGxKKNx72RIRpIxXcCXTDH+tE9wG1IllCc9yMJRyu3ogB11bUyJzpDs+AAnwKvBdonjGfZdPc29jdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780920396; c=relaxed/simple;
	bh=Ez8PeGV3qrVsjRknIVdbiQbsRYVrwrpYrN/UrBHqTck=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=i5PairDmPCf08gcGzIbSQi1JTPu8fPtsI0ecCb1QSK6jhhUpBsHrTrbaSBHl7awnpfmez6JAlcqz/H+jsCmrZLXizVbKIcz1IjEU2G1cAt07Bdz7wdpTA7MX5e/Ub27POV61QrqXUnEX0cf88RYxeRPecHXSLdUfp99dDlMAI7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=OjCLXC53; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eSzQPPFz; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="OjCLXC53";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eSzQPPFz"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id BF0E6EC01F7;
	Mon,  8 Jun 2026 08:06:34 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-08.internal (MEProxy); Mon, 08 Jun 2026 08:06:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1780920394; x=1781006794; bh=FhRUF9K1AX
	58tE0sXoTFpLxHna4DaSRdqQcQ9OJtzLo=; b=OjCLXC53fkb1/2r8I2JfG3GU/j
	aWdjKx8hqXlc3nYXIgwqCrhOiL0wi9pm2oUZ5+uA388xwS1XC71haFUY1dfbR1Sr
	Kxx14/OkzyzButpZGKcn26A9eNXCbqMlxRkgPMGToK5THRs8C6F6D+vG+4hja3mi
	0xO3I3XtfMNY3ulDMpqfhqkJP5op08LhypORJTKTegZdtWVr+c3gvDr1ISH5/3cQ
	xCvoMxc/MPK7145gZiSiS51tL+9iZsnxw39vD2UFMMukbEabIhwjSI7ZJyFdaR9I
	Dx0cqva62W1bWp1ZHmSJ4EVlhfccKYCHScZ7EKVQH0pAoOITrSjyBaCn0Udg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1780920394; x=1781006794; bh=FhRUF9K1AX58tE0sXoTFpLxHna4DaSRdqQc
	Q9OJtzLo=; b=eSzQPPFz/YnT//GoW1WrkFkugs/lxs/vBsQ8NBPSU2L5wNixokv
	WighCVQQzvhAt2Roc8jsKSesMyVvIWYERHL0dSopOC+0BToCWioKLIE5DldOORYU
	sD2OAtW0wpaWqAjEVx7W6Cew3VEvP/xWJxCO9WC9Cnw9ks7Q6YqfywlXThEXGlHv
	Gcled+5xTHCUt9HdlWucVoHWD1bL9LGJ0WRP/NMzbANJy4l4vEfvqavd1wgvtKtV
	GcEdXUut94YWME0WTbgpYtlQws6ss29SIxoLZQFFbsLBjvhw4rYMwKMrXOhVlivt
	h5zXZ8CXWbDTQr/gut1KIO5c95SqRG9PlSA==
X-ME-Sender: <xms:SrAmag2cX8dyqg64fYvr9FdmMaSXdY4su3EQxSWZXVQFtp8GXIsI7Q>
    <xme:SrAmah8GEgfxXsW1T4lTK7fBhG0o_y17U33fc77MdlewFJB4y23jlmAsSEroEy_Q9
    PBIGeMLX07m1Hf9e2DrOmJbmofj1Bd_OQT5eMAAJcWCcPc771txzg>
X-ME-Received: <xmr:SrAmahMI013JagD73Mh8Bu4VOD5O8VbtWIkfZcgn5DjqR9DHtThigb4OhtvEMPraHJtXqpctcvoU54nvInBn0eA3UByr48nhCLTB>
X-ME-Proxy-Cause: dmFkZTFFtTdmF6+7+Tdxr6BsnR883K87BZcRfxUGaedsOpGyK92HCBoHLlMnzVFYSmoIk4
    wfgPtUygJeBSorcWR73zWR5rz8+dagrkP3Wucg3TtlE0ljeHT/kPTe9Cau1GzJFI3gJwQj
    ppxrkPUaXEr5A+TEZWWsN38dwjzoeY/VrKXSA2udniic+cld84lKq78hGEfAhEYLPjEOKw
    L2JpeOaRsgmNRlZW/pikJuFD0PzOXF1bFVR7UD6duVOwLO1Zjr1StskFEDRZJAItmWfV6g
    W2U/1VGnEOsGXrN52ZCRd7z1YC9tZZK35TPNq2vFzeBbfZh+30q7Y4lR5n6iVLlONDIZA8
    l+1JwXnopDZEgND/H0qa+NPs+dvew/7dNl0HHdvqoxYNtwWm6BlfXdh7ruVw2FEme+OgqQ
    Vxte+MzD7Lxbff/MIVSKY6TCX6ZlO2PnGS7I/nd3vRF5qf41unYKUWS51Yzme3OQry3cmi
    Zh0gWl4HFKLOa61xr9YdfW17aFS13OiqnAGAYEGBJw5N9zxkc/8WIrCrJ3J5WqslbKUbcU
    5j6f3HehzUgYiF4YW072UJCgFUEz1hUVm79pwNDEfdCPO4O00Jq+akhz+3MM0jAiclqZlO
    JIw5AQuH/GRQBFLc34qS7XEj58I5ozpXUw17egJxn5nG0yCMPfZnyGmV6iXQ
X-ME-Proxy: <xmx:SrAmalesQP1wbmZKmERfCasmeQn_RF89RR-jIcBPh8IuzhZ2kzSw_w>
    <xmx:SrAmagVIqXY8VEJypM-lGxEzbKaFNXS2ZQ5gegaBOTm-6iuomDuPUw>
    <xmx:SrAmatiBYFs1eTkouWkCKDST5dgzPUYgYSeV7qaUAg0C76zBmmzheQ>
    <xmx:SrAmav-gGPawYc9mA6Lnm5CKR451WryKV0aD4aELBKG_J2yhRyFfwQ>
    <xmx:SrAmaktBmt7omhxqlZmSHGFzP_UbvJcKScttCFTv4PHfg4qSGy-TIL0f>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Jun 2026 08:06:34 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,  Kristoffer
 Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH v3 0/8] setup: centralize object database creation
In-Reply-To: <CAOLa=ZQwVbLsOcajaxQwtkTPm=4St7EiGEEyL6_B0o3Tt1v1pw@mail.gmail.com>
	(Karthik Nayak's message of "Fri, 5 Jun 2026 09:16:00 -0500")
References: <20260521-b4-pks-setup-centralize-odb-creation-v1-0-f130d2a7e8ae@pks.im>
	<20260604-b4-pks-setup-centralize-odb-creation-v3-0-0691834f318a@pks.im>
	<CAOLa=ZQwVbLsOcajaxQwtkTPm=4St7EiGEEyL6_B0o3Tt1v1pw@mail.gmail.com>
Date: Mon, 08 Jun 2026 05:06:33 -0700
Message-ID: <xmqqzf15z16e.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthik Nayak <karthik.188@gmail.com> writes:

> Patrick Steinhardt <ps@pks.im> writes:
>
>> Hi,
>>
>> this small patch series refactors the logic for how we discover and
>> configure repositories. Most importantly, this involves the following
>> two steps:
>>
>>   1. We unify the logic to apply the repository format, which is
>>      currently open-coded across multiple sites. These sites have
>>      already diverged, where some repository extensions are not
>>      consistently applied.
>>
>>   2. We then centralize creation of the object database to happen at the
>>      same time we apply the repository format.
>>
>> The end result is that we apply the repository format exactly once, and
>> that's also the point in time where we can finalize the setup of the
>> repo's data structures as we know about all details of the repo at that
>> time. Ultimately, this makes it trivial to introduce the "objectStorage"
>> extension, even though that's not part of this patch series.
>> ...
>> 4:  81b92bca7f = 4:  b0d7c11fe6 repository: stop initializing the object database in `repo_set_gitdir()`
>> 5:  807fc56353 = 5:  d0af56fdae setup: stop creating the object database in `setup_git_env()`
>> 6:  96563ff99f = 6:  3e75c5b0a6 setup: stop initializing object database without repository
>> 7:  c14f45169c = 7:  50fa2fdb3c repository: stop reading loose object map twice on repo init
>> 8:  e67c6e66d6 = 8:  4dff9d1794 setup: construct object database in `apply_repository_format()`
>>
>
> The range-diff looks good and as expected. Thanks!

Thanks, both of you.  Let me mark the topic for 'next', then.

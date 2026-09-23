Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 412D13F86E0
	for <git@vger.kernel.org>; Wed, 23 Sep 2026 17:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790184803; cv=none; b=SajBkeS9AKSdALpfALEomJyzUuu1Dkes4byNGUzghHCSHJKo92zgYdphyKufc8lAas11ABOHJes8RGyEnvzjiq2mmxGT4IeIWVovJbSM0I3nVf7nwD4TYqSmL/ygsYehQ9iv1vghvDGxsE9QHCuL37fGzAlQqH1cvVN+ohC1HNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790184803; c=relaxed/simple;
	bh=88uQEhxVcRoVLGVFrkOoGcdlCbAXLL6QCDWTOodqsoU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=E6TpetycFIEi9viOnAxAg3vYFtmnsYKF4tkIdkujwsQLnNbcwVzfBZytvsbWcCo96e5c+pvapswbJUJFzBhqj2EtfSWKTa/IQvQhfdP7B+LPGGkV5X3xQWvCZLdGBC+L21vTvvYm47u72mfvG1Eb4G5On0Ds2+3tJgPrMo6PVlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=X9PTMIGq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=npqDbOGP; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="X9PTMIGq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="npqDbOGP"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6CE3A7A0124;
	Wed, 23 Sep 2026 13:33:21 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Wed, 23 Sep 2026 13:33:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1790184801; x=1790271201; bh=FJV82jYIv1
	QHbtgrCnIzre1NidZ8kMd6qwHsw0UehNs=; b=X9PTMIGqxOy5ZWsNhZwzEQK0eB
	YBYRXJwd5KyA8AxJfngWoWRylIKQhSQzffUKcrsWeaWHjJEpTDpp/Cu2c8hWfM/L
	JqhgwDNJO8DNo/ggNGhH5TJTe70YRC5OwG/4/ICoCDuaz6KKYruzODF+sCA1C2y3
	t/M7mLovfaBSr1qe7MAqQpzX4z4YdRhkxrrAuthBXM/8TtYox6Gx5Ef1ir6rHUed
	quWbIRjnoQJeKQPDe7Tb711QobNEy6ZLZA4TsXT0dFkjYgfrO2/Ve/KgCpC6Rwwq
	Vao+/7BT+ao9mGw/FIdZpfloWEzEEf4j/SY+gsl2h2VA1oAS4a4QVJtqpoEw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790184801; x=1790271201; bh=FJV82jYIv1QHbtgrCnIzre1NidZ8kMd6qwH
	sw0UehNs=; b=npqDbOGPWlbRhM4a6jiW1EemK6pSZpp2AzwRwynGuo59AlJWohQ
	gTC8pDt3hdc5rZpUT8STUhihT3O6qdwK9CBeZ5HbZ/02C2m8C1kt00dSPV37IWYL
	/nHIvBf72PPxMzwo1dKoA/UhQkq4wj4vnf3ZeEKTOkauH4Yb4JPWgi/iGEbMvgSW
	VlXygSC8/B8P8nwSDNnkLece8cfNSpLgdcrVF62kzQNZJlXQ9zXRxuXbS4H1tAjL
	lnC/RRxK0DD6vR9+KlAZIU2NPo1QFDXTKU+6iX0daFRGJFOHPcXTW9kLzgmPJyRw
	9poNKCAU8De9n0+VBKtuQVBuFpobFFPIejA==
X-ME-Sender: <xms:YQ20akgab2gzD7LCAFXtAZ4TwdNZmGqsnz4MoZD2fPAKsZdgE5El_w>
    <xme:YQ20aj7Hdw6fVeZgCYlymz7T92oOCaOb3x2LYDUTu3TRmMkdZKfVFJfMroKDr8tHw
    Kt-6tFkXofJJ31OvTCjF_r-_9hjZeIBSRTH0nA2wlFEQ-W7V9gMb0Q>
X-ME-Received: <xmr:YQ20akYcPNoaZSJlh6Azglpim3n0FU3wfx3Hf-mPXbNaxkJhP8ab6WlsWKh0G2bk8a84RWMP2e0-23nnqR2WIQ7RavG-p6lyxZmn>
X-ME-Proxy-Cause: dmFkZTG0i/lrlqjtSHoxh6cBwhcmAKSlK9QbjOMR/Qq5Wcqk1UvTYiPS6zkiVOyZOet6vC
    +eYRM31PhecAz2sxg1CIyodVxCpd3Ha+QCHhxA6JBoNctFYR2LI/+MbG3NjFLRMfUE/TGz
    J1n2oe4V7lTLi2rrd1QBgsHXFFwNywfMNJSHe8pLsFksFWRWNXI32MUqieE6xSI+KK+dRY
    ldH/Wv2jaeopRDbABc5jrQrJ5Ya3jtHn7YigBrjDa22gOK3l1JmfGCR8FtR/rPkPA7quB4
    tpYfl1vCKPMQNwKnHzy1QGG1CE8XSC7vScMSFfE0bpGY9EttjqgRFUa/a9gOpNJ+uNGdUJ
    QoFGBtAcIisChfwanNJTdN7UV//jmsjW3wtVId+uIRTYFhgHowmiMiKLBZbsKXknPzMHeY
    0PS76NvBZ4zcKMNR8I/OEZWjpxA/nuwdfaQtqdIaWYqJ+d43e6kFYo61x+meJ3JfbvevN/
    ULMG/yorkinM9RChFGf6nUSywnCyu+VOKuhkCVKZogdWkyWL3Pxpmr6R8tQ82Bh8KezE1c
    xt+jyLvOXxzUsL7zvn/eo+UGlllo8dRTn/HTaEUv/XMk2IldOGFe+zO1DSd/fRBzWuCKhE
    YGCgWZd+jZFQk3aNA/yMioQout9TN7M25N3RtH38W67Z2gkbdyMg2p2dk3ig
X-ME-Proxy: <xmx:YQ20ag4YKDe9skuxLJ6RwqPIuwg99j2LiEbANYn9cZcw_HbyGBh3Hg>
    <xmx:YQ20avCOrAcGsFOjHWFobBcweZfrWahZvSEK9jiIPIW1V_QO1hNLXw>
    <xmx:YQ20aufVIDY6EURX7JXiIXRhEEdN962pBGZj8g56Tnn33Pkcn46Qbw>
    <xmx:YQ20amLlVWWSqenf22innzqFbzDxgSFSZSThlL-L3vHv1aaT1_YNpg>
    <xmx:YQ20asLXge_6AUkoEUUKb-LHgwBL-4anOYP3U4OpnNoKH7nJsd6WhesI>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Sep 2026 13:33:20 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,  Elijah Newren
 <newren@gmail.com>
Subject: Re: [PATCH REGRESSION] builtin/rebase: allow user to amend
 committed conflicts again
In-Reply-To: <24cc4bcc-1d26-46f5-a502-ba673713f4f0@gmail.com> (Phillip Wood's
	message of "Wed, 23 Sep 2026 15:22:32 +0100")
References: <20260923-pks-rebase-conflict-bug-v1-1-3d3ccf5022bc@pks.im>
	<c12d2ac3-5263-4301-aa64-a311a343dd40@gmail.com>
	<24cc4bcc-1d26-46f5-a502-ba673713f4f0@gmail.com>
Date: Wed, 23 Sep 2026 10:33:19 -0700
Message-ID: <xmqqik3vc1pc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> On 23/09/2026 15:02, Phillip Wood wrote:
>> On 23/09/2026 14:16, Patrick Steinhardt wrote:
>>> Instead, use the existence of "MERGE_MSG" to figure out whether the user
>>> has already resolved and committed the conflict. It feels somewhat fishy
>>> to base our decisions on the existence of that particular file, as it
>>> really is only a proxy for what we are actually after. 
>> 
>> I think that's probably the best we can do. If, after committing a 
>> conflict resolution from "git rebase", the user runs a merge/cherry- 
>> pick/revert that has conflicts, then "MERGE_MSG" will also exist, but we 
>> don't want them to amend that case either so it should be fine.
>> 
>> The code changes look good,
>
> Let me rephrase that. The code changes look good for "git rebase", but 
> do we have a similar problem with "cherry-pick", "merge" and "revert"?
>
> Thanks

Now, would it be a -rc2 material to just revert the regressing
change out of the release and restart the effort post release?

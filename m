Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 700C61991CB
	for <git@vger.kernel.org>; Sat, 27 Jun 2026 20:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782593259; cv=none; b=NUOzGN09ceGXpXPyMGYZXNLrmelEWCbcuVc3kdln3jUhkRFxfLjlD7IZiNPyZ4zzyFBiqtu/HRV0B7CvMVPg+ouMRR9ihTinwSLrT2s07tMcjffKktpZRqjVFxKacf41x0qMUODM+urkOyG5mQfUBhf+6660Idv02yLgdTSb9Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782593259; c=relaxed/simple;
	bh=Hd3NyYwYfnEtnOpsx8eBUvpPIcX5hbnGNBXdq36DKW8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VQ1dFtfzdkPa0HHE1uc5DeqZaEfzDmMwvfDka+TtocqzB4oyZuiLeo0xQZqpIQqm2OmOOX4vvPi+R0R8mGKjWJXmNKemAphweuLSzfL7Rn4cxzQaCfNf5Rd3v3pHdvdvw7QJyUX+D1Ft5D3oeFUu5mHrhUGJutuxYDNOwI/3YQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=NZJxyFVD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TKLtwMZb; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="NZJxyFVD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TKLtwMZb"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B1D8514000DA;
	Sat, 27 Jun 2026 16:47:36 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Sat, 27 Jun 2026 16:47:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1782593256; x=1782679656; bh=sxeLUdOrQj
	LFtad/8LzsJCK031pCGIjxkWNF0MIb6/w=; b=NZJxyFVD3SdMjhoW55eXUUB7O+
	UyhP/w9vNPTYPxd/6e5Ipfjf9p0Xn7CwxAITcsRxeH/5lW1/pzReUyIvW2vt84Xf
	p0pEUrRNegL+8pYL3z/Rtzn/YZs84Ezb9BAN5U6OkoGgUEFECq4vjei2M4ZcYLL5
	YD3/Iq23M/qTTb81bSfG+KPRQTkmrWFwWe38LHdgHM+gbZCt/mh7glx++l0AGkmG
	PgapOnthi2D7bBU4a3wcmhy1AT7bPeilbrJ+BRV5CmBNF5djAjyM56umv9JcoWYB
	cGVHRGNdckUuiunhaxOPpyC7CYm/J0OBGWhiV0GNZiT28ZmhHR8MvIj6O2Jg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782593256; x=1782679656; bh=sxeLUdOrQjLFtad/8LzsJCK031pCGIjxkWN
	F0MIb6/w=; b=TKLtwMZblNvBOmp8y6Mwh/GzakMzs24z29HNPdrmqWdGwWMoNaf
	byWwnertnf6udplDo2VmBsoun4SvtjSbtnKLs1N44NGya0OooeLkga4V2p5EwqLh
	2KTP8AymGmr2dZi5h8VqgLH5gXdqZO0v9uSk15KeXjD59kcJJ8Ak4LTul7Dj8hEs
	k0VOxj3K+MdmWSQZ0KVsRFLEOH97c/QYqyJ2TDjRLgALU+eGb0hfSLwLbtT56hzE
	BhD1s3ILBkWgqf9wsUwtfRtQ6NURzRv48aWvXSvfsqK/bIDxJmTeJgEhqETms0GE
	gvaUHSSvYNky97DxyofaGRCv16YZyHAKhQg==
X-ME-Sender: <xms:6DZAanctZAP-Qd0c3uc6PYyMlqgCOBrpjPMd6xN64QQJFyhAgnNYAg>
    <xme:6DZAasRAnRwypI6HPpInhhCK_ZH3b8isH8k-A1pu0eak_GCXEWB5Qw6yMJoeJPJ7h
    XsflHEmCx_1j7o5fWtg-fAMFsmV1uvTvAmOksSoipnar998Gi6IXHw>
X-ME-Received: <xmr:6DZAamtpYbeIEswT910CnPcD9G9_PeI9A1bbljucFPTfkUPgAFhMUFvyvNqNVJq2FsP2YM6uTuoNwgYNS0JR9tiWs3Xin_kvfcdjLHg>
X-ME-Proxy-Cause: dmFkZTGbylt477Q4WH5vsjLr3q1bxxnH3US/TJFA2wKtztfAK+TJfRh6B9uYoBhwKGYkkM
    ZqkB87OQJNAOtQ0MbtiBkpVuUuYygAxdm4Se5M1W6yefclRPFPMopGmhpSCaUVMJlhhcAH
    bS/map3Bs42wDLIt4lLFYWrOFQXFMCMp0jymMpseUar546Fqi3m1fFfAzpJroFpuU+rQzE
    V3tilkE1HyvxIwIEU80WHLjVyu5HVLaSzQ8ckz6uakA8RlFilSLKZQX52NpaMvRSOesN8C
    zpfSgAdwS3m8VY/1W07Leji2K6BJ8rZtot/zXzXvFaJbqAb5Ib+GjSkL8GEASwK1Y815AW
    yY/3yGJFWsbGUOJYuaAGUSN6DQiBXFW4iA/8ifPSJdGh5z+ETv81p5+GT/T06PTYUmAHbq
    p71kiPJL+81RoCoZSYhj3zM1LomHuR7HF03zaAmkNirs/ZAyBcOy3U76FXvhb+G6kL57wx
    UMLaVLtFOr/bhR7eF+wyBoTDtTkAoxGyv34XPYSmKkSG2kmql6o5JHhwYZMyTHff/8WsDP
    rC8kMZiyhGzZq6rDTYyXE3Mn78g6X6BcLHpbc9gJTxg/IU8+oIcBKvEC+an6EdU2b389wN
    GAreuyevniEouPCXshu2+K/Fo3xR48gNMTeOChPu0x+a65Q7t2PltJOlkWQg
X-ME-Proxy: <xmx:6DZAalcivQZ4nECWQubl3lNLRZMiSQRMBO8Fp-uk12F-lvYFPm1czw>
    <xmx:6DZAaoZX1A1ztgsr03QKRtPifoo6G3TOwxruRCDftq3W4QBkWdcEXA>
    <xmx:6DZAavalS27n5m2CroET40pPC4XDajd0svOVnXkODiUwpSbkk3pvrg>
    <xmx:6DZAalL-28INMCvFqYkZOoQWt4K0teJWzKecfPkPjjdPWaS9I56fdQ>
    <xmx:6DZAamIUFnum2XnuMfFg-IGoW7tTl-b5nrSeWdusrEUHWWEWcLtgL1B8>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 27 Jun 2026 16:47:36 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Tian Yuchen <cat@malon.dev>
Cc: git@vger.kernel.org,  cirnovskyv@gmail.com,  szeder.dev@gmail.com,
  Christian Couder <christian.couder@gmail.com>,  Ayush Chandekar
 <ayu.chandekar@gmail.com>,  Olamide Caleb Bello <belkid98@gmail.com>
Subject: Re: [PATCH v4 1/1] environment: move excludes_file into
 repo_config_values
In-Reply-To: <04d1a7d5-ef83-4728-b816-5cdf1cb4aa25@malon.dev> (Tian Yuchen's
	message of "Sun, 28 Jun 2026 00:10:49 +0800")
References: <20260626075037.532164-1-cat@malon.dev>
	<20260627160813.1074201-1-cat@malon.dev>
	<20260627160813.1074201-2-cat@malon.dev>
	<04d1a7d5-ef83-4728-b816-5cdf1cb4aa25@malon.dev>
Date: Sat, 27 Jun 2026 13:47:34 -0700
Message-ID: <xmqqv7b34snt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Tian Yuchen <cat@malon.dev> writes:

> Hi all,
>
> Apologies again for the duplicate...
>
> On 6/28/26 00:08, Tian Yuchen wrote:
>
>> +const char *repo_excludes_file(struct repository *repo)
>> +{
>> +	if (!repo || !repo->initialized)
>> +		return NULL;

I might already have said this, but I am not sure why want to be as
loose as this code.  It is not limited to this line, but I think we
saw plenty of other "We know we must get an already initialized
thing here, and the subsequent operation we perform on that thing
will cause us to die() later, so let's return silently and early
to avoid hitting die()" attempts to sweep problems under the rug.

Wouldn't we rather want to try to be more strict and say

	if (!repo || !repo->initialized)
		BUG("repo must be an initialied repository");

here?  Aren't all the callers of this function supposed to be
dealing with an already initialized repository?


>> +	if (!repo_config_values(repo)->excludes_file)
>> +		repo_config_values(repo)->excludes_file = xdg_config_home("ignore");
>> +
>> +	return repo_config_values(repo)->excludes_file;
>> +}
>
> One more thing:
>
> I deliberately didn't write a comment for the getter because it will 
> probably be merged with comments from the previous several patches in 
> some form in the near future... I'm not sure if it would be more 
> appropriate to write a separate patch to add the corresponding comments 
> then.

That's very sensible.


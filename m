Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47BD9283FDD
	for <git@vger.kernel.org>; Mon,  8 Jun 2026 23:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780962997; cv=none; b=SGwierb5Ff3lh9Kc7sv1C+yFzfabxW7Bw4LA6XCRN+a73Qn5ihqZcQlLdYrwZgRTCwvZs6SiQd+FKH1Wg5D2DhvXoXWNA+9boGai2B2sNL4zb1zI9w/PBN1U0OrEbnjj2KtwCGnUadPCGGhuLUilPCGUR+0m5K6DVi/usDDXxOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780962997; c=relaxed/simple;
	bh=Q2kJQpCVcYHP1UkpUlTlE8sKv9P5tKBKEdB89Y+wRic=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dMC6sBVFIpnbuUCjrqlkVOO96c8bWXIWdrYuV8eUg/SikcbJ57VMGNMdOFHMKaVUKVHT8uezBXHRMatJ2GKhD0WjloPsIcz3Z9nv0EvVIdyfxxu9fusIvLOwgZouUN9ddq2skSGolflqbx4yXgHwZm2qoZ3uMkO3oqUFPUMWB0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=LtFDgXAi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VMJdVQvN; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="LtFDgXAi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VMJdVQvN"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 75A881D0011C;
	Mon,  8 Jun 2026 19:56:35 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Mon, 08 Jun 2026 19:56:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1780962995; x=1781049395; bh=i10amax7IE
	IeHvP7BmGH9CfBhXXbl/k3eCdYhZDBWTo=; b=LtFDgXAiiRcB9AArkt5xmT3CkY
	9zFEUyOac/lR+jrTaezbbhllFGPQpjpDovvB/+FCDQtjRsbx3eveAvcsVlhTpmBP
	QUWX0Pkg/lslQmTv8Yh5spmolHLNka+NddtWtgYjLAsOX52lIDpfuUhmnVX+zImD
	3Qu6ndCx3b1CPJslwQ5faADjcDtcJ5BjRhe2bGRS19Ei9s5hWNYBvsQcxn8tmi4M
	B2yyLQeus+WXwHWsTq95o/G8f3RLpZxDro+tzhYm+xESIcMw5ryshAEzaasEoVyt
	iUh3sKAx5n+L49w7Tsp6HNpx4kxVx8IIlSUtwQdowozHTWuzQla9tP1TvrKw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1780962995; x=1781049395; bh=i10amax7IEIeHvP7BmGH9CfBhXXbl/k3eCd
	YhZDBWTo=; b=VMJdVQvN3PTCgxdWs9coji7eI2F7+KXH5czGu+2V36WvrBdoDd5
	FHfX3W5m+/DbgjJFHqTP4FDHe7vPmFlmyPS9jAZgOESCllUS5k52YFD6kf1pCoH3
	VSYywfhfHvZHP7UmbeJrCuCcpBgwAFYoj0bqVSzw2Tbx2IAoS8BLizIWpi1QsD7E
	6liYvB4ROU8Y0f0ABVgUcNFKUKCmt1GcBu+ionS1W45C8Oor42Dh5JUGwLb1/DuQ
	qiBDuErV+84LE/WdcJblx+7tuWB2BJyTWLsYLBHTCbJD5a6vKqOw4lC4RR6bJAQz
	VTT5Z7KWX8BrLGoORmMv4QnSlC+rKscjbLg==
X-ME-Sender: <xms:slYnasqk-J51G_zh4PWthS1p2wRDiAt_DAXiWWaorsOFTZVDYboiLA>
    <xme:slYnapiMUEW2gWzBIHvC7n3_37fR6VESxfYO73dxYBhBIF273y_sLxicm-WHgO1yi
    BwllTWzXvbVTFvGEzBTSM3yUHgRMzO-rpkLItShMDV9NmbBH9vOzQ>
X-ME-Received: <xmr:slYnapj_zvAdDaJTLHGXWjuD0Gt-6ZYw5OcxI8gdrMey38mvrDgwan2UTo8SMGoAMnXrACS1K6abqVlYPAvfpitP9obvZX326VDk>
X-ME-Proxy-Cause: dmFkZTGjv4a/Bgu7uX9d3S9mVkzojJW24OpzCdHA7Y6Ip7GcNUpA6+or4rNIDW2XaYwslF
    RTdn385za49JyFN8aJ2AL7m8l19/+ykeCLDbsEba1NRnpQKTfU48EytBmgrXLMQY7psJ+a
    fBNrLHvVo1QcJmAwii2eWRWscs0t1+X/gcjwVm21/gsOOBZt1FQk2o1OW+Pyr0PKvNQjZX
    1xdJ25rsG41Gd9gR1dyAxyr2boK36miTn1CTIEQHue+jETvcDsvOEdy2d5BsXSor2zn+ob
    FF0TyHCX3HuOYyvXvxKJdqJtiACjwkourP2KOY66L8fABDvTrXrt9n7RV+INx6uK7carGQ
    ILoQQ4mQtMDw9HIWeERzf1ORaMXHXdI33Cx33xJpbmF8mF38wFSrVu5YZTf7St8tLNRTcc
    3TEkoK30YeAvOwn38EV/oRzgcYICKFjGUmG8oM3IUQtpyNB1mQduhQM1SOpD9Eh16kgZmt
    Ew3hq6X2QXzREY+z/crXJ6dsN3av5u/5jANnmYiijWXuQYmEWn/Tpy0Dk+8ju7i2Aue/mX
    UW8B5u8zPgKCjsBBBNI2yNj5SGJRwZ/kRGKK9PTfBCN2UyNjdenyUDtxazMF4Dx9mCEmcg
    vGsq5EKyzksl1AP/8mE9GV/oORBF7ZE+atTiPntPVuAgCWsmGpJHHhle0pdg
X-ME-Proxy: <xmx:slYnaviNhnckN-T1FTKQZ2AuQ5zQugBfXq0bDmhAsl1WySbcbEBcQw>
    <xmx:slYnapL_jO3Rtf0O_U5N3m0W1rKg7sWvC6SNjLOfb8IWDmuEQsBhBA>
    <xmx:slYnauFWOg2Y39BFir8Ci3e-1rJbb1pLrgqYK8ubi0omQP6NcR5ztw>
    <xmx:slYnatRripeLousrVbbcII45H9Kw713MVnbvAxq9yC32suZ6KBt5tQ>
    <xmx:s1Ynaj8DIkT5sKcM-jP-b4bI_qg6X-RQ-I_Xtttqd6swHjmIhYvY-27m>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Jun 2026 19:56:34 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Philip Oakley <philipoakley@iee.email>
Cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 0/6] Support hashing objects larger than 4GB on Windows
In-Reply-To: <4e3430a1-e8ee-47de-b6f0-25abafe3c45b@iee.email> (Philip Oakley's
	message of "Thu, 4 Jun 2026 22:56:04 +0100")
References: <pull.2138.git.1780593313.gitgitgadget@gmail.com>
	<4e3430a1-e8ee-47de-b6f0-25abafe3c45b@iee.email>
Date: Mon, 08 Jun 2026 16:56:33 -0700
Message-ID: <xmqq8q8ovb66.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Philip Oakley <philipoakley@iee.email> writes:

> On 04/06/2026 18:15, Johannes Schindelin via GitGitGadget wrote:
>> Philip Oakley has contributed these patches ~4.5 years ago, and they have
>> been carried in Git for Windows ever since.
>> 
>> Now that there are already other patch series flying around that try to
>> address various aspects about >4GB objects (which aren't handled well by Git
>> until it stops forcing unsigned long to do size_t's job), it seems a good
>> time to upstream these patches, too, at long last.
>
> Yay. I approve this message ;-)

While I very much appreciate the effort to switch to size_t where
appropriate (and the places we historically used ulong for size of
in-core memory region are the most appropriate places), such an old
series crashes with in-flight topics big time.  Can we get an update
on a more recent base?

No need to rush, as I'll be slowly processing the backlog to catch
up with the list traffic for a few days.

Thanks.

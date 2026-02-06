Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08460423175
	for <git@vger.kernel.org>; Fri,  6 Feb 2026 17:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770400227; cv=none; b=TMvOg1alyWBMVSYM3rneJe51MIARedwnCeYk+m/ijref/errB3SGAB5GibDUXNj62qCV9qDq3S2R2eMFAbL+IrQXRKPlKzGkPuXAdUZ2J8U4sJER30tv7yY2x/nqDnkmYVaA/wt3vSSL4dkGvrWtF1q8VCwd8cebuUbGTSh4aew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770400227; c=relaxed/simple;
	bh=dZ9K+4NCd4/i1Ji7NhkowztanSWrIVEC/1q6f0ylTj4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fCWSQ4n6FaxP/2yCMUcsA9UG3njZDVde085nb3qa7kEitodDBLhnQkTjASqLDsYsCNROYd97W+nXWDDXbCCK9kbGTGIYiUCUR5nFlD2Yq7PMXwj3r590bH1XQZrmLMXiSyuXbhwjI9shhiVg8v0BQCCFGOaZDqeyFa8JyVAr5fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=QS3DUn6o; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZyCjs+KL; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="QS3DUn6o";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZyCjs+KL"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 5BCF0EC05AB;
	Fri,  6 Feb 2026 12:50:26 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Fri, 06 Feb 2026 12:50:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1770400226; x=1770486626; bh=Hb9llcjZs2
	aU+kA8UfYq4WwgYcQaINam/+BPZok6kSU=; b=QS3DUn6oZQgLLJQ+3po45sQLmx
	Q6uNUXvW6G5F8GtDLgSE2ESY6B/lkup1uzEFNd3odHiLjctrSAZ4G/ZziAejLrJ4
	dMm77O6VYR/6c059JpMV+BnLIc4GpCIObtmDuPDl9VjdYCBLUhEFMr3Nx9NHydNR
	iNQFhQ5SmTeJeOJWMVaKw2yEehS/gOvQo3SX2mpQPQeh62ELUeWrSwu84S1PXbIU
	DYlUskYGejLiz+SENgdM2IaufsGaefmz8NcFAHNa0HJRm2hr/F1EGq6ONj0RnNNv
	jO5qGKZl5TZ9HkKXSAPPUWaoTfYEQPMn4Al/nQhMSHwWHa0oop3JvPJFD9PQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770400226; x=1770486626; bh=Hb9llcjZs2aU+kA8UfYq4WwgYcQaINam/+B
	PZok6kSU=; b=ZyCjs+KLvPleVdHX8o0REGdiN0fBeBz+xsUzT6Z+NrvcmzLKXXn
	5JM0FYHHjXUF0KT4NHEXDhXExvhhD3PrRxmQ++eOpEDFGa/zA8wZzx4TpuAlbrAB
	yoSvQTIUlJi3XC06rBea1pvI2AR75hW2HThWv3AAyAFIzaOPqz6i5dmFNz+5+TQk
	5OgYV7086BkuxC7iQeOvJOdSVMAXPuaEV637apm/UmcG+s5yoE1Lr2L5iynjiqvM
	UQMSXmcbJg7+PgToHuBVY/I1cSEG7tf1jU3XJV0fC9cePVbhQMpr6PHhcvyUK8iD
	J7m4V+utgaoaHluPIYjD0UQfm9snBm/h07A==
X-ME-Sender: <xms:4imGaQj93UIpb-aICo3m5xP3Nlco8atvoE9_FJ1jyWnFIV3rlAuWGw>
    <xme:4imGaf7SZjgksGubTwR4Oq4ZrOCyG6pb-vHKdqdwvRl7Q58MJmytEN2MthBp-2Rjo
    -entNmxjWB6Km8g834j9PXJ83tqgP1QgMezGh2drcCpfhNou25Uiw>
X-ME-Received: <xmr:4imGaQadks7cM85xzJpwgbxbUPBB7nKAeLRQzpg_gvLU0fGgd3vncqTzBv3-DhZm-LjCWGRcK6OCNl8W5mVb7TKw0SAaFlJ_NQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukeekkeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptdevleejtdduueeljeeugfeitefhteeltdefgeelheelleelhefgfeetkeeu
    ueejnecuffhomhgrihhnpehmshhgihgurdhlihhnkhenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpsh
    esphhkshdrihhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtgho
    mhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epjhhnrdgrvhhilhgrsehfrhgvvgdrfhhrpdhrtghpthhtohepghhithhsthgvrhesphho
    sghogidrtghomh
X-ME-Proxy: <xmx:4imGac5pqSj76CrHQKIwJhZlbaDzDS8i2zzRNRfADwjqAIDrbjP15Q>
    <xmx:4imGabDdLujBwYRTSZoi4itz_f1GNTIx8e3q0IWPneVIKl15m551yA>
    <xmx:4imGaafdXPmYu2vqlzOC-ilz-MwRJnbgbBFtME83N9SakgzuvWEwTw>
    <xmx:4imGaSKy2xmtwTqDVdpiwDwljLFSL4gzXRfhUwrExwY7dly4fnWUqg>
    <xmx:4imGaeURThRayl2F9s9DnVMgg_bs9oLo7sbesRZBP2UWsdziiUwuumUK>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Feb 2026 12:50:25 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Karthik Nayak <karthik.188@gmail.com>,  git@vger.kernel.org,
  =?utf-8?Q?Jean-No=C3=ABl?=
 Avila <jn.avila@free.fr>
Subject: Re: [PATCH v4 0/4] refs: allow setting the reference directory
In-Reply-To: <aYX7z_nUc4xJC8Qs@pks.im> (Patrick Steinhardt's message of "Fri,
	6 Feb 2026 15:33:51 +0100")
References: <20251119-kn-alternate-ref-dir-v1-0-4cf4a94c8bed@gmail.com>
	<20260202-kn-alternate-ref-dir-v4-0-3b30430411e3@gmail.com>
	<aYX7z_nUc4xJC8Qs@pks.im>
Date: Fri, 06 Feb 2026 09:50:24 -0800
Message-ID: <xmqqldh5g3rz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On Mon, Feb 02, 2026 at 01:26:29PM +0100, Karthik Nayak wrote:
>> Changes in v4:
>> - Mostly re-wrote the code to also support worktree. Now, the existing
>>   backends will store worktree references in 'ref_dir/worktrees/wt_id'
>>   and add corresponding stubs in 'git_dir/worktrees/wt_id'.
>> - We also support relative paths in the reference directories. These
>>   relative paths are resolved relative to the GIT_DIR.
>> - Link to v3: https://patch.msgid.link/20251201-kn-alternate-ref-dir-v3-0-c11b946bc2fa@gmail.com
>
> I've got some of comments, but almost all of them are just nits. I quite
> like the way this is shaping up.
>
> Thanks!
>
> Patrick

Looking good.  Thanks, both.

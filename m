Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB4F63C1400
	for <git@vger.kernel.org>; Sun, 26 Jul 2026 15:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785080586; cv=none; b=N5GYL7r7VAsGp/SM7/DQlY/jcVcDNpxraeoffUzOJhOuyAdXwF5Ia554IFZE3UVf8cB3Z6R+cVuzZRz1Zbo6CfTogB2eg4/DwnnQTq3wwguIJbP9uv3dxC88gCUz9b7UgykLCcYxthOhMKvX/PRIAYNz6HtvlOIIQW5qznV7GDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785080586; c=relaxed/simple;
	bh=UAQq9wm4FuRaOjMUlFB0A6AipFPK1Mm5llvAuiYJR2o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Z8DTm1l9z6XRIOUixnS7EpaWvgyqM+UM0PmM/WILYSpHrrSY5wNHD5XYolfIRCblDi4832dupitXjO8qwAfZOLquGuCpo3ZvVJBRvfoNGbKEcrYdLA8xmpFrkyekvb/0++IXtqc05uqITBaCiEviiSpTK2wXppmPxrxkmm6VG+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=x5yByLKP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=U20A3QVm; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="x5yByLKP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="U20A3QVm"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 05109EC03A7;
	Sun, 26 Jul 2026 11:43:00 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Sun, 26 Jul 2026 11:43:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1785080580;
	 x=1785166980; bh=6hxzciFxCpU1YmONJrjZtsWECI0AnWulS8sU0dSVVB4=; b=
	x5yByLKPDfBNC5SPwUlTRNRMgCdxwkcVYvmftnH9wK3I6hcryhp2lNX39VesnDsx
	RBzNK/wa3jLIRywODtNRbnGSj3nRkDNO9Vx19Ql3BPjoYgcjjGDCbtrMm1bjzU+J
	x8Y4H9I8DtUljbh6eV9E3qpS9Pd1j5RMbuQeYxYEGbpbxA/YyPOlzBEtVCYF/tsT
	TLSkxbrmUGv/wNaT2GEsBVuLTriJUcb50am+YlWsnI7XGsMre3qfoufvaCVfrln1
	7ZKt73hXo0xXOBD4ktC6KiaSpsVlJHg4btzF80iUJiFqNtHVsZnS+p7CsAqzIxQj
	VNaMZ98FO0TBmjLbCrdZHw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1785080580; x=
	1785166980; bh=6hxzciFxCpU1YmONJrjZtsWECI0AnWulS8sU0dSVVB4=; b=U
	20A3QVmXSOs7jvDXyT09NfyqWQpjkG1wfcKMf+PLtlJbSAowI1t5tjGUslEad51y
	rajSBtavLXmLJinJSN7M8w7Esob7Z5DIPMse66YTRYJs+d3a3qZBJiY4K9UtTP/t
	Twbl/7uv70eN5fTl1PajcIjosc7cCu3DQfov5L82otIJ0U/HH0A2K74Awpci3pFD
	pjSwT5yAW9e0yxsAnm9YXRFPKpRCfd9hK9JbB+MHf64hmOvqF4ZokNpEHaxvu4En
	R5GfT4k1+Dgl42YZLDf+4rQc5FvPC6R2rzK38fYp+9Yj1qZyxhdLF+p2urNjmY6I
	Xr7POWYdsTykqi6QBjCKw==
X-ME-Sender: <xms:AytmaiNbw3AQWwOM3dmxByG3vCN0H_0dY6X9FULgkbn2Vau9-DCypQ>
    <xme:AytmakqBxNxsylIZkc0rtBhUgrd02exouqnE35mRvv3BIc4Bo-QrIIn4bBFyI5haO
    CiTGTjEdWqkJUGQwZanN92YumQSqzaWE7h5NQ2VMj5RzdOM-2d5nQ>
X-ME-Received: <xmr:AytmajHjzjDO5H5UlbXtMXYHt8PtRqQ6dh-zUqk2zZ9xeu_P5Y_4hyFfQ6X-IfRkw4rQDKhcc0PXv1pJr4lU5YH23db_4GBSOQ>
X-ME-Proxy-Cause: dmFkZTFOK/a14ydveZuh9CcRR6SGELp4xWYPPraWMq0P6cx6ZkNbP25kd/b+oZZF5AQ4Ar
    2a2bdTxDnerq3BLdy0m3ta/fWHbZ24z1PAhQj9OeGjJlUAqh9QQK+/sOcwnE/6PLX/gv2h
    groelk9PDR+bCSSNFcNEUgP6tC0FHQ3SgBtO1twP4i5t6nbcf1bVWifP4ASUeDHsIhrTGh
    mnKAkgbHvWBsAoeYrYt8qzQvW55/TLiToHvQvI0owRoX2HPVzRg/ozI2yq9RVT/cqLpmbf
    nGInhujooFWB8nLgLWgHNRRudVGMzDt7jIc1zS4XMb8iIduDPafD85RzGALNZ9ZgQwmKcR
    JSSGob1mlA6Tab7sI/Kh2kBjgpI61cO010SDituO4Y+qZV2/dVX+IMyS04pAsYbsl2YeyM
    uilMwTDEaUe67egpxsvG9kC2oojJhDIor6NEmh26AREwnaeRvFWbZ6JYKatAwQ8k4o+nBv
    Nx55Wax6h2bzwDTLhb7yB7fk9VmQhDzq248bZj5s1+aTH8pwV5SvLBNwuqG2Kb9bvbXPHJ
    Ds5BXRPW9KaXsdnkDatCygfvTn7W1sbAWZgcaRO6O/1oab85i6JOE5lAD5dRA710UM2Ed+
    dvUGXf82O3ZfNPBG1jNIg9R+siz7pqYy67cprFJfHu4dgL+0arOqpPXZq5RA
X-ME-Proxy: <xmx:AytmapoxTnumKh1vhPtEdUA18bQDsCswQ0P7rb6l2uXztk8lhK1OoQ>
    <xmx:AytmasZJSW0OjlOTUdgdIx-oZ_2ilsWH9dVKpYoxMQFruvf-NzeITg>
    <xmx:AytmaiVsNKbhRYRuYy7FpkvIqjsU6j4QTdkWWH9Inr01OKcwnhYwag>
    <xmx:Aytmal_An7MDVXrUCgCF_aZ8AMd0L5JI9FQCWF9KafrhlGuzdpFtEA>
    <xmx:BCtmamyhYO0-xSYNRzVux9OLsOs4Cm5x7jd9Ik0OAlmc3nc9bar_z4cq>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 26 Jul 2026 11:42:59 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Son Luong Ngoc via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Son Luong Ngoc <sluongng@gmail.com>
Subject: Re: [PATCH v3 1/2] rebase: skip branch symref aliases
In-Reply-To: <00e529b6-7ae7-463f-a4b3-0991e9411aba@gmail.com> (Phillip Wood's
	message of "Fri, 24 Jul 2026 10:55:18 +0100")
References: <pull.2126.v2.git.1780482436865.gitgitgadget@gmail.com>
	<pull.2126.v3.git.1784708107.gitgitgadget@gmail.com>
	<b9a01e9141d580606527cb1a658c7c72710fb013.1784708107.git.gitgitgadget@gmail.com>
	<5bece313-6ffb-450b-add1-29652b64de10@gmail.com>
	<00e529b6-7ae7-463f-a4b3-0991e9411aba@gmail.com>
Date: Sun, 26 Jul 2026 08:42:57 -0700
Message-ID: <xmqq7bmhycxq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Phillip Wood <phillip.wood123@gmail.com> writes:

>> Thanks for re-rolling I'm pretty sure the logic is sound now but I'm a 
>> bit confused by a couple of things - see my comments below.
>> ...
>> It would be nice to have a comment here explaining what we're doing. 
>> Also I don't think we need to copy the refname so it would be more 
>> efficient to use refs_resolve_ref_unsafe().
>
> Looking at this again we cannot use refs_resolve_ref_unsafe() because 
> the result would be overwritten by the call to refs_resolve_refdup() in 
> branch_checked_out().

Makes sense.  Thanks for raising a possible alternative and then
clarifying that it is not quite workable.

>>> +        /*
>>> +         * If the branch is the current HEAD, then it will be
>>> +         * updated by the default rebase behavior.
>>> +         */
>>> +        if (head_ref && !strcmp(head_ref, decoration->name)) {
>>> +            free(resolved_ref);
>>>               decoration = decoration->next;
>>>               continue;
>>>           }
>> 
>> Then we check to see if the decoration matches HEAD which we used to do 
>> above - I'm not clear why we have moved this check.
>
> Should we be using "resolved_ref" instead of "decoration->name"? That 
> would explain why this was moved and would makes sense as we resolve 
> symrefs when reading HEAD. When HEAD points outside "refs/heads/" we'd 
> then skip updating any symrefs under "refs/heads/" that pointed to the 
> same ref as HEAD.

Yeah, decoration is very much end-user facing and if we can make
behavioural decision based on a more stable resolved_ref that would
make it easier to reason about.

But stepping back a bit, is having a HEAD that is a symref and
points outside "refs/heads/" an invalid state?  Why are we catering
to such a configuration to begin with?

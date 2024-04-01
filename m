Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98105A55
	for <git@vger.kernel.org>; Mon,  1 Apr 2024 01:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711935080; cv=none; b=jSJFf1ps0ljt3NZtb2k5YqGE1PLMAak1j66r6OIyGnqWNSNX/GJxPUeYo0nvwuDh0kicM0LbMmTMW5F9gAXRBiBoZpDBchLFe+/Ihy5XGW/XDGSmp+aXGnKGiTAR+5v01J1+1oI+MtjsZTbr6ckUX/noG/S1Z1d/hfCG67Ttqo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711935080; c=relaxed/simple;
	bh=pXScDT/i0BlWtAMbBARK/W7KH7HVdPD7srwke/NhEaU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=q9J+HzYU+Lm89KBCCZbMZC/b4tTa9pIJj9orTaFc0x1QnwsyL3kIuKwEfWLAsqijm7gAuIO7YJLKHOGfMweNntWnI8id7BJXD+dn/hsBam71XkRFLGtoLl4uMEUg1XYWbChV94D5k2zajR3lo90X+lC8I7mBvTvxnIPRBR9ufMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=ai9/ajeN; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ai9/ajeN"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 297DA1862D;
	Sun, 31 Mar 2024 21:31:19 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=pXScDT/i0BlWtAMbBARK/W7KH7HVdPD7srwke/
	NhEaU=; b=ai9/ajeN769yCKapCNhp8iDGTCkR2pMTqGX1nBxS1ro3q5N1ORJcIQ
	Dimxs6bembEgTUa4Pj0wWJFMqyIFUT8nkfx/XoeLjwtiBmQCJVBQsnepNZCejBcc
	Zr0xYPb+12BPDhQori02Ddt4rMVL71m6HwsyHhWR0pkMcw6Px387Y=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 215551862C;
	Sun, 31 Mar 2024 21:31:19 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 9D0E41862B;
	Sun, 31 Mar 2024 21:31:15 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Chris Torek <chris.torek@gmail.com>
Cc: Karthik Nayak <karthik.188@gmail.com>,  git@vger.kernel.org,  ps@pks.im
Subject: Re: [PATCH 7/8] refs: add 'update-symref' command to 'update-ref'
In-Reply-To: <xmqqplvadmeq.fsf@gitster.g> (Junio C. Hamano's message of "Sun,
	31 Mar 2024 16:14:21 -0700")
References: <20240330224623.579457-1-knayak@gitlab.com>
	<20240330224623.579457-8-knayak@gitlab.com>
	<xmqqy19yf40l.fsf@gitster.g>
	<CAPx1GvdXdH3OdY1nC2ijVSdpWfg8jn5=j0KB+Wgv70wWeCNH5g@mail.gmail.com>
	<xmqqplvadmeq.fsf@gitster.g>
Date: Sun, 31 Mar 2024 18:31:14 -0700
Message-ID: <xmqqle5xeun1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 8822E144-EFC7-11EE-B3C8-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

> Chris Torek <chris.torek@gmail.com> writes:
>
>> For these reasons, I'd suggest that the all-zero hash be officially
>> deprecated in favor of create/delete and of course create-symref
>> and delete-symref. Of course, compatibility requires some sort
>> of support for the old system for some time.  As to whether that
>> means something like the suggestion of ".missing" etc, I have no
>> particular opinion -- but since the symref options are new, they
>> would not *need* symmetric options, if we just say that "update-symref"
>> cannot create or delete a symref.
>
> I love that simplicity.

Having said that, the loose "update that can create or delete" may
actually be used by applications that do not care about overwriting
competing operation, so I am not sure if we can easily deprecate
that mode of operation.  Saying "update refs/heads/next to point at
this object" and have it created if it does not exist may be handy
for some loosely written applications.

So perhaps we can say "update with a concrete <old-oid> will ensure
that the <ref> poitns at <old-oid> before proceeding, but update
with 0{40} as <old-oid> to ensure creation is deprecated.  update
with 0{40} as <new-oid> as deletion is also deprecated.  Use create
and delete for these two deprecated operation modes".

This assumes that create and delete currently ensures that what is
asked to be created does not exist, and what is asked to be deleted
does exist, before the operation.  If we are loosely doing these two
operations, then we cannot easily deprecate the checking-update,
without breaking existing users.

As {create,update,delete,verify}-symref do not exist yet, we can
start with the right semantics from day one.  "update-symref" will
accept a <old-ref> only to ensure that the symref is pointing to
that ref and there is no "zero" value based creation/deletion
validation offered via "update-symref".  "create-symref" will error
out if the ref asked to be created already exists, "delete-symref"
will error out if the ref asked to be deleted does not exist.


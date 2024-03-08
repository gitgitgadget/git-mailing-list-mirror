Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03CC979D1
	for <git@vger.kernel.org>; Fri,  8 Mar 2024 16:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709916517; cv=none; b=UM8l1OGpTrjjxRgs1l039SLyG9YJLuMsA4MFZkjhAVIXkf/LNnsUup/Av9XZeATHqWQ9dh19SZO+f2pQnZ1xva38EYssQ+V6FNoPPrrjttD5uE9Nte/0cuHtjPUgIGAq81uF//v22DuDnRgQTWkYyMwSaTjejW3arxoSGZQR4II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709916517; c=relaxed/simple;
	bh=pAiunqr/UJzpvGE9x8MjFG6Yz85zyTbCIb9GFCOPhGQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Sl/iTVX8UtRfmfFlxJwJsovXUwKmnnUgI8N/1lm0RUPXVOAdaqPYtxQts5EHFsh7p7a8Sef4RrOIOVOv7h0/rBCtq85XldffC1REoVOIO8ugPU492tOU1Im9Rvi9X0PWLMG8THEOLTV1ohjBt80HjyGjRw8RbSOZaLtg9g1eXvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=CRw/dkE2; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="CRw/dkE2"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 6CA3139339;
	Fri,  8 Mar 2024 11:48:35 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=pAiunqr/UJzpvGE9x8MjFG6Yz85zyTbCIb9GFC
	OPhGQ=; b=CRw/dkE2TPyrwadQcU2Ru2JvsdxJHq92oefumCLIaMLuzWRqTPlsno
	rxFQpYqMV9ZWhRyY2i6zOFwmp9WZs+o56Mdc+fmIBatIQI3f7tustP35ZJ+DcXpB
	mH9LzPJMe2PMSMu3N0N2QIFP95K5e61eZlfn51pszGdpjsKD9PmQ0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 63D9C39338;
	Fri,  8 Mar 2024 11:48:35 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id D0B6339334;
	Fri,  8 Mar 2024 11:48:30 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: phillip.wood123@gmail.com
Cc: Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Phillip Wood <phillip.wood@dunelm.org.uk>,  Elijah
 Newren <newren@gmail.com>
Subject: Re: [PATCH 3/4] merge options: add a conflict style member
In-Reply-To: <48b2d5b1-a59f-44c3-94ba-e7f81913b7f5@gmail.com> (phillip's
	message of "Fri, 8 Mar 2024 16:13:44 +0000")
References: <pull.1684.git.1709907270.gitgitgadget@gmail.com>
	<c0d7bafd43823ef9df5a73bc80b90cf003988bc9.1709907271.git.gitgitgadget@gmail.com>
	<xmqqle6shgkw.fsf@gitster.g>
	<48b2d5b1-a59f-44c3-94ba-e7f81913b7f5@gmail.com>
Date: Fri, 08 Mar 2024 08:48:29 -0800
Message-ID: <xmqqwmqcfz4y.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 B1C3EFD4-DD6B-11EE-A8F3-A19503B9AAD1-77302942!pb-smtp21.pobox.com

phillip.wood123@gmail.com writes:

> I agree it is confusing, Elijah renamed it from ll-merge.c relatively
> recently 6723899932e (merge-ll: rename from ll-merge, 2023-05-16). It
> looks like the idea was to group it with the other merge* files:

That reasoning cuts both ways.  When you are only interested in the
upper level API functions, being able to skip ll-anything as "low
level details" is a powerful thing.  merge-ll & hash-ll separated
far apart will make it impossible.


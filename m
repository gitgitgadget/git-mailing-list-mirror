Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459C2BA50
	for <git@vger.kernel.org>; Tue,  5 Mar 2024 19:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709667703; cv=none; b=eKesZikBkK87P6Ke8IN7eyl7GApkf4t7xtfqJyTdcWEFv/9UM2j5RyXjpqnvxrEO0CJGEzD8ViqKTx5EanZePkkSxu4nhFOLX2XvRA/ig/jHQdB9QUkeynfIthfcRJFiSCbYw5VjbyWqlK5BcqdDPnv4DPPIWD5XKr/aQAOOcXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709667703; c=relaxed/simple;
	bh=1QwAmycI+rXE1T+qzAlHbZzryF4j1rWpLqx9GuhP2no=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uIEnWqi1dcHM1Y1YngjaCO0kBBTVnf6+r3jc8aV+DyQmH8CkrHKbn8NbKByaGRHPoA/L5FOUGILHwUzkDVI2SP8qnx24FwHxy7CBPFPE9sYkMRWwnbvMO0xyBc22Qhh6JSZF+gkpX11n+/KbZxXLWwBjq6pArZ3IQAALuRqgUhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=gnlO8PZl; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="gnlO8PZl"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id C4F6E3F1C2;
	Tue,  5 Mar 2024 14:41:41 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=1QwAmycI+rXE1T+qzAlHbZzryF4j1rWpLqx9Gu
	hP2no=; b=gnlO8PZlLVuwIV4Ox0b3RO926TjULcwup+bAN25yYHps9SREsNOF5F
	5yfyYztyNQyj3fXLXMiva3lS9xX80lx2l4okNazpXOgFwchY1sYoFvNb9rzzSsRD
	qSeEHQABJNrQdlHSpJTuHuWhe6bd0h7Es1AjZWziNsYNzru5JXAL0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id BCE873F1C1;
	Tue,  5 Mar 2024 14:41:41 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 63A593F1BF;
	Tue,  5 Mar 2024 14:41:38 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Josh Steadmon <steadmon@google.com>
Cc: Linus Arver via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Christian Couder <chriscool@tuxfamily.org>,  Emily
 Shaffer <nasamuffin@google.com>,  "Randall S. Becker"
 <rsbecker@nexbridge.com>,  Christian Couder <christian.couder@gmail.com>,
  Kristoffer Haugsbakk <code@khaugsbakk.name>,  Linus Arver
 <linusa@google.com>
Subject: Re: [PATCH v6 0/9] Enrich Trailer API
In-Reply-To: <Zedtd6esmIgayeoU@google.com> (Josh Steadmon's message of "Tue, 5
	Mar 2024 11:07:35 -0800")
References: <pull.1632.v5.git.1708124950.gitgitgadget@gmail.com>
	<pull.1632.v6.git.1709252086.gitgitgadget@gmail.com>
	<xmqq5xy036a2.fsf@gitster.g> <Zedtd6esmIgayeoU@google.com>
Date: Tue, 05 Mar 2024 11:41:36 -0800
Message-ID: <xmqqh6hk1n67.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 61FDD144-DB28-11EE-8DB9-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Josh Steadmon <steadmon@google.com> writes:

> On 2024.03.05 10:03, Junio C Hamano wrote:
>> 
>> It's been nearly a week since this was posted.  Any more comments,
>> or is everybody happy with this iteration?  Otherwise I am tempted
>> to mark the topic for 'next' soon.
>> 
>> Thanks.
>
> I scanned through v6 yesterday and have nothing new to add. LGTM.

Thanks.

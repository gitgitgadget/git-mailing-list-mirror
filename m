Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA323184E
	for <git@vger.kernel.org>; Fri, 19 Jan 2024 00:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705625943; cv=none; b=Jq3dUa215mNjtcSiLwW/aFiQwSJIQESSBCehT9bvSfTgoK2P7XrRPHLqLjLpkiN4FWbyZjarW70z5HnsQCYhIkBGe0ZGPQGLsZhOVUbxchAK2udDgSfAHj/FPvzC/kXidNgYKbQD0wzEB7ZmW3bD91WVYczJLyHQPZ2aCHoLEyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705625943; c=relaxed/simple;
	bh=t0LPMV+t2ooLER0nCO3Nn5WD4UmVC4LiMyZvpDmJwYw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cSngml/EX1uH+t02HHJ01J6NBwVG+oxousJCbalWU0HePZWCOpIpjaxa3YGqP7jBFYysyVfkkOxKUD+eM9FURWXJijp6LsKEqpyiyMoHIlh/EA5/3/W4q2TVY0w9Nd01ANjdsWrcugREBgC0112723vz+NW7QN27dcYbx68fFGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=LolnAP+D; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="LolnAP+D"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 4817919F37;
	Thu, 18 Jan 2024 19:59:01 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=t0LPMV+t2ooLER0nCO3Nn5WD4UmVC4LiMyZvpD
	mJwYw=; b=LolnAP+D9v1UoKE8ftgQaDlGplXlIttsiF9/92Jt9IZ45m1lxgvkIY
	SFsOjunECxU4i/kIiU8CuD5cayXh07k/hN8bapwFUjsvYgRJ1ks3mBo0McDeLaCC
	VW0M70Enmf2slwODMDgn5dFLUIcsZ+SbmglA2dS/aShEceETfsTaM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 4106E19F36;
	Thu, 18 Jan 2024 19:59:01 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 053A819F34;
	Thu, 18 Jan 2024 19:58:55 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Emily Shaffer <nasamuffin@google.com>,  Christian
 Couder <chriscool@tuxfamily.org>,  Linus Arver <linusa@google.com>
Subject: Re: [PATCH 06/10] trailer: make trailer_info struct private
In-Reply-To: <0cbe96421c7bf573e8ddc97b2a0aecc894095399.1704869487.git.gitgitgadget@gmail.com>
	(Linus Arver via GitGitGadget's message of "Wed, 10 Jan 2024 06:51:22
	+0000")
References: <pull.1632.git.1704869487.gitgitgadget@gmail.com>
	<0cbe96421c7bf573e8ddc97b2a0aecc894095399.1704869487.git.gitgitgadget@gmail.com>
Date: Thu, 18 Jan 2024 16:58:54 -0800
Message-ID: <xmqqy1cmm94h.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 EBE0A68A-B665-11EE-A954-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

"Linus Arver via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Linus Arver <linusa@google.com>
>
> In 13211ae23f (trailer: separate public from internal portion of
> trailer_iterator, 2023-09-09) we moved trailer_info behind an anonymous
> struct to discourage use by trailer.h API users. However it still left
> open the possibility of external use of trailer_info itself. Now that
> there are no external users of trailer_info, we can make this struct
> private.

Surely, and looking good from a cursory glance.  I'll defer to
Christian to comment on this step as an area expert, though.

Thanks.

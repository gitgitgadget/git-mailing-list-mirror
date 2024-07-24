Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B435314B978
	for <git@vger.kernel.org>; Wed, 24 Jul 2024 16:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721837201; cv=none; b=eyxsszAOyWnqXqlRVRi1qry1t5veBOGwklaWSSEPpN1uCUk41qNxLj0eJ8SVzP/bmZYp+FpU/w9KucZX7pVXfADlW/PA5p80l8FVXiKZZJ7VR4ImK3QnBLCm+DcSTQXjDa/dBuv89rMrIYNWnNygIn/6HJqDcXDwLBMsbJJVPhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721837201; c=relaxed/simple;
	bh=AzvA5SUu7kk4NmXK0COflK6NzG8nlNkOde4XKDz7Pcg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cbOfP4AQixmxIuzNuIQQHDVQdW1j0HCYt0UXrHvnnPe9Awy4TopYs5np8U8R8+Q4vaHDIk40RU7nxWcweTpS1NI6uGESVxFSpilPd/Odv2rNQtUidRXI4FtjAGX4bpaAZxQC/3OcQFq344I0CNw0aFkI3EfRvyr/3bQnW8TqGos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=ZxRFS4cl; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZxRFS4cl"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id F3CD21CE95;
	Wed, 24 Jul 2024 12:06:36 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=AzvA5SUu7kk4NmXK0COflK6NzG8nlNkOde4XKD
	z7Pcg=; b=ZxRFS4clxtjZp1naF+rvG4O8lrRNxdtaClubxYYbS0UlkK0wlq6G5g
	SMWlXdKzHOKAOJ9EK4UrIsiZxuT+jOy+7bmG9srTpSGmVHpg0DTir5ijoNeAVFa4
	ONbCl8EyLWZVgs6D8KxQqDnei0mk7nrfqUA58UUgDnyaJGuN59pg4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id EC7DC1CE93;
	Wed, 24 Jul 2024 12:06:36 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 68EF31CE91;
	Wed, 24 Jul 2024 12:06:33 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Christian Couder <christian.couder@gmail.com>,  Chandra Pratap
 <chandrapratap3519@gmail.com>,  git@vger.kernel.org,  Christian Couder
 <chriscool@tuxfamily.org>
Subject: Re: [GSoC][PATCH v5 0/7] t: port reftable/pq_test.c to the unit
 testing framework
In-Reply-To: <ZqDBxUC34pV2TLGz@tanuki> (Patrick Steinhardt's message of "Wed,
	24 Jul 2024 10:56:37 +0200")
References: <20240614095136.12052-1-chandrapratap3519@gmail.com>
	<20240723143032.4261-1-chandrapratap3519@gmail.com>
	<xmqq5xsw2fyd.fsf@gitster.g>
	<CA+J6zkRKzQGvwhiQdgRqcctDP76y5_v582rRTzEXJyx7=+WRqw@mail.gmail.com>
	<CAP8UFD12Cqorr7oPS+JfOTYY6LaNUgPEJaEscf-jwLUOur+xqA@mail.gmail.com>
	<ZqDBxUC34pV2TLGz@tanuki>
Date: Wed, 24 Jul 2024 09:06:31 -0700
Message-ID: <xmqqttgeydtk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 B244E1AC-49D6-11EF-A52F-9625FCCAB05B-77302942!pb-smtp21.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> Of course, those shims will closely follow the interfaces that we have
> in Git. E.g. there will shims for "strbuf", the tempfile interface, and
> everything else that we currently use in the reftable library. So
> ultimately, I expect that the shim implementations will simply look like
> the following:
>
> ```
> typedef struct strbuf reftable_buf;
>
> static inline void reftable_buf_add(struct strbuf reftable_buf *buf,
>                                     const void *data, size_t len)
> {
>     strbuf_add(buf, data, len);
> }
> ```
>
> While we could also shim out the priority queue, I don't really think
> that it is worth it.

OK, I am fine if somebody wants to spend cycles to move the
reftable_pq tests to the unit-test framework.  I just wasn't sure
what the future plans were, and one obvious direction to replace
reftable_pq would invalidate such work, and I wanted to make sure
everybody involved in this effort is aware of that.

Thanks.


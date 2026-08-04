Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F53477292
	for <git@vger.kernel.org>; Tue,  4 Aug 2026 20:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785876262; cv=none; b=e50wuTwhLtSOcs58X5NQRELVRsQeIukVGW6rn+5KuAiWgO24wPoO15vPuqReDJ+d0kMfcbs3uaW/CzLzgiysvQDki4DewTlWgzV1ZKgy1TNusrAun22J4HqpZzZNFSauH8v8wZEIs6/ql+falZC9VFmjgpiJgJbiRyA6cOiXb0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785876262; c=relaxed/simple;
	bh=JK6LETQdljwUUn53AQL9tXWVOCrYz5olSKt+O7PBz5s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Jk9VYZUQJ074TvHnkko9p0n2j5P0yUirgHy41u2Py1/Rm+emw6MpVXweMg+IOUSlD6OTdz0YJY+F9V6kQv8MNL3vK8h9Tk5TXQVBQmSjKnAGwa94KAVPTRRf+q7iF3cV+OKw0Rx2rW8ZLe2dmW6Dja1b4u34GkbYhvIHweBMI3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=jFUwlkAV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dyrv6WcM; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="jFUwlkAV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dyrv6WcM"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id CF7B61400082;
	Tue,  4 Aug 2026 16:44:19 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Tue, 04 Aug 2026 16:44:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1785876259; x=1785962659; bh=IV3Nagha0B
	htC3rsuXISUxK0UV7kmbJMaHMrKh/rb3A=; b=jFUwlkAVFuhYHnvcao5CXnXYKb
	H1Eli5rVUHIMTX0z2Kdgp17kPrveiap2k2Kv1C8uie4irCfRJcQqC26OYPZpXqbH
	HIYzJFIWupWYSX5zO3KRY+DMBL5fQUAQ1icPouPXHGJcDi7NFlUv4N6bcC+U1SfK
	wEcwSgyGSolprBIMVfwGk+VLv6J6DLdoQuW/4OtHcZ358B8cEAyq3BsZQYzSfNwd
	Y9X+a/nk33+3PSQToc3OUVfklrZxM7tejkG7S10iPpVtknUTm7CizxRPRePTSyph
	pJ4JpTWVnjHzyQT+8Jg0M2yAFNSr6wrE55FDueo+N4q7d9hQOVWxUaBjg6vg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1785876259; x=1785962659; bh=IV3Nagha0BhtC3rsuXISUxK0UV7kmbJMaHM
	rKh/rb3A=; b=dyrv6WcMASD5Fuc7BIZ7LCi2vKSMGVF4bQnDn01IJlFogea9Gok
	8QtTQbJ5rQJ4/pT6QrGgBVl9x3hhs0rTntkx9zKlrFnkXd2cmipZJL/fZ9f76AKr
	CMcR6VUw2ifhtGYHjlGxl6iKYsmQwV/s5yU97KjfJ9rfWlGs2c9hkdLf2TECxnA8
	6i5SoOR8Rwjn5iflAThOQLETvjNpIJmNzbk9p8uVGYpj29RuqWQrsqFE+JS7S7cd
	F+nY/RnnedTuJ1dN35NbZQ71m/sKwV7g8TDc4zDRgKtCZTMKRCbI/0dBrmgzYlVQ
	w/do6kFQVbXFWyGntNGbubwGso/Fnl72vsQ==
X-ME-Sender: <xms:I09yalrzFZ1QgxX2OSwzTO-ypMs86Y6SYPqmSGhK3_tztn-qOm9qlw>
    <xme:I09yarW6ZPUqI1xLI0_7DXUivnO3FJd7XFvltI2OSpT6kRjiya5OBWCnx1hSUI37c
    sD4dZfnf6frqqSQ8A8m64ZQRM-VktTqPyW6g6obQAFvZ9xNE_ki>
X-ME-Received: <xmr:I09yasB3QVnScUY9yZQEADBKE01L_C5QpWa_jrYR6RoErjyMaYJqZEDm47p1k5hkQ-0ZWbfYU9xRcQiKE3IkJNBUjSyvrZe3dA>
X-ME-Proxy-Cause: dmFkZTGhDfTLKfTB9nSgNLTAIdQi+TLmW3zZw4wwz+O8krWHKhAmBoteBAbLhmZIBRGkoP
    I7mBJ+f1UEPg1cOA7Cjj8ipCtZSMScR0pj+SKavOCzT8H2cMAqrhP9yNqvmQgBbyahfeOr
    0zjIMzybxNZbGs6fmJ6F8/pYXy7rr7HWreJ7c/KapQGYCM3qlcIv/mqfjL8DoXTTgffY2Y
    rar3XCgWXU8KHdTl0CDcVD0uYYsm2o7bfp9TJ0kgKFb1Vfxd0sHeptQeIEaJV67F7RgfBS
    /QfxpIzT3xE9wytJAKkHxNvxNk72vTZ2yoA3F5vomJqG9OvKPB6s82NCqXJIng7KDaBDhY
    vGST884VrPScs7S69Aex6SfdeA4Cx8injfm06BSXUu1S8GxBXclS7Cmj+hTNZm5dnYqRIT
    PGd6OTAtAP5tumAn5KeLbOtO4qO34qvncOi2iFq7l8xoROznooIKDXHIezWhQPJjVCV638
    /JirC+oHeRDomj/4bZEKea24L+HKAIY3zvC4mbDDBYnk3aNx7RFn/BMaPVWufb+SP0QRbl
    NJCRwcmYXjVo/VshSAzIh2P/V7sedqH3HDPI0/4/00JJvAut9l8PZRRju8YLGG78X2yN9f
    k1pMWKf1ryHHaoLgValKE/LAHB/tBaXaI/ZPHQ9+f5zsnFNNSbIOtxzSDW1g
X-ME-Proxy: <xmx:I09yan3sY5uOTmtcIWXpQpfwYPtrXngEzS79NSn8I5bhKWOrkr6kTw>
    <xmx:I09yam3Otb99d_e_Xbot1KrZOJK-D0yUbHHNas13Or6zX3cvPEmIUQ>
    <xmx:I09yakDxilm-EpZ__hpqYIw1CAF7qMiZo0Ow3gd5_LenG1ie2kYuDw>
    <xmx:I09yat6u8OmZPki9Duski6gEHsoXMN_PuhqHL_OPW8LchvB9Ml53yg>
    <xmx:I09yaoxse4A3sCqDmc5QDTna-r5MPXiyq-wlt9lDSeNCjOXIKpaoIhZA>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Aug 2026 16:44:19 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Pablo Sabater <pabloosabaterr@gmail.com>
Cc: git@vger.kernel.org,  chandrapratap3519@gmail.com,
  karthik.188@gmail.com,  peff@peff.net
Subject: Re: [PATCH GSoC v4 3/9] fetch-object-info: pass arguments directly
 instead of a struct
In-Reply-To: <20260804-objecttype-support-v4-3-31511b0231be@gmail.com> (Pablo
	Sabater's message of "Tue, 04 Aug 2026 20:42:57 +0200")
References: <20260804-objecttype-support-v4-0-31511b0231be@gmail.com>
	<20260804-objecttype-support-v4-3-31511b0231be@gmail.com>
Date: Tue, 04 Aug 2026 13:44:17 -0700
Message-ID: <xmqqldalty3i.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Pablo Sabater <pabloosabaterr@gmail.com> writes:

> struct object_info_args groups three pointers that already live in the
> transport and are given to fetch_object_info().
> Grouping them into a struct reduces the number of parameters, but it
> suggests that the three belong together, when they are unrelated and end
> up being accessed as args->* independently.
>
> Drop the struct and pass those parameters directly to
> fetch_object_info() and send_object_info_request(). This should have no
> change in behavior.
>
> Helped-by: Jeff King <peff@peff.net>
> Helped-by: Junio C Hamano <gitster@pobox.com>
> Mentored-by: Karthik Nayak <karthik.188@gmail.com>
> Mentored-by: Chandra Pratap <chandrapratap3519@gmail.com>
> Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
> ---
>  fetch-object-info.c | 53 +++++++++++++++++++++++++++++++----------------------
>  fetch-object-info.h | 17 ++++++++---------
>  transport.c         | 11 +++++------
>  3 files changed, 44 insertions(+), 37 deletions(-)

OK, in this iteration, the step is truly about just getting rid of
the intermediate "args" structure and passing these three things
separately, without any other changes like the (half) addition of
"type" support like the previous iteration had.


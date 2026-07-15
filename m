Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE463312815
	for <git@vger.kernel.org>; Wed, 15 Jul 2026 06:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784098710; cv=none; b=izg2TPpY96qKd5SZpCBB68Jx84B50zenOTOujo3qDXhXnUKwfKREkkilzq87Lsg2scjAdzKxt3eZ3983xWdlpJWAZ0V291i8nIIoOWnENooj5E8bWeNd2vr80KSleGoRDZYXbFPB5HkrRzyDx32PVmGjbgg0fS8oEMyVBK5VGbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784098710; c=relaxed/simple;
	bh=wbShrU8NkRXVYOaqG/eQVd7m8lCtKOfKpxXj0Bh7xgc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sfIDNMQv6LTxCWVe9RiAu3+i2bv/IB11ol7/Gf9mEumVbcRdqAcFU9+4jWu9OJJmJ+7MCyW5GVZJ1vAdH+c5BmDTKAJRk+IPKz9lMSw2TWsoRvrZPuF/KnB4c35n9RG2wdErNRnW33RrhIZVhlB9AGAiMlbbrfAnm53ftnULG9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=c5C8LkvL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IuK9UtMe; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="c5C8LkvL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IuK9UtMe"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 42F2E7A0136;
	Wed, 15 Jul 2026 02:58:28 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Wed, 15 Jul 2026 02:58:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1784098708; x=1784185108; bh=9EZO7J56bK
	SBwEgum3YvcXxgCAro4D29ExFqvY3KQ2c=; b=c5C8LkvLpW/EkEeNIOExsFajqt
	RcXwEJv9TuYJO3lm4JC1YC6ELbkofL+FAqYFUN2zE9Kp5CXz3VkLYXfS0ss8L6UA
	tTYXu/XqvCdenpfVlcTbcF4sxmr0reCTr1a1vbc5gpUUEckm+pw8Ns0VwxQPb0kR
	3vJVpxNQZ2cqTK700YteLkNZIAV0m/9GOA2Z4wSsKBJXWcYL7zjcRQb6VxWSy2QK
	iSxZn8YFtMIzUI6N1lpAejGO4PnFijHPU2niQkSrp0yLy6oA/Lc8e5vOuxM3hsR3
	NAM1pLPMf9IceWZ+u01102gMUtjhE1q98nV5aNJI71R4KJw2BpNkRvuOWluw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784098708; x=1784185108; bh=9EZO7J56bKSBwEgum3YvcXxgCAro4D29ExF
	qvY3KQ2c=; b=IuK9UtMe4GCugqDfm52wVvSEpKLPsSED9pkPqolWOmHneYnT8rv
	T3BWFu+/U46b4pxNW/Y8KtKz4teowP6akn5BV6S0g/1QZiZSiT2r7+41GSDaaOI8
	k0Wh7CLGHoJwprsQ5XU/J+kNSw7D84TV9TuN4/jAicqOuo3cXgdelRdFAhchU+MV
	3gLNCkJsUcATGTtw5zQNAPQQOQg2Vevc1mFKoy3VKo2ZwiKFfAmaUbn5cxv8OgYL
	ttX61Ev5jrQkLt+jujq8RQixHRDo4vn6yZwtzccY5C1t7wv+L2ioluhGv6UuQfFb
	PFs51OOONEjx1KvuzGVlfOzXHVR35GLYdqA==
X-ME-Sender: <xms:lC9Xas7H9els6iwjvRCUrvsQw7gncXfNyKuTTVR7gRcOsYfGRYbXQw>
    <xme:lC9XalUe4_bpMvxMfPqQC0W88ulS9OtQ30Ce-GF2tdITuk-ta-_RG0wT62KNmLjg3
    jKmazELwbFRXWhIq96ItzNELCaJbtiJmnJ8nGqncfWXNFYZIxK3gWI>
X-ME-Received: <xmr:lC9Xao1QzgxpTsb6a-gKPjf8ADScfhDVHJg9APXdwf9IyzNRkjzw2fu91N8asU5gqB_kzY0rFcqYxonG4umCk2pGGEE3mskBKPCGnKuOXto>
X-ME-Proxy-Cause: dmFkZTG1WWLcByQmmxMSO/Is/1htfmCFwhWIbKc8tIyFwIy51tFCJGhWeULuMmLOXCSBLQ
    MFx1NYf4CviGlxGqPgq43w2i6MMCPtAwKkpA08/2Yta0HdXwCFPrSj0n6YWWjj4yYRMvdj
    m0qyDTj6SufVs3QizVkbE3H4edg3c3M2MnQPEQDOyz5AjnzUcvuGvK++Z5CbADHe0XZePf
    Q6jFCZT8ntJHMp4+oFMZl5p845ZNgpHlDOSm3eoZSpB2FtBvTnTwkfeVjeecBnDY75Aqfh
    XZnCuuGXJnvxOWBdYCMGi+rojKUK1izkSXYOhntYw2Z1/dz+wA/Hwfa0SczX5RCrgIR7nu
    GkAV7YWLr5GhVUJ+4CtINxz++VUuKNV+Geb5cSxoLyvpFhgrPGqi25N8f2/m8dJd6aWR5D
    qvhQPU+K6/Bsp4hC/6UUft6zKPwSSgOllGLHPekImiGkXgKOYxBCUsaEWhDknENepOzN0c
    vqbVD2Nir15SOYwlKPBmkBhCozXIhLYhVXC6gitFs60aBd/IB/nB+I8XZyhyCoTbIb8s9W
    zm3smL3XSGxoj5OodQmAYYWB3QA5XaE+doyZwFxl0o5ljefqqQwWKlvbBcrsA62SGQOpfC
    mfr/us/al7Z4A7iUnWWNlb/b7+IElUOu/ly83/zN2NCTNddgtyggMfl2PRnQ
X-ME-Proxy: <xmx:lC9Xaq19_UB7uIYpIvwGIICEx04P-yc2RaNzRBTTWAcZ250yw5hqbA>
    <xmx:lC9Xaj9stbar3G_qhIRbyKyajZdhD3xFhmgSx7bHyKYOOe-GkgQRUQ>
    <xmx:lC9Xav0xJUFDhPKs_y_W9ORIroFUR7yHbVXPckWRdZOGb0ADqms8cw>
    <xmx:lC9Xao-gzhBmeaorv4Q_XP3RQTnbzDQVH3IWhv_Q5BYpHOa6qpkmPg>
    <xmx:lC9Xav0qWkqDOQPCbjTZ_qIKN3n3syAJ-kgY01RoX5Kr-WxKj4crL45p>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Jul 2026 02:58:27 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a6bc9f18 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 15 Jul 2026 06:58:26 +0000 (UTC)
Date: Wed, 15 Jul 2026 08:58:23 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 06/11] compat/pread: check initial lseek for errors
Message-ID: <alcvjynWsHZKXD84@pks.im>
References: <pull.2179.git.1784069325.gitgitgadget@gmail.com>
 <b31e0326e7c4f97753c80077c8f0927504f40370.1784069325.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b31e0326e7c4f97753c80077c8f0927504f40370.1784069325.git.gitgitgadget@gmail.com>

On Tue, Jul 14, 2026 at 10:48:39PM +0000, Johannes Schindelin via GitGitGadget wrote:
> diff --git a/compat/pread.c b/compat/pread.c
> index 484e6d4c71..ac7d058cb8 100644
> --- a/compat/pread.c
> +++ b/compat/pread.c
> @@ -7,6 +7,8 @@ ssize_t git_pread(int fd, void *buf, size_t count, off_t offset)
>          ssize_t rc;
>  
>          current_offset = lseek(fd, 0, SEEK_CUR);
> +	if (current_offset < 0)
> +		return -1;
>  
>          if (lseek(fd, offset, SEEK_SET) < 0)
>                  return -1;

Heh, funny. I wanted to complain about misindentation here, but your new
code is actually indented correctly. It's everything else in this file
that is indented with spaces.

Patrick

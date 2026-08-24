Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C4836D9E9
	for <git@vger.kernel.org>; Mon, 24 Aug 2026 15:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787585718; cv=none; b=oMh5wcomoQQ/tVgc79SUknFUVegm5eWhX1Ehby6v2BdKFh5UXLbASMFqS5D1tch/dRR8cUoga3R5/m/4a85rQMGZlOEf3cqBBbCe6YpTTxaQk5RTz9imt4ie2TUMWXuCkMwVuYUkf+cacQOpRvXYDGvdpt1Qt5hxYvxz+ebZC6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787585718; c=relaxed/simple;
	bh=aOKYGChv7kycs8HvjhJeCbmu/92OvatfMmEg8CW5LWM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=H5vxMMzKu/usiMtfMJ8Eoa2HXW3EgwXTa0KRiTc2J2rN2CgtCma+zzAtmmyi9+Lz7jSR9IFcJiOr9g9BrT38eOqkx0QMdTWQx86MfYIcR0SHKg7c0NsllUN3JmPDmlaKvh7JEu+nTKf3/V44GWL42345sYzjvzFWsIMfUKgOGh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=UNkbVQgT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WvkeCiTv; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="UNkbVQgT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WvkeCiTv"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id C9993EC00E3;
	Mon, 24 Aug 2026 11:35:15 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Mon, 24 Aug 2026 11:35:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1787585715; x=1787672115; bh=DyNN2xUa2R
	h87O9PN+iooNNwK4E9jpr2CmfO4Eszcvg=; b=UNkbVQgTo3XntkEz6OgS3NNv6E
	SEZSpkyrhdYvDmCMyDdjSgo/Dt8Y7546X6Bl4yjS4sV5PLRhGd6qjT6PtqC3TBlp
	EsSfNXjPA98tZ3iYfTuFt2O+chpMQ4UzwCq2Ab6DnW080wF53DqksSrSA7NuDC0v
	2pAhIq6zkMBbBWEB5/R6CtFp8+8U8clv87N4I9laSngo5fH9tdmTPSs0HThgsodh
	Y8rIRHHPU/lsCwMHk+QUQt5l2KbtmAqGOKfA7rFXemUUVC8AmuLmN+BOhw/CxjV8
	fEHPi2cGHFHxj4cYt2wivpuMKCrDfY4IDeYQoVjmqnRwNN5QHkwGyUSPvSmw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787585715; x=1787672115; bh=DyNN2xUa2Rh87O9PN+iooNNwK4E9jpr2Cmf
	O4Eszcvg=; b=WvkeCiTvhyRuqjewDO1dJ701JuYQqOxEDRoNv7IxIfxWmpc9+do
	hOmDdPVo6oekdStuLqC1YiaTs7wyRzr1wqJs4b1HK1vfNJIDb00v7eby7nnLWtTo
	Oxet17W2zuWAvpL6Ip+syXQZMRk+ffIc1EmVlm2wa3baQWITh1KKHuxAxkZMCyCI
	Q/w2wcPOnYQtCpe76T/oQw2fEnPsGq61bLC5bGW3ESvO7V7DnFVk94sRVw3gsx19
	0TF+fauIJ+A53bfbruH8uiHkLXbFcQOXHBllFGI/AEN+3qiYM4VgNSDW2fz2djgv
	wwpzh2weWrVnx5vCw9VemuUxfrfvr5ha72A==
X-ME-Sender: <xms:s2SMaob4k6mQcq4nQ5HF0E0XQZZ5UsYkxe_-wzAuZK9GKCdUIxJk0g>
    <xme:s2SMakGjgAOmBsRE9QYXKCYZoMXNNQjWiH-PAkwewUKb68_Nj1IrxPlz1X679ZL-I
    WX5cN0Z0vVOT9_mu9r4_r7kVa2f4ZcrKpZ0Gk9mbxYil74_VmChp4w>
X-ME-Received: <xmr:s2SMahK9EjZ1MK9FF24xxpw6_iSgW--t99sii-VJEAm85mkv-_bL5l3IVhKQ0IuizGc3htUPN4OO9v6D5WY0h1WHNzWz8fGsXg>
X-ME-Proxy-Cause: dmFkZTFoL+pG+auMPV2QnUCNhXKT14b92U4+5+g/KQsWQVbo2DwfB2/9Nyhdacq0LeGLG8
    MQu+NdwcWuyTbw4P4gB05S/QwkaUyn6vubZY8SnEVMITveYiQCjQqP2O+Xy0hSJyJz3oro
    /MPG846Vv2SNcgKPLqdD+z+ogwpAbrzrFNI3//qgEYVOK/6NXwc7+GhS1RggIRZZLSEK0M
    cwJB6uBZApdG6qQTqpqVCXgH8jVt4bW2YCzupe9/AV4x56//QpZ0CVOhgIDgLAkcgn9fsf
    fQvYjLiDtwpMOuKN6Xfda/ML6bHfYaJ3zdalTQaJH3UIBrzTvoiyDyUscQbEWqPmz3s+pn
    v+dqonDDx7eXk+6k9GUSQp+2XDndNCzZ/qfV6kXEFMTjZik0TVb45LwY0fqQ0UUKsRJE7a
    KLF91YAVEgOMFWv8enM7MwXPFGFX0zFfUHF33C824N0FAh3hf2+2kUIig27JG3l+CwQFSo
    qRJSA0YJozKcI5+tIV/bCMEjWjWpADQOUmpUdwEzoj9BR7zAkyDdBKbxoyReMAxa+tNoqy
    rmPDUPVzXwBctiJ2bziL6bxIDs3S5DpNZ123La3LSeJcPrxpbgAYnpkLoz7v1rrcP3azLl
    r/f178s3VeGMS+Cw3MVZpV0YgoR0CXzxR86hj6jnSjUXTw+3yacNd+xavJbg
X-ME-Proxy: <xmx:s2SManMMvhaYYzevaq9Oyb_CzPZjz3dQiMx9SsV7SvO173NHHHELTw>
    <xmx:s2SMapn6-BVAerQzBWpLsZHNyzd7GKhDsmrzZI5B5zfU9yJxv3Rz_w>
    <xmx:s2SMaj4knU2MDU628zbiTWbFrAKE93SiBz3SAGX36teA9EIcLm5kXA>
    <xmx:s2SMal3gLPvBstZqdtZ04bMdndb7NZkdDjHaGt4i5qypt8B8jTc8UA>
    <xmx:s2SMaoVufP6UyuG5qvjkv3-5nECZmZdtEMCjIns-jiCasjYQgBHSAcgy>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Aug 2026 11:35:14 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im,  jltobler@gmail.com,
  kristofferhaugsbakk@fastmail.com,  Phillip Wood
 <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v3 0/3] hook: introduce the report hook for
 git-receive-pack(1)
In-Reply-To: <20260824-758-introduce-hook-v3-0-499526f0a062@gmail.com>
	(Karthik Nayak's message of "Mon, 24 Aug 2026 12:20:58 +0200")
References: <20260818-758-introduce-hook-v1-1-8a8d89e65838@gmail.com>
	<20260824-758-introduce-hook-v3-0-499526f0a062@gmail.com>
Date: Mon, 24 Aug 2026 08:35:13 -0700
Message-ID: <xmqqv78zr0pa.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthik Nayak <karthik.188@gmail.com> writes:

> ---
> Changes in v3:
> - Move out addition of proc-receive hook doc to 'git-receive-pack.adoc'
>   into a new commit.
> - Add a new commit to move out the response generation in receive-pack
>   to a new function.
> - Instead of die-ing on non-zero exit code, we modify each reference to
>   indicate that the hook failed.
> - Instead of correctly listing out the protocol, link to
>   linkgit:gitprotocol-pack[5], as the protocol also differs between v1
>   and v2.
> - Link to v2: https://patch.msgid.link/20260821-758-introduce-hook-v2-1-e90e2f7ac2cf@gmail.com

This has some interaction with Justin's pluggable writes series.
Please help sanity check the conflict resolution I did near the tip
of 'seen' when I push the integration results out later today.

Thanks.

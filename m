Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FCBE19D07A
	for <git@vger.kernel.org>; Sat, 25 Jul 2026 01:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784944630; cv=none; b=h7iCPRxrHb9EaPrM160kW/McfoJSfi++Iyn4sNlVUMDymsFFIYMr+8Zhx+AbJdu5rf0ysyl+calSFe4BGMYD0NKZkBrhXQRCvYV/4RTEpOmQbzw4wiEXhPPXtVwEBdZO06naeuhdmVwFrPKqf0V/n3RnNBRz8sh1zX38SSiOyB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784944630; c=relaxed/simple;
	bh=U21qGSnjqHc7r9cqLqcTANQyQ9CCFZeXnKshFQUSdsY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LkCEUSKh5UN7Aix1LCN46EIF1qC41jxP9tdfha2SggKEWUKYkBkS3WhiyHU+CCee6nrK09lvANt7Fa1KsBx1wyD36r88KIEpV8zmUwtbet0y33P7+iQpMrFW12caJC5y3B7e56tpdnINmw2AuKubXZG241Va1ExomrF3nGkLTEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Atsa1cHk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rNqkjgze; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Atsa1cHk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rNqkjgze"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 9C8F0EC027B;
	Fri, 24 Jul 2026 21:57:07 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Fri, 24 Jul 2026 21:57:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1784944627; x=1785031027; bh=C70tJI91+C
	9mJCIn95zHNxrpUZrfzJNRjPXMXnldqac=; b=Atsa1cHkMqWliftucwndbXVLcr
	mhKSYK71V20jvm8eE2TmIMqF09i8nMd+lzFihbB6OP7PDeDCSnACVcBIh3ZtKJsN
	8hxKaNxoKensPB3KO6ymzmYZQmZnYmJBVM6aT/7FMd3nVEbxvKkdys5ZdS/ttrxQ
	oJpQdKkv4TNeO6vpKogYMaQu6D6M5mPl191XIMwc/jW6F17kLQi/7PHa1paGEs6J
	J9dOYskE38cXon8qWRiwnw9X2hy1MCDsxgPYFUFG0sLiwZIEtV5ADE8snXf+n8w1
	jDmhzG87K4PpvUVWgPcfG+BQuDqWaMQmW1O6rvJ/GUUDiVUHun4tgUPDjNaA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784944627; x=1785031027; bh=C70tJI91+C9mJCIn95zHNxrpUZrfzJNRjPX
	MXnldqac=; b=rNqkjgzecfJ18vu3bZk3yuHvUUqrFijrf9sgcUHfQwmiTq/gFVR
	stis3MPFV0iI+CyohAkOQhkPeJmuntco9vpM0MLgDLSz7Bobqx8y0UHGX1y3+X5Q
	g7PtPdp2dz2U+BsC28lBZqRAU2J+z33fPFfQdtjPkoX9vICWeiVW0+2uXgyvTaTs
	RAhpG4u6jBlbA9IKn2OZ3xMSGIIs0XkXt1kKIDyJ6wfvdg0gkqSzkqNj4Z50DEPX
	vOBGUO33vNSCuY83P0i3RkZRMVNE+/2uVsokAeR+3evyUCxI9iwcbhHyp1m2u0mI
	/yQCEeOLFSpMrVA/DpKYrpN2eOZgtHjMRWg==
X-ME-Sender: <xms:8xdkav7t1Xk60m7FB4FSo48hUJhygRfNrKGJ3KZF-Sf95OUUoKK9yQ>
    <xme:8xdkar5JPyG6EoLqW_qCeTHOHP2LOdOTK9mPQfqHYj9Ztaq9-TLA8kKyIQ_L-DMpm
    UrDYUJTMZUYmrM0is2YSN0F-MiG9yECPtaaE1u0yR1o6ooHlUgqSno>
X-ME-Received: <xmr:8xdkarcnRTFDX6Ogh3YoJqzFNsXETkbLqVT0tUg3bRYeVEO15q56hdXq4Asm-5pO4YCC3mQQLEMpdP5BvQ94l-uPAq7ggLI_ig>
X-ME-Proxy-Cause: dmFkZTGhTaOS060CM7+lP4Sp8EHiTDAzrxIzCaeBhTTjkp3IwKt+LXIvngMBzBJEuvVmOk
    KleMpc8BOAImAoL+Oo6YKgN7yHExL2+eQgrLuRly66uVaKLguaujhJ0dDWnP3mL6U/Snjd
    yFqwQZP3J2SPZi4J10mOvTNcB1F/VeX5hAO4G8tzCSsESIytnJSmwbyNiEAsQEH/qLyWA7
    zhrXSD/esRJXS8K6Du+06cJm1kijXPGBB0RxAeWaxvmw4rQ9ZOCbvw6bZ90x63Ks+BO8+g
    8IEnViQIalG0jtk2Adm28Pkw6Whh00tJmF6wHY5LGy0EL/CVilDHAgc27sQWay/QYXnLP4
    p/YZno9f15lgFXlpUtvhbJjhmQsMITEpqzrx35EW2JwW7TvTuPqVahYr29ZgPS++vXduTt
    cHUca1fpMaeCljfMhuxGw88gQHgqKPG0wpn3t7zT1Fb/qj48mc9+tuZiFrN+/0dGoNjDzD
    mrbE1ygWVfg8uPD0/x9zZWGMtFmAKfGmuUAupmH9uqdCoKD3hUcTsGrX7Ni1+KguM+xfTn
    RywwV6wWp/eis3APFHALIu3wXugtDDKY/nBWcyC28NQODz+fF1tbgX/khSlVTEqQO47Ddb
    7BRbuIwg/ndTLF99UoRTSuRrKyc2vbJMq37HBnwHVZYYiJl/taUYjbDVLAWA
X-ME-Proxy: <xmx:8xdkavBg9EPxabM8LJDHWMwh4nUAXuhL-KRZ9Gm1dRt5GpeKa0skEQ>
    <xmx:8xdkau8bpqh2l5LGVJxs21Zptp5ROScBnXrekPRnMJttFBniBel_zw>
    <xmx:8xdkaqLsvFydaMMv0IYbjRZn8wXRQY7CDzaedm9pr8uiiY7WVSLWcg>
    <xmx:8xdkanhgTWJuxRQ7I5Yj1WjVjTciySpjk_QmbCG1NGZ3gEewUalS9g>
    <xmx:8xdkal9IPvBw2Jo9CjtKWx2dEBiDsnmj1xGrFj5rQ8q5HufcY_p8YncB>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 Jul 2026 21:57:07 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org, Ted Nyman <tnyman@openai.com>
Cc: =?utf-8?Q?=C3=89ric?= NICOLAS <ccjmne@gmail.com>
Subject: Re: [PATCH] remote: plug memory leaks
In-Reply-To: <xmqqv7a33nm9.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
	24 Jul 2026 17:43:26 -0700")
References: <xmqqv7a33nm9.fsf@gitster.g>
Date: Fri, 24 Jul 2026 18:57:05 -0700
Message-ID: <xmqqbjbv3k7i.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> The in-core data structure used to keep track of
> 'url.<real>.{insteadOf,pushInsteadOf} = <alias>' settings is not
> properly cleaned up when the process is done with it.
>
> Fix the rewrites_release() function to free not just the 'struct
> rewrites' instance itself, but also allocated structures that are
> pointed at by the 'struct rewrites' instance.  One of the embedded
> structures holds a 'const char *' to point at a borrowed constant
> string from a configuration callback.  Since the code does not
> modify this string, stop copying the value (alias URL) before
> registering it in 'struct rewrite', as nobody is freeing this
> member, to avoid leaking the extra copy.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>
>  * These are not recently introduced leaks as far as I can tell, but
>    the new tests in en/submodule-insteadof-remote-match expose them.

It is unfortunately rare to see all CI jobs pass, but today is one
of those days ;-)

With this, and everything in 'seen' reported in the last edition of
the "What's cooking" report, excluding the
'tn/packfile-uri-concurrency' topic, CI passes all jobs.

  https://github.com/git/git/actions/runs/30137079882/

'tn/packfile-uri-concurrency' was tentatively excluded from the
above as I made a random guess at who the culprit for the t5550
failure in

  https://github.com/git/git/actions/runs/30130205851/job/89602846186

for the SHA-256 CI job was.  I have merged the topic back into
'seen', and the resulting CI run for 'seen' is here:

  https://github.com/git/git/actions/runs/30138777784/

It has not finished running, so we'll see how it goes.

Thanks.

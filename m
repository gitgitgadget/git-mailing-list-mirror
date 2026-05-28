Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 920403EAC82
	for <git@vger.kernel.org>; Thu, 28 May 2026 12:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779971003; cv=none; b=NO7LzgTI98nljfshTyN7J+hdY04XbXorSydqrs8zVW7aLJ5CDVWjZD0qIwCoIq+Ot7+fa7iC+cqp0M5mqE7WI7XvV06IcmeceprshFupgSf7lWQqjRCFntk/EJ45BCjXYYDrRjjPlj6fBxKHQ2ZadBOL6sSm3bm4N91LaqdMpck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779971003; c=relaxed/simple;
	bh=W7PjUKsvkI34jQWTHi3qch8ptm+boUiuZPMonUfddO8=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=erzRkGk2Z6icuBQjt9BoBwBHBsOy0p7kjLMxKdiBIOppQAYjD/HfsWbK4GHujGTiApmafRumd5KJc3ixhdamXMczurfGA9j5bIYGgPl/COH13kYEYnJ6TOlu8UwCgaqdrKanLOWIcmm7H0YfFloGmWUmLqWjJgT04W4zKG2U410=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=S3HCSiX+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uMTQpxzX; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="S3HCSiX+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uMTQpxzX"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 6BDD41D00058;
	Thu, 28 May 2026 08:23:20 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-10.internal (MEProxy); Thu, 28 May 2026 08:23:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1779971000; x=1780057400; bh=BaG6sGfVUF
	RZHTXnCVkSEKfT1jDajd4kqqh6ogmWFPk=; b=S3HCSiX++CSPRJLCzLs3tuyZy3
	wLumiz0TdLLLB0u9dfLgPNmee4Ta9GGIM5btXaPTs0E2vux1rGcacth6wBHzC8Xn
	n295TXdorr4OMCPcWExpCaq4ZU3JgbR954KiqGJ3YC2jlCBOf3zAQbUe++gUH4SP
	tiiCKgIm7PMrox3Ab/EajcGv+0NlMHb6jbXX5mS1pqB562DFbH3GZksJkryCuTt7
	gdgsx8KalWfBsAR8gbsuA4SXv9c18+tWZenmgs2KEFitXxQg3U7CJ+jGrne+uKPU
	XfIlD9LvQiJiM14d4tlBu52M7NXu7+laKatbStLwzQlHz0PB8DxvMKGU0XkA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1779971000; x=1780057400; bh=BaG6sGfVUFRZHTXnCVkSEKfT1jDajd4kqqh
	6ogmWFPk=; b=uMTQpxzXVrIt9mIxPBp8CFEZs+YaWhnRJgRK3UZrSAXTOdd8VCb
	/Inyjb35gZLz5iLm+MHzY7mjqaYTVa7Bveew5NBQlniupLQCB0+OG30P0aKzrdq6
	b0A+1ZbfXxm8iM6qxAWEMtnumlI0aNa8OXIWx8i+4ePLNs2dHNkPuMp6h7NuyKb/
	RCshTjpl/ihD0+e5sRGcAl3cP3u82kxoIT7HdoLJDYtJhRTH0wY/R+zB8j232pY+
	RhO6cSvNb5iRW5zJHr4dENUNP/5ETHJ7MaWSeRNOMNqIvwGYxLQGoyJY7KEhHBSL
	MWVEiGzgEYKz4xYwnQIHkSsoM7+T/z88wmA==
X-ME-Sender: <xms:tzMYalXgFoQFngNaLk-SkvuMmL6I28_9BCzUdmSF1Wfvj7T9t1cdNw>
    <xme:tzMYasfI0mrl3wdOiw_Lkd_Bbd-e1FO6qxgo86MR0LB0EIPyqByd0lC54fni2gY3I
    tb9qfA44ne92dWUbzQjW3BxxmGBqFCNvetTpetoDCp4KSVeiTqMMQ>
X-ME-Received: <xmr:tzMYapvZqCiUCLLNkYNQ713TAGeNQbnWsJWl-UMARMqvJyDpNGLGLrtOLwZZUHprDst_ICjP8iROuOKlq9lEUNe1vISISlxbRLgsUNYStQ0L>
X-ME-Proxy-Cause: dmFkZTGEAZ62DvyJFrij0ii32smh/+n/i3VCwQI7lUhkykGud4M6C+rS6t345Q+2I3ccJ+
    Ef8773GLuPm3+qTEnD+9zzPA6JIHuLEJ+uyvO+Z8aEy1z/CMbSmLECYg35F96aHRpJrs6L
    4s86jCBOENBWur4ojhDQyYP49FV7ZPIrHSU1Dd+EMCOpeFk6c24w4KEQKWZtcOYfXi32rb
    BObghMkRTzEtkG/xY2HntlPguDTCWQqmTChccLIqfkqBqLzGnK3vNTTWXdw0F6jGRU0snN
    ER9LlwNpFFKkWHBxCS66JuOcNc17TzQiK8YJSdxHxKFBpU4q1QqPwOytEwI2OAnHdyE4SV
    WrVakvPPMRIXjLuJuitQ6Rt2NSgUxgMsjnXeJK8S0MmTnVUrPHar5SPTQZA4K+D1hYnw8+
    7Mm37vMPgC4oC6dvMMBI0Bf5lkQMCTJF00PjbsveixHnV0PDLW07UBA66odTTIwsRypkxJ
    loEQgRJiDRHaTSaQdyTGhGeeGRy60iFjx05AZAVDCKL557q6mepHHB9q52oeAPdsBcTBRt
    niyZnUWEvIyo8a0g8/i0O4KfnPkMI3eNiUh4a461/nYH8INQj8ccBu58M29qlPk8+hpcsE
    FYGBhJ37vMpcKMv7uZ9xXE3bqPJ1MOjOFv5d1JinuaWj8o2cDAC64xN17Keg
X-ME-Proxy: <xmx:tzMYaj8T640E6iZ5A6O-jyz4zC8-uqBAqE5fb9ro0QPggqX7mCS7VQ>
    <xmx:tzMYas2IizXonaRv9KUISg7Io2HL38tkeP_qf3pej9tb0o2sHw_eew>
    <xmx:tzMYagDHSRBdWMbfoUxBmWjsak58VYpfWfKBixX1GlDOiApFuFS5Xg>
    <xmx:tzMYagcDbQKz_i6ZJdOUjlT7QybyZz5A1_a7gpD8tTVV9GZHpd8aYw>
    <xmx:uDMYarB6267qdvTcJbXAPXuASeD2y9NWU0qoFiSseNH-uF6r7cgxahic>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 28 May 2026 08:23:19 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: Joerg Thalheim <joerg@thalheim.io>,  git@vger.kernel.org,  Patrick
 Steinhardt <ps@pks.im>
Subject: Re: [PATCH v2] config: retry acquiring config.lock, configurable
 via core.configLockTimeout
References: <409d05a5-235b-6b19-5a33-a4e613dd447c@gmx.de>
	<20260517132111.1014901-1-joerg@thalheim.io>
	<f449d0db-0434-f870-c69f-793f2b096816@gmx.de>
Date: Thu, 28 May 2026 21:23:14 +0900
In-Reply-To: <f449d0db-0434-f870-c69f-793f2b096816@gmx.de> (Johannes
	Schindelin's message of "Thu, 28 May 2026 13:51:42 +0200 (CEST)")
Message-ID: <875x47u3il.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Footnote *1*: In general, I am quite wary of unit-less numbers in
> configurations.

Hear, hear.

I do not like unit-less names for variables that store numbers, not
just configuration but in-code variables.  In the longer run we want
to clean these up.  In-code variables are much easier to clean-up
than end-user facing configuration variable names, of course.


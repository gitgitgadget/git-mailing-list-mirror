Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767AF4AEEF
	for <git@vger.kernel.org>; Mon,  1 Jun 2026 23:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780355137; cv=none; b=lR/+xONkZPXec0QN8g/fL1d9YyYcgnrTXa/3P7Djvpi/AJhCPTexACfLbjD1I/2qg3ckR4d55gGPn+SnDTTo6khYv2vIkzoVUigWD46OAIKhRjOHLO5t2BepE5IeLF6Ll23LHouLZvyaof+XpsSpRusRMFYJMqeNdJC/ThYVF4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780355137; c=relaxed/simple;
	bh=v2AqZbVftNRWqeQIaVTzRx85tykfrYun/OQnMierTmk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kbu+t0LXC9Y0yI3QaJct4voaOVFGKJXHMNfUwPmtn24abd56+mBRI2OCPwoPn3VChEK74K5vlvj+bSeqEOkx9hCmu7pxFgtXgUDDgbx6WeHRauTCEUwNeXsJ7k1X9sIcDsk+Y2DXsa/AVBuWINRrVJ9Y49lV37iYcGH+g+fEQlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=f7pEHNjf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=X0oBXSb5; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="f7pEHNjf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="X0oBXSb5"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 7B4311D000B3;
	Mon,  1 Jun 2026 19:05:35 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Mon, 01 Jun 2026 19:05:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1780355135; x=1780441535; bh=iOFy/c9wGP
	WU574BQ69wfOQy1aMt4PWxMMPFFY1wFDk=; b=f7pEHNjfWDnxloLd3NJD660UGj
	0iMn4zjOXkgszOBjJ4vPe9DqCEzwLirRAIz3Y7JQuP4iHMgxLOG3ZladoXkTX9vM
	juDwixd0WXCFDrMOUearsOCBVUGzpW8DETyzpiKzvvwg114pur370cGK+DlPBfcE
	0jOmlO9Nf5E36m8QVJhkG9XaEzc4YqVnNeY0x5fa6/vsn+YHnJdU+0CWM7vsrigy
	kriWZ8G2OsEpQFrW/63Rk+bDxDzWjUjchKuK6jspl4lUK3uFq2zR13k5HLkMH0kh
	mcMcPMyVHQoVD9HLnW8GERXrm8lInjXr/7X6+Fn1AiVLuET0xjkYOW7qla7w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1780355135; x=1780441535; bh=iOFy/c9wGPWU574BQ69wfOQy1aMt4PWxMMP
	FFY1wFDk=; b=X0oBXSb5QnQIW8qA8OBi84O8ouHtMyQW496Q6VS//Dl5DeIYVdt
	wTzUtvGc09QYkw0fYf3kLNuhKtsYE4oV69XpJ8d7nn+kjveIOyPdOn4q4OboLW2Q
	w1FifQK5QBNrjCNUaR4ZZYy1Njgh2sh1p8q8H9ZyYSwxltfLs6a5xKsIO82fkh/L
	6uldHOadrou5NTGdOPEeoV/03yK0in70XMDcj+mw3H4FSevkPoyEwBV1eK9gPaGB
	u+fH7ixxukzim4e8MN0g0DNJWMEXEg8uvxUCmp12quOgkNbSxoZYEaxGG8T8GlYB
	yIqU+LRZhoVK/fLSS+sJLgA38kRL3emXgKg==
X-ME-Sender: <xms:PhAeag0USD8ZKc-hFT2WygnwBVMKk8g86Bg09lFOtY7cLLfOMWKc5w>
    <xme:PhAealtnMPfz-PdSucoLv6kPaimBGsDrVroV4Vtm5zUixSjFGbV2CzTZvqW0iL_YO
    8sOJDG2UYZVczXhhGACvHkX39Tfb60jB5i0_PLjzv1p5HtO3JWbA2E>
X-ME-Received: <xmr:PhAeau55_f-S7wxdKkuX3APjLurqKQK6ViteUfGvWwsOTZL5kNLLoB6-LsW6dxy3mS9JfyqTCqAuJ88PBLyatdF1ta3h1_KR3Mr8>
X-ME-Proxy-Cause: dmFkZTG4no19UXl/6aL7Hw84+ApDksOErCDEZwCJ401+i6cQeAYgF1yanASJ6819HVHaVz
    wK+H8pJ6fvCpt7TtBQfHKWeVZIRgHLMMg3VgJkee0UJb9YfVQbgIM+v+WJjEmCH98KBm8J
    5mZfLIKRXstqUgd/fbPZmLCCiuiG1KqUtl4AWYsnLYYiquPuCzbwppSICk/K6HpAgel8Kn
    MGShmAIivxg9c/Hqw53sPclmy5URiwjJF652KjF0RR6YUcSVIvTMjxLMG38prWyUd4GZto
    TIktAu+3pnc8LXP7m1CGaCpg/x2q/U+1QRFwDxDDYT7fBPUtkdzxqUTCYeRv808fjiIuA9
    p/MSJY8A1yqb0jvEWSLNh6M3jLCpwL8Z+IxqtR4dBPCS8rqQ2LmpiUpgY9JWmecVoTtybm
    hn2PyFfWJS9YYJSWwQkpXVxalAS/pPjY3enYHxtrVE5WLyBcXlHKhBRs9mxDYvQ9FNMX9/
    LBb/eMukNxFNd8Gj2YUHBfX901G41ekfk/CN3LNhFivt2Nx8x/E24aDcIADYbYwukxzpJ8
    lF4nv/2o9Qfsi/invFu5CYI8U3oeXsIo13wCzyncvQeIuUkM0NjmtPjHbZqAQgxvKdcCpD
    ndkcBQwU1+1IJYOOvAOn/TzgpdHIWt+N+uDe3XP5B3ZLhDFcrKvB3ErZO6Xw
X-ME-Proxy: <xmx:PhAeape6507UEWL0899BhZy1jjvjrv6QTWMYbPzof879YMp6bu1rTg>
    <xmx:PxAeajwDTjdEnPYIPiakf3TDcmZhe-96ZzkkeVdcXxBhjJ2TCHlLfw>
    <xmx:PxAeam-BFRrWjG3NWI_RmJqeJDqyLHF_QRVZogP1qJe4_FEm1NoM0g>
    <xmx:PxAeapzXOjJVqBAP6JcH7oQCo1hn89sSu7XVq1IpIShgamQSewr7Kg>
    <xmx:PxAeasfBmxUmMpoPTLqTw8JBXHWL3QVERYK40aXLmzVmN3JbJY9TyFic>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 1 Jun 2026 19:05:34 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Cc: git@vger.kernel.org,  jltobler@gmail.com,  lucasseikioshiro@gmail.com,
  phillip.wood@dunelm.org.uk,  sandals@crustytoothpaste.net,
  kumarayushjha123@gmail.com,  a3205153416@gmail.com
Subject: Re: [GSoC][PATCH 0/4] teach git repo info to handle path keys
In-Reply-To: <20260601151950.30686-1-jayatheerthkulkarni2005@gmail.com>
	(K. Jayatheerth's message of "Mon, 1 Jun 2026 20:49:46 +0530")
References: <20260601151950.30686-1-jayatheerthkulkarni2005@gmail.com>
Date: Tue, 02 Jun 2026 08:05:33 +0900
Message-ID: <xmqqse75275u.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

K Jayatheerth <jayatheerthkulkarni2005@gmail.com> writes:

> Hi!
>
> The first and second patches are self-explanatory, so I will
> focus more on the third and fourth patches, which introduce the
> path-related fields to `git repo info`.

I sense that a paragraph or two is missing before that.  The purpose
of your cover letter is to _sell_ your changes, explain what it is
about, and get your target audience interested enough to read the
patches.  The above goes totally backwards---your readers do not yet
know what the series is about, they haven't decided if it is worth
their time to read it, and you are telling "go read first two
yourself, I am not going to tell you what they are about"?

> In the last discussion [1] we had on the mailing list about paths
> in repo info, we didn't reach a definitive conclusion, but
> adding both options made the most sense based on the feedback.

And again, you are excluding those who were not in, or do not
remember, what was discussed in "the last discussion".


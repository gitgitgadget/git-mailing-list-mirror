Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB6E3E317F
	for <git@vger.kernel.org>; Wed,  8 Jul 2026 20:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783540972; cv=none; b=XcAC/H+0CzAi8suujyI1M7XYrQy9xMjkRyA+J6/St0NhZxtdiCGRGATa0/YGK4vk0C/mrcKA9HckPePvJXagyJj+7wZILsAld0U2kL59IcjEAo3lPZoBl3zaZYGhdufv5hTAZuonZxY16aVocD5/Ep4U7AQC3WJKiAu1UL/gvrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783540972; c=relaxed/simple;
	bh=cq9qgXXRLjo7NXR2jSZ+pjAzUT5EfAZqDOlVdT+/zno=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uzv2BYDiQ+NNCmKls+7prX91Xn+Nq7aXF/c8AloRvIW1i2pH9nDWZmxXHI0wceN6H49dXX9QHEbuzhTUCZ422GWtMmm3Lv37Ia6gCXppEpCZwXyMQXTD9xa3jZllzNnUeysgXj9uITe99PPI98saB7GRXal+RJjo6XDi94rKxKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=iKi3kjA2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZH+Q5+YK; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="iKi3kjA2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZH+Q5+YK"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id AC7631D000D0;
	Wed,  8 Jul 2026 16:02:48 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Wed, 08 Jul 2026 16:02:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1783540968; x=1783627368; bh=SJdhsDjJZ0
	yH2GEM5/8Qh60XotR7VK6gGwmZOvXrzy0=; b=iKi3kjA25NpZc/jf+RjfNqwV3I
	tjslmcpqCwUjvslkG8Of0ty9YIe159/U1BsQhkzXyAKIMcoSJOrTwrHOim/IhPLu
	kfvHk1xx3zzlyOUjBR8OrPme/Z0qHKNx5CynSSYJxqFvT4IaHEp4sXT2XFjlbqG9
	jKF4+oNiyUf7MkyhQeALKqH9N1CAeea7rrsK/npbaHwosbJGJcB5uUelOz7hQlpO
	hhk6QT13bVanxPGIaD2svPEi5MdqAUEuppuguLwRmKCS/MEJV/SvC4+SlZAaHkkZ
	2wdM9u9W11rh1jL0FTDO1vffTIKZS/SLIlNTvisIfcfCaj11cC5g0rhilEpA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783540968; x=1783627368; bh=SJdhsDjJZ0yH2GEM5/8Qh60XotR7VK6gGwm
	ZOvXrzy0=; b=ZH+Q5+YKk81gAGovs8gVM5f5QItsXSI4aahbFxlylfEFkXmQyzL
	YaozDqVDsnXMPaNm4Yp6/iz/yjsrvBM8X8s8luXc2zFoAf3NczZLXDmw2HTtn6iG
	O1xnzdWn2GdBc9HmKdawhG4m9zkd88ZeNy1sMfqe3zMUqySBnbgbympfsX2fWyDZ
	9X+y47zgYBBfXJAAlgeK3uFQT2ndcqQhCIyqHqXPnXcLCh9znISTBaFQYJDfzIkw
	NF1Fd+7gBTYJApuZtqqL9Ei8TzpxlWt0Q4+lN7F1iYL8qQ8ch4t46GReghOVBGm8
	ix66K5zilEb/0TZnsIPNV7RHKVFv5QkfqIg==
X-ME-Sender: <xms:6KxOalhY0vi0q9pL9S6XFP8VJvq48jEGR8xe7ReUgSSRdTdDZtGumA>
    <xme:6KxOahBuPRHxmJywbmixYbTkCc5bSLy4IMIZB_jINrkQhz-UxJY2uipu057ObM9zc
    j6IPH81Nbqon0EVgEoThojCHAlEj0ZgU7rz0By-DjrpiYLxI5KrzDk>
X-ME-Received: <xmr:6KxOaqFKtEwQLU1PM5jj9fhXixMjlcYK6WoWfT6ymiLRBBKDIRTsK7KrTgSVFYQiQjEGOAaror1q8gIdfrEjd78CrmxIMokmv01GIW0>
X-ME-Proxy-Cause: dmFkZTEcki6L6qpoLMhVZ80ZtNPyC+oqhde7VogeGbrIACZCkJf32So6kRBFhWkCFhMtbi
    qUsIQB8qg0ozcpaVKcIUvIlDfPw+iUAB7bQXD5lYINuF1M3iVe9J2b22jUdx6xYxqajZoG
    3kNmmsVLjuPwwmDTY+9Sn49z4CVNYxJv9/BNQEWMDJyuvduW7tXpwUL02+bxBeCQjqAZLX
    +X5iobd2ttIKdyel+cF9F2vhYzi4W3r6bsUvpeImK53ZsNoTJuID69rv/Z9iLrChPBaUo3
    /rN+t/m4QZe04MO9vtQVt/VmmL8PLueYXSdkh9xCeC5cPIPmckF4YD0KfEa9YPbg3Oloie
    HS4bLW/UXGn9iorNFcDLDhYLtiiQUuFxx5fe2EH+osIe1Uux4dsVPYEQZdn5qQ4Inrhxtj
    5/vFtkEoUoD5tq2zqGaJHd9IBsvtBluYB+WXk5UXXx4MsluOruRGgV28Muv8xppOiRy89c
    Z2Ak/ODAs8iQtbV7ndF6V8nfe9ywVSXPfr4P+UY4GcGM4Dfpmka0+nkbHXBqnG323/gvwM
    MPHr7sswxvhtKmJUznsEu5sv1cc1ssH679nC9BSN/Ky5EZZ3BhdyqRgyKVL1cludJpi/40
    W4uhowSp5kx6SbKKUOC45yfmwdp0FQYsuE2lWzAh85+dZ0+mjCMF5MALewww
X-ME-Proxy: <xmx:6KxOapJ6XOc-3sHdFnkUCFR53wsU8RWs6ag0qwSqGwZSm6KFygHoZQ>
    <xmx:6KxOaumRWOAG0Cf_s2zthGt8_T2n5dwjuDSyQEKyvKdfj77hb8qSsw>
    <xmx:6KxOahTEL_hlH8BaXFXlgLWa6PqNX8_f1XkkymLvnyLQCyNVTfxlVA>
    <xmx:6KxOagKI2zgcEQ6eeRUNC2I51I1VnZSNIxHwrqDg6qKT4y_16o7G2g>
    <xmx:6KxOahmkYWbyCta_x_M9ROXry8XV1AYvWLtOYBxJUxUBmftI9PqE8dxw>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Jul 2026 16:02:48 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Michael Montalbo <mmontalbo@gmail.com>
Subject: Re: [PATCH 2/3] t/lib-httpd: make http-429 first-request check atomic
In-Reply-To: <efd34c17157b3183cdc851c8b17e7967b6c85506.1783479584.git.gitgitgadget@gmail.com>
	(Michael Montalbo via GitGitGadget's message of "Wed, 08 Jul 2026
	02:59:42 +0000")
References: <pull.2171.git.1783479584.gitgitgadget@gmail.com>
	<efd34c17157b3183cdc851c8b17e7967b6c85506.1783479584.git.gitgitgadget@gmail.com>
Date: Wed, 08 Jul 2026 13:02:46 -0700
Message-ID: <xmqqcxwxtfkp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com> writes:

> -# Check if this is the first call (no state file exists)
> -if test -f "$state_file"
> +# Apache can run this CGI for concurrent requests, so the script decides
> +# whether this is the first call with a single atomic "mkdir": it succeeds for
> +# exactly one of any racing requests and fails for the rest. "permanent"
> +# always rate-limits and records no state.
> +if test "$retry_after" != permanent && ! mkdir "$state" 2>/dev/null

I think the last sentence in the above comment was meant to explain
why the new code checks the value of "$retry_after", but it is not
clear if it is needed for correctness (in other words, the original
was wrong to do "test -f && touch" but also was wrong to do so even
when "$retry_after" is set to "permanent), or if it is a mere
"optimization opportunity" you are taking advantage of.  In either
case, it would be nice to see it explained in the proposed commit
log message.

Thanks.

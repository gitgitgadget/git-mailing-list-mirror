Received: from fout-c4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A65305679
	for <git@vger.kernel.org>; Tue, 26 May 2026 02:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779762385; cv=none; b=n53FFk8z7MdxGcdmIKuAURM2W2JIYfZE1978/Qjhk4HFudIjOAv/q09tzDR0QM164jdNidbnHj+ylQTAF8Gh3Ak9tNherbq3P+jW0byjrHn7wq1LfV9r1lljyO4Y45s69XWMjZFQYdYzB8rexuKUQ4wJ/26SJIVsuOFaTuC3Cl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779762385; c=relaxed/simple;
	bh=F+D+dYMTOpu4JdXiqg8uuuX1PrjP6SRi+mHzsP9SxWA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kc+PkjSe7JdZMOPo8B9QqB4T+DvU05fOt/7Xi3kkrXDdJFRkvuki29oC3uSsBfErpqaTETFEJF/Ovc0n0mdID67TXjcfKmH2VnGwxKR3SnHPHsPPhVXDZKvznXrxI99zM0dZ12U+Zt4yj9I5KO9K3LIh6GWSPvLctScl+A2Ft8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=abbhb1cz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=B2ZDaTPZ; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="abbhb1cz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="B2ZDaTPZ"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id E7EA31D00104;
	Mon, 25 May 2026 22:26:22 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Mon, 25 May 2026 22:26:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1779762382; x=1779848782; bh=5SUBh33yia
	znv6mQ7zPcaJ9WIz0U1EvsGq4hbxLu/e0=; b=abbhb1czxoGN/OBGPUDSw/M/Wp
	sQKLhRUCIs8IH2ef8cy1u5FmcXrgZUtxD4Z+F9FT56LrZXkIwtoAv+SJd/dps0Q5
	oZggrtrEEp+guF1legf+iA5LU1IqovD+Y8yQ5O/5xHqp+47QoUv4ebtVHxzUBK2V
	ji0dci1w1tCAqOhkbQdOpZcKW1CPj8dBEJ77PUoBW1l2EAZKHByd+JwXIIigxtET
	Kd7eIJQo+N09ZDW9EMujg2KF8+VuNorAJMuSw+mad4BJbdPHcFaoOBWb6JVdrq57
	m1+4zCCavVRHg8FklyrdnggMxQbgPazXbx2yDp9Fd3Dl984VciDryv8WG/Fg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1779762382; x=1779848782; bh=5SUBh33yiaznv6mQ7zPcaJ9WIz0U1EvsGq4
	hbxLu/e0=; b=B2ZDaTPZeLW1wk2DJQ2LK3weGPzqwQvYZIkIU5SbBU1RElZBfb/
	OX77szkFMwIqM3xfpb0vbPs3ckE1btpX7Q8/3lt4uvl5s0vZyjvh+sOj4FGnoKsH
	p7H31mT6l07lQm+U3EcR4n+wBgbwApLV6VdD1Zs1Mekg9sYFTIEayECjV5LPuPww
	QThZYtvyPPuNBM7gKu3Z9Y3exX4r71m7hgbraic6tBGwSOVJx2JD/qd8X8a4Rsp6
	ehcEUt2QYXe95horDyYvi3q1bu72I7BwdUYKXVuTBcxypBOSEQagjdV//CWRtRKO
	S0BRrfWAPgDvbdVwYQHovi7CLJg2l4xnJcA==
X-ME-Sender: <xms:zgQVaieRe4HSOxw2Cr3GpWwWLG-WV8tBsMjCwGQZEfbp29U8NoyuIQ>
    <xme:zgQVajOYKCuAM6OP9FsG_v6JvDwuMLyaOVD_ZQYQHGsfnhHH2-KFWmCwNsUsQ3p4u
    5Bz2rbg1vTn4mOHaY8jD-WrKaA_rf0r74B37ag3hxcdQbxn1rZC>
X-ME-Received: <xmr:zgQVaoit9M9FcCu7MzW4Ohlx-nR3kM6rKVIVls3_e-zOSGi4Cs6KSZQXHfUQ1PlA9bObZeNIlFH3uRZnjaVAU3aGoSpFJsSc33oX>
X-ME-Proxy-Cause: dmFkZTFjRp2NkHc0cm5BP8RcXvyH337Cd0NlLw9Ayu6d3vdx0RD++lqfXyfKrqD508FJXx
    wR2LXwxlOq/M1MujkYCvxSr2o3U64iz4gONbESkm8AB2viEf4aD7GDO2RIlt7hbiwpT1Ol
    HSsAJbpnSXDFOp2Y8wPJPAqqyS6UzYPwGWriomY/T3R2f9aHOe/qVV/KUQbyyJkz8Cm4Bs
    QkmchfGwlmQBsUHtCZJWqN82MLnPSqxcF1lhJiZqKR9qeleveyvBnAxf0F5nt78UOUm62e
    v95I+1+d5NZcqvrFIyU47Fj6b0gDl4nDPcLcEqPuWoatsnrwcQpUR0UgbCvI3PPxzIrSbu
    52Q6muiamHQX9IEmYBQFFpocqyFG+7dRc1IGIX9s9gj+QWWTnjoI1W/nS/SYwLooIpvX7/
    fzQf0ozOZGaAUjvCzDt0Yi3/4qERB0Tjf4/qUrT639FLw+AlOiNOwa/C08AymOOj68W9LE
    x2HYJYR+lukMd9Kp11RquzKFDEUQ/NF0x6jTpGAfujdVWdzZ6MAOrlXzBIyATcjDk21iEf
    URM0IMng4zEBDqZD5MTcmUJGW1n6ucRlgIJqB174hLD9Hdr5spLdFZrsDWnWGMFVhPsCvc
    IzaQ3f/WA+Exc3ky6h4H7qoCHg8qIHK5ocp+uXP0nFXvaEMdyzwpr8Sbcz+A
X-ME-Proxy: <xmx:zgQVau0gliHsI7hPBMSFXFoqn9M-5uG2ctoK92tYk-ONNI3LakZoGQ>
    <xmx:zgQVaqgoPryE0rw160DH93_nmiHrUoxFVMI7omFj9a8w_uiDN9ciSA>
    <xmx:zgQVameNdHimiE4JreVPKASWnpUSxSXCgpk3FYrjTCbo9WazhQDdeA>
    <xmx:zgQValnSiTUADI_ABM51L3gy2tSjQZnI2Yc59a6Z5f6FT0adD_iPjg>
    <xmx:zgQVasANnbc_PWN3mHCJogC4OjMYq9sUXw27GtVyDZkUPiuhXymyvomV>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 May 2026 22:26:22 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Michael Montalbo <mmontalbo@gmail.com>
Subject: Re: [PATCH v2 3/4] diff: add long-running diff process via
 diff.<driver>.process
In-Reply-To: <c25647c6e571e293fc994e0620ca37709f680f8a.1779733799.git.gitgitgadget@gmail.com>
	(Michael Montalbo via GitGitGadget's message of "Mon, 25 May 2026
	18:29:57 +0000")
References: <pull.2120.git.1779415884.gitgitgadget@gmail.com>
	<pull.2120.v2.git.1779733799.gitgitgadget@gmail.com>
	<c25647c6e571e293fc994e0620ca37709f680f8a.1779733799.git.gitgitgadget@gmail.com>
Date: Tue, 26 May 2026 11:26:21 +0900
Message-ID: <xmqqjysqnbxu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Zero hunks with status=success means the tool considers the
> files equivalent.  Git skips diff output for that file.

Is "zero hunk" a common word or some random string you invented?  If
the latter, which is I am assuming it to be, you should define what
it means at/before the first use.  Here in the proposed log message,
and ...

>
> Signed-off-by: Michael Montalbo <mmontalbo@gmail.com>
> ---
>  Documentation/config/diff.adoc   |   8 +
>  Documentation/gitattributes.adoc |  40 ++++
>  Makefile                         |   1 +
>  diff-process.c                   | 206 +++++++++++++++++++
>  diff-process.h                   |  28 +++
>  diff.c                           |  23 +++
>  t/.gitattributes                 |   1 +
>  t/t4080-diff-process.sh          | 338 +++++++++++++++++++++++++++++++
>  8 files changed, 645 insertions(+)
>  create mode 100644 diff-process.c
>  create mode 100644 diff-process.h
>  create mode 100755 t/t4080-diff-process.sh
>
> diff --git a/Documentation/config/diff.adoc b/Documentation/config/diff.adoc
> index 1135a62a0a..4ab5f60df6 100644
> --- a/Documentation/config/diff.adoc
> +++ b/Documentation/config/diff.adoc
> @@ -218,6 +218,14 @@ endif::git-diff[]
>  	Set this option to `true` to make the diff driver cache the text
>  	conversion outputs.  See linkgit:gitattributes[5] for details.
>  
> +`diff.<driver>.process`::
> +	The command to run as a long-running diff process.
> +	The tool communicates via the pkt-line protocol and returns
> +	hunks that are fed into Git's diff and blame pipelines.
> +	If the tool returns zero hunks, the file is treated as
> +	unchanged for both diff output and blame attribution.
> +	See linkgit:gitattributes[5] for details.

... also here.

I do not know if you mean "the tool returns no hunks" (there is no
"hunk <old_start> <old_count> <new_start> <new_count>" line passed
from the tool over the protocol) or "the tool returns zero-hunk"
(there is a special "zero-hunk" message to signal this particular
condition sent over the protocol), and this description does not
quite help disambiguating between the two.

If the former, then avoid "zero hunks" as it sounds like a noun with
special meaning.  Yes, we can say "tool returns one hunk", "tool
returns 31 hunks", etc., so "tool returns zero hunks" may logically
be correct, but "when the tool returns no hunks with status=success"
is much less confusing, I think.

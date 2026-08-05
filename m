Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9C93CBE66
	for <git@vger.kernel.org>; Wed,  5 Aug 2026 20:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785961578; cv=none; b=mvKFttWqQs7SVuHyZoYMBIWwOcH+ileuBfHOeod7aaHRBb0hQ2cNiJd1w7psynxBDQQJJ2ouY3lvsOoTDR7cPIb2OoFB+Q8M/xrV7COjz7u/Tq4+43jfrhvDd2j8/2rl13wJ53EEJoBFMmtNve0163Bw5cVCbrU6vnWNQVX065g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785961578; c=relaxed/simple;
	bh=hzptQkYaqeRV3Lz9y1F1UAL54xDcA4wn/MZI9oCVAXk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HvotFHugxGiil6ZF35UoSeajo9Dy+aargtcoDj5FPERix3+ecPodUnV0WWkvDOoWF+NAhV6ZHrvQe0fI4teSeREKrS1hfIQsaukLVlQylPSOBEYBld8lgAWXTmwjJVlMX9IkCmj8v/8cPuDkn9L6d4FjojtHOpsfdAkuMkdU4E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=iNDmQ2Yd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CqPLNi5A; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="iNDmQ2Yd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CqPLNi5A"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 246921D00159;
	Wed,  5 Aug 2026 16:26:16 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Wed, 05 Aug 2026 16:26:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1785961576; x=1786047976; bh=/hZBY5r0NT
	Xir4eLlNX7tYxfo//rk49p9wfALjoPXHI=; b=iNDmQ2YdBtV0y8D/6Xf66iJ5Iy
	Kcuefyjhixli5gDsp1EWhslEz+zRdkM/pKhdmHy3hqkjtAKkLJS9KYWD9vprhPIo
	TDwI3gYfBd5770/sMh6r36J1IbPHzv4X7cEI7gItivTt0Fy7qvfl9BzFPAzx1Rib
	VeMfUOTHg/+8g7XIqVAkAsxBKTNVDTmohiuGFuZNiYgaWyoWoajUqCEziQCieyGy
	qOZqXf3+HLhrtzUAwHVtBXnLUY64QSGntSlhyIRZH7fOpZ3ddtqReAbUAaX7FL7+
	ipDHisIyqnS+zs41oNtN5/oFp8RGsS+v/N52G7BZLhbqzxhcI763NBZupmBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1785961576; x=1786047976; bh=/hZBY5r0NTXir4eLlNX7tYxfo//rk49p9wf
	ALjoPXHI=; b=CqPLNi5AfoaWCFO4a3ESIRO+3X96y6EHk4fjMe7UQemWuU3frEX
	+7926lpk0UMZDedX0HcqQ5NPXbi3hTsDmo7mtm/tyAJJTTe+31eTMJ+EQn2tRcmz
	fGKFL3zgOWjq2bpFkt5w6y6qZJrv9OtXnvGb3NgQ1dpvxbSzH2QiT1M97NH+VkXY
	OMV56knfqqAhtce78/oOBUUQi9sXrjRpnzzVJMQNmvO3VyQr0xtNImnsrVzemT4f
	Xe8KiaKpRpHhe0ec7RlKrEjJ+1Bo2q1j1JfZYhGnK31BGiwvCB1IAb6r5zEScuWg
	Z9k+3LoZZUcgY9TQQDjJDGrAc7yYRRXxW0w==
X-ME-Sender: <xms:Z5xzas7P76RIZWX_U4kZqDKcrtEeJvLIV_RGENVX5uSVhqqjZCm3Gw>
    <xme:Z5xzakx14_9XtrNiqTaI5ZGi2cgQppsEgmwHrSW0URqq7PK1HVugMf57M7lobl0sv
    laHxGya_gIB3eGAGM21byf4ZTQNb16zptIwYTLaD3VH3zDrnu_qWwQ>
X-ME-Received: <xmr:Z5xzajzMXfyFy0V7vLt1A8KYp6x41iGJHT3i17yrKAFtFduwzPoC1mTaOTFJhHz1IWADsWXPUJM-Zb-StdFq4o5hqg04RJbmLA>
X-ME-Proxy-Cause: dmFkZTGDwBTJujNtWyhNDqLl9G8q/sxcF+BG6DzFwxm25TAAWSsa9lH9jXjhgzHJq6de+d
    gc4JhKn8wwnh7aYsslPtobd9I2YX4WZVLfjyFwedUmTvKKu2KxdVKA1f5l2CYXacbXtIad
    5bfPU1UIurOMb6VB1/4XjAE909tMOpUGk92x2OPIJ7kNBsF/ObBjK2zOJ3/0zB0z6YMenK
    2oSUWOsC86oEmWm2TPUx2Gs1rK8rXLPcVxBbV8kLo8ffvTDQkMkReFLMW+aHrg7r+kQ5VZ
    K+eW7BR+cn79T86Jotq0fM4ErysU8e71z7ZI735lOeJrAbzLpriYEDUB7Gz7V/EmVSJPil
    f4OSP1QkZqRZ/dBCgRRVQw5jkHB6vpCeIKE+f1itLbYhkiLKT6bmkG0IM8a3yuL2TGgMs1
    7cJXhuIBvC0po4CTpvNwSULxBzdo1Nl1kB2z8C1AtsBPHQ0VtltvI4VtKBYCNZZW1lcfTL
    EbYoPVINm9yPnenY1FRZiV7yYLeohDHx1/x0FIjTacufczCrpWgXkVrwlUWdni51U+2g7h
    fstXjZL3E9KagMEm5dt/fX27/Nmc7u/3v6npDFJGcVoEF2dKS2aggoUmWkmjAEuiUn29rc
    KxmlN3W8D9UkTMZvryDmyYO7xv1P4/BFFzdCzd4fAu7XAEgXzH2OHXQi6bHQ
X-ME-Proxy: <xmx:Z5xzaswHX46lpGfbSHUVsweqdoa90qMc6TzMlsT-dt0WufKrbEH-gQ>
    <xmx:Z5xzatZWnUwwxEB53yCS_yzKg3aosbqN_1UqHzhdRjX3cQqsNhfBnA>
    <xmx:Z5xzatWWRqC15F00SAUCnD5pBwW-jDX7G71sWGkQ575ms6HlHy-z_w>
    <xmx:Z5xzarjeJsJX-m_rCgt2f5PKzucRH1iNtkrdliTnTGQKKrDcfdrx1w>
    <xmx:aJxzajJ0u71BSy01BkeLgCbWKcfkxMtNj1Tyl-4toFgsNuFUKKFvnjoZ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Aug 2026 16:26:15 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Johannes
 Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 10/11] bisect: check get_terms return at all call sites
In-Reply-To: <9a9103096a2bd877f84502cffefd019d0a6e229d.1785954661.git.gitgitgadget@gmail.com>
	(Johannes Schindelin via GitGitGadget's message of "Wed, 05 Aug 2026
	18:30:59 +0000")
References: <pull.2179.git.1784069325.gitgitgadget@gmail.com>
	<pull.2179.v2.git.1785954661.gitgitgadget@gmail.com>
	<9a9103096a2bd877f84502cffefd019d0a6e229d.1785954661.git.gitgitgadget@gmail.com>
Date: Wed, 05 Aug 2026 13:26:14 -0700
Message-ID: <xmqqecgcpb4p.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> There is one slight complication here: One caller _needs_ the return
> value to indicate an error when the `BISECT_TERMS` file is absent, all
> the other call sites are totally okay with a "missing" `BISECT_TERMS`
> file. To address that, extend the function signature of `get_terms()` to
> indicate which behavior the caller wants.

> -static int get_terms(struct bisect_terms *terms)
> +static int get_terms(struct bisect_terms *terms, int file_missing_is_ok)
>  {
>  	struct strbuf str = STRBUF_INIT;
>  	FILE *fp = NULL;
> @@ -493,7 +493,7 @@ static int get_terms(struct bisect_terms *terms)
>  
>  	fp = fopen(git_path_bisect_terms(), "r");
>  	if (!fp) {
> -		res = -1;
> +		res = file_missing_is_ok ? 0 : -1;
>  		goto finish;
>  	}

Hmph.  So, depending on the caller, a missing file error may have to
be treated as OK or as an error, while all other kinds of anomalies
are treated by all callers as errors.

As all the existing callsites of this function need to be adjusted
for this change anyway, I would have thought a more typical way to
handle a situation like this would be to define different error
codes for this function and have the callers deal with them.  But it
seems that almost all callers, except for one, pass "missing is OK."

So, instead of adjusting the majority of callers with something like:

        -       if (get_terms(...))
        +       if (get_terms(...) == BISECT_TERMS_ERROR)
                        oops we got an error

and keeping only the single oddball caller to barf on any non-zero
return, 

        -       if (get_terms(...))
        +       switch (get_terms(...)) {
	+	case BISECT_TERMS_ERROR:
                        oops we got an error
	+		break;
	+	case BISECT_TERMS_MISSING_FILE:
	+		deal with the missing file error
	+		break;
	+	default:
	+		break; /* ok */
	+	}

it may be simpler to change:

        -       if (get_terms(...))
        +       if (get_terms(..., 1))
                        oops we got an error

for the majority of them.  The one oddball caller then becomes:

        -       if (get_terms(...))
        +       if (get_terms(..., 0))
                        oops we got an error

to treat a missing file as an error as well.

I guess I can buy that.

If get_terms() were a public function that had many more callers,
my preference would probably be very different.  But this is local
to a single file, so the meaning of the mysterious 0/1 parameter
will quickly become evident to those who have to work with this
part of the system anyway.

Thanks.

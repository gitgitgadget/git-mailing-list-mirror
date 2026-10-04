Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4DFB3EC2E3
	for <git@vger.kernel.org>; Sun,  4 Oct 2026 17:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791135739; cv=none; b=DmjE0CqmECuyBbcRWmwnprmf7Yh5V+lHQC9oLYa807frkAD+WcXWTLO9hZOXR82O5gyqvy0oWNBwxiDC5NFWEye39klwuYwh9dWEgpvhxmycV4pHzcIXJV9s968vAn0vlXJ13/8vhN46JglF4IgHi8cjjjo/IvpZWzvKvwdAgQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791135739; c=relaxed/simple;
	bh=LVvfW/vLIG1iQHSSI00QIaRvNUH4wUzI2b/gOpo6zQc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pt7yjZWLONAsiDMDVUSBPGZ1KHRlu3jTne40r1q2dJiXfErBlY0GFNDXfjlOr47/dNDQS6na1Nsd9RcuPqRRf9gXuFLb40zRqNZtH/7CbTXuZwsaOnD33x4/adLX59al5kXhHRBfi6GUcG914eyZjHGo5MtKcKgq2PTIEDStsJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=QzlxrHkg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Yp4L9qPP; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="QzlxrHkg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Yp4L9qPP"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id DAA271D00172
	for <git@vger.kernel.org>; Sun,  4 Oct 2026 13:42:16 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Sun, 04 Oct 2026 13:42:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1791135736; x=1791222136; bh=Edj+PrPAPb
	ZMTiNwqnlKSzey+uwk4+atWi8F6F3j54o=; b=QzlxrHkgVUzR77Cg9q43Y4RlTF
	Jdv9AAvOF1C8TbD04PVNdh8V7xrQOiRKTflLpC9PCJCzhi9j8iwa9uUG88tvXwgI
	m9gneY65AZ98E+2i4vOy6MzNv14sl4PxX++RHB2TWTd59lcdFjAaAq79fNrjsAz7
	WGUhm+rRZm9500W+wCF07omGcsWb4tP3dn5Jf6Ekvdx/2QZCSJj5jwPkrnAEiOVo
	sBYkL3CiC4uleRwCa3gflJCTH3V/GpjDmdjES4QqemQqiPnXDENOo6FlF94dXx6D
	XGbZR0p/XepXUSJK9rlwDx5LQNN+S3rLLCU3MqwbUJi8j9GqIaFc7C2CxtzQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791135736; x=1791222136; bh=Edj+PrPAPbZMTiNwqnlKSzey+uwk4+atWi8
	F6F3j54o=; b=Yp4L9qPPfLe/yn3JcD+R0G7H8CvI2mWC5rNwgU4XJUZqczL1pH/
	1u3DaN5rziiyD5v1tm8aT32Tinjd+sYqWbJ1gKAsy9K6whdFu1PjGTOqg/MDrnTr
	nFGe6oS8ICA9N+okM8nCtnrG9GMSoabLs0z9plvgOy0xC83J+0jQdKSZ1n38p8Nd
	9QofO/QSYzut6h3bIWkINpv0ckuk7Ghv6JbYaIlmNNNT1yDSeTRHPZPhUp74PcNr
	tXh/jLxHp1DA1PDpyHLL1NQOtcp/6vBGLWhIkYm6GimojBCxwQVMiXleUGXEDzmg
	9n78afR927TvdpOBtwDSb1XlxFRIJGKvXKw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791135736; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:J97Pa64jHykmPeWkqDSH7ZkNRilnL/HgiPqgvOJ3iQk7ogy
	nz5GxawbuR4iGS3jLbj9CCOjfHyAFiiKBk6Keqf5fIbajb1VevtMHhxJ8i/FpDQF
	MT9r0P2V70abfBe5FR/dj7V0Avirm+gP2no1h8cqTHi4gQ3WZFReexgpdc36YCk/
	unXyAdkSCPESgsl58q2f8KFsKlbXLNSD0etUgiE4220w1S1ReE3zRA/QAl8PJndx
	JrjvJfvMkHT/v0n1vagS4FbXUZyF/HhUREEGlvXX8g+1geN4V7XdDxjke/TUJQLV
	mPunsx/9PPHmltWqvSf/FnJqj65+zhTCx81Lv7A==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:8eYDxepIEDImcrwcZNi24Ml+BgWCJeig7H+RMO25EKQ=:LVvfW/vLIG1iQHSSI00QIaRvNUH4wUzI2b/gOpo6zQc=;
X-ME-Sender: <xms:-I_CaspTZbuRPcEX7-1xq6dNsVs88uDX15LkBniu2RZD5yIkWoA2ew>
    <xme:-I_Caprp0qBYqztNrCn3AzIA4V-CApmUnbDb0cqvBx0nf52LxPpdlV-aMYeI3ZV_k
    mTvy3tHLPJdLU8je-D-O5383hey3-lBAHwiHQsd6qOPfoYfvFDpZ2M>
X-ME-Received: <xmr:-I_CamPgj0sdEKKvGspS8cSNO6FibO1Wq66rHQmboucOrTaW5J0SNWXVkO39XzsCJpIQBkDcqC1L0pd31AEnvVITK6zfwZHwS59S>
X-ME-Proxy-Cause: dmFkZTG4AtoEHiFKWFpgjoaUvylTpJzJwRujhVZISUmYNaT2wIO7t+XCSR1lk+HVVrt98N
    /21vVtM/tK6n68PGdtKXj3CRffF0Qod0CGYx7atpD/cWb6Bm1BhW7RZ4g/GdFYiOfeSZbi
    CtdJKNAu1glEN78IkJUkHjQyIm06n1k8VDBhP33ZD7snzB3F2u47+vaCpm58/Kwa7ADDxX
    3EscBR28bGeeOt+VKwoahWrLflc6dBUcfAxAieK+7kB0fn8tzjW8NUaJHFYISfZgOqKF4K
    RLIZnEfzhfJeLzgfb0q/ZsD5naqK5hssHL4V3b4K5n3O7FYEdpv4YBHIQkPaDYrE/uZypD
    EXH26RJbrLnwXhXUfoCE3jLH7gqXV1+4GC18R54jcQatRu5ZoRDvNiMM+Gga822Ls8JHOd
    mD4c7tLzZ84YdVrTL6Iifbs1/XEp96CVII39+UIM9a5zm89GZ5xHg9YajPqK7WPEEFf0wD
    YdyizDGfOh1kFRY4WdJJByhESMlA3ps1QWKgP5o2rvaDOzZlUCiR0jZ3q0LHuGUODjlSNH
    iUeYNodKbZSpyHHoFuZ9byMkiOdcmVKk2UfWCGHOJDTBnEomK2ZHqIQ0o4kAcOW/zLWkYK
    YwfyLj2lQRheqx9mV0m+l97FFLgJnB23XB/0NHeythRXyQq2JYDwf4ooXXXQ
X-ME-Proxy: <xmx:-I_CaiyKP_6rorMi9aYsAkliTeE2WFbUoMUtlMO4RQPAuByvYjfXcQ>
    <xmx:-I_CanuSAo3Mrd1gchYDISSGAcszR2JI9M8NbpTOBw8RXpmmTFyiZA>
    <xmx:-I_Caj4urVtnF_kzU3kFJbBlj_-zF_0PHuiXDGi3XO8wQUlCL4Ajaw>
    <xmx:-I_CauR3W41zDhzymiJU0lwLWFRp86CIpZayaggNhMWTWW_kY7AUmg>
    <xmx:-I_Cakdh-laD6RWGyu857kg4gnCIFf-PI16BT4bOYd6VlfcOjJZTmLZ8>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 4 Oct 2026 13:42:16 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Colin Hinton <colinlewishinton@gmail.com>
Cc: git@vger.kernel.org,  m@lfurio.us
Subject: Re: [PATCH v4] fetch.c: defer fetch.followRemoteHEAD validation
In-Reply-To: <CAHeTm9PK=sc4ajmf53rhurd532OST0qYfEaS-Kc5kpGZf1Zw2A@mail.gmail.com>
	(Colin Hinton's message of "Sun, 4 Oct 2026 08:40:13 -0700")
References: <20260925230621.179649-1-colinlewishinton@gmail.com>
	<20261003231422.6004-1-colinlewishinton@gmail.com>
	<xmqqa4otvbnk.fsf@gitster.g>
	<CAHeTm9PK=sc4ajmf53rhurd532OST0qYfEaS-Kc5kpGZf1Zw2A@mail.gmail.com>
Date: Sun, 04 Oct 2026 10:42:15 -0700
Message-ID: <xmqqh5j1s6q0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Colin Hinton <colinlewishinton@gmail.com> writes:

> My rationale for this recent change came from when I was evaluating
> what calls get_follow_remote_head() in my patch.
>
> With the current design, get_follow_remote_head() is only called in
> do_fetch() in this conditional else if
> (config->follow_remote_head_raw).
>
> If followRemoteHEAD is now NULL because we set it as such in
> fetch_config->follow_remote_head_raw = xstrdup_or_null(v); Then this
> conditional is skipped, and we will never call the die(), and alert
> the user that their value is blank.
>
> To fully fix based on your suggestion, I suppose the design question
> is, should empty string warn or die?

I think we should behave the same when we see "nvere".  We do not
understand what they wanted us to do in either case, so we should
behave the same way, be it warn-and-ignore or complain-and-die.

Given that we now check the validity of the value only after we
determine that we need it, I think it is OK to tighten the rules
to die() instead of warn().  The historical behavior of not dying,
and instead warning and ignoring, was a weak excuse for leaving
configuration parsing broken and checking the validity of the value
in the wrong place.

This patch rectifies the situation, which is a very good step
toward doing the right thing.  It is perfectly fine to tighten
the rules as a separate topic after this patch lands and things
stabilize, but this patch lays the groundwork for us to move in
that direction.

> If empty string should warn, I likely will need to add some value in
> the fetch_config struct such as follow_remote_head_seen, and use this
> as our conditional in do_fetch() rather than the
> follow_remote_head_raw, to account for when followRemoteHEAD was set
> to anything. Then when the check in get_follow_remote_head() occurs,
> we know to die or warn based on NULL, or bogus.

... because?  Ah, because then you lose distinction between "the
configuration variable not set at all" and "the configuration
variable is set to the valueless true"?

If so, you'd need to be able to tell _three_ cases.  The empty
string you use as a stand in for "valueless true" should be
distinguishable from the empty string the user set (by mistake).

> Visually, it would look something like this.
>
> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index 2cb0bcca8b..af22f63954 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -104,6 +104,7 @@ static struct string_list negotiation_include =
> STRING_LIST_INIT_NODUP;
>  struct fetch_config {
>         enum display_format display_format;
>         char *follow_remote_head_raw;
> +       int follow_remote_head_seen;

That would certainly work, and might be easier to work with than
what I would have done, which is not to bother with this extra
variable and instead to have a

	static const char *valueless_true = "true";

in the file scope.  Then use that ...

>         int all;
>         int prune;
>         int prune_tags;
> @@ -177,10 +178,8 @@ static int git_fetch_config(const char *k, const char *v,
>
>         if (!strcmp(k, "fetch.followremotehead")) {
>                 free(fetch_config->follow_remote_head_raw);
> -               if (!v)
> -                       fetch_config->follow_remote_head_raw = xstrdup("");
> -               else
> -                       fetch_config->follow_remote_head_raw = xstrdup(v);
> +               fetch_config->follow_remote_head_raw = xstrdup_or_null(v);

... here like so:

		if (fetch_config->follow_remote_head_raw != valueless_true)
			free(fetch_config->follow_remote_head_raw);
		if (!v)
			fetch_config->follow_remote_head_raw = valueless_true;
		else
			...


> @@ -189,7 +188,7 @@ static int git_fetch_config(const char *k, const char *v,
>
>  static enum follow_remote_head_settings get_follow_remote_head(const
> char *setting)
>  {
> -       if (!setting || !*setting)
> +       if (!setting) /*!*setting would return true on "" removing to
> warn instead*/
>                 die(_("missing value for 'fetch.followRemoteHEAD'"));
>         else if (!strcmp(setting, "never"))
>                 return FOLLOW_REMOTE_NEVER;

... and deal with the setting that is equal to valueless_true here.

I think either way would work, and the way you outlined would be
better.


Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E708A31B114
	for <git@vger.kernel.org>; Wed, 19 Aug 2026 16:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787156150; cv=none; b=ZJvjxbcM6J63823uM5RPnzGy2UcvFr3Zw9wbXEKyZ8NRPPny1tzpiBdXSBGRJ+WLFsgj8wSwQD9ZR5TeuTEEis0Ub6SO/M96pFB/MFs3zR41uvMdY4Fmup8nP832/Ft32p7akzlQrMDH2Oa4K0PNYi8gn9Qf5743sJMyts0Rts4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787156150; c=relaxed/simple;
	bh=ed4rKFkg+crpNeqUNmA/H35EoJL8eO6b94gHHigwNNM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SwuD76ruTONEaakMx5o6luO5Gm1Jn4nqCuXene48ZBFK/m/A8pATCnVGFT7n5Pc4i7WlB+IrEP1R/E/Vjqi8SzAqElNYqgWH7MZcIeBM+f0gFa9NYySF8/VWW3GNOJOfWFpHY2Awv4+UGiss8qo5UyI5oCH7a6tunQ4RD8+qDG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=TOA2SlrA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Q2KDycx6; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="TOA2SlrA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Q2KDycx6"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 9657D7A00AC;
	Wed, 19 Aug 2026 12:15:46 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Wed, 19 Aug 2026 12:15:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1787156146; x=1787242546; bh=rT0PvXUuWy
	bYRRz1zbX+RsoiwShyh1DdZlRs7MPji0Q=; b=TOA2SlrAocg8Y4prxC7Zlnwraq
	lA+n5cFr1khW7hI+a3wwxcnic+BIO8itSzwva2/JI4vM51toVUFYuxIseyKlaKS/
	zjw63NEQgpgt1UchPr3N4gzZtBBWRlmRfxjWaV62fJYnBWWZFWuYuJG8v1ON1cFV
	p/g/8BoNgkPkhW50enyyIEaHFg6EuPwpaTSbPi5muGSTpse8ofqlqQCOyTyUeAkd
	s6O3FXfrfmYe/kd1FRque3ErQDjgqf8oAYQWsUuS2KAdbLDMLsUu4GI12QihCiKE
	bMkJC2SHbO0mJYnNiIYpYJMc7wEMjilUrCcAX/aosoq9d6pE7aC2Xqr8FPRQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787156146; x=1787242546; bh=rT0PvXUuWybYRRz1zbX+RsoiwShyh1DdZlR
	s7MPji0Q=; b=Q2KDycx6QtW+VwhrM4ErXEoxQwRpK44ceo/83gmLSbnEY6iUgDO
	8+2HrelQ48kqSxWR6NFGXNmyctynWeo6MyIXLhEFJ3Uhh75oQ/bp7JQt0i0GogJ0
	B5B8GruPDiXOXzohn3G/G02KDStuHrE9zy8YXlCQRN6AGZdpNtkxHtyHqPfHuCWy
	UXSFgIo8OPuogmjDouP7weiPQMZ7yxhB7a2mnmjOEJrzPGgLM0wLWDYBcpRscMEV
	VoV8gNQ0C1z3f3q1mHBYIUu+7FBKRVSPGo7bUWVZTfOU9y9YcyEmynoqbhd2qxQr
	sY7Ph3dYqN2Z6fs/5LtWrozXMxPIbkvi4zQ==
X-ME-Sender: <xms:staFamPvXvum8jY8WcJdrIsiUVLDrhCbdYLG5kPU2w8CPQz2_w8s7w>
    <xme:staFanPjkNrMXR1Y1JtI0Z2-P6Tdc1QgSSacRigKukk8Md6SPzvXXoVcPiWwFcziU
    KuQPdSNhpYweWyrjtr-nid0qLO-baLVPMz9Wwhac6QaVnTbCU2M>
X-ME-Received: <xmr:staFavgFUo9lHCbhLhCWGeVP2yMm6ni4V13i4XkPQPYqv-25SfOlMP48ZeVoAtgXGR_0PAIJspXBV1GRwk_Dk2WxgtJDYt-0gA>
X-ME-Proxy-Cause: dmFkZTGihyuLLUF47jqE9h6qsQPvyjtVUsLaXwEIRNxvYDphs5EzQ/1WvdOu56iXEuqc6J
    gB0v4CQcIJDamMbsfp4d7fcCKCe9CQVxqfnQf15J6ljk9JgXVnDQCuW37jgxOOA/zkS/rk
    HUCOe+Yk1i2PAjw0SgqPi00O8ajlBwOMpHqoMk1K8mlSAeiGAfWmkQkRw9fiw0nfQ5w4vN
    JSww/7dP5o4RHeA85RirHSLwoXBcQ+pxBLR7Pw2PcLVUVmVs2y2yFfsPUT5YkBK7Oypwmi
    NEKyHlOeUycQT3ZB/NJO3yi78TMPwwi/klpQ5qojv7dsCffooGG8Fo+24WPwkamGjgMwd2
    R36aoPdgVaVHxEIvKAEkDUfQxjJJ3i5oknGMo8ulEqoDkFaK1V8ISgXIdnT6zF2mFz/AUv
    n4fUZLYfBg/km5BVBK5U8Yi8ojDhTcB8VtyEccWJjhcsHDEx4FYkIjbhzDV50JelK08HLn
    Euo+4M3E4+MuCVfnuwpeOEqv9yGrgo+XPiMSaj0HJym9LYIs8KrzwKLc44GQoxGHQIpiKL
    UBb3kgP0CkSQOhnp/9yrXjhBFSYs+YbxNnupikClqX/77oOKFCvZdJl8aHYYokpdITBPaH
    9Jom3t89TbWrOQqWVHP8sQVd5Fu4eUkEllxvp5uA8uFc5ag8Ne8pxUTeDZrw
X-ME-Proxy: <xmx:staFasvImNYWruxGttau6-E-12WvMr1FG1kuY_Zl-2qlNhItfU1cyw>
    <xmx:staFatS0TBCp_6uH5mVSm0IrtNMHt2BSSg08qyyoS1ZSYdLwlSO8Qg>
    <xmx:staFag3W3LhuENA5uR-kjj0D589PRJOHzhZHo801AFVJhhIZumz0Mw>
    <xmx:staFaistLSzdOD7o97kTXdbjbbTjV7MdrCgYBVow0ixLKpZwcb8cQA>
    <xmx:staFamNCF_8thY-HRe9AbLQh-OBYyBG093y3jl0vCmOmM-qytH07cQlx>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Aug 2026 12:15:45 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,  git@vger.kernel.org,  Todd
 Zullinger <tmz@pobox.com>,  Tian Yuchen <cat@malon.dev>,  Olamide Caleb
 Bello <belkid98@gmail.com>
Subject: Re: [PATCH v3 3/3] core: convert build-time USE_NSEC into runtime
 core.useNanosec
In-Reply-To: <aoVoJ3Ijoaj3u64e@pks.im> (Patrick Steinhardt's message of "Wed,
	19 Aug 2026 10:24:07 +0200")
References: <cover.1786103607.git.ben.knoble@gmail.com>
	<cover.1787065125.git.ben.knoble@gmail.com>
	<48fceb4b575ca39346cf2f59f621584a19049008.1787065125.git.ben.knoble@gmail.com>
	<aoVoJ3Ijoaj3u64e@pks.im>
Date: Wed, 19 Aug 2026 09:15:44 -0700
Message-ID: <xmqq8q62w0gf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

>> diff --git a/environment.c b/environment.c
>> index 6676e6f5ae..c7f6b801f4 100644
>> --- a/environment.c
>> +++ b/environment.c
>> @@ -571,6 +571,13 @@ int git_default_core_config(const char *var, const char *value,
>>  		return 0;
>>  	}
>>  
>> +#ifndef NO_NSEC
>> +	if (!strcmp(var, "core.usenanosec")) {
>> +		cfg->use_nanosec = git_config_bool(var, value);
>> +		return 0;
>> +	}
>> +#endif
>
> Do we want to omit a warning in case the config is enabled and we have
> NO_SEC set? Or would that be too obnoxious?

Those who use a $HOME/.gitconfig shared across two machines with
different builds would be annoyed with one of them constantly
complaining, I am afraid.

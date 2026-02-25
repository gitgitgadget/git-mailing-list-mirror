Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D33C39B4BC
	for <git@vger.kernel.org>; Wed, 25 Feb 2026 11:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772019900; cv=none; b=rH6KhwrjLoQFMOxtC6bG0Mw3lyCqCae2CU6XXhePm1z1683l9JKOP8CACp74BNYRTeGjKkw+2a+JIUbYeeFYb5XRoFxFGlqP9Jmr2X8R5ix/ppqwrlgZwHObKlzQ8O5KqzZ+AjdIwMkgvCAYxOQUAmFh/dtQGIOOH5IBOaGFaQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772019900; c=relaxed/simple;
	bh=Y/G9oOxdpoR1XKQ1pamx8pz3Uck8q7lP4xU6zKxC87k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=THunRYjfN/Yiz7oLNu44egrHMnbszA60OM7VtgvY2CqnnARaulsYnOHlYPtvsjZmTLvboRsnim45LumGqnxrtyeUkoDWOX6lee0jX8Y2KzKNyA1y47c1W9w4Pe4liKtqfpb2tu6heRS/57TRns7R1sPnO7kLiJXekah9b6rF+Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N7gpGWLm; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N7gpGWLm"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-896f82e5961so99147396d6.0
        for <git@vger.kernel.org>; Wed, 25 Feb 2026 03:44:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772019893; x=1772624693; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J04wV6ncMKKo4Zxswzr4FsnxALlfi5RAWCouhIVxzkU=;
        b=N7gpGWLmquSqx/GqcuvtH9iSmhAoDXriuZ5ZB2kEVCaFBNtCCvveHErGSkFmuprJmQ
         ShrGYcbKQjRqXbRFWtSyInFQRnl33nnuv1j0C+U9XdWOOvzwY2bkwTo55cdQlsUaRTPX
         8XnBxZUUuiMmYeDibK+SK3i5+7Flycv9fYXmeAzSnM/gFNsaVFzhNpe2DDf1AhqmvEFp
         UifpIwY/Z63PEnS0BPTNVgyeg5ie1eSWcKjdG71/0qMJb6ku50GLGsBOltHeb1ugkf+Z
         xmP+VNd3FnoEBhoAdX2jtIOfICsaXuGnyJ+nibvvzfF+Ou+b0JHfK4XXCbfkZJGzIRVi
         EfWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772019893; x=1772624693;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J04wV6ncMKKo4Zxswzr4FsnxALlfi5RAWCouhIVxzkU=;
        b=i35BGB5+9WQDyKMnncWr5Y+mwwKs79mYLxFvv028a3u8skz8XMvEB/fAVCdyTx95TL
         O6OREGcB5pTcUPvxoCbgjIgHL4X3gjLxnaj901az1DQ4DhhvMYDG1SS6k4o0ovixgAxO
         LV4iQqM1qqtRgjR1dvn+mKWin7L9wERnDIZ543hy8Ll1cJdi8k84uxhbPD4wHfydEL2a
         3gRLBHvdtQ1HEmv27oC+bIkE4nhs0Rz6oXI7WIpWMEOctDvq1QKvaT0kz3G7coWEs0Bi
         K5BSiA7Y/D8O8aQs/Yi6KuIrUh2Mc6R/PtTihVeTKrIFJ8z2QtuswWMgHIFJhIqZdD//
         MpjA==
X-Gm-Message-State: AOJu0Yyb3EWCZNubZiGNvj7it+uNIxk4atyTBvAnRlYrnY9/VKwbadTY
	0H1zvEVM2c2NBib2e/RglX5GzNGlJFHwX8LYw4PHJvWkIjdcMjS+Z1Mn
X-Gm-Gg: ATEYQzwGsXaUVy/iaDtH8xW3s/gJ0xeNGXAJuBKxwhOPVJJ5iDsjv4I4U2fGe/bHmKb
	QOOI4plefuEXuwgLTbs3zk81HmhMl8wyeVEtp0u77PpLOfLnsDMJi+AZA9rIWBsKkzgRFyWRqi1
	HJs7dUiCnuz3/M0WCVhNx5+WDqMfAXBJuk2Jp6Omtg/z7KP4WtZErKRMYmN37P3v3EYf1km80Tp
	px8HyfHGN2EX+gqFZbtoKUJJZzmUhZKMrni3MV/6yCJtB2qv6ES3/NzBgXcpRvX7820Sn3k0lGn
	xpF49by/KoyAGh8FzJ9cDUL5qc+f4cDQsPxPrb2tppQCAKa9ryyFnoZBUuNEdrW5InVOZnIjLSz
	2jhIjAFXM42m8/DeLURO2K+zFrQVLlWcoH+xXmk3LLgBTrGpz0Rq0oGkf/ZNywAVD31rRfBlt06
	gLS8Fd6VF4S2mqaP9znuTBKePmCI1veo+09hfjorjVO2i/SgTtF2GCte0ofAE8hRkjyeaHhTgEj
	rfbTwYMAbrIOwSn+DM+5hwQVkGs1Car04UwPdZPAUyD36tI
X-Received: by 2002:a05:6214:1c43:b0:880:5bff:74b6 with SMTP id 6a1803df08f44-899c13b94a0mr590236d6.7.1772019893229;
        Wed, 25 Feb 2026 03:44:53 -0800 (PST)
Received: from ?IPV6:2605:a601:a6b4:9c00:55d0:428:5136:da98? ([2605:a601:a6b4:9c00:55d0:428:5136:da98])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-899b894a227sm17651256d6.8.2026.02.25.03.44.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Feb 2026 03:44:52 -0800 (PST)
Message-ID: <eeebc30a-40bf-40ac-a16b-ca5e128c3c01@gmail.com>
Date: Wed, 25 Feb 2026 06:44:51 -0500
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] for-each-repo: work correctly in a worktree
To: Junio C Hamano <gitster@pobox.com>,
 Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, fastcat@gmail.com,
 Eric Sunshine <sunshine@sunshineco.com>, Jeff King <peff@peff.net>,
 Patrick Steinhardt <ps@pks.im>
References: <pull.2056.git.1771903950.gitgitgadget@gmail.com>
 <pull.2056.v2.git.1771968924.gitgitgadget@gmail.com>
 <4e3f4aa6cd36f779c6c1d6b4f30bb68ed807b9da.1771968924.git.gitgitgadget@gmail.com>
 <xmqqv7flervq.fsf@gitster.g>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <xmqqv7flervq.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/24/26 4:47 PM, Junio C Hamano wrote:

> Doesn't run_command() let you unsetenv in the child without
> affecting the parent process?
> 
> Looking at run-command.c:prep_childenv(), it seems that you can pass
> "VAR=VAL" to "export VAR=VAL" in the child, and pass "VAR" to "unset
> VAR" in the child.

You're right. Here's a much simpler implementation:

static int run_command_on_repo(const char *path, int argc, const char ** argv)
{
	int i = 0;
	struct child_process child = CHILD_PROCESS_INIT;
	char *abspath = interpolate_path(path, 0);

	while (local_repo_env[i]) {
		strvec_push(&child.env, local_repo_env[i]);
		i++;
	}

	child.git_cmd = 1;
	strvec_pushl(&child.args, "-C", abspath, NULL);

	for (i = 0; i < argc; i++)
		strvec_push(&child.args, argv[i]);

	free(abspath);

	return run_command(&child);
}

> Or is it essential to unset in both parent and child while the child
> is working and that is why we unset in the parent and then restore
> later?  I find this highly confusing.

Nope, not necessary to adjust it in the parent. The simpler version
above works in my test case. I'll apply it to an upcoming v3, but
will wait a couple of days to see if there is any more feedback on
this v2.5 before doing so.

Thanks,
-Stolee


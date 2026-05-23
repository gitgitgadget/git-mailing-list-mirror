Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA9F270EC1
	for <git@vger.kernel.org>; Sat, 23 May 2026 16:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779552501; cv=none; b=TkAywjWBL1kbTByEydMOl9Viee0n+Ma16zjYw5Ivk+cOmNn1e2KYAoUe7Ck9Z9i3XbYfdjybb/GZi9/smsfrX19cC6ao0ImKsBLzYft78+vGst/oqswTs0U55+ERdN3oa66IJuFB0jZprEAIMvBQjgaUQhRr0OGpCXn2AKAwwos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779552501; c=relaxed/simple;
	bh=PLJoDz0xpfi9fdmQzpkICf9Y1SNdK9Z6PVJ1B/3b1kw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UUQy+oRZgc/VKQiKNIrnxNJ2jxkUK871lnCMBQFR0fhnKvMZ6ERCv9Ub/b/Och5RmPMDG78bGtdV/JoDk9Ly47EIM6WmW/XQChtAXHQjUPpypp+f7Yihl5NN+oxEXL6+uEWwYwQz4a3nrypmLiqCamea3Y/7Mg2ps9+8/VTxLxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iiw/V4Tz; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iiw/V4Tz"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-8ca12973e15so113894466d6.1
        for <git@vger.kernel.org>; Sat, 23 May 2026 09:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779552499; x=1780157299; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PLJoDz0xpfi9fdmQzpkICf9Y1SNdK9Z6PVJ1B/3b1kw=;
        b=iiw/V4TzYJoNKzqkNNXhUFYriEsl5qCbswYNbUSdBbgHhKIget4HmyuplgXBBWIAyi
         zsVCFd0LYsRPOP2cBYYK6k/tuPDuDQ1KdTln9orIW5rkxW8OGyjzqR3RZlZlaRCWJNuM
         25pk6BSGeCTPytDPTf0rmWYNCCyd1WfYfTMHQgZjY23Mcc8dA1T17YAOJkO/8yJuv2B/
         VuURsC9Mp6qldg9CnwJvYQfpUXXsy7vEVkwUbx3QK1J47hT0ur/o8OvGcURZ3FXwiJJG
         WR0k15mbZofB1AZnSb9/h4CG1Iyv483OBZJ1Yz+k4gAsNviXnuFul8/fMqnnxgfWKCPS
         3wlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779552499; x=1780157299;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PLJoDz0xpfi9fdmQzpkICf9Y1SNdK9Z6PVJ1B/3b1kw=;
        b=JfYVhUchCMKTxuc9bp2HQPZwTNkPvDPPBWDd992teCDNOKlMhfHqJvzdZrvw4vVv+4
         hJLPGIHdzNvOLi2Lm8GZM+xvenE+EjbbTSt1XB/FyUllfDwdd7XaY737fq4cUXxmGAMt
         X24ym6tYv4lUGOCVheMFeEDOAuPsYY+ygzUzPsiCpbYRQq5V2cA5RtMj1vWQ4tSFwd8S
         65uB7VeCuCf/6bIjtYnNI1jSG6KPqc7EwikLGo2PYox8UKXw/iQ8tpbEDRbfPjt3ZqdM
         xIsjjIV2y0CGMzBYBWP+kb+9OLndAzx28A/L9D62zRRF2KR15DnlNbNFRZle+Dft0A3t
         2/Bw==
X-Forwarded-Encrypted: i=1; AFNElJ+S+v13bN8aOzolLVw8R5h99bvV0R526tWz1kPu9JtqXL0FcZfuyNYVpLX+EG711d3Xf+Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCY4OuHl5NWleuu8q3z7eGJX1S3M5UlrpQTTb1pBV7e7r/Apa2
	QI6wB98PEG5ngiYNOvzfKLkCKeMPMhagwddYzQMZATtUF4a+9Xi+fbgA
X-Gm-Gg: Acq92OGh7bfmX5batDn15BZgh0IpAKofrR5SYQaTFm5hH2M/IXF5VeZ3WLm0dRHP6Do
	Q91QcIx5m44S4hM5p+pGZ8BmxFmWEfAV7gtrldf9HKqe8RlLD8BmgqAQUboi8I1R1zNAueGQogT
	KD7qeVhXauSyAfbuE5yfdWSD3/PTp4qVeYf6CTR/vk+XqrY4wbbrMfsMBxlSoCP9UdpzaqabZJe
	atXoAcMlFukaonx/jq+B2FWOK6L3Rwys7aj0Lo5foY42ACPd8QFl4MT7aQM7Ven2QCDoP/Q12i5
	z2QgKHS6wA6i4FhSqMKhWKvD2tY/l9JIsM27/bo1mDNHOvCGKaa+2dgCUEZyurrfg/WiKtQuKdD
	1bSxd42LEc+d3VZu5Ih6sXK6ESCw11Ck9/v0dH4DOT4pvzEQR2/5fjW0pEapGJmlEV6ZeCW7935
	G8FFonXbrw2KTA8DTReZP/OfxGtSYZ7WAJ2Q/+E59KSini7E6Y1wanJjlnHNnrIgiAvKakwJAC4
	OR6wxXJFg==
X-Received: by 2002:a05:6214:3018:b0:8ac:a689:34ce with SMTP id 6a1803df08f44-8cc7b6a26e7mr131553056d6.45.1779552499104;
        Sat, 23 May 2026 09:08:19 -0700 (PDT)
Received: from ?IPV6:2600:4040:264b:4100:d17e:f99:a560:8cad? ([2600:4040:264b:4100:d17e:f99:a560:8cad])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cc80dcd81esm50012466d6.9.2026.05.23.09.08.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 May 2026 09:08:18 -0700 (PDT)
Message-ID: <c51e5c66-6148-48c4-9d3b-bb9ed4087115@gmail.com>
Date: Sat, 23 May 2026 12:08:17 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/11] git-gui: guard set/unset of GIT_DIR and
 GIT_WORK_TREE
To: Johannes Sixt <j6t@kdbg.org>
Cc: egg_mushroomcow@foxmail.com, bootaina702@gmail.com, git@vger.kernel.org
References: <20260514143322.865587-1-mlevedahl@gmail.com>
 <20260520202411.108764-1-mlevedahl@gmail.com>
 <20260520202411.108764-2-mlevedahl@gmail.com>
 <e5a9a410-bf62-4afd-9560-2dea01fe936b@kdbg.org>
 <eb748327-6652-4477-82bb-9db9f8388ec0@gmail.com>
 <b332c7d9-c86b-4d4b-a873-1600d910a237@kdbg.org>
Content-Language: en-US
From: Mark Levedahl <mlevedahl@gmail.com>
In-Reply-To: <b332c7d9-c86b-4d4b-a873-1600d910a237@kdbg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/23/26 4:18 AM, Johannes Sixt wrote:
> Am 22.05.26 um 13:54 schrieb Mark Levedahl:
>> The manual page is incomplete: if the repository has set core.worktree=/somehere, that is
>> the root of the worktree and the current directory is always ignored. git rev-parse will
>> report /somewhere as the answer to --show-toplevel regardless of current directory, even
>> if inside the gitdir, and even if GIT_DIR is used.
>>
>> The user can override with GIT_WORK_TREE, and if so we must keep GIT_WORK_TREE in the
>> environment if it was set. [...]
> Oh, well, these intricacies! Let's scrap my patch and keep yours.
>
> The other patch that removes cd $_gitworktree from do_gitk should still
> be good, I think.
>
> -- Hannes
>
Removing cd $_gitworktree should be ok, we are already in that directory, or don't have a
worktree, and I did that once myself before dropping it as I don't really understand
do_gitk. It should not change any behavior. So, go ahead and add it wherever you wish.

But, I don't understand unsetting GIT_DIR and GIT_WORK_TREE for gitk. If we needed them
for git in the super module, we need them for submodules as well, but have no idea how to
adjust them. Simply unsetting them cannot be right. Out of scope for me. But, there are
some dragons lurking around this proc.

Mark

Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 713E9402430
	for <git@vger.kernel.org>; Thu, 11 Jun 2026 13:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781183328; cv=none; b=G0kC+meOQu34mGvpfd8+ZtBsx8J2Nd7pyTpbij0XNxpqnqplyoxGbDl3NJBFVDagUyklPxtM16W1If4aM0ujTT09DaFnfvUw+lEpgSiAK9pcpcGp7Fd7PbhglAUhhMLrpfklTC1pH28K1Qei1yNOho8IdtuLr9Yd4xqw7duIHIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781183328; c=relaxed/simple;
	bh=BH7ZpQLY5c9/xwFt+VIBeLpe4xCCJVaiT2mzb+mb3MA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iuQeOcu30bhICMgqTBOUvoZgHwgGSoZXuqT3QSmpzlUW3rn2C23tGaUNFDY70JZzN5lpSTmzN0r9/saD7RTouodAL4N5ZsByxi8BBjkEo5gqEyQHGOCOxZAt9GbiW4bO9sZRcUUS1T+TTEkfrJAvqkM8nGpP1dT5mc9jTF7phzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c6JDOtpS; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c6JDOtpS"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-915767ea2d0so609419785a.1
        for <git@vger.kernel.org>; Thu, 11 Jun 2026 06:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781183326; x=1781788126; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=699NuWffTkneP++NxN12aqJJaG0F/NUsn9Ud3U+BLTg=;
        b=c6JDOtpSuYlU4tw5c8L1YJ3dKHlkJXQbzCpqi7ajdVYEp+29J+Ugealtm2BaPWDAOW
         5R7K6qhy+g7k9TAeYtAEAAtcqSeaudxMpUNvFF97c6reKo4K0V3Eci8Zry9ETbFVAafU
         6ggsLVq0239RiYPhs451aDCqXod8lyGpZISjsiwOrxgu52xuAd/S/Z2vEfy6hQxudD7T
         KSviqXSPZK6InTrZPf2Ujok+c5Ri8urSWRpmRKjqZWo1R12XihABIq0+Ga8NvB4b+VVp
         4JM5f294mtBwPAz/+qDKUK9P6fkWw25n7PKIRW6x6R04wJaAkybCe+MyoSu9syKZToPv
         aHlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781183326; x=1781788126;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=699NuWffTkneP++NxN12aqJJaG0F/NUsn9Ud3U+BLTg=;
        b=SM/Mu5M5JIWLBPYOcZ6d79IMxxBOCum67QxxD5XpfVV3hE+9H0qLajLRIE7I1S/SHK
         DXQ4ICM4uEMvzmmc+E8R82JEuoMFP4VmLeQ4VW+UfsYqEISWI9emXgTc8AZAMW//9wIM
         JSXSKyUAhZkYw74pMdS9x+vQmNhJaYrXR+PZCnY/WhBECjXsoIvqROqV2ShnScJw1Yad
         loA6Sjx+17mGG8ii/TuasUPTki3CC3suRY2N3jXsb3AD75ZoFu7PJoHfci/5L8muhOUu
         Ynq+6e6WR9xNwjnE1bQVjIKlw38MFz1kxz/9CjMdnbgEuPO9DxA/KXMfxRzrBiVJkzQh
         NAFQ==
X-Forwarded-Encrypted: i=1; AFNElJ/Wtpelu3mAUmwLNC/JDqkgU1vtGx646a8/USAmaBpYQn+1M2vwa6JdbwBwC95vV2Dy9/4=@vger.kernel.org
X-Gm-Message-State: AOJu0YySM5QTtl1Ii+qnk2o+d9mo7Cz5+0TAoHW1NwuVreTtFqRjANY8
	QUXCAfSlykMEk3FssNGClMR2DCLIWcughCj8FCR/KDFTQo5ASqqjU6J4
X-Gm-Gg: Acq92OFZl7yHw6ubn6rAEyuR8vZEXVEpEJ7Lsz3fI+wXgjHbLvOzsKUP1COTyjuuZVh
	aZY+Gcft5iXCbqaEhZMASHtGoVQjSTmsauVF2FBfcsZsT2dwXOQ7H3kwwqQ2CjjG/uicw+YXxiz
	O5iQt+8mA6bhrS2Y29n+ZKE66jLPG8GDoXx6cigJvQU9gQs2DCe6RNLH6BAspy3mpGAEBRjH+cg
	ODEEBJZJ77Qt58LxAz2ywsmm++CcekX2+RbMtozRHDkKosuFUYxS0m7YeYykInEL3qsccHwNzL5
	WHLMVzzrPC3Rlozh2TYt+dynmT8lnaYu8hNOc1vjG8WaNx6QBVU8hTjE+5KF/08YZW5+LikPmQe
	UXgWlTlTjDBnWmJuR1wd8ybdD9lMizU0yL7iUHQ+mn5mWfJAAYyGqbdyGdaZ7dbD4MTIp/ZfTpa
	6jmZi0jiagSyz+4+e0iSmLUCTBSXaToYGbKGGkvok6+nUckZD+r86VJzGQhf++pjwe2C8088Z/P
	S9awCE=
X-Received: by 2002:a05:620a:6484:b0:915:e932:e07f with SMTP id af79cd13be357-9160ac9fab7mr376648885a.8.1781183326165;
        Thu, 11 Jun 2026 06:08:46 -0700 (PDT)
Received: from [192.168.1.109] ([136.61.86.144])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9160accaf7asm179660985a.19.2026.06.11.06.08.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jun 2026 06:08:45 -0700 (PDT)
Message-ID: <539713c4-b291-42e6-8541-a16a454518f5@gmail.com>
Date: Thu, 11 Jun 2026 09:08:45 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] config: allow disabling config includes
To: Jeff King <peff@peff.net>
Cc: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, gitster@pobox.com
References: <pull.2139.git.1780927027.gitgitgadget@gmail.com>
 <20260608225149.GB340696@coredump.intra.peff.net>
 <4d7834c0-d8ab-4dcd-8a7f-ed62c30cbe43@gmail.com>
 <20260611083943.GJ2191159@coredump.intra.peff.net>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <20260611083943.GJ2191159@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/11/2026 4:39 AM, Jeff King wrote:
> On Tue, Jun 09, 2026 at 08:59:22AM -0400, Derrick Stolee wrote:

> I'm not sure I entirely understand the problematic case, though. The
> user points to in-repo config (which we already tell people is a bad
> idea), and then that config breaks for some reason? Because the include
> is relative and git is run from another directory?

>> Or: are we venturing into territory where we don't even want to create a
>> new foot-gun? If there were another way to solve the situation that I'm
>> facing without these risks, then I'd be open to it. Any ideas?
> 
> Yeah, the more I think on it, the more it seems like a foot-gun. Like I
> said, I'm not sure I entirely understand the use-case. If you could
> flesh out an example, that might help.
The case I'm struggling with is that our build system has sandboxing
restrictions to make sure the build is deterministic based on a certain
number of inputs. A tool we don't control is calling Git commands and
these users with included config are getting errors because the build
is looking at files in the repo that are not registered as build inputs.

Files within $SRCROOT/.git/ are ignored as "internal to Git" but when
the users update their config to include other files, this error occurs.

I'd much rather that this tool doesn't call Git at all, but I'm unable
to make that change to a third-party tool. But this environment variable
would make it possible to disable this behavior. And I'd also rather
that these users don't use includes in this way, but they are using a
checked-in file to share aliases and other quality-of-life things when
a human uses Git, not "critical" settings.

This series is my attempt to see if we can find a solution that enables
this behavior, but maybe we've found enough concerns with the idea that
we can push back on the users to say "stop doing that."

Thanks,
-Stolee


Received: from bsmtp3.bon.at (bsmtp3.bon.at [213.33.87.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F954685
	for <git@vger.kernel.org>; Sun, 27 Oct 2024 13:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730035688; cv=none; b=e7V1DMBnESx9xy+CljNNO99mqIWZF55aEMLIaUzzZSBE5Hjmhd2MH/dSYgozdmjQ96DqwzETCFcDeZjzPPcN8kTgK9okwNbNJ8aW9fE+BfsfnjsZvrUM2WQ/vwcMbDPpI2GViihJ8kl9I6+vMiKP7ttQKod0N5JM3EkdhGpxjzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730035688; c=relaxed/simple;
	bh=eKGMpHqL0CK9fdXgo9/foRQWkPdy3d6DKNNuEGWTYR0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bJJR0CVpJ6kQ6moNOXwmox5b489WiZVWMNju9ToC5CwAHMyJatv83ZbH/anWA3NnpsWk31S7gRFP9kG2+EQ+Hkn9FzG5b7QAM8CbdYq46oplt1kNeRWBoEaJaZ4glSDYHfUgIy2TpESmLMymW9IL+YT10zbsKIB2ly61+tAiSLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.100] (unknown [93.83.142.38])
	by bsmtp3.bon.at (Postfix) with ESMTPSA id 4Xby4w371QzRnmP;
	Sun, 27 Oct 2024 14:27:59 +0100 (CET)
Message-ID: <4931df84-6c5b-4f48-8917-eb7cc99134c2@kdbg.org>
Date: Sun, 27 Oct 2024 14:27:59 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] compat/mingw: implement POSIX-style atomic renames
Content-Language: en-US
To: Patrick Steinhardt <ps@pks.im>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
 Taylor Blau <me@ttaylorr.com>,
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, git@vger.kernel.org
References: <cover.1729695349.git.ps@pks.im> <cover.1729770140.git.ps@pks.im>
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <cover.1729770140.git.ps@pks.im>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 24.10.24 um 13:46 schrieb Patrick Steinhardt:
> Hi,
> 
> this is the second patch series that implements POSIX-style atomic
> renames on Windows in order to fix concurrent writes with the reftable
> backend.
> 
> Changes compared to v1:
> 
>   - Added some historic digging to the first commit message.
> 
>   - Fix various spelling mistakes.
> 
>   - Fix indentation.
> 
>   - Don't use the comma operator to assign `errno`.
> 
> Thanks!
> 
> Patrick

Thank you for working on this.

The patches look good in general, but I noticed that oflags handling in
2/3 needs to be fixed.

I ran the test suite on my Windows 10 box with this series, and it
passed all tests (with my suggested oflags fix applied). I also
cross-checked whether I would observe the failure that the series
attempts to fix, and I do see the failure, and the series fixes it.

-- Hannes


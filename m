Received: from bsmtp5.bon.at (bsmtp5.bon.at [195.3.86.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D2E1DFE1
	for <git@vger.kernel.org>; Sun,  9 Feb 2025 13:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.3.86.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739106894; cv=none; b=uJCnm5lOkS11Wa3x6yncCcxxWG9V91RhtlkG+D06z5onpnCezJeF619X2V1D43/OCrzRhMfXgXjm5r1fUq3a5jDQbVwHMaR1WlSjogZHEZLTvqe+Y0zrVdILonEBFASM+wjDn3YATpCd2Ggx00YqtSOFoQKiIak/WiZVi5TzX6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739106894; c=relaxed/simple;
	bh=uGXsAFhO1rLUZCEN9a60iiAWzcVMvkmlbjAhK+y1o5E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P8x0Z9bfRuEPnbPmqAqtF2GGK0iYiT2JNB3gLabApxopSyZtwPqiae11EmjA4aK6ScO0jibSHygAwLwqqBZvGZjZP/5evYpqMRUyEbouFBurcGtW94D+wQfne0y0tdnu7Y68r/f3j6Qd18N88WQzif9j1XBpURIpJkc06w7lOJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=195.3.86.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from bsmtp.bon.at (unknown [192.168.181.101])
	by bsmtp5.bon.at (Postfix) with ESMTPS id 4YrSq950j9z7QRDH
	for <git@vger.kernel.org>; Sun,  9 Feb 2025 14:14:45 +0100 (CET)
Received: from [192.168.0.100] (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTPSA id 4YrSq20JtJzRpKf;
	Sun,  9 Feb 2025 14:14:37 +0100 (CET)
Message-ID: <c48e8fa2-cca4-4abc-95d2-234fa5c69b8d@kdbg.org>
Date: Sun, 9 Feb 2025 14:14:37 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 15/18] compat/mingw: split out POSIX-related bits
Content-Language: en-US
To: Patrick Steinhardt <ps@pks.im>
Cc: Edward Thomson <ethomson@edwardthomson.com>,
 Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>,
 git@vger.kernel.org, Johannes Schindelin <johannes.schindelin@gmx.de>
References: <20250207-pks-reftable-drop-git-compat-util-v5-0-ba2adc79110f@pks.im>
 <20250207-pks-reftable-drop-git-compat-util-v5-15-ba2adc79110f@pks.im>
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <20250207-pks-reftable-drop-git-compat-util-v5-15-ba2adc79110f@pks.im>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 07.02.25 um 12:52 schrieb Patrick Steinhardt:
> Split out the POSIX-related bits from "compat/mingw.h". This is in
> preparation for splitting up "git-compat-utils.h" into a header that
> provides POSIX-compatibility and a header that provides common wrappers
> used by the Git project.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  compat/{mingw.c => mingw/compat-util.c} |  28 ++--
>  compat/mingw/compat-util.h              | 220 ++++++++++++++++++++++++++++++++
>  compat/{mingw.h => mingw/posix.h}       | 216 +------------------------------
>  compat/msvc.c                           |   6 -
>  compat/msvc/compat-util.c               |   6 +
>  compat/msvc/compat-util.h               |   7 +
>  compat/{msvc.h => msvc/posix.h}         |   8 +-
>  config.mak.uname                        |   6 +-
>  contrib/buildsystems/CMakeLists.txt     |   2 +-
>  git-compat-util.h                       |   4 +-
>  meson.build                             |   8 +-
>  11 files changed, 266 insertions(+), 245 deletions(-)

I can agree with this rearrangement of compat/mingw.c. But the
Git-for-Windows repository has much higher stakes with all the
additional changes. I put Dscho on Cc.

-- Hannes


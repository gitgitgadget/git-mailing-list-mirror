Received: from bsmtp5.bon.at (bsmtp5.bon.at [195.3.86.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 741D0397E75
	for <git@vger.kernel.org>; Mon, 27 Apr 2026 08:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.3.86.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777277285; cv=none; b=uaNm7Wdt33dRQufsfyZRAMptBM0f0+dsXda/lP88NDxXUsD8ZdqPUNpixHF7BDFHgL8ELLdazzaaQXhhbahXGY6abUk7PUDVo1mR4Ue+jY5z/voTQkL743kRfO1XBO7th43NdeEgIDKdIDDeV7m0EClQJxj44+jRpvm2dyDdxvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777277285; c=relaxed/simple;
	bh=b3NbUeMKLh4FvBItQWLNFwXq/Q4lQ8auXPTHrEohncM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XZ4LHWCY7Bs00fUyb7yytd1ANPKG6grrKXXdywC5kHupoIC/DoYF8Ts4dr28Vz1FFESHuZFtOPhg4N0DP1i9QcwzGgJrSTubiIHzHN6atlli2rAQ05HBaN66oXgJyBOCt7d/RA3WbihJigxxkrqKBMGW/hOJzZ84NJI4BjW6iM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=195.3.86.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from bsmtp1.bon.at (unknown [192.168.181.103])
	by bsmtp5.bon.at (Postfix) with ESMTPS id 4g3wLB5YTxz7QsHX
	for <git@vger.kernel.org>; Mon, 27 Apr 2026 09:34:10 +0200 (CEST)
Received: from [192.168.0.101] (unknown [93.83.142.38])
	by bsmtp1.bon.at (Postfix) with ESMTPSA id 4g3wKz4T9jzRnlX;
	Mon, 27 Apr 2026 09:33:59 +0200 (CEST)
Message-ID: <971f19db-eb10-4c88-8d5d-3f4f7f92db73@kdbg.org>
Date: Mon, 27 Apr 2026 09:33:59 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] revision.c: implement --reverse=before for walks
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
 =?UTF-8?Q?Jean-No=C3=ABl_Avila?= <jn.avila@free.fr>,
 Patrick Steinhardt <ps@pks.im>, Tian Yuchen <cat@malon.dev>,
 Ben Knoble <ben.knoble@gmail.com>, Mirko Faina <mroik@delayed.space>
References: <cover.1776984666.git.mroik@delayed.space>
 <cover.1777249165.git.mroik@delayed.space>
 <4864ac46dd8ef4b704c29efc96c45f4e1412373b.1777249165.git.mroik@delayed.space>
 <xmqq8qa852b5.fsf@gitster.g>
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <xmqq8qa852b5.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 27.04.26 um 08:45 schrieb Junio C Hamano:
> I think "after" and "before" comes from "Do other things (including
> count limiting) and then apply reverse after all that" and would be
> very much understandable to those who know how the machinery works,
> but should mere mortals need to know the machinery only to use "git
> log"?

I fully share your sentiments regarding "after" and "before" being too
much tied to the machinery, but...

> I wonder --reverse=oldest and --reverse=newest is easier to teach
> and explain?  I dunno.
What does it mean to "revert the oldest"? Or "the newest"? If at all,
then this "newest" and "oldest" must be a restriction that applies to
--max-count in some way. Perhaps we need a --max-count-oldest option,
then --reverse does not have to be touched at all, because it is still
applied only after the set of commits to show has been determined.

-- Hannes


Received: from bsmtp.bon.at (bsmtp.bon.at [213.33.87.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F5C2D6E61
	for <git@vger.kernel.org>; Fri, 23 Jan 2026 06:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769150301; cv=none; b=TORHAWSwAmQeDBlv8YJ69cRH9R/AXGmootzladEBddPUSvSNtDGXWt07rmu4yy4xj6ft8UnxEt78hW9/34ydL/LICtroE0xkCS9Hnj80WihY3Ik5mgpzNtbrUGMQSZC/Z3iLV500ocn/1dmNl17P5s3H006jom2k+XXX1BlrYd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769150301; c=relaxed/simple;
	bh=McIC0my/BghT0wX0YVdRuztUPAiS4+0Ub9xdO8b2eRQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fN6zk+rqxDby6Oks+gnfNBgJPZ+f3T2rlf+pa53m6YNrKuAOlXsdfQdYDEiHIz73E7FqItzK3tHMhG8s8CSNXTyMjVG6A6AjXjN447en5wqlODhpqZx1Ssj7Fj82ZDVoDPtbMkJ00p7S1SFkov8OlRufs8IWS2M6P1fZQTBj6Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.103] (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTPSA id 4dy7Xw63TYzRpLH;
	Fri, 23 Jan 2026 07:38:08 +0100 (CET)
Message-ID: <13ff1d94-401e-4fa7-b247-fe8396ca9970@kdbg.org>
Date: Fri, 23 Jan 2026 07:38:08 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] revision: add --maximal-only option
To: Derrick Stolee <stolee@gmail.com>
Cc: git@vger.kernel.org,
 Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
 Junio C Hamano <gitster@pobox.com>
References: <pull.2032.git.1768703645125.gitgitgadget@gmail.com>
 <pull.2032.v2.git.1769097958549.gitgitgadget@gmail.com>
 <xmqqikctl3vj.fsf@gitster.g> <7daff220-f93a-463a-b586-dd876b51edae@gmail.com>
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <7daff220-f93a-463a-b586-dd876b51edae@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 22.01.26 um 23:15 schrieb Derrick Stolee:
> Unfortunately, it also says "print a minimal subset" which in some
> sense is correct by "it cannot be made smaller without losing
> information" but we actually choose the maximal set there, not a
> minimal set.
> ...
> You are presenting interesting overlaps of terminology and needs.
> One thing that is different about 'git rev-list --maximal-only' with
> a list of starting commits is that it wants the maximal set from
> the _union_ of the histories, instead of the _intersection_ like
> 'git merge-base --independent' does.

I don't quite understand how a union or intersection come into play
here. The difference between the two is that `git rev-list
--maximal-only` permits negative revisions as input, but `git merge-base
--independent` does not. In the case where the input is only positive
revisions, the result of --maximal-only should always be exactly
identical to --independent, right? Even if the revisions are on
disconnected histories?

-- Hannes


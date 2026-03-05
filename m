Received: from bsmtp1.bon.at (bsmtp1.bon.at [213.33.87.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 783CA2EBB86
	for <git@vger.kernel.org>; Thu,  5 Mar 2026 07:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772696143; cv=none; b=LoXPLaewEBWzDop/KbxHQWDQccBcLP3gL1AD9K4MEyHG7XgQqQ82saaZYJE5IazMRyCcsBH+mC+iEOYtZfw/ABnNPkbyxVKQWyRSAs2NlSKfd8IOI83WL21jdP5HzxsL4g/L6uk6joGKRynCnq8qnmnTyR07m27W1YnPdJmE9f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772696143; c=relaxed/simple;
	bh=nTEqt+95zHBd274l0XCWSwaoCQggNyyKfSjYTjuyf/E=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=po8rxYEpQzElNRaW2DRAPvaO2+G3a3mgKSX2vs16QvmzAe9FNfPX0e+lVyPLBsxopLmfRcBYZReJxJ7QTZtriz4THG5wgnEZDHNDxF1AzTO13rvZKhyhZvCcm1GrTlwplWrBjMsVwZkiyVWUROkkrh/JrVQJi1CATCeRi4MYTFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.103] (unknown [93.83.142.38])
	by bsmtp1.bon.at (Postfix) with ESMTPSA id 4fRLtM1pW1zRnmP;
	Thu,  5 Mar 2026 08:35:39 +0100 (CET)
Message-ID: <264862d1-0f83-4d0b-be11-d8e479c7d8da@kdbg.org>
Date: Thu, 5 Mar 2026 08:35:38 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Feature request: support listing worktrees sorted by creation
 time
To: Norbert Kiesel <nkiesel@gmail.com>
References: <CAM+g_Nt8vZX4NxPvddJxNvSRgdMWQaLg2O9xzAU1pTHa=Et-gw@mail.gmail.com>
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
Cc: Git Mailing List <git@vger.kernel.org>
In-Reply-To: <CAM+g_Nt8vZX4NxPvddJxNvSRgdMWQaLg2O9xzAU1pTHa=Et-gw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Am 05.03.26 um 08:14 schrieb Norbert Kiesel:
> I have multiple repos with more than 20 worktrees, and sometimes
> forget the name of a recently added worktree. Therefore it would
> really be nice if I could use something like ‘git worktree list
> —created’ to list them by their creation timestamp. Is that something
> that makes sense to you as well? I could also create a pull request
> for this if you would like it.
I don't think this is warranted as a feature for a special-purpose
use-case. Assuming you don't have spaces in your worktree directory names,

  git worktree list | cut -d' ' -f1 | xargs ls -ldtr

lists the worktree directories by modification time. The last is the one
that was modified most recently. That should help your memory.

-- Hannes


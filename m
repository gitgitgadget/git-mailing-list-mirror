Received: from bsmtp2.bon.at (bsmtp2.bon.at [213.33.87.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7307E1A6809
	for <git@vger.kernel.org>; Tue,  5 May 2026 20:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778014146; cv=none; b=Hu4bjrJ6SEYrIpa6t1LqbD9XLUoXHd/pWo3DV/XR4oLcOoecYqDarYZdtGxTs8QLkLnJRo93UzcyRQOJQeh3bbyJZDFVAzgWK2vCrTokyYtxw/YjWGPL5G+WykFDfx3Vp1yPwGjQr9hVy5IJ4Ue/S4yt2lnf9sHSau4YYvYxNnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778014146; c=relaxed/simple;
	bh=xZpb4ya6CNRTq3K14QBD+RTLLxfmPbMBYKaV7jQQ8cQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZY/G9jXaZg+uvcpmYh2AnhnXgbNr4N3l/CSZ/a3STMScJk0+Iyi0R/KHISMAaSAxy/G8sc5M4zxDYOZUsSAYNq8EkFWcoVHv/xldlXRML/AYrofdCBCLPws3q8Nh/+xPreQOUJnD2OF6puq1mujvAt6/5FIWNceBgSpHSC9CbO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.101] (unknown [93.83.142.38])
	by bsmtp2.bon.at (Postfix) with ESMTPSA id 4g99bV0SyPzRnlJ;
	Tue,  5 May 2026 22:48:53 +0200 (CEST)
Message-ID: <1e38fb35-f75d-4067-856e-b5c15f507007@kdbg.org>
Date: Tue, 5 May 2026 22:48:53 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/6] fetch: add --prune-merged
Content-Language: en-US
To: Harald Nordgren <haraldnordgren@gmail.com>
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 git@vger.kernel.org,
 Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>
References: <pull.2285.v3.git.git.1777965747.gitgitgadget@gmail.com>
 <pull.2285.v4.git.git.1778009038.gitgitgadget@gmail.com>
 <98cfdb87d26cec5f91ea4d8ce949512d60958e56.1778009038.git.gitgitgadget@gmail.com>
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <98cfdb87d26cec5f91ea4d8ce949512d60958e56.1778009038.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 05.05.26 um 21:23 schrieb Harald Nordgren via GitGitGadget:
> After a successful fetch from a configured remote, run
> 'git branch --prune-merged <remote>' to delete local branches
> whose push destination ref has just been pruned.

I have some sympathy for the desire to clean up unnecessary local
branches, but I don't like the concept that `git fetch` modifies local
branches, not even as an opt-in. Deleting local branches should be `git
branch`'s task exclusively (at the porcelain level).

-- Hannes


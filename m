Received: from 256bit.org (256bit.org [144.76.87.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859172951D0
	for <git@vger.kernel.org>; Fri, 18 Jul 2025 09:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.87.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752832166; cv=none; b=BJc+BSHiT08p766iJ8MKRih5bWqYe2j+cIKv4RsdOX8kr4l2cU26eSM9YK3XOoY/qHNKvo9hSZebsw4i5O9guQTt0vaw2z93HLlcmB8TcX+gZA47ZxZ3rNIFGU3CEog2Um2/K3Y9pTFWa7BcjgJ1lM++DT/nYF5Iof2CZQUDFtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752832166; c=relaxed/simple;
	bh=NcJeeatZBIy32Kzbbx0nZDSvFShaVjoh8sXJemLra6o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tYL9dvEwyaW0jZOFtsG8o8sT/b4ObXlj0e8wFXzhdVFyvahsBoitHNRkr5En8MdvfnXEU+Y4/d2KEpD1Qj2NEZdLSfIXhnFoc5x48sugv68PK8gLFDuBjsYkYffM5EysYK+AksR0B6k87cS83e7RbeY/5OjtvQaxS3GBArV3WYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=256bit.org; spf=pass smtp.mailfrom=256bit.org; arc=none smtp.client-ip=144.76.87.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=256bit.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=256bit.org
Received: from chrisbra by 256bit.org with local (Exim 4.93)
	(envelope-from <cb@256bit.org>)
	id 1uchJN-00CtI8-5F; Fri, 18 Jul 2025 11:23:25 +0200
Date: Fri, 18 Jul 2025 11:23:25 +0200
From: Christian Brabandt <cb@256bit.org>
To: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Ezekiel Newren <ezekielnewren@gmail.com>
Subject: Re: [PATCH 0/7] RFC: Accelerate xdiff and begin its rustification
Message-ID: <aHoSjbV2nMZkBn5l@256bit.org>
Mail-Followup-To: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Ezekiel Newren <ezekielnewren@gmail.com>
References: <pull.1980.git.git.1752784344.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <pull.1980.git.git.1752784344.gitgitgadget@gmail.com>
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: cb@256bit.org
X-SA-Exim-Scanned: No (on 256bit.org); SAEximRunCond expanded to false


On Do, 17 Jul 2025, Ezekiel Newren via GitGitGadget wrote:

> This series accelerates xdiff by 5-19%.
> 
> It also introduces Rust as a hard dependency.
> 
> …and it doesn’t yet pass a couple of the github workflows; hints from
> Windows experts, and opinions on ambiguous primitives would be appreciated
> (see below).
> 
> This is just the beginning of many patches that I have to convert portions
> of, maybe eventually all of, xdiff to Rust. While working on that
> conversion, I found several ways to clarify the code, along with some
> optimizations.

Just a quick heads-up: We (as in Vim/Neovim) have been using gits xdiff 
library for use in Vim and Neovim.

Is the plan to get rid of xdiffs C source completely and replace it by a 
Rust implementation?

Thanks,
Chris
-- 
Eine gute Stellung ist besser als jede Arbeit.

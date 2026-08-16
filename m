Received: from mail.kocurkovo.cz (mail.kocurkovo.cz [37.205.10.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 192EB125AA
	for <git@vger.kernel.org>; Sun, 16 Aug 2026 21:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.205.10.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786917491; cv=none; b=UB18JPEOw1o8cFrv347Jn1zqfOYZqzko/EsBsCmsbSWPTdDuPHSzyxXLB1fTTes5y9Tn8NeW+t6wdqebKTSfm2pUNTAsJsXqtwJW9MP+NaWaLWtyBL8gs8QZoBVr/5W0YdMJ/TtU4PWAwvKcYa5hO/THVpY/UPKabhr4w54jRwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786917491; c=relaxed/simple;
	bh=Opiem+3mTfmAXg+gMiuNcsRxpnBIuR+W7wZ9k6D66tA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BzzD+wrJMmdyEe1K2WgpgblaX2m/JlwCjte9mqAqYVXKVkXuetz0hsfbPfc8XggJS5hYXYOGCF/lyG5aEV9SuTo3+H9QqRkURjE/EjqiLN8h0ulM/hS5LFDmE26CYl8XhXCGbH4/QnwYiaH/J9MP8zcMEb/7htFu90TX0oCR42w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kocurkovo.cz; spf=pass smtp.mailfrom=kocurkovo.cz; dkim=pass (2048-bit key) header.d=kocurkovo.cz header.i=@kocurkovo.cz header.b=O+LygcAR; arc=none smtp.client-ip=37.205.10.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kocurkovo.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kocurkovo.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kocurkovo.cz header.i=@kocurkovo.cz header.b="O+LygcAR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kocurkovo.cz; s=mail;
	t=1786917120; bh=Opiem+3mTfmAXg+gMiuNcsRxpnBIuR+W7wZ9k6D66tA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O+LygcARG8TH5b6Th9epQ4BxXBA/k08ZzCuIxYaY7pOpHI4JfCyA7qYRjEPvQudda
	 l8XXXic80mgekX9a+GkRedjtvmN5kc1kGO6VrPhTfqUQzHixFiVisCOpO5NIzN4ET5
	 blVFQ3cpKryccyggFw5OLPH8kBmCS4FGw3JLO5bHHXzphb+gMF03vLnbhLNzhxlny3
	 QuaQFY7Va33my7RY22I5kRpiy7KGEEbMYDtrwjiaKjFSHWVmwwteg9jRUGeX2g42K4
	 TnsZELVDPD3WYDGEg8CmzSFPRjtYHFiAP4SUEK1D4hKWHVG/A+14XNhsLyzHnSnHOR
	 Cl1MaMJN1RrhQ==
Received: by mail.kocurkovo.cz (Postfix, from userid 1000)
	id B1F6222BC7; Sun, 16 Aug 2026 23:52:00 +0200 (CEST)
Date: Sun, 16 Aug 2026 23:52:00 +0200
From: Matej Dujava <mdujava@kocurkovo.cz>
To: The Super Techie <thesupertechie1@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: Add a git squash function?
Message-ID: <aoIxALomheh-3N44@kocurkovo.cz>
References: <bc49c03e-5a90-480e-8bfa-ad8fb8e42db2@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <bc49c03e-5a90-480e-8bfa-ad8fb8e42db2@gmail.com>

On Sun, Aug 16, 2026 at 11:49:50AM -0700, The Super Techie wrote:
>Hi,

Hi,

>
>I am a developer who often squashes their commits using Git. 
>Currently, the simplest way to squash is to run the following two 
>commands:
>
>git reset --soft HEAD~3
>
>git commit
>
>Where 3 is the number of commits that a user would like to squash. 
>However, what if there was a command like as follows:
>
>Which did the same thing? This would save quite a bit of time for 
>developers. Since some projects require the DCO, an -s flag could be 
>added which would add a sign-off to the squashed commit as well.

when later commits are adressing feedback you can do fixup! or squash!
commits and then cleanup before merge: `git rebase --autosquash HEAD~3`

>
>Has this been suggested before?

Looks like there is a v13 [0] patchset discussing similar worflow, which
started as [1].

>
>git squash 3

suggested command was `git history squash HEAD~3` but this will keep
message of the fist commit


[0] https://lore.kernel.org/git/pull.2337.v13.git.git.1786088371.gitgitgadget@gmail.com/
[1] https://lore.kernel.org/git/pull.2337.git.git.1781465141.gitgitgadget@gmail.com/

Thanks,
Matej

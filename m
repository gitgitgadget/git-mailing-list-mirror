Received: from bsmtp3.bon.at (bsmtp3.bon.at [213.33.87.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67FF176ADB
	for <git@vger.kernel.org>; Thu, 28 Aug 2025 17:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756403096; cv=none; b=UtirlHWluV0gRvO9DvxCuNqpzrrvLIRCpfjVdG1T2ImXxq8fLja+2Dn+FGxH1WonBz9PusyhtvZac2LNoge4QD7UIIPsyy8ASGvoKKa89QecdmKKwHH5zcjPGJkBmlYpbUmnDkMrFBAQ/QZh9lJAlGCK17T868JmfRq/BveqvE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756403096; c=relaxed/simple;
	bh=B38b1Wv7LusOOJSfIXl9LsCaQWvauGDVfPEN6fBHCaI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SKFJLj6YFWoudeNmjK9FBbBWPuNuuOSiP6Tl+2OEp7E+0YnT/EZ4l2oXJTwJzAip6swU0gLk+caqcQOUVfQX8I4YVO486BmLOntdUqPWqsBeW8NNZ91GczA0pzUocJSgCWJlDkfB8RZnro0Uh4H11dFn0/KFUSpeY0G2WNxVyAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.104] (unknown [93.83.142.38])
	by bsmtp3.bon.at (Postfix) with ESMTPSA id 4cCTLN3XRnzRmxd;
	Thu, 28 Aug 2025 19:44:44 +0200 (CEST)
Message-ID: <816cd946-4f25-4ce8-aa06-6babf9e90751@kdbg.org>
Date: Thu, 28 Aug 2025 19:44:44 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] git gui: set GIT_ASKPASS=git-gui--askpass if not
 set yet
To: Johannes Schindelin <johannes.schindelin@gmx.de>
Cc: Pratyush Yadav <me@yadavpratyush.com>, git@vger.kernel.org,
 Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
References: <pull.358.git.gitgitgadget@gmail.com>
 <pull.358.v2.git.1756371530.gitgitgadget@gmail.com>
 <e1aef533bfe89bfb87b1a83bf7c7375e6238b06f.1756371530.git.gitgitgadget@gmail.com>
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <e1aef533bfe89bfb87b1a83bf7c7375e6238b06f.1756371530.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 28.08.25 um 10:58 schrieb Johannes Schindelin via GitGitGadget:
> @@ -1130,6 +1130,9 @@ set argv0dir [file dirname [file normalize $::argv0]]
>  if {![info exists env(SSH_ASKPASS)]} {
>  	set env(SSH_ASKPASS) [file join $argv0dir git-gui--askpass]
>  }
> +if {![info exists env(GIT_ASKPASS)]} {
> +	set env(GIT_ASKPASS) [gitexec git-gui--askpass]

Is this [gitexec ...] deliberate, or can this be [file join ...] like in
the surrounding cases? If it is deliberate, we need an updated commit
message and/or a comment, otherwise, I can amend locally while queuing.

> +}
>  if {![info exists env(GIT_ASK_YESNO)]} {
>  	set env(GIT_ASK_YESNO) [file join $argv0dir git-gui--askyesno]
>  }


Received: from bsmtp.bon.at (bsmtp.bon.at [213.33.87.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E11537472B
	for <git@vger.kernel.org>; Sat, 28 Mar 2026 07:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774684023; cv=none; b=BDjBQPm1L4t8k3td6NihHstaRFJj9dwvWTZU9hjNrUMh+LUMvh52N1PonmoiPIyUMQKn3scAX9LS9axCs/HNuQj7Gu65mMLSZk0kUlsTCbG97Ru/XxWw/eQXmPRRu8t8FpxhrJ+epH3y4IrqosCbE8FYrj8nUzSnxWBOojDH1CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774684023; c=relaxed/simple;
	bh=8y6pmx48BhNmcWjTn3GR0uRCPLj3ILb6joX/oXj4phU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QKQLLR4HLZm8/m+SDUmVOA6XXKNb2Dp3o2W+0r31Cr7FLFRJN18YtrZhgrWt2GebvtJjM6vwVaKzpKy8AkfucgkhEYsKQKTAG4SFvbHsG6cGLDFRm9iInAa7SJAOUnudmcgzIkAi0fK4E/xY1N2Z505wd3Xpzj6XRpJtrHxGeuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.103] (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTPSA id 4fjV2h0TJbzRnln;
	Sat, 28 Mar 2026 08:46:46 +0100 (CET)
Message-ID: <becf040c-b425-4fd1-affa-b6368c812b42@kdbg.org>
Date: Sat, 28 Mar 2026 08:46:46 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] Add support for per-remote and per-namespace SSH
 options
To: Wesley <wesleys@opperschaap.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
References: <20260326233739.2911354-1-wesleys@opperschaap.net>
 <7d3731c5-d766-47f5-af60-813b379cbeef@kdbg.org> <xmqqbjg9mex2.fsf@gitster.g>
 <09c5fe7d-8379-4f68-bf1c-9869e2924cb8@opperschaap.net>
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <09c5fe7d-8379-4f68-bf1c-9869e2924cb8@opperschaap.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 27.03.26 um 17:49 schrieb Wesley:
> On 3/27/26 12:10, Junio C Hamano wrote:
>> I somehow thought that this practice is so widespread that it was
>> one of the few first things any new people learn to do, but perhaps
>> we do not have a good documentation coverage?
> 
> As said before it is weird thing to configure a global ssh configuration
> just for git transport. It doesn't make much sense.
> 
> The problem with ssh_config usage is that you need to change your ssh
> config, which is machine global, not just git.

Are thinking about the SSH configuration in /etc/ssh? You do not have to
change that. There is also a .ssh/config in the user's home directory.
That configuration isn't machine global, it's obviously per user. And
the way to make the configuration work only for Git is precisely to use
fake host names that are only used in remote URLs of Git repositories.

> And not portable across
> teams with configurations committed to git. Myrepos is a good example of
> this. My former employer had this and I know the Perl metacpan project
> also uses mysrepos. Changing every URL dynamically in committed configs
> isn't really a nice ask.

I cannot comment on this, because I do not know these tools.

There are ways to achieve a considerable amount of customization of SSH
connections with existing tools. If you need additional features, you
should sell your change with a more specific justification, including
examples that show reviewers who do not know the tools you are using
what is needed, but missing.

-- Hannes


Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD5381EA7F4
	for <git@vger.kernel.org>; Fri, 27 Mar 2026 15:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774623861; cv=none; b=hzjiN5r5I6Wx5QrVDparMsvvtq1Cr8JAsyCA3zD+cR+2mPcaj8jDoBTUOHex5vNKhcgJTJuKPZFk3tAs7fKLngXBBPlSKr2mZnlPYQcaGwA6LW7QWXIg6bbnpDzucY+JZU/r0PlH48a8E08s5WWoa0wAmxu2L+cl+Xdb+U5BZY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774623861; c=relaxed/simple;
	bh=ky/6XxombmyhejQTGwKllV2Z01s61Uy9sO8l1URDoq0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=dDflGTDshddELfq3UV9MKT/Dtx395i2+NG3gDURDzW4kOQ/5xYoNbgMqw3ZZ87UkeiA3vERCv3jMiyBkVOlIuF3NVMMc7qYpNwA6XUbvrVIPhsRrHB7Ir0igCkrwsZFfC7qeyRN6r4iQZ1Co5l5IfOd21fFe5A80n9oKZHgXoEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=opperschaap.net; spf=pass smtp.mailfrom=opperschaap.net; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=opperschaap.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opperschaap.net
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4fj3nd3g4Jz9tTM;
	Fri, 27 Mar 2026 16:04:05 +0100 (CET)
Message-ID: <abe2616d-4dbc-4d84-9fa9-a6d24cd65927@opperschaap.net>
Date: Fri, 27 Mar 2026 11:04:01 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 0/3] Add support for per-remote and per-namespace SSH
 options
To: Johannes Sixt <j6t@kdbg.org>
References: <20260326233739.2911354-1-wesleys@opperschaap.net>
 <7d3731c5-d766-47f5-af60-813b379cbeef@kdbg.org>
Content-Language: en-US
Cc: Git maillinglist <git@vger.kernel.org>
From: Wesley <wesleys@opperschaap.net>
In-Reply-To: <7d3731c5-d766-47f5-af60-813b379cbeef@kdbg.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/27/26 03:51, Johannes Sixt wrote:
> Am 27.03.26 um 00:37 schrieb Wesley Schwengle:
>> * `remote.*.sshIdentityFile' and `remote.*.sshOpts'
>>
>> Configuration set on owner/path style. This is to support `includeIf`
>> configuration management. For example, a git-forge that host both
>> employer/client repo's. Eg, `git@gitlab.com/waterkip/git.git' and
>> `git@gitlab.com/corp/git.git' would have something configured as:
>>
>> * `core.sshIdentityFile.*', eg
>>
>>      [core "sshIdentityFile"]
>>        waterkip = ~/.ssh/id_ed25519_me
>>        corp     = ~/.ssh/id_ed25519_corporate

> For this reason, I see little incentive to add complexity to Git that
> achieves the same.

It's a hacky solution where you change the ssh configuration 
permanently. It breaks copy/paste(s) etc for every forge.

In addition, this is where my need came from: It breaks myrepo's 
configuration(s) for people if they have to override the hostname in 
each myrepos config. You cannot simply override the hostname in these 
situtations because of a local ssh config change.

Cheers,
Wesley


-- 
Wesley

Why not both?

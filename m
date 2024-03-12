Received: from mx10.gouders.net (mx10.gouders.net [202.61.206.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D4A7BAEF
	for <git@vger.kernel.org>; Tue, 12 Mar 2024 14:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.61.206.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710253676; cv=none; b=S4Eq+yJhSSOO2bPWFNWLuxxKZ3XcWxj7lSVMubIEaChaQok+nF0U7r0zVsPDjoSAhLOyAdjD1BLoB25VJWAPWUk7dtde9cO6dPWzcwPqmG+jJYQG0qmSvHINEikLdhp6po4V9L3UZazEbi8VhFiZhqULuY4nVZSMbVEHeWiU0ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710253676; c=relaxed/simple;
	bh=5h46n8sJ0FGExkTwb/RWL+XMk8th1Ari0m0jy2BekQ8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Fi2pM00Mah8pVjYPQbo7hiS1YBySGJxqp8Oex5a3UZAa4AfOGFOQyRBza5Qc8/N3OEBBb1bH9uGFFCZLw0lMz4Y6QvBRPZMyTNyDh2qpTmnagYrEsV97Xw4iM+qQsF9NAJEh5sbE3dxpvSzSaL30YEAxGe0wwSv7yCgHqhj15pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gouders.net; spf=pass smtp.mailfrom=gouders.net; dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.b=dl/jIubB; arc=none smtp.client-ip=202.61.206.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gouders.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gouders.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.b="dl/jIubB"
Received: from localhost ([193.175.198.193])
	(authenticated bits=0)
	by mx10.gouders.net (8.17.1.9/8.17.1.9) with ESMTPSA id 42CERkZ1013832
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Tue, 12 Mar 2024 15:27:46 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gouders.net; s=gnet;
	t=1710253666; bh=5h46n8sJ0FGExkTwb/RWL+XMk8th1Ari0m0jy2BekQ8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=dl/jIubBtaTWUVJzjzPeJE7q9S3TF+IzdabgKKPo/OSUlJbSf68KcEhDW1vfHpWvx
	 8lyg+cGLHF01mWB7H4z/IiQee9bvnG/J/TSk+6ZTwYbxm/rHtw3Vkbq0CGfd68vNzP
	 oFH4I1+VRniqkREaaRT365Mnx7vY+JfZtxZnadQs=
From: Dirk Gouders <dirk@gouders.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 5/5] MyFirstObjectWalk: add stderr to pipe processing
In-Reply-To: <xmqqh6hcmhmu.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
	11 Mar 2024 17:13:45 -0700")
References: <cover.1710192973.git.dirk@gouders.net>
	<a2d30eff217e560873c49fe45116c784dc12fd32.1710192973.git.dirk@gouders.net>
	<xmqqh6hcmhmu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Date: Tue, 12 Mar 2024 15:27:41 +0100
Message-ID: <ghbk7ja5k2.fsf@gouders.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> Dirk Gouders <dirk@gouders.net> writes:
>
>> In the last chapter of this document, pipes are used in commands to
>> filter out the first/last trace messages.  But according to git(1),
>> trace messages are sent to stderr if GIT_TRACE is set to '1', so those
>> commands do not produce the described results.
>>
>> Fix this by using the operator '|&' to additionally connect stderr to
>> stdin of the latter command.
>
> Isn't |& a bash-ism?
>
>     upstream command >&2 | downstream command
>
> is how you would do the same more portably.

Ah yes, it is a bash-ism, thank you.

I guess you meant

        upstream command 2>&1 | downstream command

I will wait a bit (some days) for other comments
and then at least remove this bash-ism plus the wrong tags you also
mentioned -- also thanks for that.

Dirk

Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDFBC3A7F73
	for <git@vger.kernel.org>; Wed,  7 Jan 2026 16:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767803539; cv=pass; b=e3ggTz3uDLABwxPx+xNPEb72h+wujbg2rjqGnIkFQd1eIC9ikOGb6vVHtWMysFW1yDZJFyq2WOfU7S3jnKeKr6l0CKqqsLGUy2cslnQo9M0+yhHYOSuVbZ9GeL15WuCJgCg/PPcmSJwVxsJPZQK5VE4+SAVy1PIONMGekgrBqXc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767803539; c=relaxed/simple;
	bh=jTXiUOVwxBFfxJUEqPc0tIhZ7+wa0oXbY66iih/0ydM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FVxMXAZh7KhE/BooNsVsPCUdKmMwbUv+oQA7dlwn3YYzzTyHunsdEslfmrMZBkEMtiwaTetzyu9Aq0WzTathu17jGFulXISG1+zJLQTNxSR4haMUzWgs50gGa0vTxHphHSK6iYZalx18JFIaotpzPXIbd44q1hwSW9u51gztvwI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=cThMnHV+; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="cThMnHV+"
ARC-Seal: i=1; a=rsa-sha256; t=1767803498; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=aENgCPpSDzHShQAvTi92ibMpvIawhAgVgKrGAKBPY64Yap/HT/AUbM3SNN56Dc9mYuyWrp2FpQFTcPesYzLtu/otGrhFc2WcicxcPiv0QXcSL1iH8HGasrUePrujRQnOZyonMnIOItau5ovpZ7oHC3JST09QjoBL95hRfYBtf3w=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1767803498; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=jTXiUOVwxBFfxJUEqPc0tIhZ7+wa0oXbY66iih/0ydM=; 
	b=Xl0rxzsaSzTu7UfOzzT+2bItMU3u/1HZEZsBkcXdQ58ZNoOErIivmseEm/vzaQ5HQ3osHUhSFcZTZPPsFn0mUYfoJPnOr3cvil6AuCPquaSn47oaI0kMxLfVjDQ97GojQzHNW3AE7Cm0Bk8IyJZzN/+wXfHwalO1y9ovuXRqbyU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1767803498;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:In-Reply-To:References:Date:Date:Message-ID:MIME-Version:Content-Type:Message-Id:Reply-To;
	bh=jTXiUOVwxBFfxJUEqPc0tIhZ7+wa0oXbY66iih/0ydM=;
	b=cThMnHV+RaDpqAmy/ciKqz/4uHhWS938zISTTPq8hQWJnxfQ3Gc+RKqV15PVJhak
	5ce4/IGORwN0mHF7J203PlUgUMyKQLi0PZWofHT7THsXT6DYPu2kk4ThfcQFTeZVZLL
	c3c9p01YQ0aqT5qZClWhDlnrNMe2caThna5NumLA=
Received: by mx.zohomail.com with SMTPS id 1767803496020113.6879115263796;
	Wed, 7 Jan 2026 08:31:36 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>, Rodrigo
 Damazio Bovendorp <rdamazio@google.com>, Jeff King <peff@peff.net>, Junio
 C Hamano <gitster@pobox.com>, Aaron Schrab <aaron@schrab.com>, Jonathan
 Nieder <jrnieder@gmail.com>, Josh Steadmon <steadmon@google.com>, Ben
 Knoble <ben.knoble@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v7 04/11] submodule: introduce
 extensions.submodulePathConfig
In-Reply-To: <aVy4-LZ7Lz_tuqdp@pks.im>
References: <20250816213642.3517822-1-adrian.ratiu@collabora.com>
 <20251220101528.1227487-1-adrian.ratiu@collabora.com>
 <20251220101528.1227487-5-adrian.ratiu@collabora.com>
 <aVy4-LZ7Lz_tuqdp@pks.im>
Date: Wed, 07 Jan 2026 18:31:30 +0200
Message-ID: <877bttidul.fsf@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ZohoMailClient: External

On Tue, 06 Jan 2026, Patrick Steinhardt <ps@pks.im> wrote:
>> diff --git a/t/t7425-submodule-gitdir-path-extension.sh b/t/t7425-submodule-gitdir-path-extension.sh
>> new file mode 100755
>> index 0000000000..5d52a289f8
>> --- /dev/null
>> +++ b/t/t7425-submodule-gitdir-path-extension.sh
>> @@ -0,0 +1,138 @@
>> +#!/bin/sh
>> +
>> +test_description='submodulePathConfig extension works as expected'
>
> I think I didn't spot any test that verifies the actual config values
> that get written when the repository extension is enabled. Specifially,
> what I think we ought to test there is that the generated submodule path
> is relative to the repository and not an absolute path.
>

Yes, I agree, it's a good idea to add a test which verifies the gitdir
config value to be relative to the repository regardless if the URL
being added is absolute or not.

This might actually be an oversight in the current code, which the test
will uncover and I will fix, if necessary.

Will do this in v8 and also fix all the nits you pointed out.

Thanks again,
Adrian

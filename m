Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571F7156875
	for <git@vger.kernel.org>; Mon, 19 Aug 2024 21:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724102511; cv=none; b=lDU9R/VEbnYHIBDhqpQoLqWdpYA9Nqfw+ezCBypNBqQ4HupOG8IL1lqs4uqUHIOreexL2pDI7jU0ma4HcG85Jr40Bt1o2XipJpCmQ80+FZ7qB/sNi2AeGC/I4iYh6EbaKhpmpmkOl6/gmYxfLlO685PFkArlR6/GKvazhLXViXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724102511; c=relaxed/simple;
	bh=2mRKebatICLy1TjIw1sKMRihShAJcqR8bIq4phwV3n0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KW6L0UB3yFf+YZPx/TVTonHMoPwv7jUAgBQvAyXUWCcPQRpKInVgBlN2AkvEtJy0PwJKOFhBOPAYbc0TpO/amS3hSjW3U489kIrgBHcUziN6d0f2awf6o9tDtFLnWyAHmL3QmLeZsfsm654zd9h3XypQ2poJUeU3iLxyDgjvMBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=uaK3gxox; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="uaK3gxox"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id A5CEC283FE;
	Mon, 19 Aug 2024 17:21:49 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=2mRKebatICLy1TjIw1sKMRihShAJcqR8bIq4ph
	wV3n0=; b=uaK3gxox5LMiehpyG+DAz2g2+4bN62l0gaufyOXdeE1UIPjD5STTio
	4olLkoBXH1RmOqSrmYXXVDwrv1nKij9skYV/JkUVI4+pmqlS2bS7LsuEvEH4s0dL
	/8IQkmsCpsq4RKJuqOQXckVQKQB2LLJZ70p/YK1pa1dWNlDnjUGh0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 9CFF0283FD;
	Mon, 19 Aug 2024 17:21:49 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 11A66283FB;
	Mon, 19 Aug 2024 17:21:46 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
  Kyle Lippincott
 <spectral@google.com>,  Phillip Wood <phillip.wood@dunelm.org.uk>,  Josh
 Steadmon <steadmon@google.com>,  rsbecker@nexbridge.com,  Edward Thomson
 <ethomson@edwardthomson.com>
Subject: Re: [PATCH v5 2/9] t: import the clar unit testing framework
In-Reply-To: <369060793306daab1796ae3063b4eaacc287f12d.1723791831.git.ps@pks.im>
	(Patrick Steinhardt's message of "Fri, 16 Aug 2024 09:04:40 +0200")
References: <cover.1722415748.git.ps@pks.im> <cover.1723791831.git.ps@pks.im>
	<369060793306daab1796ae3063b4eaacc287f12d.1723791831.git.ps@pks.im>
Date: Mon, 19 Aug 2024 14:21:44 -0700
Message-ID: <xmqqr0akcion.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 09D27D18-5E71-11EF-8278-BF444491E1BC-77302942!pb-smtp20.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> diff --git a/t/unit-tests/clar/clar.c b/t/unit-tests/clar/clar.c
> new file mode 100644
> index 0000000000..3fc2c76815
> --- /dev/null
> +++ b/t/unit-tests/clar/clar.c
> @@ -0,0 +1,842 @@
> ...
> +
> +#ifdef _WIN32
> +#	include <windows.h>
> +#	include <io.h>
> +#	include <shellapi.h>
> +#	include <direct.h>

This seems to break Windows build

  In file included from t/unit-tests/clar/clar.c:22:
  D:/git-sdk-64-minimal/mingw64/include/windows.h:89:10: fatal error: shellapi.h: No such file or directory
     89 | #include <shellapi.h>
        |          ^~~~~~~~~~~~
  compilation terminated.

https://github.com/git/git/actions/runs/10459342252/job/28963152995

As we have other topics that I do want to do well in 'seen' before
merging them to 'next', I'd temporarily drop this topic from 'seen'
and push out the rest of the topics.

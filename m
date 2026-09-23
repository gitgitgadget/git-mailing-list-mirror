Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1590C4477FD
	for <git@vger.kernel.org>; Wed, 23 Sep 2026 07:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790147422; cv=none; b=EeIbuGOvHebcKRs+9jC2Rs/YEBtQdzxhvBRyDVXaDSDGUyf9OgiJ5/QicRWOkS+yj0SIEWOzt4ZsByS8TFHFzhpUKsxlmvMV/z2m5Ods9ZR8hx3gSNs/40Mw8/2tPNKde4uWHfVLTYKl2y+4Y9+/BBaCTwnCGv79j3kGm3qGjfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790147422; c=relaxed/simple;
	bh=ARF0lr77FGjvW/219hi7NDz5DBM4aG7OUTQYjQkKmUM=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=XW8E6v4GvnK5C1sGPiXwinI3x+tEkslknQAqwyg+REDVxvzkIymWv1n3+AsSwax6m7lLQe3VZ90EMdvM2QhGPt24hmz1QRIFGhMI9J/ixaORXZsHOn/EMhVWrtuW/YG77Na6lfAHb1bvjRqb3NplAhYUc1W3Ylcf/P9Y9v5CJ4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=odoo.com; spf=pass smtp.mailfrom=odoo.com; dkim=pass (2048-bit key) header.d=odoo.com header.i=@odoo.com header.b=RNGBlwuj; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=odoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=odoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=odoo.com header.i=@odoo.com header.b="RNGBlwuj"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912d3931so3904385e9.3
        for <git@vger.kernel.org>; Wed, 23 Sep 2026 00:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=odoo.com; s=google; t=1790147412; x=1790752212; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:subject:from:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=yaAb/47oenXk96WzA6gfwyCWGzw5jTQ/nCnUG7tFnpU=;
        b=RNGBlwujhSWYzzCrq9jffiIl1+rXklle8/yhP0cFg/6ltB6vf4+jabu4zAI40Ia24w
         T9495NeN8ZeNlvyaoBCaVJ6L+ZnIBZY/KxKJxESyNusc6AXHdWwSiL63qzqFf+a3c6Cp
         0dqvWMN1jEdULHOgQYA+1QRBJot7oQJXp1RMpXNrxLvzZ1/hTxVNKHg/uuQOotKfWNCR
         HSJy9BLfHlB4Zf93pscqtXfo9uiyRimDuqrl6vSXyiAzlfNqC71HS+jgsy5AOrFXonrh
         YPVIrk/HUCUjPsa83eOY5SKau3WqdCK4CTxBcoQefyR2EZH4nR/DtSn0fRjIhGwZGnoW
         Iwtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790147412; x=1790752212;
        h=content-transfer-encoding:content-type:subject:from:to
         :content-language:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yaAb/47oenXk96WzA6gfwyCWGzw5jTQ/nCnUG7tFnpU=;
        b=gEc0TGEYLCKOlrWXb3B5NE7ZDAtMBZCSdUtb25JPdXmxIw98iriYmb8GyTrOy9wdLM
         ZYNMuswek0/9W1iZDF2C/eywMSUNbFUZraZKw5lwwp885iE/R4qLDNlPyjrZVT4znLHB
         jDL0n4jdyFqVtQP400u8qy+/sb2J7CjhNncIdyVVEmm1uOsS/HRVmsmPSKL/nQ4crfZm
         oBYYKf6icvDltIb0KhsERNgjnnXRCinUgZFqsPjWnMlTUIoFlCLM4Hz+sZewcL/dMiud
         2RvG9QKFa4+vZszt413A2sTQLAW897G/BSL/YtEGrIwsaIjzY7d9OZk6dHsKiWDtk7O6
         8wRA==
X-Gm-Message-State: AFuF++nhKYubC5jddAGg8PtgoeS9a9l0IQJgzvvhOuM5sIIYi9OaPZF2
	C2gJJdFapYDsPcfQDz7A7BTL02Dvz3mRVMu3wH3xlM9C8daC1oEjWQC9nLPELijOjIVWkBf9arD
	STjQI
X-Gm-Gg: AYBFou3w7wmvDhzqeSft9M/fHpwdj7Wn0xVL171Tp/M2kN7k7dt/8UPV1hA7BWiMOM7
	V6cLJ3bnc+kTT/WwUoA8G0MGD+X4daRiEjN/5fa/NZCmXoE4+A87E+ORpgkROjpPSOkCMiQC8mV
	00Bmd4VRADQZXBCheM/ISIi9B3Vi/vQfhFQjzXD7jnkIb/Pxz9GHW10KpoWSqCztUKjzlgxNrsc
	UxacJ5u50n4lsEd4Z+pJAzz3Lh1K1Amx/j7o7fgkFNgRz2Q1MQa2b6dspLZ28/KC83Nas73DSl3
	cKwHplPQhsETiYQ7vtTNbE2i3Ow7XTnyefvgbHnN8fsAoHKP9ECeyl8zWnVDjfW3DgebIf3+Tbw
	cr2Ixh2TGgVoYn8ih3CiQ+LIcLxiP51VIe6e5KEvURFJsSeGdpLdLOGsDfLhYGqsdAhITu8N3E/
	khhF2dNk3teJ9WAK7sB2Y+1GGfIaEPzJcF3ra2JrdT4f6Fa3sqWyoMCfKXMM5/25ms9LvtENs1j
	qB9kAkcDQEsuoe/r7SPiiQ/iTZTwefOfETLRsW+J3n0Z0Q=
X-Received: by 2002:a05:600c:1f91:b0:49c:fc6c:be19 with SMTP id 5b1f17b1804b1-49fdf24fa11mr19598225e9.31.1790147412113;
        Wed, 23 Sep 2026 00:10:12 -0700 (PDT)
Received: from [192.168.0.4] (ptr-178-51-240-126.dyn.orange.be. [178.51.240.126])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fdf158147sm39373685e9.0.2026.09.23.00.10.11
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Sep 2026 00:10:11 -0700 (PDT)
Message-ID: <6fa4c795-7f80-45e7-a42a-ee6e9cfc01cf@odoo.com>
Date: Wed, 23 Sep 2026 09:10:11 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: git@vger.kernel.org
From: Xavier Morel <xmo@odoo.com>
Subject: [BUG] basic auth not send on empty password in default configuration
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hit this issue playing with a custom credential helper:

- if the server requires authentication for an operation (returns 401 on
   an un-authenticated request)
- and the credential helper sets an empty username and a non-empty
   password
- the second request git sends is still un-authenticated instead of
   having basic auth set
- git then fails with an "authentication failed" error

If proactiveAuth=basic is enabled, git doesn't mind the empty username
and sends the request with basic auth set.

This was directly observed on git 2.47 and 2.55, with curl 8.5.0.

The issue seems to come from init_curl_http_auth: if the username is
unset *or empty*, it exits immediately unless proactive auth is enabled,
which matches the symptoms. From this it looks like an other workaround
would be for the credential helper to precompute the `credential` value
and return that instead of username/password, as that is guaranteed to 
be non-empty.

Either way the current behaviour is somewhat surprising as (AFAIK)
nothing in basic auth requires non-empty usernames (or even passwords),
and importantly git doesn't report anything odd except the connection
failing, the lack of auth on the second attempt is only visible when
enabling GIT_CURL_VERBOSE and comparing a successful auth with an
unsuccessful one (or on the server side, but there if the server is
bespoke one can easily chase ghosts assuming the error is obviously
somewhere in the bespoke code because select isn't broken).

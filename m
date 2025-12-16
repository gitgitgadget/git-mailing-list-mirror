Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5494E320380
	for <git@vger.kernel.org>; Tue, 16 Dec 2025 23:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765927257; cv=none; b=pdS9eZUpR8D/NSTfESAQODn7mFtZ8Qxh01QslZw+LOpjdj80vwEPg9U6zxKBRefOmHfZiUF5Oa7x4/TduYZYL1C2B+/z3XB79sH3zmKOMxwfcpIpdr8UWPeCRWOZyjYZwFNvWhRZgi433TMTgTGYbGDvWs0zlXzeb4IhYUk/oAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765927257; c=relaxed/simple;
	bh=LqAH5+/KAOGxXGJUBEoRop0a+oWjllz+1srVPqyeO98=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W7eBgtxdNrYc3x+/JEjD4AHtkgyzDhlafTEZf+waBXv073fC2WqO7dHbOKm80IzM4/58mC1xOZkUnZ6oBSucva2u4UR+icxz6hAH/g5K7nkvE/4MsHIzrAw7Rox255P8PKmDyv+0z3kuiConxUBv815FHvFZ12I8d5BXPdBNm1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lTHX1aPC; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lTHX1aPC"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2a1462573caso71655ad.0
        for <git@vger.kernel.org>; Tue, 16 Dec 2025 15:20:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765927255; x=1766532055; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h1QVfx5YVv3gvGA7WXVkGdq2M5QCSflO5UKssMW2pTE=;
        b=lTHX1aPCP/y/ESWrlek4e6sm08f9Oc533+0ocs6MdY9JmSfWE5PavAm4xQwZJDl5mj
         fBbbbew1UPgfd6FSa5rU0MWRcrRSxRnJ5MoUwjDrptFKpFpNPJ0ntYCpfU4HOyqoxwqX
         ALPGnwK6+M49koMUUYnJ9AyXRozH2gFDSfRXb5JPnUgVxUdqaDpyxOKDz9/67gdmb/y/
         WIftQpqivuCZrZXyVejwdnh4jjgZ2pC7KFtjhRt+FjU8eJRiFY9vRJhCYTqlbIPjFZ/i
         zbSfuHgzTjrthUj22XCIzDa52Ahvb6z9Y57paB92hH6DDCOSk7wFVbi83TnDJngRmyf7
         PYgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765927255; x=1766532055;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h1QVfx5YVv3gvGA7WXVkGdq2M5QCSflO5UKssMW2pTE=;
        b=C0BiIfqb1z+pGIqrxGQpboj1dNdogHIuluDdOtz0GTLfJmVoXs56MFfAL8PTh6SYyB
         gs0a4gnx4o310bkfw5836dpjJ4l6xP3gMLhNSEllWO+/f6/SIXgzHFcYcp34ej6eLFMQ
         ggvNNXrxwdKkdD8L+TXGLvrm9L1ClAdmtHonhL561nG/9C4vBZSYiAlrHSh84/m7RDc/
         QJcd7+YAmkV2mJI1Mn1JdWKp209etHMbB8cVkuBroL9BkLaU1/WZp32dwneVQ19QuOhz
         FN+1U9dBE1XJ1ny2RMzuHZo+3u80fvRry79PmQ/O/F3sBiY7XftlHRfspqKib+SDVaNr
         Bt7Q==
X-Gm-Message-State: AOJu0Yz1kwg69gi8s0Nw+Ns253kdOOoS6TkwlmycGFb2ggN78yEaDkza
	rKZ7cB9uwyD/+rdVjTfQNYhoKts1kBVD198uWoyLyB7dtOlUZ9rg+c1DP5ZCYWaFhw==
X-Gm-Gg: AY/fxX63wCjVj6uuJpiam21NTf4jFCfscdvIRoCWcxac8tnXDgYVUinip9p8gobiANj
	DZAZlmwywl9OZpbO+zFa3rzkYTvXV3riuD0N+JhmBkeyahAbSK+fH+DBrqDu9mJ8Nb4B5f9Cpdp
	l/DF4k40cKVs7acQfb902FvZBOjtrDY8P473YMlhbBGTR5lksMcpXYDnRHB/duExGYxsHR/xxXT
	AxibNOZZ2MT5yzpe6U7d94SSjHNq/F5j2/sfczbkdbVAEDPBsrh8ZugEy/x2vnW2+4lPPJJKD3c
	hHI5ABYaC81Rqu+L7u+ZwIun4Zm3Z0Zo2A3ptClXzkYk5Kx1GqswIdoU5Z47HHgpb4+sp52pr+K
	xMn/uLE+tvb0wC7Ruq/3MSNHW5MaUNEQhqR0lqAiGJJAIxlbhTnZAuFS70usfPU/J+X+1mT4U0h
	vLg30Corpo6Q4yQJorb7WT+hI37mDlvnnTKw4FyzF5cMZ+kY5zeazJnww=
X-Google-Smtp-Source: AGHT+IE4JPjAxnLOMRa4M3N1WXBPfxbKLobLQkuuf/dgGtDWYFCTd6UyLHQmZcmga1u4XzhgsjWeYw==
X-Received: by 2002:a05:701b:2815:b0:120:5719:624e with SMTP id a92af1059eb24-1205c62f609mr19396c88.21.1765927255186;
        Tue, 16 Dec 2025 15:20:55 -0800 (PST)
Received: from google.com ([2a00:79e0:2f0b:6:33c6:d628:8813:d90a])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ac190d3d14sm33352221eec.2.2025.12.16.15.20.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 15:20:54 -0800 (PST)
Date: Tue, 16 Dec 2025 15:20:48 -0800
From: Josh Steadmon <steadmon@google.com>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>, 
	Rodrigo Damazio Bovendorp <rdamazio@google.com>, Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>, 
	Aaron Schrab <aaron@schrab.com>, Jonathan Nieder <jrnieder@gmail.com>, 
	Patrick Steinhardt <ps@pks.im>, Ben Knoble <ben.knoble@gmail.com>, 
	Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v6 00/10] Add submodulePathConfig extension and gitdir
 encoding
Message-ID: <dymehf7vjf6winlsezdzbdiboo7d74wezoopwkyc67ckra7oe2@5ruvpsgjpbea>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>, 
	Adrian Ratiu <adrian.ratiu@collabora.com>, git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>, 
	Rodrigo Damazio Bovendorp <rdamazio@google.com>, Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>, 
	Aaron Schrab <aaron@schrab.com>, Jonathan Nieder <jrnieder@gmail.com>, 
	Patrick Steinhardt <ps@pks.im>, Ben Knoble <ben.knoble@gmail.com>, 
	Phillip Wood <phillip.wood123@gmail.com>
References: <20250816213642.3517822-1-adrian.ratiu@collabora.com>
 <20251213080817.347922-1-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251213080817.347922-1-adrian.ratiu@collabora.com>

On 2025.12.13 10:08, Adrian Ratiu wrote:
> Hello everyone,
> 
> For those new to the series, we're implementing a submodule gitdir
> extension which allows us to have a unified way to determine gitdirs
> and do things like encode submodule paths to avoid FS conflicts.

I'm afraid I've gotten a bit lost with this series. IIUC, we no longer
try to encode submodule gitdirs by default, instead we do this only if
we detect a conflict with an existing gitdir. However, in all of my
local testing, I have been unable to produce a conflict that triggers
this encoding. Instead, everything hits the error:
  "fatal: A git directory for 'nested%2fsub' is found locally with remote(s):"
from `builtin/submodule--helper.c:3389`.

This happens regardless of the setting of
`extensions.submodulepathconfig` in either the repo's local config, or
my user config.

My testing setup has been as follows:
* Using our locally-built Git with our downstream patch of [1] included:
  * create a repo "sub"
  * create a repo "super"
  * In "super":
    * mkdir nested
    * git submodule add ../sub nested/sub
    * Verify that the submodule's gitdir is .git/modules/nested%2fsub
* Using a build of git from upstream `next` plus this series:
  * git config set --global extensions.submodulepathconfig true
  * git clone --recurse-submodules super super2
  * create a repo "nested%2fsub"
  * In "super2":
    * git submodule add ../nested%2fsub

At this point I'd expect the collision detection / encoding to take
effect, but instead I get the error listed above.


[1] https://lore.kernel.org/git/20180807230637.247200-1-bmwill@google.com/

Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F977747F
	for <git@vger.kernel.org>; Thu,  4 Jul 2024 05:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720070551; cv=none; b=JWTR7WQPnu4i5PEPFU7zoZR/CHh/UD+gy0Nuz8siUoPolvZANDIWbLk3cX2g5qAUbhW3KIuH6qTLYlvRZXWSTzEZxDuj4AwjIs8AxNgff1VcVZWSQ8qFsIK4P5Di5NeNlfy1F9hn6YJzqjxn3I9pcwfOK2cHWgfjkRHfJ5SbmoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720070551; c=relaxed/simple;
	bh=LPMwbbdjsRqkyt1spQYlpyVBVbp1mobQhqWuVvxRWN4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TPkS3H4P2QXBvtqija8tEBHTR0jy6YabQ7YRC08aB3knr7X7zs3SCMpbr/iKm4q28Z5MllK/GVIRA+6UYOhznRDbsqUcbtvx06z/bNbOuzdSCrwV7ldHRofD/D4OFFrK+CTxz/rqs9ojUTRM5mrOf8tDf1dChmHfSxciHvUXlMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X5FkgrUa; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X5FkgrUa"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2c96170d23eso219367a91.0
        for <git@vger.kernel.org>; Wed, 03 Jul 2024 22:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720070549; x=1720675349; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BAp16X0QWRFU6hbkYc1STIR0MLMzjm6OtBm7JP+3rhY=;
        b=X5FkgrUaV6/hGWJcX2KfrC4nrkxdi2PiUg5ZlnPmBCstIM+urn6ObdpeezQmZPmdUK
         yq0gkftZm1IdmKM+RILGCwBHl8HJvCDfcCKqL9xYLvuDMZ9FA/gLntT0/J13HEL2KVSG
         9t0EKa3/be7y4LpMRBm4ENlEHdeAlJnWmb0vm3DYg64lg5see7MZyWno25cUkxDo2pNO
         P/wlaevYzjzHSYZfsIkRcaA/eaZiMC4HmxHqxK9HnScqSWCwZZWbSaGsLl/W25bEReIh
         fQqewpclSH1gnG2fAkt0C/YgKTLx7jJrQnkl2nIoTfC40SQOuQzfDCGT23qNOGhiZTpT
         lUJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720070549; x=1720675349;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BAp16X0QWRFU6hbkYc1STIR0MLMzjm6OtBm7JP+3rhY=;
        b=uFTfSLApPRS50zCMa39ghW56FBscPddHjeyThC29oeOnR3N1kBXUzQACoNovsS60Ig
         f4oZtZd2j5mdfDuJagwttqTc/fI0gFahsW0XzODZ2FfQIu6j3ITG976dl8R7rr/2rQX6
         9Yvi2kxehbL6t4noKaYTBogxIDRPL0ftRBMoV4iIh6IPZBfPHE6NpWpjcCeVWkw0+Bfe
         cCW8Ku8CY8pQWqy/M48fnNpUXzMyrQ5OIAgxWtAlCGSZ1BTn1bdt8krpSLHsbMjwAGeM
         R4X6ek5sg+PoLyp3vwDp79z8XmoVlpuYUEobnPWkGeGIQaS7CNlOMyhN+0LIHImRo4JW
         wd6A==
X-Gm-Message-State: AOJu0Yya9hgoyLtGsEiZX9MZRAL1gh1WO6DhB8RBLIBAuwvCQ8clgLaa
	ASL2zJVgaGN4ZeEwJLuWIcu6sHdF/PMY2CDW9jWDcnH/c3yWufGhgFoKvg==
X-Google-Smtp-Source: AGHT+IEaXfCi1ewgn3oQ+ScQRWTgZLxQ2mQzyyt8fGa45VPuxjo0H4Ae7Hi9iPRqmX29ubSjMWCnnA==
X-Received: by 2002:a05:6a20:3d81:b0:1c0:bf35:ef4c with SMTP id adf61e73a8af0-1c0cc73ae73mr483176637.11.1720070548565;
        Wed, 03 Jul 2024 22:22:28 -0700 (PDT)
Received: from localhost (236.219.125.34.bc.googleusercontent.com. [34.125.219.236])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac157890csm112557435ad.209.2024.07.03.22.22.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 22:22:28 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: <git@vger.kernel.org>,  Johannes Schindelin
 <Johannes.Schindelin@gmx.de>,  Eric Sunshine <sunshine@sunshineco.com>,
  Derrick Stolee <stolee@gmail.com>,  Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 0/4] Additional FAQ entries
In-Reply-To: <20240704003818.750223-1-sandals@crustytoothpaste.net> (brian
	m. carlson's message of "Thu, 4 Jul 2024 00:38:14 +0000")
References: <20240704003818.750223-1-sandals@crustytoothpaste.net>
Date: Wed, 03 Jul 2024 22:22:27 -0700
Message-ID: <xmqqzfqx7muk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> This series introduces some additional Git FAQ entries on various
> topics.  They are all things I've seen in my professional life or on
> Stack Overflow, so I've written documentation.
>
> There were some suggestions in the past that the text "modify, tamper
> with, or buffer" might be somewhat redundant, but I've chosen to keep
> the text as it is to avoid arguments like, "Well, buffering the entire
> request or response isn't really modifying it, so Git should just work
> in that situation," when we already know that doesn't work.

Buffering the entire thing will break because ...?  Deadlock?  Or is
there anything more subtle going on?

Are we affected by any frame boundary (do we even notice?) that
happens at layer lower than our own pkt-line layer at all (i.e. we
sent two chunks and we fail to work on them correctly if the network
collapses them into one chunk, without changing a single byte, just
changing the number of read() system calls that reads them?)?

Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6713A134B1
	for <git@vger.kernel.org>; Sat,  6 Jul 2024 05:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720245009; cv=none; b=R8kB4rvbIYQyMrewkQnTXnhIKeIXoGUCET2NBz9gJIfco2uZX/j/klSY/TsQxD2Wlb3tuPK0sN0NOWDvPyqNyDzFqF2kKevf/oZmGabiB9tlrCixkn/zQujtkxsihq7Sfjf/zITvkfjthSDi3v0VdGhuaxcZjyeXgtxjd3Q4RfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720245009; c=relaxed/simple;
	bh=mJkjBu9clpd94p8Ht7RRTGb7Fxjv1bPPH0Vq1rrKd9A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FCCShotWZEmxoksm1w0cjfrNLC08OzCJusVGbKYCjjvULfm3btEhXBU4yEy+PireZoY+stN1XgmHPb7QCVytGSOtO0Nd7CZL75jTSEkY2G0jPZ7yG5kshmCDAYBAVcpD/uwY+gng5VqmRDCfRV2l5qL2+aSTioWVa1i1l5bppro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jmUkSigJ; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jmUkSigJ"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-767506e1136so857068a12.0
        for <git@vger.kernel.org>; Fri, 05 Jul 2024 22:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720245007; x=1720849807; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eOEsu++E0rL1buwolpmw0aazlcwnlrQh6Jsq6xa2+S0=;
        b=jmUkSigJ2kG308Y7Pxzze+TrH+9bPGSniyr8AWVmcJIj0stWZbhzxY4S6/CHbo6bew
         TMOKIpw9ECVJNzjx6bNfxhhYEcnQQYZL/r5mH32qGUPQirh14gkr5V7zbFr1pTTidBX6
         WBLTm3kcF5ceBmBD4eQcPuzg9ScuffVcZI9YeEfuvZv/oUjfzC7Mtmwxgl+6iFvuzxPS
         yoP0PN6BmynrA7Z/P2VfK990ov1hYgyVa8z3xN04Iivm0bdAF4he8xbevLAKXCaoQbfx
         jmhNS+5QaQdWlEsLIYtfG2dAxfGilAyy2xyeL4oMjEggm2aw5h6QL8XlSsTENpPp5F9N
         JHUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720245007; x=1720849807;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eOEsu++E0rL1buwolpmw0aazlcwnlrQh6Jsq6xa2+S0=;
        b=jPGBOw2/zhymIhyB4/Elbv/zY1QUGqDYlIk9EZsD5TyMwtmtajl6ijH7eGAZy+er64
         0GIN6sootR0s2OewIdxujYcU6Fey5SWVDL196cKAXxAlSrM3CJYKUrbsaj5JDBBEE12P
         iF1yn5d40x/xEQlS12nv8fary/z5h7PLwn4JObKBRPfZc38YTi3NTIkOK33I+aXLLsFb
         HbyWs7t9c7OSQRLF3XbyDzsjxYXmLMmJ6RVuaUxq/OP0YUwNtkc5lNY9ubLlmoi/TRwg
         yLzGB+/7qiRttsRHDepzlE4cLJXjXdVRmrDacr3g5odqvA0KPvH610T3zjwcbIZKyvyy
         7ZYQ==
X-Gm-Message-State: AOJu0Yz3eXdc+KSmmpLupxp6bT0wRpgV7P1tr+ZSEMff46u0ba05VTUa
	rNReI1t4KLV5umeaND3JUpvZ2ZuCLA/kua43x3RfrQAncOLCKaIp
X-Google-Smtp-Source: AGHT+IEwI8mmERsICU9OkDsrFfrJHzq6Ql+wP6cVpCJb6d/kvB6o2+b3Wdl2021X7zNrOzvCwhPm9Q==
X-Received: by 2002:a17:90a:ce15:b0:2c8:3e89:bbab with SMTP id 98e67ed59e1d1-2c99f3c0834mr9001830a91.22.1720245006545;
        Fri, 05 Jul 2024 22:50:06 -0700 (PDT)
Received: from localhost (236.219.125.34.bc.googleusercontent.com. [34.125.219.236])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c99aa1a89fsm4325611a91.52.2024.07.05.22.50.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 22:50:06 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: git@vger.kernel.org,  Johannes Schindelin <Johannes.Schindelin@gmx.de>,
  Eric Sunshine <sunshine@sunshineco.com>,  Derrick Stolee
 <stolee@gmail.com>,  Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 3/4] gitfaq: add entry about syncing working trees
In-Reply-To: <ZocPYKyVzSDIekTK@tapette.crustytoothpaste.net> (brian
	m. carlson's message of "Thu, 4 Jul 2024 21:08:48 +0000")
References: <20240704003818.750223-1-sandals@crustytoothpaste.net>
	<20240704003818.750223-4-sandals@crustytoothpaste.net>
	<xmqqjzi191fw.fsf@gitster.g>
	<ZocPYKyVzSDIekTK@tapette.crustytoothpaste.net>
Date: Fri, 05 Jul 2024 22:50:05 -0700
Message-ID: <xmqqv81j3w8i.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> The most common situation we see is that refs tend to be renamed to
> things like "refs/heads/main 2", which is obviously not a valid refname
> and doesn't work, or the ref gets rolled back to an older version.
> Working trees also get stuck into weird states where files keep coming
> back or getting deleted, or the index gets two differently named copies,
> neither of which is "index".
>
> It is _less_ likely that objects are renamed, but it could be that the
> tool thinks they've been legitimately deleted if the loose objects get
> packed and then they do get deleted elsewhere without another source of
> those objects existing.

Yeah, any time two repositories that are "cloud synched" are
accessed simultaneously, all h*ll can easily break loose.  You may
move your 'master' branch to a commit while the other one may move
their 'master' branch to a different commit.  You may end up having
"master" that points at one of these commits but one of you may have
already lost the only reference to the commit you wanted to have at
the tip of your 'master' branch.  One of you may even trigger auto-gc
to spread the damage.

> If we have users who ask about this, I'm happy to answer them on the
> list.  I don't want to explain the various and sundry scenarios in the
> FAQ entry in order to keep it short, but I can find several examples of
> problems if need be.

OK, that approach would work as long as you are still involved in
the project, but having even one concrete example would help in the
longer term to (1) reduce the bus factor and (2) save time you do
not have to spend responding to every such question.

Thanks.

Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6516B20E6E9
	for <git@vger.kernel.org>; Thu, 12 Dec 2024 08:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733991921; cv=none; b=WLN69TVIndMmDwjxijM99oTw4t9QpgKYqG/4Ghhk66LwC/DLkvmf2dLKgzjWYbwpn0u7qwn6IiwS0K7y90Rdz38d4dR8hgQjnGosAY397zNz2/1Pb3vD1IZVd97494ZkW+gAOiF32kdw9U0LlwcL7cR64fDGmzFe7+BMnbkrqg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733991921; c=relaxed/simple;
	bh=biUwhLN32NMELDyiNGuQXg+OKsuLcNBm1/2hfGVrYEU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CW8hyCgXTa5e7teGEZ//0TSWf7wUjtqoI8eWMqCs+yq4GEiDsk+g0MTP4ctlXrrp0PvVf3N5q0ruTEIkD9dYhrXAzF0fxLgp8Bo0I3xs0O2OzwGFcpdq1Cp9fOvs+n/1efUnlJlFrOCcANF7U7AvGLzanqGGBvma4f5/3kXB0pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c45Ow96d; arc=none smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c45Ow96d"
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-4b24bc0cc65so174825137.2
        for <git@vger.kernel.org>; Thu, 12 Dec 2024 00:25:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733991917; x=1734596717; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=biUwhLN32NMELDyiNGuQXg+OKsuLcNBm1/2hfGVrYEU=;
        b=c45Ow96dE7PszkEk3iVc9m4nJWLF0vhzOY3dnrnzItvC+wedBSWP3m+fslcqKa8WOC
         VlLTRJIBZOKn+T5mAlHEmqPqZWJ6YCjMr6CdR0uBOW6YHwNXVNipoa8hJdY6p/w0VZ4G
         f8Fe1BVOKF9pgjFYe90V/Xn9gVEewqycpNWaZsNWhHfY8CV32/zPlEZ9t4IvtFqx8voc
         gUQ9wLeRLzJkWCPFPY5ikUoSxCVilvyb/opflvU3q6pwQerZuBo5aIYr/zpzqVwrAGhb
         so37ZQCFH6ga3wy6HzOkXLn0LmGfo7w3ptF1LGuytk1mQpwrrdc8TzC1WHHP8jcgKTGo
         jMZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733991917; x=1734596717;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=biUwhLN32NMELDyiNGuQXg+OKsuLcNBm1/2hfGVrYEU=;
        b=Uujrqe/oqiLmyfoTdBZkhVkx8vPvt5W8OfXY/qY2PoVSrkdu3gcyNbDAvKX0MW9ZlD
         N62kf268fX2aMikVviQS8JqO2nIVKy2/j7Q48FS+VbGzoisCWiQ3Y5gxZW8iuxHcgUMa
         WFv6UpWk3OuvPEsdOidW9yJb4JQN9eErtfHbKX77/HYLWiBuOWbRLTtU3g2Czm6IxUKm
         QYmqEcsf1LyWZX0adkHzQe91rXUCDXJqUFFNXrB91EB823cXSsNjQFDdHSmkEFuvoqqm
         5byPGKJLAWmozaWdIpzqk+QONG2LfZDfYdW7DJJUMiE7KWMIFzZDhNqjId4SBf14kWAY
         P56Q==
X-Gm-Message-State: AOJu0YyiMmtYYGKOruBYFiKu/D9AfLFBvvQq25bduw+qhLbytcYIwriS
	xK0zNJ509xCuCzik9a6vct94F9AxY1Rb8KCBKvQDVFcwuJnYSMrTPWkrDKAmhvgLE1eflLUwXDD
	9gdKGaXxODxtV8whnF5sLZByHPgwG84uz
X-Gm-Gg: ASbGncsTPzB3nbtUqAI3gZz5CHxEu3Myg9NXEX0JtwPhG90a8b8fcmkl0lxCDxW/Zh+
	QmKRtZU2ZaMn7RwNHY5kvIOSr4EL3XgAMO00gRN7e0v5bBdUTgPNrpw2tQoCw3x81JM+358s=
X-Google-Smtp-Source: AGHT+IEZKJ6vGtN7jt0Unc2U/D+DRSGtEhpzsCuNSX1vvsPhzB8KNKeAPZOYVLJ+lOBLUYonAVMz1/NettwXzRFTxCc=
X-Received: by 2002:a05:6102:31a1:b0:4b2:48b2:db9f with SMTP id
 ada2fe7eead31-4b248b2dd28mr2117563137.13.1733991917283; Thu, 12 Dec 2024
 00:25:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMKQPDZWgq_qCdaL_S8cYYn=wtZSJiq6nP5aqFjvUZcFSnrTzQ@mail.gmail.com>
 <xmqqv7vpfv5g.fsf@gitster.g>
In-Reply-To: <xmqqv7vpfv5g.fsf@gitster.g>
From: Ricardo Almeida <ric.almeida@gmail.com>
Date: Thu, 12 Dec 2024 08:25:06 +0000
Message-ID: <CAMKQPDaB2fP-4n9_bw1fjB7JntZ1DWMSpO01h5uuMJ-LzzufdQ@mail.gmail.com>
Subject: Re: Git pull --rebase and --reset-author-date
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Junio,

> Can't you just use "git fetch && git rebase --..." instead of "pull"
> short-hand?

But then it wouldn't update the master branch... When I'm on myBranch
and execute "git pull origin --rebase --stat master:master" it does
bring the master branch up to date, so, it's equivalent to doing:

git checkout master
git pull
git checkout myBranch
git rebase master

I have an alias for the pull command: "alias.rb=pull origin --rebase
--stat master:master", so, it would be handier to just add the
--reset-author-date to it but it's not supported atm :(

Regards,
Ricardo Almeida

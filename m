Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA4033A9F0
	for <git@vger.kernel.org>; Fri, 27 Feb 2026 06:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772173883; cv=none; b=F+yz75FUjwmy1BU02D2sXkiYcZjO6xfCBMBrXh38kYHFoQVEc27EiAl93q0iPARtZ8yFxnm5M/gL44efxbREIJAIyfVTHVpM8cAzzOhO+b91GxdyqL2ZfvpXXJwy1jcJpCuxBW1Q+Nvzha46zwRqkI2J63C/se25LZtk7aS/qsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772173883; c=relaxed/simple;
	bh=wWRy2E3MpLj7dGOlHSrjovv4/4yCB/iA83g/3Wv1lkU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sL4eE/ojDtcDFPbmbqVmsGBFRQMka4tBYffQaScpr7Xn1/ERgb5Hr14Um36spVIrxlJzTcidF4ZZudmYIJLmkuDb2LMHua4dZFRTS843Pp+m9lbU1h4VheseLD3pALlmmRqvi1FNu+7RdFl3zs+tW8pEPfMa0QfPWjZ9imdYoyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=paultarjan.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PJZn+Ky3; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=paultarjan.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PJZn+Ky3"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c70378ddaafso1127937a12.3
        for <git@vger.kernel.org>; Thu, 26 Feb 2026 22:31:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772173880; x=1772778680; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wWRy2E3MpLj7dGOlHSrjovv4/4yCB/iA83g/3Wv1lkU=;
        b=PJZn+Ky3Bp+Ki+PzbrbKSqtZDxkD9VvCcQRYBsHW5+rxQQOcblsuKahpYP4Hh7Gehx
         Z0yDQIRmC0gbEsrdwP0JRbuFkWVHJhwdBEupjO5DxfC/qfMzvaGAy4y3YhXo4l6YcUph
         wTZXvPfj64BFeFNetDZPvM15iG/5jYb8+dfwa4VtX4bCo9AycoD167cJfS2FFV+Xn2E6
         UHVvxwuP7yCOjWTEZtz31EQj40OKBF4bF/Jr1F1uIv+P5MngsoKoZJzfm+zzdXs8WsYS
         OGpRXWAilQ2pwMYWjznHqSdwQxR/OaUC8C0Ch/Vt5CBxczB2QvUNDgtOBvOoiUv/9ckS
         8RHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772173880; x=1772778680;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wWRy2E3MpLj7dGOlHSrjovv4/4yCB/iA83g/3Wv1lkU=;
        b=YPozemISMkcSnGtoOLkBks1KZ1qLsH4ix+qMb5lsc0Kb5ujedrwDBiwkAgPGXLE3jI
         Vk4I0gN8JaWkF3EN/RIzliAyGM5JOUMFdLj94mKz8dFZG0t4OObuO2R+ew0Yt099h61u
         XqXLnXMblxzRXAjAiWvBySQHjq6qGle/QxcmC1GWSRPrpuEZNZutXV/Gdyjr3lh+CEX+
         HSrj9/grl8ZG7q/YrIXCZgEnG0UN8/ysNPZRCbotsUTw7if18+pjSIoKb0Q8tqn0DgoQ
         ysaCgwnYo4ED06plEZ+MmivvjjmUkFYrJuops7mPjbLv2aZ8o3Xp4v5Z/N6Ykdw/Tknl
         KCbA==
X-Gm-Message-State: AOJu0YyCBMhpDoijfsOqfE0qXqJ12UjozuZ/XXNcLgiV93udm6WuJOLs
	K/u3vZa8tqcHHgt9DPyRd10XHV/uIw4UkpxLySFwyko/SzPRXnGNoiyJuAyC9A==
X-Gm-Gg: ATEYQzzry1lUlF7o2tldFdvLZVS2ltq//KyFn6zVJeFYpRINmnEzeoUwdoIsqcd3Scs
	UIH5ZCqyKQtIjoMdcUBLOS60kMKcWe8a1Z55SP1qz4ID20PAtQbIMHheCZuC5hI4LLFiN4BDm0C
	TnJbsbqYdd77PvcEJ14Iaq8BbrkJKKmzOBf8pKDrWDXA53v9HkMrqjUxij2TwYlMEaZxH197JE4
	/wsK72MaF5hpwzOhaNIo9Ghf/qQuTMFnJCV0ySjjKjuGVcrfKMd2Fesv/GB2RMJRaMh+fcZ0NZI
	6O0j061s/8/O4nG692BT7ohTk3QBn2Pm+C5CfA+R3tSbXVhctrJHWd4ECafkw4aWYOtMVsTpJtd
	iAHfaWktY2nFmjWFtERflQMXoTOCBXpo4go94bKs61i8eJqyYyH2cymNmczE8xfWqaAChigwg4f
	JZY7emJV1lhkIgaCN4N6DnxtgL5+lz6ySBt3JnR4y6oDyOrb+k1V8eTSQQw2Cc+y3Ni3c3GhYCX
	9N6xjIkRg==
X-Received: by 2002:a05:6a20:6a04:b0:366:14ac:e1dd with SMTP id adf61e73a8af0-395c3b3db19mr2060972637.67.1772173880297;
        Thu, 26 Feb 2026 22:31:20 -0800 (PST)
Received: from localhost.localdomain (d75-158-111-22.abhsia.telus.net. [75.158.111.22])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb69fa43sm44748755ad.46.2026.02.26.22.31.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 22:31:19 -0800 (PST)
Sender: Paul Tarjan <ptarjan@gmail.com>
From: Paul Tarjan <paul@paultarjan.com>
X-Google-Original-From: Paul Tarjan <github@paulisageek.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	Paul Tarjan <github@paulisageek.com>
Subject: Re: [PATCH v6 04/10] fsmonitor: use pthread_cond_timedwait for cookie wait
Date: Thu, 26 Feb 2026 23:31:18 -0700
Message-ID: <20260227063118.9069-1-github@paulisageek.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <xmqqzf4w8r20.fsf@gitster.g>
References: <xmqqzf4w8r20.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Junio C Hamano <gitster@pobox.com> writes:

> I cannot convince myself if one-second interval is not too frequent
> to force everybody, including those with working inotify, to poll.
> I wonder if this is something that may want to be configurable (or
> better yet, auto-detectable, but that may be wishing for moon).

The 1-second timeout only fires when the filesystem fails to deliver
the cookie event at all (e.g. overlayfs in containers where inotify
watches succeed but events never arrive). On a working filesystem
the cookie event comes back in well under a millisecond, so the
timeout never triggers. When it does fire, the client falls back to
a full scan, which is the safe default. Happy to make it
configurable if you think that's worth it, but the current behavior
seemed reasonable as a starting point.

Thanks,
Paul

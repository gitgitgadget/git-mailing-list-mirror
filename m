Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014051F03C9
	for <git@vger.kernel.org>; Tue, 22 Apr 2025 11:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745323088; cv=none; b=OIkKYdhnwRZQr8RwR9074dipEbN805llKIfZNtgO/3KXNlwA1XOy8WBSJYCsWx7GUmT0z7UW4oSY1Wk7NBcnuHl5Kj+8BTA0ujFOFNoaS9xP9lD2hX+O2aECJcVA9zoQkggefn5vB24mvlDE2tljkwht5FpuXVO/HmUr5YuAD5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745323088; c=relaxed/simple;
	bh=L4ShAv5Jj3G+GV1R1fm4fp3Fl09zjs4ncxOl0MYwDjc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pkN06JqSi7cF29CHSISCXJGpsI2Zb9MW/xjYsyu2OeTXvXNIZGYjhzRVxk8DPGQLimAHUWHxq1j+EZSseCan6KRSsybGwfig4QA3n4dK6pEeI6HzVDToBUNXp2kg5B8PlkNM7m8JusQ9jNTi8peAJfZO6STH3QZESUBGIqjKfP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iq/hwQqu; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iq/hwQqu"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-476ae781d21so53068781cf.3
        for <git@vger.kernel.org>; Tue, 22 Apr 2025 04:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745323086; x=1745927886; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=L4ShAv5Jj3G+GV1R1fm4fp3Fl09zjs4ncxOl0MYwDjc=;
        b=iq/hwQqusl9Zxa7P7PMaUotOAGpb87gys8ycda6S210E63D4U3M3YGk0gusEwX4cww
         c/ITd+J+C1mGLBIfxryZLsoi5EXonwezm4InL4KlNZn8tB2jqf+FsIxKr/yeTy2FCulT
         mAbeYUNXoWKnzZbMqB3zMyzetOGmGCWS4S9+oRNSE53SdOxjWFqDhKQLXLe3S2qBVn5W
         wdIXVT1YgptbioNtUxoj6M6xibgyXhMj8zOfjEIMzMhczKnvQseiJuHUNFvPWGzS8kJP
         KIg7s+IjHAI5S4pFkI9CT7at9m3oPgObdw38V9y9dVhH0uVHzGfHt/Hoc3zqXtSSkOPg
         pIGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745323086; x=1745927886;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L4ShAv5Jj3G+GV1R1fm4fp3Fl09zjs4ncxOl0MYwDjc=;
        b=ac/qZ9A7K6ADnB0BG+GN0DSRj4vbBL9sfcQC6DTQvME80llRuRd/Jy1YUZLg+U4oHE
         Odbb7JWRaFj2aaus3JGIMcdcWm8KeclnxvZdBCWXOjE78V5T9KqBNu1uuwPXdOGbzut9
         GKKO/SEhEceVU2cH8d8f+PUagNs45xxdm7BAXWtFg9+PIoiviMYaAQxfywXAJCgU5I1b
         gv9LWwdlLFP5jatNlfSbuqkQ0rCqBaij8Q7AIZMKuE7YCz+QgcYTMv/p+8VHrgsLdxSm
         xgJDka/R3C4YFl/iEdxacmITTQWnkWOU2jVV6NJhuoDGFeLF9Q0sUHorWB2S/bH/tvdC
         o0Cw==
X-Forwarded-Encrypted: i=1; AJvYcCUAmFlF1/QMmnZ64yjagZFFQMiTIRqQUE3ZNKJKDO24Fo156kHzdsBx08hteUvlIsCLjgs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYHBdd6hC2eM3wAi1RZ5CwCuVn0C2O8W/dN1Ykp2i2Vwy29CYW
	frOSI8anXB3WzjH9r3Vj9RWDffXgJ6DcnirRpHK34UYr00dSSYpRJRxKxv/9TXjlxA77A9kWDar
	Vu4S1HFgnJcJhsF/cg4egntSqFV0=
X-Gm-Gg: ASbGncvZUuqknjiekOC8qTt1dH3b3zLY0GUoqtar9HchZzi019yxE1kLt0pZkf5bNLS
	KooPs0S2g89jqeHsRjN6zu5gWeGhTiMHuw42cHKJzj8mrhA6BfHmxtCSHO9JcC6eZD9nhIX+ikj
	RjfXoI7ecc6lFHvl+jqnM9QECflMV3jvlnouuUl3QN5RxhMgEJZ+DuQsTBil6AEpX4VA==
X-Google-Smtp-Source: AGHT+IH4yqD0zrPkJt5PwbljrR/aKdIpCt1gNcJvMRr25iUUNmRvRYs8Zyer9ihngZNLr0fgTN3p9lDnwXHyr8Humu0=
X-Received: by 2002:ac8:5ac7:0:b0:476:903c:822e with SMTP id
 d75a77b69052e-47aec410d36mr306307281cf.27.1745323085793; Tue, 22 Apr 2025
 04:58:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250412094607.236382-2-jayatheerthkulkarni2005@gmail.com>
 <20250412174051.780148-1-jayatheerthkulkarni2005@gmail.com>
 <Z_7ekhsBzXK6LKuV@tapette.crustytoothpaste.net> <CA+rGoLfAidyuomeNym5WX8Bo7-jPcfHx35wDeZ7W2aorAN-B7g@mail.gmail.com>
 <xmqqa58gjlnk.fsf@gitster.g> <CA+rGoLesZ3nSjruJ8_XRWVsFpMu8mo_4cCOdB-GFHU_qXkXDCQ@mail.gmail.com>
 <717161C8-497D-42C7-8C10-AC112238EEFD@gmail.com> <xmqqcydchz9o.fsf@gitster.g>
 <CA+rGoLes1u3LZiStmDPmh4iiUNzNY43KyYNdLadQU+cy1TCc4A@mail.gmail.com> <9200B571-071D-4BBF-B5E3-886B5CCFB89A@gmail.com>
In-Reply-To: <9200B571-071D-4BBF-B5E3-886B5CCFB89A@gmail.com>
From: JAYATHEERTH K <jayatheerthkulkarni2005@gmail.com>
Date: Tue, 22 Apr 2025 17:27:54 +0530
X-Gm-Features: ATxdqUEjqtdLTWtVrl4XkkJLDPm1XKptO7H8TjUHTJPcvk6aZHZObeEpSaQli5M
Message-ID: <CA+rGoLe+K-yE5e6TgVOPbtpqinXrg7+k-thDBVTCtimzrWaG8A@mail.gmail.com>
Subject: Re: [PATCH] t3706: Add test for wildcard vs literal pathspec
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org, 
	peff@peff.net, piotrsiupa@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hey Lucas

Thank you for the -v tag advice,
found the problem

Fixing and sending patch as soon as possible

Sorry for the late emails

exams on head : \

Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B367F32BF52
	for <git@vger.kernel.org>; Tue, 12 May 2026 17:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778605246; cv=none; b=H7ppv+NNccNYZ4NXzWKyvuyb92wp83q/VCV+fZnBdEP+j7oySYySSdSbsJZouP8M4ksQIOoUeyGGI9bpM+ZBPwgEihsevnG3iPXSBA7I+pHw0p0ft0UI8D5vuC1Yg/su5RCOmQUHM5zcKNW32eV09DarbxpntKh/VGhOr+RdBYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778605246; c=relaxed/simple;
	bh=uiCcbRKL4Icf3VnjNCE9VEeswi9SP/XcRCJi53OW5qs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aA6byeK+ChjpPloBTk1HWYbL0vPa6yaxvIaqUkcrQbOx8JQTusXFySSSQppCot0RllpkMzIduCA6MLIZ0v7/hAgbuycFuwCLEMUSb6NeafyMYOheMult4ZD/LXd6N6si2Zx2bdVAT5Q9udA7Fs8WtMcjuidFOTUBJzN9YC5lDDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GtP+wIZH; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GtP+wIZH"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5a8721851e2so6323493e87.0
        for <git@vger.kernel.org>; Tue, 12 May 2026 10:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778605243; x=1779210043; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jv19xHYiw3B6pqU+HAlrNz0Vxwn75avOwYqIz9p0Sm4=;
        b=GtP+wIZHrniInHHC7nXtMCi2xSbWGZ3rOfHauYRpB6A0H++zejROxwm1PuAqHlc7ly
         NZk6HFtyfRfqJXDMxngBxmmeDUXaCMuu1eP3w1vMkEXj6psUaP5GSi6Or+vTZtW4GNBB
         fd6kxwDnKbHd/GnmC7mRPyKZaJeSozr0IPlKgUfOxLn1HZmJEb7YVMgm1FbjGoKuiaVR
         K5gRK1GX5BI7c8eSR55lgydJeGEht2VQ9+j5pkA6ImOoHY6o9uhVZ9D2i5ooG2bY8v5o
         MjPb8AfdbuT6CUzZGIjZ+U1xkgTe9SBFIM5/lEygPx8pVBmrkFvV7XBjU7ewfX1IhlvB
         BWTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778605243; x=1779210043;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Jv19xHYiw3B6pqU+HAlrNz0Vxwn75avOwYqIz9p0Sm4=;
        b=gWK54v9A0nAb1MAe8RMFd1tOJHU6g9Ih3pD0PqeCSvXuxN1b10RXZHW77aufZN+GAd
         ao/s7gTN4idmmFaqpLzBtNQjVPjQqU3XvkWEOAUhbZVE81hkRPpAR6LJ+jGU0aG/cbVC
         LIBQKBoBJ6LMgnRFgEo9ejrKAUBjNGRdXyj7NyUAaUptctYoDQq188Ge75BvEUbW4IOq
         5JMXw0fPTJ2Wp3UhnYkupoQnoalzbsHzvEHr+y3H6H8ZdKdL9dubJmZU7VFYRX4DbnbA
         ufNeeEethGN6+DyBZQYt8pUvLBPCN3AzowGwE2Zd9+OHwL5DClw7CxUy8UpeEslXIvpW
         pSRA==
X-Gm-Message-State: AOJu0YzsJONxwPgRBUjjXaF6U+QzVlrLzK6YfD8UbLybVhAiXRWmq+I0
	YEL8t133Fzir1KQc49yuiZ+4/BsrDnKmO3eYy/VOvF2KXsLU+eGWrpWA
X-Gm-Gg: Acq92OGo4f+thdwamTSHJ9L8HIsO04DdO0na8SUa6vVN92IPY2PFo5cjFK/H8hTQI7Q
	Xvta/shAuk8PXM3AxDtGbotpL34QOQSLX/TXZdCI5VflrcpTd1alWhcIupR8ZVaImJ+L8v9NqnV
	yqa6g1r4CqSvMnkvVsNIsDnLxE/rKTu4rN4sVSSw9N1E3PdingoDVEgui0NRRU9pZ0Hng2UKyua
	6ZycwX9cE1bXYJPuwUSXIvG4R0p/2fcRctQJGJQmdFf1JpijnuAvhO96izVgAwP8NTGWstggkvv
	QsjOwr6usCPf3HpTwy42QNJqATvpAvoZ4xahNS0SbH6AOCDc5tzPCDEndBtlCWjD/Rsi+m24lN4
	G3l6RSIZpMv1CQjZAXMMNd7My8gyogSE2e2NPdt0avqzNPfYEcvPXnqDTRN/LsZkqlT1QNkiFto
	mxIYZHWNz+mwh0HgokgW1mFI9/YZf38AlqUP+kO74nXmRp81n7HRYWjlUSfH/bkNNtZml1877ix
	U22pgmrNvB17NbV
X-Received: by 2002:a05:6512:3042:b0:5a8:a754:f9d6 with SMTP id 2adb3069b0e04-5a8e31ec7aemr1330082e87.29.1778605242593;
        Tue, 12 May 2026 10:00:42 -0700 (PDT)
Received: from Mac.localdomain (h-85-24-230-197.A753.priv.bahnhof.se. [85.24.230.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a8a951d7e7sm3451513e87.31.2026.05.12.10.00.41
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 12 May 2026 10:00:42 -0700 (PDT)
From: Harald Nordgren <haraldnordgren@gmail.com>
To: gitster@pobox.com
Cc: git@vger.kernel.org,
	gitgitgadget@gmail.com,
	haraldnordgren@gmail.com,
	j6t@kdbg.org,
	kristofferhaugsbakk@fastmail.com
Subject: [PATCH] fetch: add fetch.pruneLocalBranches config
Date: Tue, 12 May 2026 19:00:41 +0200
Message-ID: <20260512170041.92130-1-haraldnordgren@gmail.com>
X-Mailer: git-send-email 2.54.0.72.gbe25572957
In-Reply-To: <xmqq5x4sn393.fsf@gitster.g>
References: <xmqq5x4sn393.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> But the above description uses quite different condition.  You want
> to notice that _they_ removed 'next' (for that, the second-to-last
> fetch may need to be run with --prune) and then remove our local
> hn/topic, but to me, that sounds nonsense for two reasons.

I wanted to be able to be aggresice with deleting, but maybe this went a
bit overboard. Would still be nice to have a nuclear option.


Harald

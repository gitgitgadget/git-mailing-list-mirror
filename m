Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3280449620
	for <git@vger.kernel.org>; Thu,  5 Mar 2026 14:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772720131; cv=none; b=g32K2OjaPb3Pl0VOt1PpEZ6gcc0ZzSIp3klpj4PDvS6eco/Xszb8I40TdCGmQnizaiDj+2dz5itr0KOLmWUeBUwKiv0uL0AsWx86i3MbZoUupe7Sr0RMVPt8Mu0OUDcIdCzbk4qsfmARFinqBWEiA81B+BNPmu83iHjqb1pboj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772720131; c=relaxed/simple;
	bh=mHEUVnJj4kZHdgqrAN2odSC8g/Jb+blvgEgvVsInFuA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t2r4BDTzmL0m8KUuiZE0T3k6Y5gtbWfGe2W1RASHS0n2OEjm55W2AGpjwa5rDwA9w1F8tERO/28yjAnfcmDaPqmVZRbQri5l21T7JPemCK6GFVQTfiM3Fd6WfiGax48hbliadhjlCKxtbsDogeYEgXgAyoxAJ2/u5E/e9bzBLyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=paultarjan.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dHJ3JU9r; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=paultarjan.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dHJ3JU9r"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-506a1b23c05so92985611cf.0
        for <git@vger.kernel.org>; Thu, 05 Mar 2026 06:15:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772720129; x=1773324929; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mHEUVnJj4kZHdgqrAN2odSC8g/Jb+blvgEgvVsInFuA=;
        b=dHJ3JU9rmbB3jQQZ0SLwvtaD1cdQpBORFa2voFUxqD91OqZJC1Zxp9JahYl2YridBX
         z3wYsRqPcfjdXNOzzbno3S+0tUxe3fgdb5g9S4sY/aYjDEVcpgHOhvljNTqKHIyq7UV3
         Wn3swnRqWrhQNJvdecC4A9di7b1f/pAuwDbQXqWtD2iB6CEExGq9YmE37vV5QphYRPQ0
         uEzsuqq+/GCne4BhanntrrywewMLSwYv2Pe1VdAEa8mjNHe4QFGMU76OZFfM3kWm0r/G
         KcUU6C/F1cUH96U4ucTK1Of+Xl3tei7rIZuFeJf0LSFcEQKRhs+rG/XLG2w2KXpHb2AV
         zJ9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772720129; x=1773324929;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mHEUVnJj4kZHdgqrAN2odSC8g/Jb+blvgEgvVsInFuA=;
        b=uJSxweoMMaFX+BtZYjiQd6fDKnE/YozziYYbCjL2pNgr11dPX6ehWHGIHw/UXnhFXg
         NLPtOBNIU5GOA/ya8ja09kegm3d+YnLiJOgiSSjEeASlCB3qE4fNZAoaCkfw83Lf6bCV
         VwExzxfoaP2bmXbJtxJ2lx+XK3zOvZiNCnIss491LR62C6D3e8wKwG6KEPxnLmpTXSQt
         bAxp0UazPfAJWqghasSv2a32IZ8TlX2lADxeo3hr/YLRWCkft0x3pfgGI6m0AXdC3gaZ
         xMWUJ6u32PbUTf9vw9gmeEAl5rs/bZJOOkyTwDf/rv/yM+iGwjRuyX+iht0ZNwG+2vJ5
         EuKg==
X-Gm-Message-State: AOJu0YyZYgpF6n1pmU3gPLwujHqN8I4hzHEo0JGZl8GE6PU0Esj503Ju
	gMDXGLH59b184YrKB/Q2YEckpkAQL59HgrJyPMIV3e2KRlGxF5x/LcEVuo52jA==
X-Gm-Gg: ATEYQzxT54zzccYmqwXBJXQ/QQOqpgmhIPMpdaIo5IuPs4lMF6x5r0aPTQHMZhL6935
	O1dPo6t5e2YD7y2ohZf6IYIrFFNol+WbJrbJYh7p21l30rIfBB/F00PfBTvHb1/rmMzRA3OSIDr
	WEmsLr7sL/LQ1AbsZUbPmArTzb44tjD7BlXEKXMt6iULpX81NSErpdufis8JYH6Bb/J/Z67ZQjC
	rdMfm6HFDa7X3jhQe6d0bK/gYDnIiSfxqpFflxfyP0pg1EDfIGa2O8COeWO7U4fwXVVGxhDW67J
	VmkZBawoYfHWwhkVjRWIJjHo1LgMcHIc8i0jT79OfmC42AicfGYtYUzeNGIMKv79DYb7huXumJn
	hqURAFoQna5Yumcy0JmbPiPwXlWGPteDDa/DRT7gpDYKHNTcxHR+Z/oCyc2rpHiqUCfqo7H79Hf
	HlOsRwCaYN7WqZ+u0ztZZ9ablsVxmI5TkLa+M6vf2tWKtj9zF8CWfn56sr3cc3HBWvyU6nCkZXz
	5STqm7rHQ==
X-Received: by 2002:ac8:59d5:0:b0:4f1:d85c:d7c3 with SMTP id d75a77b69052e-508db39ef25mr65944751cf.66.1772720128969;
        Thu, 05 Mar 2026 06:15:28 -0800 (PST)
Received: from localhost.localdomain (d75-158-111-22.abhsia.telus.net. [75.158.111.22])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50744afa7d7sm179639451cf.32.2026.03.05.06.15.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 06:15:28 -0800 (PST)
Sender: Paul Tarjan <ptarjan@gmail.com>
From: Paul Tarjan <paul@paultarjan.com>
X-Google-Original-From: Paul Tarjan <github@paulisageek.com>
To: ps@pks.im
Cc: git@vger.kernel.org,
	gitster@pobox.com,
	paul@paultarjan.com,
	Paul Tarjan <github@paulisageek.com>
Subject: Re: [PATCH v11 00/12] fsmonitor: implement filesystem change listener for Linux
Date: Thu,  5 Mar 2026 07:15:25 -0700
Message-ID: <20260305141525.98458-1-github@paulisageek.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <aakyzGksiC2fhhiD@pks.im>
References: <aakyzGksiC2fhhiD@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Patrick Steinhardt <ps@pks.im> writes:

> One ask from my side: I would welcome it if you slowed down a bit with
> sending out new versions. Sending three different versions within a
> couple hours without any reviews in between makes me pause, as I have no
> idea whether the current version is good to be reviewed or whether I
> should expect another 5 rerolls.

Apologies for that. I thought integrating the feedback would be a quick
fix since it was small and worked locally so I /submitted it without
waiting for a Windows build. When it broke I fixed the Windows version,
saw it passed and typed /submit. Then I got the feedback on the mailing
list that it wasn't what Junio wanted so I undid that and noted in my
front matter that (v11 == v8).

> So please take a bit more time to work feedback into your patch series
> before sending out the next version. It's totally fine to wait a couple
> days between iterations.

Sorry for the quick submissions. I'm more used to the Github
development flow where quick iteration on feedback is optimal to get a
PR merged.

> Also, could you please clarify whether the patch series has been written
> by AI and if so, which parts of it are?

I'm an Engineer at Anthropic so I've sadly completely lost my vim muscle
that I built up over 20 years. All the file fwrite() operations were
executed by my Claude wrapper but fully directed and iterated by me,
with every line reviewed by me. That's just how I code nowadays. Claude
is also an excellent code reviewer so it found multiple bugs in my code
too. I'm aware of your policy and think I'm complying with it, but
please let me know if you prefer something else:
https://git-scm.com/docs/SubmittingPatches#ai

These email replies are written by me but sent by Claude calling git
commands as I've messed up formatting in the past trying to use Gmail
and couldn't figure out the right git incantation to send to the mailing
list, but Claude could.

> Thanks!
>
> Patrick

Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4321E1DF2
	for <git@vger.kernel.org>; Wed,  4 Jun 2025 21:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749072204; cv=none; b=Z/esPYQBXv6ALVdfdlIFO3tL2kaWUXoBy1bfuFttl/aDZHmQ0eyEgPcnDGFqBtgFLfs4rd6wYH9/VCmzpr5yXRoPAEvsUTYSALK1XVvE1XUqtuiI1EMTs/cfc8+g6mhAHxwAxl9x7+BTR+BnieIdcp75HJsxnsKu2oBoeKP96B0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749072204; c=relaxed/simple;
	bh=46njJwSsIkscYm55OQ3RdlccGWOp5UcA8r4BEWpZX8g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jGajBccwZrLJrUpNJ6+Ddnd/vAcRIyW7iDjGS6NHClvYehPqAo6O0qU5YUykEKp1EDDExEQ6k5fTYn9LmM94EAC6IK9yTzbSEoWFQCMrXIM1MmAyKRySHx2mJRNgNio8Ci/+9fHLn0sPuZzQ0S628l9EWHePqjnymsNqdW4aIMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EhNElulm; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EhNElulm"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-74019695377so245739b3a.3
        for <git@vger.kernel.org>; Wed, 04 Jun 2025 14:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749072202; x=1749677002; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=u8UQOSftebVolcRSGFsmZopVxJsT/iksrLPM9rQA/T4=;
        b=EhNElulmpkqQXYC96cZ9PzG5xXe2F74ljxNWnuu6hFfpYouqMTf7BoWa4psw3rNkjN
         m/Y/KgBRDPCdbx6nMrlSoSmgfwPOf99QqcwaBEczR1F5it/vV1TFT0OK6TGh4o8BvDB5
         EUBMLMIQLoBmw6cNpkRtgaRcNYdbWV9ABBh7wY5R+vdnIlzV1VhSoYwQc0Jib42T9WVA
         cMW7Eh7MzmP4nvdYAn2z3Jwsg/gqMi8AJ9YXxtZfnktP72ISID2VE/Pl7nwN/Jp4b4+l
         kL3tnL2Vo1BX6wVY4l9qTWIaxUsdaL7pFLiwCeJN6i6u0Uih551w9xy1to+coyGp4TpP
         EEGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749072202; x=1749677002;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u8UQOSftebVolcRSGFsmZopVxJsT/iksrLPM9rQA/T4=;
        b=vh4i34aTxutGSvFMF/1ceE1W+6l1H/JV+Hnufoja/E8ecvbwqAGJUkFZSDUpPg1Chn
         v/BsLrNPdwx/104ZLnlqoCoF3kfsf8yS92wixF1Nm2gzQHqOjA6wjW1JXqLl2nT62B/x
         PXQB6tc4udiBbV73iJK4xB8eOHR6d9JpIFERDlGXgM/1frvitxRsZmy6BTvqk+I+VXBG
         2fGfGCT3cC8efyxLPT1oaHTFONmNPA8ntEwwk0w3WePbT48OqW+lmcUr7Coi4ksd3X21
         S8bYDRWLpksYupoAqEU1rdJVRaYAJeyu78yBDYePGyklkOOxhkNx6GLq7+sSelj+AsnN
         TG8Q==
X-Gm-Message-State: AOJu0YwDOOPCytZI+8IyUP6VlafwNZaYR7szorIVf0yt6KFh2puRMVcu
	EuvYp6gcAucsqr8LZtom78v2uuTw09uDN+b1bLCMNEIcSyrEQnd5vsDl8kf5OQ==
X-Gm-Gg: ASbGnctYknHGfrJUDi+ojUpQDOD5GWXpTLBIfgVCDWKl5LGKJu+l5ShO6uyRdPOW3ef
	Gb1NgWqsOsUHOIDvh77P6aQOdtPfpANgqZZV8twfVnwcH5ncONImHB3uCcC0czvGrT8sBGuMCbx
	S6JqUaKvFejtF3OPQuGe0xyBLgoia5GQ4PNo4MCDceqwmbisk0IFvYvNopllGcebuWwu6yo73n4
	YkAdC384JHCmKOL863uMBNziIOscAs824tRnX4hOTM4H9ahxeh54vaxBSBXQnUQzabcrKjSQIeE
	tEShhEL/Xt19LWDxdxEhgee+DLXurBCMKLasjMGVO0XNzMyx+P2iuXsWmKZm+S+Xkdd/aGgTe6J
	tREf0r2e0+teePY4Lt2tiUo2FWQPT
X-Google-Smtp-Source: AGHT+IEMjE8chcCMryJ46CpCTOH7Hn+PFNWvYkXUmy6CqFW/wGfEQhZryVQ0HfYx1LmMgnMwN8CKEw==
X-Received: by 2002:a05:6a00:8d1:b0:747:bd3b:eae4 with SMTP id d2e1a72fcca58-7480b489665mr6598930b3a.24.1749072202042;
        Wed, 04 Jun 2025 14:23:22 -0700 (PDT)
Received: from XTHCYRY1WD-Collin-Funk (redis-162.tisch.gvad.net. [207.135.66.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-747afe96468sm11604917b3a.27.2025.06.04.14.23.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jun 2025 14:23:21 -0700 (PDT)
From: Collin Funk <collin.funk1@gmail.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 0/3] silencing warnings with curl 8.14
In-Reply-To: <20250604205505.GA1510724@coredump.intra.peff.net> (Jeff King's
	message of "Wed, 4 Jun 2025 16:55:05 -0400")
References: <20250604205505.GA1510724@coredump.intra.peff.net>
Date: Wed, 04 Jun 2025 14:23:21 -0700
Message-ID: <m1ecvzb3qu.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> The new version of curl (which hit Debian unstable a few days ago)
> causes a bunch of compiler warnings because we are passing regular ints
> to curl_easy_setopt() instead of longs. Passing longs has always been
> what you're supposed to do, but the new version is better about
> generating warnings with gcc (I think the type-check has been there for
> a long time, but I gather it was broken and recently fixed).
>
> I split this into three patches since the solutions vary slightly (well,
> the last two are the same, but my pontificating on the solution varies).
>
>   [1/3]: curl: fix integer constant typechecks with curl_easy_setopt()
>   [2/3]: curl: fix integer variable typechecks with curl_easy_setopt()
>   [3/3]: curl: fix symbolic constant typechecks with curl_easy_setopt()

I saw some GitHub CI's fail yesterday due to this as well [1], but can't
seem to find the exact error logs at the moment...

Anyways, I came to the same conclusion as your patches. So:

Reviewed-by: Collin Funk <collin.funk1@gmail.com>

Thanks,
Collin

[1] https://github.com/git/git

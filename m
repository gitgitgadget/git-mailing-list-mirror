Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 981FD1B5AD
	for <git@vger.kernel.org>; Wed,  6 Mar 2024 23:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709768797; cv=none; b=t6Aqnc2GG/+C256lYWiHrcP1zfUPby3VqVoowccIGelVorm13g9qDdjMH4Wt+PFxHENRwktLThFMfHGL2ua1caknkOUEZLuQt5LmW3UwBZHBBZRKf86tpOfZ9hNGAvSNdqZtqY8uPZ61ypNSHBEcaZZaH+dd3qAbw9Q4Oih5x5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709768797; c=relaxed/simple;
	bh=yzGxOXtxpze6c5ZBxocBmcYFmUQPpdIvkI82k6a0VnA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RgzPtEUGBrAo1Pbm2zlNEtJvW5zMbwV7gXUtyQgvkG9gz3IIrmceAF0905LkiMaiZEE+3z25hzIhjxm+0vLHW1Q+Gpd978cxtPyoZcvXUH2ZgBvQeQd6FP+k9yuNXF7VKNbnwvv+BV6Su7pSXrei+AI8UMFsMIl8x877XZLxbQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=JI3pcvJf; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="JI3pcvJf"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-609408d4b31so3624647b3.0
        for <git@vger.kernel.org>; Wed, 06 Mar 2024 15:46:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1709768794; x=1710373594; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=thI5j8SlcQhuIoiC+DfPQbHnOuDL/cyo2SKvgduUYMQ=;
        b=JI3pcvJftYI8m2ui8/5S+Ex/LKRsW+FQszaIRA1wbN/6YGPPH/BIITicQNnRRc0Xyp
         gFIA4KCCro0Edxv6IR0YAcQeyvxWpWGgEVsLGhramEimhVzZDR06G2JmSoecGrR5eDS7
         +Q4WQzxyLquAqFodOZkpQq9Fsl2AghunqPj7HHqiE8L7fNQIXY3Ci5SpfuOTmG+Sh3DQ
         oxlfZ3rRf4amYwpZS+BdkwcZMWwxl49J5J47xDXLx4H/nFvgFdeUTjvOAkRMF30v15Yp
         CY2t2yfx+h+dQY7aWI0ONo9SqWfWn/ngeApbKGU5uIOBtrP1KNDM62+tNSMgxEPG6RQQ
         gk1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709768794; x=1710373594;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=thI5j8SlcQhuIoiC+DfPQbHnOuDL/cyo2SKvgduUYMQ=;
        b=AQb1zrz1iekKQ3vepOEHLgwtBDOdQ9mwzqrqXfgGmyBOQjjp/7JHfCXH5AQ6Eiaqrc
         8iE4uSF//iOfiGU/lU9wYlJk49xUMDQoyBtVxh2VK0ut3I+gkkVOE48bRklJ1Bp9GurH
         3jYXCLOsrHMmSwGrDRyLQMnk4O8Fg3dOWCYWO34XDLVE/GGNTahLy+BnJKxVbp+EoIoH
         9JYDYW5mkxuQj6F8xt4j/tORNVzpuv7QXW1sQr1qW3N4xwVnoi0zfOhQcJAN88ulmoWf
         dtOsZl1ApooqL6i/CwwQrljMSu2/mI8QaOKf1X+jChNAakDnmtu0QoVzr+PHAmfvQqwz
         mhQw==
X-Forwarded-Encrypted: i=1; AJvYcCUOu3g8HxMqrnj4rDunC1LerqiEvWZawduSAbIhGhn1MfMwwpIyN8TxelwBfGa8CfTt2usua+jfJmV9UsZPTn5DPsXK
X-Gm-Message-State: AOJu0YzmNluFE5Ze8DvY/Mt1Av1auNgwKNja/TdfyReTD0TOQqr7T6hw
	ZfwC3kDHqz0GxHAH/puFyunNYcYba0eaac7MKdK/UKXJN6YT69MHXlRdbDR9xHmHKj8zS2xxgOk
	mWNY=
X-Google-Smtp-Source: AGHT+IEafx6yNntq5bz5PziBmcLLUWU2uElNDIlShErHq+ujNN3VoLeIjYx7S2XmyhTo3TgiQxf1vQ==
X-Received: by 2002:a81:77d7:0:b0:609:780b:3579 with SMTP id s206-20020a8177d7000000b00609780b3579mr17820734ywc.38.1709768794496;
        Wed, 06 Mar 2024 15:46:34 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id k14-20020a81ff0e000000b00608943f865bsm3823687ywn.20.2024.03.06.15.46.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 15:46:34 -0800 (PST)
Date: Wed, 6 Mar 2024 18:46:33 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Subject: Re: [PATCH 0/8] builtin/config: introduce subcommands
Message-ID: <ZekAWSqr9qb8FIAD@nand.local>
References: <cover.1709724089.git.ps@pks.im>
 <xmqqil1zs327.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqil1zs327.fsf@gitster.g>

On Wed, Mar 06, 2024 at 09:06:08AM -0800, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>
> >   - `git config foo.bar` -> `git config get foo.bar`
> >
> >   - `git config foo.bar value` -> `git config set foo.bar value`
>
> I actually have been perfectly OK with the above two, but I agree
> that ...

Same here, though I think that we are probably both biased by many years
of familiarity with the existing syntax.

> >   - `git config foo.bar value value-pattern` -> `git config set-all
> >     foo.bar value value-pattern`
>
> ... this was less than discoverable, and would be a good update.
> This one ...

Agreed.

> >   - `git config --get-urlmatch` -> `git config get-urlmatch`.
>
> ... is a Meh to me, personally.  I'd not actively push it
> enthusiastically, but I'd passively accept its existence.

I don't have strong feelings about this, but I wonder if `--urlmatch`
(or `--url-match`) might be an argument to the "get" mode of this
sub-command instead. Something like `git config get --urlmatch` feels
much more natural to me than `git config get-urlmatch`.

Thanks,
Taylor

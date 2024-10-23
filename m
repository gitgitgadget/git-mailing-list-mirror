Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4DC114EC62
	for <git@vger.kernel.org>; Wed, 23 Oct 2024 20:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729715154; cv=none; b=BzpBR0tGiCsREVN9McVRHTqz+UzDxd77rFt6nQ8yk9oDW5YstmWaNJa5logMzpJWN4HwISHM8bj6sRBWazXzqPzg6rpgtU6kpDrODIGt7Eof+IEjZ7AM3DKTTC1f0/CCBOOG/iSkvvGs8lOVNsC904b2i6qx4wBlXOwPAmvk/Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729715154; c=relaxed/simple;
	bh=HijoRQOsmQergnusOxY6exFaikmR9nIaH9w7Y5R8Ifk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z0Ubvjp8gKvAOj8fEiSpijDEOeCUkyG3Oi3+l2LJWWCl4UsoBHSI0Y1kZef3jmJzWUMBw8lC+lyYJvOYvTl9x0jEzNJUeelKbOzajlWezrB8FuxSll6XdwR3WhOzl9nFmHofohvwNYC1YBCa+m6DNtIRjqz/IBuiyXoUMXH0ybU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=AIgdp+ue; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="AIgdp+ue"
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e2908e8d45eso226640276.2
        for <git@vger.kernel.org>; Wed, 23 Oct 2024 13:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1729715152; x=1730319952; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HijoRQOsmQergnusOxY6exFaikmR9nIaH9w7Y5R8Ifk=;
        b=AIgdp+uekn448i3v9vynSmXRLHGCUtlRb10UR4EfgvT/i/EhGE6D7YtbvcugBFEeoY
         9bmHu6bt1/WvD6mSQjKdRdn1aOyi5MOOpKEaq2pIsJn6wSqsbIg1k/sbUUVshBHc4dn+
         W8+isIwGFHi3SguSKH9tfReEzdmzQZV10I+nF+YeAq6mq+T62X73iM3pE8FSygoPzvCP
         4SPqBWR2qRbqvdtj0MIBK/XRcYMRMRTiEZR1eZDKb67urDtM4udEC200//UcNuLDdhEM
         Jf6mlliK3Sg69rL6jM5umRaUju4PyzrtmhN/pYybBZ+tCAcjC8K/ysgf0abvY6COA4BG
         9Gvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729715152; x=1730319952;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HijoRQOsmQergnusOxY6exFaikmR9nIaH9w7Y5R8Ifk=;
        b=tyjqPWJe8HrBZSqlyRZEPE3xLQ9lNF/KxhKLsKhGFkSv94SUHNYW/Lo56qUpPRmrm2
         LnGii/wf1BG8Zgn898XpS1f9arGeTF38LxFRQhtU/sQF1ZOcJYpyjua9ManETQEBJXXO
         HkGiuSVS2XIUI+lB4KZA84VbCeYgY8XlGCnxg1lHnt8BZPsrLT1kgHTyuCr0Mek7z2z0
         s63sukNuKQogdMUKNJ4MUJAHq6U8Gg+6x17WVNu6FkZphUrGA/SYo7GO5zLGGPuluEki
         iY/i9AY4VsQ3sJKNXEVcoMFuMEHxv/4TA9poUpiO3AVOnj1NMifjj5XvvjhOLL67djp1
         QDUA==
X-Forwarded-Encrypted: i=1; AJvYcCU19YTBLiuoF6TJ/S1T+CFsc0oHg4Cu6jLmnlVrSTcuVhwpy8FTwNa2Rui2kQO0rukeTSg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyntbiajB0cF62odnzYyt4MxujGY6wpg11ral0Oupqay4KtpnQ
	gDHvR73rAYhA+LL/5Jq7nidrCetJ2kuwJoJejSqxO7m6pWERK6pshf8IZxAVBRcCVSy45f4BtiI
	bkuY=
X-Google-Smtp-Source: AGHT+IGIBdlyLIVWQT9XUpz9aWXGdMP+Ce8pm2vrVYuVSMUXmES6mSJSxnLPTzpgX5VstoKV4U+3WA==
X-Received: by 2002:a05:6902:2b10:b0:e2b:db9c:535a with SMTP id 3f1490d57ef6-e2e3a6e4c46mr3957403276.49.1729715151735;
        Wed, 23 Oct 2024 13:25:51 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e2e312b9971sm730519276.34.2024.10.23.13.25.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 13:25:51 -0700 (PDT)
Date: Wed, 23 Oct 2024 16:25:50 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>,
	GIT Mailing-list <git@vger.kernel.org>
Subject: Re: [PATCH] meson: fix meson build on 'seen' branch
Message-ID: <ZxlbzrrS+6q7PzFb@nand.local>
References: <12325bcd-fc3b-4d2a-9ec5-20fa2b50297b@ramsayjones.plus.com>
 <ZxbPkU+P8HUwVUDj@nand.local>
 <Zxi8T2BoMX8ltM0E@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zxi8T2BoMX8ltM0E@pks.im>

On Wed, Oct 23, 2024 at 11:05:19AM +0200, Patrick Steinhardt wrote:
> On Mon, Oct 21, 2024 at 06:02:57PM -0400, Taylor Blau wrote:
> > On Sun, Oct 20, 2024 at 01:54:47AM +0100, Ramsay Jones wrote:
> > >
> > > Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
> > > ---
> > >
> > > Hi Taylor, Patrick,
> > >
> > > I tested the v3 patches on the base mentioned in the cover letter
> > > without issues. In the interim, I noticed that the v3 patches had
> > > been queued on the 'seen' branch. I tested with make, as usual, then
> > > with meson (on Linux). This patch was required to fix the meson build
> > > (just in case you weren't already aware, although I suspect you are!).
> >
> > Thanks. It would be nice to have this folded into Patrick's branch.
> > Patrick: thoughts?
>
> Yeah, I'll pick these up with v4 of this patch series. I'll also try to
> make sure next time around that things work cleanly with "seen" and pick
> up dependencies as required.

Thanks, both.

Thanks,
Taylor

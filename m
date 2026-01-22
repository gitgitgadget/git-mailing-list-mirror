Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867AC353ECA
	for <git@vger.kernel.org>; Thu, 22 Jan 2026 19:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769109008; cv=none; b=RGzvyRT/EIjxdCf6J4ZUPs3qkkMVoW0CmXtYppgZyuzyyFcucm/WCpIktMbdnB537eZDv3+Z1Qxc/f87JFE/C2YlVyF+K3m//ZZFC5FWi4BsNZtsaA2qi7oswlapr+3G0DoAyDfpuj+UfexIrK+jtLvVhSpnu0kQg2p/A6yEMT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769109008; c=relaxed/simple;
	bh=/yyHwgQMHiXg0/x36AyLa2HTS6PNTWvES1s93NIrYwI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iL8+QB6XZ21y3tNjxoQzuUmpGfPrNaoY3DZY9+xNALlZ8E3I3G21JOXA9eQraeS5gizpIUBRTjnacKf+sm9xGldc9s3bMAMtHU6Z7GD7PbbNrax87lEkMHO/Q/FcdSajK7XKpqIje3HPsc3saNd23TkSQdb5NHk1yRw0N0t9Rwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kBqsNYtl; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kBqsNYtl"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-59de0b7c28aso918961e87.1
        for <git@vger.kernel.org>; Thu, 22 Jan 2026 11:10:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769108996; x=1769713796; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nR0DpjPpQYIBsLJlVwhG5/a5DK0izncz3oBrfIyHVbY=;
        b=kBqsNYtl3M2yozZtLoaPH9xVAzf3Lk6ujHHDmVeo2qOtmdKLUJ6eoBT0Ivzi6fSWyt
         0gJNjjEeMQ+GDFu39Hh4kmN6miN9CxF2G5CqlBmhrCbmpu73Oltet7BAUwiHBiyHpIoK
         3VuF7I6VOHhXGOe3Lz3y7uJgivsoS3W5IcDsxhn1QoAUaGaJD4LJmzGNKSSxNp4701Na
         iL2IiQYJpomzlY0aqxddI9PHXamz1GsbV+lm6sVfHsRQPbT4T/ar1GJoCBl8LDgjBRvZ
         wPmf+ARERdpJ03o9viYhQLzRQtQEWK+sWA+eaebH6+2ii9et50yBNyYDVX7AQInpAEIh
         no0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769108996; x=1769713796;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nR0DpjPpQYIBsLJlVwhG5/a5DK0izncz3oBrfIyHVbY=;
        b=Zh4O1gHs3RVn4pp5bLp5kg6Djm4odk798/cpDtCk/aVY0roguXHVNV+LMpIiQ3kfZt
         wPNtHxvpSGilesHefpeBW1QYe9cm5sJ+7C7fqWLjsCyBfqRCfUGZHhsrQxEVDFjmORJ6
         M/3DhIYHsEc7D50FEB0w8v0Gh+UTlU5Hwi+KYmxh7upuFUty92h+mKcfJxOIB0MYi9nN
         QF4eH70/vLrfXO8Vm6ZjMNOsO1/Spggn+t+D4y94Y4kJc7+UKOdYUiGwJFBl72tEQTAP
         t8xLZTMIHaosHRU8ELwcl0haXIdEMnfSkdGv/pjD+vxRmExy0HRlIuhtMX9rtGF4osxJ
         sD0A==
X-Gm-Message-State: AOJu0YyuAmlHPVHpgZKOqa8sgZAl0cYeD+ZLBaukS0jWOnZk7VIlx+eq
	VNML6NZMkm3meoR09XKgi/6uJ2pNzkZxRFTAM5sf2YEbtSpFuIDlFuS9
X-Gm-Gg: AZuq6aLEoUWrfnbSD+A9E4MTo+Tu5cKfV25UR286ectkwwdiE57o5deoU0Ujf3B6pxA
	C476ZhjXIvdAoW/PBNvHra9EP+4mkSrIWt4Zp8fYVcoY+HWKWwTwW/lhp5moaMe9p8ZLg2c5dkX
	poby91PyzjP1XFKUcpk2PqiOn6tZzmB45tiOQoFRZEOQgc/E4RI1nVGPNzO2WbpHnt5ESy6c96F
	f+NBm/pklXnBAgKjsrwvdINFdF8rinDjmMSLfpXF2tYSciHc2uUamrF2bxNsBeYxA323HjODunM
	zG7ujRVjblGk33JTayG1F6tf+70BejCSmmUQHyOMDp09VfSQfkmxUioWmDk4+2SPNUKE5JjGdeA
	ZrtnvzCodFaoFr1xBW8WIzJRHJwTE49LaIl5/VVOIToD8+pu1BWjqHmmGs5cnsP9wP1zTKGgBAC
	AsinjsgFDkFSD3Ub2KltCB6dO6/0SOUEPy/wV6qw5TpQ4MEmhBnWuNkKHRMM4DC8pvufP+Szrvc
	t+g/UiHUg==
X-Received: by 2002:a05:6512:2c0f:b0:59d:e35d:749f with SMTP id 2adb3069b0e04-59de49054e0mr120626e87.9.1769108996176;
        Thu, 22 Jan 2026 11:09:56 -0800 (PST)
Received: from Mac.localdomain (h-85-24-230-197.A753.priv.bahnhof.se. [85.24.230.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59de4927b7dsm73954e87.93.2026.01.22.11.09.55
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 22 Jan 2026 11:09:55 -0800 (PST)
From: Harald Nordgren <haraldnordgren@gmail.com>
To: gitster@pobox.com
Cc: git@vger.kernel.org,
	gitgitgadget@gmail.com,
	haraldnordgren@gmail.com
Subject: Re: [PATCH v27 0/2] status: add status.compareBranches config for multiple branch comparisons
Date: Thu, 22 Jan 2026 20:09:54 +0100
Message-ID: <20260122190954.64780-1-haraldnordgren@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <xmqq1pjho4wn.fsf@gitster.g>
References: <xmqq1pjho4wn.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Before these list of CC's (which does not seem to have any effect,
> by the way.  The message is going only to the list with your
> personal address on CC: and to nobody else), ...

Hmm, I always just the 'git send-email' snippet from example here:
https://lore.kernel.org/git/xmqqbjilo6h9.fsf@gitster.g/, which for this
message is:

  git send-email \
    --in-reply-to=xmqqbjilo6h9.fsf@gitster.g \
    --to=gitster@pobox.com \
    --cc=git@vger.kernel.org \
    --cc=gitgitgadget@gmail.com \
    --cc=haraldnordgren@gmail.com \
    --cc=peff@peff.net \
    /path/to/YOUR_REPLY

> ... please summarize
> 
>  (1) what this series of patches are about, to help those who
>      encounter these patches for the first time, and
> 
>  (2) what changed in this iteration (v27) relative to the previous
>      iteration (v26).
> 
> I happen to have seen your other message so I can guess this is
> about deduping when more than one comparison target is listed and
> some happen to become the same branches, but others may not have
> seen that other message, and it is not helpful to just dump the
> range-diff and force them to read it to deduce what you did.

Fair point, but I always always use GitGitGadget to submit patches to here,
I'm sure sure if there is a way to do that from there?

I just write '/submit' to create the whole patch:
https://github.com/git/git/pull/2138#issuecomment-3785055635


Harald

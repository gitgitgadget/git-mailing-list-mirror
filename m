Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83980139CE2
	for <git@vger.kernel.org>; Tue, 22 Oct 2024 16:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729615705; cv=none; b=K3x/fuEY2OG2Env5Ni8oqBrEQpAYbO21Aa8yY5JB5MrkPKxT28Iss0V5hR7anAlYHHlzr4AFIFctAP3BqA/Q2Qew0i6NY1Q0fq/8wLFnnqgFIJAGjPlk98TYzmIKZO1YJCRiQa6nh3K+GpONtfRrh+ddaGhCzGYOPTSiZ1DmDiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729615705; c=relaxed/simple;
	bh=SYG19Fg1Vo9OlhCO/0bd/hYMQoCikBRNpB/LttxmYdU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PK9EXR6KV+u5zhHpTiVTElMZds0pJYojojc8fVeGy+caTBMknZV7YnEWmN2YUpkpL5vhAsOUhAX+3vaObSGU/vyS9OO1KpdKukB2GwzWyNxCRH6miXt5Zvcz8vHr3TWlI6cw4cFjJdp5Sq59GFrr8NnX+J7UrbYpSdX/qTzf+Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=lMX2oRRs; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="lMX2oRRs"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6e2f4c1f79bso48923137b3.1
        for <git@vger.kernel.org>; Tue, 22 Oct 2024 09:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1729615703; x=1730220503; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SYG19Fg1Vo9OlhCO/0bd/hYMQoCikBRNpB/LttxmYdU=;
        b=lMX2oRRs5NVIN2JJTE2Q12Bl+9boQHIPVYOo8yE6zC+mdjuBdNW24KIS3tWKC0pB/6
         ssCD8XXeII9x2ISh1cmn+VZbYCs9Asv3ZTHch0b3nOqNrERRnV/R2R0sjLrFLWYp2rBB
         0D10MxkjHOxsmgayPLCMsFRtZNVKmvGUBnb4jfrQl8LqayRkxXfiWJf8H2PH7SjheRgf
         aeSKrtGpldJ/UxXsscBUzNtK2qaBPo1dFjSfA8NAj6gIdC751OedQBFHmWO/tW9TJUFr
         8yQs8+kW/MevFUyACCXrgJsr3fSxevZqALz9KyKAb5QNbpcdA2j3mTdDeBWQ9cMxPHM1
         OcdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729615703; x=1730220503;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SYG19Fg1Vo9OlhCO/0bd/hYMQoCikBRNpB/LttxmYdU=;
        b=S1H6g6bLH7UG8Wq6r6Scrxq2gsg4ZAdOHoEWiV+oZC1Gyn6RO8nrum52ddSIHHyzw4
         TYTmu0PXsKLsHQIKFuyBpdBSLLJZHds7xPvV3/OV9uYQa6L/Um+DfEfYhJyQsRzHMsv0
         0yBNIqby9fVFG/zPr2kJoI2qLQwtF/MuYOk6BYpxE3jIl6BQw1Kd5Wqv0pa9zD7zWw0J
         MM3r7cHfuSuNyeSEwfqcjntaUCHtz19vM7IrZboyiBiIylBcmiiinD3DOL5dCxOBxDqU
         j4uymuKtttI+Ld5v8wr1C4sLcwAxOb2lfkkx4B944VfH3sw/+h/jPMXPcw2zpIm/s/6V
         7jEw==
X-Forwarded-Encrypted: i=1; AJvYcCUnvYl1DzTVKiAcszIhxgfp9x2feZbZ+qdRnoqxVd4IZMIPeZdfXk+HssZaaB2MVeyOFxE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+/TwhCmpxL0ejWCMCfo2IlaBb7V+eoX0MMHAoP3W+KCkDwEsa
	RLr/KdQO8kW41ModqbBDwQaAMAbEaa8UnprzOUBRl3Fio5ZGnPToCNy1gVpJYok=
X-Google-Smtp-Source: AGHT+IHFWVuMa20aqm8/tP4PinTv5O31dpI8i8nyMsJpkNVuQxSUpRlljm+YrQiumYdByE8gYvvr3w==
X-Received: by 2002:a05:690c:46c7:b0:6e3:33af:6b64 with SMTP id 00721157ae682-6e7d820ed84mr37414147b3.14.1729615703514;
        Tue, 22 Oct 2024 09:48:23 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e5f5acc362sm11462077b3.59.2024.10.22.09.48.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 09:48:23 -0700 (PDT)
Date: Tue, 22 Oct 2024 12:48:22 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: chizobajames21@gmail.com, git@vger.kernel.org, gitster@pobox.com,
	phillip.wood@dunelm.org.uk, sunshine@sunshineco.com
Subject: Re: [Outreachy][PATCH v7] t6050: avoid pipes with upstream Git
 commands
Message-ID: <ZxfXVvPtpT7SN10s@nand.local>
References: <20241014152411.11052-1-chizobajames21@gmail.com>
 <20241022012701.8959-1-chizobajames21@gmail.com>
 <Zxcx6otjnmn6LLJ4@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zxcx6otjnmn6LLJ4@pks.im>

On Tue, Oct 22, 2024 at 07:02:41AM +0200, Patrick Steinhardt wrote:
> On Tue, Oct 22, 2024 at 02:27:01AM +0100, chizobajames21@gmail.com wrote:
> > From: Chizoba ODINAKA <chizobajames21@gmail.com>
> >
> > In pipes, the exit code of a chain of commands is determined by
> > the final command. In order not to miss the exit code of a failed
> > Git command, avoid pipes instead write output of Git commands
> > into a file.
> > For better debugging experience, instances of "grep" were changed
> > to "test_grep". "test_grep" provides more context in case of a
> > failed "grep".
>
> Thanks, this version looks good to me!

Thanks, both. Let's start merging this one down.

Thanks,
Taylor

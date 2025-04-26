Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A18225C6ED
	for <git@vger.kernel.org>; Sat, 26 Apr 2025 14:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745676762; cv=none; b=kTnr9dhyTNQ9MiXFa8UdapHvuJljr6PCePnEeHLq5OGZqd8g1BnuBRafBOZkmcVDOPRs3NUFdfRVw19YxWNowQsYZYlhve0mdHdcWHuljSQzqQyfy8ZLTXDdi4Ws+YYEsZXLTD6jquyirfPscpTiuinihx/dUA+t88EkbTkHJ5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745676762; c=relaxed/simple;
	bh=nRjWiAb9i3vyAWugiGJN9uftZODdvN6YRZT4tzdT6Ss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aD++n3j4e9rw+FePKOJwsRwtC8A6UGKUaL+LL4yLigxMzA8UvfrgrvVR+yGCXk/piBnpBi6ntOFrm5BKG9OBhkhhLhy1ZACokkhRNlvVjG/i/Cc7pb1kct368TqhjjDQaTCrQ8xkJriDR3R/owEXGL/fOJ/qJM2aBMa/A9WJeQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NknAkjET; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NknAkjET"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-73c17c770a7so4368360b3a.2
        for <git@vger.kernel.org>; Sat, 26 Apr 2025 07:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745676760; x=1746281560; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=enYZ2uTnefkgA5krtXkagnNpH4R7AQgcYQsU5y5zhVc=;
        b=NknAkjETBvYgIBunRhR3dlPrvOMGHV0//7kvGLdvJhV8NxFB1cK+9AumaAqqy1NjXD
         fuR+8ns0fKyyKLyW/+NYNptu2b7DGIGHVtDXQlGueq9yePbupapapuxQpZxAh2k8Li3M
         o5WHo4f3pMjy7J5jdq+zwch1C5JNLa7GvPNR3qmGyno/sMUUVInpQ4P7dn7jgj9Wdf7I
         xMpUaU0Gd9t8wsAX2tJ/ZcBAkP/ddihTM0lyOfZYJpYlmxgy8FHNUh+9u/9BDaoDcxCo
         /IumJD3NddyG8vwGncceLbpfmacpe19jZxWyluxjC+kkipqbuVF3Ypk0JrugVIJPgAw2
         s3cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745676760; x=1746281560;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=enYZ2uTnefkgA5krtXkagnNpH4R7AQgcYQsU5y5zhVc=;
        b=WmnatFIVqkzNCCQAZY3rwRW8K4ugAS4aIDlqrSb16No1cJvYgr7iAeKu+vUHeF8W3V
         UNBfQj1Xs92Mh+1dQ/l0tVhf9ExEUWkBYYanbp+26OAKb1dEgfgP5kW+eY6TxlylsOI7
         m4LE3M6ZedFd1l6OkeCXyDKC5uFuiF9ksWqqzMMcPmgejI4qqiJ5+9YkaE0leddO02jq
         ZTtibV8k/lbJjvNw6D0f+cHihW8cAINhgRbJ5zyMiiO0S/wkGaiUuOjU/t+w0f+ZMX4J
         FhLqRU7h2cQDdJhprBAmIwh25U433682C63XelRbnOIY0K6IRleWh6DcvaqCHihU6J65
         Vabw==
X-Gm-Message-State: AOJu0Ywme8+LyNI8I5LjBxjNtom1jiBmUYnEoAPfd/Ym6eZVDHRxMlQQ
	DJKoyyQpNAA5pXndxDwqPH1AidOzwClG4mFT2od5n/ichizNUWRS
X-Gm-Gg: ASbGnctFBN1nkQ6eRmVxJaVlQSFXhvf11S7KBgQ5kKUFCwVtPSVPO23q0r6PWbJbAN1
	j/fZDPdSq0wUswkhb9kkwOGbMy0XCoN0/dlxDiWpi3/dQ1AGkoB3Z+5I7kdrVUG0z2tjjIStEhf
	byMldIawKlYvMEhIvH515/MB8P/ujWkJtmJrE51vAZJYfRgsHMO3iYfrBtXHb+CF/iZIRIeciNx
	EYvTcwGZNL04wlhw+kwgmtb9aJ9MhJX9W7VtAE9/9Itt/O6aF9JTAnlKClmednZMtZeFtPdtkRy
	N1yhScruPRfLpOUo8HSDH2o8AYb4FSJI6vs4
X-Google-Smtp-Source: AGHT+IHQO5sZbgKGijZLF6zTIqwpXQLv8GBhmY2yShAOmBGwDvuaqgTB2MggPHXPBx6/i6cIJljqFA==
X-Received: by 2002:a05:6a21:8dc9:b0:1f5:7280:1cf7 with SMTP id adf61e73a8af0-2045b6f51a6mr8094987637.16.1745676760256;
        Sat, 26 Apr 2025 07:12:40 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-73e25a6a171sm4854681b3a.87.2025.04.26.07.12.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Apr 2025 07:12:39 -0700 (PDT)
Date: Sat, 26 Apr 2025 22:12:51 +0800
From: shejialuo <shejialuo@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: repo.eclipse.org outage breaking all our linux CI jobs
Message-ID: <aAzp49aUREpSsCrZ@ArchLinux>
References: <xmqqfrhxtdg9.fsf@gitster.g>
 <aAui8hrhm1qAxGcU@ArchLinux>
 <xmqqikmsuv2e.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqikmsuv2e.fsf@gitster.g>

On Fri, Apr 25, 2025 at 08:20:25AM -0700, Junio C Hamano wrote:
> shejialuo <shejialuo@gmail.com> writes:
> 
> > I want to know whether we should use the "cache" mechanism of CI for
> > these third-party softwares? I somehow feel strange that we would
> > download these softwares in every CI.
> 
> It also feels wasteful to me that the CI jobs need to do a full
> install-dependencies.sh over and over, instead of running it once
> (per platform type), dumping the state, and let all the other jobs
> on the same platform type to restart from that state ;-).

That's right. I'll investigate how to implement this.

Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04F41C824B
	for <git@vger.kernel.org>; Wed,  7 Aug 2024 12:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723034997; cv=none; b=A38t7ILQoZ+mZQFn6enaQvNmNkNc1Tf9hgzCECIPmgWIge0utIIFCiDrm3zuUkLFBkb8gRkquWvyWh/r3fDdzKGu7Rr6/XoaFQvlmvb+eSZRZRFw3qlVpeBCLt8EsIkfscy+AYK/zTIIRR9rW0thovdtbTWxElANxEzxyRZWymQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723034997; c=relaxed/simple;
	bh=c26tSQeXgNnvtHAg5dFs+lCW/SpHi0c6yGc8C5DgUPg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JEaNtfipPId5JVW+wFL3tTdGKm6gZeZuUf3ekGchR3UTVb/g2Sv0HSc+azIecByvnnEG+TMfXvpxkSAGhu5+2vCVb/U9ll6Qz7W4oGrrb9+FqMr7ynVSmjj+ONtU5mO22mQkXoQaL+THA0PBKsxr858APGevUmC3d4eJkz1/kYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aBet6IO6; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aBet6IO6"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7093abb12edso1082505a34.3
        for <git@vger.kernel.org>; Wed, 07 Aug 2024 05:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723034995; x=1723639795; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CVSjGRCo2M41mQmHe/min3Savq48dLsUjj7OkxaUD+A=;
        b=aBet6IO6lm0hA58tbqI1ZFy29Wv+X0K4pWHuBMsHPE/dtS5Wv9ZlXp2//AITQmFJgL
         +TB42KwmqYD5ReeDm59EwnDa7r43mvoeua1jbCaphR6AmEEfZWbzLCAVMawFr97y93md
         6WEVyjPBSOiAApJkI/Fg2Wv8wYVeX66M3lAqk/aZ+B7CCYXEPHNtUq26f3PEZBlGw5fA
         teccAviM9p9qQxGEJVYmY5UaG4QkRSzfYvKSJJWOTFQxuZDNhDPv1C3S/8Hs/hmdbXWl
         G0lK9k/vpJi9EPHQwHLquqN/Qiy766pmn4Djrr4kWSW2aWhG6pFChKsYLAzjF/oiD+7a
         /I0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723034995; x=1723639795;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CVSjGRCo2M41mQmHe/min3Savq48dLsUjj7OkxaUD+A=;
        b=b29BmanvLKKl9kD9YsSevj1doHwzGnxXHjg7HQaZKFcucfr94qk0x0gr47S7X0EEyn
         f4zMJVVvRIEcnTotyVAfQLIuuxLNzlRPyKOfGiFljmplrr7cO/P8BsvkadvajZmKp7Eg
         iK1lXTHDa6oAGsYPArJKzhwfdB1VcOkCGMxn9RtpAmEpyfiSkpmH79B+SvgJYp68Az6b
         IkYWT4M/DBskcMy3zdhUFYvPiVEdGlONEj7fHBMbloF9aIFwYagFCE6iHnx8DsevKIdg
         faVqZpPYQHlXEBdwIStfiSX8FLo1ujdvFZ6nD8vffV0FVM2bWg8DA3OBgOi2Q2lnmC8t
         fhBQ==
X-Forwarded-Encrypted: i=1; AJvYcCWuT2Lwn45e02qYeBBh6PqsK8qazz6aIDVu/nStaPekb6nWQVPVp/pp6/wfWwY83J9WCiCzGMmwZQeaW7N5BcF7HgFX
X-Gm-Message-State: AOJu0YyN7ClH4EIQlvqU+UyuTRwy7aLf0zfNEwrESYdUDD5zM82ca+kE
	hZpI2HgJkJbi9GkulIrgko6JluqVFzZsKe0Vv8+HrweAp6AUs/rp
X-Google-Smtp-Source: AGHT+IHgTxb8kq497T0/fgWqhjGsyuY+hNVBKb0CVxQzirxfQI62E/PjoiH5j5eWvW46R6sGesEIqg==
X-Received: by 2002:a05:6358:938f:b0:1ad:5ba:97dd with SMTP id e5c5f4694b2df-1af3baa984fmr2377460855d.10.1723034994623;
        Wed, 07 Aug 2024 05:49:54 -0700 (PDT)
Received: from localhost ([103.74.125.162])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7b76393ee2dsm8419089a12.40.2024.08.07.05.49.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 05:49:54 -0700 (PDT)
Date: Wed, 7 Aug 2024 20:50:21 +0800
From: shejialuo <shejialuo@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Karthik Nayak <karthik.188@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [GSoC][PATCH v15 7/9] builtin/refs: add verify subcommand
Message-ID: <ZrNtjeV5_gyZXBgB@ArchLinux.localdomain>
References: <ZrEBKjzbyxtMdCCx@ArchLinux>
 <ZrEB16WGGc28dxu2@ArchLinux>
 <ZrHRpnpGkH19godh@tanuki>
 <xmqqsevhy6e7.fsf@gitster.g>
 <ZrMMaubE_V7wUZ3H@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZrMMaubE_V7wUZ3H@tanuki>

> If so, then the only two I had were some spurious newlines. I'm not sure
> whether these really would be worth rerolling the whole patch series.
> 

Karthik has given some reviews. I guess I need to reroll because there
is one typo error in commit message. It's important to make this fixed.

> Patrick


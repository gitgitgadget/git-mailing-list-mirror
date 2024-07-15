Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE4B18B1A
	for <git@vger.kernel.org>; Mon, 15 Jul 2024 18:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721068920; cv=none; b=UYo0jnUE/dibEiNSvlH9HtZU61ffoVfgqwkRPAS51nH2gzG3i6MSEx6VAbO3Q34W8bqH4qx44liEfELakIF5SdgmbwpLxkc0QqXfESR6vEEiNpOQWsResjNjihw7kBrIJLs4EVuQnkDVVuWYyYJpJSw+u37Q8mZpWQZieRVd3eM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721068920; c=relaxed/simple;
	bh=gHk+GBwJTBNw1LpuCo07xiuP6HNHMLrWonxj+BZyMPU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=s4DV+Ab1SJNkZIml2CcVURmeVVcpqPW/nilj3p9aZziiaaldqqspda8vF3q0zSzCqDMBR9wXwtMfppjpsFWBRW80DL9eXcYgpJBdUj6sk2SnKhWLf3SLQyTnitHYMyKa9Wpr/YupZZMoSX2sRaN3Jsg1t+bS6jXNaGB0sysh9P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chainguard.dev; spf=pass smtp.mailfrom=chainguard.dev; dkim=pass (2048-bit key) header.d=chainguard.dev header.i=@chainguard.dev header.b=JZ19oqrb; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chainguard.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chainguard.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=chainguard.dev header.i=@chainguard.dev header.b="JZ19oqrb"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2eea7e2b0e6so62514661fa.3
        for <git@vger.kernel.org>; Mon, 15 Jul 2024 11:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chainguard.dev; s=google; t=1721068915; x=1721673715; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UVC7ydbXpUtNKtYhZdmPY0+DQi+EFgv5EUL8eQ5x4iQ=;
        b=JZ19oqrbjHS5Lwd9BHKftMrr/WlQmso1cjjEf+UZsmAfjmTQ+HeizBbg0dF0UjG1oj
         d0k4G6Qkbb5Ui9XKUVjgFH+U15dmYIzSbvhYmZHQsFa9GlJCd+BNZUKOGElkjzZfjZ4z
         4dsFK7E9dxPJA2k6GIsweTy42uzdgDBAOa8BL6qmZr56jQcNwuiYC+XgVDInLmEl15xg
         Kr+wlxLGwo2VznB4SRRUJVv/EgTHpj0+H+AL8G3R9mfN4Nk4Hv3ENjcBuxnnPXPFXZ91
         8JDykux8jZjswZjfGEawOVv6X5Rgjc/zkmYSe8HaCjz0/nj9LvSCKRfkst4uvRJchEzu
         LwIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721068915; x=1721673715;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UVC7ydbXpUtNKtYhZdmPY0+DQi+EFgv5EUL8eQ5x4iQ=;
        b=DHwRLq1/ncxoqU+Aw94En1z2iRxlW8yr6c3evDF5yPSTVCTXmbcEG1u6dInVnGwP2E
         lsDZBQXZiBr6fRZsrw4qaijCBNjXaINEJzD6GzQPBUCxwdcJXXCS2ofLpMoYkq1JB4cX
         +9X69e0aFcnpibp93Qiq04+Eat4GT9sRV8krpRhHKgNd4DSoBnoqsUyZWAh5ndw5usTf
         IdW8AQdn7UPxPP5Lq4YFVuJv9h67NzJziNAkhW+dOf36gf0UcGqxKwO1os8CmHB0DDPf
         V1g52N1QKmSzUDNFcpn4W66KzVfqbAS6LZe8h4UIfn512IdddQZeON+VaGzWE+HD9FkY
         f6JA==
X-Gm-Message-State: AOJu0Ywyx087ZNr7IiKLgxAPSs33iPosaoODQX25a+YZjzD1K/Fwr5u7
	7CCQgS3LUPuUaDVeyCCoU+RmA6JNw05Tv1ITMpYd4GLGNxSBlfydGX3AXqtcFaArVf6e5r8DPxq
	wFXeiff/ylAVnLhtFyuB342xPA0f1/zcGSRzwXJmQq3tLlR4CKWrheg==
X-Google-Smtp-Source: AGHT+IFvTojpjnVj249uqhD1GnSXbdqsEh+Xn+sm0v1YbGafZOpBETwOLuukz9S5kT4pCLLVZz41P+u2DDqiOawuGVE=
X-Received: by 2002:a2e:8804:0:b0:2ec:4aac:8fd4 with SMTP id
 38308e7fff4ca-2eef415ff9dmr5871fa.1.1721068915216; Mon, 15 Jul 2024 11:41:55
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Scott Moser <scott.moser@chainguard.dev>
Date: Mon, 15 Jul 2024 14:41:43 -0400
Message-ID: <CADaTQqDZ_6wORXOFc2CE90aizgHJ116NDHZhNeY4Nx7NH8DHJw@mail.gmail.com>
Subject: Can dependency on /bin/sh be removed?
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

I'm looking at putting together minimal images to run git.  In order
to make gitcredentials to work (git config credential.helper) the
image needs a /bin/sh.

I realize there are many workflows that are going to need a shell, but
it does not seem like it should be required in order to handle a
gitconfig like:

  [credential-helper]
  helper = /bin/myhelper

In that case, the shell is only being used to tokenize 'myhelper get'.

Is there a solution that I'm missing here?

Would upstream be open to some modifier on the helper value that would
indicate "do not pass to shell" ? Like a '@' to indicate "direct
invoke" rather than letting shell handle?

  [credential-helper]
  helper = @/bin/myhelper

Scott

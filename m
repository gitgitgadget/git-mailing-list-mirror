Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5DE4221FBD
	for <git@vger.kernel.org>; Sat, 26 Jul 2025 21:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753566873; cv=none; b=D3rMIAB2WBJoEeJ/kX74K3ms+IU4iejY9hVft3GUB8iA6qsGrYG72ChyyHL1LyD1DwV6gq7oKvTtitIeNuz1YzT8SxYNVCH4TN1iJUzPQT7qphEXhZTr+W4m6ewfq+5ePlVT7Wyvp3jYNqoK5hmw+BoZ7UYIBR1AHeFNZc0foEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753566873; c=relaxed/simple;
	bh=8DiM+wnEay5BH9617NyWT9iuwslVLjU+bdfsehPMH4w=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=i6/fr8ctUe7Bl8wXoYlaoAquPS6/tJn1He7lrvck/v2Ss1ZVsw2UMXxn2ORCQb+oZ1LuxjfD6SJmcMEAks6VvLO7TxDCHiVwY8CfOO9V/AkNirBUzs0brRxoY9f4p94vRfkdox+IkswPuPyr6rNux4L1Xux20wt3QncfS1TacRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Iev3VaxE; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iev3VaxE"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-234b9dfb842so28839655ad.1
        for <git@vger.kernel.org>; Sat, 26 Jul 2025 14:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753566871; x=1754171671; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8DiM+wnEay5BH9617NyWT9iuwslVLjU+bdfsehPMH4w=;
        b=Iev3VaxExVhbOEWGI62MW614Ae39nBHPiyiK3wx62JvtaeWNbY3oZFoEa55gMKjus2
         1zk9ZuzsiHhKjWFS84YSsWkNroY3tXRXOyX+DJWUKxFY8ek/SIBxyxwmMt4oS+l9N4wr
         V6WZDKCqSqmknHiY4URGB09+0VlDSu/SiFmboQpa2+TU1ihHKZayYMGUwD66L/zDsKgL
         DHjI9CQ8JsvV6kda/TjV1pqbZsrIbZHZ+ez8AhyPukToDOoeeQ5rvcPb2yhq2CrW+lUy
         0ZuK8Jh5EIYZvPLdu9cpn28ObBeytrISFNjpR4Iay1sbcNPOPhJJzWiy/nZvIf6FtLte
         w4LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753566871; x=1754171671;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8DiM+wnEay5BH9617NyWT9iuwslVLjU+bdfsehPMH4w=;
        b=n2oNx+DpiqCxdVW8wb0ihBKwZalOyZaDOA/1xgV5NCt5D2gQnsbigGuPoQUIrcYrCH
         qRYCNYKNkQNbbBqxMlCxhLL/dSoc7kYL0Xifg/PKQrbXmw/nSNUAszRuOsAlzq0FqJk/
         oBttWj3Lxsy/AEeGYKKVg0yJlXwW6XNOZrqGfNMsbYx2EBUr9Lh5j9mr7eeZSEZ6kaES
         OI+pgGkI0icETXL7xzEHe7gLRMseubvR0WDTpcvQW0ATkc0+m5OoS2yGELFFWyfmbTVn
         MWkS/QfKjPfNAZ6pJCh02zvE8piQhH7oNQF0deL55g8zwC/oIwWdAuDbdbB01Pi8Bmgg
         0v2A==
X-Forwarded-Encrypted: i=1; AJvYcCV6ZS9XNWm6OzOtpFDJgRHZ57mAkg/Gn2Djq4DLmPijvpfAoXCQcLaLf/PWs9RzVLSWPXE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHfJ//HNUKKvtQZHt/kDTRoZVfdDt0JPsBK0UTZpRxKta8CoVz
	kg5fUD2ZRM/yKXbXV+1AXZ96fp2ufcpowUxMO3pPJ7nXLkZMEqW+AsfP
X-Gm-Gg: ASbGncvEm0xvc7tLHdTCfSGw2GZSICitaaQZp3qXRSt9HkwNyqAvrhwJOtt9hKNFQMx
	+PYsVnV4ouKf5Y9TPJE9wKn+Ue55Vt1xIu3nvrxLwh1UWdBuQNHKnIv7VApMFYyiMLXWm/NSAXS
	V1ipkkTZ4T4YfwlrUSWKsh8b1+endV5aTSG2BBCJPxMa8uiaszYaOKdvDyEECI46UlD3MgMesSb
	apiBmqfDzop04om6prlDxeFl9DD6e/m/epe3ySb5ZPsi7cHoHDc6Teqra5TIFKqZhPltow3gfF7
	aOnNMuNitHu82Y1q4YQRqzk1Dowfy7rbBiTHhVYUNNVG+pNd3fCpRKHAmgDQpjelDq3VEAeBrNL
	zRYabkkzFI34d698phBQknW6Y7mJfJj/5cRhX3h+NH2HGHGsFz4u1y6KxJbbsNrGsch4/vPanlK
	cIzCmZ
X-Google-Smtp-Source: AGHT+IG7WzynH6Np+r3P1ImOwY6vh0C/uV/xmGEcghILBnS8xehMQsXSQFKSMFalAzwSURo8u4PVMA==
X-Received: by 2002:a17:903:948:b0:23f:adba:fc38 with SMTP id d9443c01a7336-23fb31c4bbemr113628705ad.51.1753566870790;
        Sat, 26 Jul 2025 14:54:30 -0700 (PDT)
Received: from smtpclient.apple (201-1-210-243.dsl.telesp.net.br. [201.1.210.243])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fbe333efesm23096305ad.65.2025.07.26.14.54.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 26 Jul 2025 14:54:30 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [GSoC PATCH v5 1/5] repo: declare the repo command
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
In-Reply-To: <aIHRCz_qswp7RgSy@pks.im>
Date: Sat, 26 Jul 2025 18:54:15 -0300
Cc: Junio C Hamano <gitster@pobox.com>,
 Karthik Nayak <karthik.188@gmail.com>,
 git@vger.kernel.org,
 oswald.buddenhagen@gmx.de,
 ben.knoble@gmail.com,
 phillip.wood@dunelm.org.uk,
 jltobler@gmail.com
Content-Transfer-Encoding: 7bit
Message-Id: <1642D169-F952-4DD6-8D95-50D5F3C400F1@gmail.com>
References: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
 <20250722002835.33428-1-lucasseikioshiro@gmail.com>
 <20250722002835.33428-2-lucasseikioshiro@gmail.com>
 <CAOLa=ZREo19jCj3i+XkRM15AzaAV9ZLOvt42pTiUFmcZpCyS5g@mail.gmail.com>
 <xmqqtt34tfna.fsf@gitster.g> <aIHRCz_qswp7RgSy@pks.im>
To: Patrick Steinhardt <ps@pks.im>
X-Mailer: Apple Mail (2.3826.600.51.1.1)


> I'm not really too sure whether we need to bother with quoting.

Given the set of values that I have planned for this command, the only
problem that I see is in the (near) future where `git-repo-info` will
return paths and only when those paths have less common bytes in those
paths (e.g. newlines).

I think I'll leave the way it is by now because it won't affect the
current set of values (which are "true", "false", "files" and
"reftable"), and we can discuss more about it in the patches related to
paths.

> So with that in mind it's probably better to just do the right thing.

Hmmm... I'm thinking about what is the "right thing" in this context.
For example, `git config --list` doesn't quote when in its key=value
format. Perhaps I'm citing `git config --list` too much :-), but it is
because is the closer command to `git-repo-info` in that sense.

But by now, I think we can discuss it later. Adding the quote_c_style
would be very easy to do in a future patch without changing the behavior
of what we have by now.


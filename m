Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1434680025
	for <git@vger.kernel.org>; Tue, 22 Oct 2024 01:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729561037; cv=none; b=DjGIR9Yh7mUcHy5fDV97hopYgHQi2YgxsTOmBTLFI3udugqMdkyua8v9rGjmD8xf5c26nBYGsm9l16I2WYMufO9x93bT3p++htQ6NXB6VlxboWeIuIAAwBP8g4DC5CwKI1UFl33kvV9IECdQuPqWSA8IxTld9EVVODJr7nvR5Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729561037; c=relaxed/simple;
	bh=Q/z7axWkGnee3gVIdoQlKVkj/AQUDwnPdGVUqU3Gsdg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dNHGA+Kz+KeO4mdGpegc/833a91jx5nLU8MiTrKKrJrmKE0/5zvBAd0Z206KT+JjztPMXBTwkWJgGVUJyxy23vVuMQbnzcqIICjCsDHIigo/q7D3AxVrT4aaWH9NqegHFaXGoLAZrE0sC3s4T2tTwuSVpNnIpOc+6J7SOmaH9XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bwzcxIC3; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bwzcxIC3"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5c94b0b466cso5794063a12.0
        for <git@vger.kernel.org>; Mon, 21 Oct 2024 18:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729561034; x=1730165834; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Q/z7axWkGnee3gVIdoQlKVkj/AQUDwnPdGVUqU3Gsdg=;
        b=bwzcxIC3ipeySL0+6wd8ayB7Ob5uZ8ngPbdbvVrxW7iDQGFi9K5wn0pPlQ8BafSpxn
         KJzK+CB7M58ZLxZTLzPlIle4V8Eui04ie8sngDsjucxxgbTH8SFCh5kMhJwsRSFF4Dvt
         yUIlWrOnd2CuOzQRL2GdkCtY5yLtNi/oYqCOL6+xX6SazZwUfJH1qoYd0+jWKT4xa0NH
         h0NhLcSvomT5xLV5+cxwvVBL3zxPnBm6UINeCbOL2Y+KZItv265QeJShAwcMAQ8Jgrvx
         b+NRlB/5BY0LxGyqN/fPM41f+T9ch+U+uOeQX5CKcvSjSK5lQrTeNPV7pQgJe9R6/g1S
         6Eyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729561034; x=1730165834;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q/z7axWkGnee3gVIdoQlKVkj/AQUDwnPdGVUqU3Gsdg=;
        b=InWtvru+n290h7+0jlAPfAeNSADHY0PeifAjCbTaDcqmYSPuIaZRh0WpWMxkQ4nOGD
         ILvRF1QlQ5PjLQrWxm61inoNAtgT13xKXPdjfX4j77LJGHRtX39CbRgXcPwAoVAv1hk6
         VR81L8ZTtIeCiVGqrfrVSDSSm23USj4Yzt8bPIIbHWKlhwvS6Vc/AHR7uDgTTNTsgEHH
         EzQ2T7D3QgugLUSOMhzsxUTCagmG87uAxpsxWNpSx2Oww4lsshgMFGnvDkavxHi5A5cH
         iF5uAOZG2LMHO5pcKEu0gMStDaD7m5DiZhyA2CJUdSy+WQKc/9K8LQNFcN8/xLZLwNEe
         mVOA==
X-Gm-Message-State: AOJu0YzJLQWwpO9hP0qEjYAuFHtBfFuNn0mN0IeTFBt6XtaHanX6I+F/
	jyTrjw03LsO8iKOOu0walUFWFvXN5iH8ed8OoCClAOo4n2B2LpmgZlX1jOq38BALIboWH0We202
	tcnLtph53/YE8adcTAFI/9NZ/bp0eZB/VFdg=
X-Google-Smtp-Source: AGHT+IE73VBltcFTpIPGB7L9AT8v8F61+otdtYe331navdppyTgUTA6xCwn4bRc1HFoj3ZQEDHPjJRKkmaNpIMXOD6I=
X-Received: by 2002:a17:907:944a:b0:a9a:3459:6b63 with SMTP id
 a640c23a62f3a-a9a69c9eaebmr1327045566b.56.1729561033812; Mon, 21 Oct 2024
 18:37:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014152411.11052-1-chizobajames21@gmail.com> <20241022012701.8959-1-chizobajames21@gmail.com>
In-Reply-To: <20241022012701.8959-1-chizobajames21@gmail.com>
From: Chizoba ODINAKA <chizobajames21@gmail.com>
Date: Tue, 22 Oct 2024 02:37:02 +0100
Message-ID: <CACwP9apQ0mwpw13K5N8PVMcBZrSrYWH4ry_abH8RPrNo8A3WbA@mail.gmail.com>
Subject: Re: [Outreachy][PATCH v7] t6050: avoid pipes with upstream Git commands
To: chizobajames21@gmail.com
Cc: git@vger.kernel.org, gitster@pobox.com, phillip.wood@dunelm.org.uk, 
	ps@pks.im, sunshine@sunshineco.com
Content-Type: text/plain; charset="UTF-8"

Hi

On Tue, 22 Oct 2024 at 02:27, <chizobajames21@gmail.com> wrote:
>
> From: Chizoba ODINAKA <chizobajames21@gmail.com>
>
> In pipes, the exit code of a chain of commands is determined by
> the final command. In order not to miss the exit code of a failed
> Git command, avoid pipes instead write output of Git commands
> into a file.
> For better debugging experience, instances of "grep" were changed
> to "test_grep". "test_grep" provides more context in case of a
> failed "grep".
>
> Signed-off-by: Chizoba ODINAKA <chizobajames21@gmail.com>
> ---
> What changed:
> - a typography error, excess whitespace
>
This patch version has implemented all recommended changes.
Thanks
Chizoba

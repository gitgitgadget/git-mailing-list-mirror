Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705D886336
	for <git@vger.kernel.org>; Thu, 19 Dec 2024 03:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734580111; cv=none; b=U67p6807vUQcTgL3kl4b7HNFkwB3Xanms64z0TZog3o0SFChYArE2rSCtPpcQnSgYpwLUNFZwUyuje+LXsqOAQxCA7e7ik1CjEuUjFsTh6WrGpkfOE21aRttwKTQvjuE7fzAeq7j9HJ590XiEk3E6GdNYdecNNg+8uYl4wJn2Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734580111; c=relaxed/simple;
	bh=20cXpV3lYIYvuLHAE7dseH99yzgtU9+YP9+69rvAG98=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HR83XXe2hzT5j77zO9pe4PBemNtHgUtT4DQaebDHETy5U+Gm/WOtJWnyHJ6Yw73O28hvyHnjyMs4oK5JG3RtBuV5/gj8xLmdpEIUZuH8Hn1jF4ZT8M/+HYmf6tyR/4nCjchxYqU0y/72UWdOoiB8YmPgdP5lQZLzBrLL9XTMK+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EiWH+8oy; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EiWH+8oy"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5d414b8af7bso596472a12.0
        for <git@vger.kernel.org>; Wed, 18 Dec 2024 19:48:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734580108; x=1735184908; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=20cXpV3lYIYvuLHAE7dseH99yzgtU9+YP9+69rvAG98=;
        b=EiWH+8oyWudEUZ3ng9R9rmcnvekub2R4zArKvajKeaJrEsxqStfNFNxUZ8neen6+zg
         jlYWu4fwkWZVAfq9sDWu/E6QGgtmyZsHUBQiZSu/A1NmjE+XpCrV41mA9JEYkP0QUGef
         ZnLN7dm0EU5OxUQgD80dpWct53xEQssB5ZssMwuZ5QZIVS1RhANU9KT2Yjs66zjJsUF8
         UALgyGVVMyS0RAbKj5bcJdVv3/ZToGhQGXIGML4Udcp4fIXaBqX7xsrqitl1pxZZJi07
         jzGUuklWYflQLoUZ9TvOd0cfCtKeitO+Yp1zSfcZ0qUhAuVrQVU6amPF8dzRWNLyj8nF
         hyUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734580108; x=1735184908;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=20cXpV3lYIYvuLHAE7dseH99yzgtU9+YP9+69rvAG98=;
        b=vNBuaWrmkK/1obBYFIJrH5V3vsk04dthypgRrFrGaDPzN0V/ZjOHI6kg5B2PFVtoXo
         uC3HZhTBLz9cHx+aUCc4eCOW3FHGAA5+FnOhww5Rt8i8ukybNN5YJCJA+cbGPW4DIHsI
         3/HHBEyWqHdtDkcOVnIA2SE0C9gHr1UvmXcMAR8gRE9JiGEbTQ2Q0sAAkN9GdJhkJvNc
         +mvIugIHWGWunatCzQ1UeF+vArvWYP8NZJypm9rWVcp0zL1lVZkutMpgDqd2C51DSvlJ
         2UD6nq/4XS39JZbiTNUvmfT1cGcHgmjVpzZ9IEcYaSXCDYcL4kEs7ShpRDay1vLn2FRI
         wxLQ==
X-Gm-Message-State: AOJu0YxciKfyxXNRgEbPwUwnSVXUFPjjTiguWeoXHWh3ZFeb0cHIGbTk
	7ZyagoWK3sLxt/J31OSZYtAgep7DkX0RP8hnx92eRp84YN9t7Ohy3RtgJh/et9J18QQ4oFcq+2m
	xq1LMCpRMAkFRCA7bGZhGWZCT/w==
X-Gm-Gg: ASbGnctdoUqBeRWdZSix/7sxmnTZwARxPDFRGcn8A23PCROqXjo1LipWS83896qwEeQ
	XDDhfb83nZVJ0GpNfnerOMURmEsL/niQ+/9cO
X-Google-Smtp-Source: AGHT+IG3zJ9HjX8CubHfY82PZP1tvS/IjJ0/Z1OdheoLO0oSilAdaFHV/S+cVyXuClS0Dhsf5lUE1LB6msUOtjzjJRY=
X-Received: by 2002:a05:6402:3895:b0:5d1:2440:9ad3 with SMTP id
 4fb4d7f45d1cf-5d7ee410be4mr4881105a12.30.1734580107686; Wed, 18 Dec 2024
 19:48:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMhVC3b+1TWLkKGYVb6VyBRyQjsDpbKRQQNT8SUXSmrWHfPnEQ@mail.gmail.com>
 <xmqqr0674hvq.fsf@gitster.g> <CAMhVC3byz89UP_DJq+c6UVUNoFW0oRRSwbR7v=uUBAdBMLwqMg@mail.gmail.com>
In-Reply-To: <CAMhVC3byz89UP_DJq+c6UVUNoFW0oRRSwbR7v=uUBAdBMLwqMg@mail.gmail.com>
From: Yuri Kanivetsky <yuri.kanivetsky@gmail.com>
Date: Thu, 19 Dec 2024 05:48:15 +0200
Message-ID: <CAMhVC3Zegt+GYXq5g04hLrzsUOqvX63OEPM+HB1syX-4cD2U4A@mail.gmail.com>
Subject: Re: remote.<name>.push without dst doesn't behave as documented
To: Junio C Hamano <gitster@pobox.com>
Cc: Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

I guess I need to add, that I hoped that the beginning would be taken
as a joke. If it wasn't the case, then sorry :( I didn't mean to
offend anyone.

Regards,
Yuri

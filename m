Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48FDB43AAE
	for <git@vger.kernel.org>; Wed,  9 Oct 2024 05:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728452054; cv=none; b=YmFnRcfTtJagAEROMGaNUTr8/KXePnnaHr9kY6YaJfVOCJJ1g3uRqd5D4uShX9G56UcYCU6QijfoLI7USoMIv6ojC50qN3eqS0ZjhbixuKz3J33NNXg4lFdR4HmmYfUJquS9fVIQm0RlyBCZJcYteUZHFvaHPLf2cl3UYk7wiqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728452054; c=relaxed/simple;
	bh=hxNvhDV+hfBBLMqvN8qQADvRjscGC51fwygMT1K5AVc=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=rLcNsF4faOov+6WfgBUyrKtCf8PF4IVOCbBqrJ6Bv9HsQLggg60crM7BS6Ia1kjP81QzMVAi7MAGu/uxP18BuRrebPgeYIZF1uxMLhRpFUl39V8YJYwzbDxX9o1cfXTXoc5IFG7Ice2mAvHSIxzPfSY5897juS6jPVHMZ8mOlOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BzgZWRMk; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BzgZWRMk"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5c5cf26b95aso8232771a12.3
        for <git@vger.kernel.org>; Tue, 08 Oct 2024 22:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728452051; x=1729056851; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hxNvhDV+hfBBLMqvN8qQADvRjscGC51fwygMT1K5AVc=;
        b=BzgZWRMkxDS2+BzxLsupHTICmXVI3Ivmh/whyitrHV/yfHBdv1sLx4FhOpD3jsdzet
         E8cKs6kbzCTpbNxSWPrZbcUBHns5SR+nucrW64dHK8pY/4ZdS8/SAQFDB29wCfLWvrG4
         3hMYG7CsnEWhIVYnwxoqvlw5boyBohAoUgcARlQaktbRqNB5fg56316asegvDlH9oUK8
         2K9V4OApmUPdqzYiGpdXbqPA/B3SwUgK9xnKes6nctawgv4axLg0k7qx0Qqo9U23oEli
         ZTnmas+JVz6NBRONFZFcf5tELg/qhOkCUoVPeJ0t6tRgoVlL88N/OtLEdHii3jyZsUfC
         5Xmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728452051; x=1729056851;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hxNvhDV+hfBBLMqvN8qQADvRjscGC51fwygMT1K5AVc=;
        b=bgLe7nFoX1+JloyYFBDn8iKa3lxM1/UIo1Z5exoYuO+CVkycW2v677siGpI0GkzsSA
         jxtb7lzwliN9Qv1KF0dp3Um6hB+QGz6zm4+pWu+FFeV2B+tyPPf050Pq9JXHNBMTCARK
         SbzQ+bgpmDjRgvEsy3oDBGu6E1nUSt5Y6AteqOg6XRFW1OUp2tfkg4OU+zfVhAytyJJw
         CJYnxW99pdgnXnlOoXWK4p0og1v4o5/BFA9Ut3r/+oOl38BxJPsHFjvA0gYXdBP9u/iZ
         TPIzubSBJdhwH5LUxRTOtDoAxsH4Fi0NwrsP8xioBIG7AMqBLHAGo/YzzrnrSj+UJgs5
         QAdg==
X-Gm-Message-State: AOJu0YzEScFaT4qhKiPho7OkmLmNGbKSic133GYnJaU4by0X+3nzph2c
	tvSJLA/29hFeMjSxKoveS4TiuIIQPQbka6LHGXCzvfamflULsVEaR4Q3hYm+WOCdhsXf8Yy0zDs
	cIvOogEB9oVYcBYF+ZpPBX2XxElcglw==
X-Google-Smtp-Source: AGHT+IEbhYDK6uANu9u9MtDYBLbHAhpg8w2iPxkUB43jFKni45kC4lD3X3yh93zIhrv0LA+Vo9aG+V1aSbdMwM+p+Vg=
X-Received: by 2002:a05:6402:448b:b0:5c7:2122:472 with SMTP id
 4fb4d7f45d1cf-5c91d6f6df8mr814675a12.36.1728452051027; Tue, 08 Oct 2024
 22:34:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Danny Ben Shitrit <dannyb@gmail.com>
Date: Wed, 9 Oct 2024 08:33:36 +0300
Message-ID: <CAPLTLvfUFBwYps3bGwPryPoXOVzmqadH0fRU1PbK6SRic9N2dw@mail.gmail.com>
Subject: warning: unable to unlink '<fulldir>/.git/objects/maintenance.lock':
 Text file busy
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

this occurs on all repositories when running various commands (e.g.
git pull) since 2.47.0
the file in subject does not exist

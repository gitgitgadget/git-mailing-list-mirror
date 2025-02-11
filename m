Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07CFA1EB9F4
	for <git@vger.kernel.org>; Tue, 11 Feb 2025 07:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739258979; cv=none; b=i+bMTjIERY7sCfeX7nRfhlCPwX3nCwVijC91yA4GbJLsoWJGLSmyxTOBglI3d/xH3H423oXO6CmUWn6cSlOeZ9oAn0im7z3+H6wBstThBu0MFbh+xEow9DWwEOPORwCzaE+Gj5c6X4kaCGxvIgX64yplVuTBy9O+JDZSGVxn1fE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739258979; c=relaxed/simple;
	bh=Owapk5v8Wuw1i/ZozkEfaOhzbHhG6hPRbUUQtj2DL9M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UY311CMXsUUekO1FzYYoDfjOgK8YynrgNg6a7gZkaROLbpO7xkgfHpRgMcPwBt29i+tHm+tiVkFFK4HAVcgziapAU9uj0LImKwDtIbKem433MyO/hWSaJxbO78TMU6RZZVhChVmyDHdAbf/QIcfzmkZOgPoxZM7zu74W2fq8NNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=avbLJaSZ; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="avbLJaSZ"
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e5b29779d74so4704054276.2
        for <git@vger.kernel.org>; Mon, 10 Feb 2025 23:29:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739258977; x=1739863777; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Owapk5v8Wuw1i/ZozkEfaOhzbHhG6hPRbUUQtj2DL9M=;
        b=avbLJaSZfYoIjUozOccW4Fa7mNx0OJ9VSLqJuoXLbiTwBvlbJ9nXBIfo0uTUHO7wIJ
         NpPN6kATOD7fDVmXOXru1FXEXMcBBQmCguCgmTRraAMfPDye3aODyqkccdTtSQkQbVAA
         i0Gk4q1ZkQk3rnt4sMkY/gfgmIT578sYoEJv1A6vx4CtJ7fmmBPhthH+Eflkp8/Ezy8E
         EXDdUc8olA1WwttwtWeDtXsQZOMzTh7NkX1LE9sMX0Hnm4h1c9SURh55s88Jus1Sppdr
         knSk27SYUqLvn0sQAQ9Ymm/nUG0XYOhp9vKR/ujIgtRiSssem7R5iU4fGljo7KWKbQCv
         nttw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739258977; x=1739863777;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Owapk5v8Wuw1i/ZozkEfaOhzbHhG6hPRbUUQtj2DL9M=;
        b=JOjHRt+4hdx5md0+xYQv2jbpeF8pBRICsMGbxGUTxTf/isq2K7Fr9bQCAkFoHWSoto
         yVXtlci80gG7idBsLAGvSQpPs4+Uo1UbES9sQBxOwCZ5/27lGTIzDwbTsC1NRNTGNHIs
         wtymthP3a9PYvogk6VTN7cbfJnNhQd2cvhuPvJaw+TEi921Ek5wwXYPOwK0QncSjkEuG
         /XwnFPaFl+SOdwH/t22ODy3YHiVymjwOat4f+4acYAyTmF+j7w5KXDIYNS92D/JSVVWb
         +6H5xCmdxU1ZA7WydL0c3Ao2Qh2eFImwEGXl93ltvLmLRqH0RDD731Qir0CdgRidPfas
         MJug==
X-Gm-Message-State: AOJu0YywIhdmTzsBEvpiIg8UQ2WGAufeHEeptmwDr0otX0SdjcTiaXn/
	enJb8INR/D6K0DMSFZY+mj6oLG5oGz8EjAHC7XsJea2F0xkblrFU3T50zK+GDHkaLgeVLSLfZdn
	ZHitpunOc3XOIeKvxVrBWnroATJC8Lrc/VAPZVg==
X-Gm-Gg: ASbGncus59fz8lDj6bHfv7UOHe1GbPUTbguScA0j7zNWXW7UANym1BZpKDXy3EyZmxt
	3GsHK4THNTUXyUEtzGYBqGMbX3IWH2M7EGD0KdDZ/eaAq3W3R2HcW5ku0tSAtQzhWBFb5TdmBsF
	4=
X-Google-Smtp-Source: AGHT+IHC+DBNzgad0t5KjL+S2+7BvLMFhbDyz8VkCIpqBG/lqvw9JlXPJfm19j3DJI9ogeNeyBso8YQhiG+Nkre/p0s=
X-Received: by 2002:a05:6902:170a:b0:e58:3449:3ad6 with SMTP id
 3f1490d57ef6-e5b461c2e4amr16614085276.22.1739258976648; Mon, 10 Feb 2025
 23:29:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGedMtcSSkmQ2u9yYvKMiWnprWR2VZrbuoT9EX+U6nuxOWiEHw@mail.gmail.com>
 <CAGedMtd0-m54075w97Z4pQ0wqAjgPRA8+HX5iar0POyuC6-GCA@mail.gmail.com>
 <CAGedMteK9=wYwCoPMGZ5t+FN_ZHOcSGxDenq8fkVM64oGpc4sQ@mail.gmail.com> <CAGedMtfiAttLUgPNyU9nNrvOjNrJ0NsCayjyTevCoAurwMDwzg@mail.gmail.com>
In-Reply-To: <CAGedMtfiAttLUgPNyU9nNrvOjNrJ0NsCayjyTevCoAurwMDwzg@mail.gmail.com>
From: Seyi Chamber <kuforiji98@gmail.com>
Date: Tue, 11 Feb 2025 08:29:21 +0100
X-Gm-Features: AWEUYZke2bWPAhf7ZZY2-kJx3aA4jJ12bLABgO9yAtJBVqO9slnf1u0aQdkCOWw
Message-ID: <CAGedMteB=yd4+Co2AXwaeYSC8rm2a6R75jG4+CrhUMy2Ug6bgQ@mail.gmail.com>
Subject: Re: [Outreachy] Blog: Reflecting on tests converted to Clar (second batch)
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"

Hello everyone,

I published a new blog post reflecting on the second batch of
converted test files. I would love for you to check it out and share
your thoughts!

Find the link here:
https://seyi-kuforiji-902b48.gitlab.io/posts/reflecting-on-converted-tests

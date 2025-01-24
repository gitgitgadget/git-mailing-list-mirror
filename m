Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA7C1DB159
	for <git@vger.kernel.org>; Fri, 24 Jan 2025 20:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737750815; cv=none; b=T8qs0bwUeDO7nKBONvobldbp8TcmXa7PF28iPRvPHw4Ycad6cz6Z69JqB20Z7iW5IDYyn025/e9TS+H+9qNvGZZjhAUCEb8pZGW4H/owL6M2XqtLJUUK2MTZY42wHvlb536TtxdGmpEhLnKAW4vTXUwuWSRmBBq2ANZHT9wUMqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737750815; c=relaxed/simple;
	bh=xvmv4tml/pip7hAvTR4DS/5kQ4BDR25JrX07YivBLwA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=Zyq5aTb1pL/aTF+RLKoqI1vdGi/4QBiuAqDnVpqP3+bJMAcQADFgoEPvGEMCOsTgVzkeg+6+DGBBOX99ejAknPsWJo6bDTz4iGqoF9WnjLSFe2aLiR8V3WNN278RsjxY82rz7qi7vr5478/sVt5hXzGuomYp7SrqS2iAAVO0uy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LkjRlCOv; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LkjRlCOv"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-aa6965ad2a5so37089666b.3
        for <git@vger.kernel.org>; Fri, 24 Jan 2025 12:33:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737750811; x=1738355611; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xvmv4tml/pip7hAvTR4DS/5kQ4BDR25JrX07YivBLwA=;
        b=LkjRlCOvYppZsrc0kX0vHXNtBP+DuE2sX0O/Vfd3fJRxrrT1asfcSK5UWMaTut1fpc
         5ka+wRTgSglYv2drwPIOU4Ir3Vb3jg0tZLNuWWEC+ELFe3pc/wldV6O5dw46ZO46u75W
         Qs9JTjhrA+R30PYfC1Tg3iWGf2ZffcRh5xtXQD8bXA9x8uJ08bIdbi+TrPoxuSd3U2wp
         JXOuOhYUEKbIxfGV0WngTMRKJDheq2PL9avAPH8R8v0xqa8Chf82joJ+RekoJ9h8/jfm
         gjaRkYrXhEznE7MCSZhazXflUTIk8ut9Bv4U8sP3nQ8cxDS3OZtvuYe29lRzADJ50kE0
         xAbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737750811; x=1738355611;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xvmv4tml/pip7hAvTR4DS/5kQ4BDR25JrX07YivBLwA=;
        b=t8ygL6b9+QSz9hzOxoczfceSURHLBitonKaXmb4mbXchzPfnTgTnY2fQBQMqgnDrvz
         p4Ur1/pB3x4afC7E6xm3USxaMzmaOZvEBWq1H15n76uxVkQWDCciHURfGLCXOnii9bUx
         epaeNfP6R8rz6sk7ripuQQa7iQ3l46MP0KAzotCCVbZ1jPtGUDpz+YmQGbSwHu/jyzaJ
         nMQjTYcwpJ8/CpyQw4HfBaJAn331bgQ1s2v0sspl8J4fi5+cwWm812Al+Lne9x+GgmH9
         IBHO7RPJjwUBfDOyFzsBaauwUc6YwT7TwylJVcYIVMywf5w9xTwe0uu8s/ZJP55ahlwa
         mrgA==
X-Gm-Message-State: AOJu0YxbB7c1Q0BZjWucQ/pn00lrF2MKZAKT4C93WS28j0fgXVU3mn6d
	0qYWmbgmz1PWWkNf6hbe7hjM7FrYawJ04tS9Ii6Vbvv2vsqJaHK1Z0FyqTKIYEeYJy7Jksq9Jzd
	RJ2UH4VDqlVb/gN6c+LiR36/YKreN4hUW
X-Gm-Gg: ASbGncvKM2krDD0WxqLP2ewrKVl5FKZG3zSF7pzRPRQUQpBib3QmkWHZI/ddMU29MeE
	OsZYRIlh+62N9fs2eRM4nh6ISSnZsQ0Gp8l5cICwAzWF48O2kJsmDK7cvUDD9Vo3+quhx/oOvSB
	QH6VbIeSaCqvRX9LOiT5CZ
X-Google-Smtp-Source: AGHT+IGNMH1+KXS1Ysc8dnzMhxDKGcmO3XFO+iCCaljmN9zAMFpQ/yQjt4EeiHdcbeGg/mF7h/Z78X2vIhudbA242O4=
X-Received: by 2002:a17:907:3e0a:b0:ab3:76fb:809d with SMTP id
 a640c23a62f3a-ab38b167b8dmr1063789766b.7.1737750810511; Fri, 24 Jan 2025
 12:33:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: M Hickford <mirth.hickford@gmail.com>
Date: Fri, 24 Jan 2025 20:32:52 +0000
X-Gm-Features: AWEUYZnndYfiWPNhfAj7VP2Ej6isDop1Mk9oJDoV81ckTu-JvDvJnocoBP83ZvU
Message-ID: <CAGJzqs=MSc3VS0HO4OwXgBFJ+zBpj-CxKkLnsqbqVdnuEu_0Xg@mail.gmail.com>
Subject: Authtype capability for git-credential-osxkeychain,
 git-credential-libsecret and git-credential-wincred
To: Git Mailing List <git@vger.kernel.org>
Cc: ilford@gmail.com, "brian m. carlson" <sandals@crustytoothpaste.net>, 
	Bo Anderson <mail@boanderson.me>, koji.nakamaru@gree.net
Content-Type: text/plain; charset="UTF-8"

Hi. Does anyone have the expertise and inclination to add authtype
capability to credential helpers git-credential-osxkeychain,
git-credential-libsecret and git-credential-wincred? Currently only
git-credential-cache has this capability.

This would be useful for users storing bearer credentials (perhaps
generated by another helper), for example.

Specifically, the helpers should store and retrieve the
(non-confidential) authtype and (confidential) credential attributes.
This can be verified with test t0303-credential-external.sh (after
adding helper_test_authtype).

This might be suitable for a #leftoverbits microproject.

Thanks for reading

https://github.com/git/git/blob/master/t/lib-credential.sh
https://github.com/git/git/blob/master/t/t0303-credential-external.sh
https://github.com/git/git/blob/master/builtin/credential-cache.c
https://github.com/git/git/blob/master/contrib/credential/wincred/git-credential-wincred.c
https://github.com/git/git/blob/master/contrib/credential/osxkeychain/git-credential-osxkeychain.c
https://github.com/git/git/blob/master/contrib/credential/libsecret/git-credential-libsecret.c
https://git.github.io/General-Microproject-Information/

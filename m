Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5516B1D7E37
	for <git@vger.kernel.org>; Fri, 13 Sep 2024 09:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726221565; cv=none; b=VHD7okGWdGrygLIzxTJeIiNnTXxSZJ0K92/O5BNc34Xy0sdXfGILPfTWhK9kvjv9hpUOJBPOeU2L5LIuzWPxK/IaRK/do5zswPUxXPo+c3B/Rd/P9Joiu0TKKIPKAOSImxAVGc8MbSZT1fWtHvG57DWT1fLSJ6wpO5UkviSxR0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726221565; c=relaxed/simple;
	bh=d2zTCu20X03wts7s/2u5PHCLkOtN1epg/SiiFdLiss4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=AL7E7QnnAC2BVT+0fc8wW2EcDCsXJZ5JFKCx6sSAaXCWrUwthUzc2T/YdoqOGSbxFNtKR6UkJoPdlb3CCeTPayWNLPXWPYWPSNT4LQSuTww/YJDPaWHxPU1WaJd6SI5GcrGCi3AtDx3bOhLlTdUrw6lNh5obaQWG1cQBkIQtjcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xs0MkhGv; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xs0MkhGv"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a8d56155f51so231689166b.2
        for <git@vger.kernel.org>; Fri, 13 Sep 2024 02:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726221562; x=1726826362; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=d2zTCu20X03wts7s/2u5PHCLkOtN1epg/SiiFdLiss4=;
        b=Xs0MkhGvtj80UcZP2D2l4VQ3pjszVjk9NWRawmpivnnTs0J1VRKG8gSFfi99pbQqoe
         ZUPERHYdh+k3m+T6VoGehl3zbuuN5zNhxOrpFNJyBJellKYTVl9EigzPgDcW9eOhfjuM
         33ELEtsMmf0lh2s8UD5J/r2cYOe9YQiYpL5OZV5cBa9mUWsU+WRBzf/atzdwAebZ7Xe5
         54PGMIvt5kBQ8vK/tJAGKsngkZrY/cJ/JZ6nsFaQkP2RQoduBAk0mgqi69pNtlvN3VQf
         IulTzf7J5ZPnTlufEWABNHnTsBThaxVBTiF10UztyVxhV5YGfZ6IIsMYvG10CwYRli+k
         wD5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726221562; x=1726826362;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d2zTCu20X03wts7s/2u5PHCLkOtN1epg/SiiFdLiss4=;
        b=XJewaZyTx1yYfOIbT3h2LLcKd3fuz/t2yaVtKHnMvgUrtF6MnWDAgpeXySGKilEY1P
         ltz7CqBJUCFCpjtNSBlkKjy99Mnk+4+yOSdxDpNHBaqIFB7tR3+o27xrnpweUl66zxWN
         asMg3RVvaQU/DGlS//1xWnIAg9dm953AW5MDzDDDqy5wkonThMKos1bjLJTqvm32YME2
         KDKDZVAyCDu6Z/KWMol6uJrFhMSWi4aDQLzGQWbgVGS2Sx+cEmJsks4BFiuM1BfClAYl
         YcW1vPoaGs1xZ6y+f+VYnB8e68NvjySxGnD5NrhPxWjP/+v90UZQmRMz3TcD8Zk/ztQb
         jdZg==
X-Gm-Message-State: AOJu0YwkBbPQoJ1Xg0qi6tdYTBbmQBAZCJPDvlE3QotzKRFSadd7bt/a
	J6HaRvj/x5bYcUch801ucaegPC6BO5QxE+uD9Jd3emdQcxBTK2J1tqMbELbQi3JhFatHTyPz+zc
	WlcEs+1gDoQVEEOo25Q7QrllcGSBNWmg=
X-Google-Smtp-Source: AGHT+IHqovjS1QyHGn1iTPZ0XlMLGFSazjUfypr2nSzHSTgHkJprTTJOKrGXPZAeNLO4i/2taG1fhVg6ZwYVYsSHP+A=
X-Received: by 2002:a17:907:f1c5:b0:a8d:2faf:d343 with SMTP id
 a640c23a62f3a-a9029496f92mr488466866b.27.1726221562015; Fri, 13 Sep 2024
 02:59:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Justin Su <injustsu@gmail.com>
Date: Fri, 13 Sep 2024 05:58:45 -0400
Message-ID: <CAB=S_8JhN=WSuYRMWbGz7gZMRX9dSb3k8rJZ7zrxkbHKOqfzww@mail.gmail.com>
Subject: Commit signing with SSH key uses SSH_AUTH_SOCK but ignores IdentityAgent
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

I use Secretive (https://github.com/maxgoedjen/secretive) to store my
SSH keys on macOS. I've configured my ssh_config to use it as the
IdentityAgent, and Git can push and pull just fine.

However, it seems that Git ignores IdentityAgent when signing commits,
resulting in the following error message:

error: No private key found for public key "foo.pub"?
fatal: failed to write commit object

I've worked around this by setting SSH_AUTH_SOCK, but this doesn't
feel correct to me. Is this intended behaviour?

Thanks,
Justin

Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E50421E1A32
	for <git@vger.kernel.org>; Tue,  1 Apr 2025 20:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743539949; cv=none; b=N84IrjeaeQIIsv5N6iykGzPJ05Pr7R8C1tPdx8HxQ2hJE37j6C2m0v9PECdLIC7kFh+6/wdH9dLR68Ij/Vy9wZtBN9E9SmMqFwh231L4KxF8pYjMNUWYWEcAkGjz7FsF69vvk8fNUCTRQN8UdqIoRJdIL13Uns8RnQapeyb0zdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743539949; c=relaxed/simple;
	bh=gEqfXzKZU9DGkAzqM6R+MkXiV6w3youQIl43NgteU5I=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=sXAd2ESU6yMIOp3uFPNE6kmI5HDxIaVZxJpUgb9WoJYbgEtJQ1Sdo4MLjX+zO+Abv+Ey5zAmP07VzEsMt9RwqquLHjEb1ESQ8NT/EHKWMWe6Ys0mk7A7wA0fxWQ8F4dwwhxOGc5FniGz26xG60pVE2vPXcrrzIwIoozeWL9QtFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KQ0BT3gf; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KQ0BT3gf"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ac2902f7c2aso1036309166b.1
        for <git@vger.kernel.org>; Tue, 01 Apr 2025 13:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743539945; x=1744144745; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jc6r/Ph3x3xq3bTKyzfKKOODVgyzB+r7qj8zog9Ih+c=;
        b=KQ0BT3gf59mstIAHZt9YbQ+7wT6lK79t8hzi2znop9gJpK0QEgfn47mQi3Whh4gFc+
         rYyHDRychYyJhzPaG2zVjHvCKTgOWXATqkFdIoP0LBmZYb1UgbtDmlzJBab7azuCJpKI
         CvfFKrcLDn2+qZMZr+tBmj24AZwiLPxCaVwWJmWRe8R4H7wqTSEcvPUhdDHkltWrZnUc
         5/q82jnDVz4/dS6IZ8+PwPXmkelgw6cd64vpwTNJBwzKgAWZYwBOpe2sqh7ZZstVgCey
         xm8hjE++i5hrwWzP+Bo69OX2fh0FqHgR9zd4IrVL7vf8Vqt4laTFx103nQoIlFIh/6Bz
         kmNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743539945; x=1744144745;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jc6r/Ph3x3xq3bTKyzfKKOODVgyzB+r7qj8zog9Ih+c=;
        b=ViZXKfrhMiWy2ZTFA/zt6qnRKueng8rQwZM3IImo867R31toKNaq5M+2GRhvnNKAIt
         iqfxtmBjVgVuxIUVLtvVW9q3M5NSZ+ABIUvRCXVygCkmQQCgY7hK3bt0qiOqWnhESgab
         VK+fxyrC77Fg6KCjl3dYkY8iwNjs0xD9P3L/Rea/s2KGggpPDyNeJI3gX0iX5tfvjrTb
         VJnZovfL2UgfZlqmVpjWkbtip18Vq3ephlZPQrQinT6NjeH6HmINF6TraLt7lgHliN+/
         lbiNR3mXUgMoDcfw4T33H2O/lihtICqAOnHZTims39YTltQTAgfCzg2sWlX+n9c5SObV
         6rGw==
X-Gm-Message-State: AOJu0Ywv+hQDNHDVLDF7gZIyQNqv0D8K5q8OyPX+wxE/9fwXJeqW6hhT
	eKg7nQKMGJ+OZmh3r1ePI2J+jAsJkzCKHpAu9nOA/yHb0chgr7encvn3Zb4+ZwNJjcyxxPuczuU
	ey1id+gku67KMAlwlzry3C1UxS5Uju70O
X-Gm-Gg: ASbGnctAyC78bN1JPe80Ld1Gxko4IneWmUAAhFVDZHgdbW10eh37cW92ZSiNyh4x2Dz
	In4x9SzyrJ04KWDKcS1x0Qzk/bLcBWNMRZrfWPzcoltDqavaXk/vtGc308g9pOoWPVZF7KwWWRg
	NK3m9g9PjuVQPMF7N+Lnq3JgXbdwuU
X-Google-Smtp-Source: AGHT+IGggkuLGvqP4J84yQlsUSgEZ2EZMlSggbF6467GDcGbl7yOs/7tNDTHHAxe2JU2D3ikj0mhX7saPv6O7qRemtQ=
X-Received: by 2002:a17:907:608d:b0:ac3:3cff:268 with SMTP id
 a640c23a62f3a-ac738a8c4camr1281187766b.30.1743539944840; Tue, 01 Apr 2025
 13:39:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Christian Couder <christian.couder@gmail.com>
Date: Tue, 1 Apr 2025 22:38:52 +0200
X-Gm-Features: AQ5f1JoPR9tM3LEIYlzQL48GrzQ67Qs2afkx672rIqMsJzsc0W89BbgdGCGxWkU
Message-ID: <CAP8UFD0FcsTm70vDrvvOzDuQDEp-N3Sp1PFkP6kLrvxX2XJyXA@mail.gmail.com>
Subject: [ANNOUNCE] Git Rev News edition 121
To: git <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jakub Narebski <jnareb@gmail.com>, 
	Markus Jansen <mja@jansen-preisler.de>, Kaartic Sivaraam <kaartic.sivaraam@gmail.com>, 
	=?UTF-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepnem@gmail.com>, 
	Taylor Blau <me@ttaylorr.com>, Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>, 
	Eric Sunshine <sunshine@sunshineco.com>, Elijah Newren <newren@gmail.com>, 
	Bruno Brito <bruno@git-tower.com>, Luca Milanesio <luca.milanesio@gmail.com>, 
	Philip Oakley <philipoakley@iee.org>, Andrew Ardill <andrew.ardill@gmail.com>, 
	David Pursehouse <dpursehouse@collab.net>, Jeff King <peff@peff.net>, 
	Matthieu Moy <git@matthieu-moy.fr>, Lars Schneider <larsxschneider@gmail.com>, 
	Thomas Ferris Nicolaisen <tfnico@gmail.com>, Gabriel Alcaras <gabriel.alcaras@telecom-paristech.fr>, 
	Nicola Paolucci <durden@gmail.com>, David Aguilar <davvid@gmail.com>, 
	Mirth Hickford <mirth.hickford@gmail.com>, Seyi Chamber <kuforiji98@gmail.com>, 
	Usman Akinyemi <usmanakinyemi202@gmail.com>, Peter Krefting <peter@softwolves.pp.se>, lwn@lwn.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi everyone,

The 121st edition of Git Rev News is now published:

  https://git.github.io/rev_news/2025/03/31/edition-121/

Thanks a lot to Peter Krefting, Bruno Brito, Daniele Sassoli, Toon
Claes and =C5=A0t=C4=9Bp=C3=A1n N=C4=9Bmec who helped this month!

Enjoy,
Christian, Jakub, Markus and Kaartic.

PS: An issue for the next edition is already opened and contributions
are welcome:

  https://github.com/git/git.github.io/issues/767

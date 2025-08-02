Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC7A18786A
	for <git@vger.kernel.org>; Sat,  2 Aug 2025 20:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754166250; cv=none; b=aPWuUGLbL3StM7XJI/A3t7tf+zkr+lRPTZZtv7qWwGG5sz1p6tu+j1UBpAw8KInY2ssRwPC68tl0LWWDOuveNElkXvI63FKGo1v3L4ufcRBV5acJ8Sk6qPAi7aflOX8RFjlsnEUi6cbHS2lDXo6qIGlPm7tz8faYQY+cN7E/Ucs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754166250; c=relaxed/simple;
	bh=Zr9TrO0BRKzztr+Zq6spYZFhC1AVJ+Ub20srXptvdxM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=hy+tgV7WJxQaM0PaFgZuTd+tXUNXmsI6mnQm3VabjobBGbXOAT5RhiCFGAsCUFthT6ddkhculyFAaO6reLEQP2x8MvP9qleNyaJk6c5WoEQYl546lQ2b0c83VA3HVqwumPEvWvm4ZluAlFFdmRApkvxLmePbKY06GkoPKlMyCSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FNJdYt93; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FNJdYt93"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-615398dc162so5496009a12.3
        for <git@vger.kernel.org>; Sat, 02 Aug 2025 13:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754166246; x=1754771046; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/cqDBh5DWK58aYOyxqzIgqgR5c5eKOfmxpWYMV+SPJA=;
        b=FNJdYt93Co/1XFyr6lHXQgPk4v70oEL2duLDGtRKRM20Cxz/zO7hnk/j70Y48stWdd
         OP0HxJaHJg1/L6W8ZGC8H8s1mlWGu/VhEiQqX1NE2h93k8cu1y01bKBuNNar91/lWzeI
         g5t1jhNhX7Qg9EdWJv+MJNBQ8J9rPtb0enrRsJkO1CQVCUi/Om7z5FUrhrvIIBkn+vTQ
         P9F45lBr7CYoKklnQsGNeYGGAX+PiIM2+KzfmnHPukAMl02dHOTWaMVUE6oULfeh86xT
         HKTSmgzZ5MzynqnagIjsiMriNxz3lX33DknavWtmgnzHsckKhXtK2nLpxYrOlFq9swA/
         sg4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754166246; x=1754771046;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/cqDBh5DWK58aYOyxqzIgqgR5c5eKOfmxpWYMV+SPJA=;
        b=HvJKa2Qbbsdia6KoRNxBHXr7UF6CqVzxgIcDy9CBrKCCxLEjyk3P5nq33NLGU+LNbH
         7/w/h7wCn4nwUgpWNRgnUaJikEwYCszbfpYtRtRH4OQ6rbJO3ZLEVPQ3GZN33KNBZ850
         ZE+U4UV3IlzCjt1sAW8vH3J9Wr8fL89T7Hj1cCOvBDhkQXw4162JNifCNOosD9xUEL9w
         Zh4JCsBfMF4vV5FToEjvjx7CdumZIWVznnHSlmAInbLP+QjmkowBJgH1XXDQftuqfUh9
         nOltg8FOeVid+LZl6KiwyPwEWM9w6htN+In1OEmxE0rUpdUueMFCaO0S98RL5iWtnjuU
         2tBg==
X-Gm-Message-State: AOJu0YwLvYWwNtwlVUhvGIk7UXEAJoCoYPIW/H3XsurR90yVYhPZAJol
	CbygvveJAg3W4aDYy7jQrhuclIdAc35OEawC7pVIwHO2oyQZsaL4K+3D/oUh3FO2aez/u/XOZ4j
	dweRlZ+CdUPCmr1MdX0AiHuqT9UlBStL2ON6J
X-Gm-Gg: ASbGnctfkeMnh5yi+tUuced64P5QNEAkktBAF+NOMp1qx5q2OkUTZ8iPfSlWaeQed5S
	IuRJREzHudQspgHdp8Mu+a0egfEeuZtvasQnYWJNw/vlbvi76yzkptGjNYCgB7e5HsTRKmYAJ6a
	XDONfMNkwN6lJ+iVrCBx9Eg7brJw584ZrUa0qr5+vcXWjGByixHl4Yc1TkkpZAWSaInmnXTv0Qs
	30gGmk6JQ==
X-Google-Smtp-Source: AGHT+IGyCTjg166wzDNBLdWSJ6AMQLdjj7Ey3CkXf6RjgD/G1Ztsz3HGy7TIL+IrjcbkQkXkeQZip7Fpc/mHHJcCdnk=
X-Received: by 2002:a17:907:7247:b0:aec:64bf:a393 with SMTP id
 a640c23a62f3a-af94016a052mr439461566b.38.1754166245794; Sat, 02 Aug 2025
 13:24:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Christian Couder <christian.couder@gmail.com>
Date: Sat, 2 Aug 2025 22:23:53 +0200
X-Gm-Features: Ac12FXwjQA3iqu7knwLhIzPhSyf4XwJHtk_ja4SKShgHN7WHJdPZL6tfk42Y8UY
Message-ID: <CAP8UFD29T-BWhp7teeoUTmujoAWK_muj1JUqP9JaayiSaFCMsg@mail.gmail.com>
Subject: [ANNOUNCE] Git Rev News edition 125
To: git <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jakub Narebski <jnareb@gmail.com>, 
	Markus Jansen <mja@jansen-preisler.de>, Kaartic Sivaraam <kaartic.sivaraam@gmail.com>, 
	=?UTF-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepnem@gmail.com>, 
	Taylor Blau <me@ttaylorr.com>, Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>, 
	Bruno Brito <bruno@git-tower.com>, Aditya Garg <gargaditya08@live.com>, 
	Julian Swagemakers <julian@swagemakers.org>, M Hickford <mirth.hickford@gmail.com>, 
	"brian m. carlson" <sandals@crustytoothpaste.net>, Erik Huelsmann <ehuels@gmail.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Yao Zi <ziyao@disroot.org>, 
	Eric Sunshine <sunshine@sunshineco.com>, Patrick Steinhardt <ps@pks.im>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Usman Akinyemi <usmanakinyemi202@gmail.com>, lwn@lwn.net, 
	"Erik-B. Ernst" <erik.ernst@sic.software>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi everyone,

The 125th edition of Git Rev News is now published:

  https://git.github.io/rev_news/2025/07/31/edition-125/

Thanks a lot to Usman Akinyemi, brian m. carlson, Aditya Garg, Erik-B.
Ernst, Bruno Brito and =C5=A0t=C4=9Bp=C3=A1n N=C4=9Bmec who helped this mon=
th!

Enjoy,
Christian, Jakub, Markus and Kaartic.

PS: An issue for the next edition is already opened and contributions
are welcome:

  https://github.com/git/git.github.io/issues/793

Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BFF020DF1
	for <git@vger.kernel.org>; Thu,  1 Feb 2024 20:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706819638; cv=none; b=bVxAwZ1TYK9sFjoGy1ftryBtHSCrKXjDyViAU7iF0IzUS6sKg3j+01RguuMMprYasIFZxv64jodO9ul34NyRdimG0E1pSMuegznWiH3Cwo3s8FokQo8/9xbmlrfZWvTnLUTjD6GshYDRyAkWK86hKo07yU8rnUtUmmQmvBEmAmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706819638; c=relaxed/simple;
	bh=5JuyI+4RBtrpfSbEeKIrOw+Amun+MejOmpJB36JiO3U=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=W/bw3CvkOyAEn4AHkTu2bRI9DWeEKzM+xwfqnGY/QJ2xQRa6hgoyMLvHO0sn+e73Rit8BDZcNI2T7T5bfGkLCbsaxhPet0Uszk5Bn4OCqRXdIkDdRvAOFkb8xUqqdWM3r810S8d9UajysMmMX3EO4ip4CzUYOJoDzGwuDLqg6E0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P4sBOLLg; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P4sBOLLg"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a364b5c5c19so234243266b.1
        for <git@vger.kernel.org>; Thu, 01 Feb 2024 12:33:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706819634; x=1707424434; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uqppc3LjeT7e5CLeSVyPMNsNPgs19VQFJwTuXeCHUoU=;
        b=P4sBOLLgcSC1ZzL8xgZSHTwFmaunvl2b7UyryP2TflqKU6JUNsKjtf8olGRaCsxSrE
         tEh6xSV2EmGPFVTf5GElUFmCezVo9cOl5m/B1l49U1e7Uq+jzQawFcVOd8fC8j3SSycY
         VtfIZZVzW2EXTQGGLwdRcNPMflw8f3uZLmULe4DBmw45w8Wc+oJcFHQVZFub+P8kNG+Y
         Fv0N5R0SP9iO4mGYwkYg967Gaj0yuwkFjgZljMW7JvHWYhV5WLHLuMuYZSVtUuVlKu68
         Wcwu//LfaiXkq2h7h1mApMd8y1o9FiMatxmGjSsWognwq9NFBESExLAlGpvahBwvsAWT
         UyeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706819634; x=1707424434;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uqppc3LjeT7e5CLeSVyPMNsNPgs19VQFJwTuXeCHUoU=;
        b=fUvPhuORCMvEbRYztzV5oOb+hg6n6f4JvonK6h4ybWz7I40i/YlrOmwCnnL8DBTQ/q
         HQ57ZRz24+A6tsEdquSDWPmz6GF5oFGbguRF9Kesgj2tdacNkG34aHW0jIGQla1vuq4J
         oAP8WnzNG6eVN0gb/tt1N1dhQ6a8eWa0hJD4mZ/m35jwb/IIoVyGVklT2fqMTo6bflHo
         O2APLX9+wXLHCQSGFym0uy0qiRRnlZwT+JFgyX/3RvXSKlJESGJLJtJZ6E6MoOkq2R49
         9wpbKeij46vXoGmWPSeUer7lWBNBZr+vfiTMJmnUwQAy5l1birVPOck1VKChBfMxv72i
         5Aeg==
X-Gm-Message-State: AOJu0YxzZMcTvBr59SlFOWj1odoYVqWajAC8MULyKwA6f/ZL34vJx5hM
	sMH5OF9Xk5lV07AmnvbQaq3Pjs6KE2+TtWmWx2Ul3bDhwm5+RAba53u2gIS/vZe6Ed7VvHq25IR
	cVc1nRzlEvwCHoN3EJvwAzeF9vSv4cxwiLLQ=
X-Google-Smtp-Source: AGHT+IG7YAvIIHvGLpEBKZmVbQUIA1PMvFSAfzh28+S6CpDoxgrGp6a+HrqhR7fy0U8a2x2wouneCQNndBUK6IAeBWQ=
X-Received: by 2002:a17:906:e53:b0:a36:70d0:6ad6 with SMTP id
 q19-20020a1709060e5300b00a3670d06ad6mr4383389eji.24.1706819634407; Thu, 01
 Feb 2024 12:33:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Christian Couder <christian.couder@gmail.com>
Date: Thu, 1 Feb 2024 21:33:42 +0100
Message-ID: <CAP8UFD3pMKHSuLFn0z2Nhm056WdArGww8Q3Gx921y0TTsVvy_w@mail.gmail.com>
Subject: [ANNOUNCE] Git Rev News edition 107
To: git <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jakub Narebski <jnareb@gmail.com>, 
	Markus Jansen <mja@jansen-preisler.de>, =?UTF-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepnem@gmail.com>, 
	Kaartic Sivaraam <kaartic.sivaraam@gmail.com>, Taylor Blau <me@ttaylorr.com>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>, 
	lwn@lwn.net, Bruno Brito <bruno@git-tower.com>, Elijah Newren <newren@gmail.com>, 
	Brandon Pugh <bp@brandonpugh.com>, Jeremy Pridmore <jpridmore@rdt.co.uk>, 
	Philip Oakley <philipoakley@iee.email>, John Cai <johncai86@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi everyone,

The 107th edition of Git Rev News is now published:

  https://git.github.io/rev_news/2024/01/31/edition-107/

Thanks a lot to Elijah Newren, Bruno Brito, Brandon Pugh and =C5=A0t=C4=9Bp=
=C3=A1n
N=C4=9Bmec who helped this month!

Enjoy,
Christian, Jakub, Markus and Kaartic.

PS: An issue for the next edition is already opened and contributions
are welcome:

  https://github.com/git/git.github.io/issues/686

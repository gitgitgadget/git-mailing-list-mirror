Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63520535D4
	for <git@vger.kernel.org>; Mon,  1 Jul 2024 12:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719836404; cv=none; b=oD9gUMSZ5nJwKklYCFuhUGYRFzgzUQb/sJFCVjOqIA6JT+Ka42v/EVPekxjRm01xoV+GAuuBR8YmpzHELpB8UpFFhBtpVa+d2jdod0woXSxU2lY/yiEIuUnujJ9PRcrlLlqPjEzsDY+mQZV6DXXMSVUrqGBGMQSDMUTspuCI8sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719836404; c=relaxed/simple;
	bh=bbJTzdr6ip+dtn0S85r3kHy+6jE3TyD7RfUkQehPdOM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=eRw+217N1TNDW2i/a8sB/YlClOb2KVen1aZGNFAywhrGGlwgujTJbPq1JmTMJEk3NqFWtZfsLxrTwIESUTxyxTMbw1u9S0w8ZMLunvZNt2zCU6D0DU5xpaglkHutvpoNXQGuDOEe6iwLvse8xqNmxsjzaiN3kXUSNZ5q5oFNNfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K7XIhHwd; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K7XIhHwd"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-585e774fd3dso262300a12.0
        for <git@vger.kernel.org>; Mon, 01 Jul 2024 05:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719836401; x=1720441201; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fWpocJGAPETV0GS5i2+AY6LPnI6WjCwfjbc7GQR65Ic=;
        b=K7XIhHwdhm7DTS+L8Wdq+GHLuX6I+AneQ/XSve+W94JeKjFSdne8uqAmKwbxw/SG+N
         9HLaTlG3e5ZD7bmslQdGVBoiPhNLxAdH1OufqNwOG+hUv4lAL4Dm7JPBc4FDJRivIF4o
         GpfWe2YEks6n7e+JdLL5n/GJT+DlbxWSDfrtfT8g4/UOmdpjGnOrZxsCpz5Z8+ak1meC
         unh6WO5GYDrLVEaAjNexsNPay2AZbMEkPY2RNpcZKN6uGDmvLtqxF4+42XHwEtOXFhfS
         nxS/0/mCz4ZrHn4taG+CuZy/O8PMPCwK5N6dvwjY1HumsGIwnMTzXTzwH78ipVY/bFjK
         Vb1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719836401; x=1720441201;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fWpocJGAPETV0GS5i2+AY6LPnI6WjCwfjbc7GQR65Ic=;
        b=rfPAi9ns8NFKODSImOdKmCrrcqKrMSHkBLvCZxdNRWDqDYz0x1y6F1MLA1U8V+FyBx
         dOLLAhWt0vVI8u4on0xGohq3M8hFDKSfx+Qc51ItKwdpt9Q7jlh+RvNRzxrv+L9IEEaY
         WGCbynMUygW51hn4DlNiqpsutqmExkUqI02A6j5J52bm0t3roh/HJlZjRB0WL1OYXMtZ
         /8lAS9m9o4esAhO/3qhQdqRrUMBZYUVXmGPhTjXmxaoVbLlTvIA6ommeRQdG9uJGlKOC
         ub0qrtbIOziIBWKFzDl+SWKuuohsQVPcEZ3qylpSq+Ip+sakiG1lT0Evm3BLl3kyOCVa
         Xw4A==
X-Gm-Message-State: AOJu0Yz7dkVPfiH6kYn+BnPVUXgL+IT5piyfImw3LwzyM/U2P4aYjsbs
	CPc/K2BT2dXwE9UbPe3zOJOD1DesT8c98aivAcIBe0vSpYceQRwpeDNggss9RwR39/2PkoqmSgf
	aCEX9irx2keYgVotFCOj8wZCuZsuYqtyab10=
X-Google-Smtp-Source: AGHT+IEuI8j5rkzcK501jkF3ivajCTB7PLPcJwhq2OQacM9cWHFg8yNco/XnDchlNsX2DP7Ozi2bJV4F6N/J+UMgxJQ=
X-Received: by 2002:a17:906:5851:b0:a72:6b08:ab1a with SMTP id
 a640c23a62f3a-a75144545f4mr321436166b.46.1719836400561; Mon, 01 Jul 2024
 05:20:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Christian Couder <christian.couder@gmail.com>
Date: Mon, 1 Jul 2024 14:19:48 +0200
Message-ID: <CAP8UFD3v2o=3wg+1g=4pt6bpeKWT3T7z1z8DX6hyuiBnEKQdPw@mail.gmail.com>
Subject: [ANNOUNCE] Git Rev News edition 112
To: git <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jakub Narebski <jnareb@gmail.com>, 
	Markus Jansen <mja@jansen-preisler.de>, Kaartic Sivaraam <kaartic.sivaraam@gmail.com>, 
	=?UTF-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepnem@gmail.com>, 
	Taylor Blau <me@ttaylorr.com>, Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>, 
	Patrick Steinhardt <ps@pks.im>, Todd Zullinger <tmz@pobox.com>, Dragan Simic <dsimic@manjaro.org>, 
	Justin Tobler <jltobler@gmail.com>, Karthik Nayak <karthik.188@gmail.com>, 
	Phillip Wood <phillip.wood123@gmail.com>, Bruno Brito <bruno@git-tower.com>, 
	David Aguilar <davvid@gmail.com>, Brandon Pugh <bp@brandonpugh.com>, lwn@lwn.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi everyone,

The 112th edition of Git Rev News is now published:

  https://git.github.io/rev_news/2024/06/30/edition-112/

Thanks a lot to =C5=A0t=C4=9Bp=C3=A1n N=C4=9Bmec, Bruno Brito, David Aguila=
r, Brandon Pugh
and Dragan Simic who helped this month!

Enjoy,
Christian, Jakub, Markus and Kaartic.

PS: An issue for the next edition is already opened and contributions
are welcome:

  https://github.com/git/git.github.io/issues/721

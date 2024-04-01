Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 237CF3D9E
	for <git@vger.kernel.org>; Mon,  1 Apr 2024 20:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712002349; cv=none; b=ebkmtdxyY3y+ZXXcTPP61+SLZfO2nwOlBzFwukHoLWnQUwNWtVu17sDTKkwsDprSI0glgG+6+ojx7woBF0HHQphIg6PA83+eBeoGUISfSVXs2qW7NVW+LMhUHKw+JA9glsspIffIll4irjdG60Oj1Ewr6Kz4gXUrmEIcQixo4v8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712002349; c=relaxed/simple;
	bh=wOWr66RB8mV9EF2bTkq+GHrmRRX+LP5V7m2DovnmElY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=uPA+cMPEuAKozsqMjkub6Lq2zR910+fxuGPERgYVU4aVDn5u/F3X4XkadoNXfziMRLQblc9ThAp+cfk+a7WfQdgEHXhUiCrLeuoh4DsB4vvO9E1TJvs5tXntNbQ5olVVGEY7SKau38vTJlukA+xQsTwHTeaATBwzjelupSpq5CQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I9qLOeuF; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I9qLOeuF"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-56d5d4d2e2bso2359194a12.3
        for <git@vger.kernel.org>; Mon, 01 Apr 2024 13:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712002346; x=1712607146; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xPYR0xcU4DOoiifAiNLCNHYsT8uTNevOzs2cuOr4FB0=;
        b=I9qLOeuF8C8g+GB+HLJvlnlijSxPzI9Zsf86+cLeFEywCyMduF71Bwj/hB3wsfjBc2
         8/5ALw5SYyEVWcg7Q7ucDgonnvuh4UOHnmUvdiZL8H+ud8CpesRO2An36/jC93WsGwvS
         xUMnsRgQ2hVM2I3DQKcFhpFQNHdzZ3MfiWUWtj9h6EAvn5BLRNjT/pmdeDaHY+i7eu0g
         dP3H/b75qf18FaeLFuZQ15uS8VL4HorQf1Do/7OQKWxj9u3Rry+Y8eXMn9L+nBOer/8r
         dyv9hPljxk6qwDb4kMBwS8Pdhz/+//0rCTae0xZePY1Jt4HMWFx8gB294bc1v5PIPP7f
         kfIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712002346; x=1712607146;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xPYR0xcU4DOoiifAiNLCNHYsT8uTNevOzs2cuOr4FB0=;
        b=cVe0+PoL4LyNEsRVJXpWchAC0PVyiT5Xpf1moe0aKtF9DJUq3z2++li/xtEMoMlw9U
         +06fF5qThBu8/wlB4OBkNuTZK4X5ua6R5QqbXGV9og1TjC40QDjz5Sx+bW5534UTX17O
         fGfltE1av/4Mlnr93g3Zp6YRU2bVDHcm/Ffn1Z+3GRez/2nqXPPOdXbQbCrcDQwX9KYB
         BWGCi2o1rawPldS8nF+9oRwSN/TGp0DaFMGqbGEgD5KFn2QAsFIsuFM6rH2kYJ5CZLub
         z42a6pLnEjxdPVPZFR1g5o1p+VRGOCJhSG5+MCFROf7SfeQrAEC6mUXGKmfWlXvwVY5l
         rDQA==
X-Gm-Message-State: AOJu0YxHolboB/MexTJHK9Oe5MH1gDeN/kdQUyfvu65bkuxyIDL5gecr
	tpY1VxYbQ3q2jiDOZ/ZCDpGfqCjCGzmOpmlVliihMM3yYV4di9vkgXbnb/VHFnKoMNBSZbNHySq
	FfOUJsUhVOxg+gKvdORSl+HfwKcSe5Db+4TdRkA==
X-Google-Smtp-Source: AGHT+IE/8WUM3cw8vQ2eIwX+QKP1BxVWyJypxmNVY/j5wuLFE4H+58adJJh7oPcks9ib1VGZ5GzM5TnzWiOCrJ43Njk=
X-Received: by 2002:a50:d6d5:0:b0:567:6a67:664e with SMTP id
 l21-20020a50d6d5000000b005676a67664emr6195547edj.34.1712002345568; Mon, 01
 Apr 2024 13:12:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Christian Couder <christian.couder@gmail.com>
Date: Mon, 1 Apr 2024 22:12:14 +0200
Message-ID: <CAP8UFD2M1jXBh5Qqdyo48-N=nm2unqf=w7cN17NAX_Pc5z_qZQ@mail.gmail.com>
Subject: [ANNOUNCE] Git Rev News edition 109
To: git <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jakub Narebski <jnareb@gmail.com>, 
	Markus Jansen <mja@jansen-preisler.de>, Kaartic Sivaraam <kaartic.sivaraam@gmail.com>, 
	=?UTF-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepnem@gmail.com>, 
	Taylor Blau <me@ttaylorr.com>, Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>, 
	Bruno Brito <bruno@git-tower.com>, Harmen Stoppels <me@harmenstoppels.nl>, 
	=?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>, 
	=?UTF-8?Q?Jean=2DNo=C3=ABl_AVILA?= <jn.avila@free.fr>, 
	Kristoffer Haugsbakk <code@khaugsbakk.name>, Patrick Steinhardt <ps@pks.im>, Linus Arver <linusa@google.com>, lwn@lwn.net, 
	Ghanshyam Thakkar <shyamthakkar001@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi everyone,

The 109th edition of Git Rev News is now published:

  https://git.github.io/rev_news/2024/03/31/edition-109/

Thanks a lot to Linus Arver, Eric Sunshine, Ghanshyam Thakkar,
Kristoffer Haugsbakk, =C5=A0t=C4=9Bp=C3=A1n N=C4=9Bmec, Junio Hamano and Br=
uno Brito who
helped this month!

Enjoy,
Christian, Jakub, Markus and Kaartic.

PS: An issue for the next edition is already opened and contributions
are welcome:

  https://github.com/git/git.github.io/issues/705

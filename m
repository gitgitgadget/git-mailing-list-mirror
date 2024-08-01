Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E933131BAF
	for <git@vger.kernel.org>; Thu,  1 Aug 2024 16:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722528029; cv=none; b=D17y9AXocJUnWT+m+3EjH7VY0k6ZKbCNQpJLa3BfNVsENlpSNVCZJl9Z4nswDHp6v+KnAuUmQ0dC+DeLBj+L74N+SW3lc2OTuvXpjtlHgkoiJiQlOsZeWZdMpTuE+UkIVE/HmjzCg2dP4jbRH5fvozx/tcjl/S5fw1OV+tb0lCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722528029; c=relaxed/simple;
	bh=qh74b5Lbvr+GoG6g0dkG+foZ3QyPq2HEY8DLsrXQyVQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=Drhhnlsfj2Iu1MCm7y4MwNEVChZMwINn0JQYH3yXdn+KUTfwiCc+YDBIFJkmSBCwe2fnpvAUoW1E63HI7Sh1ks14HKaZe9dF/ZN2JyGY3hjqlMQVN6OFLu+YvPw7bvPZsE+bCkcmRqk9MYfNKDZIcQX3P9BfKocbc+E5BqecF2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kWIg/zuo; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kWIg/zuo"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-59f9f59b827so10531523a12.1
        for <git@vger.kernel.org>; Thu, 01 Aug 2024 09:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722528026; x=1723132826; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iiSD1Kz+W72a0gnNEBMSQ8TeRYm2/qAOUP/x/1Pl5wc=;
        b=kWIg/zuoNHZnu9S3B0vwmuPc6yiYYafw4c/h8SXE/f6cuoz/b2+xOivs+nKzprlZYA
         4Io3cvDf/kCaT1ON80IRzkZL/eD2xMcjBTVztw6MrdvxSH+5dkbBxvK8PCni3LtmkwwA
         FudwQgVtXWlYSHLwEtGUwZ+knMdB5rh2trc4nMCJKGoUxp1IgpNFGR52g5+1yQ+S5GRN
         djDti97ov3ZhBXAxjd4iA2tT5O2b1ndJALMCCqn1iFvF/i0CaQiMOTK5VPPogmUWtp1E
         Cz++bRrNC05xvJzdYgZ2tBLP8JEfLC+eXr8W3fykQlIo22hO6U/yyrHLtudpMwwVYs95
         FImQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722528026; x=1723132826;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iiSD1Kz+W72a0gnNEBMSQ8TeRYm2/qAOUP/x/1Pl5wc=;
        b=YYt4kxrLil0cG3OmncYe2D6lK2RFDCtEHsVVYKYWYv9JD81MyNYOwa4zips2AW8GZL
         4jpDpH7tatcqU7FgJo9Zq4khvG9649lpOwspHb8xOv9dn948Gp2Zw+ArEQRSPX768Owi
         Ewxa1MhK5/ciMIgkaUhkxlQ4B3sJ0rViHoHvDGyKpDnTvxceeoquW1+fPE5sBGnJ8k3R
         B0ydTEnlhb4yJiMVju3NB32aQE8p2tpcpGoxMVZqevucNDz8kmTLrphyEHqNJE8qar72
         SM/0Asv7pXeF/q3/9psFd/ZN4ybsj+mY+Cz20QlXJjX7eUSeNiIrcxfmq83pT/H8THE2
         IW0Q==
X-Gm-Message-State: AOJu0Yy4nGN/3w44rqLa3RRLAs06o6eEuRZDx/0KHyYLJwN/hk8GP668
	OvJuXGzUGElkr5nJouxjzRr354ByzmQnyz5j5fZHGTZXVxlr6wFqJ1vqTSTs9skA884nJvpfaZM
	Zolov0fTpuhqHUnuyiXrGbE/cNaFcMO6o
X-Google-Smtp-Source: AGHT+IGDc0yeNBVtp7UdkW1pqTf3YqtzhiU5ZFhbh6zqCmVI/Jebo8nTynXTM8es4+AIwTpfQFrKQrKdQaka/69MWcU=
X-Received: by 2002:a17:906:bc22:b0:a7a:9a78:4b5a with SMTP id
 a640c23a62f3a-a7dc5107977mr52008566b.52.1722528025369; Thu, 01 Aug 2024
 09:00:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Christian Couder <christian.couder@gmail.com>
Date: Thu, 1 Aug 2024 18:00:13 +0200
Message-ID: <CAP8UFD1w05CX-Z20cGC=yhEzhMfWU6vOegymKBLVYNxnQANvVQ@mail.gmail.com>
Subject: [ANNOUNCE] Git Rev News edition 113
To: git <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jakub Narebski <jnareb@gmail.com>, 
	Markus Jansen <mja@jansen-preisler.de>, Kaartic Sivaraam <kaartic.sivaraam@gmail.com>, 
	=?UTF-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepnem@gmail.com>, 
	Taylor Blau <me@ttaylorr.com>, Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>, 
	Patrick Steinhardt <ps@pks.im>, Yuri <yuri@rawbw.com>, Jeff King <peff@peff.net>, 
	"Randall S. Becker" <rsbecker@nexbridge.com>, Chris Torek <chris.torek@gmail.com>, 
	Gabor Gombas <gombasg@digikabel.hu>, =?UTF-8?B?UnViw6luIEp1c3Rv?= <rjusto@gmail.com>, 
	lwn@lwn.net, Scott Chacon <schacon@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi everyone,

The 113th edition of Git Rev News is now published:

  https://git.github.io/rev_news/2024/07/31/edition-113/

Thanks a lot to Rub=C3=A9n Justo and =C5=A0t=C4=9Bp=C3=A1n N=C4=9Bmec who h=
elped this month!

Enjoy,
Christian, Jakub, Markus and Kaartic.

PS: An issue for the next edition is already opened and contributions
are welcome:

  https://github.com/git/git.github.io/issues/724

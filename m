Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9792BCF5
	for <git@vger.kernel.org>; Wed,  3 Dec 2025 02:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764728290; cv=none; b=mDDAkEXHdZnaf0Ojyn1CxJMcpKzOd6CyRngSQaNHXQkKuAzWGMPgJOkechoWmd3wroQCl/NwUZmivb4eVp2EnDFRyug25xlnmDtlcQzj4x4NSEAzHIHN0HtOVIo62Ksw/t11Q2oSBTEOB8nkFw611q/RaArya36xjRw8dDIohZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764728290; c=relaxed/simple;
	bh=vjaf0z0QNHgAfwJZ0o3IlO1K2dEphhj6Novi6F1XhHw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=FnGPeqyyzMDvTP4R3dJZlbR91FaVoG+2ckg6XyJ4K6psquSsWtCRCxe5yQLdQ/Jarqof47WqDpZgX6dpaaZLekrgltTxjBhqhFPntdwaUa3Ge6VWcPnDO9rh2bhOVS2MezdctaEijxNzWhSWD2IhZ8ApqH/r+u1s/SjOF/DI2Ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EbsaTaZZ; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EbsaTaZZ"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-64149f78c0dso9428533a12.3
        for <git@vger.kernel.org>; Tue, 02 Dec 2025 18:18:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764728286; x=1765333086; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gc1QmVU9cPqgVH5YYsupOC7M1WfPXNVTPZBfyherMX0=;
        b=EbsaTaZZkGdkJRO5flc0Z9U05Myq3b+2ftTpmlwz928NzEBaiDO6I4l42RR1yMSyqy
         OGRGRoHjg58+EH7oMf4CnMCW6lVM9ITZo4Urnfqnehr5mynpovbur1ouYaQtWancyYu3
         YvnLZuoncW/7x8UnowkN1/dfoOD8jkFPHSQvvxBvkGikP9T60g21URPScgHFBZyZknRc
         qysvIbM6WbV6jWt7KbUYCuIe369/pXf1dnDDhsqR9859L+N/ymepNZtUkjBeV17AGque
         9qB//hQi6es1fWJHf4bybTLQHlEutsIDFVnEmwLiv8S8pm37agg6Cg/WM5+ev4p3fV5P
         r3CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764728286; x=1765333086;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gc1QmVU9cPqgVH5YYsupOC7M1WfPXNVTPZBfyherMX0=;
        b=TX/JLlu3N4yc0ftQ1OGq5qXYJQcXVgjvIIUIt5zldo46VirBbMff9PEnPc2tfX9sSz
         ij9MLxCxzxrFFcQtwnsGV3omotr0VkoDXFR0q0CExi3PcdLCWCYR7YHN3wkpGiTL6vfZ
         8dc25jXLR5kH10rMidVIhYBBaJ2f/B7Z/IUjibuFqebLNpQ5JuUTKg5mCs5eultPKcxw
         Mvn9CxDvGk+WU4Pjs/bwkZSv7u3jIpl8FeaDLLeVL2YdA5k9FBF8gXhHhdmpTVGaloQj
         Z5yDhn0k/RPwdxuTKFR1+QY5UIrBeFlU90VM4PXLTxBYxzL3/uAMEb5+7wkGYLHcmvcL
         hG0w==
X-Gm-Message-State: AOJu0Ywk6On3XDlujE8sekcgho7ES3tNrkbtEroX6SMytLoX/Q70ps36
	HeNIpPoCi5GYOd1auIYSetIIA6bjt93IacFdllOX9YblBb6a1FQjTVLOOKFuUGPD6UgPzoAsJPW
	RzVsyjbhFyF6vubxG7A2YVfJhDNRjoq+36g7z
X-Gm-Gg: ASbGncu4NtNtYTKig/vFnGE87+qrj1DJu2zOAvoMtukPFWcVSFF0VVG9Qm2xNskfbk/
	fhNiATGAlBARtzT/faw7synhE1zqD3dZGVSBvPxdD9TZCp9S5TWUxTrRqK58H4roGA6Yge/tm6l
	yNJ474K2rMf10fzg0WX0bJH3RtQoP2ttLLYuQQHNU1Cb8x+f+2+agkHRY106vPbm8eZnNTbTXpI
	nAFH05KMQPgoDKOYlnjGpHxT9vEgsft4PuS7zkJh4N2vL8Q5gsEuMrn7spzLgFOdVsvw4w=
X-Google-Smtp-Source: AGHT+IFF0YM702LcS4joZzs1bhJEQaYmOCTHQ4PvAOmr8+bL3XN9mPVYScSn+kcCYcJQX396gPtYBdyMw38BwH1UPKs=
X-Received: by 2002:a05:6402:27ce:b0:639:ffb5:3606 with SMTP id
 4fb4d7f45d1cf-6479c4bdb97mr415056a12.33.1764728285996; Tue, 02 Dec 2025
 18:18:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Christian Couder <christian.couder@gmail.com>
Date: Wed, 3 Dec 2025 03:17:54 +0100
X-Gm-Features: AWmQ_bnj5nNukgVSd6gCJkBfRo49DXP3MDkBZgvn2z0A6icOhYpmK6hIkKjVuT8
Message-ID: <CAP8UFD3aBo4CNwhOPtExOvr5VfTmCV=Bw7CULpo1_5-62FQStg@mail.gmail.com>
Subject: [ANNOUNCE] Git Rev News edition 129
To: git <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jakub Narebski <jnareb@gmail.com>, 
	Markus Jansen <mja@jansen-preisler.de>, Kaartic Sivaraam <kaartic.sivaraam@gmail.com>, 
	=?UTF-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepnem@gmail.com>, 
	Taylor Blau <me@ttaylorr.com>, Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>, 
	Ayush Chandekar <ayu.chandekar@gmail.com>, Chris Torek <chris.torek@gmail.com>, 
	Johannes Sixt <j6t@kdbg.org>, Bhavik Bavishi <bhavikdbavishi@gmail.com>, 
	"D. Ben Knoble" <ben.knoble@gmail.com>, Bruno Brito <bruno@git-tower.com>, lwn@lwn.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi everyone,

The 129th edition of Git Rev News is now published:

  https://git.github.io/rev_news/2025/11/30/edition-129/

Thanks a lot to Ayush Chandekar, =C5=A0t=C4=9Bp=C3=A1n N=C4=9Bmec, Bruno Br=
ito and D. Ben
Knoble who helped this month!

Enjoy,
Christian, Jakub, Markus and Kaartic.

PS: An issue for the next edition is already opened and contributions
are welcome:

  https://github.com/git/git.github.io/issues/813

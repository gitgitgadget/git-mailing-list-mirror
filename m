Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5987A26E6FD
	for <git@vger.kernel.org>; Sun, 30 Nov 2025 20:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764534550; cv=none; b=T4c29v54/NlvJ8j72cliJc+6jlndkWRdCdeXItthY5tKo/jumf+agsojbGzEtBfGtYHCes/XOMGyYN3trPcRHJZ7oWYWGPJmjFQ9q8Y/EUh86eyb1/ttHMPQvZaaWDB8Cq5pKiRQIt4c8+LeY6lVnH30S3FFFVNoj/a4dVKFLkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764534550; c=relaxed/simple;
	bh=hrYkIdTNSToeehn1c92UReBWuWvOfQgoRfy0Z/f2N74=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=eeS5B5B9yWNYhskrNegxWDfCOoQfeiyWyN0D/GszApzag35ulshAMC6/1/DVvQ6C4hsDbZy51JK3bXfvC3xYgr/7V6OaZl02llDv3Lcoh0X8oNyXLRintThFLjd/8nDBftkQkrnV6NOvLczRu9h0fXgNKrq5iBJwHB8VLqGVii0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JGN+VPDl; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JGN+VPDl"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b73b24f1784so682595466b.0
        for <git@vger.kernel.org>; Sun, 30 Nov 2025 12:29:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764534544; x=1765139344; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=n+qe3cnZXOyLMmmd3gqK+3jF/WnS1N7BplwusTerQCg=;
        b=JGN+VPDld2Hi9siy9S2Weo1lNXXmSAdPidJJ2XLK9H5u5MugTE9WRIAomX/ZpdTv1y
         fMAXg4Jo6ysUdiX0gFX2NFB1UzKqiqa9kO/N036dOFCMVNGxmONEt7T62RXoWOsWMB/8
         UqcFTCRvZJ8CnjTdVYgYX1oyStvR6yfjrg2dqQUEiemTTvTu3aIMSyce/Frzyh8wqVRC
         XbU6jSE1VRFZSrWCPLwUilVnNfwKneQMh0LIX6sLLSuSMbJwzz5xrXV4OAVdqA0H6fDA
         hFXoA+iw2B/nbDmZ8aLusasFtZzyCEN+iGNoSB5F78iXg2itluz10ZWimpXwhw2stfFG
         TglA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764534544; x=1765139344;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n+qe3cnZXOyLMmmd3gqK+3jF/WnS1N7BplwusTerQCg=;
        b=Jp0f4mlm1v1l84jkQ1WoT4C281zwerPj+IdP7Qx/j/NU842fA/9C45TO+EpgBn0JyC
         E092o4chp6VT6G4lHflZc8lLlWgdn2NifMgwW3+cHvpW3YyGH69m4TKxQcQpyj+LpayU
         f9V5I+eiF/SuVuP401XEhPah5KRL49ngqNP6jnipArzuevcB17AVH7+XgM4fWtv1BDQj
         NvgOlOkSfM/w1NG+fxPQwBea+VglsPB7Gl0LRZvSFrWCtyi0nQCW+AIi8T8vAF70tbgi
         CfUWzYJuwohz21d1MqRFt3CZ/JLqDvtWtPxO1DpipiJEPp+xD80oab/57k+FoG5KFY3Z
         yT7w==
X-Gm-Message-State: AOJu0YwrSKfFP74yx7ktU7yOsHm8ZnHzVbsMxASxdLJVGWL5s56pFnvQ
	L20VKF0JtzcMyhReDtNq7t8uFeAY+Z44rXRyTViLnAMUFiV1m6MleWY2vLVlKK+G/ytswjuJkvF
	W5BWZIGavhO0/0vKRmzsZi/jfuXGYvSEvwR4G
X-Gm-Gg: ASbGncvQmTiMrop1i0pbI4opQy/uUN0o115PXbus5y+ruPBdPTDqpdjNuxfIwOB0mM/
	fUibOKAX6R6g6BWq0+voEI/JR7fiFUHydtpuhHYr8iSUPqvwu5fGNVX5aTDaBx3FP+gp2PcL9kg
	a/px/Gc9RfgZ5SC9V0z7VDVpjKkF5dVAOVs3uq2wWJb5yIqOdwQgJSKofxjXsBCygRXNV9jA6b/
	ZEEtksDCM8yUZRTz6uKHfjWVsMFChRQTOYIycFE1ov9PU8bFirEgZiqUGvZmZZSacACiQo=
X-Google-Smtp-Source: AGHT+IHr45zrOtndRNhAOhTxFMJcgDcKO3bCBJep0/ck547LhHj5HTEt2JVxo5EKzj2LeILp7Wp/lggB0yAD6jiskpE=
X-Received: by 2002:a17:907:2d29:b0:b07:e258:4629 with SMTP id
 a640c23a62f3a-b7657285447mr5032901666b.16.1764534543778; Sun, 30 Nov 2025
 12:29:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Christian Couder <christian.couder@gmail.com>
Date: Sun, 30 Nov 2025 21:28:52 +0100
X-Gm-Features: AWmQ_bkqkm0VEClxooRJoFjVBgk4p6kktt8mD0Go27mBnr2ixF_w5OyrjVDxC70
Message-ID: <CAP8UFD0X5iRhmQbXp3hygk=2RFm-wepo2TT+JXxd9++zSXepTA@mail.gmail.com>
Subject: Draft of Git Rev News edition 129
To: git <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jakub Narebski <jnareb@gmail.com>, 
	Markus Jansen <mja@jansen-preisler.de>, Kaartic Sivaraam <kaartic.sivaraam@gmail.com>, 
	=?UTF-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepnem@gmail.com>, 
	Taylor Blau <me@ttaylorr.com>, Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>, 
	Ayush Chandekar <ayu.chandekar@gmail.com>, Chris Torek <chris.torek@gmail.com>, 
	Johannes Sixt <j6t@kdbg.org>, Bhavik Bavishi <bhavikdbavishi@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hi everyone,

A draft of a new Git Rev News edition is available here:

  https://github.com/git/git.github.io/blob/master/rev_news/drafts/edition-129.md

Everyone is welcome to contribute in any section either by editing the
above page on GitHub and sending a pull request, or by commenting on
this GitHub issue:

  https://github.com/git/git.github.io/issues/807

You can also reply to this email.

In general all kinds of contributions, for example proofreading,
suggestions for articles or links, help on the issues in GitHub,
volunteering for being interviewed and so on, are very much
appreciated.

I tried to Cc everyone who appears in this edition, but maybe I missed
some people, sorry about that.

Jakub, Markus, Kaartic and I plan to publish this edition on Tuesday
December 2nd, 2025.

Thanks,
Christian.

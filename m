Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7811CC171
	for <git@vger.kernel.org>; Fri,  1 Nov 2024 21:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730495659; cv=none; b=OOPGvl/j7YWLp4nvAjuL1Tlzk0EzspzR4KY1zvyd0fFap9wJZgdSuAsWxk7D9vtWujMIrPxYOqoFGBVMKJk+JTEZB4+Vucw/JM3c8SMsK7+WZ6qi69IYis4I9IJmDWFAHo3AnZeAr5uOlad4oNwVvFI79loNXlERff7KOmZefXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730495659; c=relaxed/simple;
	bh=+2JKZmbAM4HnjYYHHh63Apv5AlO09UGBOAt7dYVErow=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=cV+c32N21nXCenWH/R4Zz7yplB5uy0O5JIxU7u4q2s3tuyev5z61voxQV5tMd4KXtPxJjl6RYupxuH2Xbv/h4Ut8zxp1DxKfg6xquoYBOUO+9Gt/0OTB6J4fWqToQizZtfe657e29OJRVPV0DjRMdpIcKcD1qohDJGbcluIC+nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AHyVYgZh; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AHyVYgZh"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5cb6ca2a776so3340207a12.0
        for <git@vger.kernel.org>; Fri, 01 Nov 2024 14:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730495654; x=1731100454; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TW1oLFTAPwpjTj2GkHyuXJNshXGoHcrMCP/l96t+Jy8=;
        b=AHyVYgZhvVIug/d2YSOO4askwqgIeMo13mBE4FZDiAlzT4buusZjBb+TqsQitMaazX
         9W0LwQClvWm2O+Hpw8LWKGWSXO4nVK48hSCXJT0nYrn8HgNEZVTV+EhSjXLMmkzWmFxb
         C1bKeMw+N/5amjLGQjxvyIzj6N1ixxQC8+pjebJj9GgFE3YhiuSU0G4ChtXC2ioOb5y0
         bbHbjgSTbzkQHS6YjuZFYsnFZZdRhnVTSXU7tY8u5R1jvmulUs1LCqUD3f8xjR/fojqr
         s7KNTVueduSgPozxX80HRwGCXjLQKKgib/qzpy+EkKPxdwv0jQaVKrOawJxBhSGhRQ08
         jorQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730495654; x=1731100454;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TW1oLFTAPwpjTj2GkHyuXJNshXGoHcrMCP/l96t+Jy8=;
        b=Fvcim/i0nguNUXCOJ5CX7hT9LJVlMjzLu2qmXz4oB1fA1OzzCY2q2LF4M3zwDBlmBX
         lgpBSiw1Z4ltFyZEcwAggJ8Sohn22409FAbd2fpIIBvEpiPsepVFM48m7WwDUMu0ng3/
         Etw1b40JXG8/4WTxdrLy9iJa2wfD4AjmY1c5gJlX6u2IbE0jOpijDKNIeToNwt8hxR3J
         tlJ4Rc6ydMUPQEfSo57IXKpL9dOsHgs+YWvWDJFDIjEDVTLt7T6/O3wBoEWD6JF7arWX
         gB1CHktF/dpklPGUxUzsXasYh7OxwPevpyXvwYzgKjbg3C9BlXHEHiOOHVJVpw6jNV/z
         XgTw==
X-Gm-Message-State: AOJu0YwXcKOc15tCh183ATbqAICBez1EQzGTmsdIJrQKXGKYoa04wXa/
	kDL790QYtt5+MgocicZV6rmggLyzrw9BhSLznY/da2cmZ0urwjRmUpUHE5bLTcDS5VUabZ+rT4z
	qv888iOUZ+9JGB+3H3YZkNDZyK1rPeeHm9roNKQ==
X-Google-Smtp-Source: AGHT+IFADeEsFSYiPFqgEpnjr5dbRhefziA0sfZHpzEpigexCX1jEmoDoUIpQuLur1lIIKUapftzrk0+135naNZe3O0=
X-Received: by 2002:a17:907:3f98:b0:a9a:6314:40e7 with SMTP id
 a640c23a62f3a-a9e3a5a063amr1096771566b.17.1730495654040; Fri, 01 Nov 2024
 14:14:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Christian Couder <christian.couder@gmail.com>
Date: Fri, 1 Nov 2024 22:14:02 +0100
Message-ID: <CAP8UFD0q_C-vFCPPEsem16fTMtnYFi3drj8o5zz=LbFvq9Lbag@mail.gmail.com>
Subject: [ANNOUNCE] Git Rev News edition 116
To: git <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jakub Narebski <jnareb@gmail.com>, 
	Markus Jansen <mja@jansen-preisler.de>, Kaartic Sivaraam <kaartic.sivaraam@gmail.com>, 
	=?UTF-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepnem@gmail.com>, 
	Taylor Blau <me@ttaylorr.com>, Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>, 
	Eric Sunshine <sunshine@sunshineco.com>, Matt Liberty <mliberty@precisioninno.com>, 
	Phillip Wood <phillip.wood@dunelm.org.uk>, Chandra Pratap <chandrapratap3519@gmail.com>, 
	Brooke Kuhlmann <brooke@alchemists.io>, Brandon Pugh <bp@brandonpugh.com>, 
	Justin Tobler <jltobler@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi everyone,

The 116th edition of Git Rev News is now published:

  https://git.github.io/rev_news/2024/10/31/edition-116/

Thanks a lot to Chandra Pratap, Brooke Kuhlmann,
=C5=A0t=C4=9Bp=C3=A1n N=C4=9Bmec and Brandon Pugh who helped
this month!

Enjoy,
Christian, Jakub, Markus and Kaartic.

PS: An issue for the next edition is already opened and contributions
are welcome:

  https://github.com/git/git.github.io/issues/737

Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA5881CEADD
	for <git@vger.kernel.org>; Tue,  1 Oct 2024 20:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727813262; cv=none; b=rRkx1ygN53JZVmTxfk5QfROPni+YRBOWeiqQFlXIJJH0y+ZJSGXkC8afRHsee0pkUzUp1hG/teurkmERj5o53//mnwUIzQPDt2SxL71OF824Ic8bFBgcRw5ppUusLoI+lR0D4gecQNw9F/XpUw7kUl+9JbT7uFMs7rNDPOTkcaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727813262; c=relaxed/simple;
	bh=H5VM2/1+GZTn/ry3uUr/nSFjk03Z1g4EEd+XQsU0NpE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=R896g9rhsIsxouFukeYf9MwQ5XcjHATIdLH3YRZ+9UEvLVCfVd/ZROMzjwUahUe1jGMeklny5sIMT4EZHGxHlHtvBJ9r4rmTmM7LHUKtuMKDmFysjMveH/oa42koj8pc/diJr0qwVBunVfhI2EX5xUJlIHxtzZSoapeU+rNODe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LjMCxr2r; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LjMCxr2r"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5369f1c7cb8so7306009e87.1
        for <git@vger.kernel.org>; Tue, 01 Oct 2024 13:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727813258; x=1728418058; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DzzJJrHWPpt2d0V/gUGww6krWuB4/3ED9Da860ZmLls=;
        b=LjMCxr2rBrWhSD/vhY39vm/d5fcmA3aU0s9VEdpEC8o92NQUuPzeFDy5DrRyjiq0qX
         V7yjMc23+p/qkYc2ShKidO9JjzdxgIzCtcAyQyZt2BRXfX6xDnOP/lyDZygPH/fp2qc5
         ZLAPcdBXGWjikkfA/kZRi2U38daXYrqGiEpSfCzkVTjCpi4WjpSKBbVTzMHmxLemZCO6
         HGVYY/bYsQxA/FvU+Znp3u9UY6/LkVCFm5XgmiSf//n0Pp5PAIywSf2QgmJEmJnpLt4q
         WgIozcudx5DCX5AXgkbkGkXcx6k+plN5s9Hjl/sThULFVGXhAOf8nVVyt83/GI8fhJro
         epAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727813258; x=1728418058;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DzzJJrHWPpt2d0V/gUGww6krWuB4/3ED9Da860ZmLls=;
        b=djUWoAKZAm2i8jrQT+Q8T/DGLUbSAwVqgduaNQwnICFNsMrGjpQWWuW+gXBgOGBHL6
         +HZ7Zq6+qeWuzT522kqMP0e92XdbZ/2FCVYK3BQB9kwiIzD6XkveDICg1k5K2wIxU39l
         TESR+I5cuYkVp2B2Tz1r8UKmxj4YmjBD1tY6Q6h39QoGM0x2nfNU02Hq4BrY/XfiuGUh
         mwBh95JIn07ixxDU+EiqMAzYUo3FFies8OB1Oftkw3OGySePDbgax4/4U4VGZ3T5bwMY
         UiM7LCR39tbBQP0hbtFhUvivcczXh5nGqFYqK7HL8hMsxP1I2A/wI9X4uax1S8BzOFL5
         y84g==
X-Gm-Message-State: AOJu0YyrSpDmMJdwIuc0E2TnJndQGqLNPAsRFNDbGVdS7DmWdM+RmVx0
	C1yiJyy1MKscwo1P+FGfXowsI/34qjZoXaf7HYSp3X/1WyBDjvfbmCHTMVuvJ7KCb26H9ExtBsa
	ebDWtkyRAUNqccsQKOoTTxOEiOzwW4Wvq
X-Google-Smtp-Source: AGHT+IG775cg9IQdPZ8pRtqqyf7jeey4vlTkTfEgCiGWxXYbD7S78KGwf/iDbpwXgb+I8fDhD9wNrqC5VwYMABqfzBA=
X-Received: by 2002:a05:6512:3989:b0:539:9155:e8b8 with SMTP id
 2adb3069b0e04-539a065c379mr430489e87.6.1727813258090; Tue, 01 Oct 2024
 13:07:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Christian Couder <christian.couder@gmail.com>
Date: Tue, 1 Oct 2024 22:07:26 +0200
Message-ID: <CAP8UFD1pRLHAxVQGQ-oxzKTDSp+EuspR8BtGhWNch8MRbcfBzw@mail.gmail.com>
Subject: [ANNOUNCE] Git Rev News edition 115
To: git <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jakub Narebski <jnareb@gmail.com>, 
	Markus Jansen <mja@jansen-preisler.de>, Kaartic Sivaraam <kaartic.sivaraam@gmail.com>, 
	=?UTF-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepnem@gmail.com>, 
	Taylor Blau <me@ttaylorr.com>, Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>, 
	Patrick Steinhardt <ps@pks.im>, karthik nayak <karthik.188@gmail.com>, 
	Phillip Wood <phillip.wood123@gmail.com>, Jialuo She <shejialuo@gmail.com>, 
	Jeff King <peff@peff.net>, =?UTF-8?B?UnViw6luIEp1c3Rv?= <rjusto@gmail.com>, 
	Scott Chacon <schacon@gmail.com>, Chandra Pratap <chandrapratap3519@gmail.com>, 
	Ghanshyam Thakkar <shyamthakkar001@gmail.com>, Josh Steadmon <steadmon@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi everyone,

The 115th edition of Git Rev News is now published:

  https://git.github.io/rev_news/2024/09/30/edition-115/

Thanks a lot to =C5=A0t=C4=9Bp=C3=A1n N=C4=9Bmec, Jialuo She and Josh Stead=
mon who helped
this month!

Enjoy,
Christian, Jakub, Markus and Kaartic.

PS: An issue for the next edition is already opened and contributions
are welcome:

  https://github.com/git/git.github.io/issues/732

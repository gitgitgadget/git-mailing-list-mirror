Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E61B18D4D4
	for <git@vger.kernel.org>; Mon, 29 Jul 2024 20:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722286538; cv=none; b=JQUIjUXIsva53sbYiSomUe2s6rL7Xq5/kWb4lgU4b9oCqaW1JiUiCH9xYqzSQSRaUrZYcB7NYJdnS2aJTSbryukGAw1AwhA/gamXemrlU73N78gpZynS9PrdJruYbfhiLrzd829Zr2XfLlJMEawIZF4i5xNrkfmCXSv7rRYGuOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722286538; c=relaxed/simple;
	bh=ScDZRDWS73yOwNeviniHzyjNuAEgWIevYZC7vrz0NWc=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:To; b=HqNkWJjFo7lCTDGN86X6mJS3f72en4XRqrW2hy6pj7cSouVcVJbatHZ//sLreVIkJ/x6o1CAAjkQDrWgO0kgu9teX/2qGOofKN/hae6ieXe1LvLHT/Hcu4FLzlHXOTnNxHB4S53FREa4sd0XpvGDsuQP8EoQHsdYQKFgGQ2qyjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=graphite.dev; spf=pass smtp.mailfrom=graphite.dev; dkim=pass (1024-bit key) header.d=graphite.dev header.i=@graphite.dev header.b=K2/wj5SO; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=graphite.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=graphite.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=graphite.dev header.i=@graphite.dev header.b="K2/wj5SO"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6b791cddfcbso14985536d6.0
        for <git@vger.kernel.org>; Mon, 29 Jul 2024 13:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=graphite.dev; s=google; t=1722286535; x=1722891335; darn=vger.kernel.org;
        h=to:date:message-id:subject:mime-version:content-transfer-encoding
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ScDZRDWS73yOwNeviniHzyjNuAEgWIevYZC7vrz0NWc=;
        b=K2/wj5SOAy6Tvzt7tSa1ql/mrVmILmLkPkgt1Ufzhq7MAN1tVJMiESkBVyPdLDIEsz
         wXWMdPOjEaQztpovCJkFJCD3uQMUYym5cC9e5c33Yb0pfa2Dzzy01xO964uueDYVifIT
         F7HLfwJJKABKOKrgn0LTgOp14UrgelgyJ/cBg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722286535; x=1722891335;
        h=to:date:message-id:subject:mime-version:content-transfer-encoding
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ScDZRDWS73yOwNeviniHzyjNuAEgWIevYZC7vrz0NWc=;
        b=RiRobRNjIal9wy7FnJSPjAQYhYNuBTszG3PkdXz5R86NakZO/DQ41Oies1qn6jM15H
         w0IHFJ8XUcvRiLy5nAE9u6ut7lBi9AKtMUmca0cVgSLrKcVDAnw3yjqFbllu0EFOR6CN
         9k2Wx0RdT7n2kK52RwAOC7Dwxrnsw43FLLnqtB/o/bvj24mVQ2ZS+fMAn6QlLYRCKZ5F
         RcZoLPhhZmFjeAOiQ1CVOyh8WNovaecBqrkrUlJbKGmuB8rgqOuYWqesn8SKYlehwW+V
         ipIPWQAGmOGCJ/9kZxKnDEQeIe6htd7mXqBHiiJCG2fn85ErXHnsB8CHReLFTo1eFE/c
         Qacg==
X-Gm-Message-State: AOJu0Yx2cj8qqJQon5vhqYDB2U3/VB5NYSbO2fMBUsScXhRNpltYz2aV
	vbeKoL2hyI+XddrKGfK6lWcV/MmUtwCWu1UI6iQihM/SANPTy0oNQ+7z4dwGa+aBqUcKtn+wWXh
	5zxI=
X-Google-Smtp-Source: AGHT+IHHoFsFADNiygr/SSND34Qv4D7XQSLNWI+bzKlR0tAMc4wpdX36N4VSNGGsLzCwaCzzr6rftw==
X-Received: by 2002:a05:6214:2388:b0:6b5:e40c:2c62 with SMTP id 6a1803df08f44-6bb557d8203mr77637516d6.0.1722286534655;
        Mon, 29 Jul 2024 13:55:34 -0700 (PDT)
Received: from smtpclient.apple ([216.158.152.27])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb5947f61bsm35583636d6.32.2024.07.29.13.55.34
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jul 2024 13:55:34 -0700 (PDT)
From: Brendan Ngo <brendan@graphite.dev>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: git rebase --continue in quiet mode 
Message-Id: <1F4B4F79-3F58-4934-9FFE-BE48702F7B66@graphite.dev>
Date: Mon, 29 Jul 2024 16:55:33 -0400
To: git@vger.kernel.org
X-Mailer: Apple Mail (2.3696.120.41.1.1)

Hello,

Is there a way to run =E2=80=9Cgit rebase =E2=80=94continue=E2=80=9D in =
quiet mode so that I can suppress all output such as the "Successfully =
rebased and updated=E2=80=A6=E2=80=9D message? =46rom the source code =
(https://github.com/git/git/blob/3bab5d56259722843359702bc27111475437ad2a/=
sequencer.c#L4092-L4098), it looks like it should respect the =
=E2=80=9C=E2=80=94quiet=E2=80=9D option but there=E2=80=99s no way to =
pass in this option with =E2=80=94continue. Am I missing something or Is =
there another way to get this behavior?

Thanks,
Brendan=

Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1742D1CF8D
	for <git@vger.kernel.org>; Sat, 29 Jun 2024 21:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719697357; cv=none; b=SPX0Cqs8eGmYlEUABNdwEDNhmMf12qbBvqKKa2HvsXBIiNnvL1imAoVr7jXiPAyWaZk8g4lKiMpTOffGs/Gew3INhhmExQZ3Fi+L/typtdGWrheFPShFJIaGWsVqZeQfTgK0Ew1EBg+7gE05iqxFjoXiV0Q/6LqgvoBglv96E6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719697357; c=relaxed/simple;
	bh=Y7XEGuQ3WTyq3quxAjr806wLHMmfwfYgI30xsfNIRS4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=fdPkXoV3jGIoGs3Iy6+O0Kgs3Rohdox94t6zw9iRzxGtoB93yMjWD8oqY5voIh5B/H7L453w9YhbJGqmCdqohb/+/B0lvsRMOoWGnJg/0nxN1aiH8zthRjfyyINm2U5Lzos448BKlaYo8x95qpyjSVW5D679i51DoH+HRiSQWBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mdv/Ts2N; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mdv/Ts2N"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-57d06101d76so2032016a12.3
        for <git@vger.kernel.org>; Sat, 29 Jun 2024 14:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719697354; x=1720302154; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pvFEB8vKRRmQY1Uc31OV/ad37QLodGWrD0gN7ow+tb8=;
        b=mdv/Ts2NIt5hIO+hOTEH9//JkkMV8uF2GCkG5MO+O0nl9PbTwxGNOCnYhR2jJ+sqlR
         l3AbD670G/k2pJHuU2oPPc+H0q8rtOVogO5DJwRZYGM+A/OXkPzQ6wBbsEx7oYbXod+B
         Ns41QevQTKBY6AQvzqpKMNzmVSTzPG3I6tUUHL++G09RVtCf0skxR41UOHtVqYFGEPRb
         SDDDof8FfXHQarkin1VaqA0hAkAcPgyNvQCxHyD0m0y5BHQNKH81/6BbOMmyaCnyl0MA
         7Uj0hRxLERzg8aDscBifpwAcOhMmkfSkoo1gpl0BadVrHR47cskDB4lcqi9ucHOFhr2Z
         OvBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719697354; x=1720302154;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pvFEB8vKRRmQY1Uc31OV/ad37QLodGWrD0gN7ow+tb8=;
        b=vopAhrRUe7p/SsFTPXaqF9D/ZNcAAlDmpxRFgnJBfJqHG6weXUdld8I9hdoI5UKnWk
         Q/9JAsVtF4hnUDgcP+dN+c1ENsjZeWDksr4acJ6YDDjHli/PBb4bIMAzdjrgirqp0TAi
         7l/JsSaRSlYUBo2C3GSYR9kfAglpSxqrF59D8KqF5ke5N25QslwJL2SLGek9ms9NafFf
         5/gxjfsu4cmwxO78++NW1iYjDYA0nLxXeMpLkRs2HV8mK41qLmRPWUxg77ElCYuke60H
         iwWN9B4KHLfy0FP3RDH49m/S3LPk3fdQqCkvbQ7lduFqUcUXxdZvV/vhGy3AhESQGWY3
         MVZg==
X-Gm-Message-State: AOJu0Ywc4QNWLTNll0AT1hv5r2fm4pLqp+mdlFu0K8eHZ/a8RHamWYvm
	c4T1irCpj6VmncebVouyNsed3Fy2jSaTBHaxzw5IzI2Z+EyDVAJ5Wwtg1Zr7YQIZIcQieGsHPG/
	KBvs94sdJFjUzIL/hN9ahakGL8Nzm/xYSvbo=
X-Google-Smtp-Source: AGHT+IGDO7jrSsoHIj9qhxbkfCeaaAMLtt2jO0gsCcKtaLW9HDtSE6Og5X4P9/OYJsS3frVU5UblQIjTfSONiLENEYo=
X-Received: by 2002:a17:906:c9d4:b0:a6c:7181:4ffe with SMTP id
 a640c23a62f3a-a7514498a9cmr117606666b.66.1719697353246; Sat, 29 Jun 2024
 14:42:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Christian Couder <christian.couder@gmail.com>
Date: Sat, 29 Jun 2024 23:42:20 +0200
Message-ID: <CAP8UFD1eH8GXn=aER56FVvrh90f_c+VdxdtopJmDYwPend52gQ@mail.gmail.com>
Subject: Draft of Git Rev News edition 112
To: git <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jakub Narebski <jnareb@gmail.com>, 
	Markus Jansen <mja@jansen-preisler.de>, Kaartic Sivaraam <kaartic.sivaraam@gmail.com>, 
	=?UTF-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepnem@gmail.com>, 
	Taylor Blau <me@ttaylorr.com>, Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>, 
	Patrick Steinhardt <ps@pks.im>, Todd Zullinger <tmz@pobox.com>, Dragan Simic <dsimic@manjaro.org>, 
	Justin Tobler <jltobler@gmail.com>, Karthik Nayak <karthik.188@gmail.com>, 
	Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hi everyone,

A draft of a new Git Rev News edition is available here:

  https://github.com/git/git.github.io/blob/master/rev_news/drafts/edition-112.md

Everyone is welcome to contribute in any section either by editing the
above page on GitHub and sending a pull request, or by commenting on
this GitHub issue:

  https://github.com/git/git.github.io/issues/714

You can also reply to this email.

In general all kinds of contributions, for example proofreading,
suggestions for articles or links, help on the issues in GitHub,
volunteering for being interviewed and so on, are very much
appreciated.

I tried to Cc everyone who appears in this edition, but maybe I missed
some people, sorry about that.

Jakub, Markus, Kaartic and I plan to publish this edition on
Monday July 1st, 2024.

Thanks,
Christian.

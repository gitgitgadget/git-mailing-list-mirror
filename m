Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B24C42E3E8
	for <git@vger.kernel.org>; Sat, 30 Mar 2024 23:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711839658; cv=none; b=u1NntZQm2JLm86VJtfC05NUA8q5mAaZ6fWSbdBNNSb+eSYSIHf4PWwiiEFubJwTLcO/if0dhdDUw5iLOXI3TVHwSp3utclBkUntFLJLFRTAHSWnkmpTEJTO8yETBR+ZqQ1OxQ3u4nf5y2zupkqdI5AhEr6gw7PoKtFwSpKAynaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711839658; c=relaxed/simple;
	bh=DAst49a2PD18y4rmLI9/w5bZ4Cjg7UsdRAEsHg7j38Q=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=V0sUNcXp/Xcf8GWy7oBAcCBs3MW8b2Yq5vt9gSHoJEoLRUakgL5SCm200xrspH5tIW7G3/C5HM3cKJrI9SKopwgDBZNtS9ehrqTjQLYL+62d9shVO7g/oVvhwBFkUl+Vpv6RRgUCeitJ8M5q5eR47FkzFBdOt/7XC7lBP7c0tVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hV0CWCX7; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hV0CWCX7"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a4e0e3ef357so387514166b.2
        for <git@vger.kernel.org>; Sat, 30 Mar 2024 16:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711839654; x=1712444454; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=c8OIERt3sbR7MKqQ0OSeukEYH4zlFwHhSDqBoRM9XhU=;
        b=hV0CWCX7/951ynrocAYxuqbi0NeSY+3bzHdoHEznGCR50UhKlt1rKXTlPOAqne6vIE
         4Re8KwH9qZwP2g+hMMcxxCa9QNHcqxbAdUoNuTxbkgFrGlI4mDlCJlc3T43xhseIUjuH
         C3TGHhF0ZOr9EiC9VI48YUv//esBzfEB9x84iF1U4r3OfKCFGfpRqy0suzvy7dCrBIF6
         5ICAEf3CAqwWQpma0VKb0t3yF+9muDOdAMeYocivjVkqhMyphlA2IniAc+SBLhiXwQFc
         n8nu6HeQTd67XPfqTVbZsYlpgUBo2HiIcWtt863ppRXQ1v2JSDlRkrxA6KPLykwILEuE
         EW5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711839654; x=1712444454;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c8OIERt3sbR7MKqQ0OSeukEYH4zlFwHhSDqBoRM9XhU=;
        b=r2RYGtovaDLazhakDWnIQFXoqbXKp+fe03FCmo+zmEUD1Fz4TlaRH57uEiq2xQqMDn
         XT553QF8VRo0Fvj8tciVKI0/IWruyvjBD8hlstopRbU1FcPPtnjFyOJdkGNjxn34hMvF
         YTh2d20wJsDw3UCEtLl7mfbsoqBVz2sRDkn5yTpw0qLBNC1BGUccts/08+Oa3asBqcyK
         /VYruPa5OGlebIBwKKCBMHCktu3XPZL7zBkP+VlJeMqRcZzaToJFkAIg9wqiVEUckGl3
         PqIaGKsm8882OAx3Zpkqi2bd7QjdTSCWIox6lu6/aGTEpHA8QM3PexAoCNtvyqow+JhG
         ulQw==
X-Gm-Message-State: AOJu0YyXzgwpqOJM6IPbdlfCixOv5DHQDzYQ6XenKbelPMotjielfx/l
	4UaOITz+EiCMVgGJFlbD3CaKyIGXXxZmgxZ0EqGBISI5s1tyt29LRWn4o6LCdFQ7fZYfyngPEV/
	Rpdn3ZYcpzFreDyEaorJffoQvqFNW9mPmIOAvxQ==
X-Google-Smtp-Source: AGHT+IEB6scJledqmgqsSTSEXn9U0p12RZsatzcfCqULWOeg+IIsKYi11Htzj2N1tc2auDyeCkhC/ZgKw7ePlNCp2eY=
X-Received: by 2002:a17:906:b42:b0:a4e:5f3b:1b8d with SMTP id
 v2-20020a1709060b4200b00a4e5f3b1b8dmr219173ejg.10.1711839654185; Sat, 30 Mar
 2024 16:00:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Christian Couder <christian.couder@gmail.com>
Date: Sun, 31 Mar 2024 00:00:42 +0100
Message-ID: <CAP8UFD25Dcz-Fk6wBaETX4G4OBucrexDqTd1jwH25tM3ixUhkg@mail.gmail.com>
Subject: Draft of Git Rev News edition 109
To: git <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jakub Narebski <jnareb@gmail.com>, 
	Markus Jansen <mja@jansen-preisler.de>, Kaartic Sivaraam <kaartic.sivaraam@gmail.com>, 
	=?UTF-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepnem@gmail.com>, 
	Taylor Blau <me@ttaylorr.com>, Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>, 
	Bruno Brito <bruno@git-tower.com>, Harmen Stoppels <me@harmenstoppels.nl>, 
	=?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>, 
	=?UTF-8?Q?Jean=2DNo=C3=ABl_AVILA?= <jn.avila@free.fr>, 
	Kristoffer Haugsbakk <code@khaugsbakk.name>, Patrick Steinhardt <ps@pks.im>, Linus Arver <linusa@google.com>
Content-Type: text/plain; charset="UTF-8"

Hi everyone,

A draft of a new Git Rev News edition is available here:

  https://github.com/git/git.github.io/blob/master/rev_news/drafts/edition-109.md

Everyone is welcome to contribute in any section either by editing the
above page on GitHub and sending a pull request, or by commenting on
this GitHub issue:

  https://github.com/git/git.github.io/issues/697

You can also reply to this email.

In general all kinds of contributions, for example proofreading,
suggestions for articles or links, help on the issues in GitHub,
volunteering for being interviewed and so on, are very much
appreciated.

I tried to Cc everyone who appears in this edition, but maybe I missed
some people, sorry about that.

Jakub, Markus, Kaartic and I plan to publish this edition on
Monday April 1st, 2024.

Thanks,
Christian.

Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A7FC1C07C3
	for <git@vger.kernel.org>; Mon,  8 Sep 2025 07:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757317543; cv=none; b=io/hgOFih7aF5gfkmB28EBRyrJl7HeFv17I1HA7uu6E0B0iRF9/64zHppYYFGD06mG6LgdjoTcs5vbEGaPT5OWW7wfmtnTLCrg6hYyyq3lVWNjVMlLwI1pAaecL47jRf1NQORFMKB3OTlf/MBuXJALQw/KH1WO2Qogs+LLBFjRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757317543; c=relaxed/simple;
	bh=oncQve4wh7i2yJUfKkaC3luKqUp9vKQfG2+HfiSzuCc=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=AhmJ8G30xn7iM9QEmXC/C/joYtzvcQavsF81OrG7Rq3KNOJTLzPRGDzZ6O3vASp5Ih3tuYPj4UdyV/gA8dgDNnPS+ijqPhUp8RhQKjJnqxaFxgxO3zj7MiS2iYwlU4ewz+/OykGlcZwKutu4iUsMWcB2N6JcPuv6VJU23DMpiIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Of5YNeht; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Of5YNeht"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-62733e779bbso336382a12.1
        for <git@vger.kernel.org>; Mon, 08 Sep 2025 00:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757317539; x=1757922339; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oncQve4wh7i2yJUfKkaC3luKqUp9vKQfG2+HfiSzuCc=;
        b=Of5YNehtz5blbQFtVEgzs+BLmKVey529l6i1LcRFqRGDJfS3k4bU06KHSynDFgD5ar
         1e5RcuWy5elWcc4G6boy6a4j9XPhVB90QtrHQxRXv98bqrlvBznAjUjl4jPWS0PIK28z
         NVW7+naayTmlF9QYf4/PwG0b0wxNAUQfBiA5ljzarttBNFrrMsTL5x91FvNpjkIDO+c0
         Hn0iL9AUGQd9wv2rRoA/YDLY4Md3zZjehWa7GhEIFDDJO4PcyRTubdze3SaXcmR7pU+L
         P6AP81IHuduFhJwq60tPT1hl72VwIDtrCVLaqVhFJx2p1yS1Dg2SVblUh6vXfkKwd0LW
         zWTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757317539; x=1757922339;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oncQve4wh7i2yJUfKkaC3luKqUp9vKQfG2+HfiSzuCc=;
        b=BOpaxU0ekGmhRQ8+nO8vvS0zKsD8YZERzOJhFbIfLtXcff/gn3YN9+3DKC4iKFZQBB
         Pdn74OeUOWMwz9eLNTCyB/ovmiSOitPaUiMi2Q0WH4VG0x+wFE9x41hFbFWBy+TGEN8t
         UnOCUD9ghyMsa5xo7FkKYoIgBAB53Dkj97KpRJsC6zmQltwy57p5vdgZrLbvXfycI+z3
         /ayqDye+2zvNvaJ5nDXUkhkdWHsdbdmeDLcH3kkuJhBuTR6gr8O1QS/PWv8ODciobFmC
         /6OratJp7YcFoyFZsReBetdcw5t6lurU3/4d42pDcrHa/vVvUELqqQmaqLKN6ix0LFrm
         cRow==
X-Gm-Message-State: AOJu0YyyqdkuPUAT8HgBk3C995stbKTwrH8xESZH3rOecw+qp4PH6yPW
	WHX72AERC1OhPIEBzE6D2ux6atebWnfgm8+GFj9uiJP9vnPZmMjz5Xh4hl83rQCFItbH7IZiJ2Q
	PAG2u1Pc1OUDDqFhNmVtRAiRICOpJVm8NgXv8
X-Gm-Gg: ASbGncugLkg93fbeO9GdVMbHUiMWpw77hCNN98gHl3VIyXkmgiKG0HnQZD7MZAZNIPe
	+nYmgZ/ThMMlGfNZ6EEOv9oDMx9Avw4B5vjAiFLVAqSGkV3/ONsi3p8h3foLSXHy3FJMi1UAjnf
	EqRtDbbMUXjbBsPC/5HX5q/cZ32Rjixucn+gHcJb0DRg13oHBJaxUnPRyvU08wsmKfr/dAL/A78
	Qr2yyTQMOnycXZ3DGKt
X-Google-Smtp-Source: AGHT+IGiG/IXHM2rc6GtATVPXxqqh4xLG9Pxz33QvsiT2iTBDOTXBzqeaEv12ngHl7WzxVAmws3gzrTGg7K8mT30ohA=
X-Received: by 2002:a05:6402:23d9:b0:61e:9ebf:d33f with SMTP id
 4fb4d7f45d1cf-6237b97239bmr5617026a12.11.1757317539105; Mon, 08 Sep 2025
 00:45:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Christian Couder <christian.couder@gmail.com>
Date: Mon, 8 Sep 2025 09:45:27 +0200
X-Gm-Features: AS18NWAnc_TZqrig98FZEs0D8tAIq6nNGj0TczYEOVd_7N55snLTt0KbHSuU7bw
Message-ID: <CAP8UFD2OcOaSsumKGZ-oVVWzttc48CvmQZD8tQaWTGQR7wR1EA@mail.gmail.com>
Subject: Participating in the Outreachy December 2025 cohort
To: git <git@vger.kernel.org>
Cc: Taylor Blau <me@ttaylorr.com>, Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"

Hi everyone,

Communities had to sign up for the Outreachy December 2025 internship
cohort before Sept. 10, 2025 at 4pm UTC which is relatively soon. As I
am willing to participate as a coordinator and mentor, like previous
years, I just signed us up. We can still decide not to participate if
we don't find mentors, good interns or sponsorship for the interns.

I have mentioned GitLab, GitHub and the Git project as organizations
that might be willing to sponsor, but others are very welcome to help
as Outreachy is navigating significant financial challenges these
days.

For more information, see:

https://www.outreachy.org/blog/2025-08-14/december-2025-call-for-mentoring-organizations/
https://www.outreachy.org/blog/2024-08-14/outreachy-needs-your-help/

As usual, everyone is welcome to participate especially in
(co)mentoring, providing microproject and project ideas and sending
PRs to update relevant pages on https://git.github.io/.

Thanks.

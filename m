Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25BBC352000
	for <git@vger.kernel.org>; Tue, 30 Jun 2026 13:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782827105; cv=pass; b=sjm9PKVlvZf82O+tLjUZ9DfC31I2qiUMZJYtOI+EKN3uRd4xdyJmSTUX1lLA4yPlhH8Fxf4bCo3/N8BwX+Dx1qhchfLi3a0XcVqnbWj5gdH/7HYRQO3uynC0fTB22Fq6gpucGYNkUgf/qsMhlohUxDpt3bi/nB58R0CWXD1NLKI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782827105; c=relaxed/simple;
	bh=y4DHuKz9u3Rb3aGBKWUoNrIT5c3CF8mYtvXdM8q335k=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=ZYMN8lpl0HjDagvIHcyLL8fQYdGWLmLG0h7u2iRu8zaKXan7+99zmtBPBlB67Qw+XayACEDb9wdAGxIFKT3Z/RC4U1ZRzi5FS+P07qSj9A45M+jBRjDSdx8Me1peskMk7Fiuqiqr62RiY5pq+FYxFby1Rdgq7aL9knfwM0KLe8M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fr2xuOfm; arc=pass smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fr2xuOfm"
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-139f1dfc9faso4293746c88.0
        for <git@vger.kernel.org>; Tue, 30 Jun 2026 06:45:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782827103; cv=none;
        d=google.com; s=arc-20260327;
        b=r2eBWpzgN0e7ErCMpT0OFx218hdGV3XIonDAdFKinIoV6CBoqZXBOS2FC5ISAyxNtM
         kHrOnvwK5Pb9VRx7faY/zFSOCekcewFeTKWA8FdSrxwK+S/dW1AO5iL7nAQXvrwI9PiL
         IEpKetMa8a9JXZ6IAmVktSyuj2RorlYPpOAziQe1XsPqEacfwCbs2GbXdjyuQbqe2HM6
         tLPHnX3x/MkDnT1Ev6rYrEVUIZyU3HCuntHNa87HFNqS/gaheTpn1DXQq5/Se+73cW8w
         MbtgJM/O+ervFyycg42kwJ0BUPhLfkTY2+eIkNP3I2fLAmbcOOvVXcd7HRWajZEmGgKJ
         VHVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=fdegAd9I4BxRkSgkYQqMWlV/7r/+Rv1tUuD+db7dkVA=;
        fh=kRUG/UTTydKvA2tcQPfSCjXil9cPpz91yDsWhVkK2NA=;
        b=lCSnadhzZp5KvS0VnZoM00/KKN5gtAeUqgse/A/V5bIavte5js7YuENVDvjG1Fl/h+
         ZaYs1UBxXowK7ELivaccXfNxmA8QO+SXK4oh1fha153yd7RJcgkV4J7zG7J+mHc9faqg
         BBSd8tcGeJP/IoAbXWQFiLPNQOG6XZjzqtKlNNExir08XnlOYBNAgN9ki7DqRsHh3zTP
         Lzbm5qimpY0A/ysL/jQohpkQMlbxJy1C854NqLYNJt0ILuV28z1Gn5CEH+VGhNyzo9yr
         VIzUjS9MJwXdQy0RKUw4u1Fq0RWaqfgadfbXfNDsO35VgsO5J7CtvT7KagB18oJEgEvg
         Ry4Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782827103; x=1783431903; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=fdegAd9I4BxRkSgkYQqMWlV/7r/+Rv1tUuD+db7dkVA=;
        b=Fr2xuOfmKKrAPbZaBguzYntW80pCJyn8OOi9VwaWilTxKha+78gTb1XlH6IFt79AwZ
         Mk1AHYowNfCkWHE2Q6ZKA1u9kJv8+1HacDVuQoO3wMmfNFMRNuFc6c8rK27/20Bhtw8d
         7ZtXzKT1wdpQHQGTbCC1i88jp6h+/BhDJt24FizKUEa5bOHRZnT6M1QYNrOQOezAKO0x
         S8hIEELzxdE5bmCp875DQJuHR9SBhzdT3uuG8+Ij5DlJqq/WuHUVyyu9J474vAbz0CpG
         C/6nM0TqXogQMhoGvjk3lAAH5JMoA1FWr/ku/lxuDxglgIiygTRDQkWqV2tDcAKA5apR
         a9jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782827103; x=1783431903;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=fdegAd9I4BxRkSgkYQqMWlV/7r/+Rv1tUuD+db7dkVA=;
        b=H8LDwh4NTET1N1HXF2ndHvfoZtPNHAuyBhvu+KYVwuypwSEE4FYsoQtz36IA0meUIL
         jWNw8EWPXwBEozvCO22iQI72EiC9gblQTKeJTwS0fPqiHLuOfNDhilqJbftr3kMF8riJ
         lJdbgFCb1pOvsoadP15fyMKFja/YKPMCfQvzowuiY/Q9OkwRZ9+kige8YhFaggEjElUP
         nE9VXIv16IdIruPYjTneipW1iOTPLw6v4lKAaCwHReRdxo4FkHg3X5t1vkDiZFgxbzG2
         QsgPpFKjMIhzISaT0OO5bTBE2Tt+K2eozSL/n3tfzUf8+JpyGm89NI/IBThvwJzyozz7
         f1sw==
X-Gm-Message-State: AOJu0YzkFcfR5PmVleqpmCdHPtQRAe05AQTyqMf+3ZV5R51Ews8HT422
	WF1u7l66mG0wummsfmdCf0J70aZtHbEuFmCvyLktv/6Ny0MXlG3X+B101oUop62Q4YOG9oA+0/O
	0hr7xUT93m4WJ9tEPtbcZV41UIcM7b9QhzwZ6
X-Gm-Gg: AfdE7ckEb5HAZkY8R/hIY0DRUOd1kBVQserd8uJAdwxtc+I0ARIXT53BwCzH/Br7e10
	Gk9uWrQLUzHx9rj+jEPDX0jestT9GCHUpqzuarqaxrZAN4pWsbWwKn0vEFyK2OY4taBSB2J3ugJ
	CICpuucNQi11GCZl6bTQLPGexH/qJzKTYaPnMHWOYtQfVVJsvT/5DgpgcoIUVLEWzfbMlYTErn4
	QSbnFGIIa3aBTByd8RqJN7cKJIzK2Ok6IXE99DI4/bsOUeDPup+5zt5f4zSDab5+PbcsmzJkw/D
	Cia6d0KxGObLzzwRTUIQKogkJ2iCGthcKGkUBqjZ7a8qWXS3qUE6+GsTk/x8GlblVfM5
X-Received: by 2002:a05:7022:11c:b0:138:42:96eb with SMTP id
 a92af1059eb24-13b2a160634mr1933597c88.17.1782827103183; Tue, 30 Jun 2026
 06:45:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Christian Couder <christian.couder@gmail.com>
Date: Tue, 30 Jun 2026 15:44:49 +0200
X-Gm-Features: AVVi8CdycUksX0VEt1hDDypOiBiQglffYDav6HYW_EGxmobTAFd608LVAzh00CA
Message-ID: <CAP8UFD0_UZ+nS+t_Por0q4--jvjX+7QUpoUEyBudVw82fN32ug@mail.gmail.com>
Subject: Draft of Git Rev News edition 136
To: git <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jakub Narebski <jnareb@gmail.com>, 
	Markus Jansen <mja@jansen-preisler.de>, Kaartic Sivaraam <kaartic.sivaraam@gmail.com>, 
	=?UTF-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepnem@gmail.com>, 
	Taylor Blau <me@ttaylorr.com>, Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
	Derrick Stolee <stolee@gmail.com>, Elijah Newren <newren@gmail.com>, Toon Claes <toon@iotcl.com>, 
	Paulo Gomes <pjbgf@linux.com>, Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hi everyone,

A draft of a new Git Rev News edition is available here:

  https://github.com/git/git.github.io/blob/master/rev_news/drafts/edition-136.md

Everyone is welcome to contribute in any section either by editing the
above page on GitHub and sending a pull request, or by commenting on
this GitHub issue:

  https://github.com/git/git.github.io/issues/846

You can also reply to this email.

In general all kinds of contributions, for example proofreading,
suggestions for articles or links, help on the issues in GitHub,
volunteering for being interviewed and so on, are very much
appreciated.

I tried to Cc everyone who appears in this edition, but maybe I missed
some people, sorry about that.

Jakub, Markus, Kaartic and I plan to publish this edition on Thursday
July 2nd, 2026.

Thanks,
Christian.

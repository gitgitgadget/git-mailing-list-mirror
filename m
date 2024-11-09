Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4573338DF9
	for <git@vger.kernel.org>; Sat,  9 Nov 2024 08:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731142209; cv=none; b=hWXSZzn8OToK9L4Tw2VKqBdmWWZ9JRJXda5iVr7xZI7YiX+zNAo6/kdAAR3KlNkuq1Gr53nLCyuyOkenNyz00J/Q5nM5THCcTqFfvEsWVvjRyHEKQ01BRvpLg4wgnujjFKQhiOoIg01Y7XioYtuGFZlq3bHTDDrnMRkJpWG7grw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731142209; c=relaxed/simple;
	bh=OLgIXNvhnXeQhpZq5+h0yJ9S57vCdzCTSg4WKU9qZVs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NQAlTl4zsQ81D6PEJ3clBJx2RUf+QRSZzzQLrabLfsWER4dNV7DrB9UxAooCeTuqcR77X6cNHUoS/1isExYrex71BzU/epVub7MZ+7cK9Ya+ObRuixTCdadvYJAKglMCHI5bHX9V3X26OEZ5nb2en1GqLxFQOaohsulB4ae2bU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aWMf88cy; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aWMf88cy"
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-82cd93a6617so107116639f.3
        for <git@vger.kernel.org>; Sat, 09 Nov 2024 00:50:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731142205; x=1731747005; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lRxK31Yq/+Xy4P9FPJ6jebQ5w2V3tNFAWzXlN5lUBH0=;
        b=aWMf88cy2xS+3WV+3QDwC1rJd/7o++PnhmGDpgUpYuSf1j8vO/XGkdRzvGLVaX9jw0
         dyc+BN0pT4Zj82yJo0QodPuzNlo538PSGqOo5ofVOk9evqVSEgm7NmTBarI42EwbPhAu
         U9zMu2Vcy7CMA6pnvXZXJ0D2N32qHhXRRf0bEO/iGUcKofTHqZPbZg6IckRsodFYziQh
         kIVmyugp9x/qXhhePRmmI+lSmSY2XBvveRELfmHFtsjA421kUfxpRzxPAdJXxNcsK9+G
         u0QFtoLV0XdqCNYKSCHkUXGT6nHSf6hI94mqagDTajdl3crmkCRdFDhoih2gXPkyrCri
         43IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731142205; x=1731747005;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lRxK31Yq/+Xy4P9FPJ6jebQ5w2V3tNFAWzXlN5lUBH0=;
        b=ttYe6Cqh03bdU7P/r1MULJrzlNrFKFpH1+rdMFfYpn3YnIl6aapLkdt71Fwe9Fz8ke
         KL1EdNH13iipC9R8FUfAGHGJsmvzSYA6QO7rjPslbHkBEl+INkDYdDn9WOY56scBACid
         4D20y5q93vR28DaaGyvZ4IXUTMmShK7SOoRs35DrKdZ7jS338/rwslxPXEgiBVuXi4hw
         6NQSFxdInpzB6uIgUz6oxmmV6AzGgu7cfjfp8XzaDyOgr8BYXvvCz8SXvMTn/7020yXk
         YWTEhn2VOcsALHKqqTP2SzJuKA3J/g0gKDBxaWqzgdHS2jz3YBoec9vNNf1q7hEKjDEQ
         W8/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUD/KZEPU7cZTJm7BKyjHYzTlPU5Ye2ZB5TL89SZPFSsrh8GW0GRUkz56DZjuFn8GdxibU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbeZuIj6tD7w3CwzaEWE61oBidkKIVN9yGZ0q1mB13JMvnWOKL
	djjXX0R3YNp2RhS5dmfMwlnGn0ZgibmEEywLIXEN+eqsYdR9NdgqVlSTGIJf8fHH88Luix6py9G
	2X1FIs8OfomZN1DxIlbOIZWLo0ms=
X-Google-Smtp-Source: AGHT+IGrkDg47IhP7ID2Dc7Cq1QbSxYCFWkFZ6R8E9FiCz7NGHzn7nCHtGND01ZynaZHPCzT/XLj8BzAuWaN7FZQ7vY=
X-Received: by 2002:a05:6602:14c1:b0:835:45f9:c2ee with SMTP id
 ca18e2360f4ac-83e032a8e61mr731531739f.4.1731142205343; Sat, 09 Nov 2024
 00:50:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1734.git.1731000007391.gitgitgadget@gmail.com>
 <abc2453b-f7df-4601-8834-595881f9ceca@kdbg.org> <af576487-5de2-fba3-b341-3c082322c9ec@gmx.de>
In-Reply-To: <af576487-5de2-fba3-b341-3c082322c9ec@gmx.de>
From: Elijah Newren <newren@gmail.com>
Date: Sat, 9 Nov 2024 00:49:54 -0800
Message-ID: <CABPp-BEaZXZ2wSfrkkOAX6W9An8MTf-LEVNKvXvRTxyV9XcKcA@mail.gmail.com>
Subject: Re: [PATCH] range-diff: optionally include merge commits' diffs in
 the analysis
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org, 
	Philippe Blain <levraiphilippeblain@gmail.com>, 
	Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

One more thing...

On Fri, Nov 8, 2024 at 3:04=E2=80=AFAM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
[...]
> Footnote *1*: We should really find a much better name for this than "evi=
l
> merge". There is nothing evil about me having to add `#include
> "environment.h"` in v2.45.1^, for example. It was necessary so that the
> code would build. Tedious, yes, but not evil.

Indeed, I've felt it's problematic for a while too and had to take
time on at least one occasion to mention to someone else that I don't
actually mean "evil" it's just that "evil merge" as a compound term is
the convenient nomenclature we've been using for all of these,
regardless of whether the user modified the merge to resolve syntactic
conflicts, or to resolve semantic conflicts, or to sneak in "evil"
changes.  That's particularly odd since the first category is the most
common, and the third (snuck in unrelated changes or "evil changes")
are the most rare.  Maybe we should just call these "user-modified
merges" rather than "evil merges"?  Any better suggestions?

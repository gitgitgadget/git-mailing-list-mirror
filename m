Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80AD5267B61
	for <git@vger.kernel.org>; Wed, 11 Jun 2025 13:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749647621; cv=none; b=hoICkmR714/aGgg2qkWMxdWNYFvbNfUsOQCQcDlX0L8LmHXfKdiOVISF7M7n7BKfevN8agpX89lSkpjKMZfNj07xN5Yx98IQdtUU523FPCSdGEOzqn7An8Vo+KN4jSCb2gz2i/GzdSuHCeZDRDDqqO1bLVDhBD/bXKrKGaF7veI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749647621; c=relaxed/simple;
	bh=zFaXxDlNBZxTtSius6K6D8wFvIIQOSnftkfeCTtXMUw=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TiWEraBKH8sm4hzmSD9NRIadOodZb4SA5hIyiZRvtx5giTf+LJIXIwlayLHP9gCL+I0sB+oSj/AC4jUAGgn07Kw8aSL1ri+kl3X5+ZZW6kXMyOeLsa8HCirlXY6Nfz0TyWWn9QpppE0J+0X44TmGVOgwifIrGGVu6AbNqsWEIA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZXfoVKFm; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZXfoVKFm"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7d219896edeso648153785a.1
        for <git@vger.kernel.org>; Wed, 11 Jun 2025 06:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749647617; x=1750252417; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=JYGHnLlMyYsQs18MWPkHah7aWrxPsuZyTDQpjboiVbA=;
        b=ZXfoVKFms5yMx/eaS9HuJ3dAp0lk1Kyge3qhzfvFoLU9L2OXCL8z8Tbw4giQvZGEye
         prvgOhKYWk87xQ06ZKn+PkwLP7gxgDAIhOw2RYVWgZ4FVQU9CJX+kLa20qZUnjFHs9a1
         6r9MeB4pMt1esgdjZqK3vTFx6b4SXO4Q8xBX3lhZEjFR7lRAEofWeD+EOr+/rEb1K8qx
         feROSxjnugs7V/5tvl38c1k9l9Pdn396zq1Ql1BsV+yrxloUZleX4OaBpz09Wo4TFZt7
         KIPZ2xzpMo+W9Y3mXOPFHRrpemlCIoZq+6fLRRDI8f91nmJdEhHifaBJ+jZyQno51R0Q
         9Bog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749647617; x=1750252417;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JYGHnLlMyYsQs18MWPkHah7aWrxPsuZyTDQpjboiVbA=;
        b=eS19UaB2zCYM71A7UBboIt10bC+4mJtCs62zeNJhHe40Ng1aS0IFlTBKuIT5+k880k
         LNN3fq/hjGiC5cSiAUol7KttDEHGHreyjb5OIyv4+QEmEDBsWT1rjfuAPURMAxVFwvRp
         f62mTTQSpiVF8YCdY26UaA/1kIGg6ha1lTJy6C0ah6azIumA0FoUIFhWrxNjdI+LSIkg
         0ba/2JQNueZJk8RPJZOL11/DBr81hq4nMrkyC+iW5oBTlk5qc9+WEM5MuLUEKL1CHQrc
         +92NqDtnlUyc46M6m17TZhb1gB8OeUoKCKvxHrsIO9BRCr8RSH6XWY6euVDmz/erj0SZ
         3Nng==
X-Forwarded-Encrypted: i=1; AJvYcCUaxE0xmiF16pGn/gJTF95ImunE0UG8nULob7k7EhvJRJausS95fPhdZjwSY+GvrEXelv0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz08H6l+lz5PJZaIeYs2P9OInG9xGRwbnWCqd1SWQXIS6xN+JzY
	pmwuzw2iV3Lgedv0orY3MterdFV9X+g93uFiwEd+GrMUGHZsf6r+Giu70KLU/x1itns3/pU1ByV
	TCKWK9iRuCPsktE5J9v8z57S7yXUkneSpln+YEU8=
X-Gm-Gg: ASbGncvypwiZCoT15KSi8r/9/80AQA94vh3DHmVK1XAwF0AoF/ibI/4ZtO8I1OckoJK
	m6YW4UB9rbcd5Pl77xQBvU3/+6w3v0oeAhBrXEJOs34eLEhPRv6ZyMvlHCIJlpSH6NdWKqqh9N3
	ia+/HlP7/kky026b6NcQLVNa49xtopvuuIkITFFxLdYw==
X-Google-Smtp-Source: AGHT+IGBe/IJGDBYvVbiT0j5Kns/eOI15o5PNug8dHe3R6Zh3ea/2dPHTNwzwppStF3Z3SIOJujywO16VerYkABEzd8=
X-Received: by 2002:a05:620a:178c:b0:7c3:cd78:df43 with SMTP id
 af79cd13be357-7d3a8a3f75fmr498567385a.58.1749647616853; Wed, 11 Jun 2025
 06:13:36 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 11 Jun 2025 06:13:34 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20250610152117.14826-5-lucasseikioshiro@gmail.com>
References: <20250610152117.14826-1-lucasseikioshiro@gmail.com> <20250610152117.14826-5-lucasseikioshiro@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 11 Jun 2025 06:13:34 -0700
X-Gm-Features: AX0GCFtT7_65XnHmvdR-433HiFR_1e4tCaG9Kr5K-Lc0skz2OJAczW1_7xUnbY0
Message-ID: <CAOLa=ZTvC7Hq5Fz6N1ESzf1s=7kkyZG5iYTA6pzxnKm2p4oMNw@mail.gmail.com>
Subject: Re: [GSoC RFC PATCH 4/5] repo-info: add field layout.bare
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>, git@vger.kernel.org
Cc: ps@pks.im
Content-Type: multipart/mixed; boundary="000000000000af816306374b947e"

--000000000000af816306374b947e
Content-Type: text/plain; charset="UTF-8"

Lucas Seiki Oshiro <lucasseikioshiro@gmail.com> writes:

> Add the field layout.bare to the repo-info command. The data
> retrieved in this field is the same that currently is obtained by
> running `git rev-parse --is-bare-repository`.
>
> Mentored-by: Karthik Nayak <karthik.188@gmail.com>
> Mentored-by Patrick Steinhardt <ps@pks.im>
> Signed-off-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
> ---
>  builtin/repo-info.c  | 35 ++++++++++++++++++++++++++++++++++-
>  t/t1518-repo-info.sh | 12 ++++++++++--
>  2 files changed, 44 insertions(+), 3 deletions(-)
>
> diff --git a/builtin/repo-info.c b/builtin/repo-info.c
> index a1c9d3942e..bc25a0809f 100644
> --- a/builtin/repo-info.c
> +++ b/builtin/repo-info.c
> @@ -1,4 +1,7 @@
> +#define USE_THE_REPOSITORY_VARIABLE
> +

Ah! Seems like `is_bare_repository()` is responsible for this, it would
be nice to not introduce global dependency in a new command, but this
isn't part of your project, so it's okay here.

>  #include "builtin.h"
> +#include "environment.h"
>  #include "hash.h"
>  #include "json-writer.h"
>  #include "parse-options.h"
> @@ -10,17 +13,22 @@ enum output_format {
>  };
>
>  enum repo_info_category {
> -	CATEGORY_REFERENCES = 1
> +	CATEGORY_REFERENCES = 1,
> +	CATEGORY_LAYOUT = 1 << 1

Style: If we're doing this, then it also makes sense to use `1 << 0`.

>  };
>
>  enum repo_info_references_field {
>  	FIELD_REFERENCES_FORMAT = 1
>  };
>
> +enum repo_info_layout_field { FIELD_LAYOUT_BARE = 1
> +};
> +

Style: let's keep the styling consistent with the previous block.

[snip]

--000000000000af816306374b947e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 2d6451e415589aa3_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1oSmdQMFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mOGtDQy85SDRjNDVZY0VKNm81Q2F6eGU2WmluK3BTTgpwNytLM2dNN0tk
WDd3ZXk3S0tPUTJOUWV0K3o3OFFqVGxOZmdpcjdxd3cvOXFqNmZJbzJjME55RC9NSzk5MlF0CmZG
bXdIYlZYUTY3cm5pTVQ2MEQ2R2lQMU9wUkR2RW9ZeVJqVkJ0RFFRREdwbUxGUHhkZmc5ZWdwbWtz
dDV4MkEKZlYrYkN0S1dXUUFtNGZ0SjI1Y3RxK2lPWEl2YmRKU25uZTljQjZiUDhZdXdrd0NnNUJW
R2ZrdU5zc3hQemxGcgphYUMwdVk3YVBWb2hwZFgzbzBiM1p1ZzErZmdGM1kvc0p0citzKytFZExB
d2x2cUZLbUxlN2dtWENUWDZwZTM1Cm4yS2dwZVJ6MzVPSE1uK2FKdlcvU0hzbXNUSkhTajhreHdv
ZUVFZEY5K1NRcHV5YlpsQkxQVWdaMlB5cmkyWFUKNmVVbVFwQnhrN3ZYaitTNE02RXgrb1YySFdX
ZzVkUUFFaStIeFZDeVd0cTJOZWZTM3YrRHFtRFc1RTRRdzJOMApueUhZNnE3MUdHOS9BbllTcllW
U3JaL29BVE5VQ2VudEhDemJZK2k1RDYzd25URXVjYU42VzhYdGt1R1kzT0VsCm1Kcy9MMHRmeDZw
TlRDYWtibm4xeDc4NVJXMkkyUXlpViszSDlVMD0KPUdRRHgKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000af816306374b947e--

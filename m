Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F1D111B0
	for <git@vger.kernel.org>; Wed, 14 Feb 2024 07:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707895233; cv=none; b=uXMs0vKX35f7ksxZuBJEiv7daakuP3zjPr2QpzuP1NN93O3CErKIGpMzHETlcL24ajFIlbDs8XgO3Df/gLum7URMe2dVrinP2tnXos5r5UHgbTOxKueBSY0tvP781FQDa0jjQq3TXRoKf/9J6lCzTfNYXH95Pt03/R0rCqKFiFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707895233; c=relaxed/simple;
	bh=9yYHFnE5KD2+9IE4UTS6DjwA5iFUhVnVIPiWM7Apr0M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=twlDVVpmZVThZvdg21x+h+sJcLLjr5Erfsn3EXJEcJBhzseoLG7wTLwkyXEjCt8Td3H039GWSG6pLRxSnEcauT5Sp0An2SAmQMZRBCunRAZB7+3KywslOCzbgiM4ckVUyLvGl+ROkXoQWjL6K4XbKQuTK2fOaa1CJc0Sn3UyL/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3xaomb4V; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3xaomb4V"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-295b119823aso4169094a91.1
        for <git@vger.kernel.org>; Tue, 13 Feb 2024 23:20:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707895231; x=1708500031; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=v1p/clRGWvNt8bNYO6d1P2nK0ustUtme0X29VEyNSxw=;
        b=3xaomb4V/eeA1XSzQI7KHHqGkx+gCR2LSoTfGRVdBoyf1cqBR7evDCYARayCFkjtWT
         NQEG9VfZcIPsz2t66WYIdlDK1Rih46cD5c2inRSk4CkwUIhmR4iJ9GKzweoRgijxFge0
         8Qm3hjffWXoa00Vd+9fmU/xEoEqjyHn8Fz2oPcF6gPDRoXzkw97HjdJwej+FiFBnGRbM
         M43YQ2W7ZcVzsN6Ol813OE166kLfcdccMV/sP9oVtpPVz+sYkQEqes7sE9mFg9vqbDG2
         h31PpfTcZ99ruEyFIA1LFMUsLEXHqgqDMewvos5Z5zGwLZOIXEj8oXsUw+IZXvhPWhtF
         R9zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707895231; x=1708500031;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v1p/clRGWvNt8bNYO6d1P2nK0ustUtme0X29VEyNSxw=;
        b=vJ3zM7le9RltR+Xy77b4cIxCknamMHck/Q5oIQsfM+hwdZyZjgdSMXjJWACUCjZPB4
         BEUJk/oIdRs4qAMrQlZ3IgCeEx6TEQU2fFMsSc9GedNk6PqOgwlSvFVnPtytpQT2+MWf
         0ej7f5QJfbhBqLwbMflC0WwbcNmwxR4YSLjQpcvodtcY+bNH/GOUiG4vc6KbnqsbQLXw
         SuPGufW8F7K3P14sFgfPbmHVpAw77PGgyfFsLBQ0Mwjkqn0x5caFL85WWmL2P6rktNmm
         bPW92e0OHaaFTglgJ4A9CJ0boKpksvvd3RbYOxhdigrZkhFH5GqvAERFt/jxZecx3oFm
         kAjw==
X-Gm-Message-State: AOJu0Yw3B6zfNDrWV+XOzglkG8ZEzftiLgkBN9hiyqkku+ErO5iJbnv3
	NeI+qxU/6IArq4qCGCiST8ZZE3XbWcKP/iHKqnr7Y2iiWDHB977JJ89hb4b/nvNfFx2/hOclDXb
	oJg==
X-Google-Smtp-Source: AGHT+IE6UYgPrT/7vpSIl096mUDNEnig+9gu2uke5wGws1xQ21Wrc7LnbGkoY8eV2aBh15li78Q/PYrDbpg=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a17:902:c948:b0:1d9:7ebe:ef7 with SMTP id
 i8-20020a170902c94800b001d97ebe0ef7mr19279pla.1.1707895231100; Tue, 13 Feb
 2024 23:20:31 -0800 (PST)
Date: Tue, 13 Feb 2024 23:20:29 -0800
In-Reply-To: <20231002024034.2611-5-ebiederm@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <878r8l929e.fsf@gmail.froward.int.ebiederm.org> <20231002024034.2611-5-ebiederm@gmail.com>
Message-ID: <owlybk8ja4w2.fsf@fine.c.googlers.com>
Subject: Re: [PATCH v2 05/30] loose: add a mapping between SHA-1 and SHA-256
 for loose objects
From: Linus Arver <linusa@google.com>
To: "Eric W. Biederman" <ebiederm@gmail.com>, Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, "brian m. carlson" <sandals@crustytoothpaste.net>, 
	Eric Sunshine <sunshine@sunshineco.com>, "Eric W. Biederman" <ebiederm@xmission.com>
Content-Type: text/plain; charset="UTF-8"

"Eric W. Biederman" <ebiederm@gmail.com> writes:

> From: "brian m. carlson" <sandals@crustytoothpaste.net>
>
> As part of the transition plan, we'd like to add a file in the .git
> directory that maps loose objects between SHA-1 and SHA-256.  Let's
> implement the specification in the transition plan and store this data
> on a per-repository basis in struct repository.

Could you explain a bit what the specification is, exactly? That would
save reviewers the trouble of comparing the large chunk of new code here
with the transition plan (which I assume is still
Documentation/technical/hash-function-transition.txt.

Also, are there any slight deviations from the specification for reasons
that may not be obvious to reviewers?

I would prefer if this patch is split up into smaller preparatory
patches, starting with the core essentials and then building it up
piece-by-piece to make it easier to review.

> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
> ---
>  Makefile              |   1 +
>  loose.c               | 246 ++++++++++++++++++++++++++++++++++++++++++
>  loose.h               |  22 ++++
>  object-file-convert.c |  14 ++-
>  object-store-ll.h     |   3 +
>  object.c              |   2 +
>  repository.c          |   6 ++
>  7 files changed, 293 insertions(+), 1 deletion(-)
>  create mode 100644 loose.c
>  create mode 100644 loose.h
>
> diff --git a/Makefile b/Makefile
> index f7e824f25cda..3c18664def9a 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1053,6 +1053,7 @@ LIB_OBJS += list-objects-filter.o
>  LIB_OBJS += list-objects.o
>  LIB_OBJS += lockfile.o
>  LIB_OBJS += log-tree.o
> +LIB_OBJS += loose.o

The name "loose" appears to be a bit too generic for something with such
a specialized role (_mapping_ of loose objects). Would
"loose-object-map" be a better name?

>  LIB_OBJS += ls-refs.o
>  LIB_OBJS += mailinfo.o
>  LIB_OBJS += mailmap.o
> diff --git a/loose.c b/loose.c
> new file mode 100644
> index 000000000000..6ba73cc84dca
> --- /dev/null
> +++ b/loose.c
> @@ -0,0 +1,246 @@
> +#include "git-compat-util.h"
> +#include "hash.h"
> +#include "path.h"
> +#include "object-store.h"
> +#include "hex.h"
> +#include "wrapper.h"
> +#include "gettext.h"
> +#include "loose.h"
> +#include "lockfile.h"
> +
> +static const char *loose_object_header = "# loose-object-idx\n";

IDK what the "loose-object-idx" is vs the "loose-object-map", but I
guess I need to read more of the code.

But also, I am at my limits here and am unable to review this patch as
is (too big for me to chew at once, sorry).

I'll pause my review of this series here to give Eric B some time to
respond. Thanks.

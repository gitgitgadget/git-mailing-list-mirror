Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F59718B0A
	for <git@vger.kernel.org>; Sun, 23 Nov 2025 02:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763864426; cv=none; b=EDLuZPUZ00g3m6zYlxkeIE7A4jZjI7RKRJhuwNJClPohz0Rbva32keGqujohcZBsrHuvUjqai7MBYOsKRayRsl5zfKCRZVvW/izQEqxGl8BxA2M345FQOXsRPQfE3XH6L1fgaf5NFPuaXj+sDIfA9aH8Vpj6ZDFHGn6ql3HoY94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763864426; c=relaxed/simple;
	bh=i2GNGSmuhBSJflzF8phKVqgc3Pz8/O8aJ1rfu+FfFgE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=E941GGT+It5wB4hsY7TtFUPIxxwvvVWsvFO4x5BxBCobXvOalkMT/Li8Gg7o936U9w1AHVwVRgpsGjoOaB2ur3IeU2HS2R81AOerm9nnm+/FIKjtRR3TV7Im3VhsqZZAL1Ea3N800B3UnJqn+x4v9mvEtnPyJ1MVYuyOo8QFloE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=LVt0ITAP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DCks+euY; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="LVt0ITAP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DCks+euY"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 192F4EC00A2;
	Sat, 22 Nov 2025 21:20:22 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Sat, 22 Nov 2025 21:20:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1763864422; x=1763950822; bh=PzDt7a4BmL
	gyA4WSoejDjbOk/53Be7xvOPQmmWHo1HA=; b=LVt0ITAPiY62n6H26G6SaDBmD7
	Ox1HArXKPDrq07r/dFJNXeABuzBVk0Bxsn7io+xaVb1uW/jb0vN6oQ+vmc0O9L0O
	lHLXq5kyl5yPQZn5lwKxuTSjPRVJvswO8eX3NQK+6wswuS84HM4g8N3InKNHz1oD
	0HKUnO8BLZl09SQprjA0u1MMeN9vV6QEHUWGLJWPJyz3XXES+/erLuK+fgBrynXA
	AjXA9XCjpEzgVbCb5n9YBZbzHarHsCLzl1zCCshQ0nVr5TT91bU51A7uQFcybvjb
	oKYMnjYBMjshEFinyxU3z6QOMXAGZhIy5UuUSXQvQ5llQQucAm5431uRHJlg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1763864422; x=1763950822; bh=PzDt7a4BmLgyA4WSoejDjbOk/53Be7xvOPQ
	mmWHo1HA=; b=DCks+euYqeHazdBZRIqdOJubiYNwHVexXFZqtt5UYe08Ey6fhZ6
	irJ3WuCdrYqR2IFwB3m+MSsElvnsFZX8Zub71B/kvNsJWw5Ckp1TjOJHU+Y5sX8e
	Gt7Dy5hSHwwkerkYtUUlig+toTwQy6I4TumDsIfhvYJX/DX2wY4CC9Aq0Hnav2C6
	znM7FGT8pbbPn/u35spo1khMp0c0tFu0zcY8k6z+b67F5/iOIvuX6nVShYp7USOP
	VdRiNwO7MG7dCyY1nxFML1ppoEF/un4xH7Nx/oZoFvcmqMMUwQRYYD8uQuIyxKyc
	PGUhHEMEz5ZHkHFMVYnPLNzDgkuklI+VbZw==
X-ME-Sender: <xms:ZW8iaYTkSNWR1MIV-iwQooxHN530hQiLj8T2e5HXbD2TjX3cy1A3eg>
    <xme:ZW8iacrKNIqFLDadKSa3FkJ79p-6w0RblpKLjXf1z8KaLn66kR3ekCdbdtUXK5vzb
    OkETsRAXi2Z7sGlNGIO_0p7c8VaDdQCPnG0RcVk8IKtKEBbnyrURME>
X-ME-Received: <xmr:ZW8iaeJm9gel6z-lkBj5l35IjpFzJp1YRd8occBOuFK7ciya9w5aiagDYIwGWj7CA8_RontlU6DECN7QP2GqDMp6_PgHQc-8sDte>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvfeegheduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgrrhhthhhikhdrudekkees
    ghhmrghilhdrtghomhdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:ZW8iaXoEUh5Eob_XSBZgdJGnQgtvkc_e0Uw6oy7ERUcwVU4YA7O2ng>
    <xmx:ZW8iaexAf7paeZSk39mTiqz3gaFceqZ7y8qkrogzrq4GtW7_4sMXZg>
    <xmx:ZW8iaTMGD0KHVOClzjUyEnXJ6DMnDBIVexCeAPkOpPWzwRjl7UXErQ>
    <xmx:ZW8iab69NOf9mVTe4Wb2FXgYxaVl30oYujqoHv2Ga_UcCzbHPjzQkA>
    <xmx:Zm8iaS4Du63cqXxALEMzr53Z1Ek19I4LCrzg0v3Y1AE1KA0d59H_dKWc>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 22 Nov 2025 21:20:21 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Karthik Nayak <karthik.188@gmail.com>,  Justin
 Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v2 18/19] streaming: move into object database subsystem
In-Reply-To: <20251121-b4-pks-odb-read-stream-v2-18-ca8534963150@pks.im>
	(Patrick Steinhardt's message of "Fri, 21 Nov 2025 08:41:03 +0100")
References: <20251121-b4-pks-odb-read-stream-v2-0-ca8534963150@pks.im>
	<20251121-b4-pks-odb-read-stream-v2-18-ca8534963150@pks.im>
Date: Sat, 22 Nov 2025 18:20:20 -0800
Message-ID: <xmqq5xb132xn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> The "streaming" terminology is somewhat generic, so it may not be
> immediately obvious that "streaming.{c,h}" is specific to the object
> database. Rectify this by moving it into the "odb/" directory so that it
> can be immediately attributed to the object subsystem.

I do not have an objection against this move.  Looking good.

>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  Makefile                       | 2 +-
>  archive-tar.c                  | 2 +-
>  archive-zip.c                  | 2 +-
>  builtin/cat-file.c             | 2 +-
>  builtin/fsck.c                 | 2 +-
>  builtin/index-pack.c           | 2 +-
>  builtin/log.c                  | 2 +-
>  builtin/pack-objects.c         | 2 +-
>  entry.c                        | 2 +-
>  meson.build                    | 2 +-
>  object-file.c                  | 2 +-
>  streaming.c => odb/streaming.c | 2 +-
>  streaming.h => odb/streaming.h | 0
>  packfile.c                     | 2 +-
>  parallel-checkout.c            | 2 +-
>  15 files changed, 14 insertions(+), 14 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index 7e0f77e298..6d8dcc4622 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1201,6 +1201,7 @@ LIB_OBJS += object-file.o
>  LIB_OBJS += object-name.o
>  LIB_OBJS += object.o
>  LIB_OBJS += odb.o
> +LIB_OBJS += odb/streaming.o
>  LIB_OBJS += oid-array.o
>  LIB_OBJS += oidmap.o
>  LIB_OBJS += oidset.o
> @@ -1294,7 +1295,6 @@ LIB_OBJS += split-index.o
>  LIB_OBJS += stable-qsort.o
>  LIB_OBJS += statinfo.o
>  LIB_OBJS += strbuf.o
> -LIB_OBJS += streaming.o
>  LIB_OBJS += string-list.o
>  LIB_OBJS += strmap.o
>  LIB_OBJS += strvec.o
> diff --git a/archive-tar.c b/archive-tar.c
> index 4133e09ca1..74499c311f 100644
> --- a/archive-tar.c
> +++ b/archive-tar.c
> @@ -12,8 +12,8 @@
>  #include "tar.h"
>  #include "archive.h"
>  #include "odb.h"
> +#include "odb/streaming.h"
>  #include "strbuf.h"
> -#include "streaming.h"
>  #include "run-command.h"
>  #include "write-or-die.h"
>  
> diff --git a/archive-zip.c b/archive-zip.c
> index ff57f4f884..2b645f28ef 100644
> --- a/archive-zip.c
> +++ b/archive-zip.c
> @@ -10,9 +10,9 @@
>  #include "gettext.h"
>  #include "git-zlib.h"
>  #include "hex.h"
> -#include "streaming.h"
>  #include "utf8.h"
>  #include "odb.h"
> +#include "odb/streaming.h"
>  #include "strbuf.h"
>  #include "userdiff.h"
>  #include "write-or-die.h"
> diff --git a/builtin/cat-file.c b/builtin/cat-file.c
> index 120d626d66..505ddaa12f 100644
> --- a/builtin/cat-file.c
> +++ b/builtin/cat-file.c
> @@ -18,13 +18,13 @@
>  #include "list-objects-filter-options.h"
>  #include "parse-options.h"
>  #include "userdiff.h"
> -#include "streaming.h"
>  #include "oid-array.h"
>  #include "packfile.h"
>  #include "pack-bitmap.h"
>  #include "object-file.h"
>  #include "object-name.h"
>  #include "odb.h"
> +#include "odb/streaming.h"
>  #include "replace-object.h"
>  #include "promisor-remote.h"
>  #include "mailmap.h"
> diff --git a/builtin/fsck.c b/builtin/fsck.c
> index 1a348d43c2..c7d2eea287 100644
> --- a/builtin/fsck.c
> +++ b/builtin/fsck.c
> @@ -13,11 +13,11 @@
>  #include "fsck.h"
>  #include "parse-options.h"
>  #include "progress.h"
> -#include "streaming.h"
>  #include "packfile.h"
>  #include "object-file.h"
>  #include "object-name.h"
>  #include "odb.h"
> +#include "odb/streaming.h"
>  #include "path.h"
>  #include "read-cache-ll.h"
>  #include "replace-object.h"
> diff --git a/builtin/index-pack.c b/builtin/index-pack.c
> index 67221dbe6a..6403edd3a6 100644
> --- a/builtin/index-pack.c
> +++ b/builtin/index-pack.c
> @@ -16,12 +16,12 @@
>  #include "progress.h"
>  #include "fsck.h"
>  #include "strbuf.h"
> -#include "streaming.h"
>  #include "thread-utils.h"
>  #include "packfile.h"
>  #include "pack-revindex.h"
>  #include "object-file.h"
>  #include "odb.h"
> +#include "odb/streaming.h"
>  #include "oid-array.h"
>  #include "oidset.h"
>  #include "path.h"
> diff --git a/builtin/log.c b/builtin/log.c
> index e7b83a6e00..d4cf9c59c8 100644
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -16,6 +16,7 @@
>  #include "refs.h"
>  #include "object-name.h"
>  #include "odb.h"
> +#include "odb/streaming.h"
>  #include "pager.h"
>  #include "color.h"
>  #include "commit.h"
> @@ -35,7 +36,6 @@
>  #include "parse-options.h"
>  #include "line-log.h"
>  #include "branch.h"
> -#include "streaming.h"
>  #include "version.h"
>  #include "mailmap.h"
>  #include "progress.h"
> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> index adf267c59d..f6c01bc4e0 100644
> --- a/builtin/pack-objects.c
> +++ b/builtin/pack-objects.c
> @@ -22,7 +22,6 @@
>  #include "pack-objects.h"
>  #include "progress.h"
>  #include "refs.h"
> -#include "streaming.h"
>  #include "thread-utils.h"
>  #include "pack-bitmap.h"
>  #include "delta-islands.h"
> @@ -33,6 +32,7 @@
>  #include "packfile.h"
>  #include "object-file.h"
>  #include "odb.h"
> +#include "odb/streaming.h"
>  #include "replace-object.h"
>  #include "dir.h"
>  #include "midx.h"
> diff --git a/entry.c b/entry.c
> index 38dfe670f7..7817aee362 100644
> --- a/entry.c
> +++ b/entry.c
> @@ -2,13 +2,13 @@
>  
>  #include "git-compat-util.h"
>  #include "odb.h"
> +#include "odb/streaming.h"
>  #include "dir.h"
>  #include "environment.h"
>  #include "gettext.h"
>  #include "hex.h"
>  #include "name-hash.h"
>  #include "sparse-index.h"
> -#include "streaming.h"
>  #include "submodule.h"
>  #include "symlinks.h"
>  #include "progress.h"
> diff --git a/meson.build b/meson.build
> index 1f95a06edb..fc82929b37 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -397,6 +397,7 @@ libgit_sources = [
>    'object-name.c',
>    'object.c',
>    'odb.c',
> +  'odb/streaming.c',
>    'oid-array.c',
>    'oidmap.c',
>    'oidset.c',
> @@ -490,7 +491,6 @@ libgit_sources = [
>    'stable-qsort.c',
>    'statinfo.c',
>    'strbuf.c',
> -  'streaming.c',
>    'string-list.c',
>    'strmap.c',
>    'strvec.c',
> diff --git a/object-file.c b/object-file.c
> index c6d2f2d953..4b46cf5b71 100644
> --- a/object-file.c
> +++ b/object-file.c
> @@ -20,13 +20,13 @@
>  #include "object-file-convert.h"
>  #include "object-file.h"
>  #include "odb.h"
> +#include "odb/streaming.h"
>  #include "oidtree.h"
>  #include "pack.h"
>  #include "packfile.h"
>  #include "path.h"
>  #include "read-cache-ll.h"
>  #include "setup.h"
> -#include "streaming.h"
>  #include "tempfile.h"
>  #include "tmp-objdir.h"
>  
> diff --git a/streaming.c b/odb/streaming.c
> similarity index 99%
> rename from streaming.c
> rename to odb/streaming.c
> index 3ac1a0c40f..a7ee50dc34 100644
> --- a/streaming.c
> +++ b/odb/streaming.c
> @@ -5,10 +5,10 @@
>  #include "git-compat-util.h"
>  #include "convert.h"
>  #include "environment.h"
> -#include "streaming.h"
>  #include "repository.h"
>  #include "object-file.h"
>  #include "odb.h"
> +#include "odb/streaming.h"
>  #include "replace-object.h"
>  #include "packfile.h"
>  
> diff --git a/streaming.h b/odb/streaming.h
> similarity index 100%
> rename from streaming.h
> rename to odb/streaming.h
> diff --git a/packfile.c b/packfile.c
> index ad56ce0b90..7a16aaa90d 100644
> --- a/packfile.c
> +++ b/packfile.c
> @@ -20,7 +20,7 @@
>  #include "tree.h"
>  #include "object-file.h"
>  #include "odb.h"
> -#include "streaming.h"
> +#include "odb/streaming.h"
>  #include "midx.h"
>  #include "commit-graph.h"
>  #include "pack-revindex.h"
> diff --git a/parallel-checkout.c b/parallel-checkout.c
> index 1cb6701b92..0bf4bd6d4a 100644
> --- a/parallel-checkout.c
> +++ b/parallel-checkout.c
> @@ -13,7 +13,7 @@
>  #include "read-cache-ll.h"
>  #include "run-command.h"
>  #include "sigchain.h"
> -#include "streaming.h"
> +#include "odb/streaming.h"
>  #include "symlinks.h"
>  #include "thread-utils.h"
>  #include "trace2.h"

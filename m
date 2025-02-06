Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4BC2224B02
	for <git@vger.kernel.org>; Thu,  6 Feb 2025 07:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738828344; cv=none; b=VDGaM/M4iTSSfj5no8d1fBgroimuWc8hglIwwj40xJMduQQXuTdCZ91qJ+d0hW/9ZtvVkoLDnrutayLkMR8pP8z9vf0kN2jNMSXmQyUhhxQYcTh8WUnUamKkC9Pyd4Ua8G+jHpqteI4tyzfzEx3Ob70H+r5IoH1EsKhJhNdOmjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738828344; c=relaxed/simple;
	bh=HCRNw/p70SgzoMLjt8sQWMhgcQbVzmopKuwG8JkKAaU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=DDlRvxWiySGSG5YbeJkUYbrPzjbgDwolnbR3NaPYvspv/rIS2Gvas8UHQBMLxtNeFprEMuQucPxhOy04p+SOhm6WQ6V3nOJIO7g7nxZASCqw063Bh6yfWRB0OtyyrbmRuKpwI0B13kc46FeQaqmip5h6AbvrfkMlLL7o1biuBfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=R6XL1kV3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uK448AFQ; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="R6XL1kV3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uK448AFQ"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9B2381140105;
	Thu,  6 Feb 2025 02:52:20 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Thu, 06 Feb 2025 02:52:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1738828340;
	 x=1738914740; bh=kKtVl/cFKzY26k00miSe7fT3DUr60ywm+n1z5zGYnvg=; b=
	R6XL1kV34zNDFcJr143XKllxJafpjaIg8qeVpa9sbt4AochMkqI+l2S9EizvQFM5
	KFaE8M0Jnn2S+QzsiRHlzVgxxphR4YoHgET13zC/wUHvAVb8Pf/TRrQx6IeE5fjI
	4myvPglytawIn40FkgwUqNXQTDyMpZ+UAkdLIqCgtQQIG+wnEPGXTsRi4W4yoYuM
	6+xM+jGOw2MEPgpe8q68hx/Vz4Zbh2Haip+ph0OaOY11cJ7gGlpM9+c6eXjTBVId
	uh7OVZ4t76bTIblOwLfArX6FRfRM/+DiFwTuJczP1DGnJ+MqAjmwRR1cH/PKzn/d
	B0lERkajH/IHe/ZleT/6TA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738828340; x=
	1738914740; bh=kKtVl/cFKzY26k00miSe7fT3DUr60ywm+n1z5zGYnvg=; b=u
	K448AFQYhMNxptHvqEwhLoxuWqystdFqeBe/kFbgSqzTP3W1yPQspUWKYNP/OWbD
	vyj1NMoGzIQBACRTTIbtTptI/7iQeuT/J8E7jVkjKHjcq/IymWV9lrhVSDqQaZZI
	Ztfd6DjKZ/I3A+l/L5ZNtHVbsGJ8fpMEKeIvlpTOc+jtP774wLnR3egnJBFBdl9B
	85vfycvlsztodTt8M9C4UETX1u3UGjs0UAzy8q+xRdVE4xJQl7wL4/xxX9eT40nS
	UHYv3/MDk76LV8KBkxw9z+Fn172xEImSMo1HMJoiBgxrwkrUC9ozAYuu9/ZCn119
	OdiOp45zAgWISvRvUh61w==
X-ME-Sender: <xms:NGqkZ_M_Yq2BAFFEaHbjZwiq-n_W7hqdMPfjlJuS01BODZGgfr2Brw>
    <xme:NGqkZ5-oQw57N369ZseIKtkHV1EkVxslHA-q6oIHx2WcY4LhmJkBzwTjhdPOaIoC6
    YJbTCubzmyovC6_nA>
X-ME-Received: <xmr:NGqkZ-T9QSj3JUU_X8p4avOYlTun-wHQDx78ntYRZTW9BODAZI6DleD4ZgKwPn6HpQzdU7eDa1W29rqB2kKOQ3OxkNBCbSkQ33xjuA7uPYfT>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvheekfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhufffkfggtgfgjghfvfevofesthejredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhephefgleekkeefhfeftefhgfeifeegkedvvdfgjeeu
    hefgueejffdujeeuleeikeehnecuffhomhgrihhnpehgohhoghhlvgdrtghomhdpkhgvrh
    hnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhf
    rhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtph
    houhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthho
    pegvthhhohhmshhonhesvggufigrrhguthhhohhmshhonhdrtghomhdprhgtphhtthhope
    hjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdr
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepjheitheskhgusghgrdhorhhg
X-ME-Proxy: <xmx:NGqkZzteR3n8ttl0TMmd5a1XBzkI_O4IytgGt0qBc_ciJJmUIctJrg>
    <xmx:NGqkZ3flswbaOSEYHD76kZfLoFD5vKL51JVGQvUwKra0zXho4ZRf5A>
    <xmx:NGqkZ_05XLd1TX2xacvCGgT6gtPGgi7hyTXAxr_JXMb-wyooVE-Fiw>
    <xmx:NGqkZz-QNzzbogJk5nx8AZceyxrm5FWs1gO-XSeDcytgwYEHXf44UA>
    <xmx:NGqkZ4FquLGiLGQ6ix0tspJlT1nRjRN4v1PEAJOFcVD2kxyvgZR_iCjJ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Feb 2025 02:52:19 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id be879001 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 6 Feb 2025 07:52:14 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v4 00/18] reftable: stop using "git-compat-util.h"
Date: Thu, 06 Feb 2025 08:52:02 +0100
Message-Id: <20250206-pks-reftable-drop-git-compat-util-v4-0-603d276d5f95@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACNqpGcC/43OwW7CMAwG4FdBOc8ocdK05bT3QBxK6oI1oF0Sq
 k2o744LEmy3Hn87+X7fVKLIlNRmdVORRk7cXyS4j5UKx+ZyIOBWskKNzhhTw/CVIFKXm/2JoI3
 9AAfOEPrz0GS4Zj6BK3WH+66lwqMSZ5Dn/PPo2O6eOdL3Varye3jklPv4+7hjNPN0riy0wXJB5
 WhAgyesdFN4V5Xlp/xZ81nN9Ih/uWoJh8KFqgiorfXW/Ofsm5P9Es4K55wPNbWOqKYXN03THXo
 6e1+CAQAA
X-Change-ID: 20241119-pks-reftable-drop-git-compat-util-470f2bfde562
In-Reply-To: <20250127-pks-reftable-drop-git-compat-util-v1-0-6e280a564877@pks.im>
References: <20250127-pks-reftable-drop-git-compat-util-v1-0-6e280a564877@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>, 
 Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
 Johannes Sixt <j6t@kdbg.org>
X-Mailer: b4 0.14.2

Hi,

this patch series is the final step to fully decouple the reftable
library from the rest of the Git codebase. The goal of this is to make
the library reusable by other projects like libgit2 by simply copying
over the source files, making Git the canonical upstream for reftable
functionality.

This patch series stops using all kinds of helpers exposed by our
"git-compat-util.h" header and open-codes them instead. In order to keep
us from using these helpers by accident the final step is to pull out
POSIX-related bits and pieces into a new "compat/posix.h" header, which
the reftable library then uses instead of "git-compat-util.h".

The series is built on top of master at 5f8f7081f7 (The third batch,
2025-01-23) with ps/reftable-sign-compare at 33319b0976 (reftable:
address trivial -Wsign-compare warnings, 2025-01-20) merged into it.
There is a trivial merge conflict with ps/zlib-ng that can be solved
like this:

    diff --cc reftable/system.h
    index e4a8944a70,d02eacea8f..0000000000
    --- a/reftable/system.h
    +++ b/reftable/system.h
    @@@ -11,15 -11,9 +11,15 @@@ https://developers.google.com/open-sour
      
      /* This header glues the reftable library to the rest of Git */
      
     -#include "git-compat-util.h"
     +#include "compat/posix.h"
    - #include <zlib.h>
    + #include "compat/zlib-compat.h"
      
     +/*
     + * Return a random 32 bit integer. This function is expected to return
     + * pre-seeded data.
     + */
     +uint32_t reftable_rand(void);
     +
      /*
       * An implementation-specific temporary file. By making this specific to the
       * implementation it becomes possible to tie temporary files into any kind of

Changes in v2:
  - The splitup of Windows headers has broken compilation because some
    of the headers couldn't be found anymore. I've fixed this more
    generally by converting includes in "compat/" to always be relative
    to the project source directory, dropping the platform-specific
    `-Icompat/` include.
  - Explain why we don't port over `EWOULDBLOCK` handling.
  - Fix commit message typos.
  - Link to v1: https://lore.kernel.org/r/20250127-pks-reftable-drop-git-compat-util-v1-0-6e280a564877@pks.im

Changes in v3:
  - Fix type of `total_read` variable used to track how many bytes we
    have read in `fd_read_lines()`.
  - Drop the patch use root-relative includes again. Let's rather
    discuss this outside of the scope of this series.
  - Link to v2: https://lore.kernel.org/r/20250128-pks-reftable-drop-git-compat-util-v2-0-c85c20336317@pks.im

Changes in v4:
  - Fix a couple of now-invalid relative includes that I missed. This
    fixes the build issue in "seen" with Meson.
  - Link to v3: https://lore.kernel.org/r/20250203-pks-reftable-drop-git-compat-util-v3-0-446c9ed4ee9e@pks.im

Thanks!

Patrick

---
Patrick Steinhardt (18):
      reftable/stack: stop using `read_in_full()`
      reftable/stack: stop using `write_in_full()`
      reftable/blocksource: stop using `xmmap()`
      reftable/record: stop using `COPY_ARRAY()`
      reftable/record: stop using `BUG()` in `reftable_record_init()`
      reftable/record: don't `BUG()` in `reftable_record_cmp()`
      reftable: stop using `BUG()` in trivial cases
      reftable/basics: stop using `st_mult()` in array allocators
      reftable/basics: provide wrappers for big endian conversion
      reftable/reader: stop using `ARRAY_SIZE()` macro
      reftable/system: introduce `reftable_rand()`
      reftable/stack: stop using `sleep_millisec()`
      reftable/basics: stop using `SWAP()` macro
      reftable/basics: stop using `UNUSED` annotation
      compat/mingw: split out POSIX-related bits
      git-compat-util.h: split out POSIX-emulating bits
      reftable: decouple from Git codebase by pulling in "compat/posix.h"
      Makefile: skip reftable library for Coccinelle

 Makefile                                |   2 +-
 compat/{mingw.c => mingw/compat-util.c} |  28 +-
 compat/mingw/compat-util.h              | 220 +++++++++++++
 compat/{mingw.h => mingw/posix.h}       | 216 +------------
 compat/msvc.c                           |   6 -
 compat/msvc/compat-util.c               |   6 +
 compat/msvc/compat-util.h               |   7 +
 compat/{msvc.h => msvc/posix.h}         |   8 +-
 compat/posix.h                          | 541 ++++++++++++++++++++++++++++++++
 config.mak.uname                        |   6 +-
 contrib/buildsystems/CMakeLists.txt     |   2 +-
 git-compat-util.h                       | 535 +------------------------------
 meson.build                             |   8 +-
 reftable/basics.c                       |  19 --
 reftable/basics.h                       | 123 +++++++-
 reftable/block.c                        |  16 +-
 reftable/blocksource.c                  |  21 +-
 reftable/iter.c                         |  20 +-
 reftable/merged.c                       |  27 +-
 reftable/pq.c                           |  40 ++-
 reftable/pq.h                           |   2 +-
 reftable/reader.c                       |  33 +-
 reftable/record.c                       | 109 ++++---
 reftable/record.h                       |   6 +-
 reftable/stack.c                        |  52 ++-
 reftable/system.c                       |   7 +
 reftable/system.h                       |   9 +-
 reftable/writer.c                       |  29 +-
 t/unit-tests/t-reftable-basics.c        |  28 +-
 t/unit-tests/t-reftable-pq.c            |  22 +-
 t/unit-tests/t-reftable-record.c        |  42 ++-
 31 files changed, 1242 insertions(+), 948 deletions(-)

Range-diff versus v3:

 1:  801e7bb30c =  1:  07f44927f1 reftable/stack: stop using `read_in_full()`
 2:  9b1b778a28 =  2:  c62404d62e reftable/stack: stop using `write_in_full()`
 3:  336b5ca3e1 =  3:  f936b06d4b reftable/blocksource: stop using `xmmap()`
 4:  ec74201d8d =  4:  ea203b9060 reftable/record: stop using `COPY_ARRAY()`
 5:  853740bd10 =  5:  c13aaeca16 reftable/record: stop using `BUG()` in `reftable_record_init()`
 6:  c6003aa731 =  6:  397b5321bf reftable/record: don't `BUG()` in `reftable_record_cmp()`
 7:  afbb02bdc7 =  7:  921d4ba9f0 reftable: stop using `BUG()` in trivial cases
 8:  fe34e5e425 =  8:  0c4396cc16 reftable/basics: stop using `st_mult()` in array allocators
 9:  405b6bdac7 =  9:  af50906b6d reftable/basics: provide wrappers for big endian conversion
10:  f0ca7a5f13 = 10:  1e931c747b reftable/reader: stop using `ARRAY_SIZE()` macro
11:  2e8152c509 = 11:  f66900df08 reftable/system: introduce `reftable_rand()`
12:  bdb708349d = 12:  99af9a50da reftable/stack: stop using `sleep_millisec()`
13:  6e59462638 = 13:  bdcd8744df reftable/basics: stop using `SWAP()` macro
14:  7c4e2eeb9b = 14:  41f637bd3f reftable/basics: stop using `UNUSED` annotation
15:  942eeca014 ! 15:  4dbbc71e11 compat/mingw: split out POSIX-related bits
    @@ Commit message
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
      ## compat/mingw.c => compat/mingw/compat-util.c ##
    +@@
    + #define USE_THE_REPOSITORY_VARIABLE
    + #define DISABLE_SIGN_COMPARE_WARNINGS
    + 
    +-#include "../git-compat-util.h"
    +-#include "win32.h"
    ++#include "../../git-compat-util.h"
    ++#include "../win32.h"
    + #include <aclapi.h>
    + #include <sddl.h>
    + #include <conio.h>
    + #include <wchar.h>
    +-#include "../strbuf.h"
    +-#include "../run-command.h"
    +-#include "../abspath.h"
    +-#include "../alloc.h"
    +-#include "win32/lazyload.h"
    +-#include "../config.h"
    +-#include "../environment.h"
    +-#include "../trace2.h"
    +-#include "../symlinks.h"
    +-#include "../wrapper.h"
    +-#include "dir.h"
    +-#include "gettext.h"
    ++#include "../../strbuf.h"
    ++#include "../../run-command.h"
    ++#include "../../abspath.h"
    ++#include "../../alloc.h"
    ++#include "../win32/lazyload.h"
    ++#include "../../config.h"
    ++#include "../../environment.h"
    ++#include "../../trace2.h"
    ++#include "../../symlinks.h"
    ++#include "../../wrapper.h"
    ++#include "../../dir.h"
    ++#include "../../gettext.h"
    + #define SECURITY_WIN32
    + #include <sspi.h>
    + 
     
      ## compat/mingw/compat-util.h (new) ##
     @@
    @@ compat/mingw/posix.h: char *mingw_query_user_email(void);
     -#endif
     +#endif /* COMPAT_MINGW_POSIX_H */
     
    - ## compat/msvc.c => compat/msvc/compat-util.c ##
    + ## compat/msvc.c (deleted) ##
     @@
    - #include <conio.h>
    - #include "../strbuf.h"
    - 
    +-#include "../git-compat-util.h"
    +-#include "win32.h"
    +-#include <conio.h>
    +-#include "../strbuf.h"
    +-
     -#include "mingw.c"
    -+#include "mingw/compat-util.c"
    +
    + ## compat/msvc/compat-util.c (new) ##
    +@@
    ++#include "../../git-compat-util.h"
    ++#include "../win32.h"
    ++#include <conio.h>
    ++#include "../../strbuf.h"
    ++
    ++#include "../mingw/compat-util.c"
     
      ## compat/msvc/compat-util.h (new) ##
     @@
16:  53151b2649 ! 16:  f0e9c6d3ee git-compat-util.h: split out POSIX-emulating bits
    @@ compat/posix.h (new)
     +#define HOST_NAME_MAX 256
     +#endif
     +
    -+#include "sane-ctype.h"
    ++#include "../sane-ctype.h"
     +
     +void git_stable_qsort(void *base, size_t nmemb, size_t size,
     +		      int(*compar)(const void *, const void *));
17:  b63a798513 = 17:  35a975dfe2 reftable: decouple from Git codebase by pulling in "compat/posix.h"
18:  f9edb54708 = 18:  1dde84b32c Makefile: skip reftable library for Coccinelle

---
base-commit: 8047765d092881ec4aef7dfc57772161eee7f0f5
change-id: 20241119-pks-reftable-drop-git-compat-util-470f2bfde562


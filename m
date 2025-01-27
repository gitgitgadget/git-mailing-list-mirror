Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 502064C8F
	for <git@vger.kernel.org>; Mon, 27 Jan 2025 13:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737983060; cv=none; b=JGdjDJ4OABBOk+/S/Aghm9BV5AX+INt6QXfvScxiEZtHQXUpElNgabJEgAbdmyfw1GdYXIxtux9lWKS6YDmv5mu+BM0Ll8lmWbnlISEmi+AaZwM4e0Zt5AIS/MMwxzYjwwtFj86hHNqbwuE7toOFUlK0x7WP+tDO1R5iM8vvy1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737983060; c=relaxed/simple;
	bh=O0J0k30ErqMTQq9VtOL9IoTXst5qUFULT+Hdf/34BBA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=GCjygt3wm9EwPX2suWdu9b/8iGX/ubQ2dBh5cGHJY/Hnk4J58rgxNQy8tNdjU+kxJCx9D7T5NnY7UqGOJeYboMHLi2EBYaMcVRrSye0lPQZJyK2v1X7I4iDxXVnsBzPSHj36pJyuMxb74++NMv/K7uDjqnS2IjNIzdPzGVJSF7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ezTqIs4F; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lunbaepi; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ezTqIs4F";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lunbaepi"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 450EF1380079;
	Mon, 27 Jan 2025 08:04:17 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 27 Jan 2025 08:04:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm3; t=1737983057; x=1738069457; bh=YA7belgwK6
	9PN7A5eVE0ubAV4ny5JO+4dEUfVLqGNXc=; b=ezTqIs4Ftqfo5gNjnXwNeI0QTI
	brhx3JrmdViO2HisuBl51GT80By/Aul+5Y0MtFC9h5WozCovvB2QPK/WvVcEoT3n
	l19inrYKImF0oSK1SfWGGRaPx25/WZYrvMmmwE7zNzylmIa59sz0PkKKP9MJPbQM
	vwMROVEF4ekr9rNYcvcmFknhW43RkBWRoDhXR+luVbBMKmbBOt0F9b1L57GgWkBW
	rQwf/2gAxsyQ5eEH7ALHL49HxelfPi+A/RwIJ3SheD8CA5d/xpiPOqfLUmitFdbx
	2BZlWVPzA5ubFQLgHwlqYDqYyj4x2nj2uob0LnlNkpKOS9W19F2QLjL0+8wA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1737983057; x=1738069457; bh=YA7belgwK69PN7A5eVE0ubAV4ny5
	JO+4dEUfVLqGNXc=; b=lunbaepihJL7oiC5rj75x8soS/YXxYS71PSGOGavcXNc
	RJwgUZRiACTSihqm5p1EVGOCz6ZEK2os2zbmucc5vkIMVrTS6Waa/ozGgdE/Iz+Z
	JFPRHqsHmFqDQrKJMegH2+An55s5D5ZVutVCPOVH0CDUjyQ3Nhaz6/33UeD5pPdw
	XrfucLJxKUkYGnJ97XQ1xX7fFnScFjfOesVaM2MT/RnTvLPtWNLcUITEq8jqPTx3
	dOeABFCVe3BSe7OHaPVq0QBUG1mx+oKBAnhmPvzkUHtuVy3b4CNuBsKNG/OQPT2Y
	H2CXtBCQkh63M+zeAmQ15orsUv3hHACE8TxMzxUNvw==
X-ME-Sender: <xms:UYSXZ39b5xUpP7g12rMu_-lY249_-XfSrnaiyK_1gohKveHLNc7coA>
    <xme:UYSXZzsrwPLFxutnU8LxBWmci-nJMKTjdN5hkOyPKzKc38wn0Xu-BsPR_-rtV2ymF
    cF6fbvk8xp0F6xBPg>
X-ME-Received: <xmr:UYSXZ1DCbf65VET30MHQovs_EiOApJm8NeszosMDTIuYOTJ-ZaAOFIK5qq5eHdYlu6t3Ut59oGM_IrEWYYihKDF-uQJ98ol8rClnK6V4QQxh>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejgedgudefvdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffufffkgggtgffvvefosehtjeertdertdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeehjeeugfduhfevfeeufffghfevueevuefhffefkeef
    gedtteejkefhueeiuddufeenucffohhmrghinhepghhoohhglhgvrdgtohhmnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhi
    mhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepgh
    hithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegvthhhohhmshhonhes
    vggufigrrhguthhhohhmshhonhdrtghomh
X-ME-Proxy: <xmx:UYSXZzcI87dG8FBujHhghNblqyZlLyYXemTvDIiERVNtTbj53Df68g>
    <xmx:UYSXZ8Ot0yynIjCt9eDLVoI08uJgJyjdq89DBOFX_DA1y9BYHJMaUg>
    <xmx:UYSXZ1nK6A4TcBpaVAe3j9KjTiOYY0ednI-lpHPaVX7K93Z8lvRCMg>
    <xmx:UYSXZ2uvk6n1WHt-sMal2we8HTR6V2RSlxoNr4LD7LZdmRyoZo37lg>
    <xmx:UYSXZ1aQLzeXpkx7UuRuTYHv6PDSYt_xlEjPnj4psxi55NJ8Qfyx4ZX5>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Jan 2025 08:04:16 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 04d428c1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 27 Jan 2025 13:04:13 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 00/19] reftable: stop using "git-compat-util.h"
Date: Mon, 27 Jan 2025 14:04:08 +0100
Message-Id: <20250127-pks-reftable-drop-git-compat-util-v1-0-6e280a564877@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEmEl2cC/yWNyw6DIBQFf8WwLgkgCvorjQuEey2pDwrYNDH+e
 2ldzsnJzEESRA+J9NVBIrx98ttagN8qYh9mnYB6V5gIJiTnvKPhmWgEzGacgbq4BTr5TO22BJP
 pnv1MpWIoRnTQtIIUTyh3//k37sPFEV57SeVrJKNJ8FMsPvdVgxoV0xyVarmxDnXtmJG21bxDq
 J0SEhl3igzn+QUxnBqOvwAAAA==
X-Change-ID: 20241119-pks-reftable-drop-git-compat-util-470f2bfde562
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>
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

Thanks!

Patrick

---
Patrick Steinhardt (19):
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
      compat/msvc: split out POSIX-related bits
      git-compat-util.h: split out POSIX-emulating bits
      reftable: decouple from Git codebase by pulling in "compat/posix.h"
      Makefile: skip reftable library for Coccinelle

 Makefile                                |   2 +-
 compat/{mingw.c => mingw/compat-util.c} |   0
 compat/mingw/compat-util.h              | 220 +++++++++++++
 compat/{mingw.h => mingw/posix.h}       | 216 +------------
 compat/{msvc.c => msvc/compat-util.c}   |   2 +-
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
 reftable/record.c                       |  96 +++---
 reftable/record.h                       |   6 +-
 reftable/stack.c                        |  52 ++-
 reftable/system.c                       |   7 +
 reftable/system.h                       |   9 +-
 reftable/writer.c                       |  29 +-
 t/unit-tests/t-reftable-basics.c        |  28 +-
 t/unit-tests/t-reftable-pq.c            |  22 +-
 t/unit-tests/t-reftable-record.c        |  42 ++-
 30 files changed, 1214 insertions(+), 925 deletions(-)


---
base-commit: 5f8f7081f7761acdf83d0a4c6819fe3d724f01d7
change-id: 20241119-pks-reftable-drop-git-compat-util-470f2bfde562


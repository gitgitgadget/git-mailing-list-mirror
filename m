Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB98121FF44
	for <git@vger.kernel.org>; Fri,  1 Aug 2025 22:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754085869; cv=none; b=E5zJF9yjXpn40dh71wf3jtlRo5ym0YhdngsFb0DWiHa2IRagyVoe4hNy6LU3c5WK+e/lRY++hme+JdcuKE/ezZDtSpIQuFSQJihvUn0oO7UauV0YFn48M711lmE2UiwVpMOA3XX6+K4dEivdcRYB2ZeB52Byzle1eAHnw3hSofc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754085869; c=relaxed/simple;
	bh=DnZ7uyvfVxkrWPn9AAzliTdq1X2qrY5C+qrIz8y80zc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lhgDpFsSTUXLkNZGNKuGWOQ6Gi2QT0qy9N7/3cnTj70C+RSMSxZ6XQRZaEdiaPrSrUBLPhZaJS1zK/GzNP/R74K4pHNsyH2JKKCOqRvwBg0r/ot8Ru9GpDYGMERYJCMFDkpWXBOev7hhOx51h5zTC7LN7lPonaVfgOTib7Vr9DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=W9nmnuah; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=d4aTjR1g; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="W9nmnuah";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="d4aTjR1g"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0B54914001A4;
	Fri,  1 Aug 2025 18:04:26 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Fri, 01 Aug 2025 18:04:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1754085866; x=
	1754172266; bh=iGBFJM/aKfN8OeCjSIVKTumB+mhiInuTntjbm/PR7R8=; b=W
	9nmnuahacd+TzimPRqJ4nlf/xC+fDRk7XMIC98M2f2ooD3V4794eFoYOBURrj0dS
	bkKoVop0fE90ddAju6R8WxOkOWMLk3ptoRXDgm94un0K3LeEf/3/K+jHZrupkahR
	9X9/kK51eUUoVKsWa/ol1R8SYPUk4WtET/Uj9pE+8Lp5ZUflCDfRZWl/Nz14KOhz
	+t2nn9hbP3OzxnRUaLK5VHzWyxTrYtUogeTillmHHKOau9D2t37HBUZliRU9jqa9
	LcNBd4XyqTVSai9tRxNvXtkoAv0cUkyJoo5BC8S6fqs2owa1cy4Qj62DGI+HwiCM
	jI6raLWatqABO26YDNzrg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1754085866; x=1754172266; bh=iGBFJM/aKfN8OeCjSIVKTumB+mhi
	InuTntjbm/PR7R8=; b=d4aTjR1g4ZGpmloCRiBl7rFMBh2LoLn0AQR8Ww0LMoIu
	osnMzRHDlP37H8eKXvOhQ4oIKA5qbySw3msHMGJ6KLIJI9+Zi6hK/7ASjxaMJ6MO
	NCxzeDLh+5v2EWMNY3LTuAlTBTo/rnNG/ZcO+sVFqvWYZT/rbPavBAmQK4bn3PRJ
	b3A82ctdvReVG96pUPsRJcRns5IqInRjfyAkCVdSQyQRJLft24Pq7dpZWufIHYRp
	xkRwbfFEZ5K9Euv89GDZnK49FVMME+oaWytJR4C0Va4FvM04i9v+3Dfi1yDKl7RY
	HSbul5XvF2lbYMSeOjRCHtXe8wgRlVyJoxtPE1L/kg==
X-ME-Sender: <xms:6TmNaK8xhxOIhYVS0NSgnvOiXCYq1GGkLhpUK9Twc4IkOqu94CQcag>
    <xme:6TmNaK5X0IrG46UDZ0ohWIWJoaP4j3qb9YCsnqeX93R5yQxs7Wz-RemI7Hktf4Zb1
    SYla9a8a2bTOA9NDg>
X-ME-Received: <xmr:6TmNaB3yvSkUOR3VVLIxP8JpyjkPigm307MiedIdAgWy00JtJpv81JA3mTpb34gVeUb4erjPh3gwn8SeR8HJGZ-7DJmGqI20MgbRrSk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddutdegkeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekredtre
    dttdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphho
    sghogidrtghomheqnecuggftrfgrthhtvghrnhepleevieefieeuffeugefhveeugefgfe
    evvdefleevuedvfedvudefkeehtdeftdegnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspg
    hrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhm
X-ME-Proxy: <xmx:6TmNaBCi6K8pdfxMoEjAXGEIAQ1J8-9i5fft_knJQIs488BVNLJBKw>
    <xmx:6TmNaD1M_8vbWy7hMecxtiZkzfYDI4G7oHN1xbcfdnPkhjcjhrgXkw>
    <xmx:6TmNaLv2AkQt0is5KgPSE332iqxEaRZMcCkVU-bew6iKridqIC6NVA>
    <xmx:6TmNaD4HJe_CAJZH5vS5BR-8hRwSwvDeuwhVdNTYdyL_sWoxn9QhBg>
    <xmx:6jmNaNiwtYlFXev75vbCZR33sVS0yWdQqRqa06wFLA1MsQUatkHQrT-h>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 1 Aug 2025 18:04:25 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v3 0/7] string_list_split*() updates
Date: Fri,  1 Aug 2025 15:04:16 -0700
Message-ID: <20250801220423.1230969-1-gitster@pobox.com>
X-Mailer: git-send-email 2.50.1-633-g85c5610de3
In-Reply-To: <20250731224607.3942417-1-gitster@pobox.com>
References: <20250731224607.3942417-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Two related string-list API functions, string_list_split() and
string_list_split_in_place(), more or less duplicates their
implementations.  They both take a single string, and split the
string at the delimiter and stuff the result into a string list.

However, there is one subtle and unnecessary difference.  The non
"in-place" variant only allows a single byte value as delimiter,
while the "in-place" variant can take multiple delimiters (e.g.,
"split at either a comma or a space").

This series first updates the string_list_split() to allow multiple
delimiters like string_list_split_in_place() does, by unifying their
implementations into one.  This refactoring allows us to give new
features to these two functions more easily.

Then these functions learn to optionally

 - trim the split string pieces before placing them in the resulting
   string list.

 - omit empty string pieces from the resulting string list.

An existing caller of string_list_split() in diff.c trims the
elements in the resulting string list before it uses them, which is
simplified by taking advantage of this new feature.

A handful of code paths call string_list_split*(), immediately
followed by string_list_remove_empty_items().  They are simplified
by not placing empty items in the list in the first place.



Relative to the v2 iteration, the v3 iteration switches from CPP
macros to enum for flag bits, and corrects a handful of typos.

Junio C Hamano (7):
  string-list: report programming error with BUG
  string-list: align string_list_split() with its _in_place()
    counterpart
  string-list: unify string_list_split* functions
  string-list: optionally trim string pieces split by
    string_list_split*()
  diff: simplify parsing of diff.colormovedws
  string-list: optionally omit empty string pieces in
    string_list_split*()
  string-list: split-then-remove-empty can be done while splitting

 builtin/blame.c              |   2 +-
 builtin/merge.c              |   2 +-
 builtin/var.c                |   2 +-
 connect.c                    |   2 +-
 diff.c                       |  20 ++----
 fetch-pack.c                 |   2 +-
 notes.c                      |   6 +-
 parse-options.c              |   2 +-
 pathspec.c                   |   3 +-
 protocol.c                   |   2 +-
 ref-filter.c                 |   4 +-
 setup.c                      |   3 +-
 string-list.c                | 120 ++++++++++++++++++++++++-----------
 string-list.h                |  30 ++++++---
 t/helper/test-hashmap.c      |   4 +-
 t/helper/test-json-writer.c  |   4 +-
 t/helper/test-path-utils.c   |   3 +-
 t/helper/test-ref-store.c    |   2 +-
 t/unit-tests/u-string-list.c |  95 ++++++++++++++++++++++++---
 transport.c                  |   2 +-
 upload-pack.c                |   2 +-
 21 files changed, 222 insertions(+), 90 deletions(-)

Range-diff against v2:
1:  1c2b222eec = 1:  442ed679bb string-list: report programming error with BUG
2:  a7e07b94ef = 2:  cc80bac8c2 string-list: align string_list_split() with its _in_place() counterpart
3:  b7a7fbb975 = 3:  c7922b3e14 string-list: unify string_list_split* functions
4:  c566d88c28 ! 4:  9d7d22e8ef string-list: optionally trim string pieces split by string_list_split*()
    @@ string-list.h: int string_list_split(struct string_list *list, const char *strin
      int string_list_split_in_place(struct string_list *list, char *string,
      			       const char *delim, int maxsplit);
     +
    -+/* trim() resulting string piece before adding it to the list */
    -+#define STRING_LIST_SPLIT_TRIM 01
    ++/* flag bits for split_f and split_in_place_f functions */
    ++enum {
    ++	/* trim() resulting string piece before adding it to the list */
    ++	STRING_LIST_SPLIT_TRIM = (1 << 0),
    ++};
     +
     +int string_list_split_f(struct string_list *, const char *string,
     +			const char *delim, int maxsplit, unsigned flags);
     +
     +int string_list_split_in_place_f(struct string_list *, char *string,
     +				 const char *delim, int maxsplit, unsigned flags);
    -+
      #endif /* STRING_LIST_H */
     
      ## t/unit-tests/u-string-list.c ##
5:  eb272e0f22 ! 5:  ad8b425bc5 diff: simplify parsing of diff.colormovedws
    @@ Commit message
         diff: simplify parsing of diff.colormovedws
     
         The code to parse this configuration variable, whose value is a
    -    comma separated known tokens like "ignore-space-change" and
    +    comma-separated list of known tokens like "ignore-space-change" and
         "ignore-all-space", uses string_list_split() to split the value into
         pieces, and then places each piece of string in a strbuf to trim,
         before comparing the result with the list of known tokens.
6:  d418078a84 ! 6:  d03f443878 string-list: optionally omit empty string pieces in string_list_split*()
    @@ Commit message
         string-list: optionally omit empty string pieces in string_list_split*()
     
         Teach the unified split_string() machinery a new flag bit,
    -    STRING_LIST_SPLIT_NONEMPTY, to cause empty split pieces omitted from
    -    the resulting string list.
    +    STRING_LIST_SPLIT_NONEMPTY, to cause empty split pieces to be
    +    omitted from the resulting string list.
     
         Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
    @@ string-list.c: static int append_one(struct string_list *list,
     
      ## string-list.h ##
     @@ string-list.h: int string_list_split_in_place(struct string_list *list, char *string,
    - /* trim() resulting string piece before adding it to the list */
    - #define STRING_LIST_SPLIT_TRIM 01
    + enum {
    + 	/* trim() resulting string piece before adding it to the list */
    + 	STRING_LIST_SPLIT_TRIM = (1 << 0),
    ++	/* omit adding empty string piece to the resulting list */
    ++	STRING_LIST_SPLIT_NONEMPTY = (1 << 1),
    + };
      
    -+/* omit adding empty string piece to the resulting list */
    -+#define STRING_LIST_SPLIT_NONEMPTY 02
    -+
      int string_list_split_f(struct string_list *, const char *string,
    - 			const char *delim, int maxsplit, unsigned flags);
    - 
     
      ## t/unit-tests/u-string-list.c ##
     @@ t/unit-tests/u-string-list.c: void test_string_list__split_f(void)
7:  12c1189a08 = 7:  9eb8d87d62 string-list: split-then-remove-empty can be done while splitting
-- 
2.50.1-633-g85c5610de3


Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C401A0BE0
	for <git@vger.kernel.org>; Thu, 31 Jul 2025 22:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754001974; cv=none; b=O47ty+dY7W2ZY/R3Yvo1H+uPZ/R6h7EdqCY11/FDBSd5ESfIUJBgMuXHXTAaQlH9UWD7RlMOL5BXaSvimEIGG68PKysuvEIMZYJcUksg50A3se4XzfAzwRAgt84epv1TThda0stC/Hd1hNZXRKqh3HG4/Nyw/HeF5i/qhFlJdc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754001974; c=relaxed/simple;
	bh=/X3Ib7DOU11e0ztA4DRqvJfDDeZFOrgOKx8xyMN1c5g=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NK0NhVNSC7iCAf2S96MRuQneNA66NqK+YWEPaEb/MhWHBtppkwciSAsFByC3/uFreXJBUBvmQcRxomxkRhPSjXwHaLqS5iuc740UXViXstRBzxwZHHwFtL/g2BiBki3ASs62q7VErh8sX3papE5ZgG4IXkf5xN7Qce13KBmnJcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=fW6LlR7W; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nRhoTxQT; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="fW6LlR7W";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nRhoTxQT"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E5D481400042;
	Thu, 31 Jul 2025 18:46:08 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Thu, 31 Jul 2025 18:46:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1754001968; x=
	1754088368; bh=aGMgRG+vfmRoTJdPsOjme5Cuj6M659YAZdOH1rsNZME=; b=f
	W6LlR7WqRMMaQoUUxGkizFhZwRfypkJjqmlC76b+LoHEnNlC0oCvEOm6/fv+Yvmc
	KaBD1PAczd+uHSGmMRpAlPYGejYuNmsHVqsZX8DEAEbWOBSENOLMthFZcBAFh/zD
	HExetyIo4cCBrS17gUHAuTq36TlcWhvml/CNlvJn1KxMvlC7u49nlmFa/xjZIIdu
	axgb4mY/9dvH8NJ9D5De2iiNba8ackqTJKVQuVPx+/4/RRf8mBkAVMqbzNo6IQUb
	aLzjMA1lKjCZBnMqCL+kdmmIkfffLRG9x0hokVzibbQEA8PjZoctyRj2UKx8XhYu
	fE5NiTIssGYiiR06Ndt1A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1754001968; x=1754088368; bh=aGMgRG+vfmRoTJdPsOjme5Cuj6M6
	59YAZdOH1rsNZME=; b=nRhoTxQTESwlW+qMxVOz45mmlvMul3ckGZTs0gfh5+rs
	KLKq+taLuO519X0gcEsPvmO1NqhPias6oX5oFyLwGgZvCgGiswnzHgp5junwfKQ/
	tJgVIEV/2oWxn/did3/dA6S3fWYRgR9eGFb9e4FHpsuuA67CW6XLP3tsOrR6g6ET
	qWi7TIxrhAE5hZI6wn0PNJJQ8HQlTYrOAVtttg3wLPfVl5fvt28gxPGoBA77JrLa
	1XQAfyWn61Mr/vT8ojVSBq7TGshpmCDc96d0qS8Jr6Dao1Lr08Ug9+hhEnNpqL2P
	CaFh4pE+C62hxCMt/+5r7Bx96gwvE1TMT2fm8UvW7A==
X-ME-Sender: <xms:MPKLaC7-BwczCNTECP8JiiFwrsjNVTjR719gNQlL2oLjqBGDPo3vFg>
    <xme:MPKLaMGDdZdeHP-BXDca28TJ_-qHqyrJq0HaDrzk6mMdM3FEcuAYBzcj2u-e0QfV0
    6iOJzqnIHUxpHrDHg>
X-ME-Received: <xmr:MPKLaDTILg3v-vY4esmgdryiI9HjAFT_rWzVmNUP-wMIYCN80H0ORwdmVsYwcxAwLXgjlCsAhx9Cz_WS36HLzdU3NbiKC9LjIPlRXhQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddutddvtdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekredtre
    dttdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphho
    sghogidrtghomheqnecuggftrfgrthhtvghrnhepleevieefieeuffeugefhveeugefgfe
    evvdefleevuedvfedvudefkeehtdeftdegnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspg
    hrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhm
X-ME-Proxy: <xmx:MPKLaNtzgDZbug3M9VovaU2jKQ2J0JfoOGKGMG1u4mqQlNMf2xV1bg>
    <xmx:MPKLaKwBRPK83nnAYTRz3uVFcFHBcGDoz_TRY0xFC2qRRfUY2OwNDg>
    <xmx:MPKLaP7wmc5n0yWuMq-S9xncCEmtiVDmnD_pmdfkg8iotuAwSNxpaQ>
    <xmx:MPKLaMXHCWaiLpbGaoPimLmXLtIBc64ZTa-KxBf3pn6GTzVwlROfRA>
    <xmx:MPKLaNeoKdUXzcryms7oBuFOtoXtn9QCElSMB1Qjuhqog93JT5jygHhu>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 31 Jul 2025 18:46:08 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v2 0/7] string_list_split*() updates
Date: Thu, 31 Jul 2025 15:45:59 -0700
Message-ID: <20250731224607.3942417-1-gitster@pobox.com>
X-Mailer: git-send-email 2.50.1-618-g45d530d26b
In-Reply-To: <20250731063949.1601669-1-gitster@pobox.com>
References: <20250731063949.1601669-1-gitster@pobox.com>
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
 string-list.h                |  29 ++++++---
 t/helper/test-hashmap.c      |   4 +-
 t/helper/test-json-writer.c  |   4 +-
 t/helper/test-path-utils.c   |   3 +-
 t/helper/test-ref-store.c    |   2 +-
 t/unit-tests/u-string-list.c |  95 ++++++++++++++++++++++++---
 transport.c                  |   2 +-
 upload-pack.c                |   2 +-
 21 files changed, 221 insertions(+), 90 deletions(-)


1:  e56dc89249 ! 1:  1c2b222eec string-list: report programming error with BUG
    @@ Commit message
         string-list: report programming error with BUG
     
         Passing a string list that has .strdup_strings bit unset to
    -    string_list_split(), orone that has .strdup_strings bit set to
    +    string_list_split(), or one that has .strdup_strings bit set to
         string_list_split_in_place(), is a programmer error.  Do not use
         die() to abort the execution.  Use BUG() instead.
     
2:  1bd3506fad ! 2:  a7e07b94ef string-list: align string_list_split() with its _in_place() counterpart
    @@ Commit message
         For some unknown reason, unlike string_list_split_in_place(),
         string_list_split() took only a single character as a field
         delimiter.  Before giving both functions more features in future
    -    commits, allow stirng_list_split() to take more than one delimiter
    +    commits, allow string_list_split() to take more than one delimiter
         characters to make them closer to each other.
     
         Signed-off-by: Junio C Hamano <gitster@pobox.com>
3:  52c3b694d2 ! 3:  b7a7fbb975 string-list: unify string_list_split* functions
    @@ string-list.c: void unsorted_string_list_delete_item(struct string_list *list, i
      
     -int string_list_split(struct string_list *list, const char *string,
     -		      const char *delim, int maxsplit)
    -+static void append_one(struct string_list *list,
    -+		       const char *p, const char *end,
    -+		       int in_place)
    ++/*
    ++ * append a substring [p..end] to list; return number of things it
    ++ * appended to the list.
    ++ */
    ++static int append_one(struct string_list *list,
    ++		      const char *p, const char *end,
    ++		      int in_place)
     +{
     +	if (!end)
     +		end = p + strlen(p);
    @@ string-list.c: void unsorted_string_list_delete_item(struct string_list *list, i
     +	} else {
     +		string_list_append_nodup(list, xmemdupz(p, end - p));
     +	}
    ++	return 1;
     +}
     +
     +/*
    @@ string-list.c: void unsorted_string_list_delete_item(struct string_list *list, i
     -		BUG("internal error in string_list_split(): "
     -		    "list->strdup_strings must be set");
      	for (;;) {
    -+		char *end;
    -+
    - 		count++;
    +-		count++;
     -		if (maxsplit >= 0 && count > maxsplit) {
     -			string_list_append(list, p);
     -			return count;
    @@ string-list.c: void unsorted_string_list_delete_item(struct string_list *list, i
     -			p = end + 1;
     -		} else {
     -			string_list_append(list, p);
    -+		if (maxsplit >= 0 && count > maxsplit)
    ++		char *end;
    ++
    ++		if (0 <= maxsplit && maxsplit <= count)
     +			end = NULL;
     +		else
     +			end = strpbrk(p, delim);
     +
    -+		append_one(list, p, end, in_place);
    ++		count += append_one(list, p, end, in_place);
     +
     +		if (!end)
      			return count;
4:  13e3d9fbaf ! 4:  c566d88c28 string-list: optionally trim string pieces split by string_list_split()
    @@ Metadata
     Author: Junio C Hamano <gitster@pobox.com>
     
      ## Commit message ##
    -    string-list: optionally trim string pieces split by string_list_split()
    +    string-list: optionally trim string pieces split by string_list_split*()
     
         Teach the unified split_string() to take an optional "flags" word,
         and define the first flag STRING_LIST_SPLIT_TRIM to cause the split
    @@ Commit message
     
      ## string-list.c ##
     @@ string-list.c: void unsorted_string_list_delete_item(struct string_list *list, int i, int free_
    - 
    - static void append_one(struct string_list *list,
    - 		       const char *p, const char *end,
    --		       int in_place)
    -+		       int in_place, unsigned flags)
    +  */
    + static int append_one(struct string_list *list,
    + 		      const char *p, const char *end,
    +-		      int in_place)
    ++		      int in_place, unsigned flags)
      {
      	if (!end)
      		end = p + strlen(p);
    @@ string-list.c: void unsorted_string_list_delete_item(struct string_list *list, i
      	if (in_place) {
      		*((char *)end) = '\0';
      		string_list_append(list, p);
    -@@ string-list.c: static void append_one(struct string_list *list,
    +@@ string-list.c: static int append_one(struct string_list *list,
       * returns "char *" pointer into that const string.  Yucky but works ;-).
       */
      static int split_string(struct string_list *list, const char *string, const char *delim,
    @@ string-list.c: static int split_string(struct string_list *list, const char *str
     +				p++;
     +		}
     +
    - 		count++;
    - 		if (maxsplit >= 0 && count > maxsplit)
    + 		if (0 <= maxsplit && maxsplit <= count)
      			end = NULL;
      		else
      			end = strpbrk(p, delim);
      
    --		append_one(list, p, end, in_place);
    -+		append_one(list, p, end, in_place, flags);
    +-		count += append_one(list, p, end, in_place);
    ++		count += append_one(list, p, end, in_place, flags);
      
      		if (!end)
      			return count;
5:  912c6ee193 ! 5:  eb272e0f22 diff: simplify parsing of diff.colormovedws
    @@ Commit message
     
         The code to parse this configuration variable, whose value is a
         comma separated known tokens like "ignore-space-change" and
    -    "ignore-all-space", uses string_list_split() to split the value int
    +    "ignore-all-space", uses string_list_split() to split the value into
         pieces, and then places each piece of string in a strbuf to trim,
         before comparing the result with the list of known tokens.
     
    -    Thanks to the previous steps, now string_list_split() knows to trim
    -    the resulting pieces in the string list.  Use it to simplify the
    -    code.
    +    Thanks to the previous steps, now string_list_split() can trim the
    +    resulting pieces before it places them in the string list.  Use it
    +    to simplify the code.
     
         Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
-:  ---------- > 6:  d418078a84 string-list: optionally omit empty string pieces in string_list_split*()
-:  ---------- > 7:  12c1189a08 string-list: split-then-remove-empty can be done while splitting

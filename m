Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C7C381C4
	for <git@vger.kernel.org>; Sun,  3 Aug 2025 06:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754203948; cv=none; b=hmW/k/bphW8Q4xjfTEbc0mRd55Z6S9JtpzCqMY85M0XDbR8RWeQgiAj1nEht6E01VPa9NIOsC94X7H1ytC7U9WDDXNts5iSlDSCUAOU1WfjrpLoHIgL1YwKbqYaV14k/f2/AQ3QbWhkoPp14OLIxrjGwfv5JB5PCkLqtNzlyQgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754203948; c=relaxed/simple;
	bh=VeB31aeUb/xukf+GROzMj0IbSSrzhAA+EhIzgWbdg9w=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QhKO0s69pHpdsW7ys5U9PP42qzzsnv1t6EfrxcF9udZfe42VWaJwLpjmNKInriqms1MaFDfNYORFgtx9BuBzqXK80VonhXG0lsR+dnIi1RsTracHLljYZLgKZm6VhW4b51FKQYXiP0CiykXxubx5tviWFxW96eEvdJDls3kXO3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=HbO2scn7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MQZ6em4G; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="HbO2scn7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MQZ6em4G"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 33CB2EC152C;
	Sun,  3 Aug 2025 02:52:25 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Sun, 03 Aug 2025 02:52:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1754203945; x=
	1754290345; bh=JEMxVYERWi7tA+cG1YaSfxx1G5xcIg6c97HXLpq5jRE=; b=H
	bO2scn7kVhqcOevwx0XL+/yBbvSidUfC7Kyri5z6Y2qIvpO0axgygMERWNviMu4r
	NmOpdb+5IOWYwS9B2Vevr7HmtBBmfNseC5WEMlje9kcZ06sKpu+16OYZgkRPN+we
	VRGRil5jjjuVyV87XFauJbXniM5h6pSwhWyN7I5WXlqzYtBJqowPy9DSrDwWpx4/
	zoJUqLxXIuB/DiSrhmbXk3z2K84K6ttonh8PRb/K0WFi+fHGL/0HUuTStIawW9y2
	f1DbPywR+MX6AetRy5WF0gBv0uYVfI2PT3aSieIJM4hY/tcV3oILab5Sx16el9eE
	tV7kmwTxrZRyksiCWjIFw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1754203945; x=1754290345; bh=JEMxVYERWi7tA+cG1YaSfxx1G5xc
	Ig6c97HXLpq5jRE=; b=MQZ6em4G1Du6M4mlNOAfTp12SQdjrs6m6tWlv7QXdzkF
	DNH20yaDGU5K2FN/z7BFtWJXEvC15C6ldF5H0iKZLEO3Ls9oBYdY5Mnhm4kGwbdO
	7LaYnJIYEeLjgtqNJLOqTokvhZz268VCVWP+DJUmE5cD04SHTSzzGpqhNhOlAVyA
	erL+iudXiHPd8zBNcZ2WF2w76F/0oJRLTQ/jeASS4olaOESRjpqybZ9fRB5oAnDp
	fsREauyocBpUadhqGR7rfw7eGVzcHUN4uyyUJfUODjB7g0EsY8dzlD63vCleYtlz
	tIkHFn8Q2FZYT6WIt/fkrnfoKfoH5swC9LLC9lqdNQ==
X-ME-Sender: <xms:KQePaNn3KbJLSb1RZTaRJfQv4CD23Jx9gQEv94tu8GyYkd6g-wBCsw>
    <xme:KQePaJBz4G7xxqL5hUX2EZPAuxnuyKOC9gr8Dqdibi3bQp8ysbdi5tVtAHT_uxnEM
    NhZiNTCpT9-KQFoxw>
X-ME-Received: <xmr:KQePaFfd_m03b8yC80gAaQ-Ugn5MAztERPCnmOhrWo3m4wZRZlN1EY4vebMtQ5z9k_aX89204e_2txNVhskSoOLJ1Yq3aQXQov_R-ec>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddutdekjeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekredtre
    dttdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphho
    sghogidrtghomheqnecuggftrfgrthhtvghrnhepleevieefieeuffeugefhveeugefgfe
    evvdefleevuedvfedvudefkeehtdeftdegnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspg
    hrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhm
X-ME-Proxy: <xmx:KQePaMLlWjjn5z2CfZN6NYGn5y3cVjtmSKXG9hsD5HltQYhV1P7Aog>
    <xmx:KQePaAcLkFEuylOscbyll4o-CNiI3qnqbJyEn4lUsELR7wpuURXxNQ>
    <xmx:KQePaL2uRTx-o6iSiHGpR8vzUQy2qN0oC4l_5_HUuQZXv0KmwAvofQ>
    <xmx:KQePaBgst_I_2U8VjLKrp2Sbr2SpNcYGf8mbjOPjYCxXSc3td_r3CQ>
    <xmx:KQePaALUGMpNIRYFgaKLTU_Tm4iN4hYVswxZ7iAZvvt4pCl8WLSv0Uzw>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 3 Aug 2025 02:52:24 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v4 0/7] string_list_split*() updates
Date: Sat,  2 Aug 2025 23:52:16 -0700
Message-ID: <20250803065223.3325111-1-gitster@pobox.com>
X-Mailer: git-send-email 2.50.1-633-g69dfdd50af
In-Reply-To: <20250801220423.1230969-1-gitster@pobox.com>
References: <20250801220423.1230969-1-gitster@pobox.com>
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


Relative to the v3 iteration, the v4 iteration explains the history
behind string_list_split_in_place() in a bit more detail, and
expands in-code comment to clarify what the verb "trim" means in the
context of STRING_LIST_SPLIT_TRIM.

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
 string-list.h                |  33 +++++++---
 t/helper/test-hashmap.c      |   4 +-
 t/helper/test-json-writer.c  |   4 +-
 t/helper/test-path-utils.c   |   3 +-
 t/helper/test-ref-store.c    |   2 +-
 t/unit-tests/u-string-list.c |  95 ++++++++++++++++++++++++---
 transport.c                  |   2 +-
 upload-pack.c                |   2 +-
 21 files changed, 225 insertions(+), 90 deletions(-)

Range-diff against v3:
1:  442ed679bb = 1:  4f9c8d8963 string-list: report programming error with BUG
2:  cc80bac8c2 ! 2:  9f6dfe43c8 string-list: align string_list_split() with its _in_place() counterpart
    @@ Metadata
      ## Commit message ##
         string-list: align string_list_split() with its _in_place() counterpart
     
    -    For some unknown reason, unlike string_list_split_in_place(),
    -    string_list_split() took only a single character as a field
    -    delimiter.  Before giving both functions more features in future
    -    commits, allow string_list_split() to take more than one delimiter
    -    characters to make them closer to each other.
    +    The string_list_split_in_place() function was updated by 52acddf3
    +    (string-list: multi-delimiter `string_list_split_in_place()`,
    +    2023-04-24) to take more than one delimiter characters, hoping that
    +    we can later use it to replace our uses of strtok().  We however did
    +    not make a matching change to the string_list_split() function,
    +    which is very similar.
    +
    +    Before giving both functions more features in future commits, allow
    +    string_list_split() to also take more than one delimiter characters
    +    to make them closer to each other.
     
         Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
3:  c7922b3e14 = 3:  527535fcdd string-list: unify string_list_split* functions
4:  9d7d22e8ef ! 4:  5764549741 string-list: optionally trim string pieces split by string_list_split*()
    @@ string-list.h: int string_list_split(struct string_list *list, const char *strin
      int string_list_split_in_place(struct string_list *list, char *string,
      			       const char *delim, int maxsplit);
     +
    -+/* flag bits for split_f and split_in_place_f functions */
    ++/* Flag bits for split_f and split_in_place_f functions */
     +enum {
    -+	/* trim() resulting string piece before adding it to the list */
    ++	/*
    ++	 * trim whitespaces around resulting string piece before adding
    ++	 * it to the list
    ++	 */
     +	STRING_LIST_SPLIT_TRIM = (1 << 0),
     +};
     +
5:  ad8b425bc5 = 5:  f3a303aef0 diff: simplify parsing of diff.colormovedws
6:  d03f443878 ! 6:  27531efa41 string-list: optionally omit empty string pieces in string_list_split*()
    @@ string-list.c: static int append_one(struct string_list *list,
      		string_list_append(list, p);
     
      ## string-list.h ##
    -@@ string-list.h: int string_list_split_in_place(struct string_list *list, char *string,
    - enum {
    - 	/* trim() resulting string piece before adding it to the list */
    +@@ string-list.h: enum {
    + 	 * it to the list
    + 	 */
      	STRING_LIST_SPLIT_TRIM = (1 << 0),
     +	/* omit adding empty string piece to the resulting list */
     +	STRING_LIST_SPLIT_NONEMPTY = (1 << 1),
7:  9eb8d87d62 = 7:  2ab2aac73d string-list: split-then-remove-empty can be done while splitting
-- 
2.50.1-633-g69dfdd50af


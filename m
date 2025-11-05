Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 065E524DCEF
	for <git@vger.kernel.org>; Wed,  5 Nov 2025 21:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762378257; cv=none; b=kS2NlnFqnV68Szdw4HqR34lFqo1wjNOSXMt+UU31Jz5WkHaZhThEzOsSPFSZvNiDMaH3RgCmnaHuZItXVV36cJW8bfQXfQnEPzhAo+EAnQZSC1kAaVlDLTFpJa6FJTFm5OuqpIb0gqrBb6ysfLINo8BgiTzWb0IRjgUCx98S+2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762378257; c=relaxed/simple;
	bh=LttcnAbQjfsYRzkZGVS6+19Uj8e/B6YQ6WugX/qTspU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h7aABSzXpxX8JqI4zybmhRZRE5EtbVNAxtqpEPsBxzGeggiqPrj87EdbKOpcJawhRR9+y4s+FJuYi9EQpQ/IkVDKvPMHXoJr6IEBkwbPWbHiGPEa7aHfB1rDNFLAupR//ajck3mmQswsya86irlMSuTHA3P1UPlrRlXSb3kqrME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=YrKjXlMl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HZ2W+H9D; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="YrKjXlMl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HZ2W+H9D"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 41A9B1D0021C;
	Wed,  5 Nov 2025 16:30:54 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Wed, 05 Nov 2025 16:30:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1762378254; x=
	1762464654; bh=EooMPl7MYtwgreqQ2IrwuD6xm0kqPj3B+Ki/wN5mU8Y=; b=Y
	rKjXlMlzgK/eShP7o9ecAusy2DLd9MPL5fKH605gJxZmVFUhALAYANr+tOLcNUNs
	dtWHXab0ujmShp1OpgQho9Dg1MvTiDWjzuFPOEubEVyy6NR+85EG1uhuOSn2oYMi
	Zrmzfw0OaF+reZfZ03udFZlmseAUk1YqTZZ02JFJHs9ALEHUSPVj9CBUP2viPrIo
	J4Uu0Udk3KoTJ/WJmdvy01g4kDrTE0zgaxslnMKHdZ9q9Q8TvzFf1jLCGznBa2fW
	tsL9biKWe93YeTBI8HXmi0Tnh1EHY9QxIwtgaoAwXA7bZLKKaKUz80rJbZ8E4Nhb
	f7unMQlKBAly4J8wW486Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1762378254; x=1762464654; bh=EooMPl7MYtwgreqQ2IrwuD6xm0kq
	Pj3B+Ki/wN5mU8Y=; b=HZ2W+H9Ddt9zmHByru3ym1S7Vs405JCNXhFdmBM/+/eZ
	QHawG1SXRbahlMwy92XIbyK8O1ccHNdVEZAD4UoQdKallLSdW6MJ+4orT/jATQW/
	rK6P5qajVBmshgh4t2UYqqKkIgVtV2M28k9pokxwT7o278ocftzzk0CMCPK3gb90
	1KNylbzy4kucSQWnkNzrwvMyIq1RoY7kiteSqfML1m7IcRhAKvtqwXi62/n3gIhw
	9c+lQwT6I3easlSpxH5AzB4MuQxtAddZBn4zif6zZ1VxZzKS7zaw4dHNtIojEuU4
	LkC5XkFkO0vH4uc0BxGPy/7JWdFJw/1vgK4SB2NwTw==
X-ME-Sender: <xms:DcILaVViFy0mFQYgfH5DagCCWE1lIb-txxknS_q4jpgdP2pe-FFnGg>
    <xme:DcILabnbPGphDNgBF5nVuVSGC8CVmU5u39a65NntO9LlpsrRRySvXmNx69hI8r-SX
    X3cTaYl4q0ksSO9aIclw02o6Wvo2bYia5OdVcud3jqPxPS8AvYvkg>
X-ME-Received: <xmr:DcILafC5Jhp5S4v7b7rjeO5eNV5cJphFTsURBCkECJ70h9ytJNoeXCaWs_qyvDiMO-znp38H6a-syIYpWo5gWHy7va5mTsGPHGHk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddukeegleelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekredtre
    dttdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphho
    sghogidrtghomheqnecuggftrfgrthhtvghrnhepfeeuveevledtteefgeevteeihfehhf
    dtudfhtedtteefgfffudfflefggfeghefgnecuffhomhgrihhnpehkvghrnhgvlhdrohhr
    ghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:DcILaTcUpZ5QCSCoyQdj6yeCCcOTPa5Wru8SsNLAiGrAc-vbrNQ5_g>
    <xmx:DcILaSKD7Ro0ZZDoO_iTnCXHjvT6_uE0jevlf8YYC9aHETPp4nIycA>
    <xmx:DcILaedM4dc1NuiJQ5LLe9Ot-xPWoXe-JlzoqmYD0toBL6O8TEHANg>
    <xmx:DcILaR37jWg6e2v9gyyJkis3OgHbSSWIZp5H0MYpI7bfgcYKR0o_dQ>
    <xmx:DsILaQs_fU2SyQUL7ntIw79vKnoLLxTCdPqD6MFpcyxr6TpyPh_C-AlY>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Nov 2025 16:30:53 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v2 00/12] Incomplete lines
Date: Wed,  5 Nov 2025 13:30:40 -0800
Message-ID: <20251105213052.1499224-1-gitster@pobox.com>
X-Mailer: git-send-email 2.52.0-rc0-105-gc08128fbb6
In-Reply-To: <20251104020928.582199-1-gitster@pobox.com>
References: <20251104020928.582199-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

One of the common kind of whitespace errors is to lack the final
newline at the end of a file, but so far, neither "git diff" or "git
apply" did anything about them.

This series introduces "incomplete-line" whitespace error class,
that you can add to either the core.whitespace configuration
variable, or the whitespace attribute in your .gitattributes files.

The class is disabled by default, so the final step enables it for
our project by defining it in the .gitattributes file.

The incomplete line marker that is given for a context line is not
considered an error.  The reasoning is that your preimage did have
incomplete line, but you did not touch the contents on that
incomplete line in your patch, so you left the line intact.  It is
not a new breakage you are responsible for.

If the incomplete line marker follows a postimage line, on the other
hand, it means that you added a new line at the end of the file that
is incomplete *and* that line did not exist in the preimage.  The
last line of the preimage may have been incomplete already, but then
you updated the contents on that line, so you could have easily
fixed the incompleteness of the line while at it.  Either way, you
are responsible for the incompleteness of the last ine in the
resulting file.

The organization of the series is as follows.

 * The first patch [01/12] is a clean-up we have seen earlier on the
   list already (https://lore.kernel.org/git/xmqqfrb4hyjl.fsf@gitster.g/).

 * The patches [02/12] - [08/12] are preliminary clean-up made to
   both "git diff" and "git apply" machinery.

 * The patch [09/12] shifts the bit assignment (cleaned-up in
   [01/12] without changing any values) to make room for new
   whitespace error class (which was last updated in 2007 IIRC, so
   the set of whitespace errors surprisingly haven't changed for
   quite some time), and defines the new "incomplete-line" class.

 * The patch [10/12] teaches "git apply --whitespace=<mode>" and
   "git apply --check" about the incomplete-line error class.

 * The patch [11/12] teaches "git diff [--check]" about the
   incomplete-line error class.

 * The final patch [12/12] enables the incomplete-line error class
   for our project for C source files and shell scripts.  I didn't
   touch the cover-all * entry.

Changes in v2:

 - rolled the definition (but not implementation) of the new
   "incomplete-line" class into step [09/12] that shifts the bit
   assignment.  The documentation of core.whitespace has also be
   updated in this step.

 - "git apply --check" miscounted line number reported for the
   incomplete line error, which has been corrected in step [10/12].

 - t4124-apply-ws-rule.sh has been extended to cover "git apply
   --check" and the diagnostic output from it in step [10/12].

Junio C Hamano (12):
  whitespace: correct bit assignment comments
  diff: emit_line_ws_markup() if/else style fix
  diff: correct suppress_blank_empty hack
  diff: fix incorrect counting of line numbers
  diff: refactor output of incomplete line
  diff: call emit_callback ecbdata everywhere
  diff: update the way rewrite diff handles incomplete lines
  apply: revamp the parsing of incomplete lines
  whitespace: allocate a few more bits and define WS_INCOMPLETE_LINE
  apply: check and fix incomplete lines
  diff: highlight and error out on incomplete lines
  attr: enable incomplete-line whitespace error for this project

 .gitattributes                 |   4 +-
 Documentation/config/core.adoc |   2 +
 apply.c                        |  79 ++++++++++----
 diff.c                         | 148 +++++++++++++++++---------
 diff.h                         |   6 +-
 t/t4015-diff-whitespace.sh     |  63 ++++++++++-
 t/t4124-apply-ws-rule.sh       | 187 +++++++++++++++++++++++++++++++++
 ws.c                           |  20 ++++
 ws.h                           |  26 +++--
 9 files changed, 448 insertions(+), 87 deletions(-)

Range-diff against v1:
 1:  4168f28fe7 =  1:  8a493cdea5 whitespace: correct bit assignment comments
 2:  53b7a010e7 =  2:  a01d99a055 diff: emit_line_ws_markup() if/else style fix
 3:  d93dd05543 =  3:  e3ea40af19 diff: correct suppress_blank_empty hack
 4:  5f58400bd7 =  4:  e15e89d3e2 diff: fix incorrect counting of line numbers
 5:  84c4ca147f =  5:  c007b3d7a7 diff: refactor output of incomplete line
 6:  55b42a1944 =  6:  0cea57091b diff: call emit_callback ecbdata everywhere
 7:  6947838d13 =  7:  523196b440 diff: update the way rewrite diff handles incomplete lines
 8:  63c36c6f70 =  8:  e098932784 apply: revamp the parsing of incomplete lines
 9:  00b645bb4e !  9:  28538f149f whitespace: allocate a few more bits
    @@ Metadata
     Author: Junio C Hamano <gitster@pobox.com>
     
      ## Commit message ##
    -    whitespace: allocate a few more bits
    +    whitespace: allocate a few more bits and define WS_INCOMPLETE_LINE
     
         Reserve a few more bits in the diff flags word to be used for future
    -    whitespace rules.  No behaviour changes intended.
    +    whitespace rules.  Add WS_INCOMPLETE_LINE without implementing the
    +    behaviour (yet).
     
         Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
    + ## Documentation/config/core.adoc ##
    +@@ Documentation/config/core.adoc: core.whitespace::
    +   part of the line terminator, i.e. with it, `trailing-space`
    +   does not trigger if the character before such a carriage-return
    +   is not a whitespace (not enabled by default).
    ++* `incomplete-line` treats the last line of a file that is missing the
    ++  newline at the end as an error (not enabled by default).
    + * `tabwidth=<n>` tells how many character positions a tab occupies; this
    +   is relevant for `indent-with-non-tab` and when Git fixes `tab-in-indent`
    +   errors. The default tab width is 8. Allowed values are 1 to 63.
    +
      ## diff.c ##
     @@ diff.c: enum diff_symbol {
      
    @@ diff.h: struct diff_options {
      	const char *prefix;
      	int prefix_length;
     
    + ## ws.c ##
    +@@ ws.c: static struct whitespace_rule {
    + 	{ "blank-at-eol", WS_BLANK_AT_EOL, 0 },
    + 	{ "blank-at-eof", WS_BLANK_AT_EOF, 0 },
    + 	{ "tab-in-indent", WS_TAB_IN_INDENT, 0, 1 },
    ++	{ "incomplete-line", WS_INCOMPLETE_LINE, 0, 0 },
    + };
    + 
    + unsigned parse_whitespace_rule(const char *string)
    +@@ ws.c: char *whitespace_error_string(unsigned ws)
    + 			strbuf_addstr(&err, ", ");
    + 		strbuf_addstr(&err, "tab in indent");
    + 	}
    ++	if (ws & WS_INCOMPLETE_LINE) {
    ++		if (err.len)
    ++			strbuf_addstr(&err, ", ");
    ++		strbuf_addstr(&err, "no newline at the end of file");
    ++	}
    + 	return strbuf_detach(&err, NULL);
    + }
    + 
    +
      ## ws.h ##
     @@ ws.h: struct strbuf;
    + #define WS_CR_AT_EOL            (1<<9)
    + #define WS_BLANK_AT_EOF         (1<<10)
    + #define WS_TAB_IN_INDENT        (1<<11)
    ++#define WS_INCOMPLETE_LINE      (1<<12)
    + 
    + #define WS_TRAILING_SPACE       (WS_BLANK_AT_EOL|WS_BLANK_AT_EOF)
    + #define WS_DEFAULT_RULE (WS_TRAILING_SPACE|WS_SPACE_BEFORE_TAB|8)
      #define WS_TAB_WIDTH_MASK       ((1<<6)-1)
      
      /* All WS_* -- when extended, adapt constants defined after diff.c:diff_symbol */
10:  662f15d0b4 ! 10:  7369e77309 apply: check and fix incomplete lines
    @@ Commit message
         what happens when A ends in an incomplete line, for example), and
         text-oriented tools often mishandle such a line.
     
    -    Introduce a new whitespace rule "incomplete-line", which is off by
    -    default for backward compatibility's sake, so that "git apply
    +    Implement checks in "git apply" for incomplete lines, which is off
    +    by default for backward compatibility's sake, so that "git apply
         --whitespace={fix,warn,error}" can notice, warn against, and fix
         them.
     
    @@ Commit message
     
         Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
    + ## apply.c ##
    +@@ apply.c: static void record_ws_error(struct apply_state *state,
    + 	    state->squelch_whitespace_errors < state->whitespace_error)
    + 		return;
    + 
    ++	/*
    ++	 * line[len] for an incomplete line points at the "\n" at the end
    ++	 * of patch input line, so "%.*s" would drop the last letter on line;
    ++	 * compensate for it.
    ++	 */
    ++	if (result & WS_INCOMPLETE_LINE)
    ++		len++;
    ++
    + 	err = whitespace_error_string(result);
    + 	if (state->apply_verbosity > verbosity_silent)
    + 		fprintf(stderr, "%s:%d: %s.\n%.*s\n",
    +@@ apply.c: static int parse_fragment(struct apply_state *state,
    + 		}
    + 
    + 		/* eat the "\\ No newline..." as well, if exists */
    +-		len += skip_len;
    ++		if (skip_len) {
    ++			len += skip_len;
    ++			state->linenr++;
    ++		}
    + 	}
    + 	if (oldlines || newlines)
    + 		return -1;
    +
      ## t/t4124-apply-ws-rule.sh ##
     @@ t/t4124-apply-ws-rule.sh: test_expect_success 'whitespace check skipped for excluded paths' '
      	git apply --include=used --stat --whitespace=error <patch
    @@ t/t4124-apply-ws-rule.sh: test_expect_success 'whitespace check skipped for excl
     +	git apply --whitespace=error <patch &&
     +	test_cmp sample2-i target &&
     +
    ++	cat sample-i >target &&
    ++	git apply --whitespace=error --check <patch 2>error &&
    ++	test_cmp sample-i target &&
    ++	test_must_be_empty error &&
    ++
     +	cat sample2-i >target &&
     +	git apply --whitespace=error -R <patch &&
    -+	test_cmp sample-i target
    ++	test_cmp sample-i target &&
    ++
    ++	cat sample2-i >target &&
    ++	git apply -R --whitespace=error --check <patch 2>error &&
    ++	test_cmp sample2-i target &&
    ++	test_must_be_empty error
     +'
     +
     +test_expect_success 'last line made incomplete (error)' '
    @@ t/t4124-apply-ws-rule.sh: test_expect_success 'whitespace check skipped for excl
     +	test_must_fail git apply --whitespace=error <patch 2>error &&
     +	test_grep "no newline" error &&
     +
    ++	cat sample >target &&
    ++	test_must_fail git apply --whitespace=error --check <patch 2>actual &&
    ++	test_cmp sample target &&
    ++	cat >expect <<-\EOF &&
    ++	<stdin>:10: no newline at the end of file.
    ++	6
    ++	error: 1 line adds whitespace errors.
    ++	EOF
    ++	test_cmp expect actual &&
    ++
     +	cat sample-i >target &&
     +	git apply --whitespace=error -R <patch &&
     +	test_cmp sample target &&
     +
    ++	cat sample-i >target &&
    ++	git apply --whitespace=error --check -R <patch 2>error &&
    ++	test_cmp sample-i target &&
    ++	test_must_be_empty error &&
    ++
     +	cat sample >target &&
     +	git apply --whitespace=fix <patch &&
     +	test_cmp sample target
    @@ t/t4124-apply-ws-rule.sh: test_expect_success 'whitespace check skipped for excl
     +	git apply --whitespace=error <patch &&
     +	test_cmp sample target &&
     +
    ++	cat sample-i >target &&
    ++	git apply --whitespace=error --check <patch 2>error &&
    ++	test_cmp sample-i target &&
    ++	test_must_be_empty error &&
    ++
     +	cat sample >target &&
     +	test_must_fail git apply --whitespace=error -R <patch 2>error &&
     +	test_grep "no newline" error &&
     +
     +	cat sample >target &&
    ++	test_must_fail git apply --whitespace=error --check -R <patch 2>actual &&
    ++	test_cmp sample target &&
    ++	cat >expect <<-\EOF &&
    ++	<stdin>:9: no newline at the end of file.
    ++	6
    ++	error: 1 line adds whitespace errors.
    ++	EOF
    ++	test_cmp expect actual &&
    ++
    ++	cat sample >target &&
     +	git apply --whitespace=fix -R <patch &&
     +	test_cmp sample target
     +'
    @@ t/t4124-apply-ws-rule.sh: test_expect_success 'whitespace check skipped for excl
     +	git apply --whitespace=error <patch &&
     +	test_cmp sample3 target &&
     +
    ++	cat sample-i >target &&
    ++	git apply --whitespace=error --check <patch 2>error &&
    ++	test_cmp sample-i target &&
    ++	test_must_be_empty error &&
    ++
     +	cat sample3 >target &&
     +	test_must_fail git apply --whitespace=error -R <patch 2>error &&
     +	test_grep "no newline" error &&
     +
     +	cat sample3 >target &&
    ++	test_must_fail git apply --whitespace=error -R --check <patch 2>actual &&
    ++	test_cmp sample3 target &&
    ++	cat >expect <<-\EOF &&
    ++	<stdin>:9: no newline at the end of file.
    ++	6
    ++	error: 1 line adds whitespace errors.
    ++	EOF
    ++	test_cmp expect actual &&
    ++
    ++	cat sample3 >target &&
     +	git apply --whitespace=fix -R <patch &&
     +	test_cmp sample target
     +'
    @@ t/t4124-apply-ws-rule.sh: test_expect_success 'whitespace check skipped for excl
     +	test_must_fail git apply --whitespace=error <patch 2>error &&
     +	test_grep "no newline" error &&
     +
    ++	cat sample-i >target &&
    ++	test_must_fail git apply --whitespace=error --check <patch 2>actual &&
    ++	test_cmp sample-i target &&
    ++	cat >expect <<-\EOF &&
    ++	<stdin>:11: no newline at the end of file.
    ++	7
    ++	error: 1 line adds whitespace errors.
    ++	EOF
    ++	test_cmp expect actual &&
    ++
     +	cat sample3-i >target &&
     +	test_must_fail git apply --whitespace=error -R <patch 2>error &&
     +	test_grep "no newline" error &&
     +
    ++	cat sample3-i >target &&
    ++	test_must_fail git apply --whitespace=error --check -R <patch 2>actual &&
    ++	test_cmp sample3-i target &&
    ++	cat >expect <<-\EOF &&
    ++	<stdin>:9: no newline at the end of file.
    ++	6
    ++	error: 1 line adds whitespace errors.
    ++	EOF
    ++	test_cmp expect actual &&
    ++
     +	cat sample-i >target &&
     +	git apply --whitespace=fix <patch &&
     +	test_cmp sample3 target &&
    @@ t/t4124-apply-ws-rule.sh: test_expect_success 'whitespace check skipped for excl
      test_done
     
      ## ws.c ##
    -@@ ws.c: static struct whitespace_rule {
    - 	{ "blank-at-eol", WS_BLANK_AT_EOL, 0 },
    - 	{ "blank-at-eof", WS_BLANK_AT_EOF, 0 },
    - 	{ "tab-in-indent", WS_TAB_IN_INDENT, 0, 1 },
    -+	{ "incomplete-line", WS_INCOMPLETE_LINE, 0, 0 },
    - };
    - 
    - unsigned parse_whitespace_rule(const char *string)
    -@@ ws.c: char *whitespace_error_string(unsigned ws)
    - 			strbuf_addstr(&err, ", ");
    - 		strbuf_addstr(&err, "tab in indent");
    - 	}
    -+	if (ws & WS_INCOMPLETE_LINE) {
    -+		if (err.len)
    -+			strbuf_addstr(&err, ", ");
    -+		strbuf_addstr(&err, "no newline at the end of file");
    -+	}
    - 	return strbuf_detach(&err, NULL);
    - }
    - 
     @@ ws.c: static unsigned ws_check_emit_1(const char *line, int len, unsigned ws_rule,
      	if (trailing_whitespace == -1)
      		trailing_whitespace = len;
    @@ ws.c: void ws_fix_copy(struct strbuf *dst, const char *src, int len, unsigned ws
      	/*
      	 * Strip trailing whitespace
      	 */
    -
    - ## ws.h ##
    -@@ ws.h: struct strbuf;
    - #define WS_CR_AT_EOL            (1<<9)
    - #define WS_BLANK_AT_EOF         (1<<10)
    - #define WS_TAB_IN_INDENT        (1<<11)
    -+#define WS_INCOMPLETE_LINE      (1<<12)
    - 
    - #define WS_TRAILING_SPACE       (WS_BLANK_AT_EOL|WS_BLANK_AT_EOF)
    - #define WS_DEFAULT_RULE (WS_TRAILING_SPACE|WS_SPACE_BEFORE_TAB|8)
11:  36de2ac901 = 11:  17c2fa50a7 diff: highlight and error out on incomplete lines
12:  e82056bf55 = 12:  73af29fba7 attr: enable incomplete-line whitespace error for this project
-- 
2.52.0-rc0-105-gc08128fbb6


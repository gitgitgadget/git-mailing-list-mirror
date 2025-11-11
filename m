Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0586717D6
	for <git@vger.kernel.org>; Tue, 11 Nov 2025 00:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762819497; cv=none; b=jZ54CYp54lwf0hslCkZvaPXZsnSTAaBpMiFf+Hm5YcA6iM/dSGmj69pm6g8MgrwMsQYPmFmPIplaeXHQGJnPiUR+9qzBDr5d2ivELWpAlKclo5Ue9Ez71mDoja5N1/Yh784ArFYDvXFHvL/rsjggo+Fbth4z7FwmPIKjg5EkT8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762819497; c=relaxed/simple;
	bh=XiA8fqqhH9I+WBf3D3jlx1g2St3FKrYzmZJP4R1E9ms=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PClC+vG1uThDVTfM+pWeIlKtIxojIc9yakg4syHg0usxdY6hln1QmvCyDDXusqDGtT/IJtF/F1siwSIwIQ3dcDfD7ZJAWGL44p+AS58sI+uZv4ETG7V7eG1hU3S/N6RqQ5E8K5Xz8HAP5l1WB3/CMXC5bV2XHjykmdgTweEPkRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=GIyZFXoC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UY5iSKxM; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="GIyZFXoC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UY5iSKxM"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 112877A01AC;
	Mon, 10 Nov 2025 19:04:54 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Mon, 10 Nov 2025 19:04:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1762819493; x=
	1762905893; bh=NOp0Z21tr9vELXbxLqheXVxdFB00GQTS34WRdp2GjrY=; b=G
	IyZFXoCKVZC5Av47KjvgAvO6I8y+cAQBlHg9ukoMCeWuN+VYhXQD1g73dQ0H/xIp
	oWUkGTJR1Pf1CHsC4OxH2r/Bb+B8zrzbyQvk25bBAIO9iqIzAaH8sFVScODiY7y8
	wD2MC1MZYy+ykmU9sD1FmPAcOK7AyuysNG9OMjU+cnw6VEI5ev13OPl2kX9cqqus
	GDFWmu7PXtYi7fzmz518YzBaRvxDuYPYgHzWY+TKjYYUPKmugPaxiTY8ZfM33phS
	uXJRVATYOXsDBNxjgINTNeyUpVxgHlUXdLv+7B2kfo1kdPDRkgADu/Mx4WImyo4O
	96v10uK5JI4mI4rxgBPDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1762819493; x=1762905893; bh=NOp0Z21tr9vELXbxLqheXVxdFB00
	GQTS34WRdp2GjrY=; b=UY5iSKxMCUfSihlXYt6L3GRg6L9SvwivTGV/9p88RL01
	9YG3213J2Kv7mgJzSgPTXQl5orX9NM717L5HqZSBEX+osRrDTp8GS6Ef/khrhMvO
	8gpQH1cyqqdxCCgLSXQuuUFF0jt1Sl+k+BYsHHkrlbv25gjzQhG4WN7nwCRmotIW
	3rEM19Z11KkNooC+AidjQoStuPsJ5hvU369Dwgi+UPZidxhn0sUnQ6qtbA7XtO5R
	PnYMBFAzIr4h4yRywnUZurpcMcgslJAkEw1kW7l2IoMH4kQE1HhFpNpEJ65tPtQi
	1lsds0345XAAXBpH9n4o15PmXj3VD5rOaFRf+yn92g==
X-ME-Sender: <xms:pX0SaZKIi5SbsLOM0nIebZC_eqT0u4-G4LV-BMXg8LEmUMgRGJA24w>
    <xme:pX0SabLxR_dy9dzkNcM9WDLub2dyxLVhJlRKM67c5sgObMuTRXKDtulkYvYQSQ4oT
    FzsKfpTEoJ6fMo3oIGQCWf5hyR-URx1f1g6G0_gCj2ig4pFGwACMw>
X-ME-Received: <xmr:pX0SafXKKE3esJR1A4IUUenhnizykwEyIS2hbxXV_G3C9TbqIwM2tFI-lck8scfmAgCZNDho2kMjBT_gM72phnoUWBcQ15bRuM5d>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduleeljeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekredtre
    dttdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphho
    sghogidrtghomheqnecuggftrfgrthhtvghrnhepfeeuveevledtteefgeevteeihfehhf
    dtudfhtedtteefgfffudfflefggfeghefgnecuffhomhgrihhnpehkvghrnhgvlhdrohhr
    ghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:pX0SaVjRbDgKA9K1nD_p7fN2jY9NnOyeNDTBSlPasYUh63kIBmpixQ>
    <xmx:pX0SaS-wUAGC5MibHu_XuWG-NGoN4O8qda838IOm-OtLUpZBDzqtqA>
    <xmx:pX0SaXApkdjwm1ahphIhJAQaAAwPCyvxS9RK8f-e-lrIjpqbaQtfsA>
    <xmx:pX0SaXL33c-wxgzYptYiukfLGBvTx8p1zRG_9RrEFefhjKzMubzwDA>
    <xmx:pX0SachHego8Ofz3XYduW7GYfcC61aa-wZuo7dnrmtVi8UOT_yZpMxjf>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Nov 2025 19:04:53 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v3 00/12] Incomplete lines
Date: Mon, 10 Nov 2025 16:04:39 -0800
Message-ID: <20251111000451.2243195-1-gitster@pobox.com>
X-Mailer: git-send-email 2.52.0-rc1-455-g30608eb744
In-Reply-To: <20251105213052.1499224-1-gitster@pobox.com>
References: <20251105213052.1499224-1-gitster@pobox.com>
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


Changes in v3:

 - The proposed log message of [PATCH 05/12] explains that it
   semi-duplicates the same code shared in two case arems in
   preparation for later changes.

 - The internal helper function to emit the "\ No newline" marker
   line is now called emit_incomplete_line_marker().

 - Two conditionals in [PATCH 07/12] both of which switched on !endp
   have been consolidated into a single if/else statement.

 - The tests in [PATCH 11/12] checks the output from "diff --check"
   now.


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
 diff.c                         | 152 ++++++++++++++++++---------
 diff.h                         |   6 +-
 t/t4015-diff-whitespace.sh     |  67 +++++++++++-
 t/t4124-apply-ws-rule.sh       | 187 +++++++++++++++++++++++++++++++++
 ws.c                           |  20 ++++
 ws.h                           |  26 +++--
 9 files changed, 455 insertions(+), 88 deletions(-)

Range-diff against v2:
 1:  c045e93ce5 =  1:  c045e93ce5 whitespace: correct bit assignment comments
 2:  0d95d68fb4 =  2:  0d95d68fb4 diff: emit_line_ws_markup() if/else style fix
 3:  c331218334 =  3:  c331218334 diff: correct suppress_blank_empty hack
 4:  be1473fc5a =  4:  be1473fc5a diff: fix incorrect counting of line numbers
 5:  7bcd6efba8 !  5:  9410e4257a diff: refactor output of incomplete line
    @@ Commit message
         the code path that handles xdiff output and the code path that
         bypasses xdiff and produces complete rewrite patch.
     
    +    Currently the output from the DIFF_SYMBOL_CONTEXT_INCOMPLETE case
    +    still (ab)uses the same code as what is used for context lines, but
    +    that would change in a later step where we introduce support for
    +    incomplete line detection.
    +
         Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
      ## diff.c ##
    @@ diff.c: static void emit_context_line(struct emit_callback *ecbdata,
      	emit_diff_symbol(ecbdata->opt, DIFF_SYMBOL_CONTEXT, line, len, flags);
      }
      
    -+static void emit_incomplete_line(struct emit_callback *ecbdata,
    -+				 const char *line, int len)
    ++static void emit_incomplete_line_marker(struct emit_callback *ecbdata,
    ++					const char *line, int len)
     +{
     +	emit_diff_symbol(ecbdata->opt, DIFF_SYMBOL_CONTEXT_INCOMPLETE,
     +			 line, len, 0);
    @@ diff.c: static int fn_out_consume(void *priv, char *line, unsigned long len)
      		}
     -		emit_diff_symbol(o, DIFF_SYMBOL_CONTEXT_INCOMPLETE,
     -				 line, len, 0);
    -+		emit_incomplete_line(ecbdata, line, len);
    ++		emit_incomplete_line_marker(ecbdata, line, len);
      		break;
      	default:
      		BUG("fn_out_consume: unknown line '%s'", line);
 6:  1a6f143377 =  6:  cdc6516009 diff: call emit_callback ecbdata everywhere
 7:  dfc810b1d6 !  7:  9acb9b6217 diff: update the way rewrite diff handles incomplete lines
    @@ diff.c: static void emit_rewrite_lines(struct emit_callback *ecbdata,
     +		char *pdata = NULL;
      
      		endp = memchr(data, '\n', size);
    - 		len = endp ? (endp - data + 1) : size;
    -+		plen = len;
    +-		len = endp ? (endp - data + 1) : size;
     +
    -+		if (!endp) {
    ++		if (endp) {
    ++			len = endp - data + 1;
    ++			plen = len;
    ++		} else {
    ++			len = size;
     +			plen = len + 1;
     +			pdata = xmalloc(plen + 2);
     +			memcpy(pdata, data, len);
    @@ diff.c: static void emit_rewrite_lines(struct emit_callback *ecbdata,
     +	if (!endp) {
     +		static const char nneof[] = "\\ No newline at end of file\n";
     +		ecbdata->last_line_kind = prefix;
    -+		emit_incomplete_line(ecbdata, nneof, sizeof(nneof) - 1);
    ++		emit_incomplete_line_marker(ecbdata, nneof, sizeof(nneof) - 1);
     +	}
      }
      
 8:  c66b547f13 =  8:  86c14ee62d apply: revamp the parsing of incomplete lines
 9:  bdc2dbbe4b =  9:  b62d4020e7 whitespace: allocate a few more bits and define WS_INCOMPLETE_LINE
10:  806aa30511 = 10:  081c21b14e apply: check and fix incomplete lines
11:  0cfb6ab295 ! 11:  73182b19a8 diff: highlight and error out on incomplete lines
    @@ diff.c: static void emit_diff_symbol_from_struct(struct diff_options *o,
      		emit_line(o, set, reset, line, len);
      		break;
     @@ diff.c: static void emit_context_line(struct emit_callback *ecbdata,
    - static void emit_incomplete_line(struct emit_callback *ecbdata,
    - 				 const char *line, int len)
    + static void emit_incomplete_line_marker(struct emit_callback *ecbdata,
    + 					const char *line, int len)
      {
     +	int last_line_kind = ecbdata->last_line_kind;
     +	unsigned flags = (last_line_kind == '+'
    @@ t/t4015-diff-whitespace.sh: do
     +'
     +
     +test_expect_success "incomplete lines on both pre- and post-image" '
    -+	# The interpretation taken here is "since you are toucing
    ++	# The interpretation taken here is "since you are touching
     +	# the line anyway, you would better fix the incomplete line
     +	# while you are at it."  but this is debatable.
     +	echo foo | tr -d "\012" >x &&
     +	git add x &&
     +	echo bar | tr -d "\012" >x &&
     +	git diff x &&
    -+	test_must_fail git -c core.whitespace=incomplete diff --check x &&
    ++	test_must_fail git -c core.whitespace=incomplete diff --check x >error &&
    ++	test_grep "no newline at the end of file" error &&
     +	git diff -R x &&
    -+	test_must_fail git -c core.whitespace=incomplete diff -R --check x
    ++	test_must_fail git -c core.whitespace=incomplete diff -R --check x >error &&
    ++	test_grep "no newline at the end of file" error
     +'
     +
     +test_expect_success "fix incomplete line in pre-image" '
    @@ t/t4015-diff-whitespace.sh: do
     +	git diff x &&
     +	git -c core.whitespace=incomplete diff --check x &&
     +	git diff -R x &&
    -+	test_must_fail git -c core.whitespace=incomplete diff -R --check x
    ++	test_must_fail git -c core.whitespace=incomplete diff -R --check x >error &&
    ++	test_grep "no newline at the end of file" error
     +'
     +
     +test_expect_success "new incomplete line in post-image" '
    @@ t/t4015-diff-whitespace.sh: do
     +	git add x &&
     +	echo bar | tr -d "\012" >x &&
     +	git diff x &&
    -+	test_must_fail git -c core.whitespace=incomplete diff --check x &&
    ++	test_must_fail git -c core.whitespace=incomplete diff --check x >error &&
    ++	test_grep "no newline at the end of file" error &&
     +	git diff -R x &&
     +	git -c core.whitespace=incomplete diff -R --check x
     +'
12:  33c5ae40db = 12:  85748701b4 attr: enable incomplete-line whitespace error for this project
-- 
2.52.0-rc1-455-g30608eb744


Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 530F635CBA9
	for <git@vger.kernel.org>; Wed, 12 Nov 2025 22:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762984984; cv=none; b=MfUDkVP4R2Gu1bQi0acQ0NQJfeOx0MAG2YoxfRVcpi/lDw9NJf4b2q7WZuEEupGLpXk6zS9ffUARNhnnOxuMvcgGcfo6xNIxPM2WT6eN9lpch1GRj0IrGqjMua02eDA9cEoUn+p9oDra8nixyPexyo8BZ+SFlE6E9PM0bvC75ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762984984; c=relaxed/simple;
	bh=1MxAa9Bb2qVZvMItIbhEv/WMKVOC/M7FhkzQwePqxII=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kJarLNYh4CM4pGEaw5+e1olwFJfPHKhCqO4g3efSMu7MLWSY1GX9ZS0neojzfVSeTfzP3h/A1F8CBL9A+fg9FYWMxoapo+jKykrbaGN3UxE3w91Ac4aMKiv8PxkJ0iVffwU5LJ98Kwx2e7HlpqXOrS8xhlCidUGs8X2d2Za/Xkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=SyGsihi8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AWaR8aKH; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="SyGsihi8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AWaR8aKH"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5F7807A00A9;
	Wed, 12 Nov 2025 17:03:00 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Wed, 12 Nov 2025 17:03:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1762984980; x=
	1763071380; bh=Wiv4f0eHdQlWr6C7TTVs0nV6ukQ0CYLKSo95MYMCUwI=; b=S
	yGsihi80ioJLC6RBPpfbV5TJbercgK2ZahL23PVD0+D0rjqRadJXcQ3BahvybxCd
	LVMqmj2TFCcZSx1mAH3AoKOHdkDd52k0mA/3J7/IYkr4ImSlPbNbnh6UXH3VbBzs
	G0FJXPKK6d9AmJ4jz+f3pnFp/v9uM2v0AyJr/g2UHXPLvmscUHt1B3nsjEfXWlkp
	48XjWDkHbU+oJmf/Ma+s1duMVE80qwFadGPWPpi3FFAPRbHIFTpH9mPiJ1xYKQYr
	4vblzX47yZhkmu5jPiLP4iBTqdpO3dGREU7irRGNsajY1x3w/LXdAas2sKyNPNAS
	cAuIna720OlXBUFxLENrQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1762984980; x=1763071380; bh=Wiv4f0eHdQlWr6C7TTVs0nV6ukQ0
	CYLKSo95MYMCUwI=; b=AWaR8aKHo5W7zW+IN28mQBaDYpxcTqPzv/Lsvp1HP9Lf
	OsuMsbBgnSI0A9b5ABlRG6rGHsiWGpY1CYQg/PRL5JipB6IC4FeeexFuBeMqefdx
	X6ObFxt8cJrl3osHSpuDu83ZT5EIlVR9g3eeYDNgFYh6n5WkGd+x2Ily3uCvHgwH
	NmSmteP68rF2NK2dMSc5M3Szqfo9/JvWRguaPgyMZc9vsWgpJFifva0yGBj6+cV3
	HmGCIkbnOijp8eaF5U1iA3L7cW7wZX0vtzgHkyF4RZuZlqaNofiF9UxN7RMr/WO7
	Ofn1p5+ep4vAN5kkXhOVYswoaMQDlKrlLEouSzZD0w==
X-ME-Sender: <xms:FAQVab4OWhwphu94ZlQx8PQq638cGiueqQqztCRthcpt_04VYna6zA>
    <xme:FAQVaW6aUi8gjIxEu3bEilmrtPnUV-iZHF0fxxEGPQog8kNOFjq1JDJtulTkxJ7NS
    crrfELA8u8lHTLN9pSw1Bq82gmjWa-rrRaONTmaRbKccFH87zN0Ug>
X-ME-Received: <xmr:FAQVaQGLm1JUvmrQHNqz_55xUCVhfIhH2A4jUluQk1ZtJdHBmGSWA9UfEPUn8msV-yHhLHfBuL2ZmRUzeagAeX1Jexb3RB_JFN2r>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtdehvddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekredtre
    dttdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphho
    sghogidrtghomheqnecuggftrfgrthhtvghrnhepleevieefieeuffeugefhveeugefgfe
    evvdefleevuedvfedvudefkeehtdeftdegnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspg
    hrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhm
X-ME-Proxy: <xmx:FAQVaXRe4xW-DFAX_J8MCxDGCogqu9QVy4A9t45zflpFAEDvwjbLaQ>
    <xmx:FAQVaRvtYS2l5zGaPlcz2b15ADX-4NIs6vJEHdX1VGmnoiafyuRhFA>
    <xmx:FAQVaewhNOp8QXftno63GArIkFlReLeFMH2pnR5o4UfbdsIHs8kH1w>
    <xmx:FAQVaT4s0VfKvezcxjnJlimHAHWBUbu9yHkhFCLyJ94IRdje486vag>
    <xmx:FAQVafRTw4okApRHcDgt5uPMV_5E5JmIGfZCZkzjAU8kULF1obaVhz7I>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Nov 2025 17:02:59 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v4 00/12] Incomplete lines
Date: Wed, 12 Nov 2025 14:02:46 -0800
Message-ID: <20251112220258.1009253-1-gitster@pobox.com>
X-Mailer: git-send-email 2.52.0-rc2-441-g030905368a
In-Reply-To: <20251111000451.2243195-1-gitster@pobox.com>
References: <20251111000451.2243195-1-gitster@pobox.com>
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

 * The first patch [01/12] is a preliminary clean-up to reformat the
   definition of bit assignments for whitespace error classes.

 * The patches [02/12] - [08/12] are preliminary clean-up made to
   both "git diff" and "git apply" machinery.

 * The patch [09/12] shifts the bit assignment to make room for new
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


Changes in v4:

 - The preliminary clean-up for "git diff" in [04/12] no longer
   "corrects" the code that updates the line number upon seeing
   "\ No newline" marker, and leaves it for later series to clean
   it up as #leftoverbits.

 - Our house rule updates in [12/12] now forbids the documentation
   sources *.adoc to end in an incomplete line.

 - Some typofixes in log messages.

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
  diff: keep track of the type of the last line seen
  diff: refactor output of incomplete line
  diff: call emit_callback ecbdata everywhere
  diff: update the way rewrite diff handles incomplete lines
  apply: revamp the parsing of incomplete lines
  whitespace: allocate a few more bits and define WS_INCOMPLETE_LINE
  apply: check and fix incomplete lines
  diff: highlight and error out on incomplete lines
  attr: enable incomplete-line whitespace error for this project

 .gitattributes                 |   6 +-
 Documentation/config/core.adoc |   2 +
 apply.c                        |  79 ++++++++++----
 diff.c                         | 145 ++++++++++++++++---------
 diff.h                         |   6 +-
 t/t4015-diff-whitespace.sh     |  67 +++++++++++-
 t/t4124-apply-ws-rule.sh       | 187 +++++++++++++++++++++++++++++++++
 ws.c                           |  20 ++++
 ws.h                           |  26 +++--
 9 files changed, 450 insertions(+), 88 deletions(-)

 1:  39ce594b48 =  1:  5486212662 whitespace: correct bit assignment comments
 2:  7c53ac154b =  2:  89504329a4 diff: emit_line_ws_markup() if/else style fix
 3:  239644a8b4 =  3:  78f55aebf6 diff: correct suppress_blank_empty hack
 4:  a2c279cca0 !  4:  9f6b6ad756 diff: fix incorrect counting of line numbers
    @@ Metadata
     Author: Junio C Hamano <gitster@pobox.com>
     
      ## Commit message ##
    -    diff: fix incorrect counting of line numbers
    +    diff: keep track of the type of the last line seen
     
         The "\ No newline at the end of the file" can come after any of the
         "-" (deleted preimage line), " " (unchanged line), or "+" (added
    -    postimage line).  Incrementing only the preimage line number upon
    -    seeing it does not make any sense.
    +    postimage line).  In later steps in this series, we will start
    +    treating a change that makes a file to end in an incomplete line
    +    as a whitespace error, and we would need to know what the previous
    +    line was when we react to "\ No newline" in the diff output.  If
    +    the previous line was a context (i.e., unchanged) line, the file
    +    lacked the final newline before the change, and the change did not
    +    touch that line and left it still incomplete, so we do not want to
    +    warn in such a case.
     
    -    We can keep track of what the previous line was, and increment
    -    lno_in_{pre,post}image variables properly, like this patch does.  I
    -    do not think it matters, as these numbers are used only to compare
    -    them with blank_at_eof_in_{pre,post}image to issue the warning every
    -    time we see an added line, but by definition, after we see "\ No
    -    newline at the end of the file" for an added line, we will not see
    -    an added line for the file.
    +    Teach fn_out_consume() function to keep track of what the previous
    +    line was, and prepare an otherwise empty switch statement to let us
    +    react differently to "\ No newline" based on that.
     
    -    Keeping track of what the last line was (in other words, "is it that
    -    the file used to end in an incomplete line?  The file ends in an
    -    incomplete line after the change?  Both the file before and after
    -    the change ends in an incomplete line that did not change?") will be
    -    independently useful.
    +    Note that there is an existing curiosity (read: likely to be a bug)
    +    in the code that increments line number in the preimage file every
    +    time it sees a line with "\ No newline" on it, regardless of what
    +    the previous line was.  I left it as-is, because it does not affect
    +    the main theme of this series, and more importantly, I do not think
    +    it matters, as these numbers are used only to compare them with
    +    blank_at_eof_in_{pre,post}image to issue a warning when we see more
    +    empty line was added at the end, but by definition, after we see
    +    "\ No newline at the end of the file" for an added line, we will not
    +    see an added line for the file.
    +
    +    An independent audit to ensure that this curious increment can be
    +    safely removed would make a good #leftoverbits clean-up (we may even
    +    find some code that decrements this counter or over-increments the
    +    other quantity this counter is compared with that compensates the
    +    effect of this curious increment that hides a bug, in which case we
    +    may also need to remove them).
     
         Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
    @@ diff.c: static int fn_out_consume(void *priv, char *line, unsigned long len)
      		break;
      	case '\\':
      		/* incomplete line at the end */
    --		ecbdata->lno_in_preimage++;
     +		switch (ecbdata->last_line_kind) {
     +		case '+':
    -+			ecbdata->lno_in_postimage++;
    -+			break;
     +		case '-':
    -+			ecbdata->lno_in_preimage++;
    -+			break;
     +		case ' ':
    -+			ecbdata->lno_in_preimage++;
    -+			ecbdata->lno_in_postimage++;
     +			break;
     +		default:
     +			BUG("fn_out_consume: '\\No newline' after unknown line (%c)",
     +			    ecbdata->last_line_kind);
     +		}
    + 		ecbdata->lno_in_preimage++;
      		emit_diff_symbol(o, DIFF_SYMBOL_CONTEXT_INCOMPLETE,
      				 line, len, 0);
    - 		break;
    +@@ diff.c: static int fn_out_consume(void *priv, char *line, unsigned long len)
      	default:
      		BUG("fn_out_consume: unknown line '%s'", line);
      	}
 5:  7a91bf04be !  5:  16dda4fe13 diff: refactor output of incomplete line
    @@ Commit message
         Create a helper function that reacts to "\ No newline at the end of
         file" in preparation for unifying the incomplete line handling in
         the code path that handles xdiff output and the code path that
    -    bypasses xdiff and produces complete rewrite patch.
    +    bypasses xdiff and produces a complete-rewrite patch.
     
         Currently the output from the DIFF_SYMBOL_CONTEXT_INCOMPLETE case
         still (ab)uses the same code as what is used for context lines, but
    -    that would change in a later step where we introduce support for
    -    incomplete line detection.
    +    that would change in a later step where we introduce support to treat
    +    an incomplete line as a whitespace error.
     
         Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
    @@ diff.c: static void emit_context_line(struct emit_callback *ecbdata,
      			     const char *line, int len)
      {
     @@ diff.c: static int fn_out_consume(void *priv, char *line, unsigned long len)
    - 			BUG("fn_out_consume: '\\No newline' after unknown line (%c)",
      			    ecbdata->last_line_kind);
      		}
    + 		ecbdata->lno_in_preimage++;
     -		emit_diff_symbol(o, DIFF_SYMBOL_CONTEXT_INCOMPLETE,
     -				 line, len, 0);
     +		emit_incomplete_line_marker(ecbdata, line, len);
 6:  3f56e084f8 =  6:  dd310cc6dc diff: call emit_callback ecbdata everywhere
 7:  af5b4c94e4 =  7:  3360f2882c diff: update the way rewrite diff handles incomplete lines
 8:  e4945e8951 =  8:  ff29d34f3c apply: revamp the parsing of incomplete lines
 9:  d4fd89039a =  9:  b720c4f49d whitespace: allocate a few more bits and define WS_INCOMPLETE_LINE
10:  075ef5d32f = 10:  5ddf90cd08 apply: check and fix incomplete lines
11:  04401decef = 11:  cf52c68ec1 diff: highlight and error out on incomplete lines
12:  068229790d ! 12:  cb86d9b45f attr: enable incomplete-line whitespace error for this project
    @@ Commit message
     
         Now "git diff --check" and "git apply --whitespace=warn/fix" learned
         incomplete line is a whitespace error, enable them for this project
    -    to prevent patches to add new incomplete lines to our sources.
    +    to prevent patches to add new incomplete lines to our source to both
    +    code and documentation files.
     
         Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
    @@ .gitattributes
      *.perl text eol=lf diff=perl
      *.pl text eof=lf diff=perl
      *.pm text eol=lf diff=perl
    + *.py text eol=lf diff=python
    + *.bat text eol=crlf
    + CODE_OF_CONDUCT.md -whitespace
    +-/Documentation/**/*.adoc text eol=lf
    ++/Documentation/**/*.adoc text eol=lf whitespace=!indent,trail,space,incomplete
    + /command-list.txt text eol=lf
    + /GIT-VERSION-GEN text eol=lf
    + /mergetools/* text eol=lf


-- 
2.52.0-rc2-441-g030905368a


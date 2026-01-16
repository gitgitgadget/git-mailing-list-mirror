Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87722EBB8F
	for <git@vger.kernel.org>; Fri, 16 Jan 2026 22:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768602378; cv=none; b=rmVQJVmlEMTi+Vn9PsjFkT35VM7JPtdonfLTPbP5y6jYWenQ1kZ5qyJ1OeTyqM06HzEHVcDIs34tGPixRFUfONKQI7/SuuSiU8tsHYr+vvooWjoNkIXOP6AQ/8ObHUAzy1bJWgW+WP9eEqNB+u32DUNS+VjkYAswsK7G20pONI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768602378; c=relaxed/simple;
	bh=nr8EyInKxc9oKyfteBHVed8J016zM9iDOE3ZY9UHEkU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Pwi2YC4pneC54td/IDQf64aIupuItDBOueyiLie90uDY01swSh8jBYhUSvpG19L42+lslS6EZJ1FDbCtqNo3n0GOcufCHOJhbjCRjefI40aYq3CieraimrgjdfXha52IWOUwTWKX1SX5XrzvcnS0bB3sInq2mHTleqTlh9qvNok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aiXhTQ+x; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aiXhTQ+x"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-88a2ad13c24so23642626d6.1
        for <git@vger.kernel.org>; Fri, 16 Jan 2026 14:26:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768602375; x=1769207175; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BU3GErQr0MxDQbGH+5oCV38YL/almzU1oI9ZwcSk5rw=;
        b=aiXhTQ+xLgu1nPOexbm/1udi0L/QFtvxcoFcfuGaB0gd9IcXteg8TDWMA2mZyamgvY
         H6QHShDwetWyFWh86pkYxhObLD8dFjzwPsIYpFiVtKSCcYWDzZn6Lc03tqxsbeiPBFRF
         fWnmTX3bwYPoTmJ8vls4oRtq7u54N6goH/qg6KAZFwoWrLEOKqjBw5y5Wjr5uSF0zi7D
         SPLBZ9RH6iq0DRg8cINScTWKP+NrxBs2n63Zx1hAOZWWa+x4QUDaz9i5wUeTSoGEeV2b
         mO8yhBOEJ9oeZ1WROqD5jYT2c1oC0QMzqjwCLWvn1+gextMqJI5hbR3ozw/enKAFxHm6
         Blgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768602375; x=1769207175;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BU3GErQr0MxDQbGH+5oCV38YL/almzU1oI9ZwcSk5rw=;
        b=X54b9dbGWHat66/X1TxWK/qORsdB2sV1Huy/DvLmCWS5w2SMDVkuWgIJ40npWKRsY/
         ZcZ4xLN+dDFa1Ezy2NbnrUauFAQ0B71mrU11AH7atnPyQmPEXw+FgNuZABFwZVmughHa
         KVXM0PRH5Pqw+WwpPViKtLMKSToi5l93+2joBiV6qqVR0aLkO4kLqTt6JWJlx7FsdwjT
         BARWYWXBkVQnPpPnIHC+cdWEDepUT+6JxY/oKc6QK8Dka/oMhr7BmuBTkGhUOzQK0OBp
         oc/JIr6Pm/f5KeHjqQgtwLIMulXHlr+8YQHbE57ftyL3b5sn/Xx9QjEAOiknnxL8BFbq
         ImmA==
X-Gm-Message-State: AOJu0YwP8cHavthKzWnijDkk7O6CfkBPEO2W5EJvlQHhVyfiQCzdeZ3Q
	mZB7fnjpLIRJ4WL9XnCVUvOk1Mw7YxMGeaSuJdBX/tInlih6K+P6A8fpa1LmQg==
X-Gm-Gg: AY/fxX49Swk3dKseHLI0QqeEfshSbd1hsyvyFAz8xe+OcJqLlTLJoltlOB/guMuanLa
	7cQzCi13bNHfhoCsgHTJyG677eVJuGSY5/f3vaUTnNLAeSA0FA9uM8/kH2059hs0IDSQU0p9VIG
	4GoiNl9T8RjvT+3+K27diTm/RjGHLO/ox/fM4rLtJCdCnhuFreh577ttPa7BYPnTPjqg930YfVg
	dJVXCB5hJaIwPli/VYwoVOKzcCmFx+xyO6iZzF5280SrmwXnpjezABwLAnC3I1bLrZEsXKUTa+h
	MmYMEscahPzOTRp+6k9lts/fD5Iy2L1Sej1tEYp4dzAQEH3f+qf2s5pJ5qQH//w4KIrxzWLzLbN
	losyR31K7A/p405o1stlsH3/WyxryH0Ou7GnaSmFq9lk0EOBZ1yJCwFAbC1emnexSE9uRLO0hCs
	UqNXRGoXo6TLFlRg==
X-Received: by 2002:a05:6214:2582:b0:888:8557:69e6 with SMTP id 6a1803df08f44-8942dd8c597mr70342756d6.47.1768602375404;
        Fri, 16 Jan 2026 14:26:15 -0800 (PST)
Received: from [127.0.0.1] ([64.236.153.100])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8942e5e4a3csm34064026d6.5.2026.01.16.14.26.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 14:26:14 -0800 (PST)
Message-Id: <pull.1853.v3.git.1768602373.gitgitgadget@gmail.com>
In-Reply-To: <pull.1853.v2.git.1765981422.gitgitgadget@gmail.com>
References: <pull.1853.v2.git.1765981422.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 16 Jan 2026 22:26:08 +0000
Subject: [PATCH v3 0/5] Sanitize sideband channel messages
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Andreas Schwab <schwab@linux-m68k.org>,
    Ondrej Pohorelsky <opohorel@redhat.com>,
    Patrick Steinhardt <ps@pks.im>,
    Jeff King <peff@peff.net>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

Git's sideband channel passes server output directly to the client terminal
without sanitization. This includes progress messages, error output, and
diagnostics from remote hooks during clone, fetch, and push operations.

This creates an ANSI escape sequence injection vulnerability (CWE-150
[https://cwe.mitre.org/data/definitions/150.html]). A malicious or
compromised server can corrupt terminal state, obscure information, or
inject characters into the terminal's input buffer. The client has no
mechanism to distinguish between legitimate output and attack sequences.

This series fixes the vulnerability by sanitizing control characters in the
sideband output. ANSI color sequences (SGR codes) pass through by default,
since server-side hooks exist that use these for visibility (e.g.
https://github.com/kikeonline/githook-explode). By default, all other
control characters are rendered in caret notation (e.g., ESC becomes ^[).

Users who need different behavior get configuration options:
sideband.allowControlCharacters provides an escape hatch for environments
that require raw passthrough. The defaults are secure.

Note: This series applies cleanly on v2.47.3. Integrating this into newer
versions is a bit cumbersome; I pushed a version of the branch as rebased to
v2.53.0-rc0 here:
https://github.com/dscho/git/tree/refs/heads/sanitize-sideband-2.53.0-rc0

Changes since v2:

 * Added curly brackets around a single-line if clause.
 * Enclosed the values in the documentation within backticks.
 * Aligned the enum values for better readability.
 * Added support for sideband.<url>.allowControlCharacters (à la
   http.<url>.*) on top of sideband.allowControlCharacters.

Changes since v1:

 * Applied the suggestions by Phillip and brian.
 * Rebased onto v2.47.3.
 * Added more categories of ANSI Escape sequences that can be enabled (but
   that are off by default because they could be used to hide information).

Johannes Schindelin (5):
  sideband: mask control characters
  sideband: introduce an "escape hatch" to allow control characters
  sideband: do allow ANSI color sequences by default
  sideband: add options to allow more control sequences to be passed
    through
  sideband: offer to configure sanitizing on a per-URL basis

 Documentation/config.txt            |   2 +
 Documentation/config/sideband.txt   |  28 +++++
 sideband.c                          | 181 +++++++++++++++++++++++++++-
 sideband.h                          |  14 +++
 t/t5409-colorize-remote-messages.sh |  92 ++++++++++++++
 transport.c                         |   3 +
 6 files changed, 318 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/config/sideband.txt


base-commit: a52a24e03c8c711f1d5e252fba78f9276908129b
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1853%2Fdscho%2Fsanitize-sideband-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1853/dscho/sanitize-sideband-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1853

Range-diff vs v2:

 1:  8d70476559 ! 1:  e6b71af0ca sideband: mask control characters
     @@ sideband.c: void list_config_color_sideband_slots(struct string_list *list, cons
      +{
      +	strbuf_grow(dest, n);
      +	for (; n && *src; src++, n--) {
     -+		if (!iscntrl(*src) || *src == '\t' || *src == '\n')
     ++		if (!iscntrl(*src) || *src == '\t' || *src == '\n') {
      +			strbuf_addch(dest, *src);
     -+		else {
     ++		} else {
      +			strbuf_addch(dest, '^');
      +			strbuf_addch(dest, *src == 0x7f ? '?' : 0x40 + *src);
      +		}
 2:  2615abd8c5 ! 2:  8f64d65844 sideband: introduce an "escape hatch" to allow control characters
     @@ sideband.c: void list_config_color_sideband_slots(struct string_list *list, cons
      +
       	strbuf_grow(dest, n);
       	for (; n && *src; src++, n--) {
     - 		if (!iscntrl(*src) || *src == '\t' || *src == '\n')
     + 		if (!iscntrl(*src) || *src == '\t' || *src == '\n') {
      
       ## t/t5409-colorize-remote-messages.sh ##
      @@ t/t5409-colorize-remote-messages.sh: test_expect_success 'disallow (color) control sequences in sideband' '
 3:  44585ba1f4 ! 3:  44838acacc sideband: do allow ANSI color sequences by default
     @@ Documentation/config/sideband.txt
      +	this config setting to override this behavior:
      ++
      +--
     -+	default::
     -+	color::
     ++	`default`::
     ++	`color`::
      +		Allow ANSI color sequences, line feeds and horizontal tabs,
      +		but mask all other control characters. This is the default.
     -+	false::
     ++	`false`::
      +		Mask all control characters other than line feeds and
      +		horizontal tabs.
     -+	true::
     ++	`true`::
      +		Allow all control characters to be sent to the terminal.
      +--
      
     @@ sideband.c: static struct keyword_entry keywords[] = {
       
      -static int allow_control_characters;
      +static enum {
     -+	ALLOW_NO_CONTROL_CHARACTERS = 0,
     -+	ALLOW_ANSI_COLOR_SEQUENCES = 1<<0,
     ++	ALLOW_NO_CONTROL_CHARACTERS  = 0,
     ++	ALLOW_ANSI_COLOR_SEQUENCES   = 1<<0,
      +	ALLOW_DEFAULT_ANSI_SEQUENCES = ALLOW_ANSI_COLOR_SEQUENCES,
      +	ALLOW_ALL_CONTROL_CHARACTERS = 1<<1,
      +} allow_control_characters = ALLOW_ANSI_COLOR_SEQUENCES;
     @@ sideband.c: void list_config_color_sideband_slots(struct string_list *list, cons
       	}
      @@ sideband.c: static void strbuf_add_sanitized(struct strbuf *dest, const char *src, int n)
       	for (; n && *src; src++, n--) {
     - 		if (!iscntrl(*src) || *src == '\t' || *src == '\n')
     + 		if (!iscntrl(*src) || *src == '\t' || *src == '\n') {
       			strbuf_addch(dest, *src);
     --		else {
     -+		else if ((i = handle_ansi_color_sequence(dest, src, n))) {
     ++		} else if ((i = handle_ansi_color_sequence(dest, src, n))) {
      +			src += i;
      +			n -= i;
     -+		} else {
     + 		} else {
       			strbuf_addch(dest, '^');
       			strbuf_addch(dest, *src == 0x7f ? '?' : 0x40 + *src);
     - 		}
      
       ## t/t5409-colorize-remote-messages.sh ##
      @@ t/t5409-colorize-remote-messages.sh: test_expect_success 'fallback to color.ui' '
 4:  fe109cd331 ! 4:  cc578465b9 sideband: add options to allow more control sequences to be passed through
     @@ Documentation/config/sideband.txt: sideband.allowControlCharacters::
      +	a comma-separated list of the following keywords):
       +
       --
     - 	default::
     - 	color::
     + 	`default`::
     + 	`color`::
       		Allow ANSI color sequences, line feeds and horizontal tabs,
       		but mask all other control characters. This is the default.
     -+	cursor::
     ++	`cursor:`:
      +		Allow control sequences that move the cursor. This is
      +		disabled by default.
     -+	erase::
     ++	`erase`::
      +		Allow control sequences that erase charactrs. This is
      +		disabled by default.
     - 	false::
     + 	`false`::
       		Mask all control characters other than line feeds and
       		horizontal tabs.
      
       ## sideband.c ##
      @@ sideband.c: static struct keyword_entry keywords[] = {
       static enum {
     - 	ALLOW_NO_CONTROL_CHARACTERS = 0,
     - 	ALLOW_ANSI_COLOR_SEQUENCES = 1<<0,
     -+	ALLOW_ANSI_CURSOR_MOVEMENTS = 1<<1,
     -+	ALLOW_ANSI_ERASE = 1<<2,
     + 	ALLOW_NO_CONTROL_CHARACTERS  = 0,
     + 	ALLOW_ANSI_COLOR_SEQUENCES   = 1<<0,
     ++	ALLOW_ANSI_CURSOR_MOVEMENTS  = 1<<1,
     ++	ALLOW_ANSI_ERASE             = 1<<2,
       	ALLOW_DEFAULT_ANSI_SEQUENCES = ALLOW_ANSI_COLOR_SEQUENCES,
      -	ALLOW_ALL_CONTROL_CHARACTERS = 1<<1,
      -} allow_control_characters = ALLOW_ANSI_COLOR_SEQUENCES;
     @@ sideband.c: static void strbuf_add_sanitized(struct strbuf *dest, const char *sr
       	}
      @@ sideband.c: static void strbuf_add_sanitized(struct strbuf *dest, const char *src, int n)
       	for (; n && *src; src++, n--) {
     - 		if (!iscntrl(*src) || *src == '\t' || *src == '\n')
     + 		if (!iscntrl(*src) || *src == '\t' || *src == '\n') {
       			strbuf_addch(dest, *src);
     --		else if ((i = handle_ansi_color_sequence(dest, src, n))) {
     -+		else if (allow_control_characters != ALLOW_NO_CONTROL_CHARACTERS &&
     -+			 (i = handle_ansi_sequence(dest, src, n))) {
     +-		} else if ((i = handle_ansi_color_sequence(dest, src, n))) {
     ++		} else if (allow_control_characters != ALLOW_NO_CONTROL_CHARACTERS &&
     ++			   (i = handle_ansi_sequence(dest, src, n))) {
       			src += i;
       			n -= i;
       		} else {
 -:  ---------- > 5:  f2eb0a758c sideband: offer to configure sanitizing on a per-URL basis

-- 
gitgitgadget

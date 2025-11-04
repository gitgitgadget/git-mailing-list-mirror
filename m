Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03EDA1E1E1E
	for <git@vger.kernel.org>; Tue,  4 Nov 2025 02:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762222174; cv=none; b=lxDdU2gbie3QKbB8vB3rlnpU3S4/tV34Sg3m1YvXubnoeRM7MLwZ70brpUFx/aaOg7SB0+MF0aN3aXqf8KESc9rGvVNuveDFLasT+9qFA1Eb4Jw+qlfd3iCGRA7wvXI2lIeB24PSsT7pOAmK9iwK0WOW/wofDAkw0VaNi1vYW64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762222174; c=relaxed/simple;
	bh=Jxo78C4S/QfmVgiOCLU5nyhjAwMfoEmyiXRoGvKJFTI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=lcN4SWt2AkYQNiCkUDWCo9ciwzx80pvcSo8L2QNFueBfxRQe0vZJ4xu5PN8Gik2IKPsQEcd4UjAX/tY+Qb+3Lly6QVzyzb5rcH8knfvyX3xdPBMgADJQWR0aU31gYYJ+wCKLzmzw9WNsexaZFsAkamLjDuQc8dbgU0mRnEYTsd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=jmQu3CzN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YxO0tWjW; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="jmQu3CzN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YxO0tWjW"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E46067A03F6;
	Mon,  3 Nov 2025 21:09:30 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Mon, 03 Nov 2025 21:09:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm2; t=1762222170; x=1762308570; bh=ypad7p5GgoIhj7Qbvoeyu
	ouoLkoW2uYgXPM4NXXcOXY=; b=jmQu3CzNEE2MstZHhS6MsONiPmZP/pQ7Neubg
	80SaiO3MYV9vBVMiRgat8Rbug+brVVMmZBMajjCDX/724tx2XVJ5TLkitMdoEFxi
	7gKXx8GwXHJjJgyBmjSmAzSczFefun2ROKsiy20HrEBUjSL+qXrRcu7HN5UFQ1Ts
	E/3EXwPqAxmjh9htacgsBoQwKwaGpElzgdEP/Pz70Fpp81jklX9B3W8rE7M49kDJ
	EbvBgmeExbrXMyvUkDL/4EWdN/J6wchyGk0hDxRXACfyI+8Z+swPzDgBAPRStbbR
	LF8eMX+cWVXXcYWRSs5ubaYyrT/sARUIm3aSILATA2sCiT4dw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1762222170; x=1762308570; bh=ypad7p5GgoIhj7QbvoeyuouoLkoW2uYgXPM
	4NXXcOXY=; b=YxO0tWjWTWDGwinvJgqF5TY3XvgDG32t1fMM7vikYWJhW8PfHcf
	02UvoVNCEONJUBEGMifOsk4A3rZvY7uKBOT99YXMsxazeTj9ezlxae8dDly6m2oi
	2dIGm5L4xG6BaRPhiqdjFH8OyZL2ATfr61QoCKF1Q6Tbb2OT8joqakIUACDjT437
	YY1cNxL+A/ahdVJi0q7snzMmX3tX6RylXjk5j6NC5/eRFYkRJceEFGa8+W1PkYVk
	JNdOvUFEoJE11JuOPywPMUMsE/5cM29se0BGNwn6754NWpL45tOoFCqGLi45ITwD
	XVLOb6KI0YaXmeNyIysmSMpQ/vqKf1gFOjA==
X-ME-Sender: <xms:WmAJaQrXPQpfgoGRPZydCUgmU2ejgKDN04_aO8JGESIGH-Q1aMl5Ig>
    <xme:WmAJacoqU62jWyZQS9aAQK5y_j3Q2cswpAY8UJT-7VQ7GflZvR0Dh3xegt9CpoxOE
    6jFXBs1m36ipG5KGTTS7rph_cHZbEeLCbiXIT9EdXkuLcVu4o_6gFk>
X-ME-Received: <xmr:WmAJaS2qW1ebD34sX7VsaQMZKQXVECG2SGtH_ruEwAxvKjZ7Mk6F44wvRjLXX1SuSNe8fS1oMqoTCW62QyJgZpQOjF9pL6SJJ7CV>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddujeeljeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtredttd
    enucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosgho
    gidrtghomheqnecuggftrfgrthhtvghrnhepledugfefvdejtdehtddujeekjedvieevgf
    ehteeugfdthfdvleegtefhudegjeeknecuffhomhgrihhnpehkvghrnhgvlhdrohhrghen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtsh
    htvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhp
    ohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpth
    htohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:WmAJaTAsQpxgFbUpJ-dyEvJtWrF86PoTEEIgTJhvuVlsuzNMlavU8A>
    <xmx:WmAJaSdu5kFdFc2znmIUnqKAqDYKHzROwUSF2l5XZmB5OJ8k9r3qew>
    <xmx:WmAJaQjcnxHhc1zhYNuC7L4RCIlT9cNF_Rm4p_vKuIZctyBAr9YRiA>
    <xmx:WmAJaSqStMM4F1dhWotnIZJy90f4zL4gyxKK89XqciLj3oH-uAUohA>
    <xmx:WmAJaXNT8-Qm6SojGmplDu3-V2_b44NW9U5q1TV43IpiO6kGZMSUkpF8>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Nov 2025 21:09:30 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH 00/12] Incomplete lines
Date: Mon,  3 Nov 2025 18:09:16 -0800
Message-ID: <20251104020928.582199-1-gitster@pobox.com>
X-Mailer: git-send-email 2.52.0-rc0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

One of the common kind of whitespace errors is to lack the
terminating newline at the end of a file, but so far, neither "git
diff" or "git apply" did anything about them.

This series introduces "incomplete-line" whitespace error class,
that you can add to either the core.whitespace configuration
variable, or the whitespace attribute in your .gitattributes files.
The class is disabled by default.

When incomplete-line whitespace error is enabled, a patch file that
has "\ No newline at the end of file" line for the postimage file is
considered to introduce a whitespace error.  This is true even if
the corresponding preimage file ends in a different contents on the
final line that is incomplete.  The incomplete line marker that is
given for a context line is not considered an error.  The reasoning
is that your preimage did have incomplete line, but you did not
touch the contents on that incomplete line in your patch, so you
left the line intact.  It is not a new breakage you are responsible
for.  If the incomplete line marker follows a postimage line, on the
other hand, it means that you either made a file that used to end
with a complete line to end with an incomplete line, or the file
ended with an incomplete line before your change, and you did not
fix it even though you modified other bytes on that same last line,
which you could have easily fixed while at it, and that is flagged
as an error.

 * "git diff --check" notices and errors out.

 * "git diff" and friends highlight the offending "\ No newline ..."
   line.

 * "git apply --whitespace=(error|warn)" triggers an error, and "git
   apply --whitespace=fix" would correct it by appending a newline.

The organization of the series is

 * The first patch [01/12] is a clean-up we have seen earlier on the
   list already (https://lore.kernel.org/git/xmqqfrb4hyjl.fsf@gitster.g/).

 * The patches [02/12] - [08/12] are preliminary clean-up made to
   both "git diff" and "git apply" machinery.

 * The patch [09/12] shifts the bit assignment (cleaned-up in
   [01/12] without changing any values) to make room for new
   whitespace error class (which was last updated in 2007 IIRC, so
   the set of whitespace errors surprisingly haven't changed for
   quite some time).

 * The patch [10/12] teaches "git apply --whitespace=<mode>" about
   the incomplete-line error class.

 * The patch [11/12] teaches "git diff [--check]" about the
   incomplete-line error class.

 * The final patch [12/12] enables the incomplete-line error class
   for our project for C source files and shell scripts.  I didn't
   touch the cover-all * entry.

Junio C Hamano (12):
  whitespace: correct bit assignment comments
  diff: emit_line_ws_markup() if/else style fix
  diff: correct suppress_blank_empty hack
  diff: fix incorrect counting of line numbers
  diff: refactor output of incomplete line
  diff: call emit_callback ecbdata everywhere
  diff: update the way rewrite diff handles incomplete lines
  apply: revamp the parsing of incomplete lines
  whitespace: allocate a few more bits
  apply: check and fix incomplete lines
  diff: highlight and error out on incomplete lines
  attr: enable incomplete-line whitespace error for this project

 .gitattributes             |   4 +-
 apply.c                    |  70 ++++++++++++------
 diff.c                     | 148 +++++++++++++++++++++++++------------
 diff.h                     |   6 +-
 t/t4015-diff-whitespace.sh |  63 +++++++++++++++-
 t/t4124-apply-ws-rule.sh   | 112 ++++++++++++++++++++++++++++
 ws.c                       |  20 +++++
 ws.h                       |  26 ++++---
 8 files changed, 361 insertions(+), 88 deletions(-)

-- 
2.52.0-rc0


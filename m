Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E35174ADD93
	for <git@vger.kernel.org>; Thu, 13 Aug 2026 17:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786641927; cv=none; b=blirk3MsSnA5ivO3aGEcAd3mcXWBy2gNn8oA309tfUZuTQ96/MDMH3/Pdxs7Be+TvZKX21EOwp44IpKotYeM5Fe/pSSVLxUVwpdx/dLWSGD+4ssf2uhkuN0rIShC3l3mwE5lpigMN6zOCCj8ghhNhiuklkd6RSLu1z8Wll60eZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786641927; c=relaxed/simple;
	bh=B+ObfA3sv0Qb0lXaLIygiFlxGapSEjrsSVXuuMr3gX8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LAV17o/FB5UArEG3ikQB046iDvFqvUctsOtOvFpCKxdvMIrm3d8IgbfcGinDkHxmEXo7sBNMO9I+PaqmX9+7Jwzwn9mMej389XXyt8Cb8qm8ELNHap07hci+G2oiV2D9IdDtxEmj57c2b248ijmVoH2Ufq0I1CW41KLX1FKPVA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=GGdBCrRx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OppgAqiP; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="GGdBCrRx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OppgAqiP"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id A6627EC01A1;
	Thu, 13 Aug 2026 13:25:21 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Thu, 13 Aug 2026 13:25:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1786641921;
	 x=1786728321; bh=mWRD2XwgYnAJsHsmIXncg9FzIb1jqHEOqin5EWjX8Yw=; b=
	GGdBCrRxe718OqucWV9WoBzgNbufNa/pIQQPeh+J9C2AEXXNfwyH3EreXbXVYLI/
	P9/Xo4GAUG5zJv5+iiW+SU4Lgfk9e0ldKfPgvKDoCGuxKP+tEhCiLf+UajeMB3fE
	R1Qs7JiveXgTS/DxfK6za2ujDQBm6ePbzjEWVatyNmVSvRCzeUzz5Rfrlqnbhjld
	b6xo1lUccUxJAswSgqT1tFNNy9u5GKy+GhC1PeYJEj9XMSaOIS5mI7nwZuVEzxg8
	JzyF3ckGWUAYdGT1vDXFpqjPdqj9NrNz5rFx2Xd+uxoe1XDSh4vJi8kqwqgACIVP
	HUD38Q6QTwQNAMSyuNzbqA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786641921; x=
	1786728321; bh=mWRD2XwgYnAJsHsmIXncg9FzIb1jqHEOqin5EWjX8Yw=; b=O
	ppgAqiPA4R+5egEUTOPZuV8acOdZlhUbPCbRek4CQjt0h0Yhnew8zIbqJiB/fkDl
	rIM+HUzmeHL3iVtYFh/qc/BzUjQ+VXeFvUJfeGZ/H8zFJxgq0U0p+V41g7f+8cV4
	/hZXUZkt4v8KfNbs11WBEZBrB4rZmT5Yu6chT2w5+gyTB+PHKxQWXswVeF8Bn5sx
	HFSO1meWiKNzl8CMYqFtn63LKwnbaUzYEllsQeYG7CREWHyJFtFzCdQFxtGVxR1F
	LBw0+Iph3gU1L09gxW2s7G3P3iNjlTVIBe08YB4EE8/oSBGAE2M/tgkazyDtq8TG
	c3ac10cM1R9/4c9TNcZwQ==
X-ME-Sender: <xms:Af59ajF3e6L1vr7rWGZYfNT7dMOgZtdw3z8uK-q-1op6lnfORSVAkuE>
    <xme:Af59amVlZ1OJ7QB9com-prX1MVPPyZ6IrHojqhmuoCC70YYxTuII4PlIB4SzbDdGQ
    aSp7Vi-NFiyjBz1K1ej0ZX2Ok4E9tNTFkM41oqYbQvvJeuK6IGveA>
X-ME-Received: <xmr:Af59aizgg6vCHrzb3VG8z_9gbKImY_qDdHjjGKHhLjfOgrkxTj3bOl0w20l-ajXGoAZrPDhqKDBQKx9wNeSm0BctCHWsUdNg2pg2kFoKcYaXsw2ERr5h1pQ>
X-ME-Proxy-Cause: dmFkZTEb+1JdBbr4bjqyOlMLGDEXPHFmtckxLu7/nsjUbc19wEwr8Uf3h+h1SG3PqrEZqu
    ne9MGHDJnQj14jq9YwQaxKdKRLvhGMZ/QRLKeBVztDZX/FMMLGCywVkNTw44+CMs9LogXg
    CWazUFNG8EhLyALGpvuramCByG1K4At579jy7Okcj2Na3JC7g/Xh3lsr/rO4uPtY8Bz+Y3
    GgdvFWgQ5d3nouby2EIi2CbcISHgMu8+Ihaxo+0M16qsL7zgtQPPeK4YEFCtN7k4RiyGko
    FTdhgNmoMEA79mrzaEejUNpEakwdcgy6lcey0cNxjL4eIXDQ18p/az0fZsLEDclBTBwaqE
    tB+0g3X6ZxlPUaE3ijo3eaX7uTPIWavi+qVB6OL12BmX4VFqJ/brdTaRRkRz5cCGdWW0Ms
    6Fvzgx4bHdcBeiQAL7oBzUMiBuP6m5kYDgNyOEBojsksAPW4/rrGeK/8YR6d+xFddHuggq
    2Dlr7Dimla/qon88LiwFxVLfDD38KMSmM2/o5Mq8AOgctW1lZlnJFGF1dflLeuR8Yz2+42
    cpHEMSWOJlFyCoY50nnMkIRdcd4G0L+STFre8/jkipWDlz6lG09roqsRNjjTJvKixvjZo2
    nmUmPJCMbPh9I754t8Agq3PZrUhAnaaVgr1kOeSiqjvjdk0j0kJV7V9cX+iA
X-ME-Proxy: <xmx:Af59asND-HpVFs7LKUaoWfzmCKHPKq0onS38mz_KdphPJnr9uwP2uw>
    <xmx:Af59ar6JIORipO7LaryrtUiN7SK3_s42r3bktCJD-MA3AWMF3L160Q>
    <xmx:Af59alNFW7ooK7g7g4EPT5SmVPSvaDAHinT7QDrr_jJYNxEqaVVybA>
    <xmx:Af59ahnJPRdDB8OeIGD4hODfRmsnVkj_2FHU4RNZg_JnZFAmsGKEUQ>
    <xmx:Af59aufxOC4gri0E_w-pE26gxkgD6MvXdE-p-fcRJOcc6HtD_mNoJB7k>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Aug 2026 13:25:20 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: [PATCH 3/4] doc: rev-list-options.adoc: factor out --date alts
Date: Thu, 13 Aug 2026 19:23:59 +0200
Message-ID: <doc_--date_alts.b83@msgid.xyz>
X-Mailer: git-send-email 2.54.0.22.g9e26862b904
In-Reply-To: <CV_format-rev_three_more_opts.b80@msgid.xyz>
References: <CV_format-rev_three_more_opts.b80@msgid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

We will introduce `--date` to git-format-rev(1) in the next commit and
will need to add it to the documentation. Let’s factor out the option
alternatives so that it can be included in git-format-rev(1).

The initial paragraph of this option mentions things like git-log(1).
We could make it fit in git-format-rev(1) while not changing it for
git-rev-list(1) and related commands with some conditionals like
`ifndef`, but writing a dedicated paragraph is simple enough.

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---
 .../rev-list-option-date-alternatives.adoc    | 55 ++++++++++++++++++
 Documentation/rev-list-options.adoc           | 56 +------------------
 2 files changed, 56 insertions(+), 55 deletions(-)
 create mode 100644 Documentation/rev-list-option-date-alternatives.adoc

diff --git a/Documentation/rev-list-option-date-alternatives.adoc b/Documentation/rev-list-option-date-alternatives.adoc
new file mode 100644
index 00000000000..141570b1059
--- /dev/null
+++ b/Documentation/rev-list-option-date-alternatives.adoc
@@ -0,0 +1,55 @@
+--
+`--date=relative` shows dates relative to the current time,
+e.g. ``2 hours ago''. The `-local` option has no effect for
+`--date=relative`.
+
+`--date=local` is an alias for `--date=default-local`.
+
+`--date=iso` (or `--date=iso8601`) shows timestamps in a ISO 8601-like format.
+The differences to the strict ISO 8601 format are:
+
+	- a space instead of the `T` date/time delimiter
+	- a space between time and time zone
+	- no colon between hours and minutes of the time zone
+
+`--date=iso-strict` (or `--date=iso8601-strict`) shows timestamps in strict
+ISO 8601 format.
+
+`--date=rfc` (or `--date=rfc2822`) shows timestamps in RFC 2822
+format, often found in email messages.
+
+`--date=short` shows only the date, but not the time, in `YYYY-MM-DD` format.
+
+`--date=raw` shows the date as seconds since the epoch (1970-01-01
+00:00:00 UTC), followed by a space, and then the timezone as an offset
+from UTC (a `+` or `-` with four digits; the first two are hours, and
+the second two are minutes). I.e., as if the timestamp were formatted
+with `strftime("%s %z")`).
+Note that the `-local` option does not affect the seconds-since-epoch
+value (which is always measured in UTC), but does switch the accompanying
+timezone value.
+
+`--date=human` shows the timezone if the timezone does not match the
+current time-zone, and doesn't print the whole date if that matches
+(ie skip printing year for dates that are "this year", but also skip
+the whole date itself if it's in the last few days and we can just say
+what weekday it was).  For older dates the hour and minute is also
+omitted.
+
+`--date=unix` shows the date as a Unix epoch timestamp (seconds since
+1970).  As with `--raw`, this is always in UTC and therefore `-local`
+has no effect.
+
+`--date=format:<format>` feeds the _<format>_ to your system `strftime`,
+except for `%s`, `%z`, and `%Z`, which are handled internally.
+Use `--date=format:%c` to show the date in your system locale's
+preferred format.  See the `strftime`(3) manual for a complete list of
+format placeholders. When using `-local`, the correct syntax is
+`--date=format-local:<format>`.
+
+`--date=default` is the default format, and is based on ctime(3)
+output.  It shows a single line with three-letter day of the week,
+three-letter month, day-of-month, hour-minute-seconds in "HH:MM:SS"
+format, followed by 4-digit year, plus timezone information, unless
+the local time zone is used, e.g. `Thu Jan 1 00:00:00 1970 +0000`.
+--
diff --git a/Documentation/rev-list-options.adoc b/Documentation/rev-list-options.adoc
index fd831f0ec64..6e6093f4747 100644
--- a/Documentation/rev-list-options.adoc
+++ b/Documentation/rev-list-options.adoc
@@ -1132,61 +1132,7 @@ include::pretty-options.adoc[]
 	author's). If `-local` is appended to the format (e.g.,
 	`iso-local`), the user's local time zone is used instead.
 +
---
-`--date=relative` shows dates relative to the current time,
-e.g. ``2 hours ago''. The `-local` option has no effect for
-`--date=relative`.
-
-`--date=local` is an alias for `--date=default-local`.
-
-`--date=iso` (or `--date=iso8601`) shows timestamps in a ISO 8601-like format.
-The differences to the strict ISO 8601 format are:
-
-	- a space instead of the `T` date/time delimiter
-	- a space between time and time zone
-	- no colon between hours and minutes of the time zone
-
-`--date=iso-strict` (or `--date=iso8601-strict`) shows timestamps in strict
-ISO 8601 format.
-
-`--date=rfc` (or `--date=rfc2822`) shows timestamps in RFC 2822
-format, often found in email messages.
-
-`--date=short` shows only the date, but not the time, in `YYYY-MM-DD` format.
-
-`--date=raw` shows the date as seconds since the epoch (1970-01-01
-00:00:00 UTC), followed by a space, and then the timezone as an offset
-from UTC (a `+` or `-` with four digits; the first two are hours, and
-the second two are minutes). I.e., as if the timestamp were formatted
-with `strftime("%s %z")`).
-Note that the `-local` option does not affect the seconds-since-epoch
-value (which is always measured in UTC), but does switch the accompanying
-timezone value.
-
-`--date=human` shows the timezone if the timezone does not match the
-current time-zone, and doesn't print the whole date if that matches
-(ie skip printing year for dates that are "this year", but also skip
-the whole date itself if it's in the last few days and we can just say
-what weekday it was).  For older dates the hour and minute is also
-omitted.
-
-`--date=unix` shows the date as a Unix epoch timestamp (seconds since
-1970).  As with `--raw`, this is always in UTC and therefore `-local`
-has no effect.
-
-`--date=format:<format>` feeds the _<format>_ to your system `strftime`,
-except for `%s`, `%z`, and `%Z`, which are handled internally.
-Use `--date=format:%c` to show the date in your system locale's
-preferred format.  See the `strftime`(3) manual for a complete list of
-format placeholders. When using `-local`, the correct syntax is
-`--date=format-local:<format>`.
-
-`--date=default` is the default format, and is based on ctime(3)
-output.  It shows a single line with three-letter day of the week,
-three-letter month, day-of-month, hour-minute-seconds in "HH:MM:SS"
-format, followed by 4-digit year, plus timezone information, unless
-the local time zone is used, e.g. `Thu Jan 1 00:00:00 1970 +0000`.
---
+include::rev-list-option-date-alternatives.adoc[]
 
 ifdef::git-rev-list[]
 `--header`::
-- 
2.54.0.22.g9e26862b904


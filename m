Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44EE448CE8
	for <git@vger.kernel.org>; Tue, 18 Aug 2026 09:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787047147; cv=none; b=KvSMTyD44ZPZqZcPLO5n8ddVXV/AlzCo09tP/2jLs9SoJzLztGC3JMmbTRZQiR4Tv50dMpPbOMc3cVqAjNw7mXt9YNwindCShzf7hHnDlFd2n817/a1CcikqAC7wqKst+Gtk6q1cK2zFjmGmW35MiWh95BiCGw8pJJz69MSBrnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787047147; c=relaxed/simple;
	bh=gO6VUgbsjjh4Gr4Xxvy2npyVI3g9cXTcR10J2zdLYMs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=duuPA8wE6KcNjNOAlcjBiCOkaxK2PCiOvaMXeoUL4B/nYp448FSBP3zUEO68gOOXbffcQD+V+X7jGLe/JCs+6j6k4L14RskHO7MEWli2RZRvnydfva7H30HJbSytAhAcEf967bfNPFP5W4kMEClnXY6r8xSgz8HSk/sNXNIXdds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=ISCPQW2W; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eJR5thUh; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="ISCPQW2W";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eJR5thUh"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id DA77B14000E5;
	Tue, 18 Aug 2026 05:59:04 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Tue, 18 Aug 2026 05:59:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1787047144;
	 x=1787133544; bh=jZJuK43p0uQ9OqP4qoJkqI/xs/RlsbQ18hwtBX1OVF4=; b=
	ISCPQW2WU3TSnI08fkRJDKk5wVegqDsPa+vI1dl0sUG6Rtkvy13TbfWi24iQCSqO
	63hCWeME9ffqAIxgpXhL16dmIQ3UEr7rWRJ8xAnZgJxzNDqTsJZRnb+sIeFP6efr
	dAt6pwSLcyAgWkGX6Y1op2JZeLc4PbBNqas0zUTmPSIAFq8/S8eo6OX4gc387APO
	2F3qwB9GcEfiAys0+IzgzMMnLs/QW8cQa5LLKCUalLuANxpMti1lmKXJgSv1z4BR
	KXT7mGxe82vcxECynhNZZb26+cbG36gRWosZhe8QbG9dkPauEIuncsxo7+VpH7p7
	1sL6xlthg0d0tpBXamT/0Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1787047144; x=
	1787133544; bh=jZJuK43p0uQ9OqP4qoJkqI/xs/RlsbQ18hwtBX1OVF4=; b=e
	JR5thUhgVteerqQbgalVvc5wdhh9XiyG3nnwYjGQuSVw5+N7aSYQlDplXZrbA1T9
	K1uJQ3F0dwKQwDzdJmF/3vfDyzSGfo7U8XtIjioxkn14koq5xuaCw52TdOkq67CC
	bk0MjPjhEMUV24oh1S2jVakK+shipMhpqZgVSm4xFtqF910QmnfDEEt5wu5sBRXP
	PhMVtmzXtKU7bhnfK9HDrMNJgZBsqh08/rrEmCv0VZexfdYqdgaFkJX0DLDcsuUZ
	yMNxWe9Bt38jy7yc7v3/ovWm/kLeFj7U96qrVTe1YpPCOhexlAXAMxoeEYoV5jxe
	nDJxHrwe8578T83KlU5Xw==
X-ME-Sender: <xms:6CyEal6MQLABblQx5BbcqwXGCWc_SpANUa4Gc1YE5ictVeq6aDmVK0Y>
    <xme:6CyEao7X08yswjvyIcoEae7EgIwvddFe0gTKSMUT1KvodJ2cJXK8mRg3a4rX_T2Ra
    UtJOmQu1BZv188zn30wmWNyRyMPuqnYiPUX8AQCcXzwmjmd1ao>
X-ME-Received: <xmr:6CyEaqFRDZnx3BkLx-2gvX7j589_R_2pNVL_u6xrLu2XCs9nHttdVwtE0ACJ3ARnk-BE7wQfO2P3CPKM8jw88T9uwOtn3RSI8e_NRCM>
X-ME-Proxy-Cause: dmFkZTExPi5WabwdQQgYKvaXXfH7L8duUlY9NjkKZZCelbhz6sg0wLbHY36Yjjpyx1M4G8
    2fq90vOVY0iD+MXw9L5zQVvFnl+7LqMSkiEzO95rA/H19T4sH2CSUPdT1opWzgyYECiI77
    uA2IA8ewjLR+xlhQ8dvSrU9WE6XLpl9NfdJ+sQeKeyGcShXLZkN2cYjV4715LLV50fLSU3
    D5+qaeCdBIkIZ7AHWaBJ83hSe3PAUo01SBgkl0wgzhWOlb6a7YxZz/3IDqd5fqEkk74u7Y
    yBgB8sD/xw67UR/H1P2EPq9rNXAKNJBrnN4b38J6hxDlREloPz845C7K1kjysFbWjM5zVf
    lYveh6mLhB7c6D30n2dDA4jcj9ma1UoYV5FDIHZJVXqwxcmJNUJnqyD2+rOYTx8MkG3D9y
    Sx411o8MNDwfR4zN/Fm0i3ofhgC0klT3mthRKGClIUzckutDRCfvYGuHDYfpQPC/KrcDbW
    YQD+iA33ZE1IjmMgh6YiAb5LrrgTBYT03mOsDAV7HlNjzVlCOBsg9jz1v9M65vaLKuvS4r
    XHU3XMFPeFZ4cOzvzUV4TKyLuKnQ34k/p54XOJiGsrBLl3vPJLm22y10l7b3F0DOwvNg4f
    g4eDOTAzMImurr0gah3Xqek4bUGcyepaF1VfGIrEn8TVMd2D/auIhnX0Q0+w
X-ME-Proxy: <xmx:6CyEapSwSCiN8oHiEXSsbtXe9ZPWBtO_K9wtzXFdSLWnVA4qU3J-yQ>
    <xmx:6CyEarukzn8NQLCb_jMK3xN8Qb0aqx8PFADZZjEcSJm46LydoyVJWQ>
    <xmx:6CyEagwR-Laq9eCb7jKPLQHOcOwsI0gvtEyU_Q7zf3MO4Q6m20d-gQ>
    <xmx:6CyEat68lMFOJ-8-xxhsT4DesWHIvnoQ3TtyJQBX0Eg4pFwL3W2uug>
    <xmx:6CyEapQh2aDWt9ZsTwZNxv7Z2dsAVKoRxYq-9HoJnSwyPJoJFAhrCb1s>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Aug 2026 05:59:03 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: [PATCH v2 4/5] doc: rev-list-options.adoc: factor out --date alts
Date: Tue, 18 Aug 2026 11:57:33 +0200
Message-ID: <V2_doc_--date_alts.bd7@msgid.xyz>
X-Mailer: git-send-email 2.55.0.13.g85d2d65e389
In-Reply-To: <V2_CV_format-rev_three_more_opts.bd3@msgid.xyz>
References: <CV_format-rev_three_more_opts.b80@msgid.xyz> <V2_CV_format-rev_three_more_opts.bd3@msgid.xyz>
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
2.55.0.13.g85d2d65e389


Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6734A1DDA18
	for <git@vger.kernel.org>; Sat, 30 May 2026 07:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780126986; cv=none; b=TDxVV/XgSWhJG+6+tXysnSuYJ5xFmzwphbgbN/OuMK7ruOx3OuqTXmtz5avt+kXiOda1vsx6C2zjsEFXZzKnKf5sJrR2MVzu9L/hGyTnchU5gxQ3q2b8iyYMSG2Y2KOn+L+IHhM23yUCDyQwMkldJruKYmAvBj2LDZNnlHeXtLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780126986; c=relaxed/simple;
	bh=fMTbUdK80TtphdBEnhI6h8S2g0ZJrDyqzbw1mkUuzx8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=m51rWjr1TW5lsVGTIMw2W4Bj+dgfggPX/P54CxydP73RGAMJpM+EvQJVXVAm5AWHjiEbc+JkOr+h64V9KWFuFadoKADHUgg85d0dGO98DN/5rzhUlFj+YeYoFrzJCqI6tKpZIrhQiu+CXGw4E7UAvnCZPuQ1MM0HBSbCkUCcEDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=UvWuLnjW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=X7xMyfHs; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="UvWuLnjW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="X7xMyfHs"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 70C98EC014B;
	Sat, 30 May 2026 03:43:03 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Sat, 30 May 2026 03:43:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1780126983; x=1780213383; bh=wOBROUzrlb
	lkFivlO/TP7vzk/hm/MbV0Nre3YhCaY2Y=; b=UvWuLnjWCjAq85JOelgQwO1Ukj
	x5TWxl3qZHDAWecluwyPHFrsLj2lVJ/OY6uIfxp2g7cD0h25H1e2DmqGQEHNCzvB
	64OJsEnLlX3OKZ7/W4R/Ro00KPbi/6SKeqGc1sRSAYVeqjq5uEVv/elLXA1MqzXi
	YruNM+Der8E1sz5FRs3hEbIsiGwrXwIZKdxl6VlvXb1s0iabYdzVc3mJ20LuHvRK
	ozpUVQhSkQ72WVf3GB1XgvUj/nx78l/KVaevPNRuVQKlTIVQ09EfvE3QhYqnVbD8
	txiC6uDscJrNOX5/kE99quJCMu0jAdwEXDOFcvtu+VUDPbBAUzmKrWYKBoFA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1780126983; x=1780213383; bh=wOBROUzrlblkFivlO/TP7vzk/hm/MbV0Nre
	3YhCaY2Y=; b=X7xMyfHsx4wRK1d0SXi7vJF3s4WN5oKeWvFeH583psvHtecxnCU
	+r5AA3qZ2OH7SQeQJvZTFf3UBjC2S19y/ObZpfMn0PbQ9H8AbCuwptB2ZRgLcn5r
	dZGAcp6fixYGWMUMJXzkErJ6nL8v/OlTzGoBaYcaJDfUXzcmy+Vv2vpOjX6fkF2+
	o9521pvUdGaNcAiEnnKHR35MxFII1SnuAdeqZ7IT5pokrLiTxAlXzj4969GVFPYb
	o5M07rMMg3PQd1IGa3WPxd0vFjP2RkDz0GMr6ERh+9x08Xba5Rc4/Wt+3v10Lv1L
	XNcJLTmIHpA1+l4PD4nO79fDsILBoH45XcQ==
X-ME-Sender: <xms:B5UaamQWGlLifFgNNHC20mUMtEETvGa1p-moXwC-bVPrRADqaMcD1Q>
    <xme:B5UaaiwhmCQRwGzIBq58FgpVT1j9xciIWQKWXlcFiWWaEHKTdZShPd3vtw9YhKMzy
    Y5OOyJPeztJS_jHKqez2oOXVlBt_YpGKciW24FGw5ZyoMWsdUdOIw>
X-ME-Received: <xmr:B5Uaao21DW1fGZpUkk1TbpX3Ek_9-ByOCtECPLp0toxgEZpp_IzIo2HLh8sSPAlAdik8gZ0TA14EHVyMIPP1o5_1dfBVGEQcdFdX>
X-ME-Proxy-Cause: dmFkZTEsJco+yJS7ek8nVWls60b6PkQWIUSZHUqWyOdePZKQ/PeW2Su4kfI6MDAQNIa4ws
    20HSgWJ3V/Gb1v/8v/vcAiSKnBhvNFc7pALQRnl3232vSuRTHgLEch7lnkrQFqwt9O85A5
    W4bmFqF3zaKYv1fcp2FmXg+uaYo6sRFb2CkbGWkwm5q5LRWeRdfsQvSQEC8uNhhv2p4KQX
    9LTeuPeOgN8VK+fWjEzLxQZYoxGcjnLr9whVTtYNVDdX9c9hs1oLiGU/uOt5FRuhMucM3K
    zH4aEbDrjSzaCmIjnUuUHCYYh+liJLnqSUc+/bXLlxM9wSOE2VuM0UTVo/M2DxSAHyXIbJ
    xOXtkD8fe11utG4VAe2dWoI3MbF7lugZPZvt7PwavntwykV2QsN/s7lddTJn62XDUnsEup
    aHs3qUyQtgaiGRbLiLHgp14ApJROU8r01WmeKm+2nE99Ilyq+SY3EInNRaMMtbnonJApIO
    /xKqsjHsbvFHe51fZJbzxJbOQ9ndvpzjAJN2b8Q6ppmMlNMVbZyYAvKo9jHIhVhY5JKHHq
    SXkSYlnOYepWlSor0h9xabT3P6+JM/7iy9g0ek9aTXPv/pVBcDeVTxK+5WtBrtbW907Fyj
    rdYkvg+0O1pi4jvNle3DJARjQgYj7MZBX5RWFcRFq+JBTAG5oeEPurcSyrfA
X-ME-Proxy: <xmx:B5Uaag4JDz1pne8484PnkOGThMH2L8NShoxZ_0mFV7TXky6PDOXmxQ>
    <xmx:B5UaarWksqsA8CEL7SVBy6I_asonAgDQcM879Ox13t5akN7OW8B8BQ>
    <xmx:B5UaavAMfbb9AUx5w16YoaSe5JYOdgfNEt7SfADjXv4AYIb_Fbtxiw>
    <xmx:B5Uaaq41CaKMg58_s0wHazyX7Fb5IGAbcAx8voXov720qDFKucTwgQ>
    <xmx:B5UaaqZRKb6ZCZOKRSwH7uWRFz9LBxbP1x4gsuwmZgjjXhN1pnPwubM9>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 30 May 2026 03:43:02 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Luna Schwalbe <dev@luna.gl>
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
  git@vger.kernel.org
Subject: doc: document '@' prefix for raw timestamps
In-Reply-To: <xmqq7bolg762.fsf@gitster.g> (Junio C. Hamano's message of "Sat,
	30 May 2026 07:52:37 +0900")
References: <fffe0ea9-baea-47cc-b354-5be4fff08983@luna.gl>
	<a8e51dda-7b1d-426e-9af9-cf856c42342d@app.fastmail.com>
	<08a04d91-af90-44dd-b28f-f3d5b9e77413@luna.gl>
	<xmqq7bolg762.fsf@gitster.g>
Date: Sat, 30 May 2026 16:43:01 +0900
Message-ID: <xmqqpl2de41m.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> This was introduced in 116eb3ab (parse_date(): allow ancient
> git-timestamp, 2012-02-02) and 2c733fb2 (parse_date(): '@' prefix
> forces git-timestamp, 2012-02-02) to allow specifying "ancient"
> timestamps (like 0 +0000) without conflicting with YYYYMMDD date
> formats.  I do not think neither commit added documentation for this
> '@' prefix, and Documentation/date-formats would be an excellent
> place to do so.
>
> Care to whip up a patch?

It might look something like this.

----- >8 -----

The Git internal date format `<unix-timestamp> <time-zone-offset>`
fails to parse when the timestamp is less than 100,000,000 (fewer
than 9 digits). This happens because the parser attempts to guess
the format, and 8-digit numbers are interpreted as YYYYMMDD dates.

To force the parser to interpret the value as a raw timestamp, it
must be prefixed with `@` (e.g., `@0 +0000`). This behavior was
introduced in 2c733fb24c (parse_date(): '@' prefix forces
git-timestamp, 2012-02-02) but was never documented.

Document the `@` prefix in `Documentation/date-formats.adoc` to
make this behavior explicit. Also add test cases to
`t/t0006-date.sh` to verify and demonstrate the difference
between prefixed and unprefixed small timestamps (e.g.,
`@20000101` vs `20000101`).
---
diff --git a/Documentation/date-formats.adoc b/Documentation/date-formats.adoc
index e24517c496..93fd36449c 100644
--- a/Documentation/date-formats.adoc
+++ b/Documentation/date-formats.adoc
@@ -9,6 +9,13 @@ Git internal format::
 	`<unix-timestamp>` is the number of seconds since the UNIX epoch.
 	`<time-zone-offset>` is a positive or negative offset from UTC.
 	For example CET (which is 1 hour ahead of UTC) is `+0100`.
++
+It is safer to prepend the `<unix-timestamp>` with `@`
+(e.g., `@0 +0000`), which forces Git to interpret it as a raw
+timestamp even if it looks like another format (like `YYYYMMDD`).
+This is required for timestamps less than 100,000,000 (which have
+fewer than 9 digits) to avoid confusion with other date formats.
+
 
 RFC 2822::
 	The standard date format as described by RFC 2822, for example
diff --git a/t/t0006-date.sh b/t/t0006-date.sh
index 53ced36df4..e11c659716 100755
--- a/t/t0006-date.sh
+++ b/t/t0006-date.sh
@@ -138,6 +138,14 @@ check_parse '1969-12-31 23:59:59 Z' bad
 check_parse '1969-12-31 23:59:59 +11' bad
 check_parse '1969-12-31 23:59:59 -11' bad
 
+# pathologically small or easily confused raw timestamps
+check_parse '@99999999 +0000' '1973-03-03 09:46:39 +0000'
+check_parse '@0 +0000' '1970-01-01 00:00:00 +0000'
+check_parse '99999999 +0000' bad
+check_parse '20000101 +0000' '2000-01-01 00:00:00 +0000'
+check_parse '@20000101 +0000' '1970-08-20 11:35:01 +0000'
+
+
 REQUIRE_64BIT_TIME=HAVE_64BIT_TIME
 check_parse '2099-12-31 23:59:59' '2099-12-31 23:59:59 +0000'
 check_parse '2099-12-31 23:59:59 +00' '2099-12-31 23:59:59 +0000'

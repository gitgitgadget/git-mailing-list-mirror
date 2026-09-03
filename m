Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 614324FC8D2
	for <git@vger.kernel.org>; Thu,  3 Sep 2026 18:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788459213; cv=none; b=qpDRb4B45fXB3wQTP/MRQSbyCGMRUkc+74ZsZDom8bHNRCRQS7km7GmLE6sv0NEcNu0WbM+HBoA+ev9AqvMVEDX3uqTJK+9asJEVevXJv8FFiobKePsEF1n4goOM89fRmS3tOaJskWXN5wkdzqGN/nHk2yBUs3s94flQFCD6Nms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788459213; c=relaxed/simple;
	bh=vJaaSZNxF1qD69NT5IfqB8SlT89dFtregiX3p6UQmEU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BJ6o8Puap8/8vDtPIuctXO4WjCNt4n+AS2WKpLM3h/FeuMHn8AhgQ9jtB5Mq5WtPX5RCrwZj+zhERzYOWAbqE5cb8ONy45pGu5+rxrRfFCwBBFljXF3nP30FhZqWRxKORCctqs9c74cg9HmgPazbOClpvPdP4zLjUQbxjD0Cqsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ApG6NhZD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MUJEdLlB; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ApG6NhZD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MUJEdLlB"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6DF057A00DB;
	Thu,  3 Sep 2026 14:13:31 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Thu, 03 Sep 2026 14:13:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1788459211; x=1788545611; bh=VWsfTCGKQl
	w+mMFJLsnr9UsKQnvq829/ojXYCnqXTVA=; b=ApG6NhZDChD4PJiNPxouAphGJu
	oy9aCTNmAumTkE6VHruF5a9h9rRsKtEPBn3tPZAWxEs7VXSzny0rwW88N2CYPy66
	VIM/76Vk9yMIRN/3wrB3XJvWQwleahktCnjv/rrDKaU9qiWUS8+5fCA/+a434BKF
	30yfY83MnWvIG7k5AnW7lNFZxJhY2IQZaLo+zkqiLffKrVJtMRc1/9NJOZ7Yp1if
	XAp+4nfkCJeGzzR/BfqOml0Ml+2997o5C3Xu3tnc6AVvDh2NneCQxMnWkBJU1x1C
	7IC3P82yUO3vGWop1w+vCB2kw9qqnfrYraSxMCdLiiOJEoNf/iZqgGVBfu+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1788459211; x=1788545611; bh=VWsfTCGKQlw+mMFJLsnr9UsKQnvq829/ojX
	YCnqXTVA=; b=MUJEdLlBUDbNTnGHFNsQPm0nchIK2prZJ1K7B3uF4XCq/sTiIG/
	t6u8BjtAl8pydiWqeQEO6BuSeJeXpDLlPieJwWFM+WcyBZkV4mZIPSBHMU9KefuY
	kiHevQUjahOCDBZQZUIWWyB3eYRFuAFtpBIKqU1JYJhJq1dL6eYIQoxiETUGBSnC
	U+CHrye4D3deeHmtyknMOBq9yhF6SCKLpKb693hNrQTuGOv4nNdP4ZXt2x0mxR98
	1iJLuBjBNm7bKyFDl1h6v7ClgHFLihTRudgJV8tR0fBRVAReiOk4dHyBgTQW/5uk
	1O/AuMiZKKajdgjrKoF4QDuSwUC5u6cECFA==
X-ME-Sender: <xms:y7iZaiMoNtJa-WIpiS2YuhDaNzm8IzrN_4XjHRSPeUBhEvaGZ0eUTA>
    <xme:y7iZaoaANDWSxtJWMBpPUfbB5AhUzo672z_7tsnQa78T8dYuNdl253P6_3oVUiEPb
    1LaOGpKTeqaSwbV_-p2rRcjNQR3OadD7k5S9HaOA9ylgJJ96A1AXE0>
X-ME-Received: <xmr:y7iZamol2bY1cj2X10RHRyA6Z09XuB9Gp6ET34Qlr2uORA70kHvMwMgS6o526-nsFwtWgebKtbjyc8Apqkkm3p6AJ-cvVcyTsQ>
X-ME-Proxy-Cause: dmFkZTFGDaJ26UxFhg1lFJihm0FeMu+BTGJ0Uw8/kA3rEBCPSGpwYByhImkStS/W7EQIRN
    yAzwTbAaw1oUxE+lgFsomsmRt76i3YaL67XzeasJ6BZaBpgoqjPsHAwg34V3EU9jhN8pD1
    igeGBgJZM223MHFGkohBKodMyD8BCI3A4Fg4SOArRQok0tDBdtL5lNLcG5dQ9gR4k+Cbk0
    R3x2VbFrorr7bXfOFgnGbkfOFQoFsmcHcP9mFVc2dFjYnJydEMhsnhRFZuxITO9a0HYjW8
    Q6vfmQ1viR5WSwhiCoy3gFbtNhi5qOZHNbRMnWDcdnIETODgsPHCdfd7iWzS4Axj5DpmnA
    QMpmqqxclfh0di94/v25DJ7Nl0DGaMyof3L5AJXuXkiQk7mGri5XETmfsc/IiN0riDEFUU
    lVBvLOyJWyEBBTRy6bz1j2O2N3svFZBp/IJiw+849HJoxeMonwr6RE0txIoQ9wqsp1FI1o
    oaw/p79WE1GTKX7rx4xJuWMf9Mn4EhZ2hFJHOL9oYILrylQGyVGzTeSJQDPD3+yLb0Kz4H
    dKbH8WhkynOwaEFwXh6/6Ug/YaFBhC/JyXDUj0Ldvi9iQzkO1mj39x07WPrtCnQa1yToln
    8HNxuQ5hyMU5OZanYmpvCELFCLD0/pJ0hQTN2jCfxcfgoT0y3SKYSnHZp+jQ
X-ME-Proxy: <xmx:y7iZasatlERlfpD-ivkBqWFVEJDATmU2VH8Pno9SUF2qGwlmINDpYA>
    <xmx:y7iZauRcVxjRq32f1g5ec6ZXQiFeIleb1JRVhBGBn2XYE9Q9ZRjC4A>
    <xmx:y7iZaj7maD9WLTHYNGku92KWPZaFzxWy2gS_kCJBLNPPIGz-i1actA>
    <xmx:y7iZajzGgLHMx91idfZoJJUFI9P0e4vYJoSoqaCGUSuoXZ-VXsLy-Q>
    <xmx:y7iZarVKDob7zShmz536JWCnvnX9CEjujvBNUaID5jyYpY9ta85ZXb5A>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 3 Sep 2026 14:13:30 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Yannik Tausch <dev@ytausch.de>
Cc: git@vger.kernel.org
Subject: pathspec: match and original in pathspec_item are const
In-Reply-To: <xmqq4ig6cihc.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
	03 Sep 2026 11:11:59 -0700")
References: <AA085B7A-F528-458A-8AA9-7664480997AE@ytausch.de>
	<xmqqecfbk2eb.fsf@gitster.g>
	<81EC0E28-13E7-4D10-BD07-3601124CBD77@ytausch.de>
	<886A25E6-8854-4AF6-BF0B-CFB57B673026@ytausch.de>
	<27FF785F-F5D5-44EC-93C2-5BD67BD99147@ytausch.de>
	<xmqq4ig6cihc.fsf@gitster.g>
Date: Thu, 03 Sep 2026 11:13:29 -0700
Message-ID: <xmqqy0dib3ue.fsf_-_@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> This unfortunately triggers
>
> t/unit-tests/u-dir.c: In function 'test_dir__common_prefix_skips_excluded_pathspec_items':
> t/unit-tests/u-dir.c:53:34: error: initialization discards 'const' qualifier from pointer target type [-Werror=discarded-qualifiers]
>    53 |                         .match = "unrelated/path",
>       |                                  ^~~~~~~~~~~~~~~~
>
> Other than that, looking good.

We may want a preparatory patch before this step.

----- >8 -----
Subject: pathspec: match and original in pathspec_item are const

No existing code modifies these two strings in pathspec elements
after they are created via these two pointers.  Declare them as
"const char *" to stress on this fact and cast away constness from
the code that frees these two strings.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 pathspec.c | 4 ++--
 pathspec.h | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git c/pathspec.c w/pathspec.c
index f78b22709c..06b7065372 100644
--- c/pathspec.c
+++ w/pathspec.c
@@ -749,8 +749,8 @@ void clear_pathspec(struct pathspec *pathspec)
 	int i, j;
 
 	for (i = 0; i < pathspec->nr; i++) {
-		free(pathspec->items[i].match);
-		free(pathspec->items[i].original);
+		free((void *)pathspec->items[i].match);
+		free((void *)pathspec->items[i].original);
 
 		for (j = 0; j < pathspec->items[i].attr_match_nr; j++)
 			free(pathspec->items[i].attr_match[j].value);
diff --git c/pathspec.h w/pathspec.h
index 5e3a6f1fe7..fc1b9465ad 100644
--- c/pathspec.h
+++ w/pathspec.h
@@ -35,8 +35,8 @@ struct pathspec {
 	unsigned magic;
 	int max_depth;
 	struct pathspec_item {
-		char *match;
-		char *original;
+		const char *match;
+		const char *original;
 		unsigned magic;
 		int len, prefix;
 		int nowildcard_len;

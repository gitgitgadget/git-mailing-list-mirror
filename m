Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D898D111A8
	for <git@vger.kernel.org>; Mon, 28 Jul 2025 22:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753742175; cv=none; b=OYNAJTZ+ybw7zKL8a3LQ0QbKv/ktPkd5/Sgu1Qn2R6B5v9VEl2Yc51YXiQ/oj0vfrYnDxcnPDzJjQ6HWXQDHIWwMsPFGCmrm3NqUKCSfHt127JBsiHed0j3vTg8q6JbSaotm/SWl6/1euNlhELRGrowwop14TdDye6iza5xBV3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753742175; c=relaxed/simple;
	bh=u5KWqKWsWaGw5sNv/k27f19rJDhnoeJ06bCGvd7/3iE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YNgxYTFf0bLLCoGbumwH4pFvBwRyvtTtwTgsN8cKV1Wab/kE7IlSKZxGJafXrvkVDd3rsDyjd4ufzfnKw2Qj/u97jWo5idk+weE7kXsvkimjQ/HhQYXyVS0XY2gT7YzuSfLQQUKUrDXI+ob3LSMyTCLdxb9dO2hNUCWLpCpBqw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=eLsnBTHb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jMNCLQ82; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="eLsnBTHb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jMNCLQ82"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id DF7AF7A0BC0;
	Mon, 28 Jul 2025 18:36:11 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Mon, 28 Jul 2025 18:36:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1753742171; x=1753828571; bh=tLyVm0SkkC
	Xbz1M1rdEr3H5DcznGlcjeC6Z6cbrF9dk=; b=eLsnBTHbZqSBg8pJNbIx/uwd3M
	j3BT3VlU0OP8LGz8EE1Vk/Qx8Q8IJQEpequJuCY8W6HZvG7c2qV6WUpdRDe6/wsh
	6QyoVIVZJuZ9QEryn7y/wgzYnwVAlP8vvDHW5AHUWd34q1/PBtioVh51beWUJDrU
	tcr1ShbPRyWfh+mQIZu6LWujiuDB5hN5nKA6xHQiS05OGpyoaTnJhYNxvh58ZdU4
	6eU2N7ATlkI9biQd531F2f/JnEHdVMSb7C3RhZEub7HuOX7Kqj1zOKuMfcmXZoGE
	g7Yjlhnp9n7Oz0TxI8ztLXfR9jrNTSdBLolc6AOFgc8ZibqOeBc7uYNeQujg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1753742171; x=1753828571; bh=tLyVm0SkkCXbz1M1rdEr3H5DcznGlcjeC6Z
	6cbrF9dk=; b=jMNCLQ82NHmD5Ob7DJSDkiIj6/gN0e+jTP/4F091FsigXdBD/ps
	2KYJgzlbW2D7bHBP1FuOwpEUzBS3SqCokSBVRAQfNml8Ai2x6OC8HPXalSt8LBsf
	IwmMsAWp4LBghN14ClQUhJCPs9E25l4VhoZYujih+o5Fog10IjnSUfbMnr/J/OLs
	4ZDsJ3Bsd4HLoKrp2v5JmOqvtLdsZWrzQaaK/qn9Qfc6p5JrFego1QRMqkmelh62
	WJ8cBp+P130PEyUt4+F39TAONpPoh3P87dj36wolqcK1hPc36Md84PHlL8s9eHJh
	bcNp5AbPS9aLAFgXipGhy7cfniY3yz/mGVg==
X-ME-Sender: <xms:W_uHaHIYLcN1x1Gv3XeRhRxrUNFckQ_ualTFib-qmI2NYZ9y6pM23g>
    <xme:W_uHaObcvzdkUPN69PsQbZ2ZWcbx1lLu2_t4w-URSrAE0dM3iKWEEU3Ve1EhBKH37
    g45exHM9Dw4TogXJw>
X-ME-Received: <xmr:W_uHaJI1-h1qf8wmPX_XiMWA7_YqUzH3I1l3iCibevZdnr9T_3M216sqz2DJ_lCxV4xVxwzzjF0QN_kBJB1Y1I_Qx0R-42xotG85qfU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdelfeeflecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefffetheeftdeuvedvtddvueekgfeviefgffdttdffuedvfeejteetgfehheel
    hfenucffohhmrghinhepfihilhgumhgrthgthhdrtgifnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtgho
    mhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepth
    guughguhhruhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:W_uHaMB2o_iBfESOT_jMHK4drjzKJFmBJ8lUN1zKskUxxDy4oHKJpg>
    <xmx:W_uHaOqQ270E_wyHOzjP3cnv1I8bojxtY07WEEU5nzQSBdfIla6urw>
    <xmx:W_uHaHj5OQxoHM5eq_8RbDRiNnKdPbb7JoHTPaiTlz2Lcb_qkn7C1g>
    <xmx:W_uHaLDIn7itHqMiaHtkzPhOTYizEw5vWcPxJCypbuHdex_qg6v0Hw>
    <xmx:W_uHaPAsbYuI1QiOa7yfjgbFJ6EWGkH7FNV73f0kr4YFAdGP62HFWJbv>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Jul 2025 18:36:11 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: TDD Guru <tddguru@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: gitignore pattern matching issue with Windows
In-Reply-To: <CAK2EJNO-FY+TzAnwtOhAgbWpnBP1d8yfjPidWSd=rVKM6rrdhQ@mail.gmail.com>
	(TDD Guru's message of "Mon, 28 Jul 2025 14:09:08 -0700")
References: <CAK2EJNO-FY+TzAnwtOhAgbWpnBP1d8yfjPidWSd=rVKM6rrdhQ@mail.gmail.com>
Date: Mon, 28 Jul 2025 15:36:10 -0700
Message-ID: <xmqqa54ot02t.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

TDD Guru <tddguru@gmail.com> writes:

> C:\gitbug>git check-ignore -v a
>
> C:\gitbug>git check-ignore -v b
>
> C:\gitbug>git check-ignore -v A
>
> C:\gitbug>git check-ignore -v B

I do not think this is not limited to Windows.  The exclusion
patterns use the wildmatch machinery, and its ignore-case behaviour
seems iffy.  The code expects that pattern characters to be
lowercase in character classes in order to match their uppercase
counterpart, which sounds like a bug.

    $ cat >.gitignore <<\EOF
    [ab]
    [CD]
    EOF
    $ git -c core.ignorecase check-ignore -v A
    $ git -c core.ignorecase check-ignore -v C

Here is a totally untested patch to downcase the pattern characters
to match against the text characters that are already downcased.

 wildmatch.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git c/wildmatch.c w/wildmatch.c
index 69a2ae7000..1a2d86b691 100644
--- c/wildmatch.c
+++ w/wildmatch.c
@@ -189,10 +189,14 @@ static int dowild(const uchar *p, const uchar *text, unsigned int flags)
 			do {
 				if (!p_ch)
 					return WM_ABORT_ALL;
+				if ((flags & WM_CASEFOLD) && ISUPPER(p_ch))
+					p_ch = tolower(p_ch);
 				if (p_ch == '\\') {
 					p_ch = *++p;
 					if (!p_ch)
 						return WM_ABORT_ALL;
+					if ((flags & WM_CASEFOLD) && ISUPPER(p_ch))
+						p_ch = tolower(p_ch);
 					if (t_ch == p_ch)
 						matched = 1;
 				} else if (p_ch == '-' && prev_ch && p[1] && p[1] != ']') {
@@ -201,6 +205,8 @@ static int dowild(const uchar *p, const uchar *text, unsigned int flags)
 						p_ch = *++p;
 						if (!p_ch)
 							return WM_ABORT_ALL;
+						if ((flags & WM_CASEFOLD) && ISUPPER(p_ch))
+							p_ch = tolower(p_ch);
 					}
 					if (t_ch <= p_ch && t_ch >= prev_ch)
 						matched = 1;
@@ -225,6 +231,11 @@ static int dowild(const uchar *p, const uchar *text, unsigned int flags)
 							matched = 1;
 						goto next;
 					}
+
+					/*
+					 * [[:alnum:]] etc. must be spelled in
+					 * lowercase even under icase matching rule.
+					 */
 					if (CC_EQ(s,i, "alnum")) {
 						if (ISALNUM(t_ch))
 							matched = 1;

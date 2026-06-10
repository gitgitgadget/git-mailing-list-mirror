Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D1C7331EA0
	for <git@vger.kernel.org>; Wed, 10 Jun 2026 21:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781126532; cv=none; b=UKM+Yf0XPmWx/jpr7lIU639iQHghncACYg3KPDESna+IvAFk5R9jZT2Rshti0khoIADZsNBy/kTHqhr359zECUKEoIkGochVoHbWwk8UZ1ymu2ty+dfZ+UIDp30Lagaag7FtzY3gTKRehV8TWeOvNelmWk/hiLf/Qi8BXkYLxEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781126532; c=relaxed/simple;
	bh=9piTroEKmlIYy9ZWCxeaNZ8YiPIOypF5Ex2uonr3gwU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MZHKTcsGEfB8bmBbNksvrbK7o/LTgiPwOPxc15GLQl1dEDRYTxvxJb1zhWPCE/dma2f4siHaFSLEZQ2ynYosEGveAxLIioobZZmnSmu4toOlHKOmrA9VLGohoTdyAgvb0IW5wxi9lSRbNXd4FQIsMoDkm2zxGA2l+kzxW7xKkY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=vook3n/A; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=i18v1Kr3; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="vook3n/A";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="i18v1Kr3"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6C56A7A0189;
	Wed, 10 Jun 2026 17:22:10 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 10 Jun 2026 17:22:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1781126530;
	 x=1781212930; bh=gYoBuSXBqN6O2+R6h0W+akP7XZE91s2c+ULQxmv3uBA=; b=
	vook3n/Atp9bUzKJqhnFpzyvJpAd/aFXME3TXo6HuE6LgVI8BvCtskvhUI+HzwVf
	nQfduwe4fk9pAZXtR5ZhZ2fmlZIomQr3tQkTaz3gRAT4i5JcANrNDUCwINCiahSX
	NMAuCJTcsPzlZoss4TzeTNjNfCuVgoT3kjwSTSc9pVYozPZMh/hY0lP8cKspzJs5
	L9n+j9mTDeY8tA3Oc6wpbfF2qicefYeT/tUEf2LZRSGAzSdkDWKj29PtimTvJnhS
	q6yb/vd5r/LwgvvlAV2JEpopXSi2GRh7jbBw7GYupMNUVNFWaAWi/koN9I5J8qFc
	X/tHuWHshOOvmCbEiSo0/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781126530; x=
	1781212930; bh=gYoBuSXBqN6O2+R6h0W+akP7XZE91s2c+ULQxmv3uBA=; b=i
	18v1Kr3sOOCTpN6/KgAhqWihbUZVDR3+35S+8yF9cjs8n84d2B5uSs+euj+HabS9
	oyJV+hS7ZDZbmVLRVt0QsZdb7kTQJReRIOcdTKgSndiPbjoCZTHq1e14/6PFNUdk
	Jq+R6SXDPiYZBK8z7K1coDPke4DvuhKwtXTttgd/EH6+cedq0L/7lHJaLqNaxdQ2
	5BrT/+aOfJrTygMxznhoYZE1MhRJR5417c0wTU4VKzCKLTQzAjJUtIv4U+BjQRXY
	Kp/SeDo8ac6KSpl6Pim0rK2axP64BH5S0wJ/ypewmAq9epQhj1lQbjPuvaIRzqy2
	zDVrbGIwjgRdYipKAiimA==
X-ME-Sender: <xms:gtUpapopqc6IBZB_AH5jaeXQqauFu4OB7jpQ3ij3SAyeviHfYD-rjoc>
    <xme:gtUpavVT0Nbxs13ja8Uf1Ur2uVVu--g9ZWubBsYjWcZs8jDA82c9ZMRten7Cuf33K
    ae03ZrVp09wEWyMbtwFFZYo96EqsNIKcBPIsNP6sbLNTaSThmsf_w>
X-ME-Received: <xmr:gtUpagA4wcavpqMx7ryUcz_8xqbXfaI2B-PWcwcBMB6GlCfhvQpxD1wKC13nNYgGMB89HCNNifnzBG8kLBJP4aCkYcOjqjsPPl2DPf5TRGbbfKUabiHPP7cObA>
X-ME-Proxy-Cause: dmFkZTEaFEwPJpc3GDjZQ0ko3I90dDZJ4E8uHr7r2H1x15coZGzJd3TnFG/lKQm4ZfZmdO
    kJl1dk80yqZqMZykzygwYvapWn+IW64TB7sN89lfa1Lh0GJ+6riPHFuVitSfCwlrky/nFD
    MhgZR2A0RZljvEFp/cNWqCwOlLAsCQXaQtqAiFRW77mtHZwQYYcl22DilURNbrfvdoW7Fq
    ATtEJA6N2BX8/iz5NU3mw+RxqN+26ga1dzqXLvPmC6wbsDm4ay/RZtBzLyspHPkC8Ojvru
    DX3+cW+2a3oz/T8fVW/XLSsO9hQZ4xU1/oMhaCeMPMUML65UW8xZ6AcK4r/YAenRbs6nFa
    Qre5nuI4tAcE68b3wflhny6xrcoowDV6L/n/sWNvJU7/eRKSO59vNEfNAHiK7XgpyIA8dw
    XrBPme5HB4KhdvHbFq3frQkE02ip7QF7KpQqktprjP5vidT5+nfo6PuFdnYVLG6Dx+lovW
    fDgSGvb3bifwsvEdOWZhlEXyhSnd8A1T34kXFt9kEIJIznD/aVHNs9+j0VpdUljPzLHW/U
    aij7id6xsz5+HHpul3chNjwjRT/tEz7ERRlIfQ9YRRYU6U7MEjBPkQbTkfWpSL8mgWthHA
    72ulOBEVJsu9iEqikeB7jzoR2cb3NgOyp5URcFNuOI61mlcjeiCzgL1CR/YQ
X-ME-Proxy: <xmx:gtUpar1Hgrw7ZxLD-7NFTopiHcXlwd31uU2qlIP22AsUDAA5vhfl0g>
    <xmx:gtUpaq0onr4eQ97aS89DefTtgevEjbuIGxYQDOi52KXXkZq8n9ZzSA>
    <xmx:gtUpaoDejlYA_umGDHrdPbEqi23ViCMjeFcoof2DFFXcVSImFYFSXg>
    <xmx:gtUpah4zxGJtb15RBzdH8wcu2e9rtNYSiIZI0ZHZ7HlOvp7UPp_plA>
    <xmx:gtUpaj1aNcyznG3pbkGaHZRjv2gjvw9xT7Dl_oALnPdYXQe4MK6WEt0y>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Jun 2026 17:22:08 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	christian.couder@gmail.com,
	jackmanb@google.com,
	Linus Arver <linus@ucla.edu>,
	"D . Ben Knoble" <ben.knoble@gmail.com>
Subject: [PATCH v3 02/11] =?UTF-8?q?doc:=20interpret-trailers:=20replace?= =?UTF-8?q?=20=E2=80=9Clines=E2=80=9D=20with=20=E2=80=9Cmetadata=E2=80=9D?=
Date: Wed, 10 Jun 2026 23:21:20 +0200
Message-ID: <V3_metadata_not_lines.8a5@msgid.xyz>
X-Mailer: git-send-email 2.54.0.22.g9e26862b904
In-Reply-To: <V3_CV_doc_int-tr_key_format.8a3@msgid.xyz>
References: <CV_doc_int-tr_key_format.533@msgid.xyz> <V3_CV_doc_int-tr_key_format.8a3@msgid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

We removed the initial comparison to email headers in the previous
commit. Now the introduction paragraph just says “trailer lines”, and
the only hint that this is metadata/structured information is the
“otherwise free-form” phrase.

Let’s replace “lines” with “metadata” since that is their purpose.
This also makes the introduction more consistent with how I chose
to define trailers in the glossary:[1] “Key-value metadata”. (We will
introduce “key–value” in the upcoming commit “explain the format after
the intro”.)

† 1: 68e3c69e (Documentation/glossary: describe "trailer", 2024-11-17)

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    v2: [new]

 Documentation/git-interpret-trailers.adoc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-interpret-trailers.adoc b/Documentation/git-interpret-trailers.adoc
index 1878848ad2a..3f60fd9b720 100644
--- a/Documentation/git-interpret-trailers.adoc
+++ b/Documentation/git-interpret-trailers.adoc
@@ -14,7 +14,7 @@ git interpret-trailers [--in-place] [--trim-empty]
 
 DESCRIPTION
 -----------
-Add or parse _trailer_ lines at the end of the otherwise
+Add or parse trailers metadata at the end of the otherwise
 free-form part of a commit message. For example, in the following commit
 message
 
-- 
2.54.0.22.g9e26862b904


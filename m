Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FFD3275869
	for <git@vger.kernel.org>; Tue,  1 Jul 2025 15:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751382910; cv=none; b=L29HZ7si/num5IBBKLzCQlhuDsrOFvbx9sXM0BfF4icOAUb4xwJg2i6noAtC9tRBUj6A1B+fd3XDY5VZVgKhufbTuNLXv5c49fyrtKVoja3tRSwAxQcreqcEdaNLL7W3CxL5XwXxyMYXKflPPUSJPUPmKO+49rUpBhoE0DzZWhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751382910; c=relaxed/simple;
	bh=2EXwse3P89fc0GLsRLoq9mH+1OoHr8HrHpdrfv31hy8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mbCltJrQpcDcAR915QhkfPhFPM4zQfXNH8zH9TYsEGVLPkpMUcq4EPIG8FDrS8YwQkm1x6sQ+dtCDqtJ5oxLhh3BGGHsu6ldfjb+7GDWF3/BD3JNubENX5NAtPS3xMY9/WqRxE3Pt8QrHy8mJbqI5bqrih2JrpQSzejkUgrm2uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=MLcs6aW8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=g9eM+PJD; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="MLcs6aW8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="g9eM+PJD"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id DCA171400317;
	Tue,  1 Jul 2025 11:15:07 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Tue, 01 Jul 2025 11:15:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1751382907;
	 x=1751469307; bh=CbLcRAL8CH9OtPmWxo+hijQYbMtJMdSAeLaLkgJWIv8=; b=
	MLcs6aW8ROIky3w0bmSKhVHbSA2p+eqV6uv5oenKL746zMoyWwbjDH7BOsyjX5Gy
	e6lCZYlwi0Z75g0hfVg23/6rDMl68TGGeWL8BGrZx4gsMkonwOe2sKK08cfisgry
	2qeOZLrtHhxhm2mNAiz9jzdgZU9juyRCp/hc2y4W7zQ4INgEo0nUWY+4P054Ife0
	IWOebWdvH1cv1z6v8rWlxyGeJ4bfnQ4iRfR79l9lFLwxOgxPtN8JmnzKHq5wi2MB
	FJN1frdLSyCr3NhUPmDFIOR+pQTWXVNnmSlDPn58msf/GrwGh1hcfEhOW5QT1EsT
	e6Thftiias4/6WMlvtiYcg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1751382907; x=
	1751469307; bh=CbLcRAL8CH9OtPmWxo+hijQYbMtJMdSAeLaLkgJWIv8=; b=g
	9eM+PJDpT9CLethI6aqCvM9LodEWAc9iYy7lUMyMc07gBtjKUe6ku8yBHQcM6VjU
	BinT7B1TwbXOGq1qvAK0uomZVS3v2vcKd7Q//Gm+pBO2/PG0jCt3B8wj7SasIjKy
	2mBSlfawg1PyaJf0x4+1SGrWoZdjoLm9+iDegbux0MWDTvjgSASUDyVGlXQmx0+w
	jWLIEPKUd2tieu0NU81d+BZh67Wzf8w49b4tmea6xBA6PIP/+xfW+ZoxSQSdMuSb
	9i1SMgAcR2eFy0/O4h0bZLoCsvhqrSkkLjbENRz2VlBO+jUipQ+xexWoMFwsGSJv
	UQ6T4IwazkH4QiGik3sHw==
X-ME-Sender: <xms:e_tjaES9JwfhYIED7RdUrWWFEKHg4aKeO46ftluvMICJdMr03_vNOjM>
    <xme:e_tjaBzKnHqRzkhX4WfS6Y6gnMu4KIf00O6bnuDGWwtv-b1xhIszu3--t62ZZRXlZ
    wiWwaXs6VPJgAyi6w>
X-ME-Received: <xmr:e_tjaB2Oh6MT5CRA7SMJxdlWXNicyNC3Pmsozk2kFX8Kz1U43Hvpv4PNRjsGJy6C76Np6ng6IP2ja3RZ6qA9P_DaNG4ffE2GKGUNsuQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddugeekhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepkhhrihhsthho
    fhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmnecuggftrfgrthhtvg
    hrnhephffggeelhfejkefgteelteejhfetieehgeeftdduudffgeejhfektedugefghfek
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrih
    hsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgt
    phhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghouggvsehkhhgruhhgshgsrghkkhdr
    nhgrmhgvpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehjnhdrrghvih
    hlrgesfhhrvggvrdhfrhdprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgv
    tghordgtohhm
X-ME-Proxy: <xmx:e_tjaID8BNiGF0pst5wiKS89redzy_vji_Kf284KXidOu8Rb2fBuxQ>
    <xmx:e_tjaNhGPnfmewaDK89eH_NTRfbZ63eCWL3hxpNi44VDbegJVmXpHA>
    <xmx:e_tjaErWMNms6PFsyOePoHQP0YWDC_GyqW3SXFi3PL0uwRB3pWsKKg>
    <xmx:e_tjaAhLJ4Wr5iEfGqZj1vbJjgiE6vbMM-INfKC4kQp9KtdmoEU0_w>
    <xmx:e_tjaC_ZcoM2BKV7PS70hDkdgEhIL2C52sTd_SjUXQSc8GVWqB5T4mbe>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Jul 2025 11:15:06 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Patrick Steinhardt <ps@pks.im>,
	=?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 4/5] doc: config: use --value instead of value-pattern
Date: Tue,  1 Jul 2025 17:14:31 +0200
Message-ID: <e5eee1a0541b2b540bdac92b6b81858bf1eaed93.1751382830.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.50.0.136.g907b27ebd9e
In-Reply-To: <cover.1751382830.git.code@khaugsbakk.name>
References: <cover.1751310455.git.code@khaugsbakk.name> <cover.1751382830.git.code@khaugsbakk.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

This option was introduced in a series of commits from fe3ccc7aab (Merge
branch 'ps/config-subcommands', 2024-05-15) and deprecated
`value-pattern`.  But `value-pattern` is still used throughout the doc.

The deprecated modes have been quarantined in the “Deprecated Modes”
section.  So let’s only use `--value=<pattern>` in the rest of the doc.

Acked-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---
 Documentation/git-config.adoc | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-config.adoc b/Documentation/git-config.adoc
index 03808b18d3e..9d8f9bb04e5 100644
--- a/Documentation/git-config.adoc
+++ b/Documentation/git-config.adoc
@@ -26,7 +26,7 @@ escaped.
 
 Multiple lines can be added to an option by using the `--append` option.
 If you want to update or unset an option which can occur on multiple
-lines, a `value-pattern` (which is an extended regular expression,
+lines, `--value=<pattern>` (which is an extended regular expression,
 unless the `--fixed-value` option is given) needs to be given.  Only the
 existing values that match the pattern are updated or unset.  If
 you want to handle the lines that do *not* match the pattern, just
@@ -109,7 +109,7 @@ OPTIONS
 
 --replace-all::
 	Default behavior is to replace at most one line. This replaces
-	all lines matching the key (and optionally the `value-pattern`).
+	all lines matching the key (and optionally `--value=<pattern>`).
 
 --append::
 	Adds a new line to the option without altering any existing
@@ -209,10 +209,10 @@ See also <<FILES>>.
 Use `--no-value` to unset _<pattern>_.
 
 --fixed-value::
-	When used with the `value-pattern` argument, treat `value-pattern` as
+	When used with `--value=<pattern>`, treat _<pattern>_ as
 	an exact string instead of a regular expression. This will restrict
 	the name/value pairs that are matched to only those where the value
-	is exactly equal to the `value-pattern`.
+	is exactly equal to _<pattern>_.
 
 --type <type>::
   'git config' will ensure that any input or output is valid under the given
-- 
2.50.0.136.g303b50f9132


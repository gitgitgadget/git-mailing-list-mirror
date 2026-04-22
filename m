Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5110A2F3C37
	for <git@vger.kernel.org>; Wed, 22 Apr 2026 06:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776839834; cv=none; b=DsYX1UcBInvIOGytHrINRY01j14zuHXZWlwqZRqcPhGfVEs7Wkeb/uQMsiOopnht4N3cq+hRbxjxjGPx70p1adzkkM80UvCJn+q7T27a36Qsj8qTtWnGvNFwxGwpWKwnbRkWZqH45QeJcnJJR+s9ScsWcOOcKUne23dHUm+sH6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776839834; c=relaxed/simple;
	bh=n59DsvOsKLPU2k8Saiwv3vG15F9TEUs558nuSkNHM1w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VVx8TxNMz9UkOkmoKkQkgTinLLIRj3NTzt1ZLDxsikyqtwWEHJaCNBZU9wcsjzuL8LDLC33WCEj0SpVfWdBbCXbnqyiVl4jof2dWErBsOtSLVcxl+WEDARif4NCWr2gR+HqlJo+J1ygb0j0KgFUj66Juqb7ES7yYnrXYSVBTmyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ax78xy+l; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RLcM+NAY; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ax78xy+l";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RLcM+NAY"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8E6117A00D4;
	Wed, 22 Apr 2026 02:37:11 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 22 Apr 2026 02:37:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1776839831; x=1776926231; bh=hPPafwPAyQ
	psr20eAbELDKSGzVWmr8hNZVwhILQRyOA=; b=ax78xy+lKIcNYQO/4n+sXNkaB6
	hm5viNpIBzuMxYLrAntOs7Ft98Eq+PceVNoGauA4a0ubU7o/rSo6SjRvOq58PSDt
	cilPvLRoZ8lpTXewtBLxVU/BaXnZ8bxTEfi50Duu/JpwbIGMn1sMVdFlxtNz/1Q1
	kDXOb9Z5mCWaeJkRQM9FLqp7C0xpAa5uN008FTbgeT3TKZ2xYdyYcyfFDoggBaJO
	4VrMLhLfAjlug8JFGfDgAyJQKn193YvhMnYHq+6Nf1d8Mlju1Fsm0OoqbRw41501
	s6Iuj5mlEeH2hzgzHU5YDQ3sJcZ/jMupobYM7AsIpju/BjD6ODztD8v7yqgQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1776839831; x=1776926231; bh=hPPafwPAyQpsr20eAbELDKSGzVWmr8hNZVw
	hILQRyOA=; b=RLcM+NAYIilKUw1MIKxMxeDcd5NH2na2ymrGdLy7+N7+dhUcrmZ
	5uP8pk68qtzt/3t63k9rh4Yyf7poLwT1O4Wtd/nD9V+oftfAfxcJmEtxPcLZ3dHH
	xN70GyGK8NZgqEq2FRh1nrNkT5+KekJl8ZZ4suNBtaFabYSh99MoVgcznQbcdzto
	8oVVEEs/pD6m7xi3HIE1vryqaHjsAtFlA6I/Llc4ozHaNaJq5KYV0WmdDEld352a
	TorE68Im8+eQAFSmXwPfWdCdnF1lvOBo8a5gRx0pzzKsI2eKhu6bh9p1hBF+HaSF
	xLQZyLSWYRloo3RpEkmW7zokG8bGSHV3xQA==
X-ME-Sender: <xms:lmzoafBnlK8azlpzIzmYByg2rMTMBHfzsQPcIFyQ6zOFf4J75QryXA>
    <xme:lmzoac_Yo7pH-fXlUci-oL9roEz5VlGMmAsgQcSqEyGTTMQu2YyfFcEXbLcZX72fj
    QzT79PH91vhzseXqQVAi_DdW1UIkOcx9eMdtHoAX9Th7i-6qmTb2A>
X-ME-Received: <xmr:lmzoaX9S30H-o20OLuGPEro4HaPSxPD8Wvz7ktVpXWY-Hoo1PW1Ttm-cHowGiE08SdlhVYFLSb3-qBbyZx-B7nveT66iIIqWBmpMWQZ9h3k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeifeehjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehtohhonhesihhothgtlhdrtghomhdprhgtphhtthhopegsvghnrdhknhhosghlvgdogh
    hithhhuhgssehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghr
    nhgvlhdrohhrgh
X-ME-Proxy: <xmx:lmzoabe9EsgtRbu3mXSIOmbyXYY2mXctl7rPNGVXoPfGLetJfeIisw>
    <xmx:lmzoaYGsggcHYRC68qy6yulBtrzs_Vh72ncYSnIW9rTIBysHq4HpEQ>
    <xmx:lmzoaRfaHIkZqe4svoatXcHE5-Vn7AutyzZOR5-RrWrOtHz7ttKohA>
    <xmx:lmzoaaGPQLqBhtYjNbOn91pydSv_7HLWimoGRP0qKzyMPzYAuFLQ3g>
    <xmx:l2zoac_7mzYp8M0dPhbfg7KgizJLMZzn3YZsRRMQvUvVSrvCsJocI6zu>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Apr 2026 02:37:09 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f6ae5daf (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 22 Apr 2026 06:37:08 +0000 (UTC)
Date: Wed, 22 Apr 2026 08:36:58 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org, "D. Ben Knoble" <ben.knoble+github@gmail.com>
Subject: Re: [PATCH] generate-configlist: collapse depfile for older Ninja
Message-ID: <aehsikCfPm83M9dN@pks.im>
References: <20260421-toon-fix-almalinux8-v1-1-aec1d54addde@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260421-toon-fix-almalinux8-v1-1-aec1d54addde@iotcl.com>

On Tue, Apr 21, 2026 at 09:17:25PM +0200, Toon Claes wrote:
> For the Makefile build system this works great. And since
> ebeea3c471 (build: regenerate config-list.h when Documentation changes,
> 2026-02-24) this script is also called from the Meson build system.
> Nevertheless, on AlmaLinux 8 the following build failure is seen:
> 
>     ninja: error: dependency cycle: config-list.h -> config-list.h
> 
> This version of this distro uses Ninja 1.8.2 and it seems to have some
> issues with the format of the `config-list.h.d` file.

Right, I can reproduce the issue with that version indeed:

    $ meson setup -Ddocs=man build
    $ ninja -C build
    ... successful build ...
    $ ninja -C build
    ninja: error: dependency cycle: config-list.h -> config-list.h

> Ninja versions before 1.10.0 do not reset the depfile parser state on
> newlines. This causes issues when the depfile has one dependency per
> line, like we have in `config-list.h.d`:
> 
>     config-list.h: Documentation/config.adoc
>     config-list.h: Documentation/config/add.adoc
> 
> The parser only recognizes the first "config-list.h:" as a target. On
> subsequent lines it is still in dependency-parsing mode, so the repeated
> output name is recorded as an input. This causes the error mentioned
> above.
> 
> The bug in Ninja is fixed in 1.10, with commit
> ninja-build/ninja@1daa7470ab7e (depfile_parser: remove restriction on
> multiple outputs, 2019-11-20).

Good find.

> To be compatible with older versions of Ninja, add a fourth optional
> argument to `generate-configlist.sh` that can be empty or "collapse".
> When this argument is "collapse", there is a post-processing step on
> `config-list.h.d` to put the dependencies for `config-list.h` on a
> single line, like:
> 
>     config-list.h: Documentation/config.adoc Documentation/config/add.adoc ...
> 
> This works around the bug in older versions of Ninja.

Do we really have to make the logic conditional? I would expect that
this works just fine for newer versions of Ninja and for Make, so it
feels rather pointless to me to have two modes to worry about.

So wouldn't the below simplified version be sufficient?

Thanks!

Patrick

diff --git a/tools/generate-configlist.sh b/tools/generate-configlist.sh
index e28054f9e0..f5f42492c6 100755
--- a/tools/generate-configlist.sh
+++ b/tools/generate-configlist.sh
@@ -44,7 +44,9 @@ then
 	{
 		printf '%s\n' "$SOURCE_DIR"/Documentation/*config.adoc \
 			"$SOURCE_DIR"/Documentation/config/*.adoc |
-			sed -e 's/[# ]/\\&/g' -e "s/^/$QUOTED_OUTPUT: /"
+			sed -e 's/[# ]/\\&/g' |
+			tr '\n' ' ' |
+			sed -e "s/^/$QUOTED_OUTPUT: /" -e 's/ $/\n/'
 		printf '%s:\n' "$SOURCE_DIR"/Documentation/*config.adoc \
 			"$SOURCE_DIR"/Documentation/config/*.adoc |
 			sed -e 's/[# ]/\\&/g'

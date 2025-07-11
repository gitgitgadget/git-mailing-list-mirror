Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 288D71ADC7E
	for <git@vger.kernel.org>; Fri, 11 Jul 2025 18:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752258745; cv=none; b=VsG/MZdT4RpQfcGBrmjPaCfgiLSdRHIsUv+Vk469VhTkfuhbLegrAq/6a7W+DAKYsCdIWUpGzzfKFLFEPu7K0Cc5B9TBchMrB0iuYf1J5RmKGt3KyuZD6YC/r/wXv+mjUSKOnJ6Fmc+BZLOtJRRlFKOxWUeUW4/qiHhyMlRjLZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752258745; c=relaxed/simple;
	bh=Z7I2es50vZDICND4UQEfp9pe05yOSepylEJcCR8r1L4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=T/BALWpZGzxVFMtyDEuiwtPhSepMublOGPzGVLzqzwTKqWMSUtjqwmcoTA+KxKPSd+730Pm5ddC2FE94sWsr4+b9pNrFJE6soEtWMU7SXIZn5Pl6SfBiIU43NNNmAgbG7C4Kc6c97yOXw47Pj3NmWDEQKvV1lmd1w3kPPsvxf1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=q4IP1/vn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Gc1dXVpg; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="q4IP1/vn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Gc1dXVpg"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 355367A018C;
	Fri, 11 Jul 2025 14:32:22 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Fri, 11 Jul 2025 14:32:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1752258742; x=1752345142; bh=DMJUWeXlB5
	vGQQ3e1ViDjKavfjmzEJpYmMw23zSkoeQ=; b=q4IP1/vnDXUrjDbyfgKDFjEw6o
	joBsyCGYohYFYtrJoR6/2iHGrhYz2zNl6hjeE2EfP2aPUIIKjtKxdoR9F+hAfAJ/
	HoSBAB5CSlbsUq6lx/MuiZd9kd/htibO7fqbZXiDUnUOELUWdfPsVC7aDhRIGd9r
	9pHA+ngrgAn6j1FXVuvkgTbhGCcvDO/nwaSsWzjjPDRURSl4UxB30q7a+950XfNo
	KX6teDJrBN4A0rb2AQhkg+TYTCdLNszjslSZAKzDQ/XkWNygGXfQUFGXP6CZblKz
	0Ku+rgnoKqMK3t9F5Ii3w/HB+jiWMjeRUhQGI9QdjdVm8Q+MOq+wVoloua/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1752258742; x=1752345142; bh=DMJUWeXlB5vGQQ3e1ViDjKavfjmzEJpYmMw
	23zSkoeQ=; b=Gc1dXVpgJIwv88Lmu8ArdEh0hL39awNEh1QzVNvAv99+B3KtOzs
	jH+enKgB8xyeaPqM6ZN4DGRaRy7lFJzk7/AlMoId/vdSlmy0y7uEUHtKAiDWmKSB
	vFmeTHWi0cxKSE4DHxdh+d0dCqaE1IEDvY2W00lTCq2yIKD0WHYy84T34ofbm8O6
	c4ES7RbDwyIBTOHZLAOx8QFfPVum1WoqYPMVP6rkfn1799kEpcs4Lw+UvRQHHu8c
	CT7wHc8uK+gjc21/xfDuaiUhMdb4OCcjdPyi9Kl6NymuQGkTuz6jhdbqE6Fo+S4z
	J+2byfwGWbmQPCEs9CjA9l7qXkCz8+lJJow==
X-ME-Sender: <xms:tVhxaOk6Ya8vIudOnWRDyMbnLmktVq-0eJILpIrr3bNt_6ORD5GzCA>
    <xme:tVhxaOTF4qxg8rGHrLEitDFiwyrzvbvQKiiwuR-Jb6h28v9PmsVbKi5U3XUvr3XlD
    cHlObvd9Zr4LgseHg>
X-ME-Received: <xmr:tVhxaNGJdmT0Hjr2H5kwlAvsLkfBKwYJzQPa5TNYSr3lXasVBEhBBmbVhMFHcMcc2F45S869IH9Vq7MIYN4Y-_EaqP1c0G3d0mn24so>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeggedthecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeeivdfgfedtheduffegfedtveffkeekueeuhfffveefjeeuteegleduffegvddt
    tdenucffohhmrghinhepghgvthhtvgigthdrtgifnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdp
    nhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjhhlth
    hosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshgrnhgurghlshestghruhhs
    thihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohepghhithesvhhgvghrrdhkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghp
    thhtohepvghunhhgjhhunhdrhihisehnrghvvghrtghorhhprdgtohhmpdhrtghpthhtoh
    epghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:tVhxaDFDbPcxU6u1sxPvlgLlANNXtnkHqS7HX2ACtJyFzf5KwBdoeg>
    <xmx:tVhxaLTA0puUTg1XKID7Z2LnaKlx-ff2iS8zxtDTWYOC_MaoW7yJxw>
    <xmx:tVhxaEI71n16IAmN-0YvO-X0G5JW71em_OLMCN3fUh-HObEeI-hrng>
    <xmx:tVhxaGaLGumLBk-7kh4G2fobQ7vQL0hYxvOakexYd2Pa8ga47duKaA>
    <xmx:tlhxaGshhWcPFcFRZo6mEfRgo6nnP4g4PcD6acq2PQxeIMwkwIrpRzbW>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Jul 2025 14:32:21 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Justin Tobler <jltobler@gmail.com>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,  git@vger.kernel.org,
  Taylor Blau <me@ttaylorr.com>,  Yi EungJun <eungjun.yi@navercorp.com>
Subject: Re: [PATCH 1/1] http: don't send C or POSIX in Accept-Language
In-Reply-To: <r34i7fhxwbxhppc4ia7lpyr3xqj4tgusaeikaaonpwtywlywxw@ygfmv3f3q67u>
	(Justin Tobler's message of "Fri, 11 Jul 2025 10:23:38 -0500")
References: <20250710221641.857081-1-sandals@crustytoothpaste.net>
	<20250710221641.857081-2-sandals@crustytoothpaste.net>
	<r34i7fhxwbxhppc4ia7lpyr3xqj4tgusaeikaaonpwtywlywxw@ygfmv3f3q67u>
Date: Fri, 11 Jul 2025 11:32:19 -0700
Message-ID: <xmqqldou1suk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Justin Tobler <jltobler@gmail.com> writes:

> Looking at `get_preferred_languages()` when NO_GETTEXT is defined, we
> already filter out "C" and "POSIX". So doing this for the LANGUAGE
> environment variable when writing the header also makes sense.

True.  I wonder if it makes sense to do the check in that helper
function, though.  I.e. something like

diff --git c/gettext.c w/gettext.c
index 8d08a61f84..e2e0fe339d 100644
--- c/gettext.c
+++ w/gettext.c
@@ -41,6 +41,16 @@ static const char *locale_charset(void)
 
 static const char *charset;
 
+static const char *filter_out_non_languages(const char *candidate)
+{
+	if (candidate && *candidate &&
+	    strcmp(candidate, "C") &&
+	    strcmp(candidate, "POSIX"))
+		return candidate;
+	else
+		return NULL;
+}
+
 /*
  * Guess the user's preferred languages from the value in LANGUAGE environment
  * variable and LC_MESSAGES locale category if NO_GETTEXT is not defined.
@@ -51,15 +61,13 @@ const char *get_preferred_languages(void)
 {
 	const char *retval;
 
-	retval = getenv("LANGUAGE");
-	if (retval && *retval)
+	retval = filter_out_non_languages(getenv("LANGUAGE"));
+	if (retval)
 		return retval;
 
 #ifndef NO_GETTEXT
-	retval = setlocale(LC_MESSAGES, NULL);
-	if (retval && *retval &&
-		strcmp(retval, "C") &&
-		strcmp(retval, "POSIX"))
+	retval = filter_out_non_languages(setlocale(LC_MESSAGES, NULL));
+	if (retval)
 		return retval;
 #endif
 

In the production code, we should have a comment before that new
helper function that explains why we exclude C and POSIX, if we were
to go that route.

> Not sure if being more strict adds much more value here in practice
> though. So it may be fine to keep it as-is. :)

Yup.  I care more about having a single place that checks using the
same logic, than what that logic exactly is ;-).

Thanks.

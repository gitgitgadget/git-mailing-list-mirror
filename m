Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3ED1D9A4D
	for <git@vger.kernel.org>; Fri,  4 Oct 2024 16:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728059531; cv=none; b=ln0iwlotOV12qlGVWF8rNUp9K6z39apNiXx3QRERzXnJGZ234WiijSw5WZidy48qmSe54Hc4DC9AXYCqll3Wqkx+9uYEhS5SdNt++VKMcbREmH6DMrcg1jr+Bd4GeuLE2/VwxdoB9qEL/yJ/0/OiktRnlmGtasiMjpA9tDaCBQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728059531; c=relaxed/simple;
	bh=eqi7i7mtGkyOUAMlD5IeaJkJbnbrMz/FAZBAN7LzPog=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rZfkJxnNKLpNuVSANuLNgU30F8LaGugo7kola3L54PdQnx/ifc4EAYepPVkYfy7wba+0PRBjKhJl2a8sL9/tV53N3aIYz8f/b1tQtwOoXtnse6ta/GZ7kHeYrKy3ni0aCZgFYbK1bAFvfu7/70iOuruRMAxHamZoT0ghJKGhgRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=oSgf5BHi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mMqhu2UG; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="oSgf5BHi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mMqhu2UG"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 9644213801CF;
	Fri,  4 Oct 2024 12:32:08 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Fri, 04 Oct 2024 12:32:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1728059528; x=1728145928; bh=Ejz7lYk5le
	elRCgLcmZE4aHcXF0a5nZQGJLvBXQUhhc=; b=oSgf5BHiR2JbFGBNa54ZBhnDTN
	quZgya0MWyHlkD2vNWFMedYpWX9n/xq0QeoojZ+zN/EDZFIGl3aCpCghCeLoiN5w
	QaG8VChlhbLTrkjaulTphpbuNixvE8rx+/rCJWdhW25UpxX6Dh2vS8Bs5hFf49vy
	X5DO9uArqqHoHFQ0cQIfBEtZV81fvWAjzp82bKlswAD6yyC38aaGZrbe4sanmn/j
	/NuGRDeWXj6dBL73rSFJwtCUu+AKYTD8i5r/V9yuFZXbDQIz8Lt4WVVuahVZEIq8
	SJzMwmVgsRnYq2W/B90tyPLhs7mrQC5RXGz5aziS9XiBnQFYQcAfb9gvl2Sg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728059528; x=1728145928; bh=Ejz7lYk5leelRCgLcmZE4aHcXF0a
	5nZQGJLvBXQUhhc=; b=mMqhu2UGnd+FKRLwneX94dKvMxpe0XMPnZfXiSUBlC1O
	mhfZqANVxXsqfq/MxfknM6RAnfr3PoY/mr0TNIx8pHbKuRZqPbZHsmuvubGs1xhP
	XWOdK2LR5CuVo35becgfPqs2PefNmWc3ahE2YaA5NrPzhRYZHyP4gfkgRqHEMMp/
	sG2wreHWMumN2VZFgXUWUgAeh4ldyNZ1s3vC6QriL5HvRcomcfNjBMi5onpT7UWA
	bELnFYY9EU/IznJWWjPe70ZCs+A3Ejux25jvtZQvpXVRPneOhx4Mv62IpMUdw3oS
	U4eIMh6eROMeEjPf5Ph+d111BeXaWyG42+kY14zMsw==
X-ME-Sender: <xms:iBgAZ2FgvHUCseUfuGYkLUvnUC1aYexPQizf-sIli_lTSmM0Txakmw>
    <xme:iBgAZ3VLLp8_keY7d1s125ym0zgbHa87b5WPQFWtgVguw4rYMKRVzWO_vsoz9aOdY
    x83tkMKReuZYxF6pw>
X-ME-Received: <xmr:iBgAZwKXvVu3WFbHk3xw5B5pYTPCeZzcC3-kgvEROw9UUXPFhsbHFUUBZNCorzWrZA3vD76cy1-Xln2S6yUh1EJjLmntPHnHzMIqJ7g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddvfedguddtudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehrrghmshgrhiesrh
    grmhhsrgihjhhonhgvshdrphhluhhsrdgtohhmpdhrtghpthhtohepphhssehpkhhsrdhi
    mhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtohep
    phgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehsthgvrggumhhonhesghhoohhglh
    gvrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:iBgAZwGEIJzohdIOqh3Pmf6_-QMDxrkFzi1rbUaX252bVBqnAJekCA>
    <xmx:iBgAZ8XeoHuXWO5n1z1VP_5F2W4lqZvTLDv7Qvg_XSxRVXwguU9hZg>
    <xmx:iBgAZzN0JuB531r8lfcC5JChh_GmFiMBfhlJOmqxzdb2MPSPJXyanw>
    <xmx:iBgAZz3dZsjwADQrzick9xQ2n2TSC2aKATgpEUgfOwm5ToWhMwVPTg>
    <xmx:iBgAZ_GcxcqpaDttSXdrzjfu4DrV_DAMXLYcJutvKNRj6EtNQWbmqYFL>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 4 Oct 2024 12:32:07 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,  Johannes
 Schindelin <Johannes.Schindelin@gmx.de>,  Jeff King <peff@peff.net>,  Josh
 Steadmon <steadmon@google.com>
Subject: Re: [PATCH] t0610: work around flaky test with concurrent writers
In-Reply-To: <277c243f-7179-4946-99c8-b19ad5c85412@ramsayjones.plus.com>
	(Ramsay Jones's message of "Fri, 4 Oct 2024 15:47:01 +0100")
References: <b1b5fb40-f6c2-4621-b58c-9b7c8c64cc01@ramsayjones.plus.com>
	<f83e23f1e76454a80e3e53cd02b3bb5bba6b8da1.1728044178.git.ps@pks.im>
	<277c243f-7179-4946-99c8-b19ad5c85412@ramsayjones.plus.com>
Date: Fri, 04 Oct 2024 09:32:06 -0700
Message-ID: <xmqqy133esmx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ramsay Jones <ramsay@ramsayjones.plus.com> writes:

> This doesn't work for me.
> Can you think of anything else to try?
>   
> I would strongly suggest skipping this test on cygwin as well as MINGW.

There was some mention of "Win 10 or later" in the thread, IIRC,
while explaining why Cygwin version of rename() works.  Is it
possible that the version of Windows and Cygwin you and Patrick
used are different enough?

In the meantime, I'll queue a SQUASH??? on top for preparing today's
integration.

This is a tangent, but there are places that use !MINGW,!CYGWIN and
there are places that use !WINDOWS; I think they are equivalent
prerequisites that we might want to straighten out their uses as a
clean-up later.



 t/t0610-reftable-basics.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git c/t/t0610-reftable-basics.sh w/t/t0610-reftable-basics.sh
index 86a746aff0..e10c894cb0 100755
--- c/t/t0610-reftable-basics.sh
+++ w/t/t0610-reftable-basics.sh
@@ -454,10 +454,10 @@ test_expect_success 'ref transaction: retry acquiring tables.list lock' '
 # that Windows does not allow us to rename the "tables.list.lock" file into
 # place when "tables.list" is open for reading by a concurrent process.
 #
-# The same issue does not happen on Cygwin because its implementation of
+# The same issue may not happen on Cygwin because its implementation of
 # rename(3P) is emulating POSIX-style renames, including renames over files
-# that are open.
-test_expect_success !MINGW 'ref transaction: many concurrent writers' '
+# that are open, but it probably depends on the version.
+test_expect_success !WINDOWS 'ref transaction: many concurrent writers' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
 	(

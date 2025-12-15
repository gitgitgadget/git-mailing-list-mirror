Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DAC91D5CC9
	for <git@vger.kernel.org>; Mon, 15 Dec 2025 01:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765763992; cv=none; b=uSoppyx2Qoz8wp8bkQYjZFxhB3f4Of9wpag1DWAR5RsUo+8ZCJcypT/vW/4Q4bFZzkZKWLIy4o2jHKkapmKsbbZnp4tDtyUDvOSFvzCdUaBQ1+gd1JqO9TdOPOTccsCd/Cqp/uncw/JBt7vdU24m1VhB76gFwe7Lom4v2SCAfo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765763992; c=relaxed/simple;
	bh=BJhDFr0z9QLZh7ubhDAOuArCuNpSKPM23R+nXSI+pPE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HhVLZERk48WzJYfilNdyV991AnyDsIfgPlHkDOlXDrbPLXAkxqTVUGpei6hR3Ybo3No1rpYL6LNgqsyxi1F4p05i3Y5aTYj7Y2+/2ers+VyD6RwcEMSVi4No+1jzWSBdjSgVszvAvwW2inwXnfei0JFHbr1hqojEZP7T4N0/yB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=MAHqAFQo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cXErs6hQ; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="MAHqAFQo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cXErs6hQ"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 40A4E7A0113;
	Sun, 14 Dec 2025 20:59:48 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Sun, 14 Dec 2025 20:59:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1765763988; x=1765850388; bh=iRnBo0cDvx
	t30YcBZrDm1RPDqBzExTfK8gM73tp1D2E=; b=MAHqAFQoclrQtkowvbFbWKNKjZ
	odlr2IxpCxSP1/kJzqYnFzRKqedA81/A2w2V4eV6t5golFbX85+rYNrEB5c09ZrW
	aDHDtolighe75xgABF0BUdv8dLAhcWbOinyfZ1YnQz4O7D+50WGhTlQKyTnIWFUb
	K3r01l/g1MWmdUw9t+fUNoPgAanbObMRq6tJpB1UrYC2rveDC2p6N0189nip1N1y
	guqZalU/FrsDxJT96BhCrSXW3tp7SqgijXyc0u6y3IamwsDWvltlcSJD2BDvbvvF
	r9RH9X6PQfZ5dz3npxbHFKNI3BkXHyOb0isdIPYuN4IHbjK1bh1yHqKTMSMQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1765763988; x=1765850388; bh=iRnBo0cDvxt30YcBZrDm1RPDqBzExTfK8gM
	73tp1D2E=; b=cXErs6hQlP5xkok0FZcVx8j9lWqNNyis4DWy8Ujlr5OaBCA5SHa
	Be6Sq1i7jJyUCU5GVdYDZdethls2zS8uMWy8Lq/yhjvMEkrSYNJbBOqDqD04mz0r
	8y2Fad1EyCk7CVLBRGswWJELXUcWFwfk0L0xlv+Y93S+ut5eNR50JSWnpwWrBuoe
	/d6+RsOrhx+G+0AArjePI2/4qxF1XadaI3bqN+kHi/t/02gkedkR2q3Wo20ImBYn
	tSxk9ydmjuw4FarJVhUBlHwuJJa5T3pg44xc6IFYuvpTdEOxDIQ7N1Ygt9tSTesV
	4i9bzlmZiUM/yO7rFuKT87hEY7wFEzfi+Pw==
X-ME-Sender: <xms:k2s_aehYlonwGu3NMpSvSX30_ok7OsQ_mPYOvOHI1T7CANYhw4vK6Q>
    <xme:k2s_aV4x8eksQNaGw8KzxcsLqH4rXAaKGS1iokNoruaT0qzKoo8LVoUfjXsQM1bb2
    smoxlU0SYkJMBo85ICO6mln15H4yDunL_rXALhVXTsdBYVvvFCMFqU>
X-ME-Received: <xmr:k2s_aeYLx_cCplV7x5KqR8-TgSDQIo_3r1sFSAhsoumF-E0GgJ-HCZK51WO6wZJGyu22RUjkerzrZK7q4q7o7Q5jNa7EBweE8g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefheehhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrsh
    htvgdrnhgvthdprhgtphhtthhopegtrghrvghnrghssehgmhgrihhlrdgtohhmpdhrtghp
    thhtoheplhhishhtsheshhgrlhhlvghrqdgsvghrlhhinhdruggvpdhrtghpthhtohepgh
    hithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehp
    ohgsohigrdgtohhm
X-ME-Proxy: <xmx:k2s_aS7fGUaanIrwuZZOLQ4RXek-kllm3YNUM03mqOSK8zuo8K9UkQ>
    <xmx:k2s_aZAXBe8iPbcdue4TxGTC6NtmHZGdkMeEi_dPzbKbpjpUTy6YMw>
    <xmx:k2s_aQfCEvWwPEg3TmErFjw4zuO_WkMgHrK4qwODjSYQuewtBf3X2A>
    <xmx:k2s_aQIv_Hk2vsSLP6MWtnK8iksGYWDo94FZA8GO-e5xULM5_118HA>
    <xmx:lGs_aUWBTc24gArb-DXWBoTP8brfV0GSOyIZeJcMh_TdBH_Z06BF4Jr->
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 14 Dec 2025 20:59:47 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>,  Stefan
 Haller
 <lists@haller-berlin.de>,  Git <git@vger.kernel.org>
Subject: Re: Would it make sense to add a commit.signOff config?
In-Reply-To: <aT9iu9He3yJ3npWX@fruit.crustytoothpaste.net> (brian m. carlson's
	message of "Mon, 15 Dec 2025 01:22:03 +0000")
References: <86c5d40d-5a06-4a69-90d8-a737685b0536@haller-berlin.de>
	<aT7lkXl65-TBIsRS@Carlos-MacBook-Air.local>
	<xmqqsedc8w7k.fsf@gitster.g>
	<aT9iu9He3yJ3npWX@fruit.crustytoothpaste.net>
Date: Mon, 15 Dec 2025 10:59:46 +0900
Message-ID: <xmqqldj48pyl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> I think this would be a fine approach or we could add an entry in the
> Git FAQ (or both).  I agree that this is something that comes up
> frequently and writing it down in a more visible way would be kinder to
> users and mailing list participants.

Something like this, then?

---- >8 ----
Subject: [PATCH] document that foo.signoff will not be added

Every now and then we see this coming up on the list.  Let's help
new contributors who are not aware of past discussions by clearly
documenting our past consensus.

Helped-by: brian m. carlson <sandals@crustytoothpaste.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/gitfaq.adoc         | 15 +++++++++++++++
 Documentation/signoff-option.adoc | 12 ++++++++++++
 2 files changed, 27 insertions(+)

diff --git c/Documentation/gitfaq.adoc w/Documentation/gitfaq.adoc
index f2917d142c..656093047a 100644
--- c/Documentation/gitfaq.adoc
+++ w/Documentation/gitfaq.adoc
@@ -83,6 +83,21 @@ Windows would be the configuration `"C:\Program Files\Vim\gvim.exe" --nofork`,
 which quotes the filename with spaces and specifies the `--nofork` option to
 avoid backgrounding the process.
 
+[[sign-off]]
+Why not have `commit.signoff` and other configuration variables?::
+	As it makes it harder to argue against one who tells the court
+	"the log message of the commit ends with a Signed-off-by
+	trailer by person X, but it is very plausible that it was done
+	by inertia without person X really intending to certify what
+	DCO says, hence the Signed-off-by trailer is meaningless", if
+	we add more publicized ways to add sign-off automatically, Git
+	does not (and will not) have a configuration variable to
+	enable the `--signoff` command line option it by default.
++
+There exists `format.signoff`, but that is a historical mistake, and
+it is not an excuse to pile on more mistakes of the same kind on top.
+
+
 Credentials
 -----------
 
diff --git c/Documentation/signoff-option.adoc w/Documentation/signoff-option.adoc
index cddfb225d1..0b869dfbe4 100644
--- c/Documentation/signoff-option.adoc
+++ w/Documentation/signoff-option.adoc
@@ -16,3 +16,15 @@ endif::git-commit[]
 +
 The `--no-signoff` option can be used to countermand an earlier `--signoff`
 option on the command line.
++
+As it makes it harder to argue against one who tells the court "the
+log message of the commit ends with a Signed-off-by trailer by person
+X, but it is very plausible that it was done by inertia without person
+X really intending to certify what DCO says, hence the Signed-off-by
+trailer is meaningless", if we add more publicized ways to add
+sign-off automatically, Git does not (and will not) have a
+configuration variable to enable the `--signoff` command line option
+it by default.
++
+There exists `format.signoff`, but that is a historical mistake, and
+it is not an excuse to pile on more mistakes of the same kind on top.

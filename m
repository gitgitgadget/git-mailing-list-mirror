Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC972DCC15
	for <git@vger.kernel.org>; Thu, 12 Jun 2025 21:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749765069; cv=none; b=G7/xQINAPav9eMTbeeqeqWBfX6Qg7tfFDwteH5OMqusJQs6o63lA/zvHRPG97RgkHzD3JSHG5LDkesP6XBwHeIviDcnVYYrxgcygt6qrQp0PPv7zx176uCzxi33nX2VlPyjA5AhHXb0oMnqCUD8lugSi6uKNQk+ptKVng0fL6LI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749765069; c=relaxed/simple;
	bh=NMZeB/8zNYUuePefRpF0fmJU+rCU53YwjDZQPsla3mo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Qmy0TUdb5IR7LQsnE2XoR7iCEaw1Pxo9rgZ5PK/kJkUTAT99ozP+peib2zJFewyWdovCwFjc+b7byZkH0pUYZAclbkfS9wt/in70YO1LkkTrVNNG3dgAdEYnWNA2uIdNXwuzsQ75PnzVPQUY+KzWIHXpEZZ3QnDJARh5JJ2sJpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Go9Q1TmV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DaAUabb3; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Go9Q1TmV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DaAUabb3"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 86D831140268;
	Thu, 12 Jun 2025 17:51:05 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Thu, 12 Jun 2025 17:51:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1749765065; x=1749851465; bh=3ED8VQ6JO8
	HEkwM9Dc9GbHrGXvxFVJbBsmzK+h3Sb+o=; b=Go9Q1TmV/co9Mrd6NbsAOnmvjx
	NPK/zqE22Gf+TvLUDlsN0nCZfvGv7h3aSLBK+szroW7imwwzQ24Qs1ayzmIohiwj
	NAMIdoO/CA9WSzZ+yQcLqAzqgCHLg2MYFC+ZfulXKYWFV7x1KKUQkGSeEi+tgaNH
	dLy/tEYTLTDTfdtnjeg82TrKeTXyOaraGPAlhK5UnB2fcRennLVCr0lQYhm7NJxZ
	rXYU24/azCFFJwgKFCI/wU7K0i18VLufzzZQsOCnQllBiI4kS3E78mUgFzRKNIdO
	4mBpnC5wv6Txm2JfMEr7qEKiqqTsKQPHXZT0GeSmetGVZNQ2P/RDgUvkFGbQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1749765065; x=1749851465; bh=3ED8VQ6JO8HEkwM9Dc9GbHrGXvxFVJbBsmz
	K+h3Sb+o=; b=DaAUabb3YE7LuxcqFUypOQ0wwB5vv735Fcf6GvrjFyV61iklzBa
	/JauiIxIEhtmxkhlrJ1Bd4EMaBG1Ap73ZMdY+AqNY3YP6YZeT4wcxVevcxnJc0ul
	cwi/Uon8+rQ2UxmR2JfRks3ngaiHlza0hgeFiwMRaRbD9FOr828hxJOxWkBNGz2G
	72rHmFUvNCvN6tmj2dkvB9r4a9fOdh/yG+VAE8KK/LZSKDw7xYma/oZRFWruhtaL
	PuAWZDGLs8DTXUU4yyL8BSJ4r/+/Nzl8FRfFWtV1/FzTc//tatblQCEU6U4s7SJl
	C6PXnr0ZwTgar1y1z1DAm1uG/WraCXm7Png==
X-ME-Sender: <xms:yEtLaBnVIYfEmec1xrKBXl0OY7r8dPSsZosqaJHlBhNGSd2TmWHMJQ>
    <xme:yEtLaM1N3lfkPo_HZRlADmsLkpTViW3v5NbhhAH36eOtuPsUHg9RbOjOEYEXjWOEt
    7V8T8QFL1IbZNrWpA>
X-ME-Received: <xmr:yEtLaHqm6ZmJQZu909iShQ7ub2ftSb7C304OD4JVfpGTkf96w0YOjSoQIgF5Ia4MNwNgbWCW5J7cmqvFw8RymlPkFN9QPiGmOKR5>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdduiedulecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptggrrhgvnhgrshesghhmrghilhdrtgho
    mhdprhgtphhtthhopegsrhgrugestghomhhsthihlhgvrdgtohhmpdhrtghpthhtohepsh
    grnhgurghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohep
    ghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:yEtLaBnqaP3niWABo2wdYP6uXl-DOHTvSTZJlQ7UG5YeToPMl3qZVw>
    <xmx:yUtLaP3mTeEX9RLLdtd92nkaGUaFM5Wkft7NAqJAZ1gs0ZBGrEaaNw>
    <xmx:yUtLaAtE1cO41zPJ6wV1roC6N8reT3w0AMdKWxcRwj2D698419YxBQ>
    <xmx:yUtLaDVssbN9gbWFGSKFw9X9AHRo4WODNHKmq3Co5DHeEUhnnJfYrw>
    <xmx:yUtLaNWfnLa9J2FzJhW91B7vbUTM7OEyAuMhtop5hnBMF8xr0brbfaEH>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Jun 2025 17:51:04 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Carlo Arenas <carenas@gmail.com>,  Brad Smith <brad@comstyle.com>,
  "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v3] config.mak.uname: update settings for FreeBSD
In-Reply-To: <aEsE8S90fJSr9Or5@fruit.crustytoothpaste.net> (brian m. carlson's
	message of "Thu, 12 Jun 2025 16:48:49 +0000")
References: <CAPUEspguEY+e-J0dMA2EdDgu=t4fK5ASS13Jfp_Mgwiq3Rtd0Q@mail.gmail.com>
	<aEsE8S90fJSr9Or5@fruit.crustytoothpaste.net>
Date: Thu, 12 Jun 2025 14:51:02 -0700
Message-ID: <xmqqv7p0bpdl.fsf_-_@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Even though FreeBSD 6 introduced memmem(), the implementation in
that version was buggy and not performant until FreeBSD 12, FreeBSD
11.4 (the last version of FreeBSD 11) went end of life in September
2021, so nobody should be using it since it hasn't had security
support since then.  And memmem() has even been functional (but
slow) since FreeBSD 11.0, and 10.4 went EOL in 2018.  So users
shouldn't actually be experiencing any actual functionality problems
since then.

Let's draw the line to require FreeBSD 12 or newer (but we do not
officially document it or enforce it by breaking build when compiled
on older versions, at least not yet), which allows us to drop the
special casing of FreeBSD 4.x and rely on platform implementation of
memmem() unconditionally.

Signed-off-by: Brad Smith <brad@comstyle.com>
[jc: log message with help from info by brian carlson]
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * So,... earlier I mentioned about officially documenting the EoL
   timeline for various platform support, but without any official
   one that documents the decision in one place, how about a commit
   with a detailed log like this one, which I stole from brian?

   No code changes since v2; only the log message talks more about
   where we draw the line and why.

 config.mak.uname | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/config.mak.uname b/config.mak.uname
index b12d4e168a..5d18d92cb1 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -273,16 +273,10 @@ ifeq ($(uname_S),FreeBSD)
         ifeq ($(firstword $(subst -, ,$(uname_R))),10.1)
 		OLD_ICONV = YesPlease
         endif
-	NO_MEMMEM = YesPlease
 	BASIC_CFLAGS += -I/usr/local/include
 	BASIC_LDFLAGS += -L/usr/local/lib
 	DIR_HAS_BSD_GROUP_SEMANTICS = YesPlease
 	USE_ST_TIMESPEC = YesPlease
-        ifeq ($(shell expr "$(uname_R)" : '4\.'),2)
-		PTHREAD_LIBS = -pthread
-		NO_UINTMAX_T = YesPlease
-		NO_STRTOUMAX = YesPlease
-        endif
 	PYTHON_PATH = /usr/local/bin/python
 	PERL_PATH = /usr/local/bin/perl
 	HAVE_PATHS_H = YesPlease
-- 
2.50.0-rc2-215-g56f75d5edf

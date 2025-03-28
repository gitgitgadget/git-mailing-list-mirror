Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ACBA21322F
	for <git@vger.kernel.org>; Fri, 28 Mar 2025 08:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743151130; cv=none; b=PN5r5WBrQCSTLYQcBxJg4oWLMVdwh2yIYSxJqyUT8cjsHGxPexNkYZyavU6USmOwwdQ9NirEan/9G5+AHJuxrX4CuaevfCPsbgS9kGJVzVw+ru6LT3XPLiIqYVKkf9d+Z4r6DE2MJn5azVM7DIfHe7sXxzFdGIAvztjiGBC0kvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743151130; c=relaxed/simple;
	bh=bfOZTh7jCaIdYI8MGCABuaLB8+tYSK/ytjoNn36xUBI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IuEtw5ikZngIv4RrwU6q8VuCjaoPwdgPk7JWlbLUVujYAMCTBp9PFBsIoWo1yD0wQeYRXOX7RptJqBNxWOPgAmu1y/ui9KNoOmDfBVWYbmqomu41mifnUT8mf3IkA3cg24+VEHsdPJeV8m6TUEzTtrC0OVAh6By4lZkg9yV8ws4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=HPO+AnTy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aY4cGVVh; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="HPO+AnTy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aY4cGVVh"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 0D7CB11401CC;
	Fri, 28 Mar 2025 04:38:48 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Fri, 28 Mar 2025 04:38:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1743151127;
	 x=1743237527; bh=xKxOiIL8rHL8pdtpMBUi5TudStErhBpiB4PZluHrRxo=; b=
	HPO+AnTyWiJDjlcw78KXtlsgfXIMM4Dh1zpRNUBVjyyUqY6lrv4ZJ5LvEih4Ou5l
	sNHk9P3N/D0FpMD26Fstu86HuMpHFrJdXUrxQ0henMOZFFCrVtLSKwgBjuBvDYbY
	YBZxjgNxakeS9NpXK76yses7WRPPcQgFSLud6HggIekD3mlwYMT25Ruyqtn7klhm
	wE3jYKsaB2j2QTLisvS6+QMrYWEBpnJx1z0ytbKMj5WlUWxvPVi+rgHjAqzmBTEZ
	6cfi8gBXdF2uDKEMxqnC4hRM624E6TxFLmAp6FrDS80A8QER+U6Js/KiCb8qCTDl
	LY0vuVwoX/5Qn5MJp9T3gQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1743151127; x=
	1743237527; bh=xKxOiIL8rHL8pdtpMBUi5TudStErhBpiB4PZluHrRxo=; b=a
	Y4cGVVhbwDoFQWDftK56Z/iDR9GQSegNANbNJHwFf0kRWSkn5d/H2JCGbDywZY5X
	MgLv3QR5bsM+OQD0btqaOdzEHhMCg8bFGx1e40RlXWWDQJCzWKFheWNWigK/l8WY
	p+oAd0rhX7ZhdLhJ6FvPY9Bh9B4SHv9GqWvOvREnnooa2MTmXRMS/bZjYMqpS/Qb
	r74czLOl+GgtO9kqeViLcWWGbYOR/tQsHoSG6oWDRVIIuDHLHEj7XKgMZUlH7+na
	53949DRUzgetAIUA6Guh1UX5H8fBDF6eSWr7cSMS389WAaF/MYNxEtYAtsCDHZns
	eOPFm36o7cnAjqxcXlpGQ==
X-ME-Sender: <xms:F2DmZ--TyU26f8mmUclJQGOydsQ8Q1nr2oADEVdUr6vEmaeuJft95g>
    <xme:F2DmZ-vSBiSJ5Jw_DQFFm1aGSDXc1uyeJmluVPi6deHzD3T4Q80Lp0iI-t-1knJPS
    o7I9Y2C4Zo-pFOTdw>
X-ME-Received: <xmr:F2DmZ0BIa6qnOzpJmDqcbTQOFoDKO0813SM6SIkJUOBLP42sLwonLbx9mVSWMw0ldFBErYz6qd6BoTOlCrtfQT3AXfkdUcRv5VVfTUdQNW6dkDk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddujedtkeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeeipdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpd
    hrtghpthhtohepthhgseguvggsihgrnhdrohhrghdprhgtphhtthhopegvshgthhifrghr
    thiisehgvghnthhoohdrohhrghdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhm
    gidruggvpdhrtghpthhtohepshgrmhesghgvnhhtohhordhorhhg
X-ME-Proxy: <xmx:F2DmZ2evelIAy7CB6nJFIyqmZcY1sNzY0E1YGSVcUz3rWFBfVZRR3A>
    <xmx:F2DmZzP9CplejQR-WF7ZzMlF1EclLAOwSC-LCtmsvnFZkyPeXZdwPQ>
    <xmx:F2DmZwk9FC_e0onVDqKfug-Do0TTlDbNBRACdtLSawOovaQzPatHUQ>
    <xmx:F2DmZ1ukXb-XeJGYTfU4zPtaJQwVMXlLY3sszeKgaRp_7QR9jr7M9Q>
    <xmx:F2DmZ_DSD6dgrv-q2E0ooYwk2X5AdUFfUAu5l66A4CYerPsrz-bA7Ehz>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 28 Mar 2025 04:38:46 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 0b3b6ec5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 28 Mar 2025 08:38:43 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 28 Mar 2025 09:38:37 +0100
Subject: [PATCH 3/4] meson: require Perl when building docs
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250328-b4-pks-collect-build-fixes-v1-3-ead9deda3fbc@pks.im>
References: <20250328-b4-pks-collect-build-fixes-v1-0-ead9deda3fbc@pks.im>
In-Reply-To: <20250328-b4-pks-collect-build-fixes-v1-0-ead9deda3fbc@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Sam James <sam@gentoo.org>, 
 Eli Schwartz <eschwartz@gentoo.org>, Thorsten Glaser <tg@debian.org>, 
 Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-Mailer: b4 0.14.2

From: Eli Schwartz <eschwartz@gentoo.org>

When building our documentation we require Perl to generate the list of
commands via "cmd-list.perl". Having a Perl interpreter available is
thus mandatory when building documentation, but Meson does not enforce
this prerequisite. Thus, when all optional features that depend on Perl
are disabled, we won't look up the Perl interpreter, which will in the
end lead to an error at setup time:

```
$ meson setup builddir/ -Ddocs=man -Dperl=disabled -Dtests=false
[...]
Documentation/meson.build:308:22: ERROR: Tried to use not-found external program in "command"
```

There is already a list of other cases where we do need the Perl
interpreter. Building documentation should be one of those cases, but
is missing from the list. Add it to fix the issue.

Signed-off-by: Eli Schwartz <eschwartz@gentoo.org>
Commit-message-edited-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index a8d1e63ccc6..51013c70de9 100644
--- a/meson.build
+++ b/meson.build
@@ -772,7 +772,7 @@ endif
 # features. It is optional if you want to neither execute tests nor use any of
 # these optional features.
 perl_required = get_option('perl')
-if get_option('tests') or get_option('gitweb').enabled() or 'netrc' in get_option('credential_helpers')
+if get_option('tests') or get_option('gitweb').enabled() or 'netrc' in get_option('credential_helpers') or get_options('docs') != []
   perl_required = true
 endif
 

-- 
2.49.0.472.ge94155a9ec.dirty


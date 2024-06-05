Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E57E9194A50
	for <git@vger.kernel.org>; Wed,  5 Jun 2024 17:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717609943; cv=none; b=S/BR4b3E+qcDQz5V/aXuFMg5P/3eHwpzXJPkDTtsjYM6Bt6bfho3xli9Mu6l8fNN28Bv1DbjFM+BX5xZAHdabCmmJA/XY3wmZSWmQ177GC4S1xBJzDE5gYpgrnojPGKN1iKdhei+ZqdFhYyQm1WLezaQoE/r8/OSaL9B/5upH3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717609943; c=relaxed/simple;
	bh=bIzW4k9YRBn9tNYSHcWO3sLhcKRUzpXrI4yXDkOMPZQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qBO2nyHJlgghV0+mHvVzggwppr8fs3il+ufc2g6mCiPDns2qGSrfxJnP7W4fj+/ohdZvnYid7nZwmI6SyEa5AqxqZztTC2KiV8IsA37yUPVKOz3mbPAR9v2UXJdQVR9BHJpelPDK75ouNqZ/cDYwZi5kkLmlw0g95rQI4EFnN+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=tXbHpf1h; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="tXbHpf1h"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 4CD631B8EA;
	Wed,  5 Jun 2024 13:52:15 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=bIzW4k9YRBn9tNYSHcWO3sLhcKRUzpXrI4yXDk
	OMPZQ=; b=tXbHpf1hfLFswifdTO97YqOzaASVdtae+RG9MbOAHANy9CKtRc+BAy
	DVkjJ6nrMq0jbYnGCZeDdzY+058R8d8oNfijq/4YcQ2+Ua/joNt1QQ3WDT8wTT0x
	TF8sYs6AvP+7rH5xTEB80VKZnUZGPT1+70UTPm6xmf+oiYrD6mfWE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 449C71B8E9;
	Wed,  5 Jun 2024 13:52:15 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 60F9F1B8E8;
	Wed,  5 Jun 2024 13:52:12 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Johannes Schindelin <Johannes.Schindelin@gmx.de>,
  Phillip Wood <phillip.wood123@gmail.com>,  Justin Tobler
 <jltobler@gmail.com>,  Dragan Simic <dsimic@manjaro.org>,  Karthik Nayak
 <karthik.188@gmail.com>,  Todd Zullinger <tmz@pobox.com>
Subject: Re: [PATCH v6 1/4] docs: introduce document to announce breaking
 changes
In-Reply-To: <xmqqjzj3wf4m.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
	05 Jun 2024 09:03:53 -0700")
References: <fc1a9fa03de7330f79dc56b0f2712834cb236b5a.1715070296.git.ps@pks.im>
	<cover.1717504292.git.ps@pks.im>
	<a260bbf281d2975562a042a71ca0dd7f88f03da4.1717504292.git.ps@pks.im>
	<xmqqsexsvbaf.fsf@gitster.g> <Zl_4IIqFmoPhx1Gc@tanuki>
	<xmqqjzj3wf4m.fsf@gitster.g>
Date: Wed, 05 Jun 2024 10:52:10 -0700
Message-ID: <xmqqplsvs2et.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 56593BA6-2364-11EF-9A1F-ACC938F0AE34-77302942!pb-smtp20.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

> But "in retrospect we should have called it 2.0" is patently false;
> switching from 3-tuple version numbers to 2-tuple version numbers
> has nothing to do with introducing breaking changes.

I tried to make it concise, and came up with the following on top of
tweaked [v6 1/4] on 'seen'.

 Documentation/BreakingChanges.txt | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git c/Documentation/BreakingChanges.txt w/Documentation/BreakingChanges.txt
index d977915e52..9c2c5f2328 100644
--- c/Documentation/BreakingChanges.txt
+++ w/Documentation/BreakingChanges.txt
@@ -21,12 +21,19 @@ change in user-visible behavior.
 The Git project irregularly releases breaking versions that deliberately break
 backwards compatibility with older versions. This is done to ensure that Git
 remains relevant, safe and maintainable going forward. The release cadence of
-breaking versions is typically measured in multiple years. The last breaking
-releases were:
+breaking versions is typically measured in multiple years. We had major
+breaking releases like these in the past:
 
-* Git 1.6, released in August 2008.
+* Git 1.6.0, released in August 2008.
 * Git 2.0, released in May 2014.
 
+We use <major>.<minor> release numbers these days, starting from Git
+2.0, for feature releases, our plan is to increment <major> in the
+release number when we make the next breaking release (before Git 2.0,
+the release numbers were 1.<major>.<minor> with the intention to increment
+<major> for "usual" breaking releases, reserving the jump to Git 2.0 for
+really large backward-compatibility breaking changes).
+
 The intent of this document is to track upcoming deprecations for future
 breaking releases. Furthermore, this document also tracks what will _not_ be
 deprecated. This is done such that the outcome of discussions document both

Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F1111361DF
	for <git@vger.kernel.org>; Thu, 29 Feb 2024 18:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709232906; cv=none; b=Ls/LDAB0xQwabnxAugI8SNyH5bDK2RiXu1qKRrWh90yTe9q6ogv6zwfikjT2THksiawD2FS+4yKZ8Md27ZZ/8r6CKxFH3bFYOa8/6jjRXOUNTVOm4zJVN+F8heXwlrSz/7gjdEB9FM3s49/NMtGVLcH13vo0dida8Sf4FAfUj4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709232906; c=relaxed/simple;
	bh=4CE90zb1kvxd60OKSKN8kx16GYCeTH06HCQ7BcYSH4g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ubckMjuL2b9kGuOVdSNowWLLKXXlhnsPv+zdDJG0UMkVi4xWKN+Ox3Kuy/15vI6uRRUAgPKPlaHKddubVUhnMmt2YPDMFX7tyd4gZqQkLP288PqWqC4do2/j9U+pOiTOZ1zov+xA7FbjrKfo4DBXs5weP/wsdmDyWeoXaw6KhZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=LkYI5BXL; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="LkYI5BXL"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 13D4E35B9B;
	Thu, 29 Feb 2024 13:54:58 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=4CE90zb1kvxd60OKSKN8kx16GYCeTH06HCQ7Bc
	YSH4g=; b=LkYI5BXLnzooQvRD3vRZqz2bZPxjBqC64Im0P+oE8pWLLrQwzzbi8T
	lSOTCE2Dfcb4DaWV/pL6AcV6vbbIddPO4jjUiXqSCpNbmaKzC3aLrmgN3HkT5quL
	/LmQCQxVAP/ru7715vtAiPb6GadDmsL4LLFCD4cd0Tpd4lPPAiLwM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 0C16335B9A;
	Thu, 29 Feb 2024 13:54:58 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.176.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id A034C35B99;
	Thu, 29 Feb 2024 13:54:54 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Linus Arver <linusa@google.com>
Cc: Phillip Wood <phillip.wood123@gmail.com>,  Calvin Wan
 <calvinwan@google.com>,  git@vger.kernel.org,  Jonathan Tan
 <jonathantanmy@google.com>
Subject: Re: [PATCH v5 2/3] git-std-lib: introduce Git Standard Library
In-Reply-To: <owly34tb5dop.fsf@fine.c.googlers.com> (Linus Arver's message of
	"Thu, 29 Feb 2024 10:27:02 -0800")
References: <cover.1696021277.git.jonathantanmy@google.com>
	<20240222175033.1489723-3-calvinwan@google.com>
	<db8b2398-c6d6-47a1-a4d4-7e4726d13312@gmail.com>
	<xmqq1q8vi3pz.fsf@gitster.g> <owly34tb5dop.fsf@fine.c.googlers.com>
Date: Thu, 29 Feb 2024 10:54:53 -0800
Message-ID: <xmqq8r33gkxu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 06C22A70-D734-11EE-876A-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Linus Arver <linusa@google.com> writes:

> It does make me wonder if we should stop being lazy and do the
> work that the linker has been doing for us "for free"
> ourselves. IOW, stop linking against a monolithic libgit.a.
> ... which might help us understand which things need what.

Sorry, but I fail see a point in such an exercise.  If a tool is
available to help us and if there is no downside of using the tool,
we should keep using it.  If you are proposing to move away from the
current build practice because you have a concrete downside of the
approach and avoid that, then it might be a good proposal, though.

And "we do not learn otherwise" is not a downside of the approach;
"we do not learn" comes from your not learning, the tools do not
force you to be ignorant.  We do not propose to use more __asm__ in
our C sources only because compilers were doing that for us "for
free" and because the compilers were somehow robbing us the
opportunity to learn micro-optimization techniques, do we?

A small downside I can immediately think of is possible in a
situation where we have been throwing an object file into libgit.a
archive that is no longer used by any final executable.  In such a
scenario, if you change the source file that is compiled into such
an unused object file, your next "make" will update libgit.a to
replace the unused object file with its new version with your
updates, and that would cause the final build product to be linked
again with objects needed from libgit.a, but there shouldn't be any
change because we are talking about an object that is *not* used by
them but still is in libgit.a due to be listed on LIB_OBJS variable.

But that is a purely theoretical downside. It may be the case that
we haven't done our spring cleaning recently and we haven't noticed
that a source file or two are now unused but are still listed on
LIB_OBJS to be included in the libgit.a archive.  But even if that
were the case, it is implausible that you are touching such an
unused source file in the first place.

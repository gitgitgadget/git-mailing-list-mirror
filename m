Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8526F1353FD
	for <git@vger.kernel.org>; Fri, 16 Feb 2024 18:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708109017; cv=none; b=BKTA7WKIu01UJLGSgCYG/0UXHUGiAXMKs7604IZN184M76TyhIGShs9Tvft4PL5utuQdFEX+qyainOt2RIo1oiR+gCKOcBgAtflcWdOWHPw+1Cq+aMPPy3dDCgsOXidFGXaJsKPIEKiw86Y58P6DsC+V9RvsIy8CeGhwTqYwytI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708109017; c=relaxed/simple;
	bh=sicsEHq9OjMo3+a+8t3ehgekPPNtYIJicuwqjzOJkdU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Wjm1OmAtz744utHKXVF0ztuMSzGFSs+lDtXM88JJiUA77r0JxHcnYHMol1K5VHnZghuE0VH2SAtHSfUtqJeU0x1n7VOtz5SMg9XanKNfifOP1tJ/wga31OweN/aWOIh5XrJV2+66g1pXdy8RM1ECezI2wYvYlatrBRH2Pb7cCeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=GC7gP+A1; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="GC7gP+A1"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 1552F1E716C;
	Fri, 16 Feb 2024 13:43:34 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=sicsEHq9OjMo3+a+8t3ehgekPPNtYIJicuwqjz
	OJkdU=; b=GC7gP+A1Czr9QCM8bHdW2sXyeWA/EliglUnjYf6TScQJ0MzircURc7
	wDyypQRGeWQPibC1cy2geWZl6qZhInXVkxDcjPOoQ4u5ZtdODW4jEOR4MsYJ0j7b
	2RbJxOw2tbSJAXR21cBUQxoDaqIjZDlTwxnxXoPxxVb7GcXKVJoH0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 0C7DF1E716B;
	Fri, 16 Feb 2024 13:43:34 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 58BD21E7168;
	Fri, 16 Feb 2024 13:43:33 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Alexander Shopov <ash@kambanaria.org>
Cc: git@vger.kernel.org,  worldhello.net@gmail.com
Subject: Re: [Improvements on messages 0/5] Disambuiguate between options
 and commands
In-Reply-To: <20240216101647.28837-1-ash@kambanaria.org> (Alexander Shopov's
	message of "Fri, 16 Feb 2024 11:15:32 +0100")
References: <20240216101647.28837-1-ash@kambanaria.org>
Date: Fri, 16 Feb 2024 10:43:31 -0800
Message-ID: <xmqqa5o0i71o.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 494EAC62-CCFB-11EE-A242-25B3960A682E-77302942!pb-smtp2.pobox.com

Alexander Shopov <ash@kambanaria.org> writes:

> These are trivial fixes to messages.
> They make sure commands and options are markes as such.
> This will help translators and end users.
> This will also reduce the special cases Jiang Xin keeps
> for git-po-helper which will ease maintenance.
>
> I am basing these on maint but I have also checked that
> they ar still relevant by cherry picking on top of latest and next.

I've looked at all of them and they looked sensible.

The changes look like this:

	-	die(_("something option something: %s"), arg);
	+	die(_("something --option something: %s"), arg);

It is not a fault of this patch, but wasn't the concensus that the
ideal form would be more like this:

		die(_("something %s something: %s"), "--option", arg);

in order to completely avoid tempting translators into touching
"--option", IIRC?

These patches do not make things worse, so I am willing to say they
are strict improvements and the series is a good first step if we
wanted to follow through to eject option names out of translatable
strings later.

Thanks.

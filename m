Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F0A144D33
	for <git@vger.kernel.org>; Mon, 25 Mar 2024 01:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711329873; cv=none; b=sbFnFGYaek0rXfUaHr5Hdz+tYlaGPAg38imR9uBSmAGcFI3tohSub6h0R6HbhmSJuXufaAMkflh8Qxba/RzcMbAigroP3d/2MDIFp7aVSGnOEts3sMU9OCeHwzHMwlrjuPupHXEEEL68940eRMdgu6PyBEEbengS+B1gj9Uf+Ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711329873; c=relaxed/simple;
	bh=31HwJs5YFxXP8XEk4WtL9jOlmLqXNgVbeRY0qUFEXIo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lXS7mhJvelRRHRw9SH9ZS5qOs5M0Km7ZQJqXQhb5P+VJF9Pob3EkI3hEu7b+6NSqy2K+Ztj04fdjQ+n8hLuWz9C69jo/8cH4uOELRZZVg248+80CXOy5corm8S7fKUZX/mH1mZdq+204hJQuRXgCZFPF2q86IsaWQQUWodnFs/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=G5lJYQcx; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="G5lJYQcx"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 38F1E2BBAC;
	Sun, 24 Mar 2024 21:24:31 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=31HwJs5YFxXP8XEk4WtL9jOlmLqXNgVbeRY0qU
	FEXIo=; b=G5lJYQcxPBajwszWykIToRuZGg5qPB2xWsDR5KPtumJNE8RD6UaG88
	FYv5vdPk9rAe/KdLci7frxXOILcATy8k4s4ykYTUO5YB0zMhBeVCJRYDri1ROcoz
	RIold2fmVOJHuWXep7YF1kcYF76S3iLL7WAJUqQLwOU31Bs5sQ7CU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 318252BBAB;
	Sun, 24 Mar 2024 21:24:31 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id B1D3D2BBAA;
	Sun, 24 Mar 2024 21:24:27 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Philippe Blain <levraiphilippeblain@gmail.com>
Cc: Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org
Subject: Re: [PATCH] t/README: mention test files are make targets
In-Reply-To: <97212b72-70d6-e55f-8b2a-04ede4321288@gmail.com> (Philippe
	Blain's message of "Sun, 24 Mar 2024 13:04:34 -0400")
References: <pull.1701.git.1711293246094.gitgitgadget@gmail.com>
	<xmqq4jcvtxtz.fsf@gitster.g>
	<97212b72-70d6-e55f-8b2a-04ede4321288@gmail.com>
Date: Sun, 24 Mar 2024 18:24:26 -0700
Message-ID: <xmqqfrwfp0hh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 6C1BA0E8-EA46-11EE-9ECF-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Philippe Blain <levraiphilippeblain@gmail.com> writes:

> Since '$(T)' is listed at the bottom of the Makefile as .PHONY,
> I think it is OK and not that ugly since this uses a documented feature
> of make.

You're prehaps right.

I've always felt that the documented .PHONY feature was to mark
targets that do not correspond to any filename on the filesystem,
e.g., "all", "clean", "install".  Of course these can exist as
filenames as well, and .PHONY works as an instruction that says "the
existence or freshness of these targets do not matter at all".  For
our use, it is OK.

I however wonder if marking $(T) as .PHONY is the right thing to
begin with.  Declaring that the existence or freshness of
t0000-basic.sh does not matter means we will not be able to later
write rules other than "just run it!" that does depend on the
freshness of t0000-basic.sh file, no?  IOW, if we wanted to add a
target like this at the end of the t/Makefile:

        t-combined.sh: t0000-basic.sh t0001-init.sh
                cat t0000-basic.sh t0001-init.sh >"$@"

then "make -C t t-combined.sh" would end up running these two test
scripts (because they are .PHONY) and then leave the concatenation
in t-combined.sh file.  Without changing anything, doing the same
"make -C t t-combined.sh" again will again run these two tests and
recreate the same t-combined.sh file, even though there is no need
to.

So I think that is what I felt ugly.

As long as we do not use these $(T) files as an input to some other
thing and list them as the dependencies, we are OK, though.


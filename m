Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60BD34678C
	for <git@vger.kernel.org>; Fri,  6 Feb 2026 08:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770368380; cv=none; b=emfKpa9LWr0fe1hQSKSfLNuVKQB2222/s1+j8W1R9wEB/sWlaP/IvOhfST6xT0sSJjRoqcMbqs2Oynf4DaVjOrhLyBWB6X5jQNgV9S/Spbiiv4DHIQOllJXN9XNCtLB/J14/ekUgNZUBtyjV88OabpmexFwXQSefg0mn17QnHZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770368380; c=relaxed/simple;
	bh=A/FE2a2Hk5ksyEKBVTZDxZXguU4TLLks6RbJ8DWlSg4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AFnb+D3lnCntsFX4kP8UQ5GXmtBKnDnFQMgQ+Kvg01dAXuUUbjP89rMIt1ANHYBRgwZiV9R34M0fYE3ZCj/7cH9XT56zzPyGPnQfFu/Q68+u4OFt9EFCB9/mj250lbLqf27iGyNx8GHWMTA/rMLNM8bMwGWCwBz4WSE7ndetle4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SvFZPSAT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SvFZPSAT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770368378;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OX6a5BwNzndEsYY/cPRe1/c/ZE1Qrq7bQspFQBYdVRc=;
	b=SvFZPSAT4D2CYKU1kJQ3KFkhbXFYix+21idvAC2dky39jaKDE50T36dU0DpUHNaOT0gImg
	kFkuNr4fwnMeeQtStuOZYHppQqfYxqJLpDIqwn47eK9tCyT/CEBbSPNGYp5C7BcLpf/zBk
	9HX+uZHvvNDj7768emI02r9ulRy9VBs=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-100-TM6sET9kP9WVNqq8yCD1lw-1; Fri,
 06 Feb 2026 03:59:37 -0500
X-MC-Unique: TM6sET9kP9WVNqq8yCD1lw-1
X-Mimecast-MFC-AGG-ID: TM6sET9kP9WVNqq8yCD1lw_1770368376
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 01B801955F12;
	Fri,  6 Feb 2026 08:59:36 +0000 (UTC)
Received: from fweimer-oldenburg.csb.redhat.com (unknown [10.44.32.247])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 99CD619560A7;
	Fri,  6 Feb 2026 08:59:34 +0000 (UTC)
From: Florian Weimer <fweimer@redhat.com>
To: Jacob Keller <jacob.keller@gmail.com>
Cc: Matthias Beyer <mail@beyermatthias.de>,  git@vger.kernel.org
Subject: Re: git-am applies commit message diffs
In-Reply-To: <CA+P7+xqcBcV8uySGgDfvt2ruAnFmfgaUy6aRbUC2zCzmCgPubw@mail.gmail.com>
	(Jacob Keller's message of "Fri, 6 Feb 2026 00:04:54 -0800")
References: <bcqvh7ahjjgzpgxwnr4kh3hfkksfruf54refyry3ha7qk7dldf@fij5calmscvm>
	<CA+P7+xqcBcV8uySGgDfvt2ruAnFmfgaUy6aRbUC2zCzmCgPubw@mail.gmail.com>
Date: Fri, 06 Feb 2026 09:59:31 +0100
Message-ID: <lhutsvuuu18.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

* Jacob Keller:

> It seems like a good idea to me to improve the format patch output and
> the git am patch splitting to somehow try and detect the end of a
> valid commit message and not treat it as a patch content, but I am
> really uncertain how to go about doing so safely without risking
> backwards compatibility (modifying format-patch to insert a marker
> that properly denotes end of commit would cause issues with older
> versions of git, so we need to use some marker that a well formatted
> patch already does.

Isn't the format-patch output already unambiguous because the sequence
of diffs is preceeded by the non-diff statistics section, and only then
the commit message follows?  It's just not possible to process this
correctly in one pass because only at the end of the input, you know
that you have just seen the to-be-applied diffs.

The other tool to look at is git rebase.  There have been problems with
the lack of "From " encoding in commit messages in the past, which
caused rebases to fail due to commit message contents (but I can totally
imagine that this might have resulted in commit injection with more
carefully crafted commit messages).

Thanks,
Florian


Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A6E31E0FF
	for <git@vger.kernel.org>; Tue, 23 Sep 2025 09:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758620231; cv=none; b=lDHzQtPXbQH+I+pIBkPPzqw3QYICosKhpDI+ZtdDqSOzQqD5CCOSfpzlXeniG+wp1aXHMwGOq6oVR1xvMkvWwwSNXu2bxzzmaG7AUHdMD/f9c+paK744FiLabfwCm8mHcuNuNRnk07YH9kGF6huW+WBQkaq0PuUO6qh0bzlIzPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758620231; c=relaxed/simple;
	bh=0NGuodDOIuJmgubWPruVYr4ovw4L4uCWL0Mqc3W1hDo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WZiQNVd/SKWsnBVAkCfRDrdfFXAzlGLID6KdbgrPRQ05liz3E1TpN6QSKGsFr927fgjoN7p8TfO3r+HQp64N9bsesPtxznqyN2SC2KZtOjhf+XNlLG8iILIDokoulLjWZKZg7kpV8i45us9h9TcqERxgzSfvGUzv7uZRhH+8Kcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=wkOD73Qp; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="wkOD73Qp"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1758620223;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sE0RB6mR6uLzfzQcdj3RsxwQlewv04recP4QfxHctqg=;
	b=wkOD73Qp7zwsDv5FiURwDA02q5LhuZOt8ZrLZIht8Tsg8Q1ajoVO2F+MnXBEa0AFHhDtJi
	4ia1f/AYz/GWm/vVlR/gYIIWuoM9bOHx8taMHbfz39C6b/RnQYjn4SKZJWsLnszWQA9BDk
	wES0O0jcNSMyrNPaKsSjpCZjgrRv4ng=
From: Toon Claes <toon@iotcl.com>
To: Jeff King <peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH 4/4] refs: do not clobber dangling symrefs
In-Reply-To: <20250922171203.GA2202085@coredump.intra.peff.net>
References: <20250819192934.GD1059295@coredump.intra.peff.net>
 <20250922122332.584428-1-toon@iotcl.com>
 <20250922171203.GA2202085@coredump.intra.peff.net>
Date: Tue, 23 Sep 2025 11:36:51 +0200
Message-ID: <87cy7hy0gc.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Jeff King <peff@peff.net> writes:

> So I dunno. My inclination is to say that the double-null-oid invocation
> is weird and wrong, and callers should update if they need to. But I
> could be convinced otherwise.

Thanks for your feedback, and I have to agree. I'll get in touch with
the Gitaly team to see if we can rid of this odd invocation. For the
record, this conversation has been happening here[1].

[1]: https://gitlab.com/gitlab-org/gitaly/-/merge_requests/8161#note_2767808133


-- 
Cheers,
Toon

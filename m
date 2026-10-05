Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com [209.85.222.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F17EE3DBD53
	for <git@vger.kernel.org>; Mon,  5 Oct 2026 21:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791234737; cv=none; b=BQhkvqwXa2/g6ZLAssCZv1a9Bih3cGa/riDCksae6WNiTFgtAjjrLziRQQ5WfyxWjdVzpKsfThM+k5cfZaKwfqlLSTS2Okz4QufWju4zWPqFHFpgowHbdTY1sgC/kLVe7y8v6cPPFy749dRkEmezTiJmD62MD+hj8XQP85Qk5aA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791234737; c=relaxed/simple;
	bh=4g0zmzGw3TdCf65tZRmY9Io3bkuvlIN35Dk3diuG2HY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VjkioeHqcgko12z5DXgnR6zZe4uxz80VV6/S7k0pQKLqjR43kFgVPEpT7hpEHAAkQyhKefrsWK/193JjUcx3DcYY5b9mi06h7CXLSp+TQc/6Wtm6Rowo4giFwNFJIUAssZY/AzKm4Cv7E+HIlNiKkJwxIbWWoABhhU3JA1pK4n0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--rmistry.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vTwWAjM/; arc=none smtp.client-ip=209.85.222.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--rmistry.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vTwWAjM/"
Received: by mail-ua1-f69.google.com with SMTP id a1e0cc1a2514c-988bbb0ed9aso1634443241.3
        for <git@vger.kernel.org>; Mon, 05 Oct 2026 14:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791234735; x=1791839535; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=baJPW+W5xUii2vInoj/ocaHf03bsK5E92UqeZJfGgWk=;
        b=vTwWAjM/FJN624RDGPnK8h7lu4SCgBgirsap4laSdpSBIXxrUouLSCd+Lm3VTY0GoF
         OIM32ZjEhWLTIKUfGugl2q3V75K+lsA3RcfuOaF1Ylz0QtxCgiHxg1r0xJ+85jSEKnrf
         g79g3vDizx7+fW67Y9xctevOyd9/9PsoemXmqwZwrhGpNxM/O6PO7EG/BRboiQOqPwsQ
         OJEoYz8/BdBF7g0S3ej3ugEwigWL8Qe5ao3UPOONx1c7hLQ1VVZ4krhej+kbM4c918JS
         Ntna1EfSwjU4CQ8CkiEqh+RxKGuP6D3tkvCBiXOtUlj66Uv6RHoZubT/o5eM8oSGzanL
         XyxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791234735; x=1791839535;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=baJPW+W5xUii2vInoj/ocaHf03bsK5E92UqeZJfGgWk=;
        b=1PrMU9wLazl6JJf5xPx3muL2v87YCbGF26PNmBgHfmXlseMRUUq6iDIAP2BFGHV1RJ
         59d20mna2wd3aa8Vbo/9LsuZUTh4JjydaBA73Sf22E6CBteInLflev+qrdKoSNx0oDVq
         4tPvc4aqd12nDv6IPrJn2ds4yXrQs8czwgEBWKM7czzEH+bLTMbu4n2gpD9TizAPCVs1
         Pj427mzNP+4GQ0SZzPJo83hGyWg118IzolWOVjeIZxTbfeVbg+TkaHEDBuC0V8rjKHU+
         C4/qb03Rmdm834lfXrpiqePQNB1eNaFnEF1BtVOfw1VVnDPNIdRhE3Hyz+K5684NZMpb
         zGsg==
X-Gm-Message-State: AFq9FYJa1n9CdszBYE0mtq8gNF5fj3X6JVzCGbca2tKvGCRgaCZujqB3
	ScJ5ZElc0Yur7yksHaYhIAl5eerx1IAMo5gEHvSEyo6D8SZ11pXFWpOX8ZprCSW36u03O7Poj7e
	3HxvYcJzD1A==
X-Received: from vsts15.prod.google.com ([2002:a05:6102:370f:b0:7b9:f047:3116])
 (user=rmistry job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6102:a183:10b0:7c1:f386:1b7a
 with SMTP id ada2fe7eead31-7c1f3861eabmr1979243137.27.1791234734334; Mon, 05
 Oct 2026 14:12:14 -0700 (PDT)
Date: Mon,  5 Oct 2026 21:12:13 +0000
In-Reply-To: <xmqqse2kma4o.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <pull.2224.git.1789169384240.gitgitgadget@gmail.com> <xmqqse2kma4o.fsf@gitster.g>
X-Mailer: git-send-email 2.56.0.rc0.1.g22a100d00d
Message-ID: <20261005211213.1896012-1-rmistry@google.com>
Subject: Re: [PATCH] blame: default to ignoring revisions in .git-blame-ignore-revs
From: Ravi Mistry <rmistry@google.com>
To: gitster@pobox.com
Cc: git@vger.kernel.org, phillip.wood@dunelm.org.uk, code@khaugsbakk.name, 
	sunshine@sunshineco.com, abhijeet040403@gmail.com, rmistry@google.com
Content-Type: text/plain; charset="UTF-8"

"Junio C Hamano" <gitster@pobox.com> writes:

> While wanting consistency is reasonable, the description above does
> not quite match that goal.  If an untracked '.git-blame-ignore-revs'
> file exists at the root of the working tree, or if a tracked one has
> local changes relative to HEAD, the local repository behaves
> differently from hosting sites that operate on the
> 'HEAD:.git-blame-ignore-revs' blob.  It may make more sense to say:
> "If the 'HEAD:.git-blame-ignore-revs' blob exists, it is added as
> the initial element in the list of ignore-revs files.  Other files
> listed in the configuration are also used, but an empty element
> makes all elements that appeared before in the list forgotten."
> This rule should apply whether the repository is bare or not.

Thank you very much for the detailed feedback, Junio! Reading the
committed blob from HEAD instead of the working tree totally makes
sense.

> Somebody has to audit the parser for these files (one unabbreviated
> object name per line, ignoring whitespace and lines starting with
> '#') and ensure that the implementation is truly secure.

I looked through the parser in oidset.c (which we can share for
both the HEAD blob and configured files) and peel_to_commit_oid in
builtin/blame.c. Mostly looks good, IMHO, but there may be two edge
cases we can tighten up:

1. Rejecting lines with embedded NUL bytes via memchr in oidset.c
   (where strchr and the check after parse_oid_hex_algop currently
   stop at the first NUL byte and ignore trailing bytes on the
   line).

2. Passing OBJECT_INFO_SKIP_FETCH_OBJECT and OBJECT_INFO_QUICK in
   peel_to_commit_oid and peeling tags step by step so missing OIDs
   or tag targets do not trigger lazy promisor fetches in partial
   clones.

Does this plan sound good to you for v2?

Thanks,
Ravi

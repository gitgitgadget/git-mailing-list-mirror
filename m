Received: from mail-oo2-f39.google.com (mail-oo2-f39.google.com [74.125.231.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB852C0F8C
	for <git@vger.kernel.org>; Fri, 25 Sep 2026 01:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790301115; cv=none; b=g77SgTpgVuLMwRxA8CQBYGkiiLMfmksratxtYGep1mi9VT1/hBKznC6op3FbB65/PyFDtOxD5Ft4x2MIJBTW8tIas9bour2I+7n+5XAT1aE45O/Ba9YKZMwZozdBO/PAhObQXV3/eiI90ljkABcjTs+9irFWGT8iNFBtCzrnhrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790301115; c=relaxed/simple;
	bh=xgLA98GUHxXO08yoZoKk550KaOwd1j3LfBjoylROP7E=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=rjgrwvnv4c9X2IQga4iA194G2I9PTV6jXoPKzqpg4FpasZ62ixZrLEEFx+wmqCl9hEiuxXh39LcAYZnQBRCjgVab9vuXrChUVXVlB2dpu4QqpqK7LmYCBjmSsxFQkr15wkxfwFSWSnD0OwW3hrnvQy2k2aFfRBWo6KlE9c6fMT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brighamcampbell.com; spf=pass smtp.mailfrom=brighamcampbell.com; dkim=pass (2048-bit key) header.d=brighamcampbell.com header.i=@brighamcampbell.com header.b=b0/zFZVV; arc=none smtp.client-ip=74.125.231.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brighamcampbell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=brighamcampbell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brighamcampbell.com header.i=@brighamcampbell.com header.b="b0/zFZVV"
Received: by mail-oo2-f39.google.com with SMTP id 006d021491bc7-6b1ae7089c1so204699eaf.2
        for <git@vger.kernel.org>; Thu, 24 Sep 2026 18:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brighamcampbell.com; s=google; t=1790301113; x=1790905913; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=NWFkLnRUpBphdotQWn9F6Ab6HIgoFBFwpo7dUcaI9xM=;
        b=b0/zFZVVxiVRteaLWFpJ86mzt23iYDIfvLzT4G8Zcr0q0vLz9L2D3K2i0KNibzNAc9
         rkGhw6PW5+0Qh6thFzWfvgVcvusUoQYAO1p4117nmQyFa021TZyIi1Nribgr6gvI48Ed
         +2aW58mtjiDqAzhksM+jspE6tvWei80uF1x/i7e/8q6vvA6gSZXpgutj459qrMVvu+NV
         sfsFle6uDmuaNcxe6w6NYaaXACHohkpgqgJhUxFWKHfy7oq8+Wdx3UrQ6sNb9MJXD7Ej
         ZCPwL1z0rnB9c1xQlvpBvtMJYDEqckOvvDhulp0VBpLdILeu0+t4y2+5BGkH5ApFSsRi
         dzdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790301113; x=1790905913;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NWFkLnRUpBphdotQWn9F6Ab6HIgoFBFwpo7dUcaI9xM=;
        b=VnBaAzER/6BDWJyCdUQ8CqXEiPDXyUhmz8PScAW7I1vsujXPYMukHvno0Pwai3Jap3
         JyoQlCwoyGxK2KGMrxE2enj4YYEspU5uudN2cQ4p1Uu5n7V65p6heHzltnGehGjsaUON
         XdCoSIN5x4g/oy+6tQljmqxyPezhzTrmz/08YLZkEZDe99Uxaclg62hOtx25J474kYTL
         7Onvaur/zLHdkeiTcK6KZegu28nxUGpQxazAsyznT+3pfshjeJsWmLxhKjVqjlKfrZ/d
         ikDgmdr+GtUOFmjzS3CTTKXBPiyHA9+l158tkIV5j2A0AU9OhLUETro1PEhuz4ANIKYJ
         TnTA==
X-Gm-Message-State: AFuF++km3Te4q1t9r5+0VQ1v6rZKWPej/epYUV9Qov5XwxWHXF62/QhA
	moEABEl79ZtDsB3e2J0J3zzw1B5Vh1B1cDWcxvPhOP+u9CFZj8FkPKp7YHnZ5IpHw/C+5O42Zi4
	Lc5W2
X-Gm-Gg: AYBFou37u5HFB0+dPybPOkzLL+7EEggAOKRWhL9cCjcadNWijhEJUA8PNKpdpKKdB0J
	FZXEwEyBRbR0DhUt0lieCTMjzaGAtW3ZLAFevYd5olobDNrNtM/e5Jtx+NxvuWsUvlbdrfTxi1B
	xto6XqKxOiL2uwEIFsmVM6lDPUdOJPKQBLOenzf9mAuBxMHDDTlv6+TwIA+oGfwA1ofxMp+0BLr
	MQ4Dt1XREmwwPuAzAdPRIN7IdvRVOE2gzNurkeQIKaOKOLFrjyLUYwGEVHFRBtUM5asbDaSn4bA
	0pXj9/Q8U74c5KCKKbPDifWryxib25ENft8eu9yh5aImiiLRG0z7j5pei6BxVpQMQY2fILSd7Ck
	cWHZeJDTUIsAmjgx16DwHNVJaPt3UgNYagfKf2qNQDd1NhJ2fDjjw958ERkXJ14KYskadgxZMvk
	oUezHO8RJuvWRAN5FAHwZYlxu+4N4+Jdtfgu7c0D3jUnATdl1qAOkO26IRsnJAgKSRn3saQUwCp
	ElPsYJf8YP7GCyIROr3LuwWar3pAhoQloRMo65P/QIF1zzwuQ==
X-Received: by 2002:a05:6820:1509:b0:6cd:3ffc:64cd with SMTP id 006d021491bc7-6d5baa4701emr790438eaf.72.1790301112813;
        Thu, 24 Sep 2026 18:51:52 -0700 (PDT)
Received: from brighamcampbell.com ([73.3.69.70])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6d581dc77b5sm1612027eaf.3.2026.09.24.18.51.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 18:51:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 24 Sep 2026 19:51:52 -0600
Message-Id: <DLO0S0UUB0EM.1NLQFJUPOMGY0@brighamcampbell.com>
Cc: <git@vger.kernel.org>, "Patrick Steinhardt" <ps@pks.im>
Subject: Re: [PATCH v3] git-contacts: allow inputting patch via stdin
From: "Brigham Campbell" <me@brighamcampbell.com>
To: "Junio C Hamano" <gitster@pobox.com>, "Brigham Campbell"
 <me@brighamcampbell.com>
X-Mailer: aerc 0.22.0-0-gc2f86b7abde3
References: <20260914-git-contacts-stdin-v1-1-9ac628e6fd20@brighamcampbell.com> <20260923-git-contacts-stdin-v3-1-56dd43c64d56@brighamcampbell.com> <xmqqtsnf477e.fsf@gitster.g>
In-Reply-To: <xmqqtsnf477e.fsf@gitster.g>

On Wed Sep 23, 2026 at 10:13 PM MDT, Junio C Hamano wrote:
> Brigham Campbell <me@brighamcampbell.com> writes:
>
>> $ git contacts - <patch
>> $ git contacts patch1 - patch3 <patch2
>
> The second one is an example that we could tell the command to read
> these three files in patch1 and then patch2 and then patch3.

Does the order in which arguments are processed matter? If it's a matter
of producing predictable output, I just checked out `master` and I see
that running git-contacts twice produces the same email addresses, but
in different orders for the same two input patches:

	$ git format-patch HEAD~2
	0001-Git-2.56-rc2.patch
	0002-Revert-Merge-branch-en-no-amend-during-conflicts.patch
	$ ./contrib/contacts/git-contacts *.patch
	=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
	Elijah Newren <newren@gmail.com>
	Junio C Hamano <gitster@pobox.com>
	$ ./contrib/contacts/git-contacts *.patch
	Elijah Newren <newren@gmail.com>
	=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
	Junio C Hamano <gitster@pobox.com>

What's more, git-contacts already disregards the order of argv. It will
always scan file contents first and then git rev-lists second, even if
the user passes the rev-list first like follows:

	git contacts HEAD~2.. foo.patch

I would argue that this is not by mistake. The user should have no
expectation as to the order in which arguments are processed. If the
commit message implies that the arguments are processed one after
another, regardless of whether it's a file, a rev-list, or stdin, then
the commit message should be changed.

Do I misunderstand?

--=20
Brigham Campbell
https://brighamcampbell.com


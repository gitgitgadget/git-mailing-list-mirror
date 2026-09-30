Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE55A3515DC
	for <git@vger.kernel.org>; Wed, 30 Sep 2026 18:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790793166; cv=none; b=f5cxHiC8QXq79z3zgR6xiGkT5qRrHSJhsavGnwlC1EQOSK9IahX/jorD1LBNc5PU1+d0+jX0BYQJIHhFq3qAXiFOQmm6CPqru1tjKRw2SXsRUl4Lj6XicOq9VTyaewl7Iirpcw2fj6SqPvBtHf7RhZpwGuEAjvbSoS86ZyjjjXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790793166; c=relaxed/simple;
	bh=/g0jk7SpaH/Zsx9RZgYVlDFg8JbpofOturnLHSmKobA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jIHyw4yyb2pdLOPpd5yjjUU9EbNBROFyefC6h5zn8gpIG0n8rO7MVN6LdsYeYLB+DROAV7kPkD4boK/wNXeabK6buJMOFpATFPhM6ozl3M73qZ8dxWv09peQ5Y3Zqyj4AiHikx6iAjLeX9gPIQfyTlzIiLwmktwjOyq+AP3Qd3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=oSFEf/fI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Uyj7urQC; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="oSFEf/fI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Uyj7urQC"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id F065CEC024A;
	Wed, 30 Sep 2026 14:32:42 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Wed, 30 Sep 2026 14:32:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1790793162; x=1790879562; bh=kFM8BR2Cqg
	cMMPdePxCQMOQAx0vFjNK6Eu+BfTsVKdw=; b=oSFEf/fISFmT9JeRpthq+vpMWJ
	1/GEYTHCLBR8K2V0pQM+qrvXs5WFlNucUYs4i4Gd9635XgfOdJ+W9PKB5KTPYTV+
	KtWMO92BRSB5yK2dzO8XbGnhp6F1kQGN0ltHezWMsPWUbemVFM/aNrgpIoG4TB7Y
	yhS4MxbxmFXbvL05nFk0zo9TqVxMklo/oQtjkUTpiX+loOr25UkYYa0ds/XdZCbK
	AOyr93U8PDR46zZlfHPHwmR9Igb2mzxfDQ+4uaSEF9TLXVQilGfU6w6D4xpnG1VJ
	oEfa2JbWrPukP3/1H8QIK/djihMfuBLdfqt8P+cdP12uBNp7ovqb8oHfEd+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790793162; x=1790879562; bh=kFM8BR2CqgcMMPdePxCQMOQAx0vFjNK6Eu+
	BfTsVKdw=; b=Uyj7urQC7Uzp5T914I4369NaM8ITikEAqfLhFFgVxccYX61bsE4
	N9GI8r6AMdX94E2ex83Y4DVHGU/0+FtivpbUQ77JDjGMdHevC/OCXeCniPPNgfbh
	0e2aDKR/clsmh4TxchZzTYXwn2+TxtruCjVVwcYo+fit6WeXCvn31QkgQL1xx2ra
	8Fe8EK7aCWO9VXplSN6lZxYdjj/6+LE1X9YZt1nd6xYabwGdwVB+HbK5DxxvG0Bv
	ON60bcemD9giGAYmFi4GxSlo8UfmmP6cstE2qMVB3nXKrqA8EPCffY1Z9Pa/ttPX
	VP3mmzerNzdstvhTYKhEvpE+AyVUYzTvhgw==
X-ME-Sender: <xms:ylW9aovcxymydK-ZHw7VsfxY8cozIkny7PmNreQhFOT4TjnVOuvLSQ>
    <xme:ylW9as7AM-YKR6axcMtXX6zjG8RyTVYDvPBZtawwSCI9Sir-259FLIROJl98MqJ2D
    xip0kdR_y3jda4PNYxUvGSuZakRhhrAi1wmZ0LmgYLK5QjFrp3cp4k>
X-ME-Received: <xmr:ylW9ahI0qBku_-x5BliV8mIVEtfuTUgJpdD-A0zXcxUwPNpGx3-UBgU_qdcXhsIX1kwOUUQJwKbgiRafZIxWnVC1N5_Q8IFxPCsr>
X-ME-Proxy-Cause: dmFkZTFuwRq6+7Xj2PGtZy0cgSgZJMeaP7gGivFNUULLb16LeHA2DsZ1cjBIDlXivTbcnq
    0spHCfW0HQxrBMF+ix6jL6zoc+mvCmes2BszIMmR+k0WDcDwbuwMjs5/0GQXFBUUk8JIkn
    aYbGxDG9XMLebajOTINMdQuaPNHGtvVMypx4Xd3ZILFTI1CUjWP0z1f7cP270OeegepV1L
    FMRnRlhmThpe5I9IGRDbbcKATrnADZRB/VX1iocp0MYPj8hqAGT56BXCQaSR71O8qoK6n4
    CLniZCrsI+cUFDH5vG2w4ghGK9E5jbqNxHzyN0rVLiBOUJj/xYuo7vT4lV+npewrfObGKR
    Eby5GbqaQpFEBtQLIZ4gWZlUrjYIueTWT7L9PZW8gHJGRHizsNggranTjY3s4SG58nYmRZ
    qDxZQWah4dq+azmja3qhu8tGC+9wDXIpj765+ieGRMs1iZQhLPSL069txk3n20Bz7PzxKM
    eoULnSDdt10Y8OB3P1xnn+1/vIX9XtXN0bzQQL/ZV8C6sRXSuQa9qdgfbELFp55ms6kfnn
    RZoomhTZ1mQnHx4d4VXgLsQzUkRiO9N0OIBlKbrZFME1VOzYsGkXGm/+FNaBH0YK6/6Wx4
    DhDy6KKE97QtaHV9c1H6+XHwdv9T43Qb2GaS9w0T3HNATFry/yk1NvcOUIVg
X-ME-Proxy: <xmx:ylW9ak7byJBU2hHK_y6WQdFKV8UIWcLcOw69Cif6kwq2AYGI7hgwuw>
    <xmx:ylW9aszv1lT2OCN9vXJ9oBdj-07WJJGsaQ0FRpt0sGC-O0mHHS_6Pw>
    <xmx:ylW9agbjlj2YUqE7skPG-wGT9mxRFhoFo_Tt3Bn1Er8J3VAI6f7pZg>
    <xmx:ylW9amQXkbS-VUMgPjAzmQp5uoeevR_7p2p43FsZW47D2XEQNwws7A>
    <xmx:ylW9ao44v_jYLV8WVf7X9qQ0TDLVOFqa68X0TNweNj2eA86M_h3JVC-r>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Sep 2026 14:32:42 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc: Git mailing list <git@vger.kernel.org>
Subject: Re: [RFC PATCH v2 3/4] setup: introduce new helper
 'is_git_directory_verbose'
In-Reply-To: <20260929102513.712181-4-kaartic.sivaraam@gmail.com> (Kaartic
	Sivaraam's message of "Tue, 29 Sep 2026 15:55:09 +0530")
References: <20260924120502.2642141-1-kaartic.sivaraam@gmail.com>
	<20260929102513.712181-1-kaartic.sivaraam@gmail.com>
	<20260929102513.712181-4-kaartic.sivaraam@gmail.com>
Date: Wed, 30 Sep 2026 11:32:41 -0700
Message-ID: <xmqqv77ma8ty.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kaartic Sivaraam <kaartic.sivaraam@gmail.com> writes:

> Introduce a new helper is_git_directory_verbose() as a
> counterpart to the existing is_git_directory().
>
> is_git_directory_verbose() also populates an optional
> string strbuf with reasoning around why the given suspect
> is not a valid git directory. This strbuf in turn can be
> used to improve the error reporting which is currently blunt:
>
>   fatal: not a git repository
>
> This is not helpful as the user does not get any hint about "why"
> the repository is not considered valid.

I suspect that it is much less the failure to report the reason that
may confuse users than the failure to report which directory was
inspected and why we picked that directory.  Once we make it clear
which directory was used as the repository to run the Git operation
the user specified, they can visit the directory themselves and see
that there is no HEAD, etc.  The user may have a leftover GIT_DIR in
the environment that is interfering with their operation without
their remembering they still had it, for example.  For this reason,
I am not so enthused to see this much code churn to tell the user
the subtle differences among a dangling symlink HEAD, a HEAD
pointing outside refs, and a missing HEAD.

What would be preferable is a much less invasive patch that reports
which path was assumed to be the repository and where it came from
(among GIT_DIR, auto-discovery stopped at GIT_CEILING_DIRECTORIES,
etc.).  It would help the user figure out why the directory they
thought was the Git directory is not what the git binary inspected.

This patch does report which path we thought HEAD should be at in its
messages, but does not explain where that assumption came from,
unlike the verification of the objects/ directory, which mentions the
environment variable if it is involved.  This feels uneven.

Thanks.

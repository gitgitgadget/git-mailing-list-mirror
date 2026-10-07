Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43BE73E5A20
	for <git@vger.kernel.org>; Wed,  7 Oct 2026 16:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791391836; cv=none; b=F7xiONFfDVu4sHEIw74+k28G7IAVRobv+5Gq33VrOtI3uf4gsnVauMovHREkI3M5tua5cP5CEp6S5u8zgcW9+8yEcpk6hYGaPAbAuZK1RkwaQ/+oilJvRC5sxBu0KrqkrxhS6NEFjY7nJGAVUNFqsX2HG5uuEYxBRQ6Z1kUXQsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791391836; c=relaxed/simple;
	bh=pVLJUbM4dOnUK30kwkHxLPjF8HrYa9E3QJOJV8M05lI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SDXzVWAgfjPyRfzMBnOg8RspipydQlB4iTKJAjNK0xxeuibIJonM5QkasnwQmnE+kVzitbEqaXLNjdzv9ir2G4pAa3MyWfeL59q7UXykjTmSlBiZnpbHVYsmbOuP+TCBnp5ZGGcmAARzc8FP6yvkuEgJqbyHr2LarccjFLulyPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=WeCIYsEB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fFVSu25w; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="WeCIYsEB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fFVSu25w"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 69D5CEC01B4
	for <git@vger.kernel.org>; Wed,  7 Oct 2026 12:50:34 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Wed, 07 Oct 2026 12:50:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1791391834; x=1791478234; bh=n13az4UJkA
	xxG25/KNZvL5Z1BCdTZXs8vTZNNumwA5U=; b=WeCIYsEBxiXMjP+VXloxDb1BlK
	H2xmo50797JWPvn1tmMQA9V6cEp2d17l+AgiMsgsoVa6Cft+IAg+Jy61ReHxRnsC
	k59L6690B2cjQIAezVvkFL4Sw9h8vPjYHZiDuL4X8BP16QM/ix7ZScVr5+lqgWrF
	mVrnne9+SFj651Jj9eBciT96ADNRc6QMUxBu/0dpxCMjTnW7rxkxL+iVKVbmFD7j
	s5W7HXd7MJ/v/zSLtw1xfTFgam0UjfHy8W+fYZFjKNu1cKbGQUVwmaLWN1vkBqyr
	sfAGtb3g08ISz+W3aWt7CKJTHsrN34Wg3D+oiJXRsMi2ZkPJmq+ax5c9/11g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791391834; x=1791478234; bh=n13az4UJkAxxG25/KNZvL5Z1BCdTZXs8vTZ
	NNumwA5U=; b=fFVSu25wDooX4vVMVbHZIX4rV5aDrMcHknwqxXLnthhhRgMLGWu
	TIWkg78ygk7sRphKBnpEwbd9ARbey/CG1trvfCAab1CuE7jn9wAL6QZ7cb8lBNTs
	y3FairvEl1Kte4Ti6X1UwNxqpNmc3t4qcUEyLUy0DNXYEB5ESHNEnp88QclQrysq
	QvqxoItTUS5Pv6qZBw2OUuy/2gPbOswPjEXQc4z/ATypg8m0YhQlcYjkOCEHwyfo
	HezBKRSlLePFNVuuVobXfdiwd+1R53HPQH7XtzfjG3V5VOG8NR0VbLtcxFC3jOO3
	4ggo89dzToD2tfkI1+Mi/xFiTGGujt1+5Kg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791391834; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:SRn9BiT0kS+bGjEuJKVIIcxDO5izKZmwlKYcRhsqzXIqZ5Z
	u92QG6TEUWSQ+pirOLkciJ7Ihi13/+nskdLBKhcMG4rIiQA7NS3tQyiVJ5tiixj1
	sqOYk0po+JBt2vuivbsq+N8M5aKI+82QlcqgSrJxF6Fq1DOR9lm5Fd8AOIYwf2Ke
	jFzCIm061vvUnooGyd8sz/ysKbluxbQIse8XJjWo8Ye/I/e81qrM1ds41vr0EXxK
	iGs2etUVRY9C1BymCOVc+CYcY5vSkhvLnlvpE7FhctdSxHOLOUEmiP/1qbs+oNTT
	dkG1QmoSDHqd8z3+A9gvjk2vmZ6fvwhclkSBW/g==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:Z5aOsQ2c8ZXCct2YZK6vumEbrHP8kZkWYrKsXE1eCUU=:pVLJUbM4dOnUK30kwkHxLPjF8HrYa9E3QJOJV8M05lI=;
X-ME-Sender: <xms:WnjGavZPLRkhOG61PA1buB4rmHBSEnbrptc8xyrZQn3qtG1ovfCtSg>
    <xme:WnjGalbQGNxYh4a6L7641Vl8vnDr_I7JQjTOgA68nEovPk5_aB_WPzep5t34UoS9g
    gnvmYd52bxuiDrALpFPmzBb5UnpqBwy9L15HzG-2r18qHpEnz1EpQ>
X-ME-Received: <xmr:WnjGam8G8BIXbCHgaSQaMnd4fQkliGji0U0S3xXKjVNxrQByyVg5fyiZfI3AX4zKFFFgmUiCi1TMkkMX5V2RcbBq2LvyaGm4fnXA>
X-ME-Proxy-Cause: dmFkZTEyE/a598fPngfMRe6oiJiv6csT/N2yAwQtqlidQtGK2jJBNyr1+A4xp4CuJCk/7r
    fZUr29WPH6BztCHGIvw7/qHjWR5NVBaYyqkeFo2cGStXSwijpjtRqAK6W1qaQ7W2WBJ7u+
    7e98V83uog1NJ2Y9rud7Pxs9xXgRwUS/75zHuk1XPu9qjUkGN9qeTMNHGoK2fqz+oyEMmt
    K3U57Li4pNPaWRc+mk/5jnEkl3M5jkxru7BM9/b4/RT2vC1QTpoobeTfO0zs5ryDa6S7XI
    +1Zref5fWcn1B4+ZgrLT/093PJ5TVep3g6/RmtBZulrsFg7VZe6MV9zWNA/vrFxpFir7o6
    jYSeuKcQoqqb6UB0TnV2DBvXGFpIdSwjNIqwSbV/+ZeYA0emymMAyROqDsk07l5iIU/QfQ
    vP8Yfg8LLQPasHyyjRKmQ8vHJVP0VxoQm2xW5WYLYBdipDXNhJz2QcehMxWMKMtZxIkR8z
    0pbmTzNLT24SD2TEZmlseONLE4L2HdV64aQv/uVsMm7cOWWzC/se3izQe96Ae1wEu/Yua6
    aE/DZlISuFPPgFI/9Py5+dwaZLJazkNchklzSsJVI2LUECupv7cAFxttEcKdxSpfwb066q
    nPf18INfPVLJ/dJZlFzzfvxLrMwbZa8GiN8tacGdeVTtkD2acsUkLNl7a7bg
X-ME-Proxy: <xmx:WnjGakiFbr-V0LCi0MIQTDXwGke6ASxNOXdRM3YQ6MlYXyBTj0EeDw>
    <xmx:WnjGamelbslFEJf0eT1DT43RGN4THWdtSB8y5aM7afshz0YACHw68Q>
    <xmx:WnjGarpEQUgrcTr98_HhBnzxb4NEhok5cfUQB7TBbJNWI5-dHJNYjw>
    <xmx:WnjGarBy7JYgsFoEK4luZ1T9oOLvz4G1-ah_ONE8IjaUKGYUQrIPLA>
    <xmx:WnjGavOFVDD18ND7EFHTGvSJRrAvE6m73JpxYvM_849XSfrcJCFYtZ0X>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 Oct 2026 12:50:33 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Colin Hinton <colinlewishinton@gmail.com>
Cc: git@vger.kernel.org,  m@lfurio.us
Subject: Re: [PATCH v6] fetch.c: defer fetch.followRemoteHEAD validation
In-Reply-To: <20261006032258.6561-1-colinlewishinton@gmail.com> (Colin
	Hinton's message of "Mon, 5 Oct 2026 20:22:58 -0700")
References: <20261004201428.5210-1-colinlewishinton@gmail.com>
	<20261006032258.6561-1-colinlewishinton@gmail.com>
Date: Wed, 07 Oct 2026 09:50:33 -0700
Message-ID: <xmqqece1a206.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Colin Hinton <colinlewishinton@gmail.com> writes:

> The value of the fetch.followRemoteHEAD configuration variable is
> validated while the configuration file is being parsed, which
> produces a warning even when this particular "git fetch" invocation
> will never consult it.
>
> Store the raw config string instead, and resolve/validate it lazily
> at the one place in do_fetch() that actually uses it, so a mistyped
> value only warns, and a missing value only dies, when this fetch
> would have consulted it.
>
> remote.c's handle_config() has the same problem for
> remote.<name>.followRemoteHEAD, but is left unaddressed here since
> it touches shared remote-parsing infrastructure used well beyond
> fetch. Leave a NEEDSWORK comment at remote.c:handle_config()
> that has a defect similar to what is fixed by this patch,
> so the remaining scope is easy to find for a follow-up patch.
>
> Signed-off-by: Colin Hinton <colinlewishinton@gmail.com>
> ---
>  builtin/fetch.c | 73 +++++++++++++++++++++++++------------------------
>  remote.c        |  7 +++++
>  2 files changed, 44 insertions(+), 36 deletions(-)

OK.  We agreed to punt on remote.*.followRemoteHEAD in this topic,
even though it may leave them inconsistent with what the improved
code does to fetch.followRemoteHEAD, this should be good enough.

One usability regression is that the users will no longer see the
config machinery to report which line of what configuration file has
the problematic setting, but nobody seemed to bring it up during
these iterations.  We have done similar conversions like this on
other configuration values in the past, and haven't heard people
complain about lack of source:line information, either.  So it
probably does not matter.

Let's mark the topic for 'next'.

Thanks.

Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D9B46A5E5
	for <git@vger.kernel.org>; Fri, 11 Sep 2026 22:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789164542; cv=none; b=CZjxnBXSAxESJJQMOTgYTDjU3q56mcA5eqxA4nPe6Z4rbnwZJxoITXQIj6An6PguhhsxbOaaxeZWRIjNPD7doQknYFHtIWsgVxjAFtNDKb3/GivFDRyiUdo3FD97auA57qq00OGaBNSuQ3tjnSlkLTNkjg0U+1MbXtYpu31y0JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789164542; c=relaxed/simple;
	bh=XQ88bdADAkCJRa5YjAaXV418RkN4bFBDmnmE900srCc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cV8/+oPda8gtUuGUdflRyjRA2wpS0AlX8mu7j4qsgi8yXfCtR7rw03DGOB1qv6XYUL2UtkxYvqWRsGQhg8qRrlZoS1hiPdAejIl9QDGok1oLMV8Ry3jom1OM492w8ZJDWE0qWDacOW0XjxYN/TENW4xi9taLQ2jqG7In94cTAW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=X4ANovZg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Z7w5U/Bp; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="X4ANovZg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Z7w5U/Bp"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 064251D00036;
	Fri, 11 Sep 2026 18:09:00 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Fri, 11 Sep 2026 18:09:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1789164539; x=1789250939; bh=xkAqVjdV3t
	tzxF8QZUwhrOaPv3GG+QIbhvGp8xZQAts=; b=X4ANovZgHAnqW5cOCROs+rSUfF
	hsxmKCd/X3OcJbyUP+tr22x0AYRnENBYH8iMOAL0ZQ+Gn4akeDSB+0PMdEtoOPjf
	LLAYQ5evZGnmC6TvXxg/vEZX23+vNibB2osaAvtf9r+Gl9WqZd5KKlBNXprietV2
	WW97TOeFp9ZNwtkqEjOiWyFH52KMpmLuQXLtYyWL3tYdChDKsNElsLmPddMTeGDD
	MYAYhnexHc4055BejM6sG9epwYIPqtZey+HDppKWT0lbMENxR4bjf/mOMyz5mW3G
	VSXnqBL15LoyjSKZBckgl8hq0DjC7kLURsjfYMv/X8/Yx95Qo6fkDTgKSkVg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1789164539; x=1789250939; bh=xkAqVjdV3ttzxF8QZUwhrOaPv3GG+QIbhvG
	p8xZQAts=; b=Z7w5U/BpkosCD87ZTTi6k7417x5S0fQImN0bPfLmdym2MeLtLNn
	6y6Hz4MzHXjv5uk7ZMnVEeWDs2lhXN1DlMC1lrgb0svFzkqKRhs9FC+yS9DWxBTG
	QdaR2wWOx1sPs+wlfKhIB8J8wF9ZmmcWJbN/fKYWvqHsvVcHRXyro6wrXk3s9Lr3
	jOHefbBBkGBZ7vSwJc5ei48W1EyoxfwHBjko1fB9bSk5G6n4rRSMvn1BKPbNeGev
	f1YdtPRGNrwXRLWzwV5ZqgKjzVUGTjlxpo+IyG9q3ofmQIsahJvfvntvCc7OhZwU
	DjJSOqq1K9rahfNLWtvl+B4nQrr4cxT4ZtA==
X-ME-Sender: <xms:-3ukaourExDPl3gBf7PDUkKfEMGO5z_FWDwbveOa7zmNx9hxZ0hucg>
    <xme:-3ukasXSz00lX1oYA1OAwPQ5vbWy7QqodzaxE3iHtfMZGc1ImTa0H4WXq6LcvnoyE
    tUzFmjy-U8AlkpvDoZTqZX-bSdGCaemyJXnLa_WjXRSi92UoFko>
X-ME-Received: <xmr:-3ukasFOiJ_TN_zPhM1lo3fTuoLbp36WPoPIxubvu4uUABhmfB6cAWING6EUOkeF9jUdpFXc5JBaVu7I4OLSd0KKf9TZ01VXCNGk>
X-ME-Proxy-Cause: dmFkZTFNekcUyFbBFG+urauTSrwassxu+V9lBVNFnE+W0ikyavj5qyQlFavHxL5Vx2skmy
    RixMrjRcY7Nw8AHRgmDbFY/Cu0EamovrTMzF7IFsn8iqWDE6BOIbDH71AqDsEuopmXSFvR
    TZK8mAhJOPkP9BHSQuUBA5/5TbLNGM/ycjOEyhURD5V6PJaEFkTcbmL+fWbGEiQowxO64W
    3xbXSSyGVxb+jfwrQ+hOemJ9pWviKe7UACNUAi7+XNtsxb9NptEZN/kQNBUCjKUmyciBCn
    HC46VWxdfwfEHogwyXzu+tlqp50hFhs2ycfNGoTGWC4uvjSVSnAp3Q9C13wLzMVLRGqYQE
    uCwGTd/h9x01/Ozeedte1J+V9CmWOK9Z5wnH5Bwz4pwdZpfYl9ifbQItqrsHJDB55pEhCm
    oN+9bIyp7HgcjcwGHgAVInzpov9ZZRT7zpBMCoSbVMIL67JNFZTUcTRV9UpeJhbx/irvAv
    5ZanJFOxNs3rqWvdlwNiYdSss6Df6WL7rCnY9Qt9x8EB0hoJ1+i86yDMgvSl0kl4kwlyFH
    hrs7JfKqUvC0cmuGL3m3o6W8HOWi3xD8ngrH33N7ryHE/eONvlpgDL5fmvYeFrngMFZ7LX
    4Z2+jGR9V1eEqWD8YIN36joor2CIycE3//dTqTR+s2OV64fny1qzXxi2uptQ
X-ME-Proxy: <xmx:-3ukam0YWOHvYiTGLTkZGJsL6EBZsyG_ZKe8amx_sdJAczZ27RbKpQ>
    <xmx:-3ukamMRBlhJXsVF6msTGrxO07K8qC35AKaqqn1cjgn4RQaLfIel1Q>
    <xmx:-3ukat6ydNOZp8ukzvHLKt0uDojGqVFFPQyOSXg4y2zNZXtr0dcgcw>
    <xmx:-3ukao3kRKBY8kZ7Dg8d0-vDerP4d-sLuIh5I8q4gNuY7Px1-n5I-Q>
    <xmx:-3ukauFk05v0qxOKIzoSy0iRVTONE-G3DwX7be_ifcuEZq1M2D2bHOHk>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Sep 2026 18:08:59 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Cc: git@vger.kernel.org,  jltobler@gmail.com,  lucasseikioshiro@gmail.com
Subject: Re: [GSoC Patch v6 2/7] repo: add path.superproject-root with
 absolute and relative suffixes
In-Reply-To: <20260911144519.1011780-3-jayatheerthkulkarni2005@gmail.com>
	(K. Jayatheerth's message of "Fri, 11 Sep 2026 20:15:14 +0530")
References: <20260716012138.6714-1-jayatheerthkulkarni2005@gmail.com>
	<20260911144519.1011780-1-jayatheerthkulkarni2005@gmail.com>
	<20260911144519.1011780-3-jayatheerthkulkarni2005@gmail.com>
Date: Fri, 11 Sep 2026 15:08:58 -0700
Message-ID: <xmqqmrtn8mpx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

K Jayatheerth <jayatheerthkulkarni2005@gmail.com> writes:

> Scripts working in multi-repository setups often need to identify the
> top-level working tree of a superproject from within a submodule.
> Currently, this is only exposed via `git rev-parse
> --show-superproject-working-tree`.
>
> Introduce `path.superproject-root.absolute` and
> `path.superproject-root.relative` keys to `git repo info`.
> This exposes the core submodule context via a scriptable config-like key
> using standard format rules.
>
> If requested when not inside a submodule, the command returns an empty
> string.
>
> Mentored-by: Justin Tobler <jltobler@gmail.com>
> Mentored-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
> Signed-off-by: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
> ---
>  Documentation/git-repo.adoc | 10 +++++++
>  builtin/repo.c              | 31 ++++++++++++++++++++
>  builtin/rev-parse.c         |  2 +-
>  submodule.c                 | 43 ++++++++++++++--------------
>  submodule.h                 |  2 +-
>  t/t1900-repo-info.sh        | 57 +++++++++++++++++++++++++++++++++++++
>  6 files changed, 122 insertions(+), 23 deletions(-)

Correcting get_superproject_working_tree(), which was introduced by
bf0231c661 (rev-parse: add --show-superproject-working-tree,
2017-03-08), is a major part of this step.  The old commit added a
single test for very basic use but this step makes not-so-basic use
cases to also work correctly, right?

It may be a good idea to split this step into two patches:

 - a patch that corrects get_superproject_working_tree(), that adds
   a new test or two to t1500-rev-parse.sh, next to where bf0231c661
   (rev-parse: add --show-superproject-working-tree, 2017-03-08)
   added its test.  The test would fail without the code fix to
   demonstrate what we improved.

 - another patch that uses improved get_superproject_working_tree()
   to add path.superproject-root.* keys, together with the updates
   to t1900-repo-info.sh to add tests for the new feature.

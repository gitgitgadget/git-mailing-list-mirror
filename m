Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC14B388E76
	for <git@vger.kernel.org>; Fri, 11 Sep 2026 17:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789148272; cv=none; b=UD0C1NeTEl4bd85m60eH4mjxajscI9/po3jb4QHDpGvpUTPDmwX4H/lINwRYiN+wb1ZZPqKgYXEpUjzD6O+GJG/Fddd2XmvPZQjHVwBDbFkz7GJdDiD1VB5D/0PjSR3sAK7+lC2NaZ6V7GL438Lqb9XNX4llr+UJLIIxUlhXnOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789148272; c=relaxed/simple;
	bh=KTHMlX0h2UVuwMDkVz2/P+PmVH760T4TA9/UeE+1Sto=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RAJ5ll+qLSV8OHQ6ewjgK3rgitZm7PZld8ZDCsD/0amnVfbBKAXh5EKo5cpXdk+8P7Us/Cz7G8eU54rIPQlcy4iXLlhOueEAOuNAcVvns/o9rfXglfBP5na1Zr7dQlCqn30Mpge2awp4ESAlpEX7y2y2mikSgcPc7yJxvgrpXH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=V/pUoNUk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ehitjJoe; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="V/pUoNUk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ehitjJoe"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id E0995EC00EF;
	Fri, 11 Sep 2026 13:37:49 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Fri, 11 Sep 2026 13:37:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1789148269; x=1789234669; bh=TGdbbpQ8YC
	QQ5OuzT+NEQa0U8XnOaYe3t62lCYFPkD0=; b=V/pUoNUkuZ/Bp6AY7G7j2WUCTi
	fdDOJUiOP1PPS/w41iEZtjV5OaqKM3BZ1t2Y0GmAS0eoRSgDluUlwbN0v/CAxoTU
	bXZ3dhItOY5h/maU3sQ4wzt2EuVupeW6lAW1Xx2eqonfOdExymRifl7ASFCy/Sal
	b4e3NoZ9lK/a/s63hF1GWOI0NwJLzNtlqY1uJ2H4yozEOEwYSeqZ4zfrqPd/A+Or
	Ved7UohN4TbHKooGIHbwrJSROTqODSmF+hyOwoelDnZ+KNGGgolLO2JLEQJwGK6j
	e7VeSOOGb3muhSRwRnUtXUcmX8AGU7klBDqUUsye5AuAdJ+KLMDlxTXX6L+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1789148269; x=1789234669; bh=TGdbbpQ8YCQQ5OuzT+NEQa0U8XnOaYe3t62
	lCYFPkD0=; b=ehitjJoe07OhwwSI2/O31fOTOGFK8OW86jddgFL7w1hPMqKEgRE
	5I01GWopA5yLRCQ2Y5Lr8jxTbLN958XvyPtRpEPmvd+WuF0jcI/RZ95eYMC58nz2
	yhNdNby9O6NbMWgUYvFkE32C7Yw6R2/WI0QVd9lu61MCyWpyw4efk+28Ps0PMFFu
	d85+haUuBqfoNoRCNoxhuSDh59VKfExUixfNbIVoKHIZyM88yCJ2sm2lZ70XJFSm
	MhEmdffMSjrcFtUHNpwWslpO+bl2In+wzWSIYZYNrPfI/AtucTAqdsrzZBpxDkuE
	UNcRleV4EuG/Rjz/R4S8Y9JE5iGS3CVVLQQ==
X-ME-Sender: <xms:bTykauUjFiinPpF3SYUjhIad-VhbaJTiUj-JojHvHkqFUFDoeSo-Sg>
    <xme:bTykamGZ20WmCarKHvkVxL_jjrFiDV8hlqi2PaeZUWz_aQK_4K_D2GgH6Obg6GDxw
    KCgqcRWx0w9i4y-AEYEoA8rO2EGYIRavndCsLhqsozKJkx_w8MDcNk>
X-ME-Received: <xmr:bTykao2eWhNLZLYKbpDdHEvQ_90U66FWWCPIWWFP1JOaarS8Ph15zYJqwl1vgr8_GSUZZRIzAFqbc6TIjBqMBclnFISHdo0hxYDc>
X-ME-Proxy-Cause: dmFkZTGu0CA+mm1SuLk2Hxy2rRcvfgt+l6SebYvVm6j67ps05s7f0MJl0M3w9stIZcGdz1
    SDZPVDur7RMdQ4o6H2L/5OC6ixg3m9yAGroVAihM+h9Ps7Eo1dECc9KdujE0BhPVkuS1LN
    352Pj05Tgy3IVELq4yI+0T8X710r4tp+OdOTSdt8AtJjcDgqKb++hGRY2aIExbCkewyVNB
    k9BfI33Nb6gxOyXLckXowy3JXgVwuTlcWRXIW2Q/KE5MmBnx3B03351mVhi/N5W7L7Yi7X
    Z+kWWvPCfRG4h7eTH9qiJwS/Tu3qyOlYrxFV1pK4R8LJBGCwQWltGMfiDKObNCQrwMu2FN
    Dl6te6BJxxbSYXJow8tverm7w5O+KrsLxUlQj4v6HNGb0JjOdVxtr8z9APr+OXTVrUxOLZ
    rLEGV+QalaUsiULI0PmJkVQdytirtAtFMPVt6j9F2x4o5Zn0RsTPVjCYTMuk5dodfNczfG
    LrOa9sl29TRKTAwzlDaEZp+nrHvDD0Rucg8MTjehuIC3g/o1cQk3eCKD+Kb/nOfJrfNFTI
    i6Ba3C/pH5MrbtwRBw5nPHI4FpAqhuga9keBpiejchp4xusDQotkj9DgNka0R5Af+6hj7o
    j4cC463WFNxvjXFp9n1JWYWsl7Pu5/ZE9WU1vIbndOZJH17O8lCIYbCgCj8A
X-ME-Proxy: <xmx:bTykagPtGU3kg3_pbzaqilBlxMj2HQAeeAcO1trrlZmHCiCDvkNrog>
    <xmx:bTykav71ujul6CUh53Z5j10qoMSe5RCUrtr8SDHx0jVkv_QP6Jw6wg>
    <xmx:bTykai05_sddd4Gpb4CKdCTgkeVgHV8Xl9iWkdzzpVi7diKEvEWhgw>
    <xmx:bTykaowHikFCjHMCNY-qtln6s8wBIwoCsmeP_VhXlOUvoMDDPO0ZAw>
    <xmx:bTykajlwTrIRGsfmCaS5wYkBVagc0kFbKLIO832o1m3liWnYxaXdGD23>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Sep 2026 13:37:49 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Cc: git@vger.kernel.org,  jltobler@gmail.com,  lucasseikioshiro@gmail.com
Subject: Re: [GSoC Patch v6 7/7] repo: add path.cdup
In-Reply-To: <20260911144519.1011780-8-jayatheerthkulkarni2005@gmail.com>
	(K. Jayatheerth's message of "Fri, 11 Sep 2026 20:15:19 +0530")
References: <20260716012138.6714-1-jayatheerthkulkarni2005@gmail.com>
	<20260911144519.1011780-1-jayatheerthkulkarni2005@gmail.com>
	<20260911144519.1011780-8-jayatheerthkulkarni2005@gmail.com>
Date: Fri, 11 Sep 2026 10:37:48 -0700
Message-ID: <xmqqcxujbser.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

K Jayatheerth <jayatheerthkulkarni2005@gmail.com> writes:

> Scripts sometimes need the relative path from the current working
> directory to the repository's working tree root (cdup). While this
> information can be retrieved through `git rev-parse --show-cdup`,
> `git repo info` does not currently expose it as a scriptable key.
>
> Introduce the `path.cdup` key to `git repo info`. The key returns the
> path from the current working directory to the root of the working tree,
> returning the empty string when invoked from the working tree root.
>
> Mentored-by: Justin Tobler <jltobler@gmail.com>
> Mentored-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
> Signed-off-by: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
> ---
>  Documentation/git-repo.adoc |  5 +++++
>  builtin/repo.c              | 15 +++++++++++++++
>  t/t1900-repo-info.sh        | 23 +++++++++++++++++++++++
>  3 files changed, 43 insertions(+)
>
> diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
> index fb5aceae8f..0a30c0d6ab 100644
> --- a/Documentation/git-repo.adoc
> +++ b/Documentation/git-repo.adoc
> @@ -104,6 +104,11 @@ values that they return:
>  `object.format`::
>  	The object format (hash algorithm) used in the repository.
>  
> +`path.cdup`::
> +	The path to the root of the working tree relative to the current
> +	working directory. Returns the empty string when the current
> +	working directory is the root of the working tree.

What happens when the current working directory is outside the
working tree?  For example:

    $ GIT_WORK_TREE=/tmp/x; export GIT_WORK_TREE
    $ GIT_DIR=$(pwd)/.git; export GIT_DIR

The current implementation yields an empty string:

    $ git repo info path.cdup
    path.cdup=

However, 'git rev-parse --show-cdup' produces:

    $ git rev-parse --show-cdup
    /var/tmp/x

Whether this discrepancy matters is unclear.  However, if the goal
is to consolidate all repository path-related items under the
'git repo info' umbrella, this difference sticks out.

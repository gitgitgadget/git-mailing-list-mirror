Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A1531A057
	for <git@vger.kernel.org>; Mon,  6 Jul 2026 19:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783366541; cv=none; b=bEshnMXtCyvkaVqhjMhryDhr06s6gSLQfrb/mhq4kdI0nPZz7wA33zRFP310BXL1hDlwrwymAxlJGxHJEtbC+epSodgzNgpU7y3CAyG0zCACOw1HbSxSa5vUmHXx+S23kfCMNQhlG4LPlugbS//sHD36aVivJMoLIGLJkJxcGpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783366541; c=relaxed/simple;
	bh=03WKY3XkcL+6FFvH83uDWJcGINsJGFniSJ3btZU0GlY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EnO9AV50NR+GaYN8OkqzoLjwX2ZTNSR3oBbnZfF9mHHw97GfBBHVuO3A0/14NHwHZ9i+PbouXSKliVr9fEg5FHdjr/ri3K8ntlL/jW677I7HdlbnCalZzc7taVRe1TbfOOYeuGY5O+kAtNkantF4ZOMzOmxSZoMEveTs8iCyrsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Qx/QAm4f; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ev2v1jgm; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Qx/QAm4f";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ev2v1jgm"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id CFA891400114;
	Mon,  6 Jul 2026 15:35:38 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Mon, 06 Jul 2026 15:35:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1783366538; x=1783452938; bh=u5RAWePdub
	ET4mRa3VuAD+KkYXk3Vky73OyEH39nL+Q=; b=Qx/QAm4fGI4pvsTw8bcqUVF9Vx
	VC+mgvG4Kq14A2pyNGzf/zHXACgspBLqt03SEf/k5EmqtZxWjOUe3Bmo9h80OpSU
	I+RchFwhWQRBCxQxK70vKUQamzi38BImcflH+bGo9JL4uVRixL3Dlp2Esm1c7gwB
	xEFdSfo908BEuDyfmy6SK4Hh/x/IwM7qRhFf1JEO7zi0sQSk2K/gavzkPHVTduHD
	jormP09GV5c8BhoSl2w43HKJoeCaQt6tEisWqC0H9pKEi2UzPeRskA+mYX3Dy3i8
	sYcjrbr+DOHHTCDS/oElWafPIN/qGFjn9REnmrJZWUO8mHxGCY1hFuyHPEiw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783366538; x=1783452938; bh=u5RAWePdubET4mRa3VuAD+KkYXk3Vky73Oy
	EH39nL+Q=; b=ev2v1jgmdJ9lURbd2BdBTClksvNMC/zTwdhmHwSV9X+OmGi/UF0
	DAf99tlExb0p8wQCKBmygs+KRINfBzjxdUkMHQxOhapJgeiupdvstshhts8AnFX3
	w5NOPbbRL1rSoabo2zW0uoZrSTj+gk46kXLhwyVdIvq0mOnTF4a1XD/A9U3NdcuO
	ssznWojoN/hh6UgAJMoDoXcPWG5oONjQlp0gIM2clF8XiJeTvzJrOVWsrIf36seF
	aXlwaKPX62wt1gzxt//IgMtmxBpi593Lf9gIN6YdAZEZetlz6m6j2gqdlpKndY+U
	unrYL0dr6PW/1IXkaEMYf66Wt3pxe3fiRbA==
X-ME-Sender: <xms:igNMatnnEEIY0bmoTl6NwJzwagdmswLddQv-9xj4zANzM475e7pxXQ>
    <xme:igNMagSlXe2_VyrolqwIxbjL9OBQB8_emMQiWoNKsyaNzpgMoniOY8DANQGxQomBM
    IWnRHC4O8xH48tn_YK_FnqRDQZRB__Meos3664z0iPDe4ehOyUE_Q>
X-ME-Received: <xmr:igNMahDjTv-w6CZp2rH8WCB7l00FsumWUN4AiJMseUPkCytsE5-Pzkzi7MqvXW6hkFojD4yejTItwfBsfC2kb1iJwP9vV3bnvA8Gp7A>
X-ME-Proxy-Cause: dmFkZTGDI+kiJB1KIu5pGOl09zS/hSwxlNA65aJTqRDIOfR4/pdFvf1PEQemTkxZp+V1Bf
    zcoFX7MATMcu5z5m77u9MKyOKLgDdDJz93raHA2aIheEYyQjd16jBcyAGA8l0r8pdR19FT
    hbI3rnPtLECxPfq/8+5DJu4PqVwqsW7R7B438wxkLjuZsib1HEKRImEcMWujnJkoEHr3Go
    +ni7douy70ZZqPlfEsYVXaxeNsPnoUSVzwZa9gpilS5a09tYy7nQ2jmfMmWwCowUNAtKc4
    ZBL/J90HsMbtwsEC8xurW+j7PoZvaJZ2SopOZgCLjhpIzdsGAHLeNbVfgV/NAqUSKhGJpP
    BKUNCBFoiDIw8BYJIUXHOGZZZKSW2q0D/q04MmowAQev33JeS8z2zG1LQ4yVgtmUMd4wbr
    IJrJ6kFfbvYRDw1SB3E4X6ycG/uogIv5frxvgUSuPePMyM/uwNEiAMWloL5Q3me+AklVyX
    aLOy09q1HHnt0V4JzysZN2O8g/qQ1kIxSWYtWqcUcyAlh8MQk2Mx8INEDJ0LXj1Y1N7Avz
    F5Ssg7jIjaBo+01OE972q1FpgmsgxbS/QhUxykf5kTUMCC+FY4TEfm0BmKsrM5PJqIuu0s
    VuxbA+w4u6LIfXJJcjG61cix0Qb6VS3nnab76EC5kbdwOMuL5g6mYQfaA9cg
X-ME-Proxy: <xmx:igNManSRIbDd6SkRmiPsKbgSadmbCGYEPR1OpsH2i48H9K3Eh1Hv8g>
    <xmx:igNMavqhSkCQ1yoyS2p3GF4CWqgTA5wjSQLKg0N5swDKC7BNd6PXpw>
    <xmx:igNMapwUV5aea3K-2hvZynSS8-wkbxhq9ks_5q5W7rRE_7jgo67aGQ>
    <xmx:igNMakL4OvUSUrx1RcPiz1jGzfwgN_ZxX614W-przt0o912P61GKOQ>
    <xmx:igNMakQ8pq_2Yx-_rpAXF8YlC7QoRGzwK-LISS2p8MDJ_pmap23SelUY>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Jul 2026 15:35:38 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Gatla Vishweshwar Reddy <gatlavishweshwarreddy26@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] setup.c: use die_errno() when chdir() system call fails
In-Reply-To: <20260706183851.90517-1-gatlavishweshwarreddy26@gmail.com> (Gatla
	Vishweshwar Reddy's message of "Tue, 7 Jul 2026 00:08:51 +0530")
References: <20260706183851.90517-1-gatlavishweshwarreddy26@gmail.com>
Date: Mon, 06 Jul 2026 12:35:37 -0700
Message-ID: <xmqqbjcjc3na.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Gatla Vishweshwar Reddy <gatlavishweshwarreddy26@gmail.com> writes:

> ---

The usual way to compose a log message (i.e., what the readers would
have seen above that three-dash line we see) of this project is to

 - Give an observation on how the current system works in the
   present tense (so no need to say "Currently X is Y", or
   "Previously X was Y" to describe the state before your change;
   just "X is Y" is enough), and discuss what you perceive as a
   problem in it.

 - Propose a solution (optional---often, problem description
   trivially leads to an obvious solution in reader's minds).

 - Give commands to somebody editing the codebase to "make it so",
   instead of saying "This commit does X".

in this order.  And then to conclude the message, add your sign-off
(see Documentation/SubmittingPatches:[[sign-off]]).

>  setup.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

The changes are trivially correct, in that you call die_errno()
immediately after seeing chdir() fail (which means there is no other
potential failures that can contaminate errno---what your die_errno()
will report cannot be anything but what we got from chdir()).

> diff --git a/setup.c b/setup.c
> index b4652651df..e2e98d1126 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -1954,13 +1954,13 @@ const char *setup_git_directory_gently(struct repository *repo, int *nongit_ok)
>  		break;
>  	case GIT_DIR_DISCOVERED:
>  		if (dir.len < cwd.len && chdir(dir.buf))
> -			die(_("cannot change to '%s'"), dir.buf);
> +			die_errno(_("cannot change to '%s'"), dir.buf);
>  		prefix = setup_discovered_git_dir(repo, gitdir.buf, &cwd, dir.len,
>  						  &repo_fmt, nongit_ok);
>  		break;
>  	case GIT_DIR_BARE:
>  		if (dir.len < cwd.len && chdir(dir.buf))
> -			die(_("cannot change to '%s'"), dir.buf);
> +			die_errno(_("cannot change to '%s'"), dir.buf);
>  		prefix = setup_bare_git_dir(repo, &cwd, dir.len, &repo_fmt, nongit_ok);
>  		break;
>  	case GIT_DIR_HIT_CEILING:

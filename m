Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F9F279DC3
	for <git@vger.kernel.org>; Sun,  5 Jul 2026 18:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783277888; cv=none; b=qWtttMljCsLeqiPRwFCXPhjYRSQ5V5vojtJRDdpvIKvGtFNJbl4O5M0XbCXCZsR4OllP2oMJ5wF0LTu+OerwCR5El1pxf+Ry4U/i5DaOLZGP4JjY4Dqxb7CSn6KtnRlvcvuq5RtTh5x6siv4GQcHRG4yofN8KkQO75BC0fY/CM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783277888; c=relaxed/simple;
	bh=BAhRu7HegecVEyvJMC0HrIYn7ytRYA3csBdl48mkHWM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=i0NHj956woUtkzKN4T7ZLW17MLiorDj+qA94MU7yeY2kST656e/r3fW5QpOV02dOM2Wg6h/LCcF+eImCDT1tNGQ3CvYZ/lpfJ9hgBfjSZyEy1Y+1Vn0LIKnjltK77YQzAkFIrb4i/kkLrrJt4xwMdx/pHRfD4w8zCvrTNrbO3ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=eJmCKYFs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HTYg7tSU; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="eJmCKYFs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HTYg7tSU"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 215EB140001B;
	Sun,  5 Jul 2026 14:58:05 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Sun, 05 Jul 2026 14:58:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1783277885;
	 x=1783364285; bh=TKuU1YlMBLtY6fu77MysjExY5DZV8YQ6GY1DTmZJeTM=; b=
	eJmCKYFs86CjMeCgHL1YaP5gvpMDedvJPRpCpIehIoAz0rRXNCejkQNpxXI2NQ00
	DEjsLBxkyWm0SV147eVqq6VJLvjXY/TIAYdg8W1sdCfr7zCTJ0YNkm+LFoSgITxJ
	iL8c6QmeP7qMBwKpSVPufLEha+0UmPz8lb7U+1cWvEiJ/hMRqkclToLjuY0aKuU4
	SsbE/ZJRnYyvZXi3TNIieQDetd/MYQZOIQ8buTu5Y+a7Du3wxBlfPljlTx8z7p4h
	cx6iMf5tRCd8FtfcIRyH1DOwGgfzin21+kd2ckLS6gTmoXXURdTqYCxzf/9Q/EuW
	xok/550khu0yWGhN2slOcg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783277885; x=
	1783364285; bh=TKuU1YlMBLtY6fu77MysjExY5DZV8YQ6GY1DTmZJeTM=; b=H
	TYg7tSUxKxxH1Hn4sDycGIcfy/BY9Mz8pUvS+cfw39Rbiu8eVPtUanOHuviZz9g8
	JuhwYvepjJwEcXaE8NI9qjJdkFaUWHUeIsqHE7ywzakom6HR8jJKdwSAMmS2iIHF
	FIEFYfg5bhyghqRW+QJ9CO3OgRZzN3YuLXTpKnaGrhWKjbdcZbzhiShqzQXQMQuI
	Jhe2PmdVl5PnxctKhLMDfvSsYpAQWfRLL2M+xhmzGeCZ/zNWAaci9EdcblEvxuNk
	yJnmfgsKofQrPFwwwTEbsOBi3FdEk0LLx2THohrnZoolZRFMpxln/m53eW9qF/rq
	zAq7/BNrSAt9y5vOkAp+g==
X-ME-Sender: <xms:PKlKarhMueVd4nrpRL47sMzheJRWVFpqZkLqHWw0UYM-h4LivAtqyg>
    <xme:PKlKaotoIiMnR-dk8Jc4vSl1fhq5uczl075oOK-icJ4PSGS8zyxfWtjA6ODlqYyqd
    HKfw5p9fYx4u05wa9FI7QaNg4N2Saqg2h2oP4OS28tjDxiu6WPPcQ>
X-ME-Received: <xmr:PKlKapQ5bBHXs5ZQsV5P1CZyBib91QVIYDWmCvdyXxAvF9zkG7azHV7MeesG_nF53YerKRfGkd2G29F-xVVgaa5jc4-hwK9gK8G6Hmc>
X-ME-Proxy-Cause: dmFkZTGc9NsRLuKy8OSiwWlf5oS0O7LS8YJzl4rnoqI8zLTQHlCbjuCupTsw7J3ATM+iX4
    wM1f6Qdl8wibg0h5XX7i3C/Tf893MnzR4h7kvtEyl2vH7Hkhd08VeB0DdyUe7AOcGLWydn
    Y+2no2xBu22XOUvMfQZew23nREP+n2EH3W+c44mbF7LF3mn58FuiBQRx0OKxHmvl39AxCa
    DB860soSX9ftzvmvlyIWilmS+we2isI/4thHp4QbMh9fqxcW97p6ESvv7xpFuWl7BOlUM7
    q18ONRWyDKvWH/Re8SC1a+dbqVmGBd7pQt67pkLlklKLSMYKm3hz1Szl/9lThWxKyyrHUG
    iMe4FdAyWLyl/VFQf7csN1jLQWyMCSAr6SjB4rFXmiKeDt8MaTFlXBtMc6ovtdRKZEktxL
    +3baYy9pQ5u4UNoaA+Q0z9crGVOD0O+h5lVhyQZBd95lOzfvkhlCN1SD4jRIySQOsPKtNl
    zP5txwslaO2pybqGLbaUPnGxkUcAAKwS+VSO+HDN9EH+oyzy7HSY2kUGfAYfcEKLNa+HAC
    Tdazy1JPGEvs8dZhpxNBBZewy5DNXzstC95cPlsev3Ydf8M7nYOt9yGRLbmMa7b+7Oua6C
    KySpECFE4BWmQj7mOCB3tvVTlDqeongRqvugbLYZmIOFTtqozNKsXGEumiVA
X-ME-Proxy: <xmx:PKlKas3bjGWrsCcdHjPjV_3qpV7Ns7ErXN9wlMaYXCm9Scv15E6bFQ>
    <xmx:PKlKausfSqXZ63QId56ESVQwD2yWFWQH7mr2gMez2gx9WHM39YR-KQ>
    <xmx:PKlKaii0Sb42thKLZOUtICGvs-AtgvNDxZwKgNQhHWGveI3NcJA1FQ>
    <xmx:PKlKav9iqpWIpME3a9mmalzwlcC6oCFbYvFBzO16ZTeQsNN9w9ONyg>
    <xmx:PalKarNU6Cisse4amW_wnLwZSaowx38vfkSwV6o9os1MYpG_VRnDbZhh>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 5 Jul 2026 14:58:03 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Trevor Gross <tg@trevorgross.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Stefan Haller
 <lists@haller-berlin.de>,  Derrick Stolee <stolee@gmail.com>,  Phillip
 Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH] rebase -i: introduce `pick -x` to add "cherry picked
 from commit ..."
In-Reply-To: <20260705140931.98262-2-tg@trevorgross.com> (Trevor Gross's
	message of "Sun, 5 Jul 2026 14:09:06 +0000")
References: <20260705140931.98262-2-tg@trevorgross.com>
Date: Sun, 05 Jul 2026 11:58:02 -0700
Message-ID: <xmqqldbpclhh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Trevor Gross <tg@trevorgross.com> writes:

First, I have to say that I personally am not a huge fan of these
"cherry picked from..." messages.

Especially because I was the one who initially introduced them and
enabled it as the default behaviour, and it turned out that people
really hated to see them (and rightfully so, given that the original
commit object were often not available to them) so much that they
threw raw eggs at me until I made it disabled by default.

Oh, the raw egg part is an exaggeration, but it was a traumatic
experience for me nevertheless ;-)

Anyway, let's see what we have here.

> Of note is that rebase will fastforward wherever possible, meaning the
> check for TODO_RECORD_ORIGIN doesn't get hit and the message will not
> get amended. This differs from the cherry-pick logic, which will add
> "cherry picked from ..." even if a rewrite isn't otherwise necessary.

Why should it behave differently?  Ease of implementation, or
are there inherent design reasons behind this difference (if so that
needs to be described here).


> +Similar to `git cherry-pick`, `-x` can be specified to append a "(cherry
> +picked from commit …​)" line to the commit body if the the commit base
> +changes. That is, the following todo list:

"the the".

> +
> +--------------
> +pick 123456 -x
> +edit 654321 -x
> +--------------

You do not mean "$verb -x 123456" (where verb in (pick, edit))?

The help text seems to contradict with the above.

> diff --git a/rebase-interactive.c b/rebase-interactive.c
> index 809f76a87b..6a86ab5a94 100644
> --- a/rebase-interactive.c
> +++ b/rebase-interactive.c
> @@ -47,9 +47,9 @@ void append_todo_help(int command_count,
>  		      struct strbuf *buf)
>  {
>  	const char *msg = _("\nCommands:\n"
> +"p, pick   [ -x ] <commit> = use commit\n"
> +"r, reword [ -x ] <commit> = use commit, but edit the commit message\n"
> +"e, edit   [ -x ] <commit> = use commit, but stop for amending\n"

So presumably the documentation part needs fixing?

> @@ -2758,6 +2759,14 @@ static int parse_insn_line(struct repository *r, struct replay_opts *opts,
>  		return error(_("missing arguments for %s"),
>  			     command_to_string(item->command));
>
> +	if (item->command == TODO_PICK || item->command == TODO_REWORD ||
> +	    item->command == TODO_EDIT) {
> +		if (skip_prefix(bol, "-x", &bol)) {
> +			bol += strspn(bol, " \t");
> +			item->flags |= TODO_RECORD_ORIGIN;

  "pick -xabcdef 123456 commit title"

is parsed just like "pick -x" but somewhere downstream it would fail
to pick up the commit object name and barf, with something like
"'abcdef' is not a commit object name"?  Or worse, do we mistake it
as picking commit abcdef whose title is "123456 commit title"?

In any case, since a valid <commit> will never begin with '-', we
should be able to design/implement a much better error checking here.

> @@ -5524,7 +5533,7 @@ static int single_pick(struct repository *r,
>  		       struct replay_opts *opts)
>  {
>  	int check_todo;
> -	struct todo_item item;
> +	struct todo_item item = { 0 };

This may be a good change, but I do not think the proposed commit log
message touched upon it.  It should.  Is it a bug that we somehow were
lucky that nobody made an access to uninitialized piece of memory here?

> @@ -6340,6 +6349,12 @@ static void todo_list_to_strbuf(struct repository *r,
>  					  short_commit_name(r, item->commit) :
>  					  oid_to_hex(&item->commit->object.oid);
>
> +			if (item->command == TODO_PICK || item->command == TODO_EDIT ||
> +			    item->command == TODO_REWORD) {
> +				if (item->flags & TODO_RECORD_ORIGIN)
> +					strbuf_addstr(buf, " -x");
> +			}

Why two nested conditional, instead of

		if ((item->command == ... ||
		     item->command == ... ||
		     item->command == ...) && (item->flags & RECORD_ORIGIN))
			add " -x";

?

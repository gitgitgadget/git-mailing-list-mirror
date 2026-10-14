Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638153F2116
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 18:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792001385; cv=none; b=K/92q9vMxNZ5X3DlAhALT5fcJnRcYtXzRqIAJlqCFyCJypdPmASbVyjZb7YK7PZVUdAeE9zZ2eOrvh+kT82XXG3uIVm2W+OaL6/Z6F6czLn+VxS3lw+G8QJa6d13ok5E1ZtdTikmbPvxgpHh80DHRcoqE56EAAKEKZxDpf1tIMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792001385; c=relaxed/simple;
	bh=/M8tQLVnTFcM8Ctl2qHPGn8rkFvSLt0OFsXX1Nj0IFE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iajHT4TVjtksRwb7d9NUBj5BaENY/fVXHnkhfUB1oCSCIAaF4m18LFHbWAsKmOTgsI8E3AIpOZMAPDcOo99GmgtecDUHAA7sla2gGKLZIS313X+VAxYSNlMQ1sCOK7zmQRg5HFhzWTmn4j0p3fkutMJMMC1yR3cc+ooDZ3Hphu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=cjt66ffB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=p6Gn4FTh; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="cjt66ffB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="p6Gn4FTh"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 792761400098
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 14:09:42 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Wed, 14 Oct 2026 14:09:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1792001382; x=1792087782; bh=faWmjUuBz4
	h5Q4dKSGnerp6+KeFlImiTQyXZzGuJ7SA=; b=cjt66ffBZg56l1elz/78IQaePs
	Xp/TQMXgOZzxPZSy1CvcjZkQpEkKX0cS/WecBrhKu0uLLQNqXwcO63ZqKA2xMGDe
	r5KopyFN7Os60KoN/uvH+3nMnqyHsAxWvItCE8eqvVHQkleWx1iU2dpBLY6DM+zv
	XbTJcR93jCSXID54EY7s4uLHuFJ5RWUOm9pvepAzEAsP8LFzrdPNk59uYqxUxXoi
	mDM6M+mH15qtR/ih08rvumLLwrMdQAWFRPMJpKVoF2xOhkPiESoWsDSdMxXO4nkE
	JvuWohqA9BxmUNcxT+jENuyMX6916fbYH8IxCFvhdYQQxocGJu9gfVb3OyQA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792001382; x=1792087782; bh=faWmjUuBz4h5Q4dKSGnerp6+KeFlImiTQyX
	ZzGuJ7SA=; b=p6Gn4FThW+iKjKMYiJOGeVsF0raDkYCmtTX6U49VaLcPZJko0PP
	tDd0nGfW/EYG+FAkIh0qglVqEq2qiAqknIUlqeZ/lv6sS2vKveJt6c0oZ9YMpiI2
	yiJUJI+08xwwY23s+t/mvixQLtHhrmR2ZPABlZiTvszXT26ExjHoyLUc+8JXuDMg
	kCXkY4FLP4V3/wvc5v60D92Z66LIitd0/rmFIona9U9FSxIddshG1v54VoywYF/5
	hDTA5lE6q/empsQGoM6xw3SpRH4cSqLALTJ+O4XIttFWZA0PHkgibzgFiTM9yCk7
	Ff9nm5FIZ/r78I2Yv0iIPa8jv5f6iG95/4w==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792001382; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:hOrQWfic7taOjtv5bjXR/wM6tUSsOABP1sllHdtaUiI8NX8
	b/5rfSpfi5AL7FNCiXshxnPnfY3Ct6nG/e8DqlweiBQTiS+OTe6nvCISNwbXtODP
	0Nne+QszxdKg4Y9jx9Pn/mNVShosZ2xFp412+i3mWrT21t2CyZx6BQAHOgQyg44S
	8k6vbYT8wwCm2yflzVpvBSo413pwbMRu+UvAViK43N/dZpEKa2XbDH494ZbdUXXz
	oQDJZ4Bfa6cW9HbikCh8CsvRrzmhG+OMqdDUoflI2ER1gn2Mj3wSGaKAbsRb1rJl
	aEN8VIJag3+jgeIerS7HoEiofgTyb+L8aE2veYg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:RpiTJbuIiegCaWxyCSELgMa61T9/c5+jR1qMUwoQ6cE=:/M8tQLVnTFcM8Ctl2qHPGn8rkFvSLt0OFsXX1Nj0IFE=;
X-ME-Sender: <xms:ZsXPau3XNq6Omq-V8w-CSXW38yohykjumNywkdcm9LI9mNf6hNTw9w>
    <xme:ZsXPaoGeA2uK2NOJ1m0ulVa7itTLnsQfCiWV98B_d4uVsZEFJOKszEiK8Tt7G1_jq
    BOnKF_1hSG0BIZWSGCK6gfkJaN4nraI5MR-ZbfW3fikWexpbUamWwY>
X-ME-Received: <xmr:ZsXPar5wyDsi5ksVDLoK-RbFBi-9rXuG97YaIc41R2yVPdRsfMvB8j_3-mO0wK4PJexzq7Apxe8XB863HK661_izSNteJuEoRMCM>
X-ME-Proxy-Cause: dmFkZTEv0L9cPR23otiO9+PEsydz2ZZbgBcIZRrD+5ZQKq96XQ0mG92ds9YLGGJvsTcVsx
    5cTAgsNTXUpvNKj8SKJtfn5jvi17xXo9aaYuZNjuV839QBg+r+QwpDrAuqzCxTA0ni4B+I
    iQCEmC5A02KKc0aLHH+c+IqmXY+S4MgVwdwTczlKiMf38VZ49wNj8fjH5ImWj+VUYVRg7V
    agEdA1hBeAQ/B8L4ihVUiTFJEcl8v7+paO1o36QUBC7COxmwKsrXxXEMsN0XReth0aDwAu
    tlx3VIPzqQKiBQ3SJPMXO8QIfKxGitLP1/bQAdqcMi1oovJIF+cR9UF1Vzy0V9owlV96JF
    /BPc0dtbi+Sis8njL5qSgJuXuMvpPRLpwvvXYgDgvhCWUCmvTr0l7KS0Wzoh33/JEiRf6s
    CWP8hEt/2qPBpsr58SlxvcIgwgkdD2AC5ZUBEIWd7wkH3Ni9ArYKmDK7yDG2PAxf3nwOaI
    0pKAtgAGW2If+bHbVxpTCoqgBo6z433hSBov+88iLZg/d3O+8O0BxnBW8bnKC8BXm3dqQe
    c1XbNpaVyovTGQFQgFewKY2b586T7mOCeR2ARFfzaSWeOHVEfbZHl/7tOfZb68kwNUNjYQ
    WS5WmJN1bGd4n5bj8fACNUBMqErSJvCJw5mzwRYMLCb0t6kmaLH3DshJWFTw
X-ME-Proxy: <xmx:ZsXPauvC6hUmGgGE9xkNhG7ZJfMDdgvj6CShEUG9scvJNSWiCQGEog>
    <xmx:ZsXPas5V-Wft6yFWKy6tONkcFH7YOb07L6TG3WtTDKMmCbuvo-V-9g>
    <xmx:ZsXPapXqvlRXCStlRmHiXnJ6X-NoXmMofezS_2hb3-Orzl6yDEeZGg>
    <xmx:ZsXPau_SUptIdqPHyXzkMa8-ZmDzK0ui1SxrUOULlobWCixbWwq2JQ>
    <xmx:ZsXPamZPBMI5WDtCzKMBwSQGU44OQ8QHJH68VOPYikIfFaG46ItHcsMK>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Oct 2026 14:09:41 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: git@vger.kernel.org,  =?utf-8?B?6YeN55Sw5LiA6IGW?=
 <kazumasa.shigeta@kanamei.com>
Subject: Re: [PATCH v2 4/7] stash push: avoid duplicate calls to
 preload_index()
In-Reply-To: <6ca7e1c567a9e31d6668e59df81cd793e2b3411e.1791992404.git.phillip.wood@dunelm.org.uk>
	(Phillip Wood's message of "Wed, 14 Oct 2026 16:40:16 +0100")
References: <cover.1791218125.git.phillip.wood@dunelm.org.uk>
	<cover.1791992404.git.phillip.wood@dunelm.org.uk>
	<6ca7e1c567a9e31d6668e59df81cd793e2b3411e.1791992404.git.phillip.wood@dunelm.org.uk>
Date: Wed, 14 Oct 2026 11:09:40 -0700
Message-ID: <xmqqy0c0rw63.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> do_stash_push() needs to load the index so it can check that any

Perhaps you meant do_push_stash()?

> pathspec argument refers to tracked files. To do that it calls
> repo_read_index_preload() which does not just load the index, it also
> calls preload_index() which lstat()s all the files to see which ones
> are up-to-date. do_create_stash() then calls repo_read_index_preload()
> for a second time which lstat()s all the changed paths again and then
> calls repo_refresh_and_write_index() which invokes preload_index() for a
> third time. So we're preloading the index three times when we only need
> to do it once. Avoid this by making the callers of do_create_stash()
> responsible for reading the index and use repo_read_index() rather
> than repo_read_index_preload(). This saves two lstat() calls per
> changed path.

The other caller of do_create_stash() is create_stash().  And it
does not need to call the preload version for the same reason.

> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
>  builtin/stash.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/stash.c b/builtin/stash.c
> index aec79ed473..b4fe7465e4 100644
> --- a/builtin/stash.c
> +++ b/builtin/stash.c
> @@ -1526,7 +1526,6 @@ static enum create_result do_create_stash(const struct pathspec *ps,
>  
>  	prepare_fallback_ident("git stash", "git@stash");
>  
> -	repo_read_index_preload(the_repository, NULL, 0);
>  	if (repo_refresh_and_write_index(the_repository, REFRESH_QUIET, 0, 0,
>  					 NULL, NULL, NULL) < 0) {
>  		ret = error(_("could not write index"));
> @@ -1662,6 +1661,7 @@ static int create_stash(int argc, const char **argv, const char *prefix UNUSED,
>  
>  	memset(&ps, 0, sizeof(ps));
>  
> +	repo_read_index(the_repository);
>  	ret = do_create_stash(&ps, &stash_msg_buf, 0, 0, NULL, 0, &info,
>  			      NULL, 0);
>  	if (ret == CREATE_SUCCESS)
> @@ -1707,7 +1707,7 @@ static int do_push_stash(const struct pathspec *ps, const char *stash_msg, int q
>  		goto done;
>  	}
>  
> -	repo_read_index_preload(the_repository, NULL, 0);
> +	repo_read_index(the_repository);
>  	if (!include_untracked && ps->nr) {
>  		char *ps_matched = xcalloc(ps->nr, 1);

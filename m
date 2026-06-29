Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56169175A84
	for <git@vger.kernel.org>; Mon, 29 Jun 2026 06:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782714808; cv=none; b=U+wlbLp54AZTLdVfjxCwcxlWPLE4YbihM1l05xwjMWNKkK1+fDnmKIGAjCTqsMzufORQy83vEGpmXpGZKciCR1lgDibOhMlcTUn4JATerFF4e/wmFu7cwA04r6m51yDJR3BiuEWnH6RCQv4bjda+z9TiEje4K6z0mCLy+7Ss34Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782714808; c=relaxed/simple;
	bh=5EP3TxjckoNO13flAvNWKXWEc36Fa7IXYph+S8rPghI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YmmMvXMwoT56ujsgknJ09BvotjLUDuBOyLO2aH+9rg2r0dXpDUeKKk3aJqLCsaaBOgwvhKKn8mxnZgFxYNMLtJbJnp/tZC9ZpoAXVRXgaMvU/A95e0BWyrubXhMWT+jxBT4udYFXpjttu0+XgLuuLIVSItmhCLVIzlQfA8Uk9Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=IutE6N+v; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LtdPkpnQ; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="IutE6N+v";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LtdPkpnQ"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 785F01D00086;
	Mon, 29 Jun 2026 02:33:24 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 29 Jun 2026 02:33:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1782714804; x=1782801204; bh=81CmHhy+k+
	I1qB9sqSTChzYd4QBNS5z2AdAqM+UaFMk=; b=IutE6N+vwqqgVZNq/nhGwKgjWo
	c6orf2VMm5EZBxV3lKJVeOJgej+QQken0bEUqD/+fIJZFjuIk6jJJnhqMoJNDEGq
	o35kGbwR0GdVi29gc7IiQXGtFl2tP1QmVdnREs00yTYRc1nYnueKacyLfI7eKbyW
	gjFTtP9XFnVVSXokV6JlXvHiTlwk2yLQFp3lVbbRyViSrELuqgoA74wSvPMd8BPK
	Zlj7bsjwLFV/cnFTQGQj3kB/NXF3PEc/qmn2gC3eI1RJb1zoYbQFZLb8jNCgM5sm
	Lb+R49flZBOSVkLpJZ5xDe2WEtfUIxe70z7oqoyenmK5Sblq0OjcC6ibl7Bg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782714804; x=1782801204; bh=81CmHhy+k+I1qB9sqSTChzYd4QBNS5z2AdA
	qM+UaFMk=; b=LtdPkpnQvexWrr4LMppkL1dzuImCLMyPgS9lU1eklhLAu+PuH+L
	b0sX/auSn2fP/8Mn82mjj6sIDJfUoBYD/9yGmxbxZGG0ze2o/eEzT09uCyKUIoDl
	C2mnoJHBvKJcPMY0jLmF5anTK1dn58SjSuUEKLURdMrhkHWkQGNRrlK5T5j+xT0S
	LR0u3p6ovR5DM1RN8C+j77zDHRZ70d7pi+aO1XhMgsc+Hg2DXcNZ8AXqLwcaTu1g
	/m8wlPUsTr7aXFuyTfgj/u9W7pQz9UDe5CNPqueFL+gAPjuBKC/VEcelxlG3Hmhz
	hRhbLYym3gJoPSeBZFnrPcfQoVV8TM+UcSw==
X-ME-Sender: <xms:tBFCavcYscM7n8m1xmLhHYS6OyNxR0UnNNoR6Ui_YzfosEwnaHOy6w>
    <xme:tBFCasqCW1a0QTuqUJ-bfK0BudhkOMf3dcvMepj3gh2RZVx9zUDkZuP8vSqFFiZ2d
    9mhiDSjrDBE5u0WOQYzu9Yy5wbwgElMnRfQPAUgHxNQLCrPvHE8Ag>
X-ME-Received: <xmr:tBFCal40Lu8rlnlkrJ9kNG4JpAPxOotokIF_reur2dtNN8Tisb0qqXW2pfbP0s5C_t45tMuoHppEhvPB71OjU6kVfY9GKmpzVyjoSL7p-LvS>
X-ME-Proxy-Cause: dmFkZTEhJH1QuJf5WlyEijYXZP38RoTIGaOKnbPkEsshq7IUJivHdH965AN6GnsC49ZxT7
    rGYmuzeuDh22j8Abyi5K/nsdfZ0IIV8vdL3up2fDYZpYTqz7TQrV8mfDsQ/T50nS/MCN4G
    ci+zeThy/lcJxCCp9IttRXpMl7tAq2mtatchZvQo4tL+84ueIpNcZWPkDLTGm66bvj0fyV
    yeBls/uWVPOjMob2r3sXhKbvUZiBgflH+9h30/IGGqASxtpIMTi6aZj0yWk5uznFjPIiu7
    bZJAQKMe9pMVncyQrQXZUR2rZ+y+fR/6t7p6+5H5vLCx+7gTsPqwSSGJkkxc7njTQPQoJL
    6rqujE4e1y2Xy8+PoQQr/qIe2FqKvfHXml+7kddUpa7Rbp7xdddVpRcEqe2sxKCd1KdcO8
    2F6rVOOAc+dMqBRV0I9ThtgQQjixxTdLF41qo9Uc37Szrd2TNYZIzwQD81BoaTS755v4kA
    8TKTth5ckl4+Ti8WoQHT0saEa6gJtsWJGsVxlLPPjkKW6gAUE98OH8PGf5bJd46Swb+2AB
    bgnwnXyYDnHhgHxVX8CBYqaizgDfDMCVLG+Z+QA1k07tNKFmFDnUxUlJFgL5GgOgzeKTAB
    9cJZhJfDg4cGeOmYl7RC7XPd7Pdg04st3mgzr+RtdJBXoJyiZmrfIvmgbSqQ
X-ME-Proxy: <xmx:tBFCaqpDKw0-dwAa-iYJ6H6jELWjgjY2Ycnly56TS4b4_GRxxCZLdg>
    <xmx:tBFCavgGULHR4DPx7k2nakbw5SU91r4HAJjxSOFOGqzHv14hrQlJxg>
    <xmx:tBFCasJIh-ywKcS4AWgTfok1L4hq7ZBUM3rc0haYECmLtH5DDd2rGg>
    <xmx:tBFCanBQo_2_xEy6JyevlHRF4HzK9rDPD4kXD6TZQgYL-G7E4SY9pw>
    <xmx:tBFCavNd_6HpLw8icfnWi8tchPE0amPNJk5seh3qxNSaCsUrxS4k2CIW>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Jun 2026 02:33:23 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7e914358 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 29 Jun 2026 06:33:21 +0000 (UTC)
Date: Mon, 29 Jun 2026 08:33:18 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] history: streamline message preparation and plug file
 stream leak
Message-ID: <akIRrmD4Tqp-Gi9d@pks.im>
References: <xmqqecht8df1.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqecht8df1.fsf@gitster.g>

On Fri, Jun 26, 2026 at 09:38:42AM -0700, Junio C Hamano wrote:
> diff --git a/builtin/history.c b/builtin/history.c
> index 8dcb9a6046..f17ec049c0 100644
> --- a/builtin/history.c
> +++ b/builtin/history.c
> @@ -41,11 +41,6 @@ static int fill_commit_message(struct repository *repo,
>  		  " empty message aborts the commit.\n");
>  	struct wt_status s;
>  
> -	strbuf_addstr(out, default_message);
> -	strbuf_addch(out, '\n');
> -	strbuf_commented_addf(out, comment_line_str, hint, action, comment_line_str);
> -	write_file_buf(path, out->buf, out->len);
> -
>  	wt_status_prepare(repo, &s);
>  	FREE_AND_NULL(s.branch);
>  	s.ahead_behind_flags = AHEAD_BEHIND_QUICK;
> @@ -57,14 +52,20 @@ static int fill_commit_message(struct repository *repo,
>  	s.whence = FROM_COMMIT;
>  	s.committable = 1;
>  
> -	s.fp = fopen(git_path_commit_editmsg(), "a");

Here we reuse the local `path` variable, which already carries the
result of `git_path_commit_editmsg()`.

> +	s.fp = fopen(path, "w");
>  	if (!s.fp)
> -		return error_errno(_("could not open '%s'"), git_path_commit_editmsg());
> +		return error_errno(_("could not open '%s'"), path);

Likewise.

> +	strbuf_addstr(out, default_message);
> +	strbuf_addch(out, '\n');
> +	strbuf_commented_addf(out, comment_line_str, hint, action, comment_line_str);
> +	fwrite(out->buf, 1, out->len, s.fp);
>  
>  	wt_status_collect_changes_trees(&s, old_tree, new_tree);
>  	wt_status_print(&s);
>  	wt_status_collect_free_buffers(&s);
>  	string_list_clear_func(&s.change, change_data_free);
> +	fclose(s.fp);

This is fixing the leaked file descriptor.

One thing I wonder though is that we don't perform any error checking on
the file in the new version. Previously, we would have died in case
`write_file_buf()` failed. But now we just `fwrite()` without error
checking. I don't think that "wt-status.c" does error checking either,
so we might end up with a partially-written file without us noticing.

Thanks!

Patrick

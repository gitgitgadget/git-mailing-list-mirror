Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF723EF65D
	for <git@vger.kernel.org>; Tue, 30 Jun 2026 12:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782822308; cv=none; b=dp2AZ4DVXCfTaNSTDvPiKdiMZW1G0MVXvUFp2R/UYsZEXDD8C4INmNGm+cmKhQdOrdXpBBTFbGpNmECxAfm606nWFWnh0xS8B1fYLylmDGrfz4BelXb9l89JHA/FphhF9MxbGETaIxq7mTXJMwOvNVg5dz0YJ7ifsx25gg6E7rA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782822308; c=relaxed/simple;
	bh=rRgfUiaEw0ujPN6HcGcIQqV4e7HCFsdTWZBtIZWuHgk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BARf0R3b52QPIjfzLFFp812W9zQDUHe0uzyw8u6Zd9WM0lN01r3yWfv4FvLwNsUr6xSZvltAwCRUAv/kCjvJ2ScHekwx+vTMvHC6asY1P4++gN4TfMilgyE5PGAbVG+b3SIawA5mZlDOo//Wqriwjx3ptFZgtLEz5BPtOlOUCLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=GwvibHnH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KG4tRuj2; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GwvibHnH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KG4tRuj2"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id 90D53EC017B;
	Tue, 30 Jun 2026 08:25:06 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Tue, 30 Jun 2026 08:25:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1782822306; x=1782908706; bh=OIkMH4+Eqy
	cTt7d8cYkpuDG97WYkLINBtEP1KGChueY=; b=GwvibHnHzhRYmchPoEI99qGn0k
	vAdZrJFbtdI99+5FR+oHTLQARLgLNjNhx5l/ynm/g2qgIDYq+BRoWwJJcjsUKYrc
	cmf6sgA22J90yO89fNEPkp7o9Ct6EQOaVyXhS61QVzkOvaDSZkkDXR7F75auNDaQ
	al6lru+aKJvSpqQ72LoAAr1pAIrR8CfhiLP8MJQvGQIXgfFwv8mG6kz1DO/C6Yq1
	UmIW4W1KirOrIr+5JVMf01LM9LD9nFraEMKUZr66OFGNHylpHnzWN074DDPQKuxF
	Tiwdqj5RE/f6mMI2u/Fy4tCII5WLF0kwtrczGL98dWo3Ksbx6lqkXcpj5BMA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782822306; x=1782908706; bh=OIkMH4+EqycTt7d8cYkpuDG97WYkLINBtEP
	1KGChueY=; b=KG4tRuj21ilPhVw8dKZcSUenaqof09kSEX4kEFAuZX7qrvxapIK
	VaX00DCrlhBRS7JoXrtj/z/rgq8mhM32M2jN5lWpWszH2viUDwo+u5NLWp1dNOVr
	dVcNE716Nsbr752HXznLJvKo+tliOfjU58RFMKIigSY2wjxqNNh7Lvi7dYbHlRx7
	PbB3DVLBP1Vi3n+rMo+eUVncKbYNj5EnhC2SKlY9rDKTdDEMhHZALgMwRqgkeQr5
	xwM1c4Ta0EcSk0vpvUSaouhroG1lmzlWqgh6Negf4oaWDIGFU20oyV7ahzULD775
	0VCrM7SLU4pOlpapO8TzuCYs5UJ2JE68uXQ==
X-ME-Sender: <xms:orVDalqUhLF0g6lXNUE7Is5ogJRHO1MtNcXHRDChs7ga80ko6lZAgw>
    <xme:orVDavH9hTNhd6JYdZJ1OQZp15pWeHArp338mgjEGdiY1VFgiGEah_tzPKHMQCO2N
    nkLZfR_6mSzwNdnJZGZM7R0Eo75ErebvnmEjtR3kl6_BIU6EEGX5io>
X-ME-Received: <xmr:orVDavmt3Z4CA8kwKmMml_dJ85muvujfCLbcCNkWdKxiCENdPs-bbWFu2t087jy76RzsBf0A31_DQYqfD0VmIuGUHpPfc9LdVN4fUNun80aJHQ>
X-ME-Proxy-Cause: dmFkZTEyP/dPPrGYNt4jkEMUrWn0pgiHJTaxRJFKWkjg5t7GCXKg8jXNe8qPgX9IotVGiZ
    hoaOqx3TZT7shOs0yNvHptTBAuO+WA9CBR434p9JQ1UbbkCoFlYpnsX/QLCvbDARjSwSnM
    w10lk8k0DjRu1vt/WrTiW5XCMKLApcLa+FcS/2C+8APUfRl2+kmIwcZklqt17a8tcHua3K
    M/G5IsBrfoLwRS1jzcSgma0asF/Ud/rCqNJNQ4b70rK99u0Qi7dTPvwhJjdHzmz1EBGiEj
    q6kmSPkhCvEXdr9tDsZ41xzvUrnh9qk7i5vzVLKF/dM8wK0EcaKcOImOt1mPadg8MvPQWb
    r5ekwMbVHvlRJqLUy1r6BlI+meLoB+0w3FcNC1RLSYCz4rM7EvpmnghaecN7gyFGA8zxIJ
    y+AlJb5Z/8dMsUcPGC8cvYa4CXdxV9lxRuRVZTnsXUqwptiv2TeLDt2X+spQPcGbe1nfO8
    cUru2EXO+PDZThgDrN5f01rVwNa9evKwnXlTuqaw/SuDXT8wzso1LDhR++raOyEFq9ikO/
    88/WNT5RoZ6QxPk7XLHmpsBTtw6MGB5rp5TptVcMQmPLFEyys+1mYcCnrz/NQ1MTVtkZ7B
    6nDAk5ZOX+5kGp4WEdqJHG+Jssw7I+Kw7fR0sTiSUTviGHQ/iXIUrADXtleg
X-ME-Proxy: <xmx:orVDaqlMBwcrS51MoBcIkKrhrsFMmnG2DUWY7pcFrOZCMIV9gaDjfQ>
    <xmx:orVDaov1KDE6tb3ONFEF-GYur0o6f25xCXcsqWRZB0xauIr4x5xfoA>
    <xmx:orVDalnvwKsHYpFCjq3QUe6HvvsmDs16sMo6FsUmb_TEvF-LzA3FpQ>
    <xmx:orVDarvoDrrTJtqRGuyjTyRokCDlxWTIQopGz39sECzwujz-qINb8A>
    <xmx:orVDanV06CDPLUEaw-0Bcu21WR1eVG2hmY9lUBdTU5B8Me61TAZ6MPzk>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 Jun 2026 08:25:05 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 688b56dc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 30 Jun 2026 12:25:01 +0000 (UTC)
Date: Tue, 30 Jun 2026 14:24:58 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2] history: streamline message preparation and plug file
 stream leak
Message-ID: <akO1mhi2u2PntLbt@pks.im>
References: <xmqqecht8df1.fsf@gitster.g>
 <xmqqmrwdxrat.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqmrwdxrat.fsf@gitster.g>

On Mon, Jun 29, 2026 at 09:08:42AM -0700, Junio C Hamano wrote:
[snip]
>  * Changes from v1 are two additional error checks to notice failure
>    from fwrite() and fclose() to die.  Interdiff appears at the end.

Technically speaking the first error check for fwrite() should be
unnecessary as the errors accumulate. But it doesn't hurt, either.

> Interdiff against v1:
>   diff --git a/builtin/history.c b/builtin/history.c
>   index f17ec049c0..365e81379b 100644
>   --- a/builtin/history.c
>   +++ b/builtin/history.c
>   @@ -59,13 +59,15 @@ static int fill_commit_message(struct repository *repo,
>    	strbuf_addstr(out, default_message);
>    	strbuf_addch(out, '\n');
>    	strbuf_commented_addf(out, comment_line_str, hint, action, comment_line_str);
>   -	fwrite(out->buf, 1, out->len, s.fp);
>   +	if (fwrite(out->buf, 1, out->len, s.fp) != out->len)
>   +		die_errno(_("could not write to '%s'"), path);
>    
>    	wt_status_collect_changes_trees(&s, old_tree, new_tree);
>    	wt_status_print(&s);
>    	wt_status_collect_free_buffers(&s);
>    	string_list_clear_func(&s.change, change_data_free);
>   -	fclose(s.fp);
>   +	if (fclose(s.fp))
>   +		die_errno(_("could not write to '%s'"), path);
>    
>    	strbuf_reset(out);
>    	if (launch_editor(path, out, NULL)) {

Yup, this looks good to me. Thanks!

Patrick

Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8CDF1A238F
	for <git@vger.kernel.org>; Mon, 29 Jun 2026 16:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782749061; cv=none; b=T5JyqAIacmECvMkJ4DIQL3ZxEQm6aOEEn7Ggt7O6Xdgo1KC4KFju6OydGhBARf1SqPsyihIOIf17Cis/vpGnrkz3ZEKijx2hFeZJJ/fCDwkpDdyO5Iihl75fpgXKp1sqMEr/KUW4Rkm/PkQFrGho6TxlDXYh6/j/HEKzryJZfto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782749061; c=relaxed/simple;
	bh=LPn9FnehIUWrwUXcNY0Bchn8vK+MG1tNp6o5DxgjDIg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qVHRz6Tl7QC0FFwuxeKqyTItucvidtU3+YqTHIZWcfPVOxQzg/TuZwCUfDyRWDfDodRcNanB4uVRhiYUV7w9bWdk0S7YPjSlc+v9Mp/Wbv82Ur7PoHK3FnMOqFay1Np9gISursc7BhPOXM5XJBJlNoU+LL2fmxThnMsjq6zqSp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=uAo+v/kv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fc5jL4d5; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="uAo+v/kv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fc5jL4d5"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 36207EC00FD;
	Mon, 29 Jun 2026 12:04:19 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 29 Jun 2026 12:04:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1782749059; x=1782835459; bh=oxhrHmCUGr
	jtkcrkUPwG8p/btoim5wGvgPHiBsez1S8=; b=uAo+v/kvxd0lpmswX2m2q5ctIs
	RhcJ5ztGLoIUzrCxP+F1wybYUaLWTOxIdot+TawUv2hvGbCMhE9P+W0EAE5cOuHp
	St9ON/b4MiR67WgPuMUzkq5L4UKN2d8UNBTHUYasD9qLdZrUtMfBZ3nAst4ndw28
	wIPZz9sTh4GFDN3+27WF1E/CURnKWDCcGvz6i0X+dhqyvbGPHxyMzmvqQmqnvqgs
	W8Zjx3VfJdrMZO1ukpKuzJ+WfBlKpZsUpHiMwXazkQpnNq5fASCKm+7SvUUd02qn
	Oj6g4BcWwPIpEwTN6/S/jS9axsRTvk8ipbmfbNfhy2bsEKlUKCdWmy3CRe+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782749059; x=1782835459; bh=oxhrHmCUGrjtkcrkUPwG8p/btoim5wGvgPH
	iBsez1S8=; b=fc5jL4d5/26c7YFviqOYJ+oOKKnpeazMLtQsKsNccSuI/zYdop+
	sNka33kLTreM//m0/DvxcxRGogEReWP+2dj4NKI3fUXtDR9xARVVYD1setMxKquo
	UlAPskpi4/AZStGChqM0UzdYBCrHhIqxEGdLCPg1xCcoLxuot0E0HpxmW0sOZaUA
	Wkvfxsn0pG3TIBuTgXQmjl4tUO4Gci6TN6L6XDLUBWhGPoKkAgabRJpkwrWtqSPV
	jmR4xPGBDnCNiGZ36gpGVkrSmCTDDsae2n2rKNmPCZ3MfMQcWLTTY2KlKEZZajqH
	JlXpOGTZrEjtcTkBuwxCQYlT/V96NY9KNNw==
X-ME-Sender: <xms:g5dCaunnY3JTO9U11jzM2cZtSY46ICJyLnq87KOHUbroHCLbJHj6sw>
    <xme:g5dCatQLgwGQFns5GmxvrCFyrlrjP61fCrKfdPsNv27Nj0WInyIilUg9gt0tb4Spm
    r7YfPK5gmmjr2dha2BwsDxjp51mMi6YFyzixBWGWWU7xK_z5j_oxA>
X-ME-Received: <xmr:g5dCaqCJWlVrsZiSFvMIX46AwbJCuufpKUW8fD4Cnn_b_NZveE8Y2yRVXWL8PTNaDFpJG8CHBQfBTcdax8JOtog7wDy70VSTS_HLSwBNlNb2>
X-ME-Proxy-Cause: dmFkZTFnUHauW+S82robVvCTPeo3TjwPtMQuV1rY2trZ+1ilDjlZmvXDEtOiDMuwVO/ctw
    1q749jG9EzfgHoqu38lSFOZu/xGQHt2ug+8gn6NiAJP59vS1kXnEB259y+k9MLu/9OCig3
    HzviKjIZ9+JCumfSk77sY+AEYH9rUXEVIXcWoEo3o9qWMHByZWIWDDc/loSnyiKYmcw7lT
    UxLmy0xM+DfRrmyOZqWEGOM8sXSbh+XCF0YMV5Y+VkgEmJsuXQIkBOA/QEXGA7HKrTixS3
    7e/tJwmYgnblWCIe3WNcEcs6TewnuiZwcIohb2dfSSEC1Tga8p9FIa8duMt1+v/vPA4fC+
    uWBBSfoDCkD/ioPlm/jFUMIRmwUua2k7HRTBaORkifJGqko2BIm1/1pX/6cqQBbrgGIzLU
    M+q3kdnjUBsX7nUIBGTMqdT0AkT/LNd8ZDc0LIVIl7/tIgRBE0iNbRQiB9BxLP0M5xjD9a
    42tg0h7vAnhBxe48YQzcbFWa9eQOfjcdvpCaXfwFwMdbm2vh8ooVULYjR3xjpAdvDpaAQI
    GazdqtVC+AFULdC6mwtAtlEA135/DgoRGK3TSCeg5v95AvnIm74uk8zVCpukZk9YIIYE1m
    EiEhhdj3aDlI3Wr2NEJeXNCnaSIzkvx7Vs7H4P8ksRRoBbMqsgDBPUHGjQMQ
X-ME-Proxy: <xmx:g5dCasTcfDej-0-0OHye0F0zX40WqgbifdXX1Z0O5kRIhuOb2jhkOg>
    <xmx:g5dCagqTk7VX7RXBf4Nv2weztsh2Q9jhxZMEryb9yR5ePhrGACR8nQ>
    <xmx:g5dCamwYuinQWL37BmTqE_H9rfGnO6kMJYXHdKdZQGzMFNnb5VmmRA>
    <xmx:g5dCatJ3kI87VEDDEJAxHBduNVywMjhesZkQMZ4w8vtZVm3HTOgAdA>
    <xmx:g5dCan3KyzSUdiqhLHOvuewV46WKwMKaM--kgjtip393sHDvezo56e4H>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Jun 2026 12:04:18 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7e931bcc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 29 Jun 2026 16:04:16 +0000 (UTC)
Date: Mon, 29 Jun 2026 18:04:13 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] history: streamline message preparation and plug file
 stream leak
Message-ID: <akKXfQFw3RwkshG9@pks.im>
References: <xmqqecht8df1.fsf@gitster.g>
 <akIRrmD4Tqp-Gi9d@pks.im>
 <xmqq33y5z82l.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq33y5z82l.fsf@gitster.g>

On Mon, Jun 29, 2026 at 08:21:06AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> >> +	strbuf_addstr(out, default_message);
> >> +	strbuf_addch(out, '\n');
> >> +	strbuf_commented_addf(out, comment_line_str, hint, action, comment_line_str);
> >> +	fwrite(out->buf, 1, out->len, s.fp);
> >>  
> >>  	wt_status_collect_changes_trees(&s, old_tree, new_tree);
> >>  	wt_status_print(&s);
> >>  	wt_status_collect_free_buffers(&s);
> >>  	string_list_clear_func(&s.change, change_data_free);
> >> +	fclose(s.fp);
> >
> > This is fixing the leaked file descriptor.
> >
> > One thing I wonder though is that we don't perform any error checking on
> > the file in the new version. Previously, we would have died in case
> > `write_file_buf()` failed. But now we just `fwrite()` without error
> > checking. I don't think that "wt-status.c" does error checking either,
> > so we might end up with a partially-written file without us noticing.
> 
> Yes, the fwrite() should be protected with an error checking and
> die() the same way as the code before.  Will send a v2.
> 
> But isn't the end result the same between preimage and postimage?
> If the stuff appended by wt_status_* are still written without error
> checking, we would leave a partially-written file that has the
> default_messages and the commented hint/action but not necessarily
> whatever we wanted to add with wt_status().

At least it would only be the status information that's missing in that
case, the commit message itself would be retained (or we'd die if it
wasn't written). So we didn't have the potential to loose information
that is intended to end up in the final commit.

Patrick

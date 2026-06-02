Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60CFC3DC862
	for <git@vger.kernel.org>; Tue,  2 Jun 2026 12:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780402029; cv=none; b=ex8im5yEhUqQqeqgSD1JCfXI/xgqyqKmKM59JqqCQQ1Nq+kOKbGpxuuf8rZfpNpafOx9TuxhIOCxHto04f8mhWhgD717skySIjdnoY6FgztdMtjwnMuBJF3pSEmZYblU5bgvmWW5GSxbAvJKTUUCnS/cbp/zLW/CgRx6y6zQPJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780402029; c=relaxed/simple;
	bh=ApsRsuqX+9/TwlpQyZ/e6933pIgzwVJ0LqecphVaxuE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jc4cmfjZOANvRcyetW6oBv0GegRpVqb1x363jdZyW6UeV1UjKYJVtLdXjZ1AQLaDx5A82AtrsbqBiNrSbPMboS56nSe5+U3jRuXozQv4y/HYz4c1V+fyMNMRB0dCfVFPUB9ii75pJxmLW80mIpAp1ZmM9IuIryWav/zAki9Hzhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=bkv6XVgE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bbfMlDRw; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="bkv6XVgE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bbfMlDRw"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id AA9901D00085;
	Tue,  2 Jun 2026 08:07:07 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 02 Jun 2026 08:07:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1780402027; x=1780488427; bh=+CEhHPdZAW
	LMP/AC7uwRGn5f/GxcZ1RQOdpsEhAPJl4=; b=bkv6XVgEPoF+JQa23IGpN5nlSQ
	+EmrOm1hbLUYh7EXASYLDWjh7KidMCrKU6tM76whdW2xSwuwYFUZMtSSqapsK67J
	k9YHOsx/WnX3G/gnen8anxS+Xw017SZvLNf1RChfFhEQY1ebbyvmNg7yoeTVSfGI
	ODuatFRwwOT6caDpnmgbTYYTm01hAiTynjFrUnEMgDo4GwvCv39qjwHKBrT1tKMv
	Uw3eDyoe35weVR+jRP70Wwi+IaZuIm9tv+1MeEXJL6yzriXj3ToqbIXIRIgzwRq+
	myHMECFHlJoGxlCEOO+2oYJb37ruMoVe/83AsM9Ore31VcaczsDpUtMJmfqA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1780402027; x=1780488427; bh=+CEhHPdZAWLMP/AC7uwRGn5f/GxcZ1RQOdp
	sEhAPJl4=; b=bbfMlDRwUEXU/zpU157LYjMkSSAqHSJgBUpWOAaqMotE0LhHwXw
	ratpePxSd3kY161h4Qs0VtYti5esSx/aHGRhdEA5vKMSq+xfwlKB5PN/00lZBl3/
	tfsuba5DfKZmWiQmtczkurBHaMklZgR2Mk230cehVtnAeBWrwL8Fchj+d8hrRk/k
	b0z9MaPuX/pZUZ1oD5D6cJTzbGEaiXaiRXihMPvggALOTiznNWUcggQceCXvAYva
	EeBL1gZH6pTGPCJUoYj8yJ8EBk/StlVwvZKoZanOs5PBffrG1B7/gNEUFrD/Jhwz
	FtHJ0UgZhoTobHQeyX9dXavcOkPehgAFtMw==
X-ME-Sender: <xms:a8ceaqNoKVVpr_7r7OV5JNWYNjnajKsifCLXGPBb34ToJda_vd_WYA>
    <xme:a8ceau-eex9GmblyBOtJBSr7ayDuP9xOJ2II-eMOIQGYKlTz2bw42r9674vrF1jVW
    37xTeYxJPrPwrePwHx39tC0TQjX70-0ys9NkmoWLeLVMI1Q0xwrog>
X-ME-Received: <xmr:a8ceau5bCnNsBAMfMf6S2WqkA2ib21d4RNnqLA-VD0QSQAivPfJOyuXpNLh4R_zYJ_j9PWUetLzE4JPqaJaPK8KbZppiFNAicHip74XrgQ>
X-ME-Proxy-Cause: dmFkZTFGnFC0w6xhfTicZS+mv1scS9qzzCF9/aRPBzLvnjDOOtzZpUrgkqlQhxeQWk8fc7
    OXIQiQyD9si6ryTUmiQQ7mMSwArXM0k6u2VV99K4//Nqd6CKxmd689wfzE3eeOvTX+fD09
    +9IayN/UzCfCwIRYtSMtUrun5gPpr39l76A9+DcScFPi04wiwfUw0AiTVM5lZyNJUVcO0v
    qvkuk4gOzB7qNlJ6nrM+510KOLfwRFkjalB/FOWWmMCZVXDEs/AYxCLUiuDCyomftevUPr
    b/A00KHFjLibpK00WVuSMvcKKMIUQlkR0TTgmiydtd7dkVS9xENu/8HvafihZwnEtwiKGA
    5IsPmx41Ae7k2qAwxz3yf9WWYIERJMXkCB9PzKqwM4db2qwGDxTt4FQMJBGVFUR2MRXuqs
    yNy5QB5JQzP7pO7m/LuZJxoPs6MDIdsA+M6fLaT7s4K361Xn+PoZMiM8C8N3PtQYIDISfr
    8bQP1/a26mbmFbmw4D8DbhefYfQlpXFHtKC/EBL2g4yA6da3BWvusaaPxFmJyEfDb9dIfU
    gbKbPx9/d9bmFN+Nt8igG2a/4JPpU+hZbIC7X7nelBVoWfezVpz/CrcDoPlFL6ygBithdR
    2maNX6R5Fh27oNOfolMO8RhM/KhCviZj7izwIU7iKdVB3RlAA+/63xt1dMhQ
X-ME-Proxy: <xmx:a8ceal1BQ5Vq3cG6JBsAce6Amhyr1OkF1aUb8_OAnXvIw74t_kcsEw>
    <xmx:a8cealDg3ssWct9IZGcr1MC2o6dGhPomS35WPfIHUNvLLhEDdr3WvQ>
    <xmx:a8cean1NxdJa_Xh4kB2RazWbxfNRXfWSxriD9l-YsYwKtfp3wS294Q>
    <xmx:a8ceavv-cLJPfSuOzGiI6A1f7wQ1s6zR5qbQCcAZ9opuWCz8ie60ww>
    <xmx:a8cealmERkn0Pf1w4Kl79dEKaeffVyp-xZuLYtNZNk9d_BPdJ2DJ8xZ8>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Jun 2026 08:07:06 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f03e6e5f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 2 Jun 2026 12:07:05 +0000 (UTC)
Date: Tue, 2 Jun 2026 14:07:02 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/2] SubmittingPatches: describe cover letter
Message-ID: <ah7HZuy_WRCD9ZZ-@pks.im>
References: <20260602090808.87837-1-gitster@pobox.com>
 <20260602090808.87837-3-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260602090808.87837-3-gitster@pobox.com>

On Tue, Jun 02, 2026 at 06:08:08PM +0900, Junio C Hamano wrote:
> We talk about how a commit log message should look like, but do not
> give advice on writing the cover letter to sell a series to widest

s/to widest/to the widest/?

> possible audience.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  Documentation/SubmittingPatches | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
> index dec8aea4cb..8ff1792b9b 100644
> --- a/Documentation/SubmittingPatches
> +++ b/Documentation/SubmittingPatches
> @@ -472,6 +472,25 @@ highlighted above.
>  Only capitalize the very first letter of the trailer, i.e. favor
>  "Signed-off-by" over "Signed-Off-By" and "Acked-by:" over "Acked-By".
>  
> +[[cover-letter]]
> +=== Cover Letter
> +
> +The purpose of your cover letter is to sell your changes, explain what
> +they are about, and get your target audience interested enough to read
> +the patches.
> +
> +. Make sure your target audience can understand what the patches are
> +  about and why they are needed without prior context.
> +
> +. For a second or subsequent iteration of the same topic, make sure
> +  people who missed the earlier discussion can still understand what
> +  the patches are about, so they can judge if the topic is worth their
> +  time to read and comment on.
> +
> +. To help those who are familiar with earlier iterations, give a
> +  summary of changes since the previous rounds.

We might also recommend to include a range-diff in subsequent
iterations. That being said though, I just sent a small series to the
mailing list that recommends using b4, and there it get this for free.
So no idea whether it's still worth it to then cover this here
explicitly.

Patrick

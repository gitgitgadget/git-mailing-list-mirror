Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D813C9880
	for <git@vger.kernel.org>; Fri, 24 Jul 2026 21:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784928614; cv=none; b=hOW14b888uhXqsiVBmiy81f3P6AtVXm76gqTT7vM2X+R9815x7+dfNHkaPozV/Q5M0WIGWgkKtO//e1OR6KgI1uOtFON1bbfPECFN139FjKl6XrcngUa+iBElhWOX/TJ5Sa9OSdfFF1jex6620uLYDts8VrXseZKBgkLxUWmphU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784928614; c=relaxed/simple;
	bh=yFR7PXp65RTldcmoF8n095yeE6xc51Hr8KxNvGFUu94=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=thLNIDzjN5wHULfNe+f3nMDkqpbvD2QHAebD8XBGXFyWGN8h2BKuZNB6Qyor7MWvlJo7LpYPLG+kHEVfUtt1lgyhCfr/IYCN+j1ynus6sDgPqD99F5C2rQ/v0LlyTr7BUTnCJkNB//cDNatDG7L/Z8i8WH8xVd6T1ciIBDLNtms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Gq0ncpv0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=H9i1Vqzl; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Gq0ncpv0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="H9i1Vqzl"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 032E17A01FA;
	Fri, 24 Jul 2026 17:30:07 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Fri, 24 Jul 2026 17:30:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1784928607; x=1785015007; bh=t/KOO9hI8z
	hJE9eS9OwonaQTHmVmbFw4fclM5bnbU68=; b=Gq0ncpv05Do7mhu9TGYxpiYm/A
	CLQ6lFcddsTSBdRPD3nb64pN9HguRihhvqTNVfpLKrejWIpfX5CNkYrrJpUl1/wU
	7NPNpcT/n0HZf2yRcwHIZn8b2wymn3oc454CVY9wLtciDaNGIgWX70DOraaPgYqE
	tV3g7qQss7yhp0arg5ol5a58y/uuGrKLCtOiEsXxzNSou9ZpNEEjMhLxag89xVOD
	FOPpu4yO5aR5nfxKC18tzBrZrj0CiPcyhNNoLrHadFPU9gacrKVanNQBBPcrK6/g
	7BQERGJ1YL4SQXr2gNHTAQjjpU85ZshxclHDI2NBUZW0t1kwVcEgLkHIU6gg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784928607; x=1785015007; bh=t/KOO9hI8zhJE9eS9OwonaQTHmVmbFw4fcl
	M5bnbU68=; b=H9i1VqzlR5fLT8tPlZjcLjSEjjXMRhOc8YRYnMOSpc8+buIaPEZ
	0cpve0Iq7l+8LOGUFrRckfvTTuyt8v+pKWQWLozOonux/Bq3vh7Y3rKqF1YzpYMc
	BkrQmWVnlsDlglKVAoCXbrEU7LcHCGA9lpKGX7EoNXPJ1g8f26Y0XiYGA92O9UM3
	oJFHGrbG4V2vNA8iuQ2Tjwgt9y+Hs79owPDdnO62g+IrmghJoRlVSvjr2uoGAChP
	NNVqX1fM+uVNjVafx7967xo9DxKyV4LU315YjxcmdxYOj969tNAz+2WEm+Mb/wF4
	9lXJXY0T8T6q/EWh+9BQk5kjDoBNsyenxEg==
X-ME-Sender: <xms:X9ljasq8gJUkuc9u6qRaEaW4OfZa7RI8lylWnw7I35nMRbPJz6gXKA>
    <xme:X9ljaqHVdzmNSjmQzw65H2H34MQ3DfVOxdDw9nhdWS7kTsV4B6W_DWjCZHEIAohtp
    XjRl0Z180aIA6yzfzODeUTfZ41Ere9EOghqi_udkg1ZN5ZunaA3>
X-ME-Received: <xmr:X9ljaumj3uSJ4fduelHnLq6MlwYLYMGrJ89Ysmg4Df8ra2rAsST4rGStGDfGAXID3Ghl-IIOBgt-fHdIo29kNEBwUyhODhhoHA>
X-ME-Proxy-Cause: dmFkZTEISh6kqyo8gFLiNx5uO3gVibgUsW4FAfK81AXIckIpzKgS4Kiry9z0A3vzJDExK3
    Gbq5c6pKv4j1u7UIhjdYu/YP7KvgsV4mdOVUtJdWffjfrfwvD6qAyp4TVWMqrO6cEd8ryz
    6+CKReymindRH0TCcDONHODYPkWmGP/BttnotmCLoxVZ1JIg5ZvhjDKf1B5EosKVBxXW/+
    WvDvE4EhfFg3Ns/GUNMtaxV5aG9FT43dk1R08USmY1EegakuoIoycK/ed3fOehWZeJe7oz
    3KWt25IY/7EVEJKucREH2KDt/38T0Sot3tI+3HxZEdxXR22wclNugkTXDlL7x+mm7MpBaN
    hPnJ/HawASKsESlF0i+L6rCkMMwTVjdrDNJrKxk9pZUCRcLQoMFcVhPETLT+Xav38SGZvB
    M6fbCS/dfakRVyKVPn3hLb2YM2gjxEgz1HM26egklh4AE0jtntC+eNnI320USx4nG1T+Ua
    Psf5Kmta7uAx/iYkjjloZ3o3b+PH4E2SKK3xoEhRHllvh4aXrCzvRTvJe8bliQl6v5SY6v
    5EJUHMrDZBCDgoVu5VrHcDMcizi7oCmefB8uisd/9WfPMfNn0/J1RIihd9vsVI53Xhx476
    RnqOF16Rt+thGTKa/37Ri+J58RWfTfaWFkBHGXbZyBm4AnlvRMJTVfOpPNUw
X-ME-Proxy: <xmx:X9ljatmjpYvOwfJv4ymBopkiY4KpGnSt5TNJlpXTaNQ83PP6mPCKFQ>
    <xmx:X9ljavs0Kev_DqTUvLgyRh7-8Xal9BnZ2CsIa5Tz-sJb8-tudjUgHQ>
    <xmx:X9ljagmSGrKYNrrirwyOgz0f4QWk7rXbFTFZhYPtGx2ZF80rRGiu9g>
    <xmx:X9ljaqtNo5CIn8H20nLxvELj9AlAzQtfRvGJHvGxxSZHUuY_D2Ycpg>
    <xmx:X9ljao29_a8GRrIVlOwoI4OhPsaIJ8WrcbXLr6VZIUrz1QPiw52jmJut>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 Jul 2026 17:30:07 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] diff: ignore unmerged paths outside prefix with
 --relative --cached
In-Reply-To: <20260715060523.GA517940@coredump.intra.peff.net> (Jeff King's
	message of "Wed, 15 Jul 2026 02:05:23 -0400")
References: <20260715060523.GA517940@coredump.intra.peff.net>
Date: Fri, 24 Jul 2026 14:30:05 -0700
Message-ID: <xmqqo6fw3wki.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> diff --git a/diff-lib.c b/diff-lib.c
> index ae91027a02..a23119b852 100644
> --- a/diff-lib.c
> +++ b/diff-lib.c
> @@ -467,7 +467,7 @@ static void do_oneway_diff(struct unpack_trees_options *o,
>  	if (cached && idx && ce_stage(idx)) {
>  		struct diff_filepair *pair;
>  		pair = diff_unmerge(&revs->diffopt, idx->name);
> -		if (tree)
> +		if (pair && tree)
>  			fill_filespec(pair->one, &tree->oid, 1,
>  				      tree->ce_mode);
>  		return;

OK, so if diff_unmerge() gives a NULL for a path outside out area of
interest, we of course do not fill the filepair and return.  We
won't do any further processing, like showing the entry or recursing
into it, and diff_queued_diff hasn't been told about this path (as
diff_unmerge() returns NULL before queuing the pair), so it is the
end of story for this path here.

Looks good to me.

> diff --git a/t/t4045-diff-relative.sh b/t/t4045-diff-relative.sh
> index 2c8493fe66..167be0bdcc 100755
> --- a/t/t4045-diff-relative.sh
> +++ b/t/t4045-diff-relative.sh
> @@ -245,4 +245,13 @@ test_expect_failure 'diff --relative with change in subdir' '
>  	test_cmp expected out
>  '
>  
> +test_expect_success 'diff --relative --cached with change in subdir' '
> +	git switch br3 &&
> +	test_when_finished "git merge --abort" &&
> +	test_must_fail git merge sub1 &&
> +	echo file0 >expected &&
> +	git -C subdir diff --relative --name-only --cached >out &&
> +	test_cmp expected out
> +'
> +
>  test_done

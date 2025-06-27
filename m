Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1728F22B8C2
	for <git@vger.kernel.org>; Fri, 27 Jun 2025 20:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751056748; cv=none; b=jSIOnxwS2muReqb43NWOV21vCgdHWvILrmSzGZo3eSFjWFzzfPlo8ABMVRR4S9p3sB57H6SEcuULPnq79gMGauC/Qq+1LBO7aa322amIlF0whyLt4A1AU84H3IaLY2CQQGWL7y6xPxQEEnwC1HRb6/FSArtI7c7UFtxzaqjZNMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751056748; c=relaxed/simple;
	bh=SGyCzGEEutHqMqPbTHxXMJErT2zzl0j89iGgakKgwfE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=r2yggG7GN3pF7daWdeulXJpNEGUM+neXIQP3H3vKrT8Oq569DPvOJiI4Qvw4/jrDbRicKTW8LTW92JPYEzPOVBHvCXj7WsTdz2a7SM/G0r1l1yCNwN7GZjfetRsfrCObV9woNYeJNK6AWT2arIFOmwX0X5EF2JjRW6VFBRiZu9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GxZNE1pV; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GxZNE1pV"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-313bb9b2f5bso2479725a91.3
        for <git@vger.kernel.org>; Fri, 27 Jun 2025 13:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751056745; x=1751661545; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6lxmWZFGNOtf/rJC5GVe91m4y/UDL0bMZWvIjJpHzl8=;
        b=GxZNE1pViANk8UROeVVFZQ81S9ZQWoWXH00HkdmJDUcr0Ov7wxkGp/ZdT42Nii0e39
         vtqRdBB0ddmaEt/jVplAFUHz+a7G7q+uVEmJWdPVGfoXLNdtcm5MD6DGZe91ZAiDgjL7
         m7BqqXBYymt3G9HSPPJG+wcg6Y4riX4qIOsouIXWHcNFrzxsJvd0BXeZ9a5I0Vzw55be
         m97PHw943RgEooaD38amXhUzABixJc5hnIFCtubrn3G1GwMuCW2hEY/EJL8xdvv1ReJr
         AiIZRhEeM5ArTMCaklPntAxLPphEZOfFCvUMUo8bQoXNQS7Yxufcy+a/XqX3Y1PtLey+
         pggg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751056745; x=1751661545;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6lxmWZFGNOtf/rJC5GVe91m4y/UDL0bMZWvIjJpHzl8=;
        b=mKrDaP0HxVlFa5WLAAElmiN2dCuf5439Vcyg4i+FXeFpfMcRVGH9mwBlEMa0KvdNIu
         eY6dYNLC+8pSvFz42G61iQf3Yi7PGkevcVAsJJnrkIbRGsXuYmHbBKrwkUWp8I3CjsBv
         xdACc1EvdcM+EU3eyF1LO9wWrwjRA8QdGVhl5ombgffHI/b/kSho40rcRvteudAhVwN5
         9y2jxKhfw9jKp0g/D9HdRLhImDjSoGe5l/JJKJVcR7lrzB32ZmdCqKASMwUapJ7ahUsf
         d2JJoRyhoL+tKtY/YqL20avi3us/ZiDnd3+IBXM39XAE6VS5jhmNSJT/dM+kZCzvYjj7
         1gPg==
X-Gm-Message-State: AOJu0Yw/ud4aqHao3NDlFPKpzwiqyfwsiSP1DAq4AlKqAcHoP/6OmR5i
	eHLNJQScQRz/qkCNIhor5zCkbZqHZsaw6BVp7qLO03EtqejP9n0LCHvua54hJQ==
X-Gm-Gg: ASbGncuLNT6sbcj5Jcag2QRmRNeW2+SQ91I1jHpQfF+Q8gcKKsme0UqO0SqP0OKE3Fx
	drUzbzXk7oswwf7HmhZFpJ9fhwZPMbiJm+rPRaRfajjdZb4tXMfwj8tBq8rSmHAV6NK0V1kau5z
	AAY0PJ8RILhfrEbMqEUWvCbbwhoLqPblQ/zdo+0APjzTMzGDgqz0OxgsJ7xF9CibKr1VAlQrDbx
	J52yZhI7PPphtm9bpkGnlk6Fqf6sFPiedaLuxzBZea4HHabPj+2yec84yhLPCFS9Don86OdhIgN
	djOmTwGiIQchziepDyRFgkm5AgEgAAKHpzaP8FA2O4L1slMNi8ZWw890ysAmT0l1JzGYKq877WR
	a1P2VrHl5U9duL3VEwyJcD9ZWnDTgQrVkTgNtKA==
X-Google-Smtp-Source: AGHT+IEaKe/SA7zVj477A0CEmj5dQEWwG7L5TqbcUv6KFhJRRkLwWeUV3kTY2K1LHycGU4YVmhITxQ==
X-Received: by 2002:a17:90b:3890:b0:313:1a8c:c2c6 with SMTP id 98e67ed59e1d1-318c92ec03emr7439562a91.16.1751056745236;
        Fri, 27 Jun 2025 13:39:05 -0700 (PDT)
Received: from localhost (209.255.125.34.bc.googleusercontent.com. [34.125.255.209])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-318c15232c9sm3159888a91.45.2025.06.27.13.39.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 13:39:04 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From: Junio C Hamano <gitster@pobox.com>
To: Lidong Yan <yldhome2d2@gmail.com>
Cc: git@vger.kernel.org,  Lidong Yan <502024330056@smail.nju.edu.cn>
Subject: Re: [PATCH 2/2] bloom: enable multiple pathspec bloom keys
In-Reply-To: <20250625125541.3048632-3-502024330056@smail.nju.edu.cn> (Lidong
	Yan's message of "Wed, 25 Jun 2025 20:55:41 +0800")
References: <20250625125541.3048632-1-502024330056@smail.nju.edu.cn>
	<20250625125541.3048632-3-502024330056@smail.nju.edu.cn>
Date: Fri, 27 Jun 2025 13:39:04 -0700
Message-ID: <xmqqqzz47wd3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Lidong Yan <yldhome2d2@gmail.com> writes:

This is a tangent, but I have to say that whoever wrote the original
test does not understand shells very well.  When you have files A
and B in your working tree, to your $command, the following two does
not make any difference:

	$command ?
	$command A B

In fact it cannot even tell which form was used when composing the
command line.  So this original test ...

> -test_expect_success 'git log with wildcard that resolves to a multiple paths does not uses Bloom filters' '
> -	test_bloom_filters_not_used "-- *" &&
> -	test_bloom_filters_not_used "-- file*"

... is misleading to say the least.

> +test_expect_success 'git log with wildcard that resolves to a multiple paths uses Bloom filters' '
> +	test_bloom_filters_used "-- *" &&
> +	test_bloom_filters_used "-- file*"
>  '

I think you should just retitle this to say

	git log with multiple literal paths use Bloom filter

or something.

Also the setup helper test_bloom_filters_{not_,}used helpers call is
written in a way to make it impossible to pass a real wildcard and
see how "$git log" would behave, because it does this:

	git -c core.commitGraph=false log --pretty="format:%s" $1 >log_wo_bloom &&

It probably should use 'eval' so that the caller can pass a quoted
wildcard, perhaps like

    eval git -c core.commitgraph=false \
	     log --pretty=format:%s "$1" >log_wo_bloom &&

Then a test we can add to see how wildcards prevent Bloom from
kicking in would look like

	test_bloom_filters_used "-- file*" &&
	test_bloom_filters_not_used "-- file4 file\*" &&

The former lets the shell expand file* when the above "eval"
evaluates its (concatenated) strings, while the latter leaves the
backslash before the asterisk in the strings fed to "eval", so the
"log" will see a pathspec with wildcard.

If we were to fix that setup() thing, we of course need to be
a bit careful about existing tests.

Thanks.

Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7741EB2A
	for <git@vger.kernel.org>; Mon,  1 Jul 2024 16:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719850107; cv=none; b=qoxrz+/p6azeKuERoG57H5y/VWBXmCfI4r299sJwTs15PVTLhjO6Nspq4yO4YCXFQoQQRVfd5b9yCw3Yd8zuy52dm6Y9zUFPIwxtc4SV8wR34YuKW/c5azHoC/yacDaV1KaCChddFEpttFP642ATipEFSt+/Crvzqrm8rffU9mE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719850107; c=relaxed/simple;
	bh=o2zXhMYY3W0JUzb0PV5fE8jKLcv34bbEmhoN6kgAp6E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fvd3o7ESU/jDMPiAXxEoVYCzc4nyIv5v1NSEMYurhoOF9a4jyKTX2SBGSc6aHS0ML/F9P1ctIAOizi4tQrp+zl7/l+DPVFWEGr8TlGYqCWUUBpbVevoxzqBxQ6AN9hQxYrVvlu2woy4y6ROdwUN+eoVBuJpkDrZ2HiKqwGx/AL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HeIOU0Zp; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HeIOU0Zp"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-64b417e1511so28209487b3.3
        for <git@vger.kernel.org>; Mon, 01 Jul 2024 09:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719850104; x=1720454904; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=o2zXhMYY3W0JUzb0PV5fE8jKLcv34bbEmhoN6kgAp6E=;
        b=HeIOU0Zp05cyLHQBdINg9G5YX3JW9/BBkz3gtG4ZCBXMutCr1gpMoxme/liRGxmRtI
         K/bGMDvZ9EU2kmX6IQJYYEulLjbStah7aRRjf9bXkJtFISb0kd8L+ofxjzjX4xy7pMAD
         WvalUoESRP5OqPE4yXVzG3lDQtwILUQx4mLeV2EZF0TJI1Q/j1sn4+1ZoMi2gA7q41JQ
         BGXD+BgQUiEIQHxH5rF2sBKfNLBzSIrxWDD1gYmzpTxn9ySnuSB4Hd5q4qJEdon+Ydet
         eyLaGuI4bkwuAkIRE7Q+FSthhZq/ynkYG7KCNqk5A907nr2UngqAiZ8OZpGfBJog7hbE
         HwvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719850104; x=1720454904;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o2zXhMYY3W0JUzb0PV5fE8jKLcv34bbEmhoN6kgAp6E=;
        b=wW6n1Fu1s174wpJzgJi4lYjO3lk/eUfeRdKq6WaGpXQDTHEcv4wwcE5oewCysT86wi
         rhK4FlYq0O/OktpRuEaXTNo0ZOrs5/7zAvuIyHizw0RCIRQmpelzNl2M4NObCAg5nyoL
         uRDTIQaENyTsh4rJsUlSEl2itr33o8iHPi7/eRDCpjiERy0/ffBG+VlHOxS9/BCLH8em
         F0cSm2+r6TehTRrTrgrcK6RedTFaGs197Du7g3Y1LDslIYjgm3lnVHzaBUSbXyFYklpi
         A42BiDuHCeqiPJu4wfrTqC3wX538RhowO3a5VgOG3T3+Ipynag3ZWowc9LiksVu75TNd
         9xig==
X-Gm-Message-State: AOJu0YwpyrkpzhmcGxMbbdxUBR4wJNQQVzBAuhuvIDRHBOTif9t0vDuT
	T4bpRataDWFN6Ai3olugU4RRutavj7WG0ImWvfqwek/NXhBS5ekbCwJ8Z2TQAoJ8s6kpoCoE5zr
	HVvm0ox333XItTCfaYtme6JVWPdA=
X-Google-Smtp-Source: AGHT+IGBc5ZCz7azLTxUTImH3OBP5yVUv+Q8TbmP1xIKGuUFwCB3U0501wkf+5bho4FpUzgIJXz+Af4gk7AXI+clAxM=
X-Received: by 2002:a81:7785:0:b0:64b:2cf2:391c with SMTP id
 00721157ae682-64c71803a7amr61030427b3.18.1719850104438; Mon, 01 Jul 2024
 09:08:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAChcVu=Kwqj7JhXqQW6Ni9+3TdSfdmHfSTJQWm1_uO2kczSm8g@mail.gmail.com>
 <xmqqle2lyvdd.fsf@gitster.g>
In-Reply-To: <xmqqle2lyvdd.fsf@gitster.g>
From: Pavel Rappo <pavel.rappo@gmail.com>
Date: Mon, 1 Jul 2024 17:08:13 +0100
Message-ID: <CAChcVu=bWR_DvR==b7L0tn8PmK+9KOWWw+e7RtjMhywMv3W+qA@mail.gmail.com>
Subject: Re: Determining if a merge was produced automatically
To: Junio C Hamano <gitster@pobox.com>
Cc: Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

I can see that I used "robustly" misleadingly. My intent was to get
robust automation, not a robust boolean classifier; sorry.

Here's my use case. In our project, every commit to a PR means that
the PR needs to be re-reviewed. During a PR's lifetime, the PR's
target branch might be merged into the PR multiple times. Since
re-reviewing is costly, I'm exploring the possibility of not requiring
it for such merge commits produced automatically because of the
assumption that nothing bad can happen there.

In that use case, both false positives and false negatives are _fine_,
if only annoying. If it's false positive, meaning that a PR has been
truly merged, but the check couldn't figure it out, re-review will be
required. Not a big deal. If it's false negative, meaning that a PR
has been tampered with, but looks like it hasn't, then it's okay. Why?
Because the result will be the _same_ [^*] if that PR is eventually,
automatically merged into the target branch by that very Git that
performed the merge check.

[*]: Or very, very similar.

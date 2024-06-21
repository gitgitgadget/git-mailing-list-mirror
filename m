Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67EB58C1E
	for <git@vger.kernel.org>; Fri, 21 Jun 2024 18:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718993763; cv=none; b=KyXVywMQ9b6X8wm49iSN5FS++wc9YzGuxptCmkh4Mx9hu5pOStIsTUvuNrS3fUI+/E+2DCPRHqBIJbAALtxEtR1GfVeKHnXRqbNEuSVfeVfsoywiPLdoqQuQyDnKuct1jfCyp/mz9wTb2BUjHmlYbqJ2IHBtqbVh8Uwx5s/YZdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718993763; c=relaxed/simple;
	bh=sJsMZLO7BUrSnO6wqRz7nLzL+R/l5gEk9dB5Xi012mQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n6jXuUpTy/U2R5B/02GHpL5o7ak8l9lPYNVbFXtx1vUOc5xNCZoXmfCI4DPZEAE7IRBK9IjEynXESqxRFg4rgnVlLZeNlK2rKNAV7YfwobwR5lnQB7knT5jkKYBS2tFk07z4zz3OwrU/AOPjrlOHZj2cnQit6s7OakjQLzKnTJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XGWt1tGv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XGWt1tGv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718993761;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pgxwTRwmWgBTsDXGBe5po0jbiNwk2Sb5JAwOTZAnnh8=;
	b=XGWt1tGvK3ysRayLbMEmtdSH+LEKc6RI0ugP95EYL8s+F97NipKUaRxMyYeIBHRjm75Q5Y
	VTtKZcaRlIT0V673JO/tQQJhOrTWhaNeDGeRCYX+739OnRyahdFXiB85gbf25b6aIktD9U
	3KUmtDycvo462RZz4+ag35caPqL7V58=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-TpkhyFR6ODabJ1RmSbuqJw-1; Fri, 21 Jun 2024 14:15:59 -0400
X-MC-Unique: TpkhyFR6ODabJ1RmSbuqJw-1
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-6fa16525999so2618561a34.1
        for <git@vger.kernel.org>; Fri, 21 Jun 2024 11:15:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718993759; x=1719598559;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pgxwTRwmWgBTsDXGBe5po0jbiNwk2Sb5JAwOTZAnnh8=;
        b=NOItuMOXJldYjczn29CeGPGl9XABpojcYYoxKSBCN//t7cgT60A0kgsHZyvlZnHcdF
         5TNnQ9Y5szHOkehTxP4uz2dkB8pkMz3OCbRRisLkkfiJ2UzyK87ZofyojeILPLzOYgMa
         yIRS3nJx9g8wZM/hWPCuzt9koTmmteofz0YBmodUBlA0h2mfkVSbQ2Fx1we5xdF7+Y0B
         z0NA2MzTtjyZYbW4T5IK0sF84uSdJiO0s0E5s56cvH7kVEHWfkhvwUSWI/1/iVJqlsQ4
         lpUOuMF/VEmLIUIegoJ+efXIMQkv42QKF2smpNTIjSU2XAiEUs43/dY/grXVPiQZrjzD
         xCqw==
X-Gm-Message-State: AOJu0Ywi7CvVNYIBD+TpBcK2o6rvY0B90VoA8b5aTMfoJM9QqfQtjzV2
	bYkdxRFG/VSje4p4cDnNMeki1dc18SdzvEqo8RO9qY37HWBnKO97PTshRPJnLe62qmT4n8jGpvS
	WnPJI3FhdzIb89znb8wyd66cp6CrmmLjpEP41Y3hEXk71O/6MUStux5XgmUCo488dznhp+byone
	42Itd4hLKXAPZ5JKnqJWMTeHO0
X-Received: by 2002:a05:6808:220c:b0:3d2:2ab0:1f2e with SMTP id 5614622812f47-3d51b7c6e8fmr10558866b6e.0.1718993759066;
        Fri, 21 Jun 2024 11:15:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGcwJ0mk0HfzqMEKoK1kFUKECkoZr7KlHkIztNsepvIkAmv65ntbfiJqxfaHRgmYMAAu++/Er6rDUW39p3u0WU=
X-Received: by 2002:a05:6808:220c:b0:3d2:2ab0:1f2e with SMTP id
 5614622812f47-3d51b7c6e8fmr10558855b6e.0.1718993758808; Fri, 21 Jun 2024
 11:15:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAP0H_AEd1jFNB_dO=HRjwEUKzFqnjntss_1wskKU6hE1VmBs+A@mail.gmail.com>
 <xmqqbk3uns4s.fsf@gitster.g>
In-Reply-To: <xmqqbk3uns4s.fsf@gitster.g>
From: Rob Linden <rlinden@redhat.com>
Date: Fri, 21 Jun 2024 20:15:47 +0200
Message-ID: <CAP0H_AGw2R6JPxd=8gAn0w1Fy6iY71LRkH+F7uHL0PVmE04B_g@mail.gmail.com>
Subject: Re: problem with parsing of patch files for patch-id
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Junio!
Thanks for the clue, You're right... I only work with the email format
so I didn't think of that.
My solution doesn't work then...
I had a different idea first: to check if we already got an oid and
only read a new one once
the current diff is finished (and wasn't empty so far). The other one
seemed just simpler.
I will try again...
Thanks & all the best,
rob

On Fri, Jun 21, 2024 at 7:05=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Rob Linden <rlinden@redhat.com> writes:
>
> > This patch (also attached) fixes it by only considering commit hashes
> > in a "From xxxxx..." line:
>
> If I am not mistaken, "git patch-id" was designed to read from
>
>     git rev-list ... commit range ... | git diff-tree --stdin -p
>
> where we see
>
>     9005149a4a77e2d3409c6127bf4fd1a0893c3495
>     diff --git a/path b/path
>     index ...
>     ... patch text here ...
>
> so I would suspect that limiting the commit object names only to
> those that follow "From " (i.e. the format-patch output or output
> with the "--format=3Demail" option) would break existing use cases big
> time.
>


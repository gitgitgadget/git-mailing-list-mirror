Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4576119C558
	for <git@vger.kernel.org>; Mon,  9 Dec 2024 20:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733776803; cv=none; b=VCpYMAjtwhvoHzY2160dg4fHTqGc0OKa1fonyYg3F88mM9pmcHGjzMBV7BGtF2zzTHHuV1+ZQ4pgSm1KbeFE5Ec+UJ3z0ENAGjs4YguS2JUk3mWljxa63rFUQgVJKniXs91LYVmMxbdMV3fnp43FfhG9wP/14PmD8iwnO2WFZtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733776803; c=relaxed/simple;
	bh=W/2zyRg6g6Ht/uVM9WRpsTSDQ9gXQXFNXkyWiNH99Y0=;
	h=Date:In-Reply-To:Mime-Version:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=Q5OHPVq8v4lg6AXDt8glCLJhrSw/mOmyVGmixv10ovMEvmF3NHrJXjZedHK7iOO8exdCBOgWotIkqiC5bVsCNRij7ma9LoENH0E30LMWDsXP3CSpf9x38YCMQNl+WGVtcNITv1adx6djZx2wpUdctC24cwe8ayV13AEzMJjRji8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jonathantanmy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mciH8ngE; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jonathantanmy.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mciH8ngE"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ef9e38b0cfso1603103a91.0
        for <git@vger.kernel.org>; Mon, 09 Dec 2024 12:40:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733776801; x=1734381601; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yRoTImK0Ng4QsKTDxVdj+PVgRgcMFAmkmL0Frd8Wb/E=;
        b=mciH8ngEmNEpsOLW9m0m7O6myY1YPEYirfKIh/zSG/LDGAenkSGIYzm1+LKG2peuoZ
         yEU7rzgq6z8Ttm1svhmkZNkc1/0dknkQN0Np1Rg4CuT0wzM4vSnYlwnf0103FxV7t6mt
         +prmdhp4lTUlIpXW0UN/1WOH68elTYBfLE+BbgWkalP4hHjZ00toqjFROk3NyXW94Kel
         nVtNbK6yXN1QyoT5EHFRvtD7z1KVPFt1St/5zS+Por0otrre91x64LnN8qFTatvAXQhH
         QgxWfRAhu6lQtmOwwRPsVxHGdc+aJL/fNvKwkTE8gAXJxQ0S6R8chUTnZV1ywpENMVTk
         A2lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733776801; x=1734381601;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yRoTImK0Ng4QsKTDxVdj+PVgRgcMFAmkmL0Frd8Wb/E=;
        b=c6yRLSJD89/BuTQTwDTib+YyBAh+eeYiMtS7ek6oaJdPjIjhM2uOQbsL4PgF2zgJVg
         4FpJfL/2wDdJ40RhHjDRozlTuyZzyyi3noFyrpO5NTo/UA6NEgkV7lGWz7kfoK0Gn2qy
         4gjbqWgkDtmHCbwhDNrucectryzhdckZScpT+fXRYMvvjVtfx+uESN213wgdsRTV6FH5
         gXLMwma4dKmYlsh8Cam/FAt19Jbq0Hj+SyCQdfGn9aAO37TBbQ32GTH4Aw96rNwCEmfW
         1O3V9OW9d5pe1faD6hsG8LA25u11od2w/8MBm9Ptq7LEXzuv1tbnAfp9I+5qsduqlcHS
         1xYA==
X-Forwarded-Encrypted: i=1; AJvYcCX/yUbS6WLZjkhOSemXlEm51YcV2gj0Vy2lIRaQiBHYU2yxOWWZ4Rm02I7MuGUynjfXc4g=@vger.kernel.org
X-Gm-Message-State: AOJu0YymyvzZ+03zZEWswa2QJpf8QPe0OrPJdebGPjQE/NYmkOPPROY/
	ztU6MkweLFrkwmF40xbDrPN/e6R3BnTK0jO2jl//Ci202xyEpffbImenDHOHrx1HRO880VMM48s
	tUnspJb1L8Kgen/qPOzmvDWB92uFg5A==
X-Google-Smtp-Source: AGHT+IHWzJg680exCGTT7mQIj+FwbloB7YHCs3/xGxezpXJWtumlB1y7t8Ti79yDxR2QNMIFpGBgZ+jv1NkCe1sf3xfC
X-Received: from pjuw15.prod.google.com ([2002:a17:90a:d60f:b0:2ef:977f:1108])
 (user=jonathantanmy job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90a:ca97:b0:2ee:6d08:7936 with SMTP id 98e67ed59e1d1-2ef6a6c10cemr21253381a91.20.1733776801623;
 Mon, 09 Dec 2024 12:40:01 -0800 (PST)
Date: Mon,  9 Dec 2024 12:39:58 -0800
In-Reply-To: <xmqq7c8asepo.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241209203958.801143-1-jonathantanmy@google.com>
Subject: Re: What's cooking in git.git (Dec 2024, #03; Sun, 8)
From: Jonathan Tan <jonathantanmy@google.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:
> * jt/fix-fattening-promisor-fetch (2024-12-04) 4 commits
>  - index-pack: work around false positive use of uninitialized variable
>  - index-pack --promisor: also check commits' trees
>  - index-pack --promisor: don't check blobs
>  - index-pack --promisor: dedup before checking links
> 
>  Fix performance regression of a recent "fatten promisor pack with
>  local objects" protection against an unwanted gc.
> 
>  Need to squash the fix-up at the tip.
>  source: <cover.1733262661.git.jonathantanmy@google.com>

I just replied [1] to what I believe is the last outstanding question,
so I don't think there is any code change needed besides the squashing
of the fix-up (as you said). If you could squash it locally (onto
"index-pack --promisor: dedup before checking links") that would be
great; if not let me know and I'll send an updated version.

[1] https://lore.kernel.org/git/20241209202935.799059-1-jonathantanmy@google.com/ 

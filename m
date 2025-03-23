Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E16A163
	for <git@vger.kernel.org>; Sun, 23 Mar 2025 15:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742742745; cv=none; b=XH6OtLiEw4VZUOdM7/n82GYWZXh9wpIGSzgtJbcPXzaSHA+E/A3Mvn98/r9cFohhpdz0ie7iL4Wxgw8hxwmD5ixmwM+CHc+tLDi3+hvdVTCGranwEe14/E/SU9Zaqqtf1k1Il/vb5uffWVwfS0UfnAuUUsN3I4JtrE4JJ8O0OpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742742745; c=relaxed/simple;
	bh=a04BuBRBnYTNQjomfeDxHI28bGTBEcyuVY17nzprzLQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gx16XpOngSWQ98f2z6C4uy0ez3rST2mV0rkH6tKINvAVGBQaOr5Gsz6HJWKtzEPAHPYRZOjuzS2gmVpr40cwlkNacqS0D9pvIFKIRt+TnseYHc5CcOOKgrluh+TKmXY8WDGjoNhqB/8RB0lD4MQS7Gwg96TzJutMEZ3zYdgPek0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nnWfcKJz; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nnWfcKJz"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5499e3ec54dso4082847e87.0
        for <git@vger.kernel.org>; Sun, 23 Mar 2025 08:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742742742; x=1743347542; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a04BuBRBnYTNQjomfeDxHI28bGTBEcyuVY17nzprzLQ=;
        b=nnWfcKJzKzaqFSGTiTmXvQh+zXIdI3mgTPYvYRG6dOiN1CdLInIkY6j0fSV1H9ah89
         H/H39gIgdMCWr28kJYpJBDTyUKf+4OH28WzuK2DGjAnEDtN6XL/W6Sr3eAwXBvfzS9e5
         WnUhGXLSjAqY3YtTuzeQ/SuFusrseqOUKINYzwOgJ7uqRjZ+20Xh/hY4/1NrSGL6lxs7
         xoPSs3NM1WiqVUuL8aHo29ui9vCyxEAlu5ZxaXPVPecMPkt06mCNn5WpGtrknGPpaF8F
         jwVVCKP6wfgQvOxJTP3Nk5fYfe8h1ft8d3h9sRWIReIJYbHcZjW3JVPtvw6C5nheW/To
         5FwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742742742; x=1743347542;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a04BuBRBnYTNQjomfeDxHI28bGTBEcyuVY17nzprzLQ=;
        b=P8HIh4/+vVsNWCsBxgCQmmM0qbGucMKz9iGJAC79ow2MKzvnKOMJIPxDJ8yfzgo5gq
         J/KJkwX2ShjcmXpedvUeYaO8XnvnWSiQmXvF6qmWnJ4JLXBBXTc8aSggoXEb17IDVoTr
         aZ5a+c3yhpaEf67g0NqpG8x0ryJAbJpCxwVU7KMtsCwIPW/u/DLrod88TxPhG4zc4Yni
         SkEo+aYNWjUzGmoxPNlMXcOXQK5iIDJglT3DNfem8aIoWELGFQ1oKEvamuCH9gQxjMjK
         zyZSIqLVE4Jvb6+TDyaS3R8fFN7Rg+YX2pnMty3/FFA7oD+EhX4vQhGSKmvDnf5wjJcD
         r+Kg==
X-Forwarded-Encrypted: i=1; AJvYcCUGPTMs2kWr+RufGCuKCUdcJ8JmZFDKRPDTQrHPkz6Rpyup6HoCo/QK9xEEgD51qiBSjkc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywe14PBGLfVOG2C6N3s3ouJ8x/FaDMa18k+gdWOGCc0auQZkUee
	9wEthgfVw//eSNuYShbNrfS6FBLiBz6tzsniM64RACe7mWOgB0x2KppOQngBAPNqNDl+YdbBXwJ
	6hvTQo6kEdqnrjHmIQUs6seD8Uwg=
X-Gm-Gg: ASbGncsQfAk23+h5dQnkDkc1CVxsSGTCAsY9KlRKGmfKrlvPhsdkqTFfqLvYy3HLjWW
	XZIuYTUIyjGDgr4wxO6ppbNJOymvqYyLz2ZQyMRQdP0jp/iW05Qjb40WaXga7Hguzm0Bsp/uJcJ
	AulOpJI9OXxahpLlRFzraFuuzwKD0l71HMxRjCFg==
X-Google-Smtp-Source: AGHT+IERIsa3sqxK4Yrc2TFsp6dCYOnvoZa2ML4S75aoUQRlqKjB0xD4Qbq3Y878/RRwlzdrpsrEUubnoG3RdoO4uXA=
X-Received: by 2002:ac2:4e05:0:b0:549:39b1:65c2 with SMTP id
 2adb3069b0e04-54ad64f9147mr3913220e87.48.1742742741856; Sun, 23 Mar 2025
 08:12:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1930.git.git.1742637713157.gitgitgadget@gmail.com>
 <pull.1930.v2.git.git.1742688740650.gitgitgadget@gmail.com>
 <CAPx1Gvd+0XBVm6N6Vrogczhqy8hARajoQ+zDgaaeKMTcSskmeA@mail.gmail.com> <11DFC309-0D48-42C8-A683-F5D0C30810D3@gmail.com>
In-Reply-To: <11DFC309-0D48-42C8-A683-F5D0C30810D3@gmail.com>
From: Chris Torek <chris.torek@gmail.com>
Date: Sun, 23 Mar 2025 08:12:10 -0700
X-Gm-Features: AQ5f1Jo3nF5SxR2wwISfCM4t_umseodo5z34yLqI4P8RsxMFIfFTYadWW-NCmE4
Message-ID: <CAPx1GvfPUqHkT8MewXyAS5ptO2Cz+Jn1+1w9wa5j-WfO68dfYg@mail.gmail.com>
Subject: Re: [PATCH v2] shell: allow overriding built-in commands
To: Ayman Bagabas <ayman.bagabas@gmail.com>
Cc: Ayman Bagabas via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Elijah Newren <newren@gmail.com>, Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>, 
	Taylor Blau <me@ttaylorr.com>, =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 23, 2025 at 8:05=E2=80=AFAM Ayman Bagabas <ayman.bagabas@gmail.=
com> wrote:
> Shouldn't we also check [access()] for both F_OK?

Any success for R_OK, W_OK, or X_OK implies F_OK.

I'm not a fan of access() calls in general for multiple reasons
(they get suggested for security tests in setuid programs, but
you race from "access seems OK" to "actually try to access"
against anyone who modifies the name-to-underlying-entity
binding, so in general the "right" test is "do the operation
with the appropriate permissions in place, then see if it
actually worked", which is atomic). But in this particular case
it's probably not that important (we seem to make a lot of
assumptions about security, or perhaps lack of its importance,
in git-shell).

Chris

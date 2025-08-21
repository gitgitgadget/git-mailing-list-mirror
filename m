Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0AE0352FF3
	for <git@vger.kernel.org>; Thu, 21 Aug 2025 20:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755808001; cv=none; b=dP/TyQoXpt0d2+75LKGX4xOi4iR4Zr6Mf9MCOtxGiikreN8GhMvd0D8ygrhcrtz7tzLZPWFg7Dw2L1/D7O+wa6n8mhtqXj/CPQ4klpKfo7A4HcDpjnDbiRE7Ao1GR+ViyJfzK+pVaW94vWVopiPYmAkioqwK5U9LyrQwSoLCTSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755808001; c=relaxed/simple;
	bh=pqDj8PgoAiy8PvQkN+ztp1HuVyO7iipvfaEuUcb+d0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iLzAOcJQ7WNwPXN0ibvKnD60ztMx0AtqaThGy/GQt6F4qBp7FZzd6SYq9y/NAAAmgSPDcoyXOkgfpbT744I8AWCiW3yXwL40sULF2pkrXwOuqlxo8YSEqlcHxCgDuD1tVnGpzjfNtrCke94WnoywccnFAUnjoT61/CRMuNVpDyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qh+9LsQs; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qh+9LsQs"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-74382015df5so330920a34.3
        for <git@vger.kernel.org>; Thu, 21 Aug 2025 13:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755807996; x=1756412796; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pqDj8PgoAiy8PvQkN+ztp1HuVyO7iipvfaEuUcb+d0Q=;
        b=Qh+9LsQsOpEOrpoTK1/A5i0MXNZCx9Nkur524t47bTckRr/hkGgc5NEZb6xqzMcv5K
         rif8PiD4aR6FelglEoSVKohbX/JWHqxq1zyF2vYm0TwP4R1zKJOgJflUdzNgqdjrqL/6
         TG3uZRpQUPhBpGNYLkCn+LpaLEMlol9Zyyol3mjlqRum75uQKDZMSmCfgNPQtzHpbigG
         XufPzmSzh/qtQJBX81ugzeH1awil7htCuOwXxFh/PdY/K4YV9WZAw13jHynYbCKokfWn
         A5Z+slFnCpgtwNq8f23OWZkk8lgQIpx0XKuKxlZtgImVb5ngepLodhgJ2In9dUQTeuU/
         k8tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755807996; x=1756412796;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pqDj8PgoAiy8PvQkN+ztp1HuVyO7iipvfaEuUcb+d0Q=;
        b=RyydC/6fUlub+/Fasl1FD694VBPYcvj3aPuWa0ePp1BpO1TZv33+OHU4dQxfhnSeiz
         kv+grxmU867Fwc4gg2JRGxyn1ma6Q7toqi7mtZ38cugLw+W03D0/ImTwQWYlv4KWlx9b
         jzCnqg2TsDvYgQb8WWiye8RXrh+Z16enUf6jwnA2/x+5Tj+dX9/teINm0GKAImHCzQJ1
         NH+DGkvA+fSOqt7MdgzkrgIZmEmoi2D1N+ZEMbZeT+kxapjAVk0v0bU7PTT18iDeWViL
         jgaWQeFMVStOYN9kqpdF7h31v6kb/BGx+IWS4rl41q9FyZl0Z4sh5d58QsiWHD/z2adR
         ZOjQ==
X-Gm-Message-State: AOJu0Yy6pPCuVwF9L1JJL67EDNR5QvkrJnNpQ/w30k2tp4cZDdUv/5L6
	lcseF+g3HqLX5QeCJmSHaC/g1uKNGaVZ+ewaB9LJ+XwxB1sZtCbyTO0ERfrxk0F6
X-Gm-Gg: ASbGnctmOzGyShB9r3c09oPH/44MpMMsdtvfpFwUbo3Rf7x1wn9IUZsLf7/1/CukNKh
	lcpw6ghvD9VshUMY2ZY6jFtb/eNTbpGcwOB6h6/aPoup2qZlw5SlqfWyraQI0oGQr6raEW44l9X
	l7tow2u13/cllPm1VixtWJK3EBLfmXMQZiJ4FAvelG0CiCzyR/rwSrv+TfQlM4E5+LUNYTn+BZb
	N6rejr3Cn/dnefwSwJk4SDaGrl1aN20Bp/Nb9vSRECfUpw47FIrskUOUz8Drzx69G/TiBmwuBkh
	B1J/Xx91vsCPmyETd4MXq6MJUM+E8/Lq8yuH6H1sc2xCOqpM+CCrudmxEPQmNNZ2IxO54UXH0iI
	45bJjLPyl+qXovA5o
X-Google-Smtp-Source: AGHT+IFhu+UA1G1cUas82lyjyr/rgvZJqd4AR+Sm55wDDj1uEtZub1i3fmPUNLjG1/++tY2rWO5WCg==
X-Received: by 2002:a05:6808:318f:b0:434:689:6c10 with SMTP id 5614622812f47-4378534272cmr456605b6e.37.1755807996506;
        Thu, 21 Aug 2025 13:26:36 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 5614622812f47-435ed0fd98esm3521414b6e.6.2025.08.21.13.26.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 13:26:36 -0700 (PDT)
Date: Thu, 21 Aug 2025 15:26:35 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, ps@pks.im
Subject: Re: [PATCH 3/3] bulk-checkin: wire repository variable
Message-ID: <rhkhmaozjaogm34xfwagagy2qifsq5p4fbtb23nhdu7jfg2627@qkrv57gg2k3u>
References: <20250820225531.1212935-1-jltobler@gmail.com>
 <20250820225531.1212935-4-jltobler@gmail.com>
 <xmqq8qjd7coe.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq8qjd7coe.fsf@gitster.g>

On 25/08/20 05:15PM, Junio C Hamano wrote:
> I somehow expected that odb would know what repository it was
> instanciated to work with, or in the worst case where in-core odb is
> in theory sharable among multiple in-core repositories, at least
> begin_odb_transaction() would take <repository, odb> pair and the
> transaction would know for which repository the transaction is
> working for.

The `struct odb_transaction` maintains a pointer to its parent `struct
object_database`. This ODB also has a pointer to the `struct
repository`. Thus, from an ongoing transaction we should be able to get
the repository we want.

For `begin_odb_transaction()` we should only have to provide `struct
object_database` and from that the transaction can access the
corresponding repository. In the general cases, this is exactly what we
do, but this doesn't work for `index_blob_bulk_checkin()` and its
accompanying internal functions as they may be invoked from outside of a
transaction.

> Do we need bulk_checkin_packfile as a separate structure and pass it
> around, or would these internal functions be better off passing an
> instance of odb_transaction around and learn the repository from
> odb->repo?

In its current form, the bulk-checkin mechanism for packfiles may be
used outside of transactions. For example when calling
`index_blob_bulk_checkin()` without a transaction, the single object is
written to the packfile moved into the primary ODB. With a transaction,
multiple objects may be written to a single packfile. This whole setup
is rather awkward though.

Thinking about this more, we should probably just require
`index_blob_bulk_checkin()` be provided a transaction. Callers will need
to ensure a transaction is running so that a `struct
bulk_checkin_packfile` gets set up, but this shouldn't be a big deal.
With this we could easily just propagate the transaction for all these
function as you suggested.

I'll do this in the next version. Thanks!

-Justin

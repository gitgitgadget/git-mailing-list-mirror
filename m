Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56770214A82
	for <git@vger.kernel.org>; Wed, 19 Feb 2025 20:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739996031; cv=none; b=Sk8o3zAGBlVVL+GJAeokdzv/hDZMz7JGkPhNuIls8sXyVUupTHut1JmQLNUfyz+N9jY0E8lxDawdAbD39cyboCkjB550U/2UIBbOjxwglkrO7n7hKQSUVPOzFcJInQhG1Fhtw/goX69j2cA2KKQ+GUY6CuCXQlbxcET9pM3Oq9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739996031; c=relaxed/simple;
	bh=eJ77Iy0gTfFq9Pclp3X2dhij8U+DoiQTZosDqs2hZ6o=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DZlMTeFBQgLGuQ5x2BnvRzVcGyHg4l0TcE1bgDhJtIJ+n11jdM4s646DW3aj8xReEk2yQHjXV+ENlXgS0T4Joiaa4TseZCbFYb0tWff+GbOPE0Nkedk+AZmoaLvXp9jqVNHq/X0gqvwW7BEVhbitL9EKNkLlEB46+di1E1Ignkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MvaVk8yY; arc=none smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MvaVk8yY"
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-4be4d72bceaso74731137.1
        for <git@vger.kernel.org>; Wed, 19 Feb 2025 12:13:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739996029; x=1740600829; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=GnBTkzKs6Gbu2+N0Oaxl0zREFd6hzJBzuVYWyjYNw7w=;
        b=MvaVk8yYiQy8M9yxzyhzhVwjF9mc+DbUvFyxWJ+ADgNUCuZSWT3GUOWlnzTkuW3Bvk
         1EGItOPMXV+/uIBJUIzI4gpcehVrjQidXFsfdEjZ04dPnoKlshJQAl/bldOvlwF69Sf0
         xtHezd/dEA81PagcoiUv6p1vLdGTIFx68gArpGrolt9txijAlDreH0/n2B6EDs0pAkPA
         2Su/L0HStxEJiwTxUSdTBLhuazSV9OsHMJbIrd8IGbYTGu8QQLgPl1H+Uk/52MCzIKU/
         h7WAnFI5czzuq0jBFjJ+o8AATXWEcnEaQ4t2zHGpr9qiYEjT2DfgrFE+WKRYvR1ieXOZ
         IW9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739996029; x=1740600829;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GnBTkzKs6Gbu2+N0Oaxl0zREFd6hzJBzuVYWyjYNw7w=;
        b=WKUocU4QhJFl+KKapf8VmzsIRcum6YO6BG2/10W9ayOel35IIxCnA7GsZZpQNMCNwq
         eoN2mzIQaDaOBeWfXMpxKLq0i0tAAgCdgDnbR4j0Wn0SFG44fvMDuKvC00KgcvYdCHi9
         Fqlxyt0dYITT/2ccyk4XteBgTfOtFnDGYdg+NXNFoocaBn2mHmp+H/PY8kCXRx4RtLKR
         dVTaUK5J5blMuxZu578h/GyUAM1PS3vG1YkIZMfPe05UZ7b1T20u69LHw8OWlQHPFQvI
         KSeRAZJ+mExDH25v8uAogU7dIjUVVgQAiIzQdjcFJFRTrGWm3ii+BP/zY9rV46gXGif5
         j/QA==
X-Forwarded-Encrypted: i=1; AJvYcCWhKbNxTemiWvxncCDgmdyTCmfZmsxgHIjlIM1Ym6UDyiXNdZypi0qlR32/DmStDs26W0w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmvX2gBx0nVRnDhX+NB9phGQiQyYEtiwnTPANpagFCgk6ZXr7F
	5GJbUahmtdoR6MFDTL3FHMtELND6ZNUCXJv7qATZhPePphh7p62XhLj9YP17O9iP72JArFLz2k5
	xpnCF49vvl8hMyQkLRGQjRzTKs/8=
X-Gm-Gg: ASbGncuvRP7ol7esamgH4onqs1Jml3wBGh48mFw53Tl7QdK9Ivsq5CVyZ/L2jTuxq3M
	HQUZFz3qLQDVoFO0unW7QKpJBvQ6GO9NQJh5MUsSxIQY7ouuLIs5gXgyrWdD9Bx2fVYiedZ+odB
	opPcNZoKiZ0QTFhfVvuaN8XUh6BsGFWfs=
X-Google-Smtp-Source: AGHT+IEGRhUTZKJ9Kl7sW03LHf3GQ4HCBVv1II0ioBu8C94W67ihrVyHEFxMh/oE9tdU3qDq6LLMY6NU7h7QdINnwXE=
X-Received: by 2002:a05:6102:1493:b0:4ba:fdab:6b84 with SMTP id
 ada2fe7eead31-4bd3fdfb742mr12333406137.16.1739996029214; Wed, 19 Feb 2025
 12:13:49 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 19 Feb 2025 20:13:48 +0000
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20250217-pks-update-ref-optimization-v1-10-a2b6d87a24af@pks.im>
References: <20250217-pks-update-ref-optimization-v1-0-a2b6d87a24af@pks.im> <20250217-pks-update-ref-optimization-v1-10-a2b6d87a24af@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 19 Feb 2025 20:13:48 +0000
X-Gm-Features: AWEUYZnoaMPGhV5xPqrvjeELQzbiJh8w1XB95wpZcfIOAwB5z0FWINHC_-Bhpt0
Message-ID: <CAOLa=ZSgpeTCayxCs01hdVJ3FsXMPCzSg+RV5tgMc0Agz9nAqg@mail.gmail.com>
Subject: Re: [PATCH 10/14] refs/iterator: implement seeking for reftable iterators
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, Jeff King <peff@peff.net>, 
	Junio C Hamano <gitster@pobox.com>, Christian Couder <chriscool@tuxfamily.org>
Content-Type: multipart/mixed; boundary="0000000000003b7eaf062e846552"

--0000000000003b7eaf062e846552
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> Implement seeking of reftable iterators. As the low-level reftable
> iterators already support seeking this change is straight-forward. Two
> notes though:
>
>   - We do not support seeking on reflog iterators.
>

Nit: this doesn't explain the reason and it would be nice to state why
we do not support reflog iterators here

>   - We start to check whether `reftable_stack_init_ref_iterator()` is
>     successful.
>

The patch looks good!

[snip]

--0000000000003b7eaf062e846552
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: c6e3b8ff89386e92_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1lMk8zc1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNEtqQy85dms1bm9FTmxTZmtSQUpscXJVVExneGNKTApzVHBnTW41b1E4
OUI3ZVhLQ2pFN2hFVE5EdEhuc0Y1ZEI4dUJQZlJPK3I1YmZRcGR0YnhJWmFjTUpkZHdYaWEvClpj
L0ZjeE1LYmcwbDZGbTFTQndoVUpSNy8vb1JmOGJKRzhyelJIM0dOSGY2T2MzanVTM0l6ZkZGdkQx
ZSs3aVYKcmRxL0xRWVZRaHdZMHN4M0tEQTNQREZFVWtpSEZZd1QxbjJyZjNTZUZQYW82L2svdDBL
WURTbWpobElmZTNKUgpycVlkNXVPZzJIbkJtOHg1dndnckNCa3Y0N0FZTmw3c0RSb3lJNmx0SXdh
RDBNVllpWWh3YnV4QmFxMU9lbGs2CisvZTFSWE1xU0pwbUQzRFBqQXIzdkxlY3NMbUlicHJZUTFx
aVEwL1BucjVFajRtQmFtelF3VEh1aDEzeWxDNjEKUVp1cXNOSDFndVdPSHVNS1Rzam9tc3hFQlBG
R1dhdGxOU0RSZkY3c0ZncFNGS3FsZVlHMjlOVjFlUTh0YkRXVQpyUzBaL0pNM1h3eDNYWUdpcjFj
bEs0ODZ3NXloRFlOS1ZjM3BiY05DcG5SZzFCZ2cybVZENVd4N29UTC9uRHhjCjhJNEpFdW4rZlBI
Mmg3MU4vL3JjVmxqRE5IOVArNk9mZjQ5dTNrST0KPVgyNjAKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000003b7eaf062e846552--

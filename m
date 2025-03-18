Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0AE14A1C
	for <git@vger.kernel.org>; Tue, 18 Mar 2025 02:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742265788; cv=none; b=eBarWe0pgvVlYzBf1St4d4erxwKhZQOd+VYpDD53XXHapJJSs/hk7G+NRHrzPZfK9M6G9X/DDBZ+XKS78W+zi6bBWWu8hWssrvdbIZl5mktnrvbz6w+FoZe2Sci0Ub1d4A9xZPtzhggmklDjLvdT4Q0lvX5nGicuuKopSjkGxvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742265788; c=relaxed/simple;
	bh=zB05ndzFQ+NmzHoM+4TV6loznkImZO6pJQd6oodZizw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CelAuY7c/nvtpWtW86g8xX/Adj8gFz1SNsL/Nx0v2ajeoDBLQJO5AiZWoSYZre+ncjavinvW1NE5y09gF5+XiQJ/51xgKvF25zPpJ/l9DlNepg69RnWHfcqfiTPF7WpV3w97nehgI+OHCNuaFohkIw0jF1SFcN2a5bU3MQuvulo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qx71TDXM; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qx71TDXM"
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-855bd88ee2cso127359639f.0
        for <git@vger.kernel.org>; Mon, 17 Mar 2025 19:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742265786; x=1742870586; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qCbDYda4eOdFv8KznAiUYzqnIS4PX8CcJRcyz/LTMbg=;
        b=Qx71TDXMWzG18TEPTXXpydelULZ6t45JgYJhUvKy3XmrFnE3Y5COkeKrBkAOHeGeKv
         2Cfa1WBl1NZdhZnx6f9p7NWcm1YJqiQBNQ/B53xNYDxutA7uCEXuCapwqe6OOLGbG/qy
         yOBD10hCW8xLz23kKGMqJ+mykZ0BIFKq+sNyRq8QAD7sAQrI5qgX7uhVT2j27Yt4BwM0
         YmrLQK/h+JsZ5qfXrHzyyREr84V/dtWkuHgVIJxXpEro/mmmBsJBjK8lQNixgUm1geay
         i/J9n6XDNxpF0xAoBKmlYl9sEPwdmZov5CRPmdQ6qX5zuWH2ndB0XzcXB41wFTe3PpIC
         Rhww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742265786; x=1742870586;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qCbDYda4eOdFv8KznAiUYzqnIS4PX8CcJRcyz/LTMbg=;
        b=VWPRDCkoDmNklveddDqyjgwXk3vn1A6JAtN4D2jFLApe3vjDRutlo/nnUAZRYg3SYY
         yG4IgJMXDluJ290j18g3JHoWw+i+Lk4Ozzy+9WpeDewcS5+3wokouv8uQM/U1FITX3EC
         JEj3X5QgzGohebc0v7QvOnPowTB7wvlcRZYYBNuTl8ZfKYf83YsgHIU0+NBZDRVMVKVm
         ro1+qgXKW8VmvMZsArushET6/t2Xk8DQtguRx6PPYFpvz7JH0Aa4XL6pM1qzR/FjL0AE
         UIcsq6imb5bTNZFzAkAub/VOCR4h28p4bnRSvFo5sii/Z0uajiC+HiJ6spH7V9EHucn0
         ofJw==
X-Gm-Message-State: AOJu0YyMu8BEDsfdvGtjEvVd0pI7duIV1mYOiP9QcsJyTS6l6EYoYzDn
	19vAsy4njS3ZWmvJ/njl2SvVpYL+hwuNThZ0i22PSPXmhFBSkZiqKgVO4PxD2HiPuSNHUrCHrUb
	w+0w1Yrlhxo9d3o5XIMm10IjqxN0=
X-Gm-Gg: ASbGncteAiqasYCXb8gNwnP/5QVQ0+id8o4iECuweX/XzVmOy5pzWQ38gXQvpkwy8WW
	9UpBvjiOlRFRUdbY1Ei7UeRxFNKSy6n7hnNjlu7SCPQiZK12kx9XyAU1m6DAteFOVuT+7vthhTQ
	yzQawdJcEvAvFpdA6VgAK4/u55MNajXBkT7COAkzdrA8napbDIxELBWxBt8Ek=
X-Google-Smtp-Source: AGHT+IFiarCcwtvUM9rQP3rVFGEnZnPB57tr44C7VBEHN5t/53GtUp+Xc6QV0NGaEXC/D4Vs7lbGcqhb9L3GEgF0B7o=
X-Received: by 2002:a05:6602:378e:b0:85b:59f3:2ebe with SMTP id
 ca18e2360f4ac-85e005f9270mr215500039f.11.1742265785802; Mon, 17 Mar 2025
 19:43:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1723755667.git.me@ttaylorr.com> <cover.1741983492.git.me@ttaylorr.com>
 <f565f2fff166bdf4bb2505f4a8853215a5365b17.1741983492.git.me@ttaylorr.com>
In-Reply-To: <f565f2fff166bdf4bb2505f4a8853215a5365b17.1741983492.git.me@ttaylorr.com>
From: Elijah Newren <newren@gmail.com>
Date: Mon, 17 Mar 2025 19:42:54 -0700
X-Gm-Features: AQ5f1JpP4t9s56mRQn5ePA_K9_YPhiFt7U3GhzckRAwFsEbjxoIniuX6w_dBxY4
Message-ID: <CABPp-BHMSs7R1kufM6f0PQDBAoPrOkKwnKK+hA+sK72LFLzCCg@mail.gmail.com>
Subject: Re: [PATCH v4 01/13] Documentation: describe incremental MIDX bitmaps
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>, 
	Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 14, 2025 at 1:18=E2=80=AFPM Taylor Blau <me@ttaylorr.com> wrote=
:
>
> Prepare to implement support for reachability bitmaps for the new
> incremental multi-pack index (MIDX) feature over the following commits.
>
> This commit begins by first describing the relevant format and usage
> details for incremental MIDX bitmaps.
>
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
>  Documentation/technical/multi-pack-index.adoc | 71 +++++++++++++++++++
>  1 file changed, 71 insertions(+)
>
> diff --git a/Documentation/technical/multi-pack-index.adoc b/Documentatio=
n/technical/multi-pack-index.adoc
> index cc063b30be..ab98ecfeb9 100644
> --- a/Documentation/technical/multi-pack-index.adoc
> +++ b/Documentation/technical/multi-pack-index.adoc
> @@ -164,6 +164,77 @@ objects_nr($H2) + objects_nr($H1) + i
>  (in the C implementation, this is often computed as `i +
>  m->num_objects_in_base`).
>
> +=3D=3D=3D Pseudo-pack order for incremental MIDXs
> +
> +The original implementation of multi-pack reachability bitmaps defined
> +the pseudo-pack order in linkgit:gitformat-pack[5] (see the section
> +titled "multi-pack-index reverse indexes") roughly as follows:
> +
> +____
> +In short, a MIDX's pseudo-pack is the de-duplicated concatenation of
> +objects in packs stored by the MIDX, laid out in pack order, and the
> +packs arranged in MIDX order (with the preferred pack coming first).
> +____
> +
> +In the incremental MIDX design, we extend this definition to include
> +objects from multiple layers of the MIDX chain. The pseudo-pack order
> +for incremental MIDXs is determined by concatenating the pseudo-pack
> +ordering for each layer of the MIDX chain in order. Formally two objects
> +`o1` and `o2` are compared as follows:
> +
> +1. If `o1` appears in an earlier layer of the MIDX chain than `o2`, then
> +  `o1` is considered less than `o2`.

For sorting order, 'less than' doesn't tell us if you are sorting
smallest to greatest or greatest to smallest.  Maybe "less than (so
its order is earlier than) `o2'" ?

> +
> +2. Otherwise, if `o1` and `o2` appear in the same MIDX layer, and that
> +   MIDX layer has no base, then if one of `pack(o1)` and `pack(o2)` is
> +   preferred and the other is not, then the preferred one sorts first. I=
f
> +   there is a base layer (i.e. the MIDX layer is not the first layer in
> +   the chain), then if `pack(o1)` appears earlier in that MIDX layer's
> +   pack order, than `o1` is less than `o2`. Likewise if `pack(o2)`

s/than/then/

> +   appears earlier, than the opposite is true.

s/than/then/

> +
> +3. Otherwise, `o1` and `o2` appear in the same pack, and thus in the
> +   same MIDX layer. Sort `o1` and `o2` by their offset within their
> +   containing packfile.
> +
> +Note that the preferred pack is a property of the MIDX chain, not the
> +individual layers themselves. Fundamentally we could introduce a
> +per-layer preferred pack, but this is less relevant now that we can
> +perform multi-pack reuse across the set of packs in a MIDX.
> +
> +=3D=3D=3D Reachability bitmaps and incremental MIDXs
> +
> +Each layer of an incremental MIDX chain may have its objects (and the
> +objects from any previous layer in the same MIDX chain) represented in
> +its own `*.bitmap` file.
> +
> +The structure of a `*.bitmap` file belonging to an incremental MIDX
> +chain is identical to that of a non-incremental MIDX bitmap, or a
> +classic single-pack bitmap. Since objects are added to the end of the
> +incremental MIDX's pseudo-pack order (see: above), it is possible to

drop the colon?

> +extend a bitmap when appending to the end of a MIDX chain.
> +
> +(Note: it is possible likewise to compress a contiguous sequence of MIDX
> +incremental layers, and their `*.bitmap`(s) into a single layer and
> +`*.bitmap`, but this is not yet implemented.)

"`*.bitmap`(s)" feels slightly awkward and only saves 2 characters.
Maybe just "`*.bitmap` files"?

> +
> +The object positions used are global within the pseudo-pack order, so
> +subsequent layers will have, for example, `m->num_objects_in_base`
> +number of `0` bits in each of their four type bitmaps. This follows from
> +the fact that we only write type bitmap entries for objects present in
> +the layer immediately corresponding to the bitmap).
> +
> +Note also that only the bitmap pertaining to the most recent layer in an
> +incremental MIDX chain is used to store reachability information about
> +the interesting and uninteresting objects in a reachability query.
> +Earlier bitmap layers are only used to look up commit and pseudo-merge
> +bitmaps from that layer, as well as the type-level bitmaps for objects
> +in that layer.
> +
> +To simplify the implementation, type-level bitmaps are iterated
> +simultaneously, and their results are OR'd together to avoid recursively
> +calling internal bitmap functions.
> +
>  Future Work
>  -----------

Should the patch also remove the first item from Future Work, since
this series is implementing it?


> --
> 2.49.0.13.gd0d564685b

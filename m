Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6905F1A264A
	for <git@vger.kernel.org>; Fri,  1 Nov 2024 14:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730471143; cv=none; b=MLxWZvjph0cRJyGaARG4XwffVntquND93zDX+UElYPnwHXp3NlcGwMfVbYdO7qZHS5DeYMr0iBroVSVEtf4a+HQ9dJmYQXtJfIpSTgHokDUuprXdIX79gIA2pGp2BZc24RduXIl52kpvUx+8KEIlEr7bIY1jIGfOLVKWOnBRzZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730471143; c=relaxed/simple;
	bh=M7oLKUU+e5jh3VBjDVS7ZhUICRoPnAqbS55h65yNt/0=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wxg77cZ+wkyV2pFLrLODzYMdRy6yDEmtJ9HHo4r0WwERdBWgqBgW2nFZ4h4gO0nwVo65CuN8iDO1wB1XWVSid2gx7KLBi6nf3wjBkjh+h0w+wd6IhgbM81CKjAXfQ9xCXt+G1yN2yzsNaHcKtevDML8BWjJO7wXT/iFcWRv35ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CN2sb+mY; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CN2sb+mY"
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5daa93677e1so972346eaf.3
        for <git@vger.kernel.org>; Fri, 01 Nov 2024 07:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730471139; x=1731075939; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=r42/G5bHuG9mU6zfSfACvLj+BTVHfk9aS83c34tsJZo=;
        b=CN2sb+mYtr1+hmJHfQjpcx9DWKmIfheYMuDXVeiU/ODCQg5UIUCv0aUSqBHQIO4idn
         XQucM8dVt7mllTTD4lgJ72z7qHX5nlWUkeLrJYbI9MivBSm2M9VMj3hfIAq8NqH6Insw
         u3ahAV1kP8Xfg/i5R3YqHQNJDwnYOLkS6QtYANR+/sbWSHQtTnxeomt4D4Xjf/F8eW4q
         czPSdDNYcJ08EOnhzZeSF6dKLnsAn4LqjzChzyJTVlyaKCXYakZERWDdDBeGWXnU6Hg+
         JGD+io7G6r7OaBpJE82kA4uAH5miE39wtPJhMvfrOZSVyPLgiPuiNywBBd6un+pOQkrK
         zoUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730471139; x=1731075939;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r42/G5bHuG9mU6zfSfACvLj+BTVHfk9aS83c34tsJZo=;
        b=AZx9J+DGqDXNraBjGZYT/L2o+mM3LGMZuqTUUwpHfirk8Q0/TBmIcD99Vf5ckScdiW
         v+VolDYOQ3cwmT0488T+/6E/sdwku9ZBOSQYi0TDrIxsf35lFuJBbi7ETqIaRYfaZbTq
         L8QYHRZOvc0UYtenzFNcnceVIiAjgg2o9M/nAuwvtgyF0aZ+XePcmuAAZdZUfeVVSXc5
         Blzj1v6OIVT7YIQIxYHcT5mq0LWmjKMFLxqw3fQJziNvkr454PHGqXlNgDbe5eBVt5jp
         evmXBTiq2MfyD4AzMDrohgMIi834ROV2R5e+B5+YrEqC9AQGeNwdrNybZujmkpQ/uyVe
         B+wg==
X-Forwarded-Encrypted: i=1; AJvYcCW91raqqJjToWpzcScS5iuSoXtH+DznuTdxHVV9GrsWch7/biRhEDg8UjGqMPe6eqePx/M=@vger.kernel.org
X-Gm-Message-State: AOJu0YylXQIALsLqenzm+4ifqnqguDRJuJqeTRZqrWm5w9CSLmhuw15/
	fPeBNdobE5SlYUHXOOQBWVdNNrugae+wNmE0yZIyMrAF8YMp+cqzWumNEUBvqo2fxFzwHFHYN3o
	Gn030Ta7ut96sE8YBi90xn92cB60=
X-Google-Smtp-Source: AGHT+IEXx+zyTQ/ZL6/ga6T+2WpV3Sksy8plTbS/7tI8NgYiCF2qfQnWtloG/tpfElWSu53t5kbLowvofuV2nRtNWek=
X-Received: by 2002:a05:6359:4105:b0:1b1:acd5:dd98 with SMTP id
 e5c5f4694b2df-1c3f9dfd566mr1201923455d.7.1730471139280; Fri, 01 Nov 2024
 07:25:39 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 1 Nov 2024 07:25:38 -0700
From: karthik nayak <karthik.188@gmail.com>
In-Reply-To: <3dc27658526784edf46f67661d1161a8eea3ea0a.1730356023.git.gitgitgadget@gmail.com>
References: <pull.1818.git.1730356023.gitgitgadget@gmail.com> <3dc27658526784edf46f67661d1161a8eea3ea0a.1730356023.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 1 Nov 2024 07:25:38 -0700
Message-ID: <CAOLa=ZR1BjKzujxpA2icAfJHin-krqwkxTf5VPeGg14AVr-TcQ@mail.gmail.com>
Subject: Re: [PATCH 5/6] path-walk: visit tags and cached objects
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc: gitster@pobox.com, johannes.schindelin@gmx.de, peff@peff.net, ps@pks.im, 
	me@ttaylorr.com, johncai86@gmail.com, newren@gmail.com, 
	christian.couder@gmail.com, kristofferhaugsbakk@fastmail.com, 
	jonathantanmy@google.com, Derrick Stolee <stolee@gmail.com>
Content-Type: multipart/mixed; boundary="0000000000008e05ba0625dab52c"

--0000000000008e05ba0625dab52c
Content-Type: text/plain; charset="UTF-8"

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Derrick Stolee <stolee@gmail.com>
>
> The rev_info that is specified for a path-walk traversal may specify
> visiting tag refs (both lightweight and annotated) and also may specify
> indexed objects (blobs and trees). Update the path-walk API to walk
> these objects as well.
>
> When walking tags, we need to peel the annotated objects until reaching
> a non-tag object. If we reach a commit, then we can add it to the
> pending objects to make sure we visit in the commit walk portion. If we

Nit: s/in/it in/

[snip]

> +		case OBJ_BLOB:
> +			if (!info->blobs)
> +				continue;
> +			if (pending->path) {
> +				struct type_and_oid_list *list;
> +				char *path = pending->path;
> +				if (!(list = strmap_get(&ctx->paths_to_lists, path))) {
> +					CALLOC_ARRAY(list, 1);
> +					list->type = OBJ_BLOB;
> +					strmap_put(&ctx->paths_to_lists, path, list);
> +				}
> +				oid_array_append(&list->oids, &obj->oid);
> +			} else {
> +				/* assume a root tree, such as a lightweight tag. */

Shouldn't this comment be for tagged blobs?

> +				oid_array_append(&tagged_blobs->oids, &obj->oid);
> +			}
> +			break;

[snip]

--0000000000008e05ba0625dab52c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: a4977b06d5cd6fa8_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ0FBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1jazVONFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mdzZ6Qy85c09LczBvL1RrT21XNlhmVEVITk1JK1RoaApKbno0UUk2RnFK
UTNCNlpMRlNIK1pjK2dvNXBLYTVKTmNoTXA3b0NUajlIWEEvUFVPMHlCdGplU1ZMSkdrOEI2Ckdp
UDdBbmF3MmNmNkJUMmRxWHNDWmhOd2hNY1grK0QwRms5VEFBS3ErdWdwbG1FVEhPZFJvNUVzbUFl
cCt5Uk0KT1lrN3haUm0zZ0M2dE9XODYyRXp1UFFNczc5bWJZbndLSGZ0a2tyZ0gzVHZYL3pWR2dH
ckROY0o4TFh1aksvagpGYmVQVmw1ekRBdWVTNzNPbVRhNFJsa2ZpUGpFdjNDeHFCZHRaRHhIQ3hx
c1RZVGZncXRya0VJQkZ4bVJNZ0FICktSQXRLQXVia09tRjZJSU1tVWJHYW5VMWcrRVY2YmxhU2ow
UFp1azEyNWx0cGJBR0E5YlRyZ0pFV1NQaWR6QmwKRWV2TjJ2OTNNeWlZVzVqTGhCbGFXOGtsTDVH
ZUhuVUFaMHFEdFZVSU4xdmdzdFoybDFpcmZVOVg4dUxyZ25ySQpoWWxnMDVDRFprK05Tc3dLZDUr
SmJmL2Yra3dtWllHblV5akhRTUFtZFZNckw5YnNyVEVwNDNJSllLTDBGV0RDCjRYUjdnaGN0RGJ3
amxXS2U3VGJlVEJaYUJVaGNjNmZRQzdxcjcwYz0KPU5pRTQKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000008e05ba0625dab52c--

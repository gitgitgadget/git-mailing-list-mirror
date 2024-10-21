Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27211C32EC
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 15:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729525087; cv=none; b=i5+6i2/WToZ7brKlwYp73vrzz9kIeAyB+wjS0PsMoHHi4ygSPn60cxuV3m/G0M6nwKShuij2BPvK1ThReUzoEQSOR4NflslTDKK1zNbgEgPlUKFkazWTMvnTQW+MUJCjROfHkJq4U8N6Znfn0Axc6N4LW09pLDSVrXVDXh7vj9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729525087; c=relaxed/simple;
	bh=YGZSXgjFNHmueFffYvi8GBROawQ5X1pWQBFBvuQpokY=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j9vKKDINA+g+MmhnB3mlm43xG1YaGRsiUI4tAL15AW9KTWhq0QiLljQG3ieO1bE/bvonIgkQEsOTquDvqMUaKid978qwOCOqjLfj8ynRbREYmA2rJKwyG3t6RPJzY7h93Qe+/UszNueuK3aR73gE3j6ICOfF++AhQBxzD+kkq5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X4/1ynCQ; arc=none smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X4/1ynCQ"
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-4a47dc2ef46so1186721137.3
        for <git@vger.kernel.org>; Mon, 21 Oct 2024 08:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729525085; x=1730129885; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=1KP1lzZpiEcAzvZei1ehVxjbL1NxEYWK7FyLxVeBHPE=;
        b=X4/1ynCQBK34PCbBk6EtX41F5JOrLQ+99Yvgekt+crG4kAYAWkbh2JGt1yjzVBu3cp
         OqEex/eJYJAVxiOmqUJ6MKxQq0I8IgsqAK7A4VUM4hhZ9mu72g1RtyvRaeUwdHo2r557
         nzgLb48jl+uT+9f59GjRoJK+rbso6EbXTnNfMnisaPIEJYRKtzf3VMKVZ+gKSZw7UTh/
         SdVbAV/GCNqSalXson8CScgYgMKnJi75eQ0vb0BJ4yhpGXZXnT1x4VxncXH0dkeVe7hY
         LehQWV3/UrtoYMS5hHTn8qeytAUewyzwBnoYQNkUZJvP66Z6rQD52xWyxl4wdlETrif2
         qYUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729525085; x=1730129885;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1KP1lzZpiEcAzvZei1ehVxjbL1NxEYWK7FyLxVeBHPE=;
        b=VQVWWfXZ4I9AJ8WQ+gx1QR5lmpAtJw4+5TuL0Diuuw6XFY7aHy3BsIj4q0y+SOZSPl
         SJ5e3dGFeaHH0xxdqLncumMaFQJj1zcAX1kaeMc/S/e8IFkjKmIUAIMM0VfMpAFmvZsr
         XX6oWR5q1WQ8AvsiuE0N6OZHYhsz6udGq6nj9zPL5tV/FN9KIvS2hXEcDTucGx6zZpdt
         3c+8yzV1yncQDkvm31EmvXwGa+5+uf9wpIij9sKYAKPnq4dDJcki7dqAzYt/hrb6YjD/
         ajaVYQG626UxEJvxrqbQUQyj2RlbK1j2hPFM2C3T3AjFJizOUpnNLX7gHCC74cLJnz9p
         jcZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVkxOM0jLp52INZoRZGM0NnrIwN/Rh+7zLwL25efRG2p3xCly0vNBBU5YSDCmHx7qMWzjQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwM6TRlVlEQpC0I5NxtDxq0PIz3+pzBc81/qzkp1SR8YG3zrZxB
	t6v3bwE7b0yLEqGj2G1XaNKWG89CBzW1TrLllxM744CxYte0+6GY23jlO7ucUBNEV99dnqqMfhq
	u2pLFsQxZQXtvK7cAzwF7jT1hkgQ=
X-Google-Smtp-Source: AGHT+IHVQ9/isYNqdW5kTGA4BqrdkUA0Pi6ErOBZH136e7lyZ0ePuMbap0eDxiUh2P3BqP3xNGUL2Zne/kBlzfxjcoU=
X-Received: by 2002:a05:6122:200f:b0:50c:9834:57b3 with SMTP id
 71dfb90a1353d-50dda1c2ae6mr9261642e0c.4.1729525084688; Mon, 21 Oct 2024
 08:38:04 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 21 Oct 2024 10:38:02 -0500
From: karthik nayak <karthik.188@gmail.com>
In-Reply-To: <ZxZYXpuCD2I_3bNh@ArchLinux>
References: <ZxZX5HDdq_R0C77b@ArchLinux> <ZxZYXpuCD2I_3bNh@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 21 Oct 2024 10:38:02 -0500
Message-ID: <CAOLa=ZSoB77JvuEJkWLL=eiDTsKysM8sxcYddUEbTSt1LziY1A@mail.gmail.com>
Subject: Re: [PATCH v6 2/9] ref: check the full refname instead of basename
To: shejialuo <shejialuo@gmail.com>, git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Content-Type: multipart/mixed; boundary="0000000000004db3cb0624fe7047"

--0000000000004db3cb0624fe7047
Content-Type: text/plain; charset="UTF-8"

shejialuo <shejialuo@gmail.com> writes:

[snip]

> diff --git a/t/t0602-reffiles-fsck.sh b/t/t0602-reffiles-fsck.sh
> index 71a4d1a5ae..0aee377439 100755
> --- a/t/t0602-reffiles-fsck.sh
> +++ b/t/t0602-reffiles-fsck.sh
> @@ -25,6 +25,13 @@ test_expect_success 'ref name should be checked' '
>  	git tag tag-2 &&
>  	git tag multi_hierarchy/tag-2 &&
>
> +	cp $branch_dir_prefix/branch-1 $branch_dir_prefix/@ &&
> +	git refs verify 2>err &&
> +	cat >expect <<-EOF &&
> +	EOF
> +	test_must_be_empty err &&
> +	rm $branch_dir_prefix/@ &&
> +
>  	cp $branch_dir_prefix/branch-1 $branch_dir_prefix/.branch-1 &&
>  	test_must_fail git refs verify 2>err &&
>  	cat >expect <<-EOF &&
> @@ -33,20 +40,20 @@ test_expect_success 'ref name should be checked' '
>  	rm $branch_dir_prefix/.branch-1 &&
>  	test_cmp expect err &&
>
> -	cp $branch_dir_prefix/branch-1 $branch_dir_prefix/@ &&
> +	cp $branch_dir_prefix/branch-1 $branch_dir_prefix/'\'' branch-1'\'' &&

Nit: Here and below we could use ${SQ} instead.

[snip]

--0000000000004db3cb0624fe7047
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 513a20fe79574516_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ0FBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1jV2RWVVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mejJ6Qy8wUnduVnhBVSttR2tvYmNLWWN3TzYwcFB5QQo1TVpoU3hrM2Rn
MTd0ZWVvR0VzZGR5RDNiVFJRbFZHTlhtMVFRMlNEeGJRMUVIa1NoV1VDblMrYkNSVWF3TW5kCnVr
ZWw1N3ZUR212YklQaTFKSVFrL0ZFYk13a05WY0ZZdThveU1IZGdBK2hxcVhjYkkrZnk5U1IyTDFS
ZEpNT0QKYzRHZlhMZG8zZkZwYmRKNXR3b2ZrWmtjdk95K1ZJSEZZbFhVWWZwbkM4NzdiSGVBOGdG
Yk9mUEhHZGt5RzVrQQpMa0M5TmxVaFdML3ovWVdNdnozTmxmZzAvVHVTOTRvYURGb3hCN05QWjlO
RENiZUdqVUxkN25IV3Y3M1lFbUxtCk9kYkg4OWVpQ0wzd0pIN2hVcmRBdkFSYVNNUjdXN2w3bVdC
b2VJTWgvcWpCM2F2ZkhNOVBmU3lBVjB2YWZjYWYKTDI3MkVYbjUxQndRMHZ2aUJRcGxLNXlmendv
NktPeG1pZ01sWXArTStHaDU5S0JQNFBrQjA0bEJpUE5vUHoxNgpVVmV5ZzlXcklFVmJ1VlVZVkpx
OG1yTVNiRjRzSUQwKzdBbzMyOVFYdGxGeER4VUZqaXFBOTVnYVpZZWt1OHNYClF0dW14bnF5TDBv
RWlYVjMwOWR2ejFBUGI4KzlVbVc0OHBCMG9QVT0KPTVmMU8KLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000004db3cb0624fe7047--

Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C70424D74
	for <git@vger.kernel.org>; Mon, 17 Aug 2026 15:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786981442; cv=none; b=R2bW6kY9mA4E8HM6s3GAT1ipv2fq+AfR/ly+TXT26hbsN637lRjQtMQSegXak6SXNxuI0VjkS5M82cB5Q2XBKgEMtPLMA0nZYYkFmlrd4gH/HYQWiEmfBGjVBNxBZ4c9pnY4Nu9p/zQkYeQ+jAZtVX15Lmzv48Ktfn0pLhnsNxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786981442; c=relaxed/simple;
	bh=i4EBGpYKZWIalC7qcY0/xfs7oUtdd42W2vKV0K+9d5Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PMUKBwA4n00r/HVHfgYQUxPNT7J+p3pfkjUoXk+uSUA9ZKpI3ymIhrg5nUBRuJAoGtKnjNfQ38dqwYSAl2h2YLWGWcQBWoNM50tAKeby6qolHKsf/WtfsMOLcH1DjNi+F4qdMXoMiDxsCZixa9ICvd/6bNFoodNVJqN8y8JIVm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=DN02eg77; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kGqd8hGb; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="DN02eg77";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kGqd8hGb"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 9F90AEC0230;
	Mon, 17 Aug 2026 11:43:59 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Mon, 17 Aug 2026 11:43:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1786981439; x=1787067839; bh=ycGNAHKuH6
	RdfrTaoaF4EPIjluuzt6feekr2BstHjXM=; b=DN02eg77deaRHq3niri3sMKvHV
	1NS27bZGKM70u9JWvB+FW1CAIbZ9jzNVO+n6GFPYcTyf87E4kjvtIRacph3dRLlu
	Ul85QHZEHWA8P0HlKRcWuRzLqvVo4ybC221tLde5ltJxv9cE75qr5GjGHTpXAVCC
	ePvVRQ7ittYlDgOkjyg3B6ET+enMMFGnc/tP3Dl3Cf4CF6kuss9S73VWZ4YCI1cp
	+EKaODCpciUxQk8MRfoWC0jaiq+7pPaRwOym80sWNwxWMfn44WdWtSyKt/SlEZYR
	3+rHSAlF2FexM+3+zhx2wIFl4xIzG4FQiEojalEYetxgDtfoERIqlKmf17ng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1786981439; x=1787067839; bh=ycGNAHKuH6RdfrTaoaF4EPIjluuzt6feekr
	2BstHjXM=; b=kGqd8hGbFouXaoi3ZlNYt0XnTNN3WuCjAYG+kVGPQWamSjZXful
	AOomSnQ1anAgz9HImEEvlcSnqUpcbs0VENoWbS6ugS3E5b8M4RTdDiNJRhnHxLTz
	jcAXhBFV2eKGdibt9QGzx+v9Is01ugCBgleFvDK8v672i9ZdntUPf8v9rd5QCZvj
	Kt14MeokvZyes18J2UY9gD7u7prHTfNmxWoKNMaOJzziGeFU0NIc+ITlAc6HRmn8
	GyqrKLVZAhAHL94o3udmjuvmf1QSi45t+ZuUWLE9G6v4aEgloFTZ4XlIFJaZdyJr
	SnnCwwc5VWdA5BR2NLzxoYQyfO6H5yw5nCQ==
X-ME-Sender: <xms:PyyDaoI-JEv8_USiLrKfuh_NmWFEYLjfvD5DRiRCKtutr9DD6pkoHw>
    <xme:PyyDar2q4OFm4jjP4bFqPo0weZTKYgMx5CsxJvxxPejcmDwnPby4cLdehWivrsS2c
    iJV86UhGOKZz68oP0a1aIUEkeKjue33UqPvx8XKLG6-68EXVFAHhYY>
X-ME-Received: <xmr:PyyDaijbDZutqQbQHaqJq1jHijmr8-O7g8-ARH5K3_QUgAxxEYf09XlfoFy1ckLyvwDDPogH5JDK1nWlqxjdpYZyUpnVOUj2Mg>
X-ME-Proxy-Cause: dmFkZTF/B5l+qINxmobLY4KBOJsNSuKgGOmdlsqrGXUJtC61N1SZZLJWNa/Flgte8jpdP2
    HaODUmZMIXlEQTqZabxChYsjSk2AK8QWCaFCLf6uENBP/6M5t0vI5qnet50fKNP8wqzv8C
    hwXRgs9TxMkTod1v5ewZaMkAw4mAmTJZeFRAszfm/FizZT3YM7vUn09w0FpfLShkyA/2d0
    NTKfFyl3t8b3b2oLncUuOpscuvmhHw3jKCbkwGpEfHHlNe8t3xaer99LPXdANszATmn9pH
    3eiEwXj6+i1XabBHG/wBUOcwkmZILNnf+3o3uXkdPH3RoqiL8jBv93abrzbKJ+6JI+J3hP
    LwcrNjpSmSzk8/LomGr3ELT9tmSzDX9QBIVr1DIAzg25GcOYKTSw31yT/UZyTnznsDQONl
    a8xPPq9Ylsw5da1D+oVyXZp02Nag66NhzSKcFzdmrtz+n8zp5CMK9w8w9KwrDw2Vp0yjmY
    hzZ8f78d6+/OnEWA8G+1rc2JZ7j3LVgpxLFJ56gKnSf3KmwsOFQRLYEIlSUNVLkvcFLPn8
    R1n6MtvIw9057MFkdFMuquhZ/6rjB3XIcKkR8pUzWYynMtTa6I3kNHL2HuIB+qZoQ+OgmP
    ZiwJ6bYIRFJAB/V4qm/qQkhLDl7BCmGLLIKvyKoaWyado2252bvSXg5inX7Q
X-ME-Proxy: <xmx:PyyDasWvmRTn3I8AeO3eqMOgmQK-ZvbO6EY6kyBIlrOLZcxELJO-Wg>
    <xmx:PyyDahWkbB-a93Mkh6enYmVVtqGbxgzQR7mpC7asfXUOtb0ZgQfbzQ>
    <xmx:PyyDasjZOAV8kZUvSax4bpeK1F1uejyZ2XFOY9djWC_HGX4v6WgWDQ>
    <xmx:PyyDasbgRo-sFRvwcB_3-3NLnuAxjOFLk3qSRL7Gq_wmQplKxwlslQ>
    <xmx:PyyDahcNjxtyaBVvXB_fgrJn2-O22T853nlcT2im6BjwtHRvNYrmB9Kl>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Aug 2026 11:43:58 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Shlok Kulshreshtha <diy2903@gmail.com>
Cc: git@vger.kernel.org,  l.s.r@web.de,  Johannes.Schindelin@gmx.de,  ps@pks.im
Subject: Re: [PATCH v3] object-name: avoid use-after-free in
 get_oid_with_context_1()
In-Reply-To: <20260817082127.81132-1-diy2903@gmail.com> (Shlok Kulshreshtha's
	message of "Mon, 17 Aug 2026 13:51:27 +0530")
References: <anltEAohp3F9Jbx5@pks.im>
	<20260817082127.81132-1-diy2903@gmail.com>
Date: Mon, 17 Aug 2026 08:43:57 -0700
Message-ID: <xmqq1pbw7nwi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Shlok Kulshreshtha <diy2903@gmail.com> writes:

> When a ":<path>" argument names a relative path, resolve_relative_path()
> returns a newly allocated string and "cp" is pointed at it:
>
> 	new_path = resolve_relative_path(repo, cp);
> 	if (!new_path) {
> 		namelen = namelen - (cp - name);
> 	} else {
> 		cp = new_path;
> 		namelen = strlen(cp);
> 	}
>
> From there on "cp" and "new_path" name the same allocation. Later the
> memory location that "new_path" points to is freed.
>
> 	free(new_path);
> 	if (reject_tree_in_index(repo, only_to_die, ce, stage, prefix, cp))

Nicely described and ...

> diff --git a/object-name.c b/object-name.c
> index 83efba0ba6..026ff8c6dd 100644
> --- a/object-name.c
> +++ b/object-name.c
> @@ -1803,13 +1803,15 @@ static enum get_oid_result get_oid_with_context_1(struct repository *repo,
>  			    memcmp(ce->name, cp, namelen))
>  				break;
>  			if (ce_stage(ce) == stage) {
> +				int ret = reject_tree_in_index(repo, only_to_die, ce,
> +							       stage, prefix, cp);
> +
> +				if (!ret) {
> +					oidcpy(oid, &ce->oid);
> +					oc->mode = ce->ce_mode;
> +				}
>  				free(new_path);
> -				if (reject_tree_in_index(repo, only_to_die, ce,
> -							 stage, prefix, cp))
> -					return -1;
> -				oidcpy(oid, &ce->oid);
> -				oc->mode = ce->ce_mode;
> -				return 0;
> +				return ret;
>  			}

... the fix matches exactly what anybody would expect from the
problem description, i.e., "Do not free new_path before we are done
with using cp".

Will queue.  Thanks.

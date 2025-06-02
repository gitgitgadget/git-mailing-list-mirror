Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C14691DFDAE
	for <git@vger.kernel.org>; Mon,  2 Jun 2025 09:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748858035; cv=none; b=U3dlIDE1eo7wb9zGQKrlp0T8rU6m4D9X8HoX7SM1odDxkg7pz+Dgfbtkxb17U24i+fnV1UAoSjjBdeXYZ3vnPN4q5E/UftSBK/o3NgiCOJi9ouXgxtnBm63iuJ0R+t3bkRCfGl0u04moU2DL7xaLJaz++FwKirAi144YBt2TBko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748858035; c=relaxed/simple;
	bh=8K4ZcCMVZR9ORNB4dNw94g/7CL01HJz6emCURXPuGNg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UhtgURSsf5Y0UoQRWHM47RgEuhDnjlBQskERrDkY7QiEbdBiLdb0HBJVh+Ph8Z1Uyu1Me37XGimjgNgbxENH2umSQ9EFE/B7gyQ1Ltcvre9+GfVsdhXY1pQA5TaX2xRGL/jHNg74723Mt7alXyPx237bQvwBSForkk/eylWcb34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YGbRM65u; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YGbRM65u"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-450cf0120cdso34314975e9.2
        for <git@vger.kernel.org>; Mon, 02 Jun 2025 02:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748858032; x=1749462832; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=sBWHRDGaPpO5WwEkY8zf4Qx5og6rPK0RhSNRs0lnab8=;
        b=YGbRM65uyYysCUjzFJXoXbHVSbEUKPDgBizt5vU5vrElSQGcgaM294foSAtqjjzn5N
         gGJpfDuDmXcUPd1UfOJ/UiqsArxqOn0jRNTcvbwn2sk10GzgLuLYRTZ55ujoxloIWMtO
         1ZnImMwHkq27pHXktAgE8faYjk4m8SHsmf4Q/cQOyhq/OAQOJQTYVN2NACUBEcNW5k/P
         8FP96ee3KwKwRBPQ67ppjHGsaHHsnCYsvjBsqGCoZXFUFw3LJrorDezec3xVjzeZOeBG
         TK/mXXI4bd2nNt4RZPkW9ZR5a0nT76YiwwGKH/bc4LY3C0Mwrsb4UOOXNI3lRPY0zURh
         9JSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748858032; x=1749462832;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sBWHRDGaPpO5WwEkY8zf4Qx5og6rPK0RhSNRs0lnab8=;
        b=ZFn/76iQeYhVvY2JevydVf6Ug1tluSrXXVxUYX2kiyWfsLtf/17lpaHzPOb3yQ0xbI
         qXgGla+IVjxgsyIHCuxencBRNiMEbz0V6SwEo69ifwpG2zKlKLvkxoNYbRdfY0hh+fKx
         0QgCxPozSSvBmBP8wU4+w1DHweS4hBe+TmG8Y8VMBTv56Z5Y34DR19i/K0basOwVHZ1Q
         DWMc+Ca/WGBZPeRwqWe4A/27RPZUTDnSXYajleKwMqLpuW9bT15NecXGBH5byDJzpngZ
         4NgTlLUhLyfMaca7DUCghJTEGKZoDolBau6itvCpRkflDoP/3uKcfZuz9k/DVAFm8rM6
         j8mA==
X-Forwarded-Encrypted: i=1; AJvYcCUjN/K1mQtK3RiyCXeGiptA+RtRKENJc4HMEBoceU7bD2A3Vb0ME40+yzhaNz2NdGJ14G0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvEkGfFy/WsXq2ofobRBs/Ux24TRmfTO7T1ulpnP57Pny8D/tp
	CxS/uy6tsfdBMOmfaw0s2SnqingCWHdmZotO7dwGRobeyQcxLQMoNUIz
X-Gm-Gg: ASbGncuhTzBMKmJ086a/tI7Mq2gFisqR7NHQpoMF1Um0WSiF3nO9MpMo/a6vsceKCfg
	PTLlxj45EkVLPacuB9S1Pp63yCxp/osBZSkO+3/gZge1zGLS1ZNC8M562QmShRA+GIDyEe3p0CX
	WPZd5R5UNd2a8H/Ow5kPF0iaQQfvHFPQRrZyJEgXt/N3PwVDLmjVwGIwMszlAb/dftzMSXDREDk
	vMhMthR4elHkiQvWAtnXgYbMfFdXBfB38Xw+oyaib32DFwfJIfHS0i5UNMk6sAy3DnNf5JAYYl1
	tlhdHdryVT2WqsonkceCQhCyZih+4WcAkT2PVxpZsTQIE9CcoPm4fV6NNopCAdJrJiCCNZlfrXf
	Sbz7qfQKR2vkUZCuSf0G3jMCJ3wNRpWT6pnUBTg==
X-Google-Smtp-Source: AGHT+IH4okaDQ1hkAfGGVeU3jsSObvDED1PneLXRMAQ7PFbEOqRJGNX4LWBqx0K8DK3te7nq/h0srA==
X-Received: by 2002:a5d:5f94:0:b0:3a4:bfff:8443 with SMTP id ffacd0b85a97d-3a4fe183820mr5606908f8f.25.1748858031710;
        Mon, 02 Jun 2025 02:53:51 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:20c3:eb2d:481:4a64? ([2a0a:ef40:700:a501:20c3:eb2d:481:4a64])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4efe6c738sm13921826f8f.24.2025.06.02.02.53.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Jun 2025 02:53:51 -0700 (PDT)
Message-ID: <b92b5d93-7f7f-4370-ac79-7d9767bb0db5@gmail.com>
Date: Mon, 2 Jun 2025 10:53:50 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] fsck: ignore missing "refs" directory for linked
 worktrees
To: shejialuo <shejialuo@gmail.com>, git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
 Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
 Eric Sunshine <sunshine@sunshineco.com>, Junio C Hamano <gitster@pobox.com>
References: <1d8f471b6dcb7e952afea834490be195189492a7.1748629208.git.code@khaugsbakk.name>
 <aDp55upE6AhYunz7@ArchLinux>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <aDp55upE6AhYunz7@ArchLinux>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Shejialuo

On 31/05/2025 04:39, shejialuo wrote:
> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index 4d1f65a57a..bf6f89b1d1 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -3762,6 +3762,9 @@ static int files_fsck_refs_dir(struct ref_store *ref_store,
>   
>   	iter = dir_iterator_begin(sb.buf, 0);
>   	if (!iter) {
> +		if (errno == ENOENT && !is_main_worktree(wt))
> +			goto out;
> +
>   		ret = error_errno(_("cannot open directory %s"), sb.buf);
>   		goto out;
>   	}

I think it would be clearer to write this as

	if (is_main_worktree(wt) || errno != ENOENT)
		ret = error_errno(_("cannot open directory %s"), sb.buf);
	goto out;

so that the condition that triggers the error message is explicit rather 
than having to mentally invert the condition to figure out when we 
return an error

Best Wishes

Phillip

> diff --git a/t/t0602-reffiles-fsck.sh b/t/t0602-reffiles-fsck.sh
> index f671ac4d3a..615b7c0683 100755
> --- a/t/t0602-reffiles-fsck.sh
> +++ b/t/t0602-reffiles-fsck.sh
> @@ -110,6 +110,21 @@ test_expect_success 'ref name check should be adapted into fsck messages' '
>   	)
>   '
>   
> +test_expect_success 'no refs directory of worktree should not cause problems' '
> +	test_when_finished "rm -rf repo" &&
> +	git init repo &&
> +	(
> +		cd repo &&
> +		test_commit initial &&
> +
> +		git worktree add --detach ./worktree &&
> +		# Simulate old directory layout
> +		rm -rf ./git/worktrees/worktree/refs &&
> +		git refs verify 2>err &&
> +		test_must_be_empty err
> +	)
> +'
> +
>   test_expect_success 'ref name check should work for multiple worktrees' '
>   	test_when_finished "rm -rf repo" &&
>   	git init repo &&


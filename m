Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8885F18A939
	for <git@vger.kernel.org>; Mon, 28 Oct 2024 16:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730131739; cv=none; b=HpASj9cG3jfRs3USH5rg1cqyf0PF5EipjyX7nEQIzf6MTpaKcjqsUHxeFSHnBzmNdMfE3xHd1i43i4+zJh9qWljm8sYFN5gl9MjQUSyqUStdPoIt95UrHgVSpnnV89d0RQ2fMtbPQQXVUWX7obWMbrFcC63+WxAoiqO7+iHaFTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730131739; c=relaxed/simple;
	bh=yCjFjldUk78ntmbFOy3MffSqw0HTNMIF0251DTihqCw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XnLMzdB44ydnAaYswtvsOPDiu9r1EVr5xDePrNYWgZyuBmbuAK7y1gm1YElTz2N3/7OkfuR6A15BHUFGgUZuHpz5ZD4MkKGymPx7sLl23LYVldLSJF3HoiHYxzYaIwJosrkW2ZFkafS9w4pb5l98Wt7vbFHQ6ikbX5EXUs/BMUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=NJVnxHhU; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="NJVnxHhU"
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e2e444e355fso4049072276.1
        for <git@vger.kernel.org>; Mon, 28 Oct 2024 09:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1730131736; x=1730736536; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=t3Lbe1lllJwwqrg1GjlCv48+2aNrjrrbEcohEQ1RSPs=;
        b=NJVnxHhUBkzI4enefqiVSZkqdyt+5AVC7/+W6B+MfwA7314CTzTUuv3JJWH86FbvxO
         XOLPvqp61SXEV5AQAKs9VSAj7lJsa4fKiX7XqvnD17NMVl7VjqMwJn+jkJPDW/TVUTbO
         Wpks8+Kg9m6Cwwjpe4YTHI9jTngy2of2xIhZZAWM1vPqGBvS8FQSK68/geg1pdKX7OEE
         2U049HzJPpimGhYUoc3FsLvQXS7pXwemJ0WQvO7TCmwXYIPMsyFyxdMTEQq23csbwMET
         o4M7K0f6cyb61Ke0eZbuY+cmzcIxPkXlCVgO5+MIEOiVq0jvO1MpIOygDu5Sxp/GJorz
         Ekvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730131736; x=1730736536;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t3Lbe1lllJwwqrg1GjlCv48+2aNrjrrbEcohEQ1RSPs=;
        b=HQqe8ZWjd5WSMduAajvvqf2vIaU/OZeHe0Tn/fo5pCh0yb+IPR6Buv/mX7nmRLOA0B
         8CxqzgbqPGGARVmvtL+Q2Z7xGxJSB1ZgdfkQcaVVJ1hRImGwZqRZ2OO1n3nAxGG6sA/j
         D9kyTKpguHuy9DjctCpjDLffYvaI/NKm8/QrVo1tULkL5lYiKhKy23d62+u4Qly+fQZ7
         c7fcbBg1S69RR3xJ7aWF0CyokKhT+CDGKpzXmgsI3eTpqiuNwgB3998qBl+3ZYdGP6wm
         FJ74b9JBjs3rNFARm/kNne9uGBTi/Hlj7wbpVoWr6PeCEGrG/vS6DhBkf/dEXtjA8dcY
         7bNw==
X-Gm-Message-State: AOJu0Yw1w6x2eeLr5bgduoJKJSc3OIzswZMasj3ugAVoqIvoA5jw5hs7
	/y6zb5d3T2RPoi32t86/cUdjnypVJflSL/8urqLy4f/mBgNnXC8WYjuF5m1Nosk=
X-Google-Smtp-Source: AGHT+IEHrLEVRi2wTttdMrnKBawyUqPHALyQUvQoJfs63QVtO0rrQ6owJQl8hJroNeg5Yr7ZMfl2wA==
X-Received: by 2002:a05:6902:1147:b0:e2e:3301:6dd3 with SMTP id 3f1490d57ef6-e30bc64994fmr136320276.17.1730131736454;
        Mon, 28 Oct 2024 09:08:56 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e307a01d539sm1472483276.49.2024.10.28.09.08.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 09:08:56 -0700 (PDT)
Date: Mon, 28 Oct 2024 12:08:53 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 2/8] packfile: use `repository` from `packed_git`
 directly
Message-ID: <Zx+3FZNzwe6V159m@nand.local>
References: <cover.1730122499.git.karthik.188@gmail.com>
 <ca033556866cbb6cdff49507eb27ed5ef57cf44f.1730122499.git.karthik.188@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ca033556866cbb6cdff49507eb27ed5ef57cf44f.1730122499.git.karthik.188@gmail.com>

On Mon, Oct 28, 2024 at 02:43:40PM +0100, Karthik Nayak wrote:
> In the previous commit, we introduced the `repository` structure inside
> `packed_git`. This provides an alternative route instead of using the
> global `the_repository` variable. Let's modify `packfile.c` now to use
> this field wherever possible instead of relying on the global state.
> There are still a few instances of `the_repository` usage in the file,
> where there is no struct `packed_git` locally available, which will be
> fixed in the following commits.
>
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
>  packfile.c | 50 +++++++++++++++++++++++++++-----------------------
>  1 file changed, 27 insertions(+), 23 deletions(-)

Very nice, and indeed much less disruptive than the RFC version of these
patches. All of the first few transformations look correct to me.

> @@ -751,9 +752,13 @@ struct packed_git *add_packed_git(struct repository *repo, const char *path,
>  	p->pack_size = st.st_size;
>  	p->pack_local = local;
>  	p->mtime = st.st_mtime;
> -	if (path_len < the_hash_algo->hexsz ||
> -	    get_hash_hex(path + path_len - the_hash_algo->hexsz, p->hash))
> -		hashclr(p->hash, the_repository->hash_algo);
> +	if (path_len < repo->hash_algo->hexsz ||
> +	    get_oid_hex_algop(path + path_len - repo->hash_algo->hexsz, &oid,
> +			      repo->hash_algo))
> +		hashclr(p->hash, repo->hash_algo);
> +	else
> +		memcpy(p->hash, oid.hash, repo->hash_algo->rawsz);

This should be:

    hashcpy(p->hash, oid.hash, repo->hash_algo);

instead of a bare memcpy().

Everything else is looking good.

Thanks,
Taylor

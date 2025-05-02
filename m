Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72102225A29
	for <git@vger.kernel.org>; Fri,  2 May 2025 23:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746228865; cv=none; b=G3F869TrHkwIgebH7ztdHt3L2CiWmN6IwqaexKgJNaKRby7BWiabpXp5vABPJD0fDCnXFVNOE+h5mI+tzjKELW+Kwo7u/T4oGFhFfBjBCBnQvK4gOGE2LjvdiCJ47A4vxdPmn4Uy6MC7aedx5kcX6u6rNcR+OSR6osFVnW1BmYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746228865; c=relaxed/simple;
	bh=LHukUnLVwtp2IpqYC/mJq8HFCgWdmud/mNI47FBLpHA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YNK/986JevXDD1xW7lvZeyHg6hPtpQ9rkiabzVYH3J91L+1twoZ6hf1lhGFZadi1jMf+GNd0a1BeVGxv9/h/eftGu8EcVDBMeZOyG/n7KmaNpw6Jey4OChwEKNaFwJ5+BpmS53FLEzNu92fFMNp0UYwdagZfYm995hR/JeAU2Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=oUfNm+tH; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="oUfNm+tH"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7c9677cd6d7so304981685a.3
        for <git@vger.kernel.org>; Fri, 02 May 2025 16:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1746228862; x=1746833662; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=h9xWYhOGMYJuYx8H/NT2qH8lGF6+JKzDd2d1LZS9mw8=;
        b=oUfNm+tHkPGRbjNYAE1GIMzY5xtF5JpkEahq5LOxMS/p90fOXUNerXStWmDbUZ03zn
         +3hS4AjIklvqYgkzTto0H4yonNm3FloaibXWdgNId4eNWXrUXJmPbOwlyueVK8Qzrd7W
         ZmEFwAd2/QiVclNjVVJWNZnrSeBtWlwweeNcOLpcW8MBjH4mAlz/SaRY9K47IQxCp4Nl
         i+O7nvCf9oblTep3liDgxQvegbDV6wsSxL6+Mx1YdRCKr2crYJk+YnvVlntsxHDyRYVp
         jLCUlIqPtixLrzAPBLMvB7f5hIGr4Aei5FDFvyPQ4etS0d1VYCZcJnxt3OXsp4s8qdX5
         AJuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746228862; x=1746833662;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h9xWYhOGMYJuYx8H/NT2qH8lGF6+JKzDd2d1LZS9mw8=;
        b=Gk6o+atzTTL3314S7hFXHhU04c7fkYbRe/g0y74jYopVxAycsugTnvdr8U+0kFbBCB
         1pf4ar/+Af6ZE29TLVZQsyAXt1zVE6AHhcOFgd/qm3bCYikNQ+upLg4PY6jo/c9LnzAj
         McWJa8fUBKsEE12qS8h9s38S+1KJCwm3FocjC/FRWD0Tik+C8bRIDqx8E1g/viIL9Ui8
         SovGVnQAt+eQ2C/qrmQhc895cMr1k5UcYUwIvrjOXcW6LYVo1WS4ncej9zMYYmTbJv1G
         QEiWIiJlk9Vw5sERxlAThL4cSUnwHI2CLhxhq9Kc3hO06pIrz24wdtIiB/8X3CsfD69I
         ursw==
X-Gm-Message-State: AOJu0Yws5gMcoKXlhFLg+v4PN298CWqHWixi2HD7V4FFCKQrx+4hHno7
	bfDx2UordCbWacBABzo2GZzUM851oNIklok8UH/f7jYL4oWqfYS76iEkA96R6ZM=
X-Gm-Gg: ASbGncvm5DaDxXsa+kbAvkzQZ9PbT005B13mLMnI29AT9fV54zTBCcrVm+eE8RfVfyJ
	igzW7R38Jj8kWpGt/xpTDFqWdh8pFfrkAdBicIWVJTlp95HEK8HaFHO706QO2AN8nugLw4T4Pja
	dI2QQmhbBWs1BqyN2ZHE/fUhzCQlPBoQpXpC5zRSomA38GHMJhHAgmzK11k4u8zaaWbWV/qdiu1
	IN6MpX7x2wJ7bJGJLNlNyNwtYz5zH8YmmIfGyY89+Km5z6j1ZAs/2QZkE8jF58O4+gd+Xjp8Wur
	Ufy0D5uTHmL9Ag6AYbSLrQyTWlXPWzmVPZcuRzhcvPmDnMBk78HFLe2jXfQLbyUdezh1H31Vzh+
	6n57Z8I3ZY/Vr
X-Google-Smtp-Source: AGHT+IE9iPfD7XFq6AP+m6zpQDqD7UgTP7wsjiHCLzCkQ8S23njD4pkM6RaaA6Kro6K1Bm7mlP/BWQ==
X-Received: by 2002:a05:620a:1a94:b0:7c5:b0b4:2cea with SMTP id af79cd13be357-7cad5b8fc39mr659838585a.38.1746228862380;
        Fri, 02 May 2025 16:34:22 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7cad23d1241sm255639985a.54.2025.05.02.16.34.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 May 2025 16:34:22 -0700 (PDT)
Date: Fri, 2 May 2025 19:34:20 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, gitster@pobox.com,
	johannes.schindelin@gmx.de, johncai86@gmail.com,
	jonathantanmy@google.com, karthik.188@gmail.com,
	kristofferhaugsbakk@fastmail.com, newren@gmail.com, peff@peff.net,
	ps@pks.im, Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2 06/13] t5538: add tests to confirm deltas in shallow
 pushes
Message-ID: <aBVWfJUFNdfwS0PO@nand.local>
References: <pull.1819.git.1741571455.gitgitgadget@gmail.com>
 <pull.1819.v2.git.1742829769.gitgitgadget@gmail.com>
 <ddf804e606a5560639e4018709da33cd80c74012.1742829770.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ddf804e606a5560639e4018709da33cd80c74012.1742829770.git.gitgitgadget@gmail.com>

On Mon, Mar 24, 2025 at 03:22:42PM +0000, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <stolee@gmail.com>
>
> It can be notoriously difficult to detect if delta bases are being
> computed properly during 'git push'. Construct an example where it will
> make a kilobyte worth of difference when a delta base is not found. We
> can then use the progress indicators to distinguish between bytes and
> KiB depending on whether the delta base is found and used.
>
> Signed-off-by: Derrick Stolee <stolee@gmail.com>
> ---
>  t/t5538-push-shallow.sh | 34 ++++++++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
>
> diff --git a/t/t5538-push-shallow.sh b/t/t5538-push-shallow.sh
> index e91fcc173e8..11b85cca9e8 100755
> --- a/t/t5538-push-shallow.sh
> +++ b/t/t5538-push-shallow.sh
> @@ -123,4 +123,38 @@ EOF
>  	git cat-file blob $(echo 1|git hash-object --stdin) >/dev/null
>  	)
>  '
> +
> +test_expect_success 'push new commit from shallow clone has correct object count' '
> +	git init origin &&
> +	test_commit -C origin a &&
> +	test_commit -C origin b &&
> +
> +	git clone --depth=1 "file://$(pwd)/origin" client &&
> +	git -C client checkout -b topic &&
> +	git -C client commit --allow-empty -m "empty" &&
> +	GIT_PROGRESS_DELAY=0 git -C client push --progress origin topic 2>err &&
> +	test_grep "Enumerating objects: 1, done." err

Why is a full 'git push' necessary here? Could you instead directly
invoke pack-objects as git push / send-pack does? That test_grep to
assert on the size of the pack seems very fragile to me.

> +
> +test_expect_success 'push new commit from shallow clone has good deltas' '
> +	git init base &&
> +	test_seq 1 999 >base/a &&
> +	test_commit -C base initial &&
> +	git -C base add a &&
> +	git -C base commit -m "big a" &&

I don't think it really matters, but you may want to write a test_tick
here before committing.

> +
> +	git clone --depth=1 "file://$(pwd)/base" deltas &&
> +	git -C deltas checkout -b deltas &&
> +	test_seq 1 1000 >deltas/a &&
> +	git -C deltas commit -a -m "bigger a" &&
> +	GIT_TRACE2_PERF="$(pwd)/trace.txt" \
> +	GIT_PROGRESS_DELAY=0 git -C deltas push --progress origin deltas 2>err &&

Same note here.

> +
> +	test_grep "Enumerating objects: 5, done" err &&
> +
> +	# If the delta base is found, then this message uses "bytes".
> +	# If the delta base is not found, then this message uses "KiB".
> +	test_grep "Writing objects: .* bytes" err

If we had the raw pack that was generated, could you use verify-pack
instead to check that the desired delta/base relationship was
discovered?

Thanks,
Taylor

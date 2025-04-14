Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A5027B4F8
	for <git@vger.kernel.org>; Mon, 14 Apr 2025 16:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744649499; cv=none; b=UCV4/s8QGBsY3q8At4OfbhIdQTlKQKKlEYMys/bCaOIouTmOyivMSAT4ZXqTWuV/rsxXdL7QL/wOYu4Ck5ETQkqKPX/1mArAAqAXJTT2eZZU/ZO0hWU4GkG2pLn2ATvz26g5UFGuSmX1fBAOmQvyJQ7rf6iUsJmVimWx0zN0h9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744649499; c=relaxed/simple;
	bh=F+kCSiLUM0EKGqGRPB0vE/KXMiniOpq/fgPZEXIcB2Y=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=WbLd48XG1l9JiYc70LqL/RwW/kjzKiCVgbpH9nBeBDafbnM9tOlsHRkOoTOcRfDxJWPdUU7agjVZG1H7X5rizJamiunCTQAsLZOeMzgD4tYxEaVWVhZQcI2owjrp0Rwai1nrJfqaEoR1vFfCNhux0I915oi7qiKzM9jQ5WERaaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=grgtNOBO; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="grgtNOBO"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-736b0c68092so3905069b3a.0
        for <git@vger.kernel.org>; Mon, 14 Apr 2025 09:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744649497; x=1745254297; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PmwhHjuImd9eXGilk442VwiiYmZyFxUOVkGA2/kPjqg=;
        b=grgtNOBONWVZ6JJm0HS2cn4/w/Fk4hmDhtT231xSKWt715uDfX3WwuYEw5E7c1jgQS
         f4KY3xjql4wvgAgGMnmIVwReK8hvF1UUQ5+dU/ZmBJKKP6leCdPU4ZfRXStMZny3WolT
         gtEFyXxVDTrBwRTQXP0VQW7tT07bpW9z7MI9tmlAERGJLI2OxByHrqfbEBEoNuBJtM/d
         wAFV+7v2zcaHDFJ3yeUCDXmPYuGBpiAthvammptE0Rx//dq1k+tCjja8xEuf9jtVrXw9
         VFb0ogT/kCWhKXJqdpF/NZLXqtYmOVYnpb8/JF/wMgVLe5Hw1gn1EurfgQZpy7a2x4Vq
         QXrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744649497; x=1745254297;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PmwhHjuImd9eXGilk442VwiiYmZyFxUOVkGA2/kPjqg=;
        b=DhM3CUKrQhHQJhAPyqVl1NPMERuhQMRgbmg+PIfFQRyrslN5tZxTOjcl3OzrCktCrE
         jZVgp7wJ9KyiOvi9tTVRGs7cPDu1Mf0GnhdQizs34+ftMD/n1Aa/3ZQlWmEBIPRgkePs
         69gwoM0HgmEKSj5JoHz3B4n5jgD1U1gnDhN1NhGG4ckKj5u54P0CvDQY6RnVMARU6w7b
         AuWQ5XOIuT9j400pkQ5F44w+s7b4Zwi8Z0IX1lYXWci3DSmOIjJIDXaFl5JtXC8i4SYS
         KRgGV4vhYAwpi8LAnyELEBk5UJRj/UiSLLHrCCulZQJBVU5eCiGxsaBZF8qgQiKF9PlN
         ULDg==
X-Gm-Message-State: AOJu0YxmcCIKe3rmgkXCAn2asXQ+SmZznv098ty/3J+ZIZNFABuD8+02
	2uckaxYaEL5pl20i/WtWlCzTuLcFJgLE3gAif/3T3IYj1gEzqDRwqwMZHaEV
X-Gm-Gg: ASbGncsUJkj470mBCPTrAl/9+gAObLGWIMFofzC6a0QQF0wSOn9kp8SPkv3ftiHsYER
	xYSm1ejGL5PYi5ZodkykiHip3868OnlHwdNWx8zsq/WdAVK9UP7LtjnEsX4yVZAejxgax8VERbe
	7iYA5RKxZnfQGbNaAOavhnbCJDe4PNUJgzVNwNZc6+Gg+72y9wT+GEebxf6/rYcm9cA42rMxs0c
	kUcct8p0N4o6in4ix09poIgOBNZeo7sm26VynoCE1bPEOaz0O5TSF8ruG78og9BDGiIQn/+wwa7
	M3OjW6xiAwL/sxy5m5n6Nh71gXRFtRJRInMPXJiFy92CI8FwuCCOcDXwPKdn7hV4ihMiaucH
X-Google-Smtp-Source: AGHT+IHwopIhjKJkbJQBqSafZwJdMU9GO0wwCEiRMb44uHdzt/LAmcJskYTmerysGLuNFYHCE7Tlzg==
X-Received: by 2002:a05:6a00:13a1:b0:730:927c:d451 with SMTP id d2e1a72fcca58-73bd12a9926mr16791035b3a.20.1744649497038;
        Mon, 14 Apr 2025 09:51:37 -0700 (PDT)
Received: from smtpclient.apple ([2804:14c:32:8e7e:85b7:aff:5cfe:b6e5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bd230e520sm7035757b3a.132.2025.04.14.09.51.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Apr 2025 09:51:36 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.500.181.1.5\))
Subject: Re: [PATCH] t3706: Add test for wildcard vs literal pathspec
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
In-Reply-To: <20250412174051.780148-1-jayatheerthkulkarni2005@gmail.com>
Date: Mon, 14 Apr 2025 13:51:22 -0300
Cc: git@vger.kernel.org,
 peff@peff.net,
 piotrsiupa@gmail.com
Content-Transfer-Encoding: 7bit
Message-Id: <FFC5C6BE-9A4B-4EFD-AEC4-E69CE6610054@gmail.com>
References: <20250412094607.236382-2-jayatheerthkulkarni2005@gmail.com>
 <20250412174051.780148-1-jayatheerthkulkarni2005@gmail.com>
To: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
X-Mailer: Apple Mail (2.3826.500.181.1.5)

Hi!

> +test_expect_success 'setup: create files and initial commit' '
> +    mkdir testdir &&
> +    >testdir/f\* &&
> +    >testdir/f\*\* &&
> +    >testdir/foo &&
> +    git add testdir &&
> +    git commit -m "Initial setup with literal wildcard files"
> +'
> +
> +test_expect_success 'clean slate before testing wildcard behavior' '
> +    git rm -rf testdir &&
> +    git commit -m "Clean state"
> +'
>
> +test_expect_success 'recreate files to test add behavior' '
> +    mkdir testdir &&
> +    >testdir/f\* &&
> +    >testdir/f\*\* &&
> +    >testdir/foo
> +'


Two questions:

1. Does this need to be inside a test_expect_success? It seems to me
   that those two tests cases are actually setup code for the next
   two.

2. If so, does it need to have all that setup? I could reproduce the
   bug by only running:

   ```
   git reset
   touch foo 'f*' 'f**'
   git add 'f*'
   git ls-files 
   ```

   btw, this works with your code, congrats!

Other idea: `?` is another wildcard for matching only one character.
Have you tested if the same bug happens with it?

PS: while I was writing this review I pushed this to my GitHub just
to make the CI run the entire test suite since pathspecs are a
sensible part of Git.

Take look at this, it seems that your tests aren't passing on Windows:
https://github.com/lucasoshiro/git/actions/runs/14450183624/job/40521015897.
Perhaps you'll need to change something there. It seems to be
related to how Windows handle paths (specially the \ character, which
means the same as / in Unix). Personally, I'm not a Windows guy and
can't help you further with this. A quick reference on how paths on
Windows work is this (and yeah, they are far more complex than in
Unix):
https://www.fileside.app/blog/2023-03-17_windows-file-paths/



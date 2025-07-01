Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B0818E1A
	for <git@vger.kernel.org>; Tue,  1 Jul 2025 14:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751381161; cv=none; b=Pal9Xrg3wBDC7wCl59TjLil5AGRlEcUR4hE/OTuwIe2/Ea+QTiwtb5xAGsN4mczEYKbiBp04+0zi7PdS0Mtwz84qyv9gS3PzFYBLt2sK8Ivwiuw+6PQTelPevOECrwJYjoH04aqX6NxPYq4BB91qpk+47ONk0v3XIVNZXA3rS6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751381161; c=relaxed/simple;
	bh=rnEGA/QVazh4c61IE4A/9aGyLslBmHksjxWl6sNCwQk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SMqk7lSIXOTCHKaXlcgHmZqMN/sxzkemNt5NlxQTVu4dMVNwc+g8NgnoPbAguiMpNC8UsiM1hj9eVOira7NjW8boWJArVz03PqlNfe75fEZ1ctp2UFxU/AD7T9580byyifshVPybGSTxqGspnZaqflV/W3rYfwpzBmc1AxXWXtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Em+uIDI7; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Em+uIDI7"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7490cb9a892so4067685b3a.0
        for <git@vger.kernel.org>; Tue, 01 Jul 2025 07:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751381159; x=1751985959; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :references:in-reply-to:subject:cc:to:from:sender:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Tgu53KIYTruEYVnrup6ZBqHOZrOKIeBDVWrYTufHgSk=;
        b=Em+uIDI7OExEvzAxnOBEXsxxAQVqkmZxvbur3NF0XrhbxewVct7HVYV7BT9dtiLWwX
         gy4hEK5dlOSgShz5nsmIEEwSsr3RUall29DPQjGxen5TVfGlAmvAXWAT8ZZl0Nlvdjq/
         skxg0a6ckbEYn2fN/QYMPQAHVy/ku3bpfxcWjf943zVZZ57A6kznCZuEAv2kt997T1Se
         stDJuLXqzjRn5OTAkwjxPBBREN97feQMExdyNLZEdAB2qECaI7NWn94XxxtjwSsETIFb
         WSGu8ubxPbK76PCt/exTKiDjwocI/BGSfZLzJHX9os1tddB6yi2ZbqBRASt+VmXkZNdM
         O6tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751381159; x=1751985959;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :references:in-reply-to:subject:cc:to:from:sender:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Tgu53KIYTruEYVnrup6ZBqHOZrOKIeBDVWrYTufHgSk=;
        b=SWDsqoVUkT3xzioOY8dvUWH3sUW4YwDytrbt9iZo1oJtf8h+AvJUvN7hbq13comhG7
         hb05PPdqdo9KtS0YaN8TvHHfJ6ikKCDO0PabM0Rq0duIm/yrbHcaQsHjKbXkSuiuHEI+
         JZbw1thZnvXcUOBLjjSaKhk3ajE/xxjfA30OVl14gqbqS9Q9GitNud7KG8A2lJl7UzRn
         kMlqr0KYXJ2Bm0Yf1k2vkSFkk02+H2vrxkQYhr5vZF6KFCvH0PNFmK/ZifXEo4NrXpob
         Lf50em1Re/XE/EbPt51M6T/dJCxkTL8L7ocJA81K7xTi1zpe4coWZGROCmlSdOCk2c2D
         pUSg==
X-Gm-Message-State: AOJu0YxdD2CuE5LnDC8u0zQv57uRrLLgEMM9rH8nTXioK0SRqxmjhwdf
	m9GkqGk7DV9i6Mj1+L80DZhuGpYRWS2o+0P91jYLvEC9q/TSEqayq1QXrF4oQQ==
X-Gm-Gg: ASbGncv9so9hhUP2XsMPthP7l6UUv86qb1KvAhQlXnHF0AJdBtdiDGdW/XYKZ+7Ky5j
	d5QWkefB2E7rnur+J/XxBM2AAZBcrsDKHnCKHTAQnrufy7DSkE8cgzcyamxs8/osoVz7ixQ0ox4
	s804WyY1TPd0KpqeCSyYzGQLkjlI++b+JVh4PZTK3ghoHq6OIIySJ0mZUnwXL2FEK+jOELAp9sT
	XAYImhAC04Ok8bZcvCHjnS49PLk93/q4QRZ5e+yZWEbwP7v44PohIRlRdl95Ck2/CiCprUVOHlr
	0POI51MTOs6cAz5TTCJ+3TyRqPl1w/eiRyDuMzChwpfsxjjQ3MI4TI0HjkwtshZl1HRIVhVay2j
	tCUueR15Dn7npgvakjc71mWVS4Ps=
X-Google-Smtp-Source: AGHT+IEZjq8KiNV1ApXQntUKmDmRoerWrzaYhHEjRwS4USs7ZZQrHK8oIaktz0+rRmJP6/2kCS6n/A==
X-Received: by 2002:a05:6a00:1992:b0:748:fb2c:6b95 with SMTP id d2e1a72fcca58-74af6f2e8c1mr26000665b3a.18.1751381158644;
        Tue, 01 Jul 2025 07:45:58 -0700 (PDT)
Received: from localhost (209.255.125.34.bc.googleusercontent.com. [34.125.255.209])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-74af541e64asm12257630b3a.63.2025.07.01.07.45.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 07:45:58 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n_via_GitGitGadget?=
 <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?=
 <carenas@gmail.com>
Subject: Re: [PATCH] ci: update FreeBSD image to 14.3
In-Reply-To: <pull.2006.git.git.1751345578742.gitgitgadget@gmail.com>
 ("Carlo
	Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= via GitGitGadget"'s message of "Tue,
 01 Jul 2025
	04:52:58 +0000")
References: <pull.2006.git.git.1751345578742.gitgitgadget@gmail.com>
Date: Tue, 01 Jul 2025 07:45:57 -0700
Message-ID: <xmqqsejgklzu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"Carlo Marcelo Arenas Belón via GitGitGadget"
<gitgitgadget@gmail.com> writes:

> From: =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= <carenas@gmail.com>
>
> FreeBSD 13.4 is no longer supported, and 13.5 will be the last
> release from that series, so jump instead to 14.3 which should
> be supported for another 10 months and will be at that point
> the oldest supported release with the interim release of 15.
>
> While at it, move some variables to the environment and make
> sure to skip a git grep test that assumes glibc regex.
>
> Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
> ---
>     ci: update FreeBSD image to 14.3
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2006%2Fcarenas%2Fmaster-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2006/carenas/master-v1
> Pull-Request: https://github.com/git/git/pull/2006

Thanks, will queue.



>
>  .cirrus.yml | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/.cirrus.yml b/.cirrus.yml
> index 1fbdc2652b3..fef04a38402 100644
> --- a/.cirrus.yml
> +++ b/.cirrus.yml
> @@ -5,11 +5,13 @@ freebsd_task:
>    env:
>      GIT_PROVE_OPTS: "--timer --jobs 10"
>      GIT_TEST_OPTS: "--no-chain-lint --no-bin-wrappers"
> -    MAKEFLAGS: "-j4"
> +    GIT_SKIP_TESTS: t7815.12
> +    MAKEFLAGS: -j4
>      DEFAULT_TEST_TARGET: prove
> +    DEFAULT_UNIT_TEST_TARGET: unit-tests-prove
>      DEVELOPER: 1
>    freebsd_instance:
> -    image_family: freebsd-13-4
> +    image_family: freebsd-14-3
>      memory: 2G
>    install_script:
>      pkg install -y gettext gmake perl5
> @@ -19,4 +21,4 @@ freebsd_task:
>    build_script:
>      - su git -c gmake
>    test_script:
> -    - su git -c 'gmake DEFAULT_UNIT_TEST_TARGET=unit-tests-prove test unit-tests'
> +    - su git -c 'gmake test unit-tests'
>
> base-commit: 83014dc05f6fc9275c0a02886cb428805abaf9e5

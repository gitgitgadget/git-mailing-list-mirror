Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA0BD1474B7
	for <git@vger.kernel.org>; Mon, 14 Oct 2024 21:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728942445; cv=none; b=a8o2RkBuI1Ht0teKTB25yLmyy1j5kRi3IXY9lv6QzTH/Meihph9UwNZYIYFhaQIUhS7oJCdWslunztZerNiYGSIHtq95O6sj40MgseloQG6eiCOwy/92F5VPDlnQqGX9MzWvuyFjYPtZX5IG2wJ8iB3mwKzdBMH62H91QGyHuIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728942445; c=relaxed/simple;
	bh=DtBbY0keFJ6dn2bB2rr6V+WmP4A9xsJ9rD2LWp/kYO8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NKnCP/Lj7h7sKeKlYbEjmkcrDcvQmNcaDR667ZYkjHBKacxVADYF55TyL96VXXKGXSjDu+itmyjCRYiVwREXKDUDTZtD/SAePjsj1k5Y71yd82Q8OaUh8X3Xv8InFs9C2i2YRDauLmTbrZon0L6raQtgqpr6TXKiw7JTv7Z9ifA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=JFWC62WS; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="JFWC62WS"
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e2918664a3fso2685545276.0
        for <git@vger.kernel.org>; Mon, 14 Oct 2024 14:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1728942443; x=1729547243; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dGekQGaEw/sMQ4qiTnZY4iN1Q0AAf4M6Va7l2Mz75Cg=;
        b=JFWC62WSY64rYtoKNuruI6HdymAlMSIwyARfs36hISmuLWI4inZyD0GWW3TsZ0D/uP
         VH8x1EU5OH68BdxLz8V0UZMXOsqbHpyUIlGyDzJaD+Wnfh3kfIzbwE6sQQiD8UHGhzpu
         Ekbxsf85zHiPXhF62xWumqC/LnB4HNYUX7sukCSgHh7Q7oRpWrdvMuCvhoSuoi+EDXL8
         3mkyy3e48vYkpIdRxUBEvL5aXK82HE82t12a4Od9HWT6gUnsevtWmsmr0GqlWGAP4mfS
         aEu0RqamkWGcXzjxBBCawbCaJ+eO7HY3KZL5DguXMyEfWO6h/xuj3tYL6xWn0PFaKrkL
         T/NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728942443; x=1729547243;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dGekQGaEw/sMQ4qiTnZY4iN1Q0AAf4M6Va7l2Mz75Cg=;
        b=fRujsvDlDsMVPdbMG29Be0CkdNIXC0Oehw8h1tWL6bfjHQSrLZKCjKwrDqIQwVCnWN
         hFGyGJF1qSlTFBahZMOmpwGxbFe2NocXQXCpHK8buPgZ59uF5tCSA9GII6tvTVwsSUiT
         rSiYzAtOzjG1LMeRbRXAsPQZKQAOqtgQmZ7ojbV4w7rW99pVCfgV4c7ihlQ6tInjRf5j
         J1ZsF7+KR1a9If66iZKebOUNCrZ3zMCll0cwUMc3nNCYwAPpRYsd3z1q6/rSZKjlLXbC
         IYmJMZoDbsR2MsMMG5AhsLA2Zrdu4UUXzKh0dVX2bAoFVuuxOEI8tQ1osAlQnjTsCrd+
         NIXw==
X-Gm-Message-State: AOJu0Yx7AVBcFpvwgtwQGDC6d18aLNIac4WwhBDEx+xWPYH6KCvdiNPa
	UpOO93mWLwEN3S/WtWrl5iF9pk3vTu0f0EzqEmQSroLzyo1/wD/muIcOlFj5hpc=
X-Google-Smtp-Source: AGHT+IGjWhxFVGq27CxgmG3pD/A1mQKwGAnCFA3r1YVoIo5SxUZapQxQ9CZePhJa9XYow5VJw81Zxg==
X-Received: by 2002:a05:6902:250a:b0:e28:68e8:ccb7 with SMTP id 3f1490d57ef6-e2918351353mr7712556276.12.1728942442862;
        Mon, 14 Oct 2024 14:47:22 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e29284ac988sm1919027276.20.2024.10.14.14.47.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 14:47:22 -0700 (PDT)
Date: Mon, 14 Oct 2024 17:47:21 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Ed Reel <edreel@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 3/3] cmake: set up proper dependencies for generated clar
 headers
Message-ID: <Zw2RaUNoQz+OTcKZ@nand.local>
References: <CAGjHeYfyH+cOMYYYHnFR+Vu9T+RbmzO1SpB_-kbmBSf1DitJhA@mail.gmail.com>
 <cover.1728914219.git.ps@pks.im>
 <129d28ae48ad984e9fae8bf803ae50a390b15a46.1728914219.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <129d28ae48ad984e9fae8bf803ae50a390b15a46.1728914219.git.ps@pks.im>

On Mon, Oct 14, 2024 at 04:06:47PM +0200, Patrick Steinhardt wrote:
> The auto-generated headers used by clar are written at configure time
> and thus do not get regenerated automatically. Refactor the build
> recipes such that we use custom commands instead, which also has the
> benefit that we can reuse the same infrastructure as our Makefile.

OK.

> +add_custom_command(OUTPUT "${CMAKE_BINARY_DIR}/t/unit-tests/clar-decls.h"
> +	COMMAND ${CMAKE_SOURCE_DIR}/t/unit-tests/generate-clar-decls.sh "${CMAKE_BINARY_DIR}/t/unit-tests/clar-decls.h" ${clar_test_SUITES}
> +	DEPENDS ${CMAKE_SOURCE_DIR}/t/unit-tests/generate-clar-decls.sh ${clar_test_SUITES})
> +add_custom_command(OUTPUT "${CMAKE_BINARY_DIR}/t/unit-tests/clar.suite"
> +	COMMAND awk -f "${CMAKE_SOURCE_DIR}/t/unit-tests/clar-generate.awk" "${CMAKE_BINARY_DIR}/t/unit-tests/clar-decls.h" > "${CMAKE_BINARY_DIR}/t/unit-tests/clar.suite"
> +	DEPENDS "${CMAKE_SOURCE_DIR}/t/unit-tests/clar-generate.awk" "${CMAKE_BINARY_DIR}/t/unit-tests/clar-decls.h")
> +
> +add_library(unit-tests-lib ${clar_test_SUITES}
> +	"${CMAKE_SOURCE_DIR}/t/unit-tests/clar/clar.c"
> +	"${CMAKE_BINARY_DIR}/t/unit-tests/clar-decls.h"
> +	"${CMAKE_BINARY_DIR}/t/unit-tests/clar.suite"
> +)
>  target_include_directories(unit-tests-lib PUBLIC "${CMAKE_BINARY_DIR}/t/unit-tests")
>  add_executable(unit-tests "${CMAKE_SOURCE_DIR}/t/unit-tests/unit-test.c")
>  target_link_libraries(unit-tests unit-tests-lib common-main)

Ahh. The post-image is a definite improvement ;-).

Thanks,
Taylor

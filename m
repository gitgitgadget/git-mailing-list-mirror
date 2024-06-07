Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D6A19AA63
	for <git@vger.kernel.org>; Fri,  7 Jun 2024 16:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717777752; cv=none; b=W4epF6+59v7W+2azVXAyXlGbpoSFYNENNBNoEOP9VNkP1obq059tsZzXQ5nGTG7NIwGKqJPPEpYUOQuu24tJaNfhK9vd2HMAAB4Ds+x/azCYSs3MGEOGXRAKyuyiRI6IJ6xrrvXjd70MrzEvyh+w23V+AH1+ztbYiGoPlO3JEh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717777752; c=relaxed/simple;
	bh=CaOKllho9TG4KsOzqlrSDkQ5+ZLwRX88FAsFunlqqG8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=a6AmDSQynQ9PakgL4Nv85mXwAVTh1ZyIyTFuJHrHk25stOprcdKA8hHshz+rmHO/ht7LiE7Hz0CoYJv69BEfDvzdE2ajJj6FsoXwVhoQeDAZYQuFnAFY0MvDDEMgeIO9Gc6e3Xs7xmaRpaXVdX2b53YVPrlwImb3k9rgO0x8Tiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hq/ycr2L; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hq/ycr2L"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-35f0aeff7a8so540186f8f.2
        for <git@vger.kernel.org>; Fri, 07 Jun 2024 09:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717777749; x=1718382549; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ONq9ymPqnCAP4B5DNXV+4FOWWnqD6iZwqNG8gqJMffE=;
        b=hq/ycr2LaJ4lIxY9aL0+fKT2z61kacul1t49hjX1gtdcJ2X24OovvdMqynUGkapuqa
         ccqG2LuTHrNuxV9E8I6UDOKaRZJ5mclQFl0fD/0jYqFwj9F7KclSMXdfRrBf05GlVGSw
         j/yGwYI+DhLw0wEGa4nRvVqEvtweMOKY5HJ8yCtkaghdiC24RxzImacnk3hgm2zd3G2Y
         KfR0J+PjZ+83L/p8aeJSm+FMBRetW6AYHcMonLgkPpkH9smQtYdZHeIV4aCxw6n4Dh2U
         a8Chk6h029m2R8awl9H3sprF9kGlMi8dolWpV/7xbstfms+lLnBMbH3ztoy9fIJNI2q0
         Pb5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717777749; x=1718382549;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ONq9ymPqnCAP4B5DNXV+4FOWWnqD6iZwqNG8gqJMffE=;
        b=OAC60iGzsMAGUXt6eQdAqkpMhEHVDZVXb/c7nHtQDBJ5FIGsmW7BpwLFgDGIC7si0z
         XDbUN2CaTuRnV1w9JCUb2TM+ON7lFoeNxi0nqVkdtk/BNQSO18C6ll0dhtBfxni/Vio0
         GBCGMaQb5agfv0zeTmv0d0uowTkQlcrhwsbon8xahUDTwH7glQv2r9vUf+P/18n0OOmA
         hM7FqJyjPLShCAB0m3CdXPZSu8EzYNgENinvTGjJuSWKmthK0WKzy3t5v6WTIvmZAtFS
         Y1eSWizlxcQlCt/wNlOyi/1whqXUahl6z81puIktedRmtVHX7gSPF8IeI+wii23vc8pt
         orMQ==
X-Gm-Message-State: AOJu0YzFFg8Xr2yV8fakg+aqxLijRwDZnpW9T3+IK5nx6mpMUTBrlLMd
	VH6z/JDgptdtGxiQ1AcX7ZQbIJ3brgRRZS0yxw0ITIcury0J1mWc40oqaQ==
X-Google-Smtp-Source: AGHT+IEU8rizDXVnnS5KkSPTl7O4C4iVYainNN+0aNxyfPncbu7aR8FqRC8Mz/lScFoufyZsFhW9Cg==
X-Received: by 2002:a5d:648f:0:b0:35e:83c0:82cb with SMTP id ffacd0b85a97d-35efedf8b16mr3142614f8f.70.1717777748391;
        Fri, 07 Jun 2024 09:29:08 -0700 (PDT)
Received: from gmail.com (200.red-88-14-44.dynamicip.rima-tde.net. [88.14.44.200])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35ef5d66d01sm4318004f8f.50.2024.06.07.09.29.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Jun 2024 09:29:07 -0700 (PDT)
Message-ID: <9f520828-f87e-49b1-aa4b-c00ec6bb0133@gmail.com>
Date: Fri, 7 Jun 2024 18:29:06 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v4 0/2] format-patch: assume --cover-letter for diff in
 multi-patch series
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
To: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>
References: <6269eed5-f1ff-43f3-9249-d6a0f1852a6c@gmail.com>
 <14365d68-ed04-44fe-823b-a3959626684e@gmail.com>
 <cb6b6d54-959f-477d-83e5-027c81ae85de@gmail.com>
Content-Language: en-US
In-Reply-To: <cb6b6d54-959f-477d-83e5-027c81ae85de@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This iteration incorporates the changes to the tests suggested in the
reviews from the previous iteration.

The main change is to split the tests proposed in the previous iteration
into several separate tests;  separating the functionality that checks
when `--cover-letter` is implicitly assumed, from the tests that check
when this implicit assumption is avoided.

The new patch in the series, [1/2], is a preparation patch that reorders
the way `test_when_finished` is used in t4014, making it more reasonable
and logical.

Thanks.

Rubén Justo (2):
  t4014: cleanups in a few tests
  format-patch: assume --cover-letter for diff in multi-patch series

 builtin/log.c           |  2 ++
 t/t3206-range-diff.sh   | 14 ++++++++++++++
 t/t4014-format-patch.sh | 25 ++++++++++++++++++++-----
 3 files changed, 36 insertions(+), 5 deletions(-)

Range-diff against v3:
-:  ---------- > 1:  678bae2e42 t4014: cleanups in a few tests
1:  78aeff9016 ! 2:  d1e9f8561b format-patch: assume --cover-letter for diff in multi-patch series
    @@ t/t3206-range-diff.sh: do
      	'
      done
      
    -+test_expect_success "format-patch --range-diff, implicit --cover-letter" '
    ++test_expect_success "--range-diff implies --cover-letter for multi-patch series" '
    ++	test_when_finished "rm -f v2-000?-*" &&
    ++	git format-patch -v2 --range-diff=topic main..unmodified &&
    ++	test_grep "^Range-diff against v1:$" v2-0000-cover-letter.patch
    ++'
    ++
    ++test_expect_success "explicit --no-cover-letter defeats implied --cover-letter" '
    ++	test_when_finished "rm -f v2-000?-*" &&
     +	test_must_fail git format-patch --no-cover-letter \
     +		-v2 --range-diff=topic main..unmodified &&
     +	test_must_fail git -c format.coverLetter=no format-patch \
    -+		-v2 --range-diff=topic main..unmodified &&
    -+	git format-patch -v2 --range-diff=topic main..unmodified &&
    -+	test_when_finished "rm v2-000?-*" &&
    -+	test_grep "^Range-diff against v1:$" v2-0000-cover-letter.patch
    ++		-v2 --range-diff=topic main..unmodified
     +'
     +
      test_expect_success 'format-patch --range-diff as commentary' '
    @@ t/t4014-format-patch.sh: test_expect_success 'interdiff: solo-patch' '
      '
      
     +test_expect_success 'interdiff: multi-patch, implicit --cover-letter' '
    -+	test_must_fail git format-patch --no-cover-letter \
    -+		--interdiff=boop~2 -2 -v23 &&
    -+	test_must_fail git -c format.coverLetter=no format-patch \
    -+		--interdiff=boop~2 -2 -v23 &&
    ++	test_when_finished "rm -f v23-0*.patch" &&
     +	git format-patch --interdiff=boop~2 -2 -v23 &&
     +	test_grep "^Interdiff against v22:$" v23-0000-cover-letter.patch &&
     +	test_cmp expect actual
     +'
    ++
    ++test_expect_success 'interdiff: explicit --no-cover-letter defeats implied --cover-letter' '
    ++	test_when_finished "rm -f v23-0*.patch" &&
    ++	test_must_fail git format-patch --no-cover-letter \
    ++		--interdiff=boop~2 -2 -v23 &&
    ++	test_must_fail git -c format.coverLetter=no format-patch \
    ++		--interdiff=boop~2 -2 -v23
    ++'
     +
      test_expect_success 'format-patch does not respect diff.noprefix' '
      	git -c diff.noprefix format-patch -1 --stdout >actual &&
-- 
2.45.2.23.gd1e9f8561b

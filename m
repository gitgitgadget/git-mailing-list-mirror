Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5DBA2D5940
	for <git@vger.kernel.org>; Sat, 23 May 2026 15:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779550996; cv=none; b=oUdP/OfcJtwHeNxKz8VThakhI/LzgkYUL6miU2/0yCzOChkvxbkDepduGPL1scaZpeidpyM106fI6dAH7TNyViUZsdXUL4YDos/fCDN7n2N5fmh4vxuN7yDQ7b6XdCzkJ007HJy1d+LMig4DndZyUMKvUXoP4claud75LagG2Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779550996; c=relaxed/simple;
	bh=ohnWBKpYqHMMFbFP1KTy8iDA8UkgIHY3tYnrCEk2Auk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bSdXqhKqnxTJk+LogdprsqCEftaJc8w5ZHL4u+45jnN/1XE5p3LwT4T8F4dhGiCI2xjbvG41OLjOriUbl/3Mn2FmHG8v0qNFEP+Esy0gxSYTc4Xa4ULtsN+RVTjYzWBDs2faQzpcRaScXj+JbO3mXRp1o2Uw3Kdab5EcfW3yx5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cjIbvPoN; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cjIbvPoN"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-8bb09239328so64290026d6.3
        for <git@vger.kernel.org>; Sat, 23 May 2026 08:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779550994; x=1780155794; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ohnWBKpYqHMMFbFP1KTy8iDA8UkgIHY3tYnrCEk2Auk=;
        b=cjIbvPoNyCPDXJbVz85MeA+lagZWo8Lw/gvqP0oa383PDlWtNKkIzUmYBrHeHL4If/
         WFRUP/2EkbAsHyXT0BQ5WIiHermioXvWfctE/qD9InbP9ZLpP3KT0X6VXKA5Ifg2rj5c
         unIOJ7E7sTB9x8EOT51q91oKokTf3x93VqE+ls7fjjpXwWggDVvdX1M7rSqoInAXVym+
         7WuQxHCTmN2/SCkfA68iUthWTg4hNxO9yKadhWYXRxUw2b40V00sSbbsqKdYvK7wbOJG
         NcYZmbFqWd7U4gajdIvIHd1yZt5lVMTd/V9RNHcSfI+7QaY5+i+flNlE3bbYoNSXu1ES
         nr+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779550994; x=1780155794;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ohnWBKpYqHMMFbFP1KTy8iDA8UkgIHY3tYnrCEk2Auk=;
        b=GNAp69QJZiyjclvRwCwp0SO4Yl7AFd7lrpvQkNkSL3sdMfm20oQdmh38ppUgCXRn72
         wYTXLl7Q7Z1GHdFS7u0VFedQkT2A3MxlYNCLwR6fs+uvvrvBkVCwnKrSTD7SZF05+fLD
         sfB1wZxx/dbsPvAdrOAhc6XJdVrgBj0BDxwVlSrs0gjhtvYqx6b/7muLNQJrrZTH59Nc
         dCrdr/XbclfzmJaweHJMXcDboteH11HXjFP4c1G6VGyyKsaMPyrg5d/MqXfpzqh5NnMG
         RL125qF58Zw0yZ86YcEXyXeVgGdQLk9feYV69arutZzr0t7Xdd9JQex4B8Wo2obGSNht
         ha8g==
X-Forwarded-Encrypted: i=1; AFNElJ+8pz2fIg6KIsXcxPdqD4U42Ao/Uhph7e+TA7I7YekOgcpqxNg3srnBdkHnV+wonDU3b5w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJ59mcCG2ery/4nE3/R2iiLjtWeQcjWz8etU6WipzFjf/Wzyr9
	QpaypGBGkm+6swki4d7M1tWQ4asxbgcU5XzHnpL2x+fouYZPXBFbMiXbrKX5IRoO
X-Gm-Gg: Acq92OFP24tfcdZ3H1IW8xRiQNeaCZg71eHk4i166FSHP9K0IzJe8mmxfl6XNv7AsYc
	unMeYv0pJKOvFxEOKHXX/fQxLScLrXC+W4m5sDdK8jDBMJZDBPs8ecY7Ow3I4Un7Nu0Uo5ssNdH
	6bCW6z6zbGnLEPFTek48DEefWFECC+HtIcN6h641eKhOfnRMW0B9VScJ5phmksKI4nqzMeDygwJ
	uPwDIl1gD3bgVRtKXYge5ohh2EbyTfghG7nQzm0huZ/hSayk6FI7fZGNfMUQXg6PyG4wIAggJjK
	4R6YKAuS4Ea9ULhNal9iuqbSEZ+EkQxCj+dU8q/7RJsusPtzfQMbHq1G3ee1/bbilBP5pd0jg7f
	B6eIBwbhSObxmFAUcOEBG7pWq2b/fY9RpEzqWmnGltEm/dmq32d0xpwtM57F6Kvh9TiU4DYTKk8
	4c8SUorY8yjVqt8r5laB+odIK97sh0qiFjb9P7BoTvSTKG6tvDm/XzUkwxzgh10ff5VI22i1X1B
	pF/AptbPw==
X-Received: by 2002:a05:6214:3bc7:b0:8cc:15e4:1208 with SMTP id 6a1803df08f44-8cc7b65aa0dmr132607046d6.32.1779550993692;
        Sat, 23 May 2026 08:43:13 -0700 (PDT)
Received: from ?IPV6:2600:4040:264b:4100:d17e:f99:a560:8cad? ([2600:4040:264b:4100:d17e:f99:a560:8cad])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cc81316e4esm48978586d6.41.2026.05.23.08.43.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 May 2026 08:43:13 -0700 (PDT)
Message-ID: <52331f7c-1c97-4de4-bfb6-05140ffea6b4@gmail.com>
Date: Sat, 23 May 2026 11:43:12 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/11] git-gui: allow specifying path '.' to the
 browser
To: Johannes Sixt <j6t@kdbg.org>
Cc: egg_mushroomcow@foxmail.com, bootaina702@gmail.com, git@vger.kernel.org
References: <20260514143322.865587-1-mlevedahl@gmail.com>
 <20260520202411.108764-1-mlevedahl@gmail.com>
 <20260520202411.108764-10-mlevedahl@gmail.com>
 <ae3cdc22-2f88-4222-bab7-403408373a53@kdbg.org>
Content-Language: en-US
From: Mark Levedahl <mlevedahl@gmail.com>
In-Reply-To: <ae3cdc22-2f88-4222-bab7-403408373a53@kdbg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/23/26 10:23 AM, Johannes Sixt wrote:
> Am 20.05.26 um 22:24 schrieb Mark Levedahl:
>> Invoking "git-gui browser rev ." should show the file browser for the
>> commitish rev, starting at the current directory. When the current
>> directory is the working tree root, this errors out in normalize_relpath
>> because the '.' is removed, yielding an empty list as argument to [file
>> join ...]. The browser function demands "./" in this case, so make it
>> so. (./ works on Windows as well because g4w accepts posix file
>> naming).
> I wonder why we need "./" instead of plain ".". The latter works just
> fine in my tests (on Linux).
'.' caused errors in browser::new in for me before while './' worked, but now I find both
work. I'm confused, this must have been an interaction with something else in flight at
the time, will revert to '.' if that passes my tests on Windows as well as it is more
consistent of not adding '/' to a dirname.

Mark

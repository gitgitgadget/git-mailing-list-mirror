Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CFA715B7
	for <git@vger.kernel.org>; Wed, 26 Jun 2024 19:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719429909; cv=none; b=eWuTPvxYUXA3MkuuH6wMLFxlmLh/EiySBda/P1wbcFxA5/zSBzJjjSavxjUWkSx4Rw3wTklvKDxXmkn42ZqIcq3cBx/vtAHIIuIuRE+87Mpfa5fbBHg23wvRLKRVlNcutEr0gErQ7PkqE6MSr2xsKScSsaZ7iLDGukeQYjheVho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719429909; c=relaxed/simple;
	bh=tee6+dmQOGngKSdaNsCH8xttC27h7eZeXGJ7K5CQ4TU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=re2czxVf08Um3fn5Ix7K+dWtgdcXaoqJb565bKUpUq1wblis/6knc4XQenw/VKSI5ZMT48yxh+pjfNseMGTCWCE3IRKjU7db/FYnr7HoDp4dqQ1kE2CQEPI/n9NzbIJu3U/K3QslSCo4PlObsSs8hgoTAsTOq4s09lg/ZamvM4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NirqiAzj; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NirqiAzj"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1f9c4ec8e04so3266425ad.3
        for <git@vger.kernel.org>; Wed, 26 Jun 2024 12:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719429907; x=1720034707; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7W523YwnzE+odCCJ7NuDTd7JIEzCAvaLXR1DvRK1TQs=;
        b=NirqiAzjJlb0UJVnrXhFenpZ4BxvslDc/hy9MDx3Mm3OFzNlD3E3yLpNDvxkOoHRYZ
         itr2MMhTa32LS+Blb/xzJ4pNjBS0SEGO7i5R60yQZ0naQ02sTC/fEtSgGJ9dQlgWn2Zm
         JRBHpcu4ywF/MfFtJf5VOgDHlga+mPTMOBCp9O/cmA+O93PKNabF1zxH47r9aEJ40Yy8
         /5DwFgoao9nGMXlgFJW0zUTHCbT3GoI5TMrdQffHJFAExWnDutdhUmCnRjmEfEiUZdIC
         61r50qAXNaQPpivFQynaljt0YjI03oMLVEj7VSVdcJg0z9HyOAfqAsu1C+lox+0K+wgs
         D/AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719429907; x=1720034707;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7W523YwnzE+odCCJ7NuDTd7JIEzCAvaLXR1DvRK1TQs=;
        b=AUj/Y8fJxTgiqgB+at7/u1UcIATT9VZlMIu6GJcia2erPQm6Xhrp1GbujAzkQIG4ZA
         uUR9LePh+g9iM2r7arw1jw3cS04/f6wuDfW8F1E3piO6nUSFGzDe7vWyTAVeAMvrdWhA
         hzqEfn2jtnfxsn3YozJKAPj17JvpjKKuCofb/zWUY9Ztvmk7OEnldGgkQvwC6hiEqxOK
         x3VC7+999RD/NYtgft1HPYig3I2BOSffGJ7qqDtjHLGEUHV4xG4KSq1UNQBcOMR6QTrH
         pLpzp5vB6XYnXNLIO7CT9iq1RhkagYup1j9uZaRDwlhhdRY5Xb3VIFbg56KQ7+iA2+8H
         v6eQ==
X-Gm-Message-State: AOJu0YwrvH0FBXmqzW/CDyII+IlgMpQOzf+5/vTNr9xCKxyg7U6Q5t1B
	ENzNGRQcqgjx8dG5CJVqtf1O8ncYNG2zEVSb0uPWSvgAK/q4VYVM3Zdwu9WmGj4=
X-Google-Smtp-Source: AGHT+IFjlocnKdfmXo7cl4Y9V4SiBV+M6jMtbIGOA/l2Sa+mXD+66fyARZoGmNqzZlo+BlRiKQT5zw==
X-Received: by 2002:a17:903:94:b0:1fa:1a7c:9a05 with SMTP id d9443c01a7336-1fa1a7c9d36mr131974305ad.6.1719429907250;
        Wed, 26 Jun 2024 12:25:07 -0700 (PDT)
Received: from ?IPV6:2409:40c2:205a:5198:c04f:bc01:50f8:f177? ([2409:40c2:205a:5198:c04f:bc01:50f8:f177])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9ebbb5c93sm102780985ad.267.2024.06.26.12.25.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jun 2024 12:25:06 -0700 (PDT)
Message-ID: <03628ece-4f47-40d5-a926-acce684a21e5@gmail.com>
Date: Thu, 27 Jun 2024 00:55:01 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7] describe: refresh the index when 'broken' flag is used
To: git@vger.kernel.org
Cc: Paul Millar <paul.millar@desy.de>, Junio C Hamano <gitster@pobox.com>,
 Phillip Wood <phillip.wood123@gmail.com>, Elijah Newren <newren@gmail.com>,
 Jeff King <peff@peff.net>
References: <xmqqpls3zhc2.fsf@gitster.g>
 <20240626190801.68472-1-abhijeet.nkt@gmail.com>
Content-Language: en-US, en-GB
From: Abhijeet Sonar <abhijeet.nkt@gmail.com>
In-Reply-To: <20240626190801.68472-1-abhijeet.nkt@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

I have a question:

Why does --dirty code path also not call git-update-index and instead does

	setup_work_tree();
	prepare_repo_settings(the_repository);
	the_repository->settings.command_requires_full_index = 0;
	repo_read_index(the_repository);
	refresh_index(...);
	fd = repo_hold_locked_index(...);
	if (0 <= fd)
		repo_update_index_if_able(the_repository, &index_lock);

I assume they are equivalent?
The commit which introduced this --
bb571486ae93d02746c4bcc8032bde306f6d399a (describe: Refresh the index
when run with --dirty) seems to be for the same objective as mu patch.

Is this something you would like to see addressed?

Thanks

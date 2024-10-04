Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5EF1DE3D5
	for <git@vger.kernel.org>; Fri,  4 Oct 2024 19:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728070404; cv=none; b=dwpORpfVkpeKCVmQN0n613SfN4emgrStDcaoXMtfLjcGUVG4DXHWSF6TC9QgKekXe3W7g+YWoJ5+aObbN+v9ACdIi1GmiwW+D/tPeCfnNutIDZpbEHqWXB046ParSmb+NZRtByJa5w+HR6AdbxFxGJvmPCjNl8d7LdSs72dkIEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728070404; c=relaxed/simple;
	bh=HCDOhvxukCju9C0qI3zoeBhiMdpofs/s3xP1YcfIbgw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gBA8x2bpO0n6CCkd12s/+OezYZ8JtGdmr1T5qc0jufQNIF6uQvUjuoSshMzXabLYNgRA5eCGEmxZpihrMSxOkXiDJfKIP36mkhNpENLoplLBN+bidT/hSKF3VFq0jYIN6PhuZq+iaOas4oOwyk5vn5JSWpF8h5N99PTASUbsexM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eGh3E5ky; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eGh3E5ky"
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e25cf3c7278so2350305276.3
        for <git@vger.kernel.org>; Fri, 04 Oct 2024 12:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728070402; x=1728675202; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cLQzab649n1OnBeeuDgBmpxGC1FeSDUi/XRcX4oiKbc=;
        b=eGh3E5kyN4wL5YN5yxrTQowrB9bWplI1xa887XyAuUbdePddOGwaQMJDCd/cFjf07c
         mS3kRFKRwBFKJ9E+/Nr8eDGfWSjFxyKLOtBfTHAgknnHAklGKNQ8jiG9216iwZttXbim
         MJg5Z+JpV16ETz8nHI8J61i5pMUbObymvPJYbMwJB2yLq91s11DmQ4gcUlBLZDGvpMU6
         Y5ud18C5GUbQ0o6Wc6bqNd8SFEjli/TG35d4yAAVzUUH2DLL6HJmErv5DcNfKlm07B6c
         rbAgPQ/H4P23ccO1Fexbo/eYVJzHxS8+6//Cdhtv75Cqp070sSLwo8xEcIA55naE23f8
         R34w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728070402; x=1728675202;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cLQzab649n1OnBeeuDgBmpxGC1FeSDUi/XRcX4oiKbc=;
        b=DSih55Z3ixhjBjxH3WUQJsIgQ6jinnfJC1YZ41IaVd1DAHmTxjYGPinr+kWriVJN5t
         PGqfUt5IqyOBh+dAczWKf1VUfex3Bh6Co5MP+ZVTBYsGGn4G3G8x2GlGQ/HuwKTuH8ic
         BOWXFBU3FJ3yW6hbfSqHk9bTaP5Xqg0OmYR8i5KBnalZHdsDb0c01+KA+HPZW+B9JkXQ
         lFDaWj8jk1nDsdSLl+oAJwbBj2s0MilSE/UI+R9CiLoxaSqDCHIdBQGpm9CYkhctshQu
         T1m2KM8jXVvcPCT9g+edZyvQq61D9N9hb5DkUHi5LiYgACHvzgAVK2X0ORmwBeA4VYn8
         MjBA==
X-Gm-Message-State: AOJu0YwfU0XA/ykM70VSeBCfpMQVQhL6ie7B7QTrQBSmvLYIhvhQJjHf
	W8Sx7LFc5zfWx1otwQIYnMYT2bg7VdqZtjt4e4OL8BqITjuRZOTA
X-Google-Smtp-Source: AGHT+IH08tVK0CSVViCHSPFhLM3kTkbDZMOJ1/8HkhTrCCidZidRCAA1qGmIF/3n33Eyq3sVlBf/uw==
X-Received: by 2002:a05:6902:2b8f:b0:e20:16b9:ad68 with SMTP id 3f1490d57ef6-e2893951b87mr3113163276.45.1728070402127;
        Fri, 04 Oct 2024 12:33:22 -0700 (PDT)
Received: from ?IPV6:2600:1700:60ba:9810:2979:6e53:aebc:1a02? ([2600:1700:60ba:9810:2979:6e53:aebc:1a02])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e28a593b196sm59284276.4.2024.10.04.12.33.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Oct 2024 12:33:21 -0700 (PDT)
Message-ID: <039920ed-57a8-4c49-8914-5f071a548eca@gmail.com>
Date: Fri, 4 Oct 2024 15:33:20 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] diff output_prefix cleanups
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, gitster@pobox.com, ps@pks.im
References: <pull.1806.git.1727885224966.gitgitgadget@gmail.com>
 <pull.1806.v2.git.1727956724.gitgitgadget@gmail.com>
 <20241003210548.GB11180@coredump.intra.peff.net>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <20241003210548.GB11180@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/3/24 5:05 PM, Jeff King wrote:
 > Here's what I would> put on top (but I would suggest making it a separate 
branch, since yours
> is a fairly urgent fix and mine is all cleanup).
> 
>    [1/5]: line-log: use diff_line_prefix() instead of custom helper
>    [2/5]: diff: drop line_prefix_length field
>    [3/5]: diff: return const char from output_prefix callback
>    [4/5]: diff: return line_prefix directly when possible
>    [5/5]: diff: store graph prefix buf in git_graph struct

I've reviewed these patches and they look good to me. Thanks for
taking the time to split them up carefully to help review go so
smoothly.

>   7 files changed, 28 insertions(+), 43 deletions(-)

Excellent to see the line reduction, too.

Thanks,
-Stolee


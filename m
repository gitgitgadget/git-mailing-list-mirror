Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2CB319CD09
	for <git@vger.kernel.org>; Thu, 27 Jun 2024 17:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719509592; cv=none; b=W90VYsjxvMIWjuElHFwWdr8SKRIII2YLlnEbGqvRi5Nwe/txKk3fwiRqmeI1qiQPZZTTiguDhe8PtX7xNXzNHTYtRAouS454xnJEYLTsPIZw5dYP9C1p5Ker7kSJX4ViMVgKSVuOl7fGfCIG1u9PjAG8isSfYaMpZWE5RSjX3K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719509592; c=relaxed/simple;
	bh=AsI9MEiiNnQutxWvrTXFRQrt48WXwYklhf5OAt/qO9I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oL+yUG07sBNE6X5f8k6Oo7RubX5oYE2CghRRWWilMj/e31EJS1DW4Xf6D/Fz/WnBbEfSKou8bTnuKmApZlle01aLMMvWhfANHd7EvboxEB0sc4Khp+7vvb1cySf7IjuzVhQTFT27upuyEauQyCb/jk6jUGfzO3oZbKE7Suc0HEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XiEYVtaq; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XiEYVtaq"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2c8000cac03so1287666a91.0
        for <git@vger.kernel.org>; Thu, 27 Jun 2024 10:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719509590; x=1720114390; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AsI9MEiiNnQutxWvrTXFRQrt48WXwYklhf5OAt/qO9I=;
        b=XiEYVtaqhL3UuNrQgdGeiL7Ajp7kYr7+hsIrJFiWHLbD+yvU9sCSOYxFJa6XAVUapu
         4Z4PQyeVGoWZMe1jkjdEzaPTRVi7WUsltUZBu8oOjhnh+uMjcpjBd1xFg6/r2kYH57yM
         mMx6w9jw3j+EymfChSk5Juwn0vCeFjX9LbAhI1lZ7WQo1wNzyE7Pogl8KY23GxlCTcZm
         zoTFINZGO8SIWA3c5MLZv3qDKY8q4CR2hLrvoHquuKt/m8xtKA6G8v0kTeSoL5VUh+xw
         gWTJCzadr3F/PpGWaajrALyOHMwNxu26ybutegyYvz+Q5R3xKcY0T3DlyaNY2/4YoKFl
         AhZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719509590; x=1720114390;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AsI9MEiiNnQutxWvrTXFRQrt48WXwYklhf5OAt/qO9I=;
        b=HQAuxGl9+QFAZZGU1hIBlg8ycRuv3mHX1HN95TG4EzD68YzdJVNaMRafSHiyLjQLVL
         kpNyv+2YoQse6keWhF7l56ZxOIXLU+Vpm1CxroeQz21MVGkTEalcjEKZh0P4OGqwO/fC
         b8CIpH4OWPVg+rEIDIEcmHMROSBWyRBpHT3i+7YLOAzh+E9bL8rG4PbmxGQeQSFXC92L
         pED0zRgTs7DFD/A1zRDvII5x5iN1wPlyiqqLgV0lCZqnHB48OYjGMLfAS6Q6+HumR5q/
         uSjEvy+TU06SnjtKWc3Y8FarIA3rh4AbvYYWDtTtmimapro9UoG3/JJq9+zclg44ewOk
         KN2A==
X-Gm-Message-State: AOJu0Yz16++d13tSqXjo/33th/ZR5HaTuv/qcT2ZdQ8VM6EB1isNbbJj
	wGiAkA8lltJEy74Y/3sLpThhAuInfCPIBaNN2lLXd1ygKmsvv/9O
X-Google-Smtp-Source: AGHT+IGhfSLGIYmXWGTGT80pNGN3kulyINyQKOwbbglT5qP5lw+jDrfmxai71/WYA1bGbOyA+sRrvw==
X-Received: by 2002:a17:90a:8c9:b0:2c4:d63b:cde with SMTP id 98e67ed59e1d1-2c8459a1666mr14381536a91.1.1719509589849;
        Thu, 27 Jun 2024 10:33:09 -0700 (PDT)
Received: from ?IPV6:2409:40c2:205a:5198:5f27:d1e5:36bb:2297? ([2409:40c2:205a:5198:5f27:d1e5:36bb:2297])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c91ce17a77sm45739a91.6.2024.06.27.10.33.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jun 2024 10:33:09 -0700 (PDT)
Message-ID: <90640733-a34e-4b3d-8019-a0ee53908946@gmail.com>
Date: Thu, 27 Jun 2024 23:03:03 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7] describe: refresh the index when 'broken' flag is used
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Paul Millar <paul.millar@desy.de>,
 Phillip Wood <phillip.wood123@gmail.com>, Elijah Newren <newren@gmail.com>,
 Jeff King <peff@peff.net>
References: <xmqqpls3zhc2.fsf@gitster.g>
 <20240626190801.68472-1-abhijeet.nkt@gmail.com>
 <03628ece-4f47-40d5-a926-acce684a21e5@gmail.com> <xmqqfrsyv155.fsf@gitster.g>
Content-Language: en-US, en-GB
From: Abhijeet Sonar <abhijeet.nkt@gmail.com>
In-Reply-To: <xmqqfrsyv155.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 27/06/24 21:17, Junio C Hamano wrote:

> to avoid triggering an in-process error and instead run an
> equivalent "update-index --refresh" via the run_command() interface,
> so that we can catch potential errors.

Thanks, I get it now.


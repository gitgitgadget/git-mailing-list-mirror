Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C701A190498
	for <git@vger.kernel.org>; Thu,  7 Aug 2025 22:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754605307; cv=none; b=bLRAZlGmDZ5VWiaREQLtZOdVOTRqBaUpUkfQpLw6X6NEhbuelLBpC/Z9MmFXI4ojicAwwh8Y2OWz1XApf3k4jrnFQ7yevogI1p6EWXag8nYuOd9bTfkuvr3CQK9znjNi2CHx9UY7HosKn4WUdRyzn0DiOhFhrr8zswMp5ZyyZ6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754605307; c=relaxed/simple;
	bh=cN/+kgCpfnzEZnjbcEHOvV3uZQ9ZJMT1MCA5uCVMK+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sEAK6c8iwyee+vuTK/Lzrp7kPqL+crk2InncB114ymJQP8RlrXBNWS/62D1Kjruxz+rXQbPw9jkAzpNxSt8oXnCrzKhiKg2shsVxOnL2e/ZKYLjD/M3sDj1asA6RfyMKxE/B49wmVGOQwiV9WXMAk+Tm0W67aYj8QfVQw9o2zVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=M4JZC6lA; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="M4JZC6lA"
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3e3d238b3a7so12775555ab.0
        for <git@vger.kernel.org>; Thu, 07 Aug 2025 15:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1754605305; x=1755210105; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BslKFtf1uRMd8uKjFtzO0Co6YML+zJld7CIcRSTEfxE=;
        b=M4JZC6lAB6dsyFPAzRHByl2njcuxjmPQTJmCFOTPQY9ExFuVcH07VaWWXkgmcMcWP+
         X+K53ar++sYspMn8VIS8y5aXxdq2/zAqNJ5dzXR7PyEQlhV99zFlz2JGq1w0exB5464W
         eMhr00/4zy5jXuO7G9U5OX8TVP9ZeGk79O+HlMq3xUPmwikhJecmwUNT3tEIsXqRjqQh
         jibyv4FBj+V1E/+3mc5EEumb5UNUuGSh3DbEKs/2A8dtMphqcNDKyX7v0g8nN59T5/dS
         ncWR4T58rKoBBN0HpKDiWqRlvT/VOIQal25v2ofKNS3Cmty7kEXAyeU4mM2+nB7HgQXk
         E5Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754605305; x=1755210105;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BslKFtf1uRMd8uKjFtzO0Co6YML+zJld7CIcRSTEfxE=;
        b=EfgR4Cqs8difthb8gqMTMgaYPPpb5gRymt10G/V2P4bm6OnNHEs6EEtOnxN6CHa3yK
         ifZcNqv6Q2mErUGmwroCodepCM8i34Jt3tqPcPYHRzA8oB93ljGj4LaK4txLX+IxSmRZ
         OP9huq4A1padjdP0gb8llZUuU9aCl1/5ei+umxE/gu7aX7MQ9rd9r3KB9dR94H+6kM0m
         UkzLJh9APuabdkdw+iJp2emFHnYtljxyXe0t3R7+v8Vx5Crw8XlvUK8zlfYnYPm5II9v
         fgulrlVpFVDceOPPA5HqogN0RIq4HWufUVhaKTbUAZaQmVBRlugvQYQ9TbVwKGZJbi8m
         3TfQ==
X-Gm-Message-State: AOJu0YwLjIjRyZth3x09RWJlrbZNnOMl3xw66FwEfvOGVZ48wNZgPYfS
	slpZ68j7xVjwWUZ7oRAKiV5sONPlrrkJJPByw6a2Bqg9H9oYdzkZ95nIwja6iAfWpWY=
X-Gm-Gg: ASbGncuT5RY+IEyjJVL7yfrYpW1rTX1GgKcMQ29UPfXbkRckBqB2EtoQwJg4x5msY3J
	GiR6Nd5MYgsY3AwYFbv3a3NIT4xus+MA3eSAfadHL7IM8KLgBijDLfGxlD9w+xP+R7USCuYPw9b
	IANoGo1fMyhLDw8pNfSqEz5A2M25D1ZrggrQ7SkxpbPo4kXzES9uLK5DfozYgsSdxcsEm0jUzJF
	YbCgVcEF0y2azB43iOB9mWwFivOI1u+s9RiqHDY8z+cvuPvWogpVUp2MHSW6sd5y1Nr+DJD+N7q
	qNtL5nc+xLtUZZjTRmyI1K2PTRQTz7iu4hNVBrVXYF0C2bGOZs5uEoGflguu4Be7IbalwyjuO6D
	s3qVtFrxbz6Gl1YnL1zcPYnTa0k++dUqJtjLJvVd481yNQVQ5hnYEvX6cECQcS/Z/EImDzg==
X-Google-Smtp-Source: AGHT+IH9N/WITnuIc2fCfizIwM0pwcwyc8PC42bTZ1YR1z9+OHcnOm8r+gfyhh9V3SIHIt0cy0h7cQ==
X-Received: by 2002:a05:6e02:1988:b0:3e2:988a:101d with SMTP id e9e14a558f8ab-3e5330d8b76mr15077155ab.6.1754605304878;
        Thu, 07 Aug 2025 15:21:44 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 8926c6da1cb9f-50ae99cec0asm83667173.23.2025.08.07.15.21.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Aug 2025 15:21:43 -0700 (PDT)
Date: Thu, 7 Aug 2025 18:21:42 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Toon Claes <toon@iotcl.com>
Subject: Re: [PATCH v2 4/9] odb: simplify calling `link_alt_odb_entry()`
Message-ID: <aJUm9vU9uc7MaP6X@nand.local>
References: <20250807-b4-pks-midx-deduplicate-source-info-v2-0-bcffb8fc119c@pks.im>
 <20250807-b4-pks-midx-deduplicate-source-info-v2-4-bcffb8fc119c@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250807-b4-pks-midx-deduplicate-source-info-v2-4-bcffb8fc119c@pks.im>

On Thu, Aug 07, 2025 at 10:09:54AM +0200, Patrick Steinhardt wrote:
> ---
>  odb.c | 25 +++++++------------------
>  1 file changed, 7 insertions(+), 18 deletions(-)

Very nice, this was a quite pleasant read.

Thanks,
Taylor

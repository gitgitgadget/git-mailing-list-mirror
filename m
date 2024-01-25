Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E4011118A
	for <git@vger.kernel.org>; Thu, 25 Jan 2024 23:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706226855; cv=none; b=MYtAaIokGPd/WjqoW+Thos2ZYX9V0VKc2ao/qolaEdXU8Q44ZoR6MEwblijg8iUOLDbXz6VDihZVS3C1IkOBKqrFSHWI8soHNl1EQKfn8Y0HXaRCmrNfLeXhvKnCiJU8pxF9K0MKU39CFcahry+cWgIRJri5rPrlsjX7SpWyd1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706226855; c=relaxed/simple;
	bh=scaovjq3E0Cv0us+Ow6vc63ZwjUzujgKtIoAjL79GOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=so8jfj6ZIiKsyxxxRn7X3S8Hg7AAzupd/QVm5iezaNMLZKocp5/94wXTwADl31bB/4RMTGT/LuR5rYsVQBKgwDVoXU05ItVUElUK+ROAm1OoZKMNb73sX43j5iQdZo8Onvzw1QGgbxyXUy/JhoUH7oySJZuqaBp/Pp72dZcCp58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aYekkCTU; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aYekkCTU"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1d780a392fdso21965155ad.3
        for <git@vger.kernel.org>; Thu, 25 Jan 2024 15:54:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706226853; x=1706831653; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=scaovjq3E0Cv0us+Ow6vc63ZwjUzujgKtIoAjL79GOQ=;
        b=aYekkCTU78SeNe/VYOMfbD3CdBZVLRIro8PyFCyWzqmAMUp2p7WyGXZZ4J09sfJ0rx
         MmudajzzZ8KO+bH8CKyc7KtiRJ3Qx/rU4N0RTUZVVXP23RJ49kvtOJU/cOneL4hdcCK/
         MxwwGZrSFz70qnTPFTEvTrbp3IsCSSY7+0RF+Z0bjxXP7Zbg7e4F2jFB8yE3GXRVNMkz
         4d1T7A0hspwouGgvkdsY89bi76Ms9H9QA8dGDrDEUn9pa/WjX8kD1GX7BJ6qsY00V1y4
         QGkI6slV1aZJ5QNF+va1PL0uLmqGBuZEk2wnef3gngIVmOQF3sJER8iKsYuUduyhD5Lw
         zD+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706226853; x=1706831653;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=scaovjq3E0Cv0us+Ow6vc63ZwjUzujgKtIoAjL79GOQ=;
        b=gmjH+AnFofgF5aFhoewJIGhR1VHmUGhE5wNr+Lm3QK7rjNjebTkAlvujm2GREMCHEQ
         OtQxm3m4/4BpgbE7GOBjpd0JAlCyi5IisFbK6IPAFQGpAFG+Whuil99QxEgYvApeEXJv
         67bZO1Kc3yVbsCkT+IcIhs/CxTEYEsKFI+vdASUBsf1dKuXI/nnjwbvZR2sklWgT+Yl/
         E8uMqjljz0hourkiu3eZeKcyR6PINk9xm95kbj9KLtdqF03unrKrYdpp++onpfjFHTNK
         6h74jY/rNxC0lKyYhRySPi6R/N1pXNxVBqDa6TykqV/U2gbu8Go0OFOjHu+IKh9scDpz
         xdTQ==
X-Gm-Message-State: AOJu0YwkLNpVKrS3Y8QX18oWPk8WpEYwAdlW026FrrUVblBipjmoY/P+
	AQ4CMggiRqLD14fEfH/bzrjeyFsVeSGBid7x/kfJJmG7wghQm4QnB3UwkE9L9Q==
X-Google-Smtp-Source: AGHT+IHocJGu+dIGNCM+vZBPV4X5PsmdJ2pmPgqQQH8hp9IQvhALeHT0pgrWfpbeCwqPFAO46sQAoQ==
X-Received: by 2002:a17:902:ec85:b0:1d7:67ed:f359 with SMTP id x5-20020a170902ec8500b001d767edf359mr596832plg.4.1706226853086;
        Thu, 25 Jan 2024 15:54:13 -0800 (PST)
Received: from google.com ([2620:15c:2d3:204:e113:1259:42a9:a0c8])
        by smtp.gmail.com with ESMTPSA id t3-20020a1709028c8300b001d7134d149dsm45979plo.256.2024.01.25.15.54.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 15:54:12 -0800 (PST)
Date: Thu, 25 Jan 2024 15:54:07 -0800
From: Josh Steadmon <steadmon@google.com>
To: Linus Arver via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Emily Shaffer <nasamuffin@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Linus Arver <linusa@google.com>
Subject: Re: [PATCH 00/10] Enrich Trailer API
Message-ID: <ZbL0nyOnUKqIwgsg@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
	Linus Arver via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Emily Shaffer <nasamuffin@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Linus Arver <linusa@google.com>
References: <pull.1632.git.1704869487.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.1632.git.1704869487.gitgitgadget@gmail.com>

On 2024.01.10 06:51, Linus Arver via GitGitGadget wrote:
> This patch series is the first 10 patches of a much larger series I've been
> working. The main goal of this series is to enrich the API in trailer.h. The
> larger series brings a number of additional code simplifications and
> cleanups (exposing and fixing some bugs along the way), and builds on top of
> this series. The goal of the larger series is to make the trailer interface
> ready for unit testing. By "trailer API" I mean those functions exposed in
> trailer.h.

I agree with Junio's points, and I added a small nitpick about patch 8's
commit message. But apart from that, this all looks good to me and I'm
interested in seeing the followup series as well. Thanks!

Reviewed-by: Josh Steadmon <steadmon@google.com>

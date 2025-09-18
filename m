Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0730F34BA52
	for <git@vger.kernel.org>; Thu, 18 Sep 2025 17:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758217655; cv=none; b=ETsk2jjkMD/c26SPz+BHWrNZscy4zPNkOHVoPpwJp3gntjBUV644UevtbulLXpwiRJmzsQWuskDE3SXa2SOR1MBiuawgmYxuqRjDiJbDPHQZD4h4j6o4iJReoy3nP7kutmjFbSJnwvoDlfizTJ7WJ4mtoI6csYoOeoY1Q5VUyZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758217655; c=relaxed/simple;
	bh=6XtITeLMknPuieUZR3iz0ULfmqxVzZV1k/+9BPZGDFU=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AXrUBf+v+Iu7lGioYC45keeGMg0mENsRC9hll/IIL1jCxK9g3nJFnczHyxAOYlw+kYJKx0cPdCe8E77DYLrfF6K2tSwNIoY+6GIZW5+okF/rHCQDmiqaA1MTr3MK/HU9UgTUCkvz7KLiB7dXvMhpxIwE+mIRQIhc4mRuNwoiQJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=UpaT/BDY; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="UpaT/BDY"
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-ea5b96d2488so912845276.0
        for <git@vger.kernel.org>; Thu, 18 Sep 2025 10:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1758217653; x=1758822453; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CMcJftcVy4MWRHTkOZKyJUSSmHXSVF6w35m/k9eQ+jM=;
        b=UpaT/BDYkpSRxGjoPtwohCR47J8uBnr+cT60m5UIus+pMvS7iJBGtcXwr8MukF1FBs
         aUE35jCL5VRUDiB4huwlt5RgEoKBjrsneSBgNNF6+2MxbBDunsN9/kq/L8n5ZzQHSuIP
         kplrDn54GyPzX/nnoFB9xtzIaM1meRG5aDeCnnqAJzg5B5se7M4UaVTHYtQXkGmjyp9Z
         VtmZy3kQlcRJ0JpeSq/hn4H/1mhAAsLl/aphT6IqTerWRe8YsqvWdyLmigKx5wzJICBB
         qTFDm+dNFfDNO9qyJBXNI8kc7U+4rNfCJRIPDx/PcZ+bXwc9hlH5Mv4qSQfzitwyvfww
         bVog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758217653; x=1758822453;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CMcJftcVy4MWRHTkOZKyJUSSmHXSVF6w35m/k9eQ+jM=;
        b=v5IjMSV8ZeIzYireHNFERHGKb3FrTZUitwEVbMt7nCSdzkPbO/gjgQrVccxU6WSqxH
         wHYWI7EyN3G+3qr+hi3+st0IH/cPZe7SYtv+WGBPMgNei/zgflP7N05dejzsUsCy0Z7c
         9VIXPaqdQuir7GiRpxyqUE6ikEnvckimb3A+gmXOkgPvSDni/yPV0f+qZUVB/00qJFHC
         gD5Vi0lcWtVAwO/0QB8aDYuDJm4TyYEfpCnaaGWmp+tfHmsebSej/fItt/WFO6CaZoml
         ZAQ1AZnVqzFQnSrmayGCixZ4F9B4eAAj6jQfIzzfdXRulhpvgQIXGUmrdJ7jmCYVqPLY
         gCWA==
X-Gm-Message-State: AOJu0YxleASvvmtv9+Jf/5905dgGOMF+cG5jkt1s+RI6uTe3gB/++wqV
	SM9ueBjwpaSLTIvvBGtA4piM4DajinbAquBRoKiDtaavSuGznoaJS7qUc3JzxkIOvlJHcj16YxP
	4QSaK
X-Gm-Gg: ASbGncvgHoGFytn7TYBnNcGT0rh88WnZT7ETzN+28R6Qk2lTOoicYX14aEuSJv97Otu
	sMxgdTHLzk+cYK9tdog14g4lrfa4CibguEzW8q3qdwqUx6HCPgpVGW5nRMZCPzpkUgd9n+UMxDB
	ZhPVAdMQlKvMdAF9u0Kinc8+I8f5pkaypnzgjS8a/UjnxzTz22LCDQNidpxi+VFehLH72+OxUtk
	67YEkZfNLirzERM7iOUdO54vZtqVvTrv550zTNerAUxEj4Q/+wmM92rXcc9s6H8MaPT5XO/4hfj
	jIS0IQ6mBzYszBz4GrjuATRZTbp+57M2BMPuVY12rIN+w4fZ8+Dk6O9Ssm1PLYMFHn8/fZz1gCc
	i3bDgC9LBkzKkjjrWYWVcpXPIis+8aHR1Bq3qgneZiL21926z5C0/gTS/d71ST0qugx4IJJfzts
	Tnctkh8DLPJEFBE8tNMim5/eBFYwC5DNB/1dqUGID90Vt7
X-Google-Smtp-Source: AGHT+IFAGD8EdlwWxwbCrToF8LMnQnx62NOkGCQNKb7ZY4adYgxyxxoNuzPfFQenA8sCAl6U68F1Tg==
X-Received: by 2002:a05:6902:6010:b0:ea4:16c0:61d3 with SMTP id 3f1490d57ef6-ea8a92fd4a6mr250098276.47.1758217652474;
        Thu, 18 Sep 2025 10:47:32 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 3f1490d57ef6-ea5ce973daasm991620276.27.2025.09.18.10.47.31
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 10:47:32 -0700 (PDT)
Date: Thu, 18 Sep 2025 13:47:30 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Subject: Re: [ANNOUNCE] Contributor's Summit updates
Message-ID: <aMxFsgsF06/nF72x@nand.local>
References: <aLDEPRnXqazmxwzq@nand.local>
 <aLDHLMVmdskbqIic@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aLDHLMVmdskbqIic@nand.local>

On Thu, Aug 28, 2025 at 05:16:28PM -0400, Taylor Blau wrote:
> On Thu, Aug 28, 2025 at 05:03:57PM -0400, Taylor Blau wrote:
> > If you haven't yet registered for the Contributor's Summit (whether or
> > not you are planning on attending in person), you can do so using the
> > following link:
> >
> >     https://git-merge-2025.eventbrite.com/
> >
> > In order to grab tickets for the Contributor's Summit, **you'll have to
> > enter in the special code "git-20-25" to expose that as an add-on**.

Another small update: if you have topic(s) that you would like to either
present on or discuss, please **e-mail me off-list for a link to a
spreadsheet to collect a list of topics**.

In the past we've voted on these things ahead of the Contributor's
Summit, but I don't think this was very effective since it was hard to
know when to stop accepting topics and when to start voting on them. I
figure that this year we can try something new and vote on topics to
discuss at the start of the Contributor's Summit, and then organize our
day around that.

If others have suggestions for how to run the day, please feel free to
let me know either here or off-list.

Thanks,
Taylor

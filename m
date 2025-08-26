Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB6E1EF091
	for <git@vger.kernel.org>; Tue, 26 Aug 2025 02:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756174316; cv=none; b=jz7qu9amDR3qiM2cR/9Z3uzgG4/fwS+CY1fisa4nHEE2RuiNh19h7rDxaOpxwnu4Fp0uT1tWfh2je0eThV7ZEQQCRTxLdabZgwhzq5wKJYj021OG9C192nKw0qJ0Tn/KZBW5RFNQn8ONpyG01c9jfflPrATwIcUxh85zFmsqE4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756174316; c=relaxed/simple;
	bh=CNurpDrnndRxBRSuSzO9tOp32c4RAw07IQeFB/0ZXk0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nPjih5ppbOdR/wkSh4ReA39FsEvL0GmgGjE0Q8sOqBnj6Th+xLPA/aVa6QKULqo5i5qx6uiJOzTufIt5PF4GvY6lqkeSCUJdqYcfAlB3+JubNNC0EEIyv556C+cNumrWpDqXRb9PZYPrZAUqCEI1Stc2ivntC2EdSfkZ20FKTHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=BAtsDQTZ; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="BAtsDQTZ"
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-88432e31bdbso445824039f.2
        for <git@vger.kernel.org>; Mon, 25 Aug 2025 19:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1756174314; x=1756779114; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CNurpDrnndRxBRSuSzO9tOp32c4RAw07IQeFB/0ZXk0=;
        b=BAtsDQTZIAzwqbqYLDsOAqVtwdp9NY1L9vV74Bd84cfV3OaBy9HXltzF/KHeGBFYB8
         /HyeWFFCq5sWMc468A03U9yTGFTjD77X5KLJVUASoMQYi52XOaYJipJ0s4Fj9ZFBWOup
         Jan6+wfcEFnUiHUKneTfJxvGxksor+DKigRFHa0H4ewXgOBOmqS6apR5GP54pD293LAg
         8cOn2PTDlF2mNA5IjxtngENAMc4YupsjMvtBbWceMhj9nL8Hdwq/rgVGxcODDf+OqeSf
         nYOHpdCiVMckzRg/P5ggLgj3qC4EfwiYthB8409BFb+tVokYrl8bDjTWXXOYITbFAlY3
         S3Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756174314; x=1756779114;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CNurpDrnndRxBRSuSzO9tOp32c4RAw07IQeFB/0ZXk0=;
        b=WSY5N4YNKxF0tKZbbbluDIJSlWD45Lm0xROnXyTwk0dhUNGqpOXVedjDoYOeVN/z+j
         TE39wV2s0sJRETMzCdzk1sBzREYq65oC0A42/B/qYIyAMnKn+HFJnnk13A69b8c+fLGy
         L6WWApk0Avb4Fq08dTiwN5Gd46Cj83mqme0yqP3NHXX5Nm5GIBvBAsmsTBosbvAC/4d6
         aL/NHvxuQFJsfpstaGOsPHYgIU9hHVQLIsVJYoX3OKsAvz1bsqRoff6V3DXTTUKlnIHG
         CIECdbdEAXKuWrs+sIhCLwUTroYYoOUgN8nfyo4o9/Ac2XNY0VSfXcj8ZeTrv3IUHl86
         DATQ==
X-Gm-Message-State: AOJu0Yy4wpmBpO7uol3QHN3xKAlN+J2B4mh1TocQlzRGV0lV+ju9dBw3
	8TamT0MpLXY4vFWAVXCR3dAs0ugqbnqjsgztFf7xTw6Qri4FYVVET6NTaypRigyJCjo=
X-Gm-Gg: ASbGnctklCVkJsgDJWuWD5wVbOgnPlU4nRaxUqhYSkvf9/alKdad0bzBeHmXFc5TlE2
	S+IGQn+CQOW/CGxwKcn9GckK/GWdWBJvomnhzzuqrlU4SDBDSCOGUlCN9lFpwqWybXxaMRvAXfU
	QlvDOoY6T+GPp4FJzjQG2WcWxNLmamrPPPntTILnSFq/OYVWwo9pc87UcFYyKFnJYXdfGJiDDwI
	QQKQBiOKsT++Xrt5YCaFdCYZXStGDr7zBcX9OTpvj045PlZ96E20OLVp4P+oyYqPQMIUWo7otvJ
	/RBh276M4GtoLPMv6VkWDZpDiRFQ0Cyh0MYiuV7kGxBOqhvjfzbb4eXItVsms0OyYVC84t73dY3
	3xwgToG822LQQGVwPShM8qgiKF7MPySFR9eMqsWzsUuyPmYSkkebpadclC5t9v+ox+A5bYuuuVq
	/MzX1O0qOcX9BsZyuoC853NmesYw==
X-Google-Smtp-Source: AGHT+IHUzWMD+e0+0MgbU8/DnP4m2HESgMhCIrVAcPJEAfGPuYxv8rBbhl6NaGTYk5w8jl07jS72NQ==
X-Received: by 2002:a05:6602:1684:b0:886:c53c:916c with SMTP id ca18e2360f4ac-886c53c9398mr1517438539f.17.1756174313711;
        Mon, 25 Aug 2025 19:11:53 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id ca18e2360f4ac-886d9cad307sm292108639f.3.2025.08.25.19.11.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 19:11:53 -0700 (PDT)
Date: Mon, 25 Aug 2025 22:11:52 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 10/16] packfile: refactor `install_packed_git()` to
 work on packfile store
Message-ID: <aK0X6FF/vX9kujFR@nand.local>
References: <20250821-b4-pks-packfiles-store-v2-0-d10623355e9f@pks.im>
 <20250821-b4-pks-packfiles-store-v2-10-d10623355e9f@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250821-b4-pks-packfiles-store-v2-10-d10623355e9f@pks.im>

On Thu, Aug 21, 2025 at 09:39:08AM +0200, Patrick Steinhardt wrote:
> The `install_packed_git()` functions adds a packfile to a specific
> object store. Refactor it to accept a packfile store instead of a
> repository to clarify its scope.

All of the refactoring here looks straightforward and correct to me. I
admit that I have a vague preference towards keeping the word "install"
in the function name here, since it (to me) suggests that the packfile
in question is going to be used for lookups, whereas "add" is a bit
more generic.

I don't feel strongly about it, though, so if you have a preference
towards "add" then I'm fine with that.

Thanks,
Taylor

Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED051DA4F
	for <git@vger.kernel.org>; Tue, 16 Jan 2024 20:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705437448; cv=none; b=WfWyXNmATqtPrLVKY9vcNis5n8u5jULlfEeykJH38sOPDXPe0zy+yh3HfXrrmC6Nc/eEtNNCB4e2qu/8CNVrldMqJfXHXqgAhCecC6ZY80Ds4IJgi/JgL+vNgm6gJSfh9eDthpGt1oSCl5DA3X4QHFPetyKApPGGcHbebDCU3pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705437448; c=relaxed/simple;
	bh=yDPAEVGXPw0HuhHzPKjEsKusiX6s5hYWkMl5Z4KkDMs=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To; b=X3WhCun2B305VgpzKphKKewOExVCnJ4fkW5/fx5c+deoUJphtLcIKPF5+stZ+6e/mb2Nw8hGEzXFXw830eVkOWuVyJZjN+tTx776yxfzNMCzyQAPsNlSs+FjYpOFy1ZEXJcIqMteNZheAiMys/aHy65jTXRGIyHwIftxgpEGI+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=niIXoewt; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="niIXoewt"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-429fc7a1eacso12346721cf.2
        for <git@vger.kernel.org>; Tue, 16 Jan 2024 12:37:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1705437446; x=1706042246; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yDPAEVGXPw0HuhHzPKjEsKusiX6s5hYWkMl5Z4KkDMs=;
        b=niIXoewtt+Pyp7eYMzD+xWbaco0CF93s2TasQqmFOx8Kwr/oE2H7mBNIMxaixdZa0f
         JhJy9J2/jqisT2o7hF+FZLVMTcMTMeJ64m0UCeX/c7xfTAvxVbOwCVnAelxdMjq2Ztvm
         931mUy/5Q4e72cAMuSsC7K/WGpvBFHt/nvuzIRQl4vznvMBDOuNF5rbzaxYRxvHnV1oV
         NX1l5Gs5V7jCFihPne60rDdoHrMZMOrSaF3i58YK9IZCaOEXHLeRN4EBnqI7qEhLj92t
         XVMpcIpU280BJDB0MSVwG7zs3GU2zUd6iigv3EEVfS0IY3W5v48/4iKY7wNHdp2hnx8A
         1gLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705437446; x=1706042246;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yDPAEVGXPw0HuhHzPKjEsKusiX6s5hYWkMl5Z4KkDMs=;
        b=rEcJYuh38r9QDXNCi3rkBDSRuLYKktwBHh4t5G35DQfuL/GHbJ1Z65KiZub49dUNgd
         gn98kkRP4ZdBBDCvlitUxQdtyzIsmUHihsKSSyyOj8fJW1LgZNci1TXxaJYa0EcYYX87
         3jKpWzGcoaIm58P7Rd0ZpMD/j+BaUCN9Has9BBJjP2++SkuZ9mlN2ztSpBvWxL/+TIIk
         5Fzh07NQDvq3e4zhVus6+avYDoiGKiSBRkKM/VVuU/2xdb6kGBt4tXv5o4qiR2phgWq/
         KIDN6YhNOGJJAX5Tt0CmvcyUoGlOA8W6kWgKbwHrBS0sCfjBFLWH3J5hWSLfUkkRzMcR
         pi3g==
X-Gm-Message-State: AOJu0Ywg3P/n9fL8wQ3QGoH145DyUZRUvs2v90oKWKj3i1Qxw+4c/9Mu
	/B6OnwSl6wSjxu4W1Bn3stJU5rLVh9SdtQ==
X-Google-Smtp-Source: AGHT+IHY4HEKRz90BTAV1lEUDkhRbj06zAUwaZsct9n7ugearVNfM/4NFqX3Im0GImpAQG+bYHUpxA==
X-Received: by 2002:ac8:5c8c:0:b0:429:cfbd:20a2 with SMTP id r12-20020ac85c8c000000b00429cfbd20a2mr10539991qta.4.1705437446019;
        Tue, 16 Jan 2024 12:37:26 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id hh12-20020a05622a618c00b00427fd4e1710sm5143849qtb.0.2024.01.16.12.37.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jan 2024 12:37:25 -0800 (PST)
Date: Tue, 16 Jan 2024 15:37:24 -0500
From: Taylor Blau <me@ttaylorr.com>
To: SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jan 2024, #01; Tue, 2)
Message-ID: <ZabpBHBB1TXIXJLr@nand.local>
References: <xmqq5y0bcjpw.fsf@gitster.g>
 <ZZWOtnP2IHNldcy6@nand.local>
 <xmqqa5pm9tnx.fsf@gitster.g>
 <20240113183544.GA3000857@szeder.dev>
 <ZaMJU6MJ5wZxyLeM@nand.local>
 <20240113234134.GE3000857@szeder.dev>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240113234134.GE3000857@szeder.dev>

Hi Gábor,

On Sun, Jan 14, 2024 at 12:41:34AM +0100, SZEDER Gábor wrote:
> > In any case, here's the patch on top (with a lightly modified version of
> > the test you wrote in <20230830200218.GA5147@szeder.dev>:
>
> I certainly hope that I'm just misunderstanding, and you don't
> actually imply that this one test in its current form would qualify as
> thorough testing... :)

I hear what you're saying, though I think that the interesting behavior
that would be most likely to regress is the transition between different
Bloom filter settings/hash-version across split commit-graph layers.

We have extensive tests on either "side" of this transition for both v1
and v2 Bloom filters, so I'm not sure what we'd want to add there. Like
I said, the transition is the primary (previously-)untested area of this
code that I would want to ensure is covered to protect against
regressions.

I think that the most recent round of this series accomplishes that
goal.

Thanks,
Taylor

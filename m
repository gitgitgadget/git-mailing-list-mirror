Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8053F16F288
	for <git@vger.kernel.org>; Wed, 12 Jun 2024 12:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718194261; cv=none; b=Cr6qGtR9bDArEZ4oVAJUREubNZQDmGIKYjcPrqweYHCHbxosc2eqeMBQfHRvg6eImmP016FYIRXpkAi8J9Mk8glhoFMHsX9tMmSG6ppFL/8uML4tgRjAiW0t22wwIHq8sI8mBE0pipNfWBnwemIHjdItr3LEViMnLASY7KMQSmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718194261; c=relaxed/simple;
	bh=Qqkv2Mna5dRksai9NSsGmjeXre+tk/sgLUFwyIMqle0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RndUagSp16ysNfJY262WE+9eey8XAuu9oo9V7xnuB2fvxk24kVQe8LSnBfYCQAmJxP7ZSNoVVdAOtY8dHyXWGzQ+yGl+b5pJnK6FbItUa385MdF3lBJ7KrDT0Q9KoekT2DxWwpl7De8+IEpWfPhKHnmVaE8Rv8nKuS6saC8SUHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CS1muVKJ; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CS1muVKJ"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-6f8ef63714cso1228643a34.1
        for <git@vger.kernel.org>; Wed, 12 Jun 2024 05:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718194259; x=1718799059; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nLsLSaKh1N1e+SxxOGBEtWETCkH5tEyi8bZuDv9NGEw=;
        b=CS1muVKJ5SV8ldKHCXtLJreo4WHtQdQBG+B56OTqf9v0e5E3jViL71mMDUp0PYlQSZ
         KCcxCy9RxoOafYrtT12oRp9oth7wGeA/xR81eQMqjpSDDRJoT5JEvT44aa9vv9FWu+Kl
         L2xy7IxI/Ea1hkRiQ+HN+aAEKNL0MWSC+IyHR2j7cbeeFHNLC8kij8zINoXmSGPFVtfP
         zJYZyoxY/fbr4Aa/cr+nQNPJ0YtcITaqxQgzhT+gkmPfVcFsOm/y80SINDj6S7fSGuYv
         oMl4sMxF8mzlLw9VElw8g1XBRZv0HhKkk8++nWwRzn1NBDAGulkWLXg3eoWoDjB2dAYN
         hcSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718194259; x=1718799059;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nLsLSaKh1N1e+SxxOGBEtWETCkH5tEyi8bZuDv9NGEw=;
        b=ZTswo962ecn2VyNZu0+rrhaukG+lLJR6ZfP6gbPX0Zpf+d3uTmCNZRFKLqyPYslnOm
         GRdtzz1qiHt5UHwx1BuUhJAP+PWLBvKF4X59WTEvUDxI9RcYdJLBRC1wQ9Au5Oglx+Mi
         YGfUVGvvzkI6H1sFQHCwm09akn9xkBeMsCd6f25jFkwiaTZFYozVBnHBj18YrKUpX6oz
         LP5q9svTT7fKHFDbZTVw2FZIz+9y5kAjax/elKRYkF21i9fYyxBTu9duMbYW9xqHbsUO
         oR9PdMNDZq6oV5+KEN9a1nnszmpZMF/yVTuI9YB50NCGZ1PTXg9SxhHebSh3CedAlL+c
         Z5PQ==
X-Gm-Message-State: AOJu0YzoqfJg+1SpSQf7crxaMBzJusEM16bmtqap0oI+J3Xiw1HeLsUV
	Wxv+rkydb8tD6YIidUGoR3/6Sev1e762gdApq2EmfTUQyGMBaRWqwyRMQw==
X-Google-Smtp-Source: AGHT+IFU9MQ17rfQgSkV4PozC0hHdm9BYdJnIFZymLgvKdSwbgo3RKl/ZYY8HihDqEh3BY/AAE9oOA==
X-Received: by 2002:a05:6871:3a0c:b0:254:de02:4c65 with SMTP id 586e51a60fabf-25514b4cb41mr2015696fac.6.1718194259051;
        Wed, 12 Jun 2024 05:10:59 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-704268073c9sm7598030b3a.178.2024.06.12.05.10.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 05:10:58 -0700 (PDT)
Date: Wed, 12 Jun 2024 20:10:57 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [GSoC][PATCH v2 0/7] ref consistency check infra setup
Message-ID: <ZmmQUUXEeG6d8y2f@ArchLinux>
References: <20240530122753.1114818-1-shejialuo@gmail.com>
 <20240612085349.710785-1-shejialuo@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240612085349.710785-1-shejialuo@gmail.com>

Sorry for the confusion, I wanna emphasis what this series of patches
replies on.

It is built upon on the this patch.

	https://lore.kernel.org/git/cover.1716451672.git.ps@pks.im/T/#t

Thanks,
Jialuo

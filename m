Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 757C42E3E0
	for <git@vger.kernel.org>; Fri,  3 May 2024 18:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714761831; cv=none; b=dPz9yJKh+941obd/Ui0CiKuDi2ngeLaP2dAhTgmBY3dXv1C4tCDOnXOaTL+qLPJ01wE9nngJstvYi6TZP8yQggRjSCqueOPuhp2K4tpl7xfzXB11PbgOLFrCUA9XY2Oqs8tx0gn0IFFAi207zxTBLoMh5insUCAorgUu3opzEVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714761831; c=relaxed/simple;
	bh=oLr3uY2goWAm4HGqaf/8qr4+2muStNEDAWNbll2zpc0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qzmez2+1kMihsoeCaPSeqpIA8zbrJhVdcFv5luEHmoON33ZfRWvIwCZwmt/1SzEIdN0esW/tvpGyd42GM/zw4WZXnQshDESt+INI1qgeWM/9nHEyP8ujyfWyrRgkuscv2eig4Nv11dpAJ+IQakyqsntPPzPVSnd57++u2Lz2tU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HGdoIP8J; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HGdoIP8J"
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3c74ff209f6so5798812b6e.0
        for <git@vger.kernel.org>; Fri, 03 May 2024 11:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714761829; x=1715366629; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=isb+VnERQpYhf5C4qrhjRKhgZtAekC4BC1RNJzQt0Nw=;
        b=HGdoIP8JMCeznRlX6ft1fjMzsD+7nZoBtRcNIkpyJQ2SrX9TpV6Z38/LWdLpbUCOm6
         YxC0FVv6MXMGu141aipFlYUwyYlOlxzKE9WnipHYc7WfNP0RIzZw3xQSXVT+M5wNrcdf
         peJWi1vZ6LVZzTu0XjklUdiqSKPjJc3OcJMb2Pz4wVfXHtVbYxnkkIOIHrjyCHBlVKok
         qOTnH9Br9TEDAejL1gqq9f/XwtJxK0DprDl8TogiCUDXDZ+OdWbkxgeGLrbUbmJcqOfe
         BrOrTuQobVxLcjNDK2EmhLrglqAzCYfL1RQ6zp36LhP4ysfHoX4U9knK90vS1HSYfF4K
         lpAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714761829; x=1715366629;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=isb+VnERQpYhf5C4qrhjRKhgZtAekC4BC1RNJzQt0Nw=;
        b=vexJ1TjwDwP3UD1mFJt9aA0AAt8oUXu+dyqnyCZQrg07Pz5gurEhAukNNXJHFyTiki
         yz+5K8hgpQ73pdtsv7ApyRqq7zk6lhFvJFY0+cWxgK+TXm9R/7B6m/R8mS2NznwmjY5U
         9KB3qKGEh0V7ecozgD5xcgqW4vIeMOTFecdWfHGuVhAk19KiXrdBW1dadR+TH8u2oj10
         Irm50v/FTT6KdY2ef8TfIAKu9hXFAUNRYowKyNMAh3U93Rlv1zYxdVq/m48P0f7amltg
         7Y90MHeUwPGW9826v9lRR9kfq0E6KPVzOTxIYy2zIalqcWgSLri3pHQ0B/7iFYZ1/Kfs
         4CXg==
X-Gm-Message-State: AOJu0Yw/n2VSqpnZKB3c0HxZPhcN7bWcXlQBd/I/LnCTgTQDLCVAOxib
	9Jsim+6qmLCV4OI8YYpXEoRnX6F6OEGQBuJXplsmaTqQqa+PuwNUzc+QxmIB
X-Google-Smtp-Source: AGHT+IETYPtrRPmkb5BWDr+7MomJPOWxVdOr1ZZnvZJnpaWsqbhYBrx57mVzBWS97yfQt5/JbisFHA==
X-Received: by 2002:a05:6808:15a9:b0:3c6:943:e0ad with SMTP id t41-20020a05680815a900b003c60943e0admr4725601oiw.51.1714761829619;
        Fri, 03 May 2024 11:43:49 -0700 (PDT)
Received: from localhost ([136.50.225.32])
        by smtp.gmail.com with ESMTPSA id ec18-20020a056808639200b003c8643f0e5csm598960oib.16.2024.05.03.11.43.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 11:43:49 -0700 (PDT)
Date: Fri, 3 May 2024 13:42:32 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>, 
	Josh Steadmon <steadmon@google.com>, Luca Milanesio <luca.milanesio@gmail.com>, 
	Eric Sunshine <sunshine@sunshineco.com>, Toon Claes <toon@iotcl.com>
Subject: Re: [PATCH v4 00/13] t: exercise Git/JGit reftable compatibility
Message-ID: <x7v4d4siixs3wllzycibxtgsqipnwohhyxg72zvcxboucshd2t@won3yobvixbu>
Mail-Followup-To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org, 
	Han-Wen Nienhuys <hanwenn@gmail.com>, Josh Steadmon <steadmon@google.com>, 
	Luca Milanesio <luca.milanesio@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>, 
	Toon Claes <toon@iotcl.com>
References: <cover.1712235356.git.ps@pks.im>
 <cover.1712896868.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1712896868.git.ps@pks.im>

On 24/04/12 06:43AM, Patrick Steinhardt wrote:
> Hi,
> 
> here's the (hopefully last) version of my patch series that introduces
> Git/JGit compatibility tests for the reftable format. Only a single
> commit changed, where I fixed two typos and added a missing signoff.

With 35e293e6 (Merge branch 'ps/ci-test-with-jgit' into next,
2024-05-01), I've noticed that a subset of the `test:linux` GitLab CI
jobs have started failing on next.

https://gitlab.com/gitlab-org/git/-/pipelines/1277877090

I'll take a look.

-Justin

Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 557C62E62F
	for <git@vger.kernel.org>; Thu,  4 Jul 2024 05:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720070518; cv=none; b=Hycp2Oj4H6m7v/60RTjjghSVVtitpEh7brJgAEVXYns31NPed6pfpH8lQ4WZG8nyxLew3jmKpfiHTk3Ka2p6jNOFeJqXf4nU8IDM0fZncL3N6HDc1/QWAskCoEL5/TF3GDNMr7wGO/t8R6h7JHbRjUPHStD2gTzdmmLv3eloAxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720070518; c=relaxed/simple;
	bh=FjDJfAgmD/6sGp03/ip9Bpz9gTMqyY9Nlz4+OK+NwuE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JKUxBJqPe+qz5j/hXVBXChrR+hpAZfE00UNKYwnYoljoS4RcRaCVEuR/A7wsZREm0t9O1fq5XBZZTSLjNrXuo59H8wRuwxDoHxpK1P5pUq5uEGyfmy2zSYIfd4AUxXGT+1QvwIZnZ8lug6X1Qfa3bkNJlzTTKz2aB6TWdC7yI8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GmlLvmS0; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GmlLvmS0"
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3d853305abfso175254b6e.2
        for <git@vger.kernel.org>; Wed, 03 Jul 2024 22:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720070516; x=1720675316; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :references:in-reply-to:subject:cc:to:from:sender:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aWCwgTdqSM0iMxFFdFm9R0HDjkPCkP0hbj3vaOSCF40=;
        b=GmlLvmS0bl4k+MMIwD3vuErV53Owkh25D9KcgIXjqDJw3QfYM859bsd9jHWXEk07BD
         UBrFuMz72phMlKVP2GSDFnITbIgBBjwffqBezxwmnoCHQEZXtJtG1GKal75l2F+lKbXd
         3rfN5H18KKlA3ufAFtpHmPxFyKoJ5UNecCHD7n3uCwaGZC8Cc57mFiZ8a3fCTLAeDIlu
         nm3oMoFY253g251cIdDcuzaoP5QFtIwbv2NhsLDu1/47hqZFRXX3KXWFsL9Mq74VWEeY
         /NlWkv66Rqo/F8dBVHLFfrSAv3OD/8VJqJ3LK4UiKX9h19F4CSfb8O9aTfOZpF47IOkO
         +EEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720070516; x=1720675316;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :references:in-reply-to:subject:cc:to:from:sender:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aWCwgTdqSM0iMxFFdFm9R0HDjkPCkP0hbj3vaOSCF40=;
        b=BL0wYq1yvFFevQUYlhBggYia5oS8ilZVndSBbc5gFlag7OfJ0k73YUVXN+ymxGX44n
         zHBvKeRMr8X2F1lWlsnOlYDZ0JJu+fH8DRzp2YbKJXUmSfrm0GW73CVDyOSnXhh2uEPl
         2sFV7wuKsujPUw8MOEaEJJMDJmz7gra819bShRQ750c1sW4YMQ/IP7LYFbSC5OVYJA23
         v6X6U2XmiVbiHgoEKPENFJF9o8dGP0W3wAeJtONULNKk71oO4jgTPDvsdItdH+ezVWel
         3uBts9MlGFB1NACFf1L2GHQyo2gEFtRaajcJYKExBcSm0Pju79LWarkKqiTnB95VHa49
         qZjA==
X-Gm-Message-State: AOJu0YxVm6uCM656ajaKonC20T+1w4oV82C1c03+8bPxbLr3C9iEQhRy
	PTSCn3xBDP/CLmRAjmgZukSMtCm5Q7yx3c7i1RhqWksxxCjHKxvJ
X-Google-Smtp-Source: AGHT+IF1odg+1GDjEnC2IoUFuXSOPX4gDfLB3/8BTUj7WqqVTPwoRqkvo/IA/Erozz+oWOg0hKGP6A==
X-Received: by 2002:a05:6808:a8c:b0:3d5:5ed9:b92 with SMTP id 5614622812f47-3d914eae90amr512943b6e.56.1720070516209;
        Wed, 03 Jul 2024 22:21:56 -0700 (PDT)
Received: from localhost (236.219.125.34.bc.googleusercontent.com. [34.125.219.236])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70803ecfafesm11297886b3a.137.2024.07.03.22.21.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 22:21:55 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: <git@vger.kernel.org>,  Johannes Schindelin
 <Johannes.Schindelin@gmx.de>,  Eric Sunshine <sunshine@sunshineco.com>,
  Derrick Stolee <stolee@gmail.com>,  Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 3/4] gitfaq: add entry about syncing working trees
In-Reply-To: <20240704003818.750223-4-sandals@crustytoothpaste.net> (brian
	m. carlson's message of "Thu, 4 Jul 2024 00:38:17 +0000")
References: <20240704003818.750223-1-sandals@crustytoothpaste.net>
	<20240704003818.750223-4-sandals@crustytoothpaste.net>
Date: Wed, 03 Jul 2024 22:21:55 -0700
Message-ID: <xmqqjzi191fw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> -Credentials
> ------------
> +Credentials and Transfers
> +-------------------------

I can see (and appreciate) that you struggled to find a good section
to piggyback on, instead of giving this topic its own section.  But
do these two make a good mix?  They seem to be totally different
topics.

> +It is important not to use a cloud syncing service to sync any portion of a Git
> +repository, since this can cause corruption, such as missing objects, changed
> +or added files, broken refs, and a wide variety of other corruption.  These
> +services tend to sync file by file on a continuous basis and don't understand
> +the structure of a Git repository.  This is especially bad if they sync the
> +repository in the middle of it being updated, since that is very likely to
> +cause incomplete or partial updates and therefore data loss.

A naïve reader may say "but isn't it the point of these cloud
syncing service that they will eventually catch up???" and we may
want to have a good story why it does not work.

    You create many objects in one repository in loose form, cloud
    syncing service kicks in to transfer them to the second
    repository, and then in the original repository an auto-gc kicks
    in so some of the loose objects fail to propagate.  The packfile
    that is the result of auto-gc will eventually propagate to the
    second repository, but before it completes, the second
    repository would be in an inconsistent state, and especially if
    the ref updates are propagated before objects, then the second
    repository will be in a corrupt state.  It would be a disaster
    if another auto-gc kicked in there.

is one scenario I came up with.



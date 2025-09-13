Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D065F1E9B0B
	for <git@vger.kernel.org>; Sat, 13 Sep 2025 22:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757801599; cv=none; b=Xlxf+/zI5R3lqz4o+2QuiHMVn08vbb7BJLhyWBaY7bOBeLT6ojS4vQ6FIuj9J8kVlxbU2IIaJtq2U/7FL//3J9zEY0wRRerRc0S23fW9aY7jS14gDgOm9ZBiamAmhR5AKOSV4EHOiJhLp+aHUzMZBQHm/l8svSw81TgX1j2XBDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757801599; c=relaxed/simple;
	bh=udY0Jvq01/H+tnHnIkcyGACkBCE4ITR/bf9vkNaLaoM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ii/eVOn2SQtoCMXW9CiigDpI5drt69w2tPNW3qdVDHI5AD3SbH7kt85xOGPUJ3/ecdvCNjDZYisHXcsgDdCARH8GHJ+w3oBXTSQAzIGyZvhIypEopWnaVCfr4q6mzkJ5ph7RAa2GWZSqbif+IXMNQjNc37ey78xHaus5c9SM4rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qj4NZo0S; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qj4NZo0S"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b54c707374fso56489a12.1
        for <git@vger.kernel.org>; Sat, 13 Sep 2025 15:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757801597; x=1758406397; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iqXKNkfKk0YRah1n2j1j7mNGGsrp8qxPLOyM1FI7BAI=;
        b=Qj4NZo0StS7Q8VP+0bECfbaq/Dje3vggGmtlRoNsvioOAUmN65Ni3tg2bUuUPq1ysq
         u4kN9IYhCcBRuzd5nxIGL/LuOawCOM2WhhBbNPlGrr62zJeVCZqQWsBHLM+mflnkpFoZ
         u/6S+rfkCRaG2X6ISFbUCVkbR4QoVFNkXQI7jdMV7H0fcqXPSDReVBJ+MsqH1Mob9bmP
         0hw+XkA0VtLXRA7wcVxrkYWtEtVE6fY7aRR3cw5hr/E0GQohM/Ro1wwr4KvmFZEcjtyg
         6mZrDCjuEomi0rRWRLd1BsHwujsKOYBaC1kVP0s06XlD32Yn5WrgypGzBk1vkicfeunY
         hpQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757801597; x=1758406397;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iqXKNkfKk0YRah1n2j1j7mNGGsrp8qxPLOyM1FI7BAI=;
        b=q4vrI4lqO9yy6c6oyQ7uU62ZqVRmlIwfBZDbJyXk4mJJua7Bnt1iaEQdZb3vxLIa3b
         ysAFIP8BL42YcARBEJQSHS0Cyrot3llZz7T+DXZpcsMXj8UJ9SinOtI/fNkUrvctpcoF
         pS+fuiZfCHTlJ7UVinUVOu0pXfQndYwfyP/YTJ/dKrirhih8gGaPzjavlozAuRagMwzk
         uaYcxr9HyWexlJYTLWcjnJ4ow/h2jvk3+QNDDwhtP/toMo8Or+LnSQk0DrAxYvPLEhPz
         vJqXVZQCB1lFoDAGEscsD2KzM73A8fnoOckY9T7nrVSC7LmJY0LmcdCg9frCn1AH1h9w
         0sdg==
X-Gm-Message-State: AOJu0YxgC4PNSn2Mq3FXaQx8Oo8KrPBAHiQ+FtP1qv7W38ygeW8QJrPV
	T/52tYqA9HHbrSdGoaWkAlX8DUy26kTqMREqmZ0vP4/oFX3UVEpFv29Lz4UQyg==
X-Gm-Gg: ASbGncullULn7kCjo6kPoXg4ROSjGmUuPJDsjylsc7Pt88GHqDt6KDLBQwzBg5qeSSs
	VzFK1zJNheZ4dCzRbBpJOka1MzlhNd/9a4aYGXlQ6Qd15rKeKzpyVzTn+c8alWRG1YPPEKdH2jk
	N0VzBEWSg6as9stXaLfSB9xaH0K00NasLX3tnWjjAEuCB66lWjL+LIZ2nZ+8D/vNstvuCzcKYCo
	YDe7snZSgV0PwIFneUTkutvvOlklHKqG/dNGN28Z9hnqGsg9FEqBb7Jb1JkxkvmUugqZSiMxnL8
	ixk3m1kXeJ+BLoDpKzQ/kdBjFmWrX1Om59ma5SuIFTA5FWjVA45tv0QXWQH7Ty8VnbpQm7QOs/T
	pBTaN4ll9En8YWKCo43LKWrHrWeeW9U9c74UKoMFH1W9Fy3rYm8ojdwx+pAwf7xRGogCIhmc2Pw
	==
X-Google-Smtp-Source: AGHT+IGHqEGOBerwG0ceQzXbPZKL04OBk3IYnrYqeWUuOXKkbw4sr8acOMmKMJ+WXzYhv8l2RU1mBg==
X-Received: by 2002:a17:902:ebc5:b0:24b:164d:4e61 with SMTP id d9443c01a7336-25d243ef720mr70402965ad.13.1757801596957;
        Sat, 13 Sep 2025 15:13:16 -0700 (PDT)
Received: from Reys-MacBook-Air.local (c-73-70-17-6.hsd1.ca.comcast.net. [73.70.17.6])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32df96f6118sm2028032a91.4.2025.09.13.15.13.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Sep 2025 15:13:16 -0700 (PDT)
Date: Sat, 13 Sep 2025 15:13:14 -0700
From: Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
To: Marc-Jano Knopp <y--gitbugs@marc-jano.de>
Cc: git@vger.kernel.org
Subject: Re: safe.directory does not work at all (git 2.39.5, 2.51.0)
Message-ID: <lamzerhpp6kbgzbhztgaqvdcymaqvec232sen67t6wx4rmobih@lqqivgroonmp>
References: <duuus2ifgydpwpja6vccvxbcnxdgy6mc6h63okzv7xdqo23fpi@ermurkhms4j3>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <duuus2ifgydpwpja6vccvxbcnxdgy6mc6h63okzv7xdqo23fpi@ermurkhms4j3>

On Sat, Sep 13, 2025 at 07:38:53PM -0800, Marc-Jano Knopp wrote:
> $ git clone myuser@my.server:/git/main/test.git
> Cloning into 'test'...
> fatal: detected dubious ownership in repository at '/git/main/test.git'
> To add an exception for this directory, call:
> 
>         git config --global --add safe.directory /git/main/test.git
> fatal: Could not read from remote repository.

it is a little confusing, but the message comes from the git command
running in "my.server".

doest it work if you run the same command after first doing ssh with "myuser"
account into "my.server"?

Carlo

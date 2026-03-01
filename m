Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C92211A9FAF
	for <git@vger.kernel.org>; Sun,  1 Mar 2026 19:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772394599; cv=none; b=Vz3Jgs7/1a4UZK2FBSV17E0j74zPT3ZTBAoj9toMdaOz1fwtfbuR+v6Oiu7kr6pYw/8bmYVX1IvgtAj9d9xBQfq36ZvN8FLhgL5+PqZ9UEY4kiCLypg1YtFTzhTbHxFwgrrsG5oT7RV5uyfhr8eg+AoQ7S4H9kdcJTyWcYPmS0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772394599; c=relaxed/simple;
	bh=OLOwZcQhb91z1neKmD98z0hoWI5VR8+6GIxHxa8tSEs=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=KsymNFKmJHlSnktKUAn+mSSiVdW4xKNUdzVs9UknbcHLl/rJJ+6jX5IWzIxt+j9Acvm31AQAGHZ1hi+eEv43IWxU2URKhaJnLLg9QqxaBOU9O3sG4Cr4t432rqn/i/6p5RYv31xVn7pDvd6iZsZA7RAbzn4S4E3i2gJUm2D8p+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NgQZJmZ4; arc=none smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NgQZJmZ4"
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-12776bebe9fso2125118c88.1
        for <git@vger.kernel.org>; Sun, 01 Mar 2026 11:49:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772394598; x=1772999398; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OLOwZcQhb91z1neKmD98z0hoWI5VR8+6GIxHxa8tSEs=;
        b=NgQZJmZ4+2FjdpSWyO8Oo7BSi2HegOHrluQKj/Qmz7FE1Kr5+Rwjej7iIdK3dGV3Q8
         HABGi+NqWpWcTGOBAa3a5OWLwp9eN0oZKcpMQvwPREKGrtkVX2o1EsCaqZqMkvv6Gust
         0zNCVGG8KWlwbN6dO7kO+kBgUOI+8nkXwaKOG8dIWw4q4H0cFmiA3AyVPuT84bzjxxC9
         a2UWfy65KbA+N3dtGYEYOgY+HJF+YnZqWnbnYqSOG+2OBbRbbqNmql9lD/z9RhN5pL/t
         SE2nV3VQXZfL9olpN1uLX/EIgIMxmxNpHzAKzvr31567+vXk20ub0l/YrUl9yW92ZvNC
         zM/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772394598; x=1772999398;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OLOwZcQhb91z1neKmD98z0hoWI5VR8+6GIxHxa8tSEs=;
        b=pLk2FyY3cXPLGRBG24gwcCM4R1xQ7MptH7rEjSNm0AJBZivENlqL0v7KrP6CYkVH5o
         TEB+Yuj3X4boUCPM1ptNTHMU4ax9nwJ4J1miwiJCZpTI7By2G0xKQA1Qnqg8O3nVjrcL
         JLH2jxadpii/ZUzgJOJAWHNczDAuQPwIYD/F55mGqnY7LdZIj4Q5l+oJnq7pMEmEDrg7
         mFmk/OVXTnmlgTNohMcnWDHRoMf0powLEk8OtQZFJDejYIT4bGBKNZiQGJ9+1bklFVDh
         VwSRx2fUvL+wnoa06nnWmQ31ssZV+n12RU5mA/U4wdE8Irc9wHhjB3haLzOPpNAXh4NY
         +ovg==
X-Gm-Message-State: AOJu0YxHNsVCnOC4U2XRGcC2jPVWKiV7jJudhY4vf5uysEzCDNUIr+NB
	3fl3mWx69YX3CvrBkgHsUoJXul6i1dHeo5E9iR4RBuWxvQNO7MwdaFO0
X-Gm-Gg: ATEYQzytMCk8iRfjXKqsVANx61AhgzWp35FGz5bacTJyTEapTrEWdAA7WEg+j6GnmuK
	gykrYqfVA9nhLGpRVu39rZ3ApPE1mgvctfrGWEFji3b3JNwCtNJ0GL4SycZeQcF0MoOjgwNtrvC
	trzyOJ4r684PxDC94I719GAri9gHjkklauc7fN1qzJWagRhQX7JKxPcbXMIuK6RIi7xTXbvuErW
	1tHAw1RtTNeG08F9+UTv+ijGkmfvBX6gL9KNOSEP8vI2lKhPXU4xdvF2xHjcoKTrxUFcxWJ/WZh
	f2chTnDj3/+ic1qwxvUYdrpDex6lANwWSogf3RRFeNG6InCYra3gFDwygBaM/iezGuDeNBfPSRo
	BKMcFpWgEHo6MoXW3AYLD8lbbQobB6LPwCr2heHOoCc42uVXVul0pyOBs7Yvl+bng1CVKxQR9e8
	gXxJYAmXKqvA/ik0wxKNZ6T2M0ycqtPzCE604/NyrWNZH2BjrdA73rAtO2aL9O
X-Received: by 2002:a05:7022:209:b0:119:e569:f268 with SMTP id a92af1059eb24-1278fc5ecaamr3928379c88.17.1772394597836;
        Sun, 01 Mar 2026 11:49:57 -0800 (PST)
Received: from smtpclient.apple ([2804:14c:c4:89c7:617e:ea24:9d26:4bc7])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1279cbd1993sm2714359c88.2.2026.03.01.11.49.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 01 Mar 2026 11:49:57 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.400.21\))
Subject: Re: [PATCH 0/4] repo: add support for path-related fields
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
In-Reply-To: <CA+rGoLdTc2caDUsQedpegL+T4MqwwiA62uuDSFSawAT5vcPvWQ@mail.gmail.com>
Date: Sun, 1 Mar 2026 16:49:43 -0300
Cc: git@vger.kernel.org,
 sandals@crustytoothpaste.net,
 kumarayushjha123@gmail.com,
 a3205153416@gmail.com,
 valusoutrik@gmail.com,
 pushkarkumarsingh1970@gmail.com
Content-Transfer-Encoding: 7bit
Message-Id: <12F0E36B-6F42-494A-B985-E41C9C4BF92F@gmail.com>
References: <20260228224252.72788-1-lucasseikioshiro@gmail.com>
 <CA+rGoLdTc2caDUsQedpegL+T4MqwwiA62uuDSFSawAT5vcPvWQ@mail.gmail.com>
To: JAYATHEERTH K <jayatheerthkulkarni2005@gmail.com>
X-Mailer: Apple Mail (2.3864.400.21)


> Option 1 feels like the cleanest approach.
> Even though it means git-repo-info can't return both a relative and
> absolute path in the exact same call, it keeps the API highly predictable
> for scripting without bloating the key namespace (which Option 3 would do).

Yeah. I think that in the future most of them will be
path.*, and 3 would double them...

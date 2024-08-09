Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCCF81DFF5
	for <git@vger.kernel.org>; Fri,  9 Aug 2024 12:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723206856; cv=none; b=BhIjHVBg+ovI5b6EccE+jtzRBnykyyaQqgXserTBLvX/sw4K3NbsNvPhMtKXy3ttwy1hZPZ67vW6aYAam9TcxDJ9FpS4O4xqdbC+9QAU8Prz9AhHt0iEryaZCEiX7vSKNEFSPxZwtvWGM5pd86g9rQkLI79ydlwfrluUs1/uqSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723206856; c=relaxed/simple;
	bh=4E29nwyBdTE+H+utub0SURXB3TI1PPiyoU7cWy//R3U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t6HEbkU69zQGM2vQX8D+KYHkvvRPhcw1Hm+L2THoFNUODdBri4IO7yDx7kNkWb2wxilF5d2yHiX8sG1hMK9CnKcBU6kDIWuBU1wMA6fKlMDfBOo/Bj80NL/6SLSainJwgLWDNOoqjY/o58Nc9wbYWCDw50+JKsA1shw+HhbD0Cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EdeO/E4K; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EdeO/E4K"
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3db14cc9066so1331910b6e.3
        for <git@vger.kernel.org>; Fri, 09 Aug 2024 05:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723206854; x=1723811654; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eU6LQWa5f51Ka2ryjJeu8jEDvpysaU4CLTROjHgvrg8=;
        b=EdeO/E4KHKB+Rp4ym7saPHky7Jj42YGi747PiQpyzPtIoIwAsN5ZahmeHlDsb3VrES
         7rKO2cQcZMuzpEV5hEtxcmP4qZATtFXyvhIuJk/OeKweip/VSoSPIMZzZQVh2xA/tGH6
         /m6w2hOx1yqsLnOEg2gH8rXaVVruNTf54mCyawdM3RLrZ3RG8DDI9m7M9Tj0sKXEtfPL
         fw5bPQF2TcnsUWX7J4KC3jfEma0mrYJlSXV7bxFXd/ht6v6gV21Q/8bKnKpTMy7H9ia+
         PhJZ7d3cEaibnT/obnThLlWwAFsQWtsakkA799ccS3K6hz4YmQ1ATxj1bIcuIu5xyJxN
         2k1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723206854; x=1723811654;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eU6LQWa5f51Ka2ryjJeu8jEDvpysaU4CLTROjHgvrg8=;
        b=TpWGRxx7q3XYVuQ1MjshDXT5YF2FMsVEfdXRutjn5fEfOZ0TpfcwI//iu2SpQGIbd+
         qGh2zNIYsy2YOssBnLbyFxsV4gEg3/RIMLjyidEkICFtRAk8UWAxV72516Ebgc5J+RhX
         C+TFqod27smALqUQMfAv++4tCQ2RdR44m7+RY89061Rkmu//9OEP1yawNKVWRkw2rOBG
         cOGhIKqZx9uEMukP0wSeZsrDiJnChYlHEvYcasM+pkac0sRT/iv0Wg3Ib6E1HQ1pa1+X
         /cqCM0N3ouEeha9lDCDpikeFefe0X/1OGe70IlC5mh7jg/9gB0C+wZ+prI2SIwLd7WE3
         1N7A==
X-Gm-Message-State: AOJu0YzGjfrZFqz/oJnfqxFSZldZS8rYbL25HxRSunS8atbvTVu27+Zd
	Y4R9uL70rTURJchJPnxkGovm6X1ihtRZZCUoWwmXAJbEOlPEJ0LePRyVJ474
X-Google-Smtp-Source: AGHT+IFrtq65chpMRAcBfn4Xnx8DoAGjFxhkqaCWeV1cu0WFplmF38cRLNJNoWi71S4MDPeswDQvog==
X-Received: by 2002:a05:6808:181a:b0:3d9:41d1:acd2 with SMTP id 5614622812f47-3dc41691d9cmr1399859b6e.27.1723206853848;
        Fri, 09 Aug 2024 05:34:13 -0700 (PDT)
Received: from [192.168.1.70] (99-95-164-14.lightspeed.sntcca.sbcglobal.net. [99.95.164.14])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7b762e9c066sm9356882a12.13.2024.08.09.05.34.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Aug 2024 05:34:13 -0700 (PDT)
Message-ID: <b76b3a9f-fa4a-41ab-893a-7fafe865ca09@gmail.com>
Date: Fri, 9 Aug 2024 05:34:05 -0700
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: bundles discovery and clones
To: Karthik Nayak <karthik.188@gmail.com>, Jeff King <peff@peff.net>,
 matthew sporleder <msporleder@gmail.com>, Toon Claes <toon@iotcl.com>
Cc: Git Mailing List <git@vger.kernel.org>
References: <CAHKF-AsoF10coLP=+MV-NfkEvWzp2Xbucs7OwtOoCBs3TVMg3A@mail.gmail.com>
 <20240611072144.GD3248245@coredump.intra.peff.net>
 <CAOLa=ZRkZb65b1NawPBNOnnxi_gjCU9=85cJuxj0mQxyrPJe0g@mail.gmail.com>
Content-Language: en-US
From: Dhruva Krishnamurthy <dhruvakm@gmail.com>
In-Reply-To: <CAOLa=ZRkZb65b1NawPBNOnnxi_gjCU9=85cJuxj0mQxyrPJe0g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/15/24 6:01 AM, Karthik Nayak wrote:
> Jeff King <peff@peff.net> writes:
> 
>> On Mon, Jun 10, 2024 at 02:25:19PM -0400, matthew sporleder wrote:
>>
>>> I have recently been playing with git clone --bundle-uri and loving it
>>> because I can clone with almost-*zero* resources being used on the
>>> server!
>>>
>>> I am a little confused by https://git-scm.com/docs/bundle-uri
>>> mentioning "discovery" and things. Is this something being added to
>>> the git cli, a special feature for other clients, or is it still too
>>> early-days to talk about much?
>>>
>>> I would love to produce bundles of common use cases and have them
>>> auto-discovered by git clone *without* the --bundle-uri parameter, and
>>> then let our CDN do the heavy lifting of satisfying things like:
>>> git clone
>>> git clone --depth=0
>>> git clone --single-branch --branch main
>>>
>>> I'm not sure I hold out as much hope for pre-bundling pulls/updates
>>> but any movement towards offloading our big-ish repos to CDNs is a win
>>> for us.
>>
>> I don't think the server side is well documented, but peeking at the
>> code, I think you want this on the server:
>>
>>    git config uploadpack.advertiseBundleURIs true
>>    git config bundle.version 1
>>    git config bundle.mode any
>>    git config bundle.foo.uri https://example.com/your.bundle
>>
>> And then the clients need to tell Git that they allow bundle transfers:
>>
>>    git config --global transfer.bundleURI true
>>
>> I'm not sure if we'd eventually flip the client-side switch to "true" by
>> default (which is what you'd need for this to happen without any user
>> participation at all).
>>
> 
> This would indeed be nice. We at GitLab have been experimenting with
> bundle-uri. While it is easy to flip the switch for clients under our
> control (CI pipelines). End users loose out on these benefits, especially
> for large monorepos where the servers spend a lot of time computing the
> packfile.
> 
>> One gotcha there is that clients are now accessing an arbitrary URL
>> provided by the server, so there are cross-site security implications.
>> It might make more sense to allow only relative URLs without ".." (so if
>> I fetched from https://example.com/foo.git, the server could use only
>> the relative "bundles/bar.bundle", which would then be found at
>> https://example.com/foo.git/bundles/bar.bundle").
>>
>> -Peff
> 
> True. But I suspect servers using bundle uri might not always serve them
> from the same domain. I know we were experimenting using cloud storage
> and providing the client with a one-time signed URL.
> 
> https://cloud.google.com/storage/docs/access-control/signed-urls

We (at Bitbucket) have implemented bundle server for serving bundles
with expiring URL from cloud storage. It will be nice to have bundle
server discovery based on git v2 protocol based capability exchange.

example pkt format:
007bbundle-server=https://cdn-1.bitbucket.org/workspace/repository/bundle,https://bitbucket.org/workspace/repository/bundle

-Dhruva

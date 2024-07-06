Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427B918645
	for <git@vger.kernel.org>; Sat,  6 Jul 2024 05:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720245600; cv=none; b=Sc0UFQMPa7BQKT/rvwxEjFOIKcyZqcQPraeJ3ttGusUQNs5bbbNxB2HUb9oYkXLFxMQxZKplMflApia2xlFNZk5Q2thH369D8AofgIjuK4KiIL+0PT6S/PBv3ZMNl86iWwjrHoW4cq4AF/JlSV3MnAQ53ntOgV3/snKpaGoDymc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720245600; c=relaxed/simple;
	bh=kCtDSIeQBoQPZ5UQfUd8Yr7NWpECzdxaOi+J2BHfvHw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oQGjhrPNow8ZHGNXnvCYCHJzJPkbEIAt190ZVx854IqP6jc2iUbhUeJgp6hMyuIvogeiwU13YIJxabE/6C6PfjeASoolPCHTNTmdfkOdF9W/cpt4ixLs8fZ7s4a1ThKiuAAcCzGwlB6ll2UWLO0jPF++jV6mkg5zNxPDjWVKm7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h+oph1Hd; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h+oph1Hd"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-754d2b05db5so1329379a12.0
        for <git@vger.kernel.org>; Fri, 05 Jul 2024 22:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720245598; x=1720850398; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uNhh5MNZWqU0w7ySLLtrDFLRtq3s2XHSNCioqz0r9kY=;
        b=h+oph1HddQQfORjvOz5erx0Yp8Yi0dXvu1pCk7PJ3P9VseQURnlIpTO0yceb188GVY
         XZQU9mNGfPz939iNVCcYDgLYNr8O5YSvdfwg5ciHO3GYKE1cMP7PUDNA0ZKotTN/YTHW
         S5goT3HDcCxuJ2D4QIPoPNwHoqdviRRhIV3mtggZnFT9t0SOF4Ln7rVq/8d0FOPJv/LR
         zxAzoJa0PYUXW+KO4ebCqO35XdzbePkVMzv5388OVOwUVheRmd6OnqdLy4Z0ZGfafQLW
         dDPbQ2ehbUb/VtNVTX8gob9Q56EXAoXlXabsFxKn4px25yironlujHmAttXM0KEcliiX
         IEdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720245598; x=1720850398;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uNhh5MNZWqU0w7ySLLtrDFLRtq3s2XHSNCioqz0r9kY=;
        b=YA/KaoqXXrFmnNRWUJVGvKav5hYRsCRniDebxM6UG5OHWW7bij7zjO2ZtgUig7Nqpa
         aVvMiUxI+B5emIWfve2/MVsSSjtkYh3vJorEmYzK2KIGXKeIpCARSR70i44mUDpvEt0T
         rxJ7eBjHdPohSBjXxqv8+3m/YYcCC+OCTSs0ul+W4Fh9+/cyY8wKCjUPGRlKuogOm9QV
         vMAGL4j0O4lJoFwpAfPOdIWlm+m/h1IXmkiLFlF4zUGy2O12W8j4fIf/zBMfvwM6Mp9I
         41Ke7uIzwEb35OBNGd+9KfO8pdUWiBxJzITfDg6DNbk04TrXQT6dJiopqsUgexUGNYs6
         4QMA==
X-Gm-Message-State: AOJu0Ywo5sc6iKrP/jIr8yYdiFcR7eZGafb8mFmq5JuRBQnJjB8lHD/i
	0UVfArJOTSTT8pVG4aiZR+T70xegXtRIGd5gV0ZSV7+40PjD9OqVFfK6cQ==
X-Google-Smtp-Source: AGHT+IHdlJkG/fDFGCUmmd9qJbyH2E7UaCNvYBsaZnFsYm7Hn4d4ADjLIN1kmLS8+ufrJ7CMmrDSSw==
X-Received: by 2002:a17:90a:fe0a:b0:2c9:6ad9:b75b with SMTP id 98e67ed59e1d1-2c99c6b8f2dmr4300061a91.40.1720245598371;
        Fri, 05 Jul 2024 22:59:58 -0700 (PDT)
Received: from localhost (236.219.125.34.bc.googleusercontent.com. [34.125.219.236])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c99a984507sm4342414a91.32.2024.07.05.22.59.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 22:59:57 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: git@vger.kernel.org,  Johannes Schindelin <Johannes.Schindelin@gmx.de>,
  Eric Sunshine <sunshine@sunshineco.com>,  Derrick Stolee
 <stolee@gmail.com>,  Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 0/4] Additional FAQ entries
In-Reply-To: <ZocS0NgiAbg5Mnzp@tapette.crustytoothpaste.net> (brian
	m. carlson's message of "Thu, 4 Jul 2024 21:23:28 +0000")
References: <20240704003818.750223-1-sandals@crustytoothpaste.net>
	<xmqqzfqx7muk.fsf@gitster.g>
	<ZocS0NgiAbg5Mnzp@tapette.crustytoothpaste.net>
Date: Fri, 05 Jul 2024 22:59:57 -0700
Message-ID: <xmqqo77b3vs2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

>> Buffering the entire thing will break because ...?  Deadlock?  Or is
>> there anything more subtle going on?
>
> When we use the smart HTTP protocol, the server sends keep-alive and
> status messages as one of the data streams, which is important because
> (a) the user is usually impatient and wants to know what's going on and
> (b) it may take a long time to pack the data, especially for large
> repositories, and sending no data may result in the connection being
> dropped or the client being served a 500 by an intermediate layer.  We
> know this does happen and I've seen reports of it.

And this is an example of "a proxy that buffers the data, without
modifying or tampering with, would still break transport"?

> We've also seen some cases where proxies refuse to accept
> Transfer-Encoding: chunked (let's party like it's 1999) and send a 411
> back since there's no Content-Length header.

This is "a proxy that wanted to buffer the data but failed to do so"
that ended up modifying the data Gits sitting at both ends of the
connection can observe, so it is a bit different issue.  It clearly
falls into "modify or tampering with" category.

I forgot to say this clearly when I wrote the message you are
responding to, but I am trying to see if we can clarify the "or
buffer" part in "modify, tamper with, or buffer", as offhand I did
not think of a reason why a proxy would break the Git communication
if it receives a segment that was 2MB originally from upload-pack,
and forwards the contents of the segment in two 1MB segments without
tampering or modifying the payload bytes at all to fetch-pack.

Thanks.

Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1880A1552F9
	for <git@vger.kernel.org>; Thu,  1 Feb 2024 10:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706784647; cv=none; b=IbVrVsA2HfAD7rZZuu16nuRikKNlTlASg1eI0omfXI5sYx0mZLjl1j1QydWJT6YmTdnpmPEfz7+v5L69se+B4OozIrklFzXNd+6h2C7m3hbw3LR2Oy4Qrc4Pja0UH50GTmI+qh3dREgugjViTDumkqWB9jesRkB5q58u1bSf7A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706784647; c=relaxed/simple;
	bh=XBLb9Ltvy7oRJJAYFrm1M+/bIqm3iwUqkcBCfbj0h5I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nxn5MorsbA5ffdM4Kcj+24GTgMumpN9OD2cpiqavSa//zQHpe8TWLkqHFjVh8xQhAh4iF6bwYB5AQ/bTT404po+CvAqL5ki/GanUHPHs8nXicNfJ+f095XgF5VVC57QrA60j91yEF92oo2nNnBB1I4wNIYz4jvrId+Zbqj3hn+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X0DQZHCz; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X0DQZHCz"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-33934567777so471309f8f.1
        for <git@vger.kernel.org>; Thu, 01 Feb 2024 02:50:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706784644; x=1707389444; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=TrJqckI+Rya0cQQ/K3zF3rJU2gk9T7FDFn6TCDuR0W8=;
        b=X0DQZHCz2Uc3tu5wTZQuzF4M2IH5aWhSpTeHDN5GQ/rNrkmxQ/Fmc3KguYSkOcI5M+
         QuZc11bycOjFA90hSs1yPxYDdY3w6gs+DfT3DlB1DvEnSpAP/mCdG0AjNgOOi47w7Qh5
         Eze7EsdiXG5jP7LVpOf4R1UEHrdGto1tpv3XMRxq1EjisSVJ7a92ZLjRA+uZiMIxi1RY
         fE+S0I3WxxFaPnMxCCfRoh5Hnp3idQbd1d/3mHxLnYJFgoROXsgQ6kmCCtuTqIyk7D8n
         i8knNzobRoIcVODJo5JK6LHbtkH97JGaHaQyJNAK5FI+WFPTcDd3Z19pOBsdkC83jmXw
         OkZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706784644; x=1707389444;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TrJqckI+Rya0cQQ/K3zF3rJU2gk9T7FDFn6TCDuR0W8=;
        b=oy+D0oDbXeOuQR/CHYMPC5713Ha657vRJX3K6OJmx6ohAAZiFqQcmEo78bguMX1+Qn
         PIEpuo5cNJTGriIVYutoX/QmaCL/cUqyXq6BgDQS5ggv7+IkhBVN3LxQmYigOre77F7c
         vMTFrc1LMRtLYsUMFbVOpybBUYRBtpRgIJWkqttB0GHo6eiSdrFQw6JGkIRELoygiTGH
         S10dcbtFCPDuBzah0Ki4vwD/alCi+dPLBvXHzwST0oc3QZdeyGKL2VVdKgxPM5Ljk2rk
         md+n6uHzc03rN8W9k/FylHRiMFqGUD8qaaL6t42JTu2nJIr7+mw6CxUQ7kFI6GWhmmu6
         Hh8Q==
X-Gm-Message-State: AOJu0YxtjdU8TSzR3QnALs2w6bjFkIX7YGrGiz76T0w8zOKk3UihIE+S
	0C/wPeuLULpCg6Mg0VJ4iDB5hSsbC9ehBJPpX/g6ywEzC/2JEfhi
X-Google-Smtp-Source: AGHT+IHLaUm2PvMAETMUJoyQt5eQlJpzZd+QJJ75LPZ1Y53qsUZ+kqB/ljntnSXvZ2o8xoGDZ/gSwQ==
X-Received: by 2002:adf:e6cc:0:b0:33b:11e9:be3d with SMTP id y12-20020adfe6cc000000b0033b11e9be3dmr1669592wrm.16.1706784643996;
        Thu, 01 Feb 2024 02:50:43 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCU15VAisvIJ1WU/7vGd3YcnUhV6m8zxi7Qrj2FWSSpbywPJXHYWr1mddQ/BnrOVcGHiy7OP9xWxwqF6mhLd+0UGd7FTtf2Q+jIiKbbY1xg4oEw18C6QplQXTqaIdijdxljX21UTSVhKUyPwbRAJsHus077ETXwiT6A+NzEL64C5QSRvW/V3HK1JLtqh
Received: from ?IPV6:2a0a:ef40:62e:a901:d2c6:37ff:fef6:7b1? ([2a0a:ef40:62e:a901:d2c6:37ff:fef6:7b1])
        by smtp.googlemail.com with ESMTPSA id z7-20020a5d4c87000000b0033af9b7db6esm6941658wrs.22.2024.02.01.02.50.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Feb 2024 02:50:43 -0800 (PST)
Message-ID: <08303f49-63dd-4141-be34-0d6b5fa28a0b@gmail.com>
Date: Thu, 1 Feb 2024 10:50:43 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 3/3] t/Makefile: get UNIT_TESTS list from C sources
Content-Language: en-US
To: Jeff King <peff@peff.net>, git@vger.kernel.org
Cc: Phillip Wood <phillip.wood@dunelm.org.uk>,
 =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
 Junio C Hamano <gitster@pobox.com>, Adam Dinwoodie <adam@dinwoodie.org>,
 Patrick Steinhardt <ps@pks.im>
References: <20240130053714.GA165967@coredump.intra.peff.net>
 <20240130054037.GC166699@coredump.intra.peff.net>
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20240130054037.GC166699@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Peff

On 30/01/2024 05:40, Jeff King wrote:
> We decide on the set of unit tests to run by asking make to expand the
> wildcard "t/unit-tests/bin/*". One unfortunate outcome of this is that
> we'll run anything in that directory, even if it is leftover cruft from
> a previous build. This isn't _quite_ as bad as it sounds, since in
> theory the unit tests executables are self-contained (so if they passed
> before, they'll pass even though they now have nothing to do with the
> checked out version of Git). But at the very least it's wasteful, and if
> they _do_ fail it can be quite confusing to understand why they are
> being run at all.
> 
> This wildcarding presumably came from our handling of the regular
> shell-script tests, which use $(wildcard t[0-9][0-9][0-9][0-9]-*.sh).
> But the difference there is that those are actual tracked files. So if
> you checkout a different commit, they'll go away. Whereas the contents
> of unit-tests/bin are ignored (so not only do they stick around, but you
> are not even warned of the stale files via "git status").
> 
> This patch fixes the situation by looking for the actual unit-test
> source files and then massaging those names into the final executable
> names. This has two additional benefits:
> 
>    1. It will notice if we failed to build one or more unit-tests for
>       some reason (wheras the current code just runs whatever made it to
>       the bin/ directory).

The downside to this is that if there are any cruft C files lying about 
t/unit-tests we'll fail to run the unit tests. In the past we've avoided 
using wildcard rules on C sources to avoid problems like this[1]. This 
change may well be the lesser of two evils but a test run that fails due 
to a cruft C file cannot be fixed by "make clean && make" whereas that 
will fix the problem of a stale test executable.

>    2. The wildcard should avoid other build cruft, like the pdb files we
>       worked around in 0df903d402 (unit-tests: do not mistake `.pdb`
>       files for being executable, 2023-09-25).
> 
> Our new wildcard does make an assumption that unit tests are built from
> C sources. It would be a bit cleaner if we consulted UNIT_TEST_PROGRAMS
> from the top-level Makefile. But doing so is tricky unless we reorganize
> that Makefile to split the source file lists into include-able subfiles.
> That might be worth doing in general, but in the meantime, the
> assumptions made by the wildcard here seems reasonable.

Using UNIT_TEST_PROGRAMS would definitely be a nicer approach long term.

Best Wishes

Phillip

[1] https://lore.kernel.org/git/xmqqtugl102l.fsf@gitster.g/


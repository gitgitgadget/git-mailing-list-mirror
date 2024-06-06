Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D08AB1F171
	for <git@vger.kernel.org>; Thu,  6 Jun 2024 16:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717691532; cv=none; b=R9gKJS6oCsb5VF42zUzYKSPzrhFUpoLbJmfedb2fgpG+k76SVXd+MEty2m+0/pNM4mrhSWbiUEsVKS1rtPNpWrMLdszRxDBZhcN86PZD7TbR3ZsEwKYa2lq8l4PmiYYOFmKij9PQJl+1Yj87gK41rMkZHir1pF8fTwV0wpWnxPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717691532; c=relaxed/simple;
	bh=16thv84HhygDVkWszKYSBpAASO+7BFuMc316VCQkNoY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uvvDEWA46GqcVzs/2ecIuUu2XUqoUv3IPDYGVFDzxAp+rVfUtp3Sq0EzEmi5KheU0eFu0P97ZwlByOHuMHcUtcODTHK1HsgQsYsT3GDqxrxPY/jEHhWTdVDKtKMXdOayLZaH/mCRXp6r9HQxhSv5nrBddAPotwZowNAe94cCA58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PdwfUK1b; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PdwfUK1b"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7024d571d8eso995570b3a.0
        for <git@vger.kernel.org>; Thu, 06 Jun 2024 09:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717691530; x=1718296330; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dmMhAMq+8g2voBzeWmNyftIi6edd7atK34ybVGdaLsc=;
        b=PdwfUK1bjRQ0gtmfJEsvX58RJYT6UBWAbfJGcoNcy3KeMg/WQT5AC5trklS2kqAo9H
         ch69S+qmnzsrS1/TGZcBYAfDc3RAvgPtK26kOHlY1dpsM6b3Q0GWPF0KkoQjM6Tdv/44
         88dPWrYmiJjwGUCstXDCM+aRvrtuO323PFiFu8ZlZ+CS1CAdPLe1WzNZfh3Kt2WYJzD2
         6oFBXZNsHQXFI3H+XHQiQUjzCNIkWb8TdsPkr6Z6yYzUGFhySQcBF8zhJJlZvE1vp2bV
         BTUZN3BG4W4VYscmgInGM1UKiraRuwNgHXGDgpCyIFFDzJRWk+228KZEMs/I2gtGy9/o
         6uXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717691530; x=1718296330;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dmMhAMq+8g2voBzeWmNyftIi6edd7atK34ybVGdaLsc=;
        b=nTA0pPWPv2PL35Ai8mTE1GR9CbWbuwR+UrfNSLQ6GAHDsYYYY2njy9EJqoyXu7+/v8
         1/CkjrHJzZVc0oXreH2HANkJMDl47InNNX8XjU1oWbQR/JN85o7OBAZgCm2ZWZ879JuH
         007jS0UDAlOnW3hvb759UE7WE4y+/5psAIPYkLuhzIPxvtRoWzpBAmutqakAPYdxtSXA
         grk3kGyB7P8x5TkbzVVjYP2k8EEJG8HmZq9dIOyobiK9xs66XATZYbPU7SdOFWQPHCgy
         2CVsLLhvxqiuYNQxSVZ4nVAl+2+JmjGpzz8t/DYC7io6f4BfVxs/CrQEJZkq5lbMPab5
         OJSg==
X-Forwarded-Encrypted: i=1; AJvYcCWq6p6cpn2WhgstQ+jUaln3i9VbdxpL4K75iu7o8Xkzulrsl/9/VyX5XAU2L9R9LnCCAkPnR31mYmQgkSRKqzFxGNxw
X-Gm-Message-State: AOJu0YzaWTbcMRhn9+jVH7VyBT6UpmXxZ7J2k3z6lMDTJ5cJ/9OI2Nfc
	1p1OqHMWRqA9bsnjnRLovjtn68U/8qFZGF4QhRcgqWguSDkP3WpcVHAw4Q==
X-Google-Smtp-Source: AGHT+IH8aWD4kMAKlci/oYr54cPYUsdJBluWih1QRLSdO4/AXeaMzfoCQh3FNfKT4WO5XZlzfGjCUA==
X-Received: by 2002:a05:6a00:1307:b0:6ea:b818:f499 with SMTP id d2e1a72fcca58-703e599ca68mr7095598b3a.19.1717691529967;
        Thu, 06 Jun 2024 09:32:09 -0700 (PDT)
Received: from localhost (201.204.125.34.bc.googleusercontent.com. [34.125.204.201])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-703fd4951bdsm1294689b3a.128.2024.06.06.09.32.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 09:32:09 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org
Subject: Re: [PATCH 2/2] ci: let pedantic job compile with -Og
In-Reply-To: <20240606065236.GA646308@coredump.intra.peff.net> (Jeff King's
	message of "Thu, 6 Jun 2024 02:52:36 -0400")
References: <cover.1717655210.git.ps@pks.im>
	<351dec4a4d5a5619e7627e11a8e674e32125125e.1717655210.git.ps@pks.im>
	<20240606065236.GA646308@coredump.intra.peff.net>
Date: Thu, 06 Jun 2024 09:32:09 -0700
Message-ID: <xmqq4ja6niba.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> So for the pedantic warnings, we're left with a guess as to whether -Og
> or -O2 will yield more results. And in my experience it is probably -O2.
>
> If we want to get coverage of -Og, I'd suggest doing it in a job that is
> otherwise overlapping with another (maybe linux-TEST-vars, which I think
> is otherwise a duplicate build?).

The same knee-jerk reaction came to me.

Speaking of variants, is there any interest in migrating one or some
of the existing x86-64 CI jobs to arm64 CI jobs GitHub introduced
recently?  I suspect that we won't find any endianness bugs (I
expect they are configured to do little endian just like everybody
else) and there may no longer be lurking unaligned read bugs (but
"git log --grep=unaligned" finds surprising number of them we have
seen and fixed), so the returns may be very small.

> Your command above also loses the "-g" and "-Wall" from the default
> CFLAGS. Maybe OK, since DEVELOPER=1 implies -Wall anyway, and "-g" isn't
> important. But one thing I've done for a long time in my config.mak is:
>
>   O ?= 2
>   CFLAGS = -g -Wall -O$(O)
>
> Then you can "make O=0" or "make O=g" if you want. And I think that
> setting O=g in the environment (exported) would work, as well.

I do something similar, but my $(O) replaces the whole -O2 thing, so
I can say something silly like

    make O="-O2 -g -Wall"



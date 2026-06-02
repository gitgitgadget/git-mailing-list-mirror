Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5406219303
	for <git@vger.kernel.org>; Tue,  2 Jun 2026 13:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780405986; cv=none; b=p/TWXxXBpiosii+hEE8x0nOF3hLwg/jYf2YK3i3sD7tYG6AgOjmKzw9CLDlqMAlY3msafXOEEiYaJhGgDVAy5uttAPsdaxk2KNEc+rTDuem61BE1+dbyMiEIskFZNUCpmmdSVnE5gPLHJlvTLUPobmcDpC7dMYS3gqbCRvdiA48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780405986; c=relaxed/simple;
	bh=Ugwreef9XSipP2IXkwif+tb8ZLBeiSyw6dbOlSDBJJk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kwI+Od6dlvxiKG9+2CWi3zWE4a5nTPkSQjDj8fVvhSC+L6rT3OwE6SbKo6AgO66vl/Aby/3oM1oRliuoT//ROspiQJKz0TTihZuhmC8kKRdrensMtGW3V3iJm7knNWjNpmWqY3xiBzx8iFazNadI4qKw6aAqbfbECtSmflzvb6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tGM0VOWn; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tGM0VOWn"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-becfa735b9aso327602366b.1
        for <git@vger.kernel.org>; Tue, 02 Jun 2026 06:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780405983; x=1781010783; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=MrGnT0tUWZbe62r2I05rFGQHUba8Hpun6MFuk2YVGSU=;
        b=tGM0VOWnultfmBPQZwQBgDZNhgrwLC26zdJAlPx8Zgc/TQAMXQ9xb/J8yG2zeCaX0I
         YekIq45nBO8st8RCyV/ocBMbh/I3hms+LOuPY+1GvC5IAnpE/C2NS15e1s9l/s3dRR8d
         PgIDkh/ZmByK9L+6ZxzUmIN7F/tVoXMayFYwod+uB/fEbIGsQmInGNM7ScNQPAz/WnCb
         PqiBFHO5mFXUB0b+FA9jlvlX1kzXhwNEn6o4fwyqIiOHojRAkvhPe6m8iRAWiSHTMKGu
         KQawN/tCMacLZSWBPqDxzGoqvFISJnl4l7tRHXOfxeME1TW2nVJAPgTIx9kPFp3qWmG5
         1OYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780405983; x=1781010783;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MrGnT0tUWZbe62r2I05rFGQHUba8Hpun6MFuk2YVGSU=;
        b=sMpW4GA4QjVTUwzU5Uzo3Z46g8fgwaxyjrdu4kynVyUngRTVNIDKmJVwOl9bd3H2tm
         R2SS5Ui9ttKXmn1WOjeLxhuWaYdZShgWjVBqEYid1F9Y/TmdO7iWP0OyziZnaHRQbm21
         UtswQ/QYZWn9gB+dlmE8/EHQkn5PvMHI7yvu2L0HZuxhjazHg88vVgCi16Oqrx3l3SXj
         K9b7Q4wd5gqf8tq24uGeHCwys7UfsQwRUeTtZtzCP2+HkajE3ZSuCnZjHQUg1xTD8LOr
         B3bpGHD8GXIf1pWUY9S9dXV5DdEF2pOohMKsVJxkgGT6A5HYODVBpMr64O56GaeNDUIe
         glTA==
X-Forwarded-Encrypted: i=1; AFNElJ8ADeMvrEXyOE+UpRfq4vC81Y+qUjC8Bk/Bn603UYqqQ8GORXn006ktJ8XpoqpvYX0fNBI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzcbFJ/hvy+cjMBp69+YvXHYlyGusevjm3d8K+g3DSsro60GVz
	CMS3oqLynTQxp3zXF8EfvFGXNxRnfS5n72Clcwt9Kl+5PjrQpk+g25sv
X-Gm-Gg: Acq92OGF6zN6FYK0wUE43bpxmO9oluiXCaQg+Fn49mMKLvij9jvzWTVss89SOmiVcH2
	SCEQaejKjjLSkdRMfeT5y+vlu4GzZZ2DsYPffF5zyy953tmegW7ofh69AApzpFh/Eqmwz4HGccA
	3VhFtPASujFr/ylzaI4EPqpwzTCVBsjZp8/R4e3uXkoQ9NivTDD1P3CJpRqZnDzbxeEp2gr111G
	/0LBrOYm8MbP843jLBtSnsLCA1dIGkpJO21g9bCqxe4OqFn7/+IYo0JqEz1BYYlcpbMifo0avLH
	u8zqnYboIhWhO7IA94tTPrg8+6tMooFPJAd6kLlBR54CHmK69ZPBh10+e+t0ORUeWX3vD2HPfiS
	86TiptWCxraw+EEcpF+FsSXDLXyH1KPXlTxlcug0Arkh8aPKCJiw9rdq5u+XkGwY5Buc8ytsAv7
	fiEQaM2mcuXlr3uD4uHy12lvUSA9cUXCFTJ8XKrGfqAbBgoahG9YTLDfTZkehfp8lvH2azIHeGY
	q2flnh+swj2AA==
X-Received: by 2002:a17:907:6898:b0:bed:2a8b:3e73 with SMTP id a640c23a62f3a-bed2a8b4d19mr415795466b.41.1780405983262;
        Tue, 02 Jun 2026 06:13:03 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:638:c001:a103:efc2:6ce:f580? ([2a0a:ef40:638:c001:a103:efc2:6ce:f580])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bed10b15cd9sm272547466b.31.2026.06.02.06.13.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jun 2026 06:13:02 -0700 (PDT)
Message-ID: <e6e225e7-f915-4ed0-900d-03a7767fb36f@gmail.com>
Date: Tue, 2 Jun 2026 14:12:58 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 2/2] builtin/init-db: deprecate alias for git-init(1)
To: Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 Phillip Wood <phillip.wood@dunelm.org.uk>, git@vger.kernel.org
References: <20260601-pks-deprecate-git-init-db-v1-0-ea3e6eebe674@pks.im>
 <20260601-pks-deprecate-git-init-db-v1-2-ea3e6eebe674@pks.im>
 <276a92ac-b2cb-4a89-96d0-9071ab6200be@app.fastmail.com>
 <ah12uk7IFxS92OR1@pks.im> <042e66b5-122b-4c86-a9a9-f75f763666a7@gmail.com>
 <ah2VL-ftCQelNoOc@pks.im>
 <2e266786-4ccd-4300-9b53-6f13fbaa2933@app.fastmail.com>
 <xmqqcxy93nph.fsf@gitster.g> <ah58IJ8DgSZYRjMM@pks.im>
 <xmqqv7c1xs76.fsf@gitster.g> <ah7N5bKAiAORtNkp@pks.im>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <ah7N5bKAiAORtNkp@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02/06/2026 13:34, Patrick Steinhardt wrote:
> 
> That's entirely fair. My take on this is a bit different, as I think
> it's beneficial to accept a short-term adjustment for core contributors
> in favor of making stuff easier to discover/maintain going forward.
> > A new contributor would probably be quick to learn that every
> `cmd_foo()` entry point is named exactly the same as the subcommand
> name, but they will then eventually trip over the few exceptions like
> `cmd_init_db()` where that assumption doesn't hold.

Yes, those exceptions to the rule are annoying. Though they mostly exist 
for a good reason (code sharing between builtin commands), it would be 
nice to minimize them where we can.

Thanks

Phillip


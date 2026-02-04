Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7971E38F931
	for <git@vger.kernel.org>; Wed,  4 Feb 2026 17:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770227589; cv=none; b=pk0XaQBY/ka97Q8y7uQyPglYQ8X6QZ46CtTKeS3EQLPjwN1lDgmemecCh9i8ExJg3fb4WxlIZGAwNgnHh2k8dt5XwgiJx9Tzet49elu03IkajDWGLrRuK7n0Pek8Z+ZcwWcOmnIeamAHCJrvuMpqD2n2icKjFd9tJfz6ai6kNsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770227589; c=relaxed/simple;
	bh=WbidgWkcOE56TSIh0kp7QiL13MYPgf6Yt6y8IHip+do=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PB9YYCQb0J3lqAVAKak0qyPF+wwwLaT68Q71HT/S5mT1EwRjTscYbulhFWOvwRkAwla+/dAZRts26j1D2tPHoRCW/pflzk6PCsUyWbqPMoKfFm+Mhc2pfAuyrRNqGpBZ3DalrSJ+ZNy/JBEsy+oRwK3F9mSrn1iH0qzYhGcDbAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RjIw23nX; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RjIw23nX"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2a8fbd09b09so188455ad.2
        for <git@vger.kernel.org>; Wed, 04 Feb 2026 09:53:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770227589; x=1770832389; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B8szojqfM+Q2rGz2+0D3f7E9M4VB7oLMN231+0IDwxM=;
        b=RjIw23nX4AX6/HphnIr9PIvROk2KXA6+dqOhltkY95ICK06/KbfNg2xJ0EEX+7NXwF
         0yomWILtaYDX7+PHDaCGgQJKcDZ7Cmw1yjtJe/L7Qx/ZPDYeXy5HcEjZLdYXjV0Dy0ML
         ZZmqkIIcf07Msx9f6lbv2qCxZ/S9HAbDVTrTosyJA1gUbKhB+UAt03wuHA44UEjRzW7I
         /Kp7FdGaB3zqTxJ6VUE4JZhel0XkTrvy8Q3BOBoBt/WuYuKQ2exWSL/ahGfzVOTOx1EA
         4y2RbxcXoy+jK/IZtz5SFvAotWyro6fWydr427XwdEtWHxuaCb/6sk52e7SQgR0PQioW
         RKrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770227589; x=1770832389;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B8szojqfM+Q2rGz2+0D3f7E9M4VB7oLMN231+0IDwxM=;
        b=aq+dnzv9eLxOrT4ef4fc19qruSuB3GPjJ05ZI15Cvb9Fy49FUaE3V5cREOs4TFO0Tp
         x8irSj9jG4gjcGE6b4lICjabws/ygxvUsAEuEqZ74o4eK91KYLUJX/ERMSBDRCRtPqcO
         Dsbv+2iC+XsE0lLvozipa3cOlL116tQ6lenQOL6RmqBFY84fVgMOkuURIoz73MEZAX3H
         cO5NbUVq4ekbJEcAsEZEFmERfJanClpzg0FkCke1VlNmJsjI4AzONSvYeIxFN1/oz970
         xImnjCgfNLdBXOYeBPeP5QyVus81MJ4m025eX8h9bUBBv3wzJsaPPqIKLRt/gPp1edaK
         KFKw==
X-Gm-Message-State: AOJu0YwOspGgM79lYBIqVr7TjPf5tFnQQiU1aP8Ab93bPhXvFdzjDkEs
	UTc4LLYqxR3I175mDBw5Bts3oyI1ieFeJyClGhFlx5+lzGTl2Xk0FbBt
X-Gm-Gg: AZuq6aLVdlLAC5P0nAUcdiibUayzSpJGogl1uaOMFYE18ejOZjsyCRww1PRjP5nF6dc
	xJZ0x6VxSF2K3IwDxLvlPJ4juRsy5Hndr30c9BAxe8YzeJ/MLD338dCNV+qHDfZv0ySj8Y9+DXK
	Cami64nCvYx+zlM5yA9eRkN9oWE7OnWfdvNKwuXWgXnd4GGuA6qfNEcKdbq0RETmsYdfJTpPS87
	s8ERl5CLPBjU4n/aPa74qFS2tzeazHLX5pf6RbUCKMPMMSDtJL2/mk2tam/bnoG7N1h5+xbf6MW
	3cGG2RxJf8w9Iypkg0aYmfIQw5S+BBFKXLhus56XEe/a5z0GFnRGE0+BmvAHq2Xc8qEJWKWePdX
	sG8ijeMA8PW7NRGhS0tcsEwrvWs/Ey3z1WJNZRnD+BL8Dnqo8RjAzz/WLe2Esxf3G48Hl6LqZqB
	V0F5NuVK5kipCKfrU=
X-Received: by 2002:a17:903:1b43:b0:29f:f14:18a0 with SMTP id d9443c01a7336-2a933e518a2mr30394235ad.4.1770227588710;
        Wed, 04 Feb 2026 09:53:08 -0800 (PST)
Received: from [192.168.0.106] ([155.69.180.3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a933965c3esm27249275ad.67.2026.02.04.09.53.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Feb 2026 09:53:08 -0800 (PST)
Message-ID: <9c5be231-f340-4a97-850e-d43c78b2c889@gmail.com>
Date: Thu, 5 Feb 2026 01:53:05 +0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fix git add :!x exiting with error when x is in
 .gitignore
To: Junio C Hamano <gitster@pobox.com>,
 "Remy D. Farley" <one-d-wide@protonmail.com>
Cc: git@vger.kernel.org
References: <20260204132747.1564157-1-one-d-wide@protonmail.com>
 <xmqqo6m4pi84.fsf@gitster.g>
Content-Language: en-US
From: Tian Yuchen <a3205153416@gmail.com>
In-Reply-To: <xmqqo6m4pi84.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/5/26 00:48, Junio C Hamano wrote:
> "Remy D. Farley" <one-d-wide@protonmail.com> writes:

> A question that immediately comes to mind is if it is appropriate
> for a negated pathspec element to recuse itself like this from the
> decision process and let other pathspec elements decide the fate of
> the path, or if a negated pathspec element should take a more active
> role of saying "no" (no, not by immediately returning 0, but this
> loop may have to become a two step process if we wanted to implement
> e.g., for the function to yield "yes", it has to match at least one
> positive pathspec element and zero negated one, or something like
> that).

You are right. To illustrate, if we run:

git add ignored_file ":!ignored_file"

Then following things might happen with the patch:
-> For the first item,
	- Does it match 'exclude'? No.
	- Does it match 'path'? Yes.
	- Return 1.
-> For the second item,
	- Is never reached
-> Git complain,
	'The following paths are ignored: ignored_file.'

In other word, it's not the expected silent no-op (returning 0).

As you suggested, The loop needs to verify that the path matches at 
least one positive item AND matches none of the negative items. A 
possible way to acheive it is:
(Notice that we no longer return 1 in the half way)


 >bool matched_positive = false;
 >
 >for (item in pathspec) {
 >	if (item matches patch) {
 >		if (item is exclude) {
 >			return 0;
 >		} else {
 >			matched_positive = true;
 >		}
 >	}
 >}
 >
 >return matched_positive ? 1 : 0;

By the way, I think extreme cases like 'git add x :!x' should be added 
into the test scripts.

Regards,

Yuchen





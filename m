Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7DC432C938
	for <git@vger.kernel.org>; Mon, 22 Dec 2025 10:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766400382; cv=none; b=BwlI2RVl2P+bfMHzDrbHOxlhuQemZH39lxpeJ7aZElrIp3Ie0BVFeXptDLicWU9HpeC2jXJAXukKX3z9okXn3bRmY8D7s0hROweY5ZpUrF/JY9u/jvwjsgIroKlssUUSsxyI3GTqiwuzwKO/+sTOgSm1lMg5PmhzkeQBOz/rrs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766400382; c=relaxed/simple;
	bh=t281MlTwFvpVX4ZDKFJPOEQciKMTxe2eBzCbBC/pwn0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=DtPB0r9es56WA/F2dSZwl/btGEyFv7A0sWLwG4SH5z4auTiUP/mnERg5Hrj2os9B9W3Tzf9SQ01QIDa9MGLurE75Meq4UGDy2shqKPsy8RpLcP5C3ksKGiocOk4lP6VDPRkLb+PEnyEJfHBUXUmEsOM6iKvYtKp0Xh7ozb/F7ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ksduHWfc; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ksduHWfc"
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-47aa03d3326so23509315e9.3
        for <git@vger.kernel.org>; Mon, 22 Dec 2025 02:46:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766400379; x=1767005179; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RUkORI/DVGtkWJNOk98EOUs/ZSF3nF3+CPDWwkkqO28=;
        b=ksduHWfcPl+ldrTo3KB/EAAsCNJV1zSPs6xY2ggNmdrkIeruE3xE1MFsvqIideuNnc
         CDSIHs8QfjHvIJtjMJiYpbpv4zWaFcYh0sgDiRM37DUrzucd6OLimTQ0+6VnmITLWF/F
         Kd6lZn9tLvUBgWsLwK/GiGTqkOhMSwoWIe1aBV9Z4+4Hns5RcWmgwoZYO/xsUQDP/uu3
         bxIRwBMGJ1maaS3qlvQMkmmU0Z3fGBZkTo3VwbJq3WbZrPp0A6WMUXouzFXKeKEVsU9L
         Tu8AbqOMulq4BBI2Ozf3e9K/D4h/dPG4jeuaAKKb6q2qM2T7KpGTtvRCuehLmWBf0hen
         Ad8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766400379; x=1767005179;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RUkORI/DVGtkWJNOk98EOUs/ZSF3nF3+CPDWwkkqO28=;
        b=ZSw6epMFk+dOroNTN4t2Jo8qAM7Bj085+EWwh3Rg5nB5mY8rSrsBeX7gwqm7UAz7h7
         aJuVFW0Y6ECnNsJRI0dp8cJtavGSnoDFVpVcUp4HsrApBYtq41KrDR/0RkQtOcCsDpGo
         12VJYuOroLOVz33cu1LWJHYLkV4KyCf7RE74CUkNA8dnEulgdoOeI76FImtLs0SxJ0ea
         Mblw+5QhR+wvo0i94pMYqeOnHCVns4WS/votWULNQAW//foR08FEwcWI3Qv6culgQEgz
         Amer4m88NL3pzQvdlDWgJltVjUmnEp+JEtDIGlP8bS1ErTNTRNcHuPNLXOEkMrOgFxVF
         ymDA==
X-Forwarded-Encrypted: i=1; AJvYcCXOv+3ACMRUveUha+kisNRBOpdoBsOLkXfipaWXI2a9cSg/pvgek5GU4YD3tfR4Po4AnSw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5BVVkQV06wTqAgpOdTvFphVjmWJJzHbxiUGPZL1xI4ocXpZSz
	dv6S9N4g2e/tdUJBMefisfbw8w2ysz/SS9W58Vs4I0gMsB/ATPSrv+aS
X-Gm-Gg: AY/fxX5MOKTfosxixmtB7ECyjFH4nXWnEYmnoqVCtNfrPTLUiMkahxEWCJD1g4zVj3l
	QgUyj+VwEDcq809iDS7PmIpnKWvfgZRJ9VaZzuksqahw7DJLqQL6+I0og84/tN51GDIfMFUKaQE
	acvnwstC1hnV/wpbUk+tYoooEVuMPYP5+sLW5+sJJafH77axKQMRge0o3OrRVt43FJH9BrkmiK8
	Ff6kuuUwZw/fLYoy6dgmWHoG4wD76CFuUTtdHzT5azAGmfHRjsGY+kOoz9KHXmRl0qhE9tDuuZl
	tJ8X1zNiUXTJdEpdJ8mTtHbOw1dL0kEgoIPEowGO/PjvBhZl9Pz7Pg953voWKdf0HpUMVKzQSNt
	4nuaBstUJl0+RzTctpnB1qcZLEullLC0q43sIPcgWcawGC0ndbGiiHVNm6GW1CIGJHk1NQkbrTm
	VrEp4BDroTDsne15O/Jf3HCBBmJ312pAj5w3h/NFA10WthbOrNka9vHB8qh/VB9t5dyjUj0vYDo
	agX
X-Google-Smtp-Source: AGHT+IEoVh48KwIonCx+2/wYqkwpcVKtcetCQb1ZvNH9wY/qQ1+HWSICC++mxQzQ3rg9EZmn0gqBow==
X-Received: by 2002:a05:600c:4e8f:b0:475:e007:baf1 with SMTP id 5b1f17b1804b1-47d19591166mr100247525e9.34.1766400378659;
        Mon, 22 Dec 2025 02:46:18 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:627:1f01:b22b:2092:b7ed:c8f5? ([2a0a:ef40:627:1f01:b22b:2092:b7ed:c8f5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47be3acdb87sm93352895e9.16.2025.12.22.02.46.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Dec 2025 02:46:17 -0800 (PST)
Message-ID: <91bd9241-96c1-4b34-98a9-af3bad345c4d@gmail.com>
Date: Mon, 22 Dec 2025 10:46:12 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH RFC 00/11] Introduce git-history(1) command for easy
 history editing
To: Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Cc: Matthias Beyer <mail@beyermatthias.de>, phillip.wood@dunelm.org.uk,
 =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
 Martin von Zweigbergk <martinvonz@gmail.com>, git@vger.kernel.org,
 Elijah Newren <newren@gmail.com>
References: <20250819-b4-pks-history-builtin-v1-0-9b77c32688fe@pks.im>
 <CANiSa6gXbrZaMLVq-AAg38sm+7qgzn4w98WWowLtUHA2P+BdLw@mail.gmail.com>
 <aKs3tqjE510MF0T-@pks.im> <aMsWL2cSoytbmRjA@szeder.dev>
 <4m6rmefbv4hftclimitz5rp6yapswjtnjsxymrsdkuan4jbg3u@dm5jzdiq5cxz>
 <bc01706e-b9cc-4cd4-953a-971a3ccd6c79@gmail.com>
 <paqf2ko6kcm5qdcqxqz57qu6gjw3vf6boabjsryeugfnlzzb7z@4dzqo6jug6l2>
 <a6efc710-4062-4955-8fe8-bb6d428a44c1@gmail.com> <xmqqms3qh13e.fsf@gitster.g>
 <aUVDax0PbkaXGB61@pks.im>
Content-Language: en-US
In-Reply-To: <aUVDax0PbkaXGB61@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19/12/2025 12:22, Patrick Steinhardt wrote:
> 
> But in our case we're not working with ranges, we are working with a
> singular commit. In my head this meant that we'd have to basically do a
> revision walk that starts from all of our branches so that we can figure
> out which of them would eventually reach the commit that we are about to
> rewrite. And that of course doesn't scale.

I'm not so sure about that. In repositories with lots of refs most of 
them are likely to be tags or remote tracking branches rather than local 
branches so I'd hope that the number of refs we have to walk was 
manageable. I'd also expect the commit we're rewriting to be relatively 
recent so the revision walk should quickly prune any branches that point 
to commits older than the one we're rewriting which should further 
reduce the number of commits we need to walk.

> But now that I've thought about the problem a bit I think we can avoid
> that issue by implicitly identifying the range: it's all the commits
> between the commit we're about to rewrite and HEAD. So, same as with
> git-replay(1), the set of branches that we'd need to rewrite is any one
> branch that points into that range. It keeps the UI simple as the user
> still only has to think about a singular commit, should be sufficiently
> fast to compute in most cases, and it allows mega-merge workflows like
> JJ supports.

I agree that users should not have to think about commit ranges, but 
using an implicit range between the commit we're about to rewrite and 
HEAD will not rewrite all the branches descended from that commit, 
instead it will behave like "git rebase --update-refs".

> Does that make sense to everyone? If so, I'll revise my stance and will
> adapt the current implementation to do exactly that.

I'd much rather rewrite all the branches descended from the commit we're 
about the rewrite rather than those that happen to point into the 
revision range between that commit and HEAD as I think that ends up 
being confusing.

Thanks

Phillip

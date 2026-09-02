Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B8549DB91
	for <git@vger.kernel.org>; Wed,  2 Sep 2026 13:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788355248; cv=none; b=hehqMUhooeqKQ+AbWa4GCdWc5xNigf0x8ferKHO7/NnkDYuLNRc4NPRd8XgoNAa0DnWssbCOgT2QLGLKR87/UBQ+R3Om5q8kl3X+h8iy1379pp030PrQow35o4OrXc4bWOcztOXFFyk7Yv8lpuswDTNbsvfAgnG+IlRANRHswfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788355248; c=relaxed/simple;
	bh=sAkCzcv9XvJQvBmophIWYD7fGgWpR1xxRxv/B4qWgcY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UP02XxOePIUnALRL7eDxNANYEDXcq2FAfhp2UlCLAdn6Mw/YonE2skk2NZHwK1KAtlycFV1yOjD5Xvd6pkM9wxcqCtv272yXSbnPcqcS3XPi1plHYy89/Ezr+A1ixWlY8fQydfvQQ5gdFfnwS8bRd4TIjGr7o4I0zMUwX8ZFY6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EyAng5IQ; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EyAng5IQ"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2d944747d41so11714935ad.0
        for <git@vger.kernel.org>; Wed, 02 Sep 2026 06:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788355246; x=1788960046; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IHOZ7a6nhIhGZPziYQNOlGE9S3gCmv3eilLFrWClvhs=;
        b=EyAng5IQcDO+6dTiYpFGwFKBMXRr71/CsKbY+QrfABv6mCJsCYj1vtBxZ08MaTscSj
         yAgq9jh9KeRRK7aTXk4PeQXsOTwaOSYtvsaxpDziflOebmAYN3AIkQPMpBD5O9zGJFqM
         is4eD5Dh9/5p2UgZgV0xnsCtknPe7PpNOmOe/kSNscczASf6xP3KyXT9ye24LltH6qS+
         M0qV8r6c4n4mqREc8vIuCPfzf1TAU8U/uMPRtCDHesaFbbjJEt7NvcFBvTyLNWrYJ4tt
         W+QHgyjgLyPQxKW0/LUv4gpCvoq8F66Gnj0VTxlCfJaXZKsb6JkOrPLWF2tNCfQ5k9o2
         osXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788355246; x=1788960046;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IHOZ7a6nhIhGZPziYQNOlGE9S3gCmv3eilLFrWClvhs=;
        b=XQ5UmOlp0xKtO0pkp2FW6xCnLeMrgWmx0JD2rJIuppXDOqCSatHJlrsWMhCSBxnnll
         hSeuOZzdRXOSIIAMfQTQTcberRg5ZulUB6OP7TaM4eXNTs5jop3jzOabwcp2GkU+Iopr
         9FegJLwEtBc9z1f6y39GIns0E0D0EDUxUubVvybH2BQ1po/vyJI6qcaDoJruV1j9YO42
         /o/JE9y8ZuSOyNCl95zczWuTcoOT5yCrYi7m4jtR+n7j6WGgrU4ia7aaUsBhIJ4b2/+5
         +C19OXJiPKtSntcaW8Et7YFcsCSPHTeamLK0I+dYVvAJ/ldPZsdYhd4697CEzrfjA6Qu
         WkZA==
X-Forwarded-Encrypted: i=1; AKwUvBztBX/UrobLX9Rr5yc3NvH0MwO5tq2FCXSr1mMPXYB+Y2AqBpCewlcDJuz/YJZxhM5EUFU=@vger.kernel.org
X-Gm-Message-State: AFuF++m9XmYb8GqGDZR5udjyqpacNq8n9QCopzIU9o3wLsgO2Ap1CDCZ
	wnaju5i04e957LUc3Ic8l78l458eBuR9ERAqCgYM+5//C82w+peRyKfj
X-Gm-Gg: AYBFou239EgXr2jRivEGb7RBV9bmxRlurJVE1O4H2R7dzstdtKIdtVZWKQ22tk4a5DT
	f+kcxKETyPrRAh8cnX8w4PexHZ64I537xoDDUFQ8B4WoQJHT6lF5um+3VlxeFAfVtJ+VgSggQXg
	jzhR4m1mpGlA6LvCkrrpdWF6SH/JnYg/tXqKOkxJNz7BDipH7d66V1PUUgVqKU0fuzCz65TOEhf
	9hwF4oXGScvNix74nhwidDvuyyYauw/23NPoTKFtM0o0cBFHtDVn1RrhwcuZ5bAmloaAaeHBTcr
	pISU2VUnvfFgQduwoWYxMMUSUa1HVNIAcsDij6KXRERkRvCGR077RADG+B+46cIBYh3+/a0SIZL
	S7mHrGnCH5yW041VfoSoDPZCQql08Hr1lrDVTdtRCpME031knlOgQMQpIl3KCQEgCsxjA+vCWEk
	BeBa5VSe1+T1yfEmjhOJu0MOD5qJjYxrjlYakZXfNtRQpuWLKFnARtx2pUe3fU92U9E6vxpg==
X-Received: by 2002:a17:903:11cf:b0:2d6:fed1:7127 with SMTP id d9443c01a7336-2daec42ea99mr54752235ad.0.1788355246282;
        Wed, 02 Sep 2026 06:20:46 -0700 (PDT)
Received: from [10.10.2.12] ([202.83.17.231])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-331d6eaeb06sm3028395eec.9.2026.09.02.06.20.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Sep 2026 06:20:45 -0700 (PDT)
Message-ID: <4de9645c-f067-45bb-8168-1f660e11eb8d@gmail.com>
Date: Wed, 2 Sep 2026 18:50:42 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Participating in Outreachy's December 2026 cohort
To: Christian Couder <christian.couder@gmail.com>, git <git@vger.kernel.org>
Cc: Git at SFC <git@sfconservancy.org>,
 Pablo Sabater <pabloosabaterr@gmail.com>
References: <CAP8UFD367UD=AomNVHEBnhY-2DQmqTNRcBX6NW7YZywWgOmxTQ@mail.gmail.com>
Content-Language: en-US
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
In-Reply-To: <CAP8UFD367UD=AomNVHEBnhY-2DQmqTNRcBX6NW7YZywWgOmxTQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Christian,

On 8/26/26 16:25, Christian Couder wrote:
> Hi everyone,
> 
> Open Source communities have until September 11, 2026, at 4 pm UTC to
> sign up to participate as mentoring organizations in Outreachy's
> December 2026 cohort (see
> https://www.outreachy.org/blog/2026-02-06/may-2026-call-for-mentoring-organizations/).
> And (co)mentors have until that same time to submit project
> descriptions.
> 
> Last year the Git community mentored a single intern. For a long time
> GitHub or GitLab used to sponsor Outreachy interns working on Git, but
> last year both declined to do it, so the intern was sponsored by the
> Git project itself.
> 
> Let us know if you want to help as a (co)mentor or an Org Admin, if
> you know a company that would sponsor an intern, if you have ideas for
> projects that we could propose, or if you have an opinion on Git
> participating again this year, or on how we should select interns,
> etc.
> 

I too believe it would be great if Git could participate in Outreachy 
this year.

I would be willing to co-mentor a project this year. I could also help
as an org admin if needed.

Also, Pablo was interested to volunteer as a co-mentor for Outreachy. 
I've added him in Cc.

--
Sivaraam


Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B114A1E
	for <git@vger.kernel.org>; Mon, 23 Sep 2024 01:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727054804; cv=none; b=PGGDGpnTsZMJ2xegHFPQvhgnvdK1fZPbcXGkYlc4kfQ264WnqrsaGwBKDD+1i2PPytzVXV66hSU30aKypuksvQm1+2h//Z/r+KCMgYd++p5SlWZRjmTHFpv8+L+muINKAA8c3C+WEIK0MLXJWs4rEhA9WW/0iwAZIf7de1Wxbe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727054804; c=relaxed/simple;
	bh=8XlFApG6FPadMKvs9/6z33AE5+MsK/EP6PD6mz7amhk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gqFJYpsZ2CCg8tPprN/n0mK6fvG9gryDlru8xM2XjIxt6g7TCF3DN60EcTf/D123pQJJMoRsawD/kWhqqcG1I2hXjdxNXXdyK5IMkbvsGIgz00gIQ5YrJ+juBiM43vSc6h19anujyTZ6ym2r1/AKNOa+E8bRXMb45M98+VQFQnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BG32wn08; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BG32wn08"
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7124395ca86so1470936a34.0
        for <git@vger.kernel.org>; Sun, 22 Sep 2024 18:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727054802; x=1727659602; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M4PgJ9J3iZt3sbxQnDGUQkK7yNo/JBGNON6+5QU6N4s=;
        b=BG32wn08bJUBjE56SBoIUCiL0vq8PcddMKhmPIrdwwaQmYNdEXkqJJnW154MAXFvPe
         JGVOCkichhBM9Qj+IP/XYd0mLOJchWT+83OFHbptd5Fz+N3dZFmOLNRaeQIig+cb3gp3
         Ybm3nNQ0O4xzhWG0pdycj+p52zDrHzy1J5fbFI9K5BSfgjlNAW4i9DHU0OW7Ae84vIDR
         U10TVQEpE73onTvnsW5/IyrjtggNKdJik3e0uYkqMbfeibel1vhMRgkXdKTDS3PxDnsq
         7wmqu5C29vLPWuyHIomfmQ6lWwqXKRlWGufJmvhK6M+fmQki2rC3eEAc+I92hRQ4qJbD
         rWVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727054802; x=1727659602;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M4PgJ9J3iZt3sbxQnDGUQkK7yNo/JBGNON6+5QU6N4s=;
        b=QNqVqXMgGicdSXcgPtPsY7/9b+9My/glbReITptPMESFqYoYTukzPawQUA3CcUqV4G
         N1UTJnVTlN4ddl6L+AJOOw+zjMPIV2ncuD+XyECjIKDMuivzI+kN3VUVpnAxXoYueIug
         sCzbKbEJNO2K3Bh1f+W8pNkEiKtcJbRLKLSj4B9NM+9UCJLatX4a5hJm3CZKpEgNmSMT
         7lNchvOwShZNrqol6RBVRxiop8OSpAmCjGQjOEld6n8/dXi0c5mv/i1Mlz+5W8bk6B3r
         80Wu0jIIxsrfR+mgY87PGcwRu6ulK7s9e2U3x+SmdfAgrb2M9S7FxO135o393gWiY7ZC
         aSPg==
X-Gm-Message-State: AOJu0YxJdsNjc3CxyRUWf1PF12Oz1rdHYlWPMGE0qvEQpIHsNpANOqrI
	g3ZQzN87DV95drl5EuBjyhyjR5GW9yQ7Pbm4eRKUvZLQBOLKWqckfC+pKw==
X-Google-Smtp-Source: AGHT+IF77L0UcwMpoyIH+zsEwvrPrfl95CodjY6IIynV4C2+xxLIqC7e6yUhGU/XDUbVvnQIUC47Pw==
X-Received: by 2002:a05:6830:2a14:b0:703:5fbe:e0ca with SMTP id 46e09a7af769-713923abdd1mr7106764a34.4.1727054802509;
        Sun, 22 Sep 2024 18:26:42 -0700 (PDT)
Received: from ?IPV6:2600:1700:60ba:9810:1803:188e:65b0:6321? ([2600:1700:60ba:9810:1803:188e:65b0:6321])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-71389b4a157sm1968651a34.2.2024.09.22.18.26.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Sep 2024 18:26:41 -0700 (PDT)
Message-ID: <91bf8c63-b2fc-48ca-a6de-37a576ddc1b1@gmail.com>
Date: Sun, 22 Sep 2024 21:26:40 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Prefetch maintenance might lead to thundering herd issues
To: Shubham Kanodia <shubham.kanodia10@gmail.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>
References: <CAG=Um+3C1JMKoW+j03nF6uS2DjcJnKD7+0PSaiXGB-td9qyc8Q@mail.gmail.com>
 <b67c7b6b-f11b-4306-b3ba-c440e8cf7cab@gmail.com>
 <CAG=Um+2g-pn3XmC4MVkA+UAGeWpHw5U6fe=zXR=6-ibu3d0qsg@mail.gmail.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <CAG=Um+2g-pn3XmC4MVkA+UAGeWpHw5U6fe=zXR=6-ibu3d0qsg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/22/24 2:40 PM, Shubham Kanodia wrote:
> On Sat, Sep 21, 2024 at 1:20 AM Derrick Stolee <stolee@gmail.com> wrote:

>> This is already handled by using a random minute of the hour, as
>> implemented in 9b43399057 (maintenance: use random minute in cron
>> scheduler, 2023-08-10), for example. There are similar uses for
>> systemd, launchctl, and schtasks schedulers (look for uses of
>> the get_random_minute() method).

> Ah, thanks for pointing that out. It wasn't really clear from the
> multiple examples and cron expressions on the git
> maintenance documentation page (which have examples such as `0 1-23 *
> * *` for hourly). I should've looked
> more deeply into the implementation.
> 
> Perhaps adding a line to the existing doc might be of help? What do
> you think about adding a line to the
> section on scheduling —

I do think a doc change would help. Please submit it as a patch for
review!

Thanks,
-Stolee


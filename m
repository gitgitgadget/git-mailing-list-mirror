Received: from mail-qk2-f5.google.com (mail-qk2-f5.google.com [74.125.230.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 502C859B672
	for <git@vger.kernel.org>; Tue,  8 Sep 2026 18:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788891670; cv=none; b=qNPHfNXzcfwSnhu2sjITD15gyieSLeqNyFNzUdWN4TRWFo+z2l3winIgnQ60bQ+xoYjT1LIi8ntomU5CFhpnr79Ma8t6skaIcj6d/cxYeCtkGgVl7dCiydFaYsKFNTddSQhKpXrI/1SkcqYOOBJ5/BRcym81yQgHgDZG43NKuN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788891670; c=relaxed/simple;
	bh=pVzh4V5k3YZM6s7Zbo46CIXO0x4Og1o0ss7oOaXVeHE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uG+33rrzFMK0oMi8NDlsvufk0hxBpxIY+zvkEVrKxI35sxzNjs1JXPUbTNwlnkZFHB0V5Uo0ltEwovZF2e0dxrJG8NAMfEf9ykZXUcXJJZEw/3iPeqJCUkAu6nxS5zRBjIhNuqitNK5JXPFZHxmhVY7JSn4TiI3OW8Lk4ZHve/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=UCJm4oAs; arc=none smtp.client-ip=74.125.230.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="UCJm4oAs"
Received: by mail-qk2-f5.google.com with SMTP id af79cd13be357-939042cc742so252328085a.1
        for <git@vger.kernel.org>; Tue, 08 Sep 2026 11:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1788891668; x=1789496468; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9cBU42EYC7ArparLgcnO5hXmCVBaGvotJa4FE8iNwr0=;
        b=UCJm4oAs1lQMaexST/QvfNiGg9ju2JvgHYJ/9uTFdt6zsMyF0qRrvyCSf0fJTMr6y6
         4ekRcy49zW2gB4Ooo4Y6TtyhaS+xUPgICv8cNJAHEbBXOfImbC4+9B20U6VbikTxkWir
         ady2pWnSKUYuOTgYFeFitN9DNVXygNe8tvb0c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788891668; x=1789496468;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9cBU42EYC7ArparLgcnO5hXmCVBaGvotJa4FE8iNwr0=;
        b=rRNE2Yanxibh573zjbZgF/85TRTO05q7N/1ByaU7Sirk04YEDVaVFpJIsddSyWbexV
         tihTfLYp6wKU+YPa5zdi3oSRauyjRhL100EXVnrXhi8+qFT8A0wObq7mrSN22kSFO0Jk
         vPcg3ZB9BXabwWIXrEhDHLYwux/op2Ne+BkbIZ/HESOCDtw1yBfVV6RgNm9HRfDCPrzh
         Nczh6WcIPAEEuU87IAiUHRwt5AG2WOCRb/iYF+WgS2ri6M0mlCJ/8ASBkVZff4km0kUt
         lCqJS5pmsG0tvY6kHl+fRPRPKjVjzYJKm5/Rl07ffjZgLJUVmHGKlksQi0fJ1QIbfwQh
         xh1g==
X-Gm-Message-State: AFuF++mLBAavsgAJ3ihFC5bAhymlrUsxCpXaM1Kn1QvxkWxfQqd/XvzK
	bqstHvZcc9BX3PoHjqYMJaap9jyTLUzOuL4Mxt61GDmdmtmPrhjTz3iWxbQ460RLAhj92vPj3PP
	CKbGbdgzb93Mc
X-Gm-Gg: AYBFou0uaVR4SJJvC0eOEozhuxaMAd7LoA/nScH5Sd73neaR9yPFDp3guyReuuliINq
	DyqamuJQtML+82WnBsiR3zjH85rxykAMQAkVxOY8LK9nZUXU4lzp4MISDlcoBHCOohVi8Jsz9LA
	GPzSGh3Y1UcXiwf1Z1qGaKWF7IEIykh17O3pdvcnRIi+zPaICygV2Jnv1tCM7ewzBkOKFYjILD+
	1aKHRpVjSVzWqI0mMG8Teu3tTkURYMqFIrnblva9PShh+Zu6AYfB5K1NLOdh/XGWnXN3AlrTGVA
	90U9mTD999XY+FlNAD06VRIzn/G8eN8tCwaIhaJgjVuJDiLJJtwFxIcWWafchoZS1oVA6HWj+g8
	C2OmW8eo+tPWnAgl1H+/jVig7qV8XBUa0WriZPUFTak8rxavJ8nqytWDTOUu60629ppQUADrDWU
	sMg/tIVfT/CH/HUt4PjEloQyPWmg7xL+gEj93Kd8HQAZdEWGDlm/XuFW3le9fl+q3gH8o93lkIw
	0Oi/Jv00V/8ZbbgfDMhHLH+92cU70rKnnW7JXobeihfLA==
X-Received: by 2002:a05:620a:8386:b0:939:6d22:6fd with SMTP id af79cd13be357-939803712c1mr3036452485a.18.1788891667737;
        Tue, 08 Sep 2026 11:21:07 -0700 (PDT)
Received: from com-79390 ([40.76.104.167])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9397fbe00f9sm1207600485a.45.2026.09.08.11.21.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 11:21:07 -0700 (PDT)
Date: Tue, 8 Sep 2026 13:20:19 -0500
From: Taylor Blau <ttaylorr@openai.com>
To: git@vger.kernel.org
Cc: Scott Chacon <schacon@gmail.com>
Subject: Re: [ANNOUNCE] Git Contributor's Summit 2026
Message-ID: <aqBR4_huOMUY1GwG@com-79390>
References: <aqBRDSkgC4wrUUL4@com-79390>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aqBRDSkgC4wrUUL4@com-79390>

On Tue, Sep 08, 2026 at 01:16:45PM -0500, Taylor Blau wrote:
> As in previous years, we'll use the summit to discuss topics of interest
> to people working on Git. If there's something you'd like to discuss,
> please add it to the topic sheet:
>
>     https://docs.google.com/spreadsheets/d/1ianyjHMV8EHVfHvwFfNa3SAFu5NIIBLyKyD-pU8LArQ/edit

Heh. I can't make this sheet public with my OpenAI account, so please
let me know off-list if you want to add topics and I'll grant you
access.

I've granted access to everyone with a ticket to the Contributor's
Summit. If you're missing access to either the sheet, or don't yet have
a ticket to the Contributor's Summit, please let me know.

Thanks,
Taylor

Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4727B1C2BD
	for <git@vger.kernel.org>; Tue,  5 Mar 2024 19:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709665662; cv=none; b=JSP/2YOkqe3MABqLqOzKsDfo7p2bmTrgGe8VMf271xJMdqHjhFJuTUmo36si7YNvoCqFh/LaBy6clZbeaThv4sEn/0r9cB51b7l9hH6sDbOh6xseBzs789SZfDuFGwzXgskhgYv31oUY4nAvJEw2zcH+CTI9pRIBp0nAWW9Cnk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709665662; c=relaxed/simple;
	bh=7xdS2mg6sbbefMhsBchKNlC0KiMk0uV6xhBV7YqpnIE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qDzu7bWbwA3OjMx9oZkz8nRzesQ1X5E6qOL3Vxk7Er+YV/2UMyfw0MJ2m2uWfFseVoJKRdT8I7kEStRiZMvJGXtrhnzaFf6aOJXathiOhljzdcaaYcCBURnIsWcTLzy1sxwWz2FdpZia09hvnHsU1PvPgYC/8Bzcd1XFvtXsCqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=07SrF/yE; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="07SrF/yE"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6e5b1c6daa3so4401217b3a.1
        for <git@vger.kernel.org>; Tue, 05 Mar 2024 11:07:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709665660; x=1710270460; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Eur+Gm4Es66wLF0NWxs6BeNnpgU+MWQ84LRasDeqmz0=;
        b=07SrF/yE43tR/xfHPB+qPXwnxb7mbE/bugHlu8nXlWGo/UGwELkVO+X7mJugZaiLL6
         JsM89SFoAxepQOuH2b02DQLeFbmbTtdDY5BFBy/CzUKnVNhOtGF6bIeMOfPXvCktd/ef
         enu+nfycqZyrC8v7EcI1zdXq2+84DNrI//XGJD0iXnd9mujF6LXPtW62mGl5ooeOk73v
         H34NFwI1z0iJfqEC0L7I5Ou7b8JFEsU3nl4F+XS/lAVjRdO0xTvlup+eimmDiQ2t+rpe
         wg3X+YsHgIvWgpd+Z+lvBx7yGfgv4yzzp22/kWIlBh4RP8cXHcPzDyTrG//psAeJFfX8
         oswg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709665660; x=1710270460;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Eur+Gm4Es66wLF0NWxs6BeNnpgU+MWQ84LRasDeqmz0=;
        b=XIzp0Mvo27xySaikdnOuFTX69B8ksWIaEPKomL+PXoDWkidqA5UOiztBfJxfDSqGE/
         D0PN3aF+MeJpvw53JEGqVd4KLSq8t98P7ss5c40LT2ytwgyTaKcRj4ipmZex69ATkLiI
         T3PBPrKbXFXUOdTRnAgX0THj0r3yTDHikj+3QPmG5hSmqx8fTZdAfmg5bnII1g0dQyac
         fzVscvDv1AotyMTiYBdtb7lmjgqSoE5atpej17lebsLoDA1iDvFoRh1xGzuDbZXgdYKu
         Bl1FYzPU1bFLMFbk8dG/j0V+2iq5XvA3jIclwbcLhlx+FBpf1CBdsCsxTn3Mval/i1IK
         et1g==
X-Forwarded-Encrypted: i=1; AJvYcCXyxuxroD8G8jYVHXtmd5GY2BDi2n/wc/bAL/hQeZy7f2UWVSszfzfKDnGZ1ZIziBz1IN9z6X3+KTo0eyRsE7aTuDQN
X-Gm-Message-State: AOJu0YzbO+roiEVGPZJVotediWf1kiCPMvuuMcQ9NPeYCS4FPMGZYZPV
	zRHhbgKpcvjwmHRxHQ3k1tiWVh66518k6sdptHeWuiPJaUKDkBAUgY95ccztlA==
X-Google-Smtp-Source: AGHT+IHhcTAFR0KJvIXnDZ9gcHayYkTE4YwWOMGF5U8CUji0qCxienVxWsB4UIdr42+3r5/yWPGNHg==
X-Received: by 2002:aa7:88cd:0:b0:6e5:58a5:ceb2 with SMTP id k13-20020aa788cd000000b006e558a5ceb2mr16894436pff.29.1709665660366;
        Tue, 05 Mar 2024 11:07:40 -0800 (PST)
Received: from google.com ([2620:15c:2d3:204:f9ac:5d54:eb54:107])
        by smtp.gmail.com with ESMTPSA id x53-20020a056a000bf500b006e3b868b8b8sm9319142pfu.130.2024.03.05.11.07.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 11:07:39 -0800 (PST)
Date: Tue, 5 Mar 2024 11:07:35 -0800
From: Josh Steadmon <steadmon@google.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Linus Arver via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
	Emily Shaffer <nasamuffin@google.com>,
	"Randall S. Becker" <rsbecker@nexbridge.com>,
	Christian Couder <christian.couder@gmail.com>,
	Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Linus Arver <linusa@google.com>
Subject: Re: [PATCH v6 0/9] Enrich Trailer API
Message-ID: <Zedtd6esmIgayeoU@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Linus Arver via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
	Emily Shaffer <nasamuffin@google.com>,
	"Randall S. Becker" <rsbecker@nexbridge.com>,
	Christian Couder <christian.couder@gmail.com>,
	Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Linus Arver <linusa@google.com>
References: <pull.1632.v5.git.1708124950.gitgitgadget@gmail.com>
 <pull.1632.v6.git.1709252086.gitgitgadget@gmail.com>
 <xmqq5xy036a2.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq5xy036a2.fsf@gitster.g>

On 2024.03.05 10:03, Junio C Hamano wrote:
> 
> It's been nearly a week since this was posted.  Any more comments,
> or is everybody happy with this iteration?  Otherwise I am tempted
> to mark the topic for 'next' soon.
> 
> Thanks.

I scanned through v6 yesterday and have nothing new to add. LGTM.

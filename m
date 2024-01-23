Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E57253AB
	for <git@vger.kernel.org>; Tue, 23 Jan 2024 21:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706045162; cv=none; b=d+InJ1RsUp6g5U/sXlv6HMW0LE43K9NQqzq8lVetj8xgrKebVT7FPJPortnD/7+REduNKnFWDMBMdNFkD6YU4zavdzQrwJmVIaqEc3cDNTKLIiTc7RiVk7CrNDJVp0iI79h+d4kHlcsWVq6/CtVGBWIWHyxhyBWPPR5KdNXrDcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706045162; c=relaxed/simple;
	bh=Q6UMkWpMuAzRmMNMWSVua+4m7hf4n9R41dWbQiSZMIA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l9k+SDNTVwsMlZqfkxX5lQy+c7oZkaoUJrxxMzfqKfZophiLS7vQHWR9KM6ZFISePJ8Vwje5oAyscsTF0BpswNsYI/p0Ig6LNWGSNCFKeFEct/EYpZwaZoXwWcrk6wuFd2v9GXV6Fhu5xyAmRy3OXGu1Ry8b+i1zXek5c3HGlfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HUQx9g06; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HUQx9g06"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6dd80d3d419so764783b3a.3
        for <git@vger.kernel.org>; Tue, 23 Jan 2024 13:26:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706045160; x=1706649960; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CllrmtRl0TN1ZjXM8kclb3ExLX7LQmvY4Kbklh2qNGg=;
        b=HUQx9g06LPCFSU6tZDuR88yFxRXuA+ZKRRkpjso9favp2zmHKvgJULsYnWUxZqIsxy
         H5vW2D5mRRIYOShits8UDlBnxXGJKFPpJiccXd0hCgfwyTeQUybFZ9DqXFJFlZnbr96k
         VEsTn3LCYDypM6JliTw6KCkMUpfvcCDXB5+D1A3LHzP8cL+HwbIKjFH7NI6s3DCGc2SB
         cw3EAtTXJcD/xreHgv+zGdmNe9GtwiF8i52WrR5LGwF5i5T5sRimlWdgQUPGi4QFmNJ6
         Ch4QNxZNdHwqsAa9BUQo6C6iJy7WmhGnD3UqaCtkSiSLwQDWSCYVFfSJJr8gM1Sw12QC
         pJyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706045160; x=1706649960;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CllrmtRl0TN1ZjXM8kclb3ExLX7LQmvY4Kbklh2qNGg=;
        b=KF18lMxiocJC3OuNyJjwiAghjgcC1Je1h1Pj7y57z0LMmDqXmik9XLJp3KTzX4E3Dk
         kKuMTIUnNtRwwtx7bSE1vojE6sM9V3y1GHXRu8DImmafa+ndmyD8Gy2U+rVoyF8vG1rf
         Cwwla2I1gKOASXhi/VGVktOhd2cP2XC0SeL5hRSfSQDmzp+GEm/RqVBux590/fgF3Eoy
         zEVSgMS59qRRLES9CFXTP7+ZStS/hQnXS4cTvDv1XOyLASrzxauC/PPLZ6Cz9nD9FFzq
         E6Az5yy+f9YJo9SUOqzkaX4Ee6I9GhR3vSnudekM7vr9Bnj/18Krso4/MstV6yniQ5Pf
         5LkA==
X-Gm-Message-State: AOJu0YwV7Y2MAp2naDYY0Qu53+Gfat2gZU8HlLIDIlx1lbFJu+EbyTyO
	TAaxOk6CxpeaI0MbxBrWJI8+f2LxlUcuFEeLbLavZdS+rokV8GZcls4tuqqXEA==
X-Google-Smtp-Source: AGHT+IGGyj5qtWRDWxpP+DGWkRMLw4+IB6ONEJMfUURlcXqU/S1ZOPAxSfh9hBz5W7LwQl05DBW+eA==
X-Received: by 2002:a62:5fc3:0:b0:6db:e366:3f6e with SMTP id t186-20020a625fc3000000b006dbe3663f6emr3201120pfb.53.1706045160413;
        Tue, 23 Jan 2024 13:26:00 -0800 (PST)
Received: from google.com ([2620:15c:2d3:204:6543:4fcf:4afc:fb2e])
        by smtp.gmail.com with ESMTPSA id jw13-20020a056a00928d00b006dd738e9004sm2000961pfb.172.2024.01.23.13.25.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 13:25:59 -0800 (PST)
Date: Tue, 23 Jan 2024 13:25:55 -0800
From: Josh Steadmon <steadmon@google.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, delmerico@google.com
Subject: Re: sd/negotiate-trace-fix (was: What's cooking in git.git (Jan
 2024, #06; Fri, 19))
Message-ID: <ZbAu49xkxEzJ3ZkX@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	delmerico@google.com
References: <xmqqbk9ghio5.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqbk9ghio5.fsf@gitster.g>

On 2024.01.19 17:56, Junio C Hamano wrote:
[snip]
> * sd/negotiate-trace-fix (2024-01-03) 1 commit
>  - push: region_leave trace for negotiate_using_fetch
> 
>  Tracing fix.
> 
>  Waiting for a review response.
>  cf. <xmqqbka27zu9.fsf@gitster.g>
>  source: <20240103224054.1940209-1-delmerico@google.com>

Hi Junio,

Were there other open questions you had on this series? It looks like
Sam answered all the questions in your xmqqbka27zu9.fsf@gitster.g reply.
In your other followup you mentioned running CI with tracing enabled for
all tests. This is something that we suggested before [1] but it was
pretty thoroughly rejected for runtime reasons. Perhaps a more efficient
check for region_enter/leave pairs could be an option, though.

[1] https://lore.kernel.org/git/cover.1564009259.git.steadmon@google.com/

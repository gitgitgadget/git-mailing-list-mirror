Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 756331E3788
	for <git@vger.kernel.org>; Fri,  4 Oct 2024 16:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728059889; cv=none; b=mI3pPc0kvDS0rQ4j/QAK3yFO0h9mZCbhUwM3In8dQnYJkno20zhGtsaVY+rKi8rGWSEy+eVtDSw+2VxOdwSWezzE9MlN/POT0GuzTENo5eLDyj3m6zLlWcIy9c112s2ST36LGbjYmHtpuxsYEQUWB1IIS1mOWtYpBR52n56SAEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728059889; c=relaxed/simple;
	bh=oNnfkEiadjtX1mk1fLX/JCeYDvQ8DFstOqhpgh79vNw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oDQAHyZGQ0TMeQ23dBfq75isuZWhCscXcsWXidcG8DhyTsNl7XhKZF6NsqaT3/X4EaRCQabTb4xaWeujpoq1v29vaL+cNd5oHMYmdxhQBW6mvdLzqdDxr3U0zW7gVUcEmKsnPJ7Rb/dWepIN4IuWevMfHl2Exf5yGuQbRTTeGCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jPi3IzkI; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jPi3IzkI"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2e082bf1c7fso1726211a91.3
        for <git@vger.kernel.org>; Fri, 04 Oct 2024 09:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728059888; x=1728664688; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+3LEbwmy2LCJeZCahWuYpeJITdQoe3NYwLjqJMzEUt4=;
        b=jPi3IzkIEXdwrvK6yvVzDbYSXqKypKizqdyK4RxmgVNGm4HqRNCJN6HOYDq83UCFXU
         iWDpdBvDO+vbXWWjLE6gF6O7pkrtHleuIumYeAq68EeqBcS7hsZCIDpXR1YJUDx6UEZC
         pCEs+Rb388AfQZrHbBSfpg2XrFHaPMgX17IQTkLlpXZG6GVILDArFteKIl+7BAncDV9U
         NX9DdAOtN2nRpRV5oCC6F/myM91iOoBSqWmL6YJGRx9rcaLWWdU9EyWvhtY7+QLBJZcf
         dLm3K47wQNbS3m3+6yVHBkjmtT+le3IqKGiIKZX6DQWk8iGaF4zqOj4rF+xt/Z+1/HSf
         nY6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728059888; x=1728664688;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+3LEbwmy2LCJeZCahWuYpeJITdQoe3NYwLjqJMzEUt4=;
        b=MZ/Afb32uXpOO+tE3i3k1DKyHcLIMVA8zBENJyFK3uVnI+fJEjR10KN+JRLJGLLHFQ
         Q78mvuVi182/WQYbB7Yq7xajTQbgIJas6XQn+fDg+jtMyo25rW1hXmPGHEDDK/X8vqXp
         0QdA1uUbGAqYu8Ay7s5URJ99Hldsi65I4ge7bb4tcCleUNPOGiXL8UfQ1C9rzs+RhZf8
         /vHqdUCVQ10jRNCkPA3nq3b3cEUyGaaMwbXfpT7/ayz9iukvKRVVCfEtBMSBhPAwW3eP
         sZnmnid9zFab1XR0GPS8/sA+rwIg+/K401f4x1+1khahQE/ah8HIRuqD1NlrTV90SiHr
         0LdQ==
X-Forwarded-Encrypted: i=1; AJvYcCXRE3El+FSyMT4HCelpMXfxjTUoRZjHRt6lgmVoOUCZAnMCi7k1GdPecJi3h7JqvhTKLo8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxArFTzC+ETv75V1AqvrGA6RvUU/kzwDTj0JXez79vS9zu7vPzx
	2nDjP7qL7j8os0qREOMaLB2yKguW+9/aRS9VZTHMzYqh2CVLkZxIDnap8g==
X-Google-Smtp-Source: AGHT+IFvlohlTC5Vmz3e48wH8W8ZY5t1Aexl0PhWFvLgNef914yvBowFqSzHzChECz+bUXu8GKbtAQ==
X-Received: by 2002:a17:90b:1645:b0:2e0:a9e8:b9c1 with SMTP id 98e67ed59e1d1-2e1e6296d3fmr3793886a91.22.1728059887587;
        Fri, 04 Oct 2024 09:38:07 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e20af569acsm115669a91.28.2024.10.04.09.38.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 09:38:06 -0700 (PDT)
Date: Sat, 5 Oct 2024 00:38:11 +0800
From: shejialuo <shejialuo@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
Subject: Re: the latter half of october, the maintainer goes offline
Message-ID: <ZwAZ82gevwT2TDgL@ArchLinux>
References: <xmqqh69thzd0.fsf@gitster.g>
 <Zv7aLRXwt9cfqW58@nand.local>
 <ZwAIM6GO3VtoG3ZM@pks.im>
 <ZwAYccsboGIhGVIx@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZwAYccsboGIhGVIx@ArchLinux>

> Well, I think we cannot easily fund a single individual. It it is a
> full-time job, we have to also pay for the insurances. I don't know
> how to hire an individual in an open source project. But intuitively I
> think there would be a lot of trouble here due to the laws. As far as I
> know, Junio is working at Google.
> 
> So, the biggest problem here is that most of us either work at other
> companies for full-time job which are not unrelated to Git or work at
> companies which are related to Git(upstream). Although it is an honor to
> be hired by an open source project, there are still many concerns for an
> individual.
> 

"which are not unrelated to Git" should be "which are unrelated to Git".
Sorry for typos here.

> From my perspective, we already did this. Junio will rely on the reviews
> from other contributors. This is what I got from the Git Contributor's
> Summit, 2024: [TOPIC 10/11] Project Tracking.
> 
>   https://lore.kernel.org/git/xmqqployf6z5.fsf@gitster.g/
> 

I forgot to show my intention here. I do not think we need to really
distinguish these two modes. Even if we hire an individual, the
individual still needs the help from the community about the unfamiliar
fields.

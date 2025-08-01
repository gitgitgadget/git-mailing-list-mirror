Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91AC2D023
	for <git@vger.kernel.org>; Fri,  1 Aug 2025 03:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754017234; cv=none; b=WEIVe4X3lYSKpahipsXGTwjd9lpvq6dx1is9xfquw7dRstBMEHvP1NRH8VQkK9G800l+rVmkaEjnTa5OwkdtZEw9CyNmtrrzSEWSACl+dks7Nwk5WtLy/r7WDc7yQyJW3YBjjVYoS6EQ0e/HeyGZkw63cT7H61CxJc1PWFr6DxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754017234; c=relaxed/simple;
	bh=YGr1OeFR74cSN/VBLqREO6E9d7zUTYsX1Q3keZePOaM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pzC87ZS//DwfR/nzJUJJDB6WTkLHqtop9tcTodR/XZQ0eyNjkm/rpE7YvyCMEr6v/RIjeI4KQiU7z9cxD0OhJ/31mpn+Xwn3j+ObsYaRF1rPr+pj4eveq2VsEvnFr10c8ObSd1umG3pq0kjjw0lJsKnHU/zmekLy5xVJJOpiEXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CbfP/o/u; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CbfP/o/u"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-76bd202ef81so1473801b3a.3
        for <git@vger.kernel.org>; Thu, 31 Jul 2025 20:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754017232; x=1754622032; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=g25n/qicBAEUklzC/njfeJ6fbQmImGbnnUV7mxXK5Cc=;
        b=CbfP/o/u7zkKpl79Q+N7QKilB71akwGgU3becN+dnticOXkqeN4eZJFn1vxDGFeLRB
         o03TeX0E0HyrPRSRi8jMXeMX2+LD79bzfqv8KybwiOJoPxdeyfcUGqlysUfMKGJX3S4I
         PSH/Ie9XE5UXbFKuhDYEqTQk9KPRX0N79x6vpXZMwrRcuVfKIn2D6oGH9SHd2vdghDte
         yWElB4oZpmPAcAfBazs1jrJh3kaR1nYrqr9Hph1NYPdmtWwmAnnidNesoTZ5ypEJk3b3
         Sn6nn3SlSB0BC/LDKdSUKTXQEzJNmHyfC19Sb5vgHTqVO93s1vXPabnEfdZG4hBzvQOq
         xnWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754017232; x=1754622032;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g25n/qicBAEUklzC/njfeJ6fbQmImGbnnUV7mxXK5Cc=;
        b=spigQWtHjadq10x8Zw/9/rt8KCTj6NImrOgbUtvz2gb+OodSPB3akV31C3DKrtNdWT
         5/fQvuBhuHrb7jGr2z9CV37gFvaMiM9t+u1MLQihUHBka+AHiBXKs58VkJKKb5svzKDX
         STLZ1fOgB4fVKCLgkTW4aEo9Xl//kaSEqzIJvf3f13hst4KLKLnvi3T4GHRbVsSbLTQx
         ubdb0OfoujI0j7kpsxnuWavSTC5fJbdLSmNCs0XRnzYQNLRRO5njqQO9kr9Hf5lhdo+2
         U4lbxb7ZOeP4DE7wbF8r8BJXGQHVC6+DA6LRs+4N2yeRfRqajgO6zZ4Aa5KtMUSBZywt
         Z0JQ==
X-Gm-Message-State: AOJu0YxscfQlLH6NRoLANoQrGuxXf2gQD3TAkfUNY5nWlBIoH32nbQAE
	s6WnSIoybYAL8kgg7gRe0eGH66JWLf0R+afW1j4Q/KRvAl1zXY/4ModS9JITswv0
X-Gm-Gg: ASbGncvzz59vcawASQkCmA9ToPYH/0w4+m7g5Loi0zXCLjhfIxGfkQdfhiwqtpZbdxP
	2+6+RcBj8ciyqRi2z7xLJ2iA/hRRTnTiYCgQjkKeJOclgHjTmVeVZTeOzy4XFsvTwTbWRvKs7i1
	N+Tb+jf5uEgjzf1EGL78unXbkoxyko/sCh+wjHUmFE9CErk4CFePAZ8xhqMREMGcwgXLS4geNbE
	f/Esd5JmxwE0qBfY6BlBKxyUxwAV1PcaQ06dgHsfND7lU4cDLiS+hZfuA71pOKsSQ0y89tkm9St
	+3FIxhtH/LzNJz1hbaBNh4rrsQdF0XtSOEKHmQ82DRxnrSHfCF4zfIr1yOl7h4HEYUixMRdof95
	y+OWatC7Kph0Dd9heSZBAjcoVN6rq
X-Google-Smtp-Source: AGHT+IE0JxHxWFF2pOSW4YKu54L2iYxWR+IYg2sGp9TylBFHv4a4EyvPhFwYnaQlNB2/YRVOYk/TNg==
X-Received: by 2002:a05:6a20:6a05:b0:23d:ae11:e1dc with SMTP id adf61e73a8af0-23dc0f318afmr17697403637.46.1754017231922;
        Thu, 31 Jul 2025 20:00:31 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-3207eba6bb8sm3281072a91.4.2025.07.31.20.00.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 20:00:31 -0700 (PDT)
Date: Fri, 1 Aug 2025 11:00:28 +0800
From: shejialuo <shejialuo@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 3/7] string-list: unify string_list_split* functions
Message-ID: <aIwtzHdDQPzl56KU@mbp>
References: <20250731063949.1601669-1-gitster@pobox.com>
 <20250731224607.3942417-1-gitster@pobox.com>
 <20250731224607.3942417-4-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250731224607.3942417-4-gitster@pobox.com>

On Thu, Jul 31, 2025 at 03:46:02PM -0700, Junio C Hamano wrote:

[snip]

> +/*
> + * append a substring [p..end] to list; return number of things it
> + * appended to the list.
> + */

In the following function, we would always return 1. So, I guess in the
following commits, there would be a case where we won't append the
string. And it is, in [PATCH v2 6/7], we would simply skip and return 0.

And I have a design question, should we make "append_one" pure? It would
simply attend a string where start is `p` and end is `end`? Let's see in
the later patches whether we could do this.

> +static int append_one(struct string_list *list,
> +		      const char *p, const char *end,
> +		      int in_place)
> +{
> +	if (!end)
> +		end = p + strlen(p);
> +
> +	if (in_place) {
> +		*((char *)end) = '\0';
> +		string_list_append(list, p);
> +	} else {
> +		string_list_append_nodup(list, xmemdupz(p, end - p));
> +	}
> +	return 1;

Thanks,
Jialuo

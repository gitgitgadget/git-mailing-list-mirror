Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC68C223DD6
	for <git@vger.kernel.org>; Sun, 15 Feb 2026 22:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771194223; cv=none; b=M2FlHoCMOMPLOgXheh63TG3R2+fJVIqFLwUOPZgvZ2hi2vEnhKdPu5NnRyOo5j8ZrmczOhAcyKuWTcyNb4cG3YftNiIriBClohEOT23P+LNKu8UY4k4z//IgpFJBDqearUNUY3367m0DMihlCsSEn0EZlpjRoX6iG7343A6qq0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771194223; c=relaxed/simple;
	bh=BoZMYK+mdwbPiSZ+JoZbbpxc4Ha1pbYRC9Vcfuel518=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Is23N9zI/O6JeAIwX2pvDnN9K5XSb3WRk4n0SqYe0yNqJF79rzQuNiuWKnnpcD1peGia5IY6ZcuafbSUuE1X2Fsme/IAn+KOMKQ5DtJND0PSeJxM3ZJRz2VoCN0mBRi76Sa8iaB+nwZRox0e7g608yjyMUmlyuJq5RIGybi9aHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dCHGxaHJ; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dCHGxaHJ"
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-2ba6aa57d5fso2556086eec.1
        for <git@vger.kernel.org>; Sun, 15 Feb 2026 14:23:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771194222; x=1771799022; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=j7Nt5lJRXvVPG/U+818yjSkoq5OM0tmsuamcOYyNGTQ=;
        b=dCHGxaHJuRsg9X5lujd5Tzz7a7ZjaV1wEKtzaR3Ggps1cmprofh/plvY4P6+u223cZ
         3HGBnA1wD8A23H6KfH1g94EQpLobLwh/7eikHw2Q1wmGm+wA1KR1xEenAQqaWkAHJ7hX
         Zen9gcQhx9TwllwJ84zMnVjwPoiboJElMVVaoRNVGvhlP06ybF/52qiBzAKN4kCRqUSX
         +uqRhK7uqKbdJFVYDAFrATRfLn8nV/Rxxx4A0yP/1zNiEgVX9SrDWhRgZMIqM6ZSxKHn
         GEaacD8DhtPqFqqlDN7sheajfjoCGZgVeTH+2I8gtDzKlv6JrUZ8k220CwlymrMhFdCs
         Mmqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771194222; x=1771799022;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=j7Nt5lJRXvVPG/U+818yjSkoq5OM0tmsuamcOYyNGTQ=;
        b=pcd6OHQIT/zyKN7nOSunBIgePjIWdc+STi8Imp8SHMwWODO4hKG11CAUpW49L3/PWm
         25giRmflsHKDZGrEE7xjHJLvjf+S0ulenPzKJo/92OlZPtqh7sbbuMhuQni4tCrCct8o
         voBCduAn6ew1lNCoM61Piu/g/GB7nf92ewfE0PMGxGNFODBANDcucTNRzQwZvnc35Q5F
         2fVJgZv4p82j38G2FtSpNU+YBbJqtPt8p+p41c/uRx3oLknBdlrAM8Mm/OpaQvj5/ovh
         tJbyRrGI/8rZx7cfG3bANIrXtvTj8kw2DxlKXt4G0EhAHwGIiVxfqJzd0bMguRpNiLHF
         P0zQ==
X-Gm-Message-State: AOJu0YwgbDMl8lr+hAS4YcBfrBQxt1URDYlX3RxGcnmi0oNL1RAX1zsY
	ZYUcGW+N/8sUyMa1ukFBq81QYdo0pmnoB1tCMNq5+Sjs9I6nV/lN+nsw
X-Gm-Gg: AZuq6aLRIFJe5bJS0Hg3PSYFz79v4+EGO+B4Gu85e4RAdXhyPszocNTy6SLEWLjXtmq
	quTKu4cUxep7842Fg5EV+ZtuZGGzbpglgFHZVTnybuuEmLz/+rDj6NHy+pSXCAMPavJJzhuymtD
	TKrd5LusdSUVymUfyfNJIApCi+lVP3MHX/ltW/eSN4soPKe1z/jOog8WuoGYVmuAja7UHsc6ZzR
	CO+wd0/vejuAlqadRMQw2/Xq6UpE+kmyv5qr/5ApBx9HNFNo5dFA5fisMmNUT3tmEVzEF/yYL28
	5SE55trYyDPVMoOwCJGP63qnsDtRafert8BC3BCoOB/4tDybOkZChQf6bfaspDLvu459i4iE83s
	w7XrNtMc08v3barAy8YAZWbZUJo51E8znGsY3EtbytE9Z8m4HhFPVGmbfQ34bUsVfyNGM5I7TwY
	YULjypAlId8mgSFuA=
X-Received: by 2002:a05:7300:1348:b0:2ba:aeb2:3f46 with SMTP id 5a478bee46e88-2bac93560ebmr1869451eec.15.1771194221701;
        Sun, 15 Feb 2026 14:23:41 -0800 (PST)
Received: from fedora ([2601:646:8081:3770::996e])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bacb543d40sm8507669eec.2.2026.02.15.14.23.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Feb 2026 14:23:41 -0800 (PST)
From: Collin Funk <collin.funk1@gmail.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org,  Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/4] cleaning up ref-filter lstrip/rstrip code
In-Reply-To: <20260215085755.GA86262@coredump.intra.peff.net>
References: <c752a4a6c750bc485804b43d7b525754e39e5fe0.1771046151.git.collin.funk1@gmail.com>
	<20260215085755.GA86262@coredump.intra.peff.net>
Date: Sun, 15 Feb 2026 14:23:40 -0800
Message-ID: <87cy25ve6r.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> On Fri, Feb 13, 2026 at 09:15:57PM -0800, Collin Funk wrote:
>
>> I generally don't like the casts like in rstrip_ref_components and
>> rstrip_ref_components because they force you to write this:
>> 
>>     free((char *)free_ptr);
>> 
>> And the const doesn't really benefit readability, in my opinion.
>
> Agreed. It is especially egregious in this case because the const
> variable is called to_free, and so its only purpose is to be non-const. ;)
>
>> That is a bit of a seperate topic than fixing the warning, though, so
>> I left them as-is.
>
> It is a separate topic, but I feel like this is a good opportunity to
> make this code less horrible. That is, there are some obvious
> low-hanging cleanups that make the code more readable, and as a side
> effect we clean up the const confusion. In such cases I think it is
> worth veering off the path a little.
>
> I was going to catalog the numerous flaws I found, but by the time I
> explained them, I had basically written patches and commit messages. So
> here is what I would propose instead. I hope I'm not stealing your
> thunder nor knocking us too far off our goal.

No need to worry about stealing my thunder.

> The first three I hope are no-brainers, and the final one fixes the
> glibc const issue. The fourth is perhaps more risky.
>
>   [1/4]: ref-filter: factor out refname component counting
>   [2/4]: ref-filter: simplify lstrip_ref_components() memory handling
>   [3/4]: ref-filter: simplify rstrip_ref_components() memory handling
>   [4/4]: ref-filter: open-code slash search in rstrip_ref_components()

The cleanups look good and certainly make the code more understandable.

Also, I confirm that the last one fixes the glibc-2.43 warning.

Collin

Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3AAB17C9E
	for <git@vger.kernel.org>; Tue,  9 Dec 2025 02:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765246598; cv=none; b=Nd0K+svbX6wjIhl8iD1LAQyDvHFgDRtYN3agPK6dBCkQbY3VNpmdrprwSzKrkms2XSg6qvI3zUfvFUhZ8JyZcbGUNb0bHTYcWl/Nlt6Jc5Z5ax2gSghnTDUQh7M2Mp5jsFwG6pW0n28ZgCe8JiaAicvQLGjw5AfG9aUplWKwxkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765246598; c=relaxed/simple;
	bh=oJaMLEOo37VmRs8wUWk0i79tfVhwFCurdN1i8wV4bGk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BxVmHh6suE26TiWj7sNd2sXxTYwOdN8vdw4r1hocIu550oNkUJQb0k3UfW0Z/rezx8mue3c0UfxrHG4rSpUhXQKJ9DrXIr2w4TeFNQXeNEzNy/qCIn37aqk2KUmuup34tvkON2Isz6yphjNvDAIV4NY0HzX0ewStzjmWprdsUeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=LwT2U+/y; arc=none smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="LwT2U+/y"
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-6433f99eb15so4521789d50.3
        for <git@vger.kernel.org>; Mon, 08 Dec 2025 18:16:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1765246596; x=1765851396; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sa26c+XnH0Xkn8W+Eb9c/ntyOONmxIeFf6RV9a5dEX8=;
        b=LwT2U+/y5UqnrJhr/teNp0DcVKgsFOAS/1AG7UDUIP+LsnbaL9CVxLraA0U9Vc1HT4
         2MoM4UZ2Y52/sX2ghv+Dco8pEK4w3zTfkbRKXyCFX7sd1u19Dzl0Ce3ouWEAitpSmNT+
         RZO8OC+0t0vzDgXm2CdoUfhhWlDmqIiLq9zd5VLOe1tuuL9iaB3Ugc92olw2Y0ataW/X
         /D8m/SCMNf4KvkJdWSLFquNoino8yQE1glSlDsChrpSryNkIxxLwiMLxyoF3XZACXRH/
         0XizSc7VjnSthr8hvoPSYZPnuZF+i8LLExPIfRlWli88d/wLKtkrwBjg3H/9aI3tvTO5
         aknQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765246596; x=1765851396;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sa26c+XnH0Xkn8W+Eb9c/ntyOONmxIeFf6RV9a5dEX8=;
        b=CSQ6Jn1m0bR3Lppjq8ndjJLmY863NpRtHL7bLCtUNi3pl2V9tS4Ua4tOQbihYPpZ97
         8IU1xcO1RVvvEl/FSCSxCDU1sS+b2PvS/Ee3+/jlHjWNBImTkevb7jl0mvFrdmewHZRC
         JDM4mO4AFjmXVXB9c31sQQ/IDlDBdAeZx+MHyQV+ETLfFQfjeY61EgZbhWy5YK/uYh8s
         q5BIxpcOcqP+z9ZBe2aWz6DVtViLpJRxDXxtmAJYU+XenpQJT70Zc2qN3h3gs//CZGlX
         v+OBFZUhdb+coziR99ng0toYugJwUTzizFkPZDA+sSzntTKopRpg4fCu6YXKHk6LrUXY
         nIog==
X-Gm-Message-State: AOJu0Yyx/4E/QE74gApFZideViZuCFEnEzsfz0v0CRE6oSAouDV7sh1V
	UWDJuJJ2iU9oaFji7Cv0Mtdwo/9iXERoAcwdTBlc7SaSz2FrrkY7+jkWgai6WtpqNLw=
X-Gm-Gg: AY/fxX7WtulD3UXnL9AdIlG3gNsrkZk0eP4SQvqnVxna8zKlh90fffE8j0sDKp/mD3N
	H1XbZ8Wwef9OYS4UqclVuffYceO51nEJOSOd2lqzLx/dBHmT4b4yLIRl6AT4p/n7Kxa48+Y0gtU
	ErzAsUkNE9PlCxAnggowSXIXJUOk8BIBrVpQD7355Dufj8TJPbZDvoO0KmksnVPvZYySZJxyNGX
	IiZFzG4+Y4HtVz+77kkNXQQGfDb8fofQHDv64dypbk5g9fcCb5vskcUcBIcuZxMPLhnKDYOkgPD
	KdaNPnI7BmSio5m6+IgYz9nKH/0IX5yKFe7kVG3uoG3MU5LPw1BxWP/gkzFztGpUv3ZQf1M5ct/
	t0ZHFVULcDbK4jFLyjLYILEKnm6tnFIiK4n/i/W/4ENv0F+AFFvjqjmUqTViwav0Qj6214K5x6Q
	smQM7q5qNn2PxvhoxYGTqDxCX0/zKxh2kASTIDuo3GX6Iq9R6glfPu6crxEOYq2G2wiG33PIRRg
	D82F8AqgLZmhh7Pnw==
X-Google-Smtp-Source: AGHT+IHfBfTs0mMpbey6cqVzBI1Cf2y7M92x7NLG9rRBQH4PJOp2WLf4AYg3SaVkdkTzyo3nKocr8A==
X-Received: by 2002:a05:690e:1912:b0:640:d255:2d75 with SMTP id 956f58d0204a3-6444e7afbb9mr7405326d50.48.1765246595952;
        Mon, 08 Dec 2025 18:16:35 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-78c1b77c0f0sm53801257b3.29.2025.12.08.18.16.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Dec 2025 18:16:35 -0800 (PST)
Date: Mon, 8 Dec 2025 21:16:34 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 15/17] t/helper/test-read-midx.c: plug memory leak when
 selecting layer
Message-ID: <aTeGgqxVO4xcuk6y@nand.local>
References: <cover.1765053054.git.me@ttaylorr.com>
 <43ef3d0013f1534c7ff8b1a7c4a17fb0c9b68684.1765053054.git.me@ttaylorr.com>
 <aTcYhKOIu7ebJ_xV@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aTcYhKOIu7ebJ_xV@pks.im>

On Mon, Dec 08, 2025 at 07:27:16PM +0100, Patrick Steinhardt wrote:
> > @@ -36,8 +37,11 @@ static int read_midx_file(const char *object_dir, const char *checksum,
> >  	if (checksum) {
> >  		while (m && strcmp(get_midx_checksum(m), checksum))
> >  			m = m->base_midx;
> > -		if (!m)
> > -			return 1;
> > +		if (!m) {
> > +			ret = error(_("could not find MIDX with checksum %s"),
> > +				    checksum);
> > +			goto out;
> > +		}
> >  	}
> >
> >  	printf("header: %08x %d %d %d %d\n",
>
> We change the return code from 1 to -1, but that ultimately shouldn't
> matter much.

Yeah; I think that returning negative values here makes more sense, and
use of error() encourages that pattern, hence the change here.

> I'll stop reviewing here and will have a look at the remaining two
> patches with some fresh eyes. But so far this was a nice read, thanks!

Thanks for the review thus far! I look forward to your thoughts on the
remainder of the series. In related news, I owe you some review on your
'pks/skip-noop-rewrite' patches, which I hope to get to tomorrow.

Thanks,
Taylor

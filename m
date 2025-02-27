Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6E618FC84
	for <git@vger.kernel.org>; Thu, 27 Feb 2025 22:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740694066; cv=none; b=f6tH67KMNU27h/x3zNdZQHgeINaIM9yazQ77ALpT0CTtNDETKwkp6DrbFXmjqo9MlhwCh2v5sJR+gpJKvpai51WcVXifqJ0Xwxs0VyOQzv/Gyp14huKrr0o1z58UMKfbFWYXtUjcTT87a+mo/BsUnTyeEMzdrNfQWdlq89A2F+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740694066; c=relaxed/simple;
	bh=NwiXaxmteM96Tp9fxo6bIRGyS5OHZ90DHvn+jMp9EPc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jjsq8XzKqiywZ0vYmFAyDlWq6AlPAOTfUmBWVNMvRpMPMKPp09ucfFQz7GI9ZbDsJT9GEjExOOHd3nRtejzhaGdnydYWSUtdNj485TYeWP2S2XMyIQXefP4rZ/kqY7VCGnnGWshoEN+DOLVPbOxa5Ne/1VIJqZAnYHEtXg46obs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k+fTWyg+; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k+fTWyg+"
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-2bcceee7b41so424692fac.2
        for <git@vger.kernel.org>; Thu, 27 Feb 2025 14:07:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740694063; x=1741298863; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jSopgVt82L/XQ2JMg10fnIcxaS76YafQx6+dM1i+4rU=;
        b=k+fTWyg+gRhuhoa5Ougj5y7Si/DeNOiI5eD8ELYaRdSgPZlEVPU9325Keyz5di7EBr
         zg+dyA8a8g4QZzWj0PZ0AEkFLss14/KWNb61RUKUrlumsvl4hOcG5ZBpJsKQWwJ1KLMe
         mRJwdMhIiU7ZuxmFXA1q0VHq2MOSDbEOB4YrlzV9gAqSX0LtP91Uh7VzK3oO1GLyHs3p
         xzF7UCqVMNkXeJlXlyuBqrya/OO3xYwxqwfvDXJ4GXKUQj/EWb/UcHSNQfVFEZjCn3Rc
         GU8pP4/b6OQWN5YfDp4zvGdgN+L99BJXh3r/YFw9C9G49TvizSgPAx7fYq9oVBiaZGcz
         tl9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740694063; x=1741298863;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jSopgVt82L/XQ2JMg10fnIcxaS76YafQx6+dM1i+4rU=;
        b=Me2bhYdk0QeN3i7D+AdArtIzdyYfaTNVaRIT45t+02jxTuEqTdRj5v9t6VhBcxtVM7
         0qggXSREcVmw1OWYBQhEvocCk9vMH1z3spF2j9ACYudxFeo3i9M359QKE4OCWlV1JCQd
         hCKrp7sy+oVlIH8YWl7b+oa0f7XLfKM9BhcBJ9AqK+RBLTbX7iKo9FmGlgjGFGg53hOU
         jrgd3PltpOPeKNEEo/jIWpczxOhhpS5R8CAzUENfSPaRV1GZf38UTTYXRu3rLDujK6tj
         I2BUb1cHgMuo7n0Cy5EsWAdpwFGHRbIcoIfWJrsRdYlwBdSaDvJch8V3/zkEl1VX4Qgp
         fSTw==
X-Gm-Message-State: AOJu0YzGH3m7UwVDT5mXdg2DbNPHLXBQpyGOsolF0d8ulCzjLTcApzSI
	Y7kePKs5pHVSzxzf1YpdGG1ZEr31xv/dGZ9A3POso8gHKkL5Ut6my06yGA==
X-Gm-Gg: ASbGncvd7KPnTyf+JPlAotFApfn35PT4tyeDl2Zk1fxmM8J5XhoMiZwFxNkeRaqRub8
	ekgoYl8bWXJ8VP3Xy7eDKeYSMQGNVPP9+rSvPXUUydxLvrh5DcQnUFFLs6Tx3yFxNUxQit0uc/t
	QSueKVnri/rQuHersnk1SzKOsk1nj9Lf9pgnF3obGlYLzXLLmxbL8CIq/MZMV0WkdnqHd/NJJdG
	AChppX4HmtHcf11GSMRwN4sqbXBXFiKi/dg1UixvsE1oPDwhs4uShiAFEc13mh4NrWhKBzL24r5
	VqNHjO/dk+DlX3how0g=
X-Google-Smtp-Source: AGHT+IE3gNam1dSco6riusgpDBpjR5oftuuccsGU6dSWkvv9VgVlaxdaQ+9I6uKB22z7c5mH0qtkug==
X-Received: by 2002:a05:6871:79a2:b0:296:c3cf:39ed with SMTP id 586e51a60fabf-2c1787ba82emr521567fac.38.1740694063646;
        Thu, 27 Feb 2025 14:07:43 -0800 (PST)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 46e09a7af769-728afd7694fsm409366a34.50.2025.02.27.14.07.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 14:07:43 -0800 (PST)
Date: Thu, 27 Feb 2025 16:04:27 -0600
From: Justin Tobler <jltobler@gmail.com>
To: phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, ps@pks.im, karthik.188@gmail.com
Subject: Re: [PATCH v3 0/3] batch blob diff generation
Message-ID: <b3a4lco523aodf3oqctf33utcp6372b3qp6sgekeb4dx2wbtya@huxwtr4vw5md>
References: <20250212041825.2455031-1-jltobler@gmail.com>
 <20250225233925.1345086-1-jltobler@gmail.com>
 <1e41249a-5241-4cd8-8a6a-3c9163fb0ea0@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1e41249a-5241-4cd8-8a6a-3c9163fb0ea0@gmail.com>

On 25/02/26 02:58PM, phillip.wood123@gmail.com wrote:
> I also think we might want to massage the output in the tests so that we're
> not running test_cmp on files containing NUL bytes. Using
> 
>     git diff-tree -z ... | tr '\0' Q >actual
> 
> would get rid of the NULs but does not improve the readability of the raw
> diffs that much as everything is still on a single line. Using '\n' instead
> of 'Q' would give us mulit-line output but we would lose confidence that the
> original output was actually NUL terminated.

Is the underlying motivation here to provide more feedback if a test
fails? I somewhat have a preference for the test to be validating the
output as it is actually expected. As you mentioned, getting rid of the
NUL bytes wouldn't help with readability much and we probably wouldn't
want to replace with `\n`, so maybe a simple "Binary files expect and
actual differ" would be the most straightforward.

If this is the preferred way to handle it, I can adapt in a followup
version though. :)

Thanks for the review!
-Justin

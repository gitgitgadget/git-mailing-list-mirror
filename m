Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C588633F
	for <git@vger.kernel.org>; Tue, 15 Jul 2025 18:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752605053; cv=none; b=P/6SZQCu+aSQmErrXnve8qN2r5blaR7sDRTnFeUp0/cxoDqx/OFbXPAGzKYCz49rZne4T3hA2HXKURTRrW/ZUSvGSjWuqNK6RJwDfe8jaizyNJlXhJVrUU74ncjH1P4A1JqudOJ6SlreFMoTZhuioi9AT5k9jm0UJ/YtGH35HHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752605053; c=relaxed/simple;
	bh=ol1DI7JtSiYnCIoFtPz06IfMNzh7Ua0zOALfUlF5okE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n0c7cMUAUQkSDroc1FsfdMrAd57dZkRR6WrO+zqVxkt4gROBcby/nPh3D9hAy6AuY2XMDmVdAHKQcv5FD2nt2i+AGZKg1udMMwp6rcqz2wM8BvqRRmuvWF8AexJbEe5wyzLnhMnb5I3aMW9D4QjYtKrQxoqQc5bUOBWV52jfAkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bEZOMXlZ; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bEZOMXlZ"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-73e58d51060so376292a34.0
        for <git@vger.kernel.org>; Tue, 15 Jul 2025 11:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752605050; x=1753209850; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=h/nhhUTjW6YvZS7QloZtG8tZ859ly0AVEDdICTwbO1c=;
        b=bEZOMXlZmLeoPjSLHU38J/MCE0SS2+PjHzC9e4g2TsDqLvTx5N+nQ3FyQBXuhECn/z
         pbhJdyFmGfTAWVp/q1BPbGu/cAeWLqA8EDNxUTGMn464A3oJB/suFYzKwYKQDTi1ogDj
         zA2Eu7HROnyQ+nCvsduwTy4PctJZ6kyOZrtC0ZFoAvlyo48mYhPmi8XGhTU366eNxo1h
         xmDv/uD3Pt1kVHtcRXywBbUtNg90NFClrxSftQlUidUdX6iLoPTDmex/m3Zta+VKMPAv
         eaXoRKWT6Wf7FruFPc+yYymr2gUYnD7PVjrqlDoJUVta1QloriVoGk20Ru7H3f9cIRI4
         zQ9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752605050; x=1753209850;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h/nhhUTjW6YvZS7QloZtG8tZ859ly0AVEDdICTwbO1c=;
        b=IBK5+Xp1bDM7b/Z2Nm8heghur+3Tst7Ms+TVmJ2QtmrP4iG1zsnGvKAnCBo5OTTqRn
         zpg4xwcSlc2oRx2UteF0/s/jiU7GYUuC8S+6F0AtZ8sfReRLeiBXIJPrjR802rz3Bxny
         O219WY79BnPAYQi8TOjlEysXDh8CtUaOguAe5EzsTGUvXOwREtokZUvymZfNuEPwvAgi
         JuTJNCqBVuEFeWf0sZyaab61K+7SU3YwflrVz170i+Sjgwxzkhnde/gX+OL+jm8tlhhb
         aNfvLBE3aJuR32TaKfB0BAylCN+3qtAezv/47YBEO/9UtY+8LEcoxR8s1C1tlTJCy+Z8
         xqIQ==
X-Forwarded-Encrypted: i=1; AJvYcCVlDqNQBgMZryCV+SVjre+zmZk2sqJmQXURMZ0wyJNIPVZ0MvWzn3wF96UtasGkvQVZHus=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKk0zu+k155Ngn1qWsns09fvdfprfZEbVESyBQZ9JPYCV3Ar+Y
	XtbHRAFgnBeGv8Ad56PL8X8iYP0sDcJPzh6Nhxtn/1LKgpNmHTQzwsLS9d4vbg==
X-Gm-Gg: ASbGnctgm9v4xT7OuWae945UmyjJIbtlpEvzsG2mWo0QFjppJ1JhWqM3QUY+H+4rzh8
	zvmt1Dfv8L/qNKT+I/0v4Qo8AXJwDzyC0vaC0XhOlVD2sVN4prysJcMytaP30TLNi5RX69T1Xl7
	oa3zOBklEO5tpJsfL1/7BOQUe/Xjl2simaadqD7gB5qgLTS0mDRi0RBNR/LZjNDJT64HcDVJvNX
	kQcRTybKc8/Pr8unpH65rZbQX4jCHxsUWSugnTLrDF5XoYeNbqvoitv30XwYMP902XrkN2xgqDk
	+YLRk6kfbtT+BTHP03DT5sFS7BdjABQ3h7IzHU4AENWFkpjfgdX/7lGXSxo1MzYD3k/EefNdUAm
	3U7uv3cdR7wET5Ek=
X-Google-Smtp-Source: AGHT+IGEmB9fLmyx7SRewcflR/wMDJ1pbwNiz+B/1iG43aoHCUwmkRRnm+63EAIybAXupYm0tQJPBQ==
X-Received: by 2002:a05:6830:7201:b0:739:f84e:9ba2 with SMTP id 46e09a7af769-73e64af961emr404130a34.25.1752605050508;
        Tue, 15 Jul 2025 11:44:10 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 46e09a7af769-73cf1064f46sm2336524a34.14.2025.07.15.11.44.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 11:44:10 -0700 (PDT)
Date: Tue, 15 Jul 2025 13:38:28 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>, git@vger.kernel.org, 
	karthik.188@gmail.com, ben.knoble@gmail.com, gitster@pobox.com, 
	phillip.wood@dunelm.org.uk
Subject: Re: [GSoC RFC PATCH v4 1/4] repo: declare the repo command
Message-ID: <y3t46fgy6vun6qlxb2fq7n3tcq6zkhfxeoluratzw7jj73ksyn@ggyxtxbgdknu>
References: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
 <20250714235231.10137-1-lucasseikioshiro@gmail.com>
 <20250714235231.10137-2-lucasseikioshiro@gmail.com>
 <aHZChXPTbk_X6xDK@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aHZChXPTbk_X6xDK@pks.im>

On 25/07/15 01:59PM, Patrick Steinhardt wrote:
> On Mon, Jul 14, 2025 at 08:52:28PM -0300, Lucas Seiki Oshiro wrote:
> > +This command returns the retrieved data following a null-terminated format with
> > +this syntax:
> > ++
> > +----------------
> > +key1<LF>value1<NUL>
> > +key2<LF>value2<NUL>
> > +...
> > +----------------
> > ++
> 
> One of the things I wonder is whether we should by default adapt those
> tools to have human-readable format, e.g. in a way that it can be easily
> added to git-bugreport(1). This would teach script authors that want to
> use the command to use `git repo info --format=porcelain` right from the
> start to have a machine-parseable output, and it would allow us to
> iterate on the exact output format.

For this subcommand (and the future "stats" one), I think the ouput
should default to a simple <key=value> form for each line and use a `-z`
flag to add support for a nul-delimited mode. This way we still have a
default view that a human can feasible consume while also supporting a
more machine friendly format in a manner consistent with other commands.

For a more decorated view of the data, something akin to git-sizer(1),
maybe we could introduce a separate subcommand in the future like `git
repo summary`. This could allow us to implement other information such
as "level of concern" separately and also group the data in a way that
is easier to digest.

-Justin

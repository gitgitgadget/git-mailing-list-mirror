Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2878512B73
	for <git@vger.kernel.org>; Tue, 30 Apr 2024 19:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714506568; cv=none; b=nYEoXgXS81C5b2uVcawRzGt3Luym03rUcQ8AgO03XSpHBUiyadJB2WzjHbIJLjJUIC5MvyHBBOaL7K7/YCic9xlO3+xtnxTJCYWqdyoBmmeWbyAG5s1/+2DqpapoJTMtuVoNlh/afOqm4+AqoQywHjoGY9P8BSJTqiMZV5TNvQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714506568; c=relaxed/simple;
	bh=2N5esIUHvqyW9E8SRm3/iifihUVtjx2vG99CbLslLOU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SHchGxaMT1eMAL7mFCkaEG28zxcfGk9CI4l37S68kxe/izOFwvdiA0gRsB+fuVI3UAG1z7OCdWs/LomKDWkBY9xn2GGKW2+b+Ufr/0MjUSLDjvHlU0NjwtsdJ9d9vsr5iJVaMzz1OFMbrh8myhNDY2EElduj7wuTUDj3eRnnd/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hEj2Yj3c; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hEj2Yj3c"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6ece8991654so5669492b3a.3
        for <git@vger.kernel.org>; Tue, 30 Apr 2024 12:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714506566; x=1715111366; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hy/9pW69X7d0o/voMrM00fb8it00CCW558bcJOQwVPQ=;
        b=hEj2Yj3cEbdFfca2v+yWSCALateZrQt+onFCe/Kd3XiLx9V9AOWuV7Us7MyDFUwUTD
         DI7bvF3IzKiXrk0a5bNZ5rtXxEja5edbKIBOGcGJ/dWM5pgsVYx/6YdjlywMV1JoFG4e
         XOp7BdFBz6ceR4r02L/hj2t3NahpmUrbqNwIwkBWqD754jumc8Bmrq5CorJIyfz3V8fz
         nLWAgQFcmbsE35EZRMEAFJ67COzVbmjNZwS+WDYFA8FkUW7ys4XAHn3D8V28wmqzPww1
         BPRDlRa2SlbnSAvtocntMn/rDMl10t+qom7GrvdtjL+DvQQyY3xXpw6DzUfbKOrC+FbY
         DThA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714506566; x=1715111366;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hy/9pW69X7d0o/voMrM00fb8it00CCW558bcJOQwVPQ=;
        b=hSlx8M9nIbDO95E2UMQPOmb2LcuQLS7/Gg9ppEEOrFY0wbydE9NJMj/cA7tkXM1QTq
         6nPT+7vQhQ6uQZaoNs+qemLn6scCNkquJXhjmeHjkQyCSRxlJyjeHEXzDhU8qzRD53we
         tcUU2QyPLrqkYCL6ab+S9mW1StIqaTFU9CB+vhqOyh586pRBgm3x+pYiXxWgRbKDIBTi
         xS9q4cd198VtpcYf8hibfpjWWKr9m/2YwKo1/O7I/CrYMrFo/O7trYqo0aaG+emjoRLC
         AZAWxlWmtQweJWqCDFyoN1fWZMr2Bl94+9IxWULEv/l19dmaowj1kIiM6LoO5w6taNst
         bnOQ==
X-Gm-Message-State: AOJu0Yw03LLT9GYl9pt5PQPCLBizB+Qaa3yxTv9Y7/Bf2LP9ChNECYWh
	qXNoKIDJKtBCkXKd7NYbHZZXaKQnk3U5xMxnyn0GGweORNUF5Z9Ox7x0ZWLy9Q==
X-Google-Smtp-Source: AGHT+IG+ZjcwD19IkDCBLPs2LmWf9xz1I0Mo8cRRAM0Q0VRDjNztjOHBv2BeZrVzNrj72OfsaVqvQA==
X-Received: by 2002:a05:6a21:3997:b0:1a7:3b4b:4153 with SMTP id ad23-20020a056a21399700b001a73b4b4153mr929099pzc.58.1714506566070;
        Tue, 30 Apr 2024 12:49:26 -0700 (PDT)
Received: from google.com ([2620:15c:2d3:204:3e48:fe18:8aa:8a0e])
        by smtp.gmail.com with ESMTPSA id b1-20020a170902d50100b001eb2fa0c577sm7709702plg.116.2024.04.30.12.49.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 12:49:25 -0700 (PDT)
Date: Tue, 30 Apr 2024 12:49:19 -0700
From: Josh Steadmon <steadmon@google.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH v4 6/7] t/Makefile: run unit tests alongside shell tests
Message-ID: <vspumeff4mdkxjnbqgrkwh25v5wh45zpq7yvrbkfagaknzrv54@m3mz4rtunn6w>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>, 
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, peff@peff.net
References: <cover.1705443632.git.steadmon@google.com>
 <cover.1713985716.git.steadmon@google.com>
 <0e32de1afe9cbab02c5d3476a0fc2a1ba0151dcf.1713985716.git.steadmon@google.com>
 <xmqqo79yxxk7.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqo79yxxk7.fsf@gitster.g>

On 2024.04.24 14:25, Junio C Hamano wrote:
> Josh Steadmon <steadmon@google.com> writes:
> 
> > +case "$1" in
> > +*.sh)
> > +	if test -z "${TEST_SHELL_PATH+set}" ; then
> > +		echo "ERROR: TEST_SHELL_PATH is not set" >&2
> 
> Style.
> 
> As an empty string is not a reasonable value for this variable (and
> you do not quote ${TEST_SHELL_PATH} when you use it in "exec" below),
> 
> 	if test -z "${TEST_SHELL_PATH:+set}"
> 	then
> 		echo >&2 "ERROR: TEST_SHELL_PATH is not set or empty"
> 
> may be what we want here.
> 
> > +		exit 1
> > +	fi
> > +	exec ${TEST_SHELL_PATH} "$@"
> > +	;;
> > +*)
> > +	exec "$@"
> > +	;;
> > +esac
> 
> Other than that, the update in this iteration looks reasonable to
> me.
> 
> Thanks.

Fixed in V5, thanks.

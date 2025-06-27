Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B7C2DCC1A
	for <git@vger.kernel.org>; Fri, 27 Jun 2025 14:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751035929; cv=none; b=UM1cXutKa1zFy/5SvtfqjUmex6PC9XzOleXQGMgNgT51qN8QWCVbQ6uaoq64y+Pdc+Ker7nZXvC9i/8Av7O4kUldQT19WPqg1ayo77xrFdlC0akSzOr+flcq2ObHlPdAGVoVMmYTbKGp+K1248Nhp/s5eh/ceAWAptC2oS7Ukuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751035929; c=relaxed/simple;
	bh=ssH1c9PazQNjOK41gQReItkQ95b/YDYBXdsSCfABxeI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=owxuz2QT2c/I3TdyZKE8q1AKUumqNkv6C4jddLz6LGsJ1QSbkAFV9GfkbrFpMHCW2DLMJAlkMCoPCyS/ObivFnNF2OanqI3dqWMplu/F5oCGzGCf7I55Sg1ie7G5AJKTLj6U9b4dXTyhcn6bTnTqaQKrJRiWHSpl8OYw+1e8Tic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LdGA7ZGE; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LdGA7ZGE"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-748e378ba4fso3016763b3a.1
        for <git@vger.kernel.org>; Fri, 27 Jun 2025 07:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751035927; x=1751640727; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M1d8e/wX8BRrxjo+kBeB4jFJ6k4YbdnWDXBuj1y4wGM=;
        b=LdGA7ZGE8Y741a8wEXKOf2zSPY+Smy0cAuZF5W5556E5Hm52D1gjsDzmcnUDnyBJZr
         6/Y6td2BGwoOOZeyPr4o4VG5LV6zRB5CFBgWkJIvJP3QYkp9M4l89Fb9f+ClCkbKlbyR
         Hge6J9O1Q57yMHLWQQiqCnocFLpD4fKOUGpvK45zbxvPpq8e4YJUl1LC7LTmegldBU1V
         PoXLMWIW2tLlF7HbzwX+VIWxonjsOragSVbVJU/R6c1U1CGoM1pgOQXQgcIgT/VSbO/f
         THp4j9f3m0mO6RnWVEJ/h88T9k5Q8C65ARMHJFbXxDZ7wncHkReIQfwEZ4p3bZlGeRu2
         0itA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751035927; x=1751640727;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=M1d8e/wX8BRrxjo+kBeB4jFJ6k4YbdnWDXBuj1y4wGM=;
        b=IMmse9jeF/gvXZov9lAUWYPzaJiyj6E29KnTrGO0tKhSxNeFY+lW909Co8e8+JNQe/
         cKSIZB2iolBucZvw2OTDCL3ZEXPJZ6S8vcH6zbZ/C4ifwDZYu2s1TsXGR7+mhEiRR53V
         XxThRbVbaj48vs6HrWSSe6FyLBME99tG7LN4kQINK8rqRX7DVM7sZ96CW51Bep3mwL2w
         9x1R0/lRoo14GK6BAXayazkUCfPdvXauerqvk7iw1R8NFBlOWw8qyXie5bqC8+d5/pm4
         XRUfU1dg4c5N9kpZp0SeYJpc4W1zKpaG60wy0YCMLigR2D0553IDEJAEfCdXnmVDwWcy
         hoVA==
X-Forwarded-Encrypted: i=1; AJvYcCWMwlDtq0RFq/2h4GgW3yz8WHhg5kUCB8h+oJiaRT3FwXC+jBTq+7GhsroknCcTv08EWk4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6xy4PdNoCxRpwiN3gxeeBk1ZVn0HBpyMm4SLh2KQrLc7d58AR
	TRY+/5lwn39gFXUfukQZwf1x//HT+6dYD/gBcrOR+/EsZrQcma2v14BY5SLOiw==
X-Gm-Gg: ASbGncv/XPRGZiL2cjovzQ+LV+8dbzke8zSxWKnyHBsra/vwAWdzSYEnZ7O89hps0xa
	O+DFFBi9DpyQH4r5lcXp4mPBsyn+21kygYy0yllUX0aw8sKcBsfM+bh7iGbVhduir4Mvv+xc6+k
	E30eThvV0KwrSp4MkrUKU3qA07oB0ZWehThnMtgp/Vwm74vXRIB3nlSIBoko+uUpNMOIDsvSWSj
	fXCD3e3X4AFeGDpSyhRhVyfwv1sadEZsWwfOG4VzreHhd+4znKPqeXqObDMVWQH+ccmMDZGBrTf
	Fg6Hx3ZO2kc5H2ONNUFkSiAFk/d1+pvmnrDn81n57YYioG3gy4cTvLZ5qPAO90BWYsIRhMNf+kr
	tRPv8bw1usqV4ZGznGwCoWLJJnkg=
X-Google-Smtp-Source: AGHT+IHxMZqiocdnmUTmrt+7l2PiJ0w0uDjhNtStRbK2UNIRHbQ4rjZWRaLpva7zlmu+VPR6c8+CvA==
X-Received: by 2002:a05:6a00:b56:b0:73c:a55c:6cdf with SMTP id d2e1a72fcca58-74af6e61c65mr4584403b3a.1.1751035927374;
        Fri, 27 Jun 2025 07:52:07 -0700 (PDT)
Received: from localhost (209.255.125.34.bc.googleusercontent.com. [34.125.255.209])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-74af541bd1fsm2373548b3a.47.2025.06.27.07.52.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 07:52:07 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Ayush Chandekar <ayu.chandekar@gmail.com>,  christian.couder@gmail.com,
  git@vger.kernel.org,  shyamthakkar001@gmail.com,
  kristofferhaugsbakk@fastmail.com
Subject: Re: [GSOC PATCH v2] commit: avoid scanning trailing comments when
 'core.commentChar' is "auto"
In-Reply-To: <91982162-b138-4bb1-81fd-6f9185801c99@gmail.com> (Phillip Wood's
	message of "Fri, 27 Jun 2025 09:34:30 +0100")
References: <20250626132233.414789-1-ayu.chandekar@gmail.com>
	<20250626221631.457725-1-ayu.chandekar@gmail.com>
	<91982162-b138-4bb1-81fd-6f9185801c99@gmail.com>
Date: Fri, 27 Jun 2025 07:52:06 -0700
Message-ID: <xmqqms9t8cfd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

>> +	size_t cutoff;
>> +
>> +	/* Ignore comment chars in trailing comments (e.g., Conflicts:) */
>> +	cutoff = sb->len - ignored_log_message_bytes(sb->buf, sb->len);
>
> This finds the "Conflicts:" line. I was surprised to see that the
> string it looks for is hard coded and not translated, however the
> sequencer (also surprisingly) does not translate that message either
> so it should work.

There is a funny chicken-and-egg problem, though.  It limits the
search for "Conflicts" by using wt_status_locate_end() based on the
current value of comment_line_str.  When core.commentstring is set
to "auto", the code that reads the configuration does not touch the
comment_line_str variable, which is initialized to '#'.  So

	[core]
	    commentstring = '%'
	    commentstring = auto

would have '%' in comment_line_str upon entering this codepath, let
wt_status_locate_end() use '%' as the comment string to find the end
of the log message, and then looks for "Conflicts:" in the result.

Which may or may not be what you want.

> If you used an existing file (F1 or F2) like most of the rest of the
> tests in this file we could avoid creating this commit and save
> ourselves a couple of processes.

Excellent suggestion.

>> +	test_grep "^# Changes to be committed:$" actual
>
> I agree that it is a good idea to anchor the start of the message, but
> I'm not sure it is helpful to anchor the end of the message as we
> don't want the test to fail just because an unrelated change adds some
> whitespace to the end of this line. I'd be tempted to drop the ':' for
> the same reason.

Again, excellent.


> Thanks for fixing this
>
> Phillip

Thanks.

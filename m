Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFEF918FC63
	for <git@vger.kernel.org>; Wed, 26 Jun 2024 17:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719422970; cv=none; b=R52AKJ6QRFIZj8Ti6DKcVX215yMPiUtD/wR0dsHlN0f9rq+WAnCKEdbSHInIC+N8b+Ix3QrTy8ihEC3lPrtzAU4VzKB+Iu11ykd/MPw/P5NEd4RAH/NTbfZg6sYaG/WjpbSctClXXVOo39aoU1oixoMYlxDGaRR3MlhwGlrbf6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719422970; c=relaxed/simple;
	bh=TZdSdsASr4BzHF3zmFeAkR3PQ5sWDIus1OULfjKn158=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZKiodVe8Mr+tNIuNxQqAxSRkm1ROqyDInx83TELnclUqaQhodjNQ2icdzDEUas5Vwzafhsfu9th5xzxScI3JCwdv1rJ3RYyfkolKXOFd9m++UUpDl80nYAcrXk/LnqVHRSj5Br8KoQCdisa6Ukcfb85pCF8/rlsyR3cYExo/AQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UL7w3Y+2; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UL7w3Y+2"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-70675c617e7so183924b3a.0
        for <git@vger.kernel.org>; Wed, 26 Jun 2024 10:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719422968; x=1720027768; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ojaD2Lu8UXiOinWU0IRIn1em+CTwj/DY6HA/b8qB1is=;
        b=UL7w3Y+21FP0YiT7LF55t9b5u599eyHm6d4n53NQBqI+ujrl597BhcHdjBJtniXvHh
         lXyx0nLUJNLKVjpsUy3V3RM+E+G0QQQyVL1N1NlO+2ZIKvaAXhUb02O8dBML4nXF2L3m
         sWftlsCyi7l2IK8DFS63Lf4mVtfx9xAtrJBdAKy0Wf2gHcSil0HyVvuCHRftRoWzSyG8
         ZRzae4oWgd/LL/PC3FkYB9JuawaQGPQHdjJHiPNEc6rBte1zY58+K1fe5p+kynROcWwJ
         MC7mmP+nOQBNbJuZgwsSx4fNVwEwqrCsE6e7IOKklxFlYDNVBEL474XbeprIm45xvCG4
         4qOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719422968; x=1720027768;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ojaD2Lu8UXiOinWU0IRIn1em+CTwj/DY6HA/b8qB1is=;
        b=fVmzrUceXjhwC8SPScMQnSf7oBkHHW5DivWNy1dI76iGNPXrCRd6VWrXpy0LvFIvie
         lW27tu8W2CsVuZ1BP3YOleCRgUMbBZ8tizUq6FjSoEnQwXJlphYomaHBHKIh2lN6seZI
         XJBi19oWFgxiJLDk7G01kxqyqII8OJWJKHJQO1F9kBcWPAFfG40i/14dYB0o7Th+s2+v
         ZQt/UbsE2t3fmHV0A0nt0bLfGODZlMUPe2DMC9yVgHoCFbpFWrIymjp1piIcp1fViAmd
         vFhbwRRoAzuLxR9O/zEY2r/23fciE++ZgMZ5cRFJTVjQh/Em+PcRVuB5nv5tHK40UE53
         aRSw==
X-Forwarded-Encrypted: i=1; AJvYcCVtN7x9cGmvkA8pJX8ogbqoHHue/cJrXsD3pO1rxKwWkSstUJ7DjQtxNA01DZ1ItCQUNBfv6IKq7d967VTcDrbTYn/c
X-Gm-Message-State: AOJu0Yw9/90BVovKfKpC3iBOXh3FRZkh8djYquFf4ZuaGR9qMkN3grk2
	Hh1aMY9jvm44hKzkJdcF3iULSnG0SlDW1WhS9s4WrUbxydlOAT6p
X-Google-Smtp-Source: AGHT+IEk/HncyGbp2UHNfreL/1K0LCRha4iFkjW8/8SddYc7I3WW7Snui9OO39gUKQevnvEFziVwKw==
X-Received: by 2002:a05:6a00:784:b0:706:32d1:f6c9 with SMTP id d2e1a72fcca58-70667dda8e2mr12847025b3a.2.1719422968097;
        Wed, 26 Jun 2024 10:29:28 -0700 (PDT)
Received: from ?IPV6:2409:40c2:205a:5198:c04f:bc01:50f8:f177? ([2409:40c2:205a:5198:c04f:bc01:50f8:f177])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70694606cefsm4053683b3a.8.2024.06.26.10.29.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jun 2024 10:29:27 -0700 (PDT)
Message-ID: <bbc223a3-2c82-4108-adf1-5e8518ff776e@gmail.com>
Date: Wed, 26 Jun 2024 22:59:22 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Re* [PATCH v5] describe: refresh the index when 'broken' flag is
 used
To: Junio C Hamano <gitster@pobox.com>
Cc: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org,
 Paul Millar <paul.millar@desy.de>, Phillip Wood <phillip.wood123@gmail.com>,
 Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>
References: <xmqq34p1813n.fsf@gitster.g>
 <20240626065223.28154-1-abhijeet.nkt@gmail.com>
 <CAOLa=ZRz2KEGiBnX1YP6JG1nXXHLfw9A3dHKO3s_ViLhq+bWww@mail.gmail.com>
 <2e80306e-2474-4254-95eb-c2902a56ffdd@gmail.com>
 <xmqqikxv4t1v.fsf_-_@gitster.g> <xmqqcyo33cgu.fsf@gitster.g>
Content-Language: en-US, en-GB
From: Abhijeet Sonar <abhijeet.nkt@gmail.com>
In-Reply-To: <xmqqcyo33cgu.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26/06/24 21:47, Junio C Hamano wrote:
> Or alternatively, we could do this to ensure that the child_process
> structure is always reusable.
> 
>  run-command.c | 1 +
>  run-command.h | 6 +++++-
>  2 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git c/run-command.c w/run-command.c
> index 6ac1d14516..aba250fbe1 100644
> --- c/run-command.c
> +++ w/run-command.c
> @@ -26,6 +26,7 @@ void child_process_clear(struct child_process *child)
>  {
>  	strvec_clear(&child->args);
>  	strvec_clear(&child->env);
> +	child_process_init(child);
>  }

To me, this looks much better.  child_process_clear's name already
suggests that is sort of like a destructor, so it makes sense to
re-initialize everything here.  I even wonder why it was not that way to
begin with.  I suppose no callers are assuming that it only clears args
and env though?

>  struct child_to_clean {
> diff --git c/run-command.h w/run-command.h
> index 55f6631a2a..6e203c22f6 100644
> --- c/run-command.h
> +++ w/run-command.h
> @@ -204,7 +204,8 @@ int start_command(struct child_process *);
>  
>  /**
>   * Wait for the completion of a sub-process that was started with
> - * start_command().
> + * start_command().  The child_process structure is cleared and
> + * reinitialized.
>   */
>  int finish_command(struct child_process *);
>  
> @@ -214,6 +215,9 @@ int finish_command_in_signal(struct child_process *);
>   * A convenience function that encapsulates a sequence of
>   * start_command() followed by finish_command(). Takes a pointer
>   * to a `struct child_process` that specifies the details.
> + * The child_process structure is cleared and reinitialized,
> + * even when the command fails to start or an error is detected
> + * in finish_command().
>   */
>  int run_command(struct child_process *);
>  



Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A17213D8A4
	for <git@vger.kernel.org>; Fri,  4 Jul 2025 04:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751604677; cv=none; b=DRvx+xltQPaFQWUSW518ncKnmBdPeSmY2RzqqixH30E1kUy6DpcAkGeaZCF84IoMtEG15K/yD1q7kfob3ag50MHyS3kvKxg3TfGD+t+CSdHgD2jqhouGFWtkOuJnWhwvTiyLvvvfKtyruODdke6U+XxtVwzixMR0nqCrr+8RPe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751604677; c=relaxed/simple;
	bh=Aw3/VH3phN2haMR+gWxEj8qFDQusGZlHQCh2DuGI8+E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iuHZs1hfLNj7len5GqhdhwYtRrVoOD0yyjql9v84FI1dFwPKE15K9oBbd/GtXLFjkKef5cJlIGg5II4mpWRWGonCmjn3ZWRzQgDHIFtvgdS2RSbxCh91hwqtD7sRfWVTit1Fd8fN8FskIw8NU7G94MxX2XSJ4TPC6vFSMviTzXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fGkbHPQR; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fGkbHPQR"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-23694cec0feso5069935ad.2
        for <git@vger.kernel.org>; Thu, 03 Jul 2025 21:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751604674; x=1752209474; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mJixP4TAhktGHVpJYi8MBq3V/yl4NZqSOIPcEaUwIQ0=;
        b=fGkbHPQRn8SY0k+yY2axZ6S7uBFA/tv8SnLWQhfRT7DAgrTifAPkP9mgINbFtPFq7P
         UZUdAfy5f6Jz+6N2EUypKj0kuvtvqz0ef81XJz2MZhDE8nHfs23GLudiufG+XV45J/qy
         H6TnaRSvdIXwVHT8dP1TCifqHYB7dZM8+En5JXw5qCJmM+j9HoHYyuZ/JRbh4YIRxhmq
         h98hCarXawuGRpCBlbOJYS1dz7fxY7trYF2PDKrI01bzxlKJzjAC7nGrr12WLwsjFLPT
         E/icB1VfEv632ldjwfJFmgeAl5P2DTdldq8v0a7XeJNlMEYxADVlRsdKQ5R1ngvy1+bw
         Ks0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751604674; x=1752209474;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mJixP4TAhktGHVpJYi8MBq3V/yl4NZqSOIPcEaUwIQ0=;
        b=EZakrML9iUQNjd8UblzCRpT1n8L+mYyOEqKkQsEhdoAWGufj9YV9J5VhAUN4IyfEIz
         gdR9uUrd3tBj4QW2mfn4f2aMQMrpbVdZEtcRJSejDpaObjDtvL54yA+BuHc7p6kb05lZ
         sGSxE1pmoV6xhBzbSQPEhEN3y2NYo896iP3HBqGlrc1z3a4PlUE7+9VV/A6PJ9ZdlYyp
         c9Enyl2rZNAQfxmAi0sdjjNRNWv6ty5SJJEFJ0yiQxpi+zb84bkBB+Yo7bvxKzeFyZ8u
         yrpUoSCEC960k3IyIx5TGwHqOEeuLItcjhOnxxDPMwz1UKXhGrEtBf31NrSt8pZGBsf6
         BYgw==
X-Gm-Message-State: AOJu0YzqGXztiZNVP/cSMhB4w04nwUw14wgU2VvwdAdVlvLx+vqIGzIK
	33koKgR0Me8B9nVTjf58xiPGBh7nsjvmvJaWPNsvcQF1DPeCpNWW7k/Z
X-Gm-Gg: ASbGncvAYRi6YhsA0yLW0cn0P1PS23WgiDbyH6zQTQKFtYTS85ej1vF/Q9+GlMH2qks
	6B4xBtMm6jmkLtWLRcYs39JmOEF6F3FpdiXB2kPnJunkFf8XhifG9/neLkKTfv7nPP0dlCkTuUq
	GRz656+pf5fm5HsUyULgA1tZkopV2dgYwn+Vf1YpQSsDy6AyoOuQSORXnr1+7lZCXHak/ytNva/
	dYHztY5reK3bsgW2Fwp2Fo/xMMzSsWnNNsAW31GtK1Q77eTKTZDwcbH5jc/iHdoPaLwPBy3Ieg9
	kKJ4sfAjgnTVxE6kUzUnUL3AzzhQuwh8C3RVKPUknAhaADYYo5YddtSV73sb1dVQOuNQ9/prBtN
	dGjDX9gxXQSBWG/B8d0ssLjEqcNvTn1yx5Nn+Bg==
X-Google-Smtp-Source: AGHT+IFYn5+/VWUK+rb04uSIkekYtvnm0LUbiAmwWzKbWRNNjTfiK5Aky6g6wC1DVvAilQx9affqoQ==
X-Received: by 2002:a17:903:41c4:b0:235:f298:cbbe with SMTP id d9443c01a7336-23c86074d43mr18667155ad.12.1751604674137;
        Thu, 03 Jul 2025 21:51:14 -0700 (PDT)
Received: from localhost (209.255.125.34.bc.googleusercontent.com. [34.125.255.209])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-23c8431a3fcsm9916145ad.37.2025.07.03.21.51.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 21:51:13 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From: Junio C Hamano <gitster@pobox.com>
To: Per Cederqvist <ceder@lysator.liu.se>
Cc: git@vger.kernel.org
Subject: Re: Allowing "/" in the name of a git remote is a strange choice
In-Reply-To: <CAHx6-Um1dq0xJ-RkW+qXe=sEa6JGViSJxjzNw56u55DHLYoT2Q@mail.gmail.com>
	(Per Cederqvist's message of "Thu, 3 Jul 2025 21:33:20 +0200")
References: <CAHx6-Um1dq0xJ-RkW+qXe=sEa6JGViSJxjzNw56u55DHLYoT2Q@mail.gmail.com>
Date: Thu, 03 Jul 2025 21:51:12 -0700
Message-ID: <xmqqikk8bltr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Per Cederqvist <ceder@lysator.liu.se> writes:

> Today I realized that git accepts "/" in a remote name.
>
> This can lead to problems. I have a repository that contains a branch
> called "master" and another called "chat/master". Just for fun, I
> added a second remote in this repository and named it
> "origin/chat".
>
> Now, does "refs/remotes/origin/chat/master" refer to the branch
> "chat/master" from "origin", or the branch "master" from
> "origin/chat"? Git seems to think it refers to both:

That would have been a fun experiment ;-)

> If it was up to me, I'd add a check to valid_remote_name() to ensure
> the name doesn't contain any "/" character.  I doubt it is used often.

If your remote-naming discipline is to always use two-levels
(e.g. origin/chat, origin/chien, origin/lapin but never origin or
origin/chat/blanc mixed in), then there is no confusion.

It becomes only confusing if you mix origin and origin/chat.  

So it is not like we can just forbid '/' retroactively and expect no
repercussions, especially given that I hear there are more than a
few thousands of existing Git users in the world.

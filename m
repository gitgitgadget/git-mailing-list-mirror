Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B29B1C8603
	for <git@vger.kernel.org>; Sun,  1 Mar 2026 18:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772389821; cv=none; b=L6+FT7P/BNce9O7Jv1yQepwWhA/noa/IubCBRh6qwAnEBSvzyn6WbnsXjrYGv0Sc55pb/jdJfnT6WBaqEN+cY6sAfKRCp4z4SfvXn6BcjBIntGFAGK1ohQfiG1tNTktkUoDqMXPi9n7GesjdgJtDxKGhnx0i4Zx9hM05Ztgbm/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772389821; c=relaxed/simple;
	bh=Uw6/dQjasmyJdjvXPGXVYHr0AQqzrfXayvtLHF5iep0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PuYpBHiN6vgomXZMg54se0gbZxXLPMG6kkhCV9eqjYFw1QW5BbNF9cJ0PVhwgRsyTJf7SBktp2uYO8hcfabCzsWv8RkmdCZFWJkxLFc56iJaQSCnE/0Oc1w1Z3oBGzxjsURxOqMEyqRMe2e1lCLvx4z7ImejfpWiW0SnluWeg4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AQKbjpVn; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AQKbjpVn"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-48329eb96a7so24867265e9.3
        for <git@vger.kernel.org>; Sun, 01 Mar 2026 10:30:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772389819; x=1772994619; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=J697SCcnt1oExBggUUsvr8wfMHbJSgC8QXC2YNpbHOw=;
        b=AQKbjpVnvBFbaEJjP84PdHUuUmyfJFRMp3+EnCAxdtxyhEAlAmR5r1157j+TM2OSNS
         sjqxFkjz7cyu4t6oVDYHM83stJNCAhYgrZfolcNlZFqsKr+VKaeS23CeCcdkmkvB5sw2
         Nov9bHwKsDsQMv7djOhqdmQjSgyg6wuDjOpPaOUfgOaVHUxjAR0kTr3mK42PYgR39ylV
         PMNnJTv2ug2TiHiN4Xsh3AAEOjGxXIwC4xztClecq+GJggc05YMgrhpJ6BkyG15yi2A7
         wCMXsIAWF/SM/qPvfBlQpctoLxBI7n2BLhtV2ovxfZYUmpDVi0YCU6EGOvutGxNr6pF4
         MeHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772389819; x=1772994619;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J697SCcnt1oExBggUUsvr8wfMHbJSgC8QXC2YNpbHOw=;
        b=QI5XOgvfD0ijtcNNyxJt0Jdfg5IdziZld3Vp8iafDTZJW8IHlFwGeL4WLXa/oB2MVx
         0YPBXB5erNNNO2HIxvWu3xf0G4FTvW5MTD9X0+lZ6ATiSBp1r9tFxyH9ANC/AUIrIzOM
         Zw79NBwKTg5tP9l/dfEDYtt/e9IbAGOletE2n8Jb67+B4306BYUYxyi02QgcRGvjNqa5
         yLWVsPvuKs98owmo/X0R4jU5cg8J0gB9qEQchyVGtb14LnqbVpWcmM2lVi0aVzp3AHrG
         UepJ8iKGgnWzrk9zWtTXP9+NdG1YQbqZTigOZLgPsRITgzV6g8WlEQFqvA7g7Gu4EWj1
         Ngag==
X-Forwarded-Encrypted: i=1; AJvYcCUoJFjxwNn1Mq3dvVF86oTCmrJmapwrB011udR1XmBXXmo7z3VxkTPP5+q7+B2r/g3LF3o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1xXpwLuFrsnOeTWAY8SmB75QMImzEqEn8KmdpM1dHX5lgiWjd
	g6aH+MIPHRSBxvzuwDGL6a/3nQTjChLQmL8VmdfnE8xdL3nhfdB4qJQLvWd2Lnan
X-Gm-Gg: ATEYQzzsR5YM3jVhOiZ2XbKhnggvSHqqSnnInlbsrDfFIQq/N+lmYCVfLkeoxVk5ov6
	+95NwRlE56uAAWhuJhjaPBxU5TUEMSSXhM0KqWVrLsk+Me2hYSq5LfrHns/cgCLPntF8ArdPI8y
	757Tkx1hOt6zHD3f54jT1fcEsPGSR9YohLFUZzJZm1CwD8nlXcWCwOVLMhtBAe8ZSju8GdMJYq6
	AFViynj8kaLkID73pUXWWPczGhyiX+cohS4iG0dEq4jWa/9oRAKYsZmD+DZD2J/zlnQher4mwvI
	M3CSaYJUGeubES8tt1YvmRBqdrJoUqSjvh/ISOMOo4vgfSIO04F1PLk2w4vGYrV+H9Ohug7YtBg
	F4EIRZO352T0PO5fd1t7+V7yetqYFZRZqlJfDOko+mreSBRbhP9zFEKre0vVmVcpBY4/0w3uBbH
	Trg1/ERmQhLhNdEQc=
X-Received: by 2002:a05:600c:3e16:b0:46e:32dd:1b1a with SMTP id 5b1f17b1804b1-483c9ba38damr181953605e9.7.1772389818623;
        Sun, 01 Mar 2026 10:30:18 -0800 (PST)
Received: from fedora ([159.146.42.25])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bd70e692sm375479965e9.7.2026.03.01.10.30.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2026 10:30:17 -0800 (PST)
Date: Sun, 1 Mar 2026 21:30:09 +0300
From: Burak Kaan =?utf-8?Q?Kara=C3=A7ay?= <bkkaracay@gmail.com>
To: phillip.wood@dunelm.org.uk
Cc: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>, 
	git@vger.kernel.org, gitster@pobox.com, christian.couder@gmail.com, 
	karthik.188@gmail.com, jltobler@gmail.com, ayu.chandekar@gmail.com, 
	siddharthasthana31@gmail.com, lucasseikioshiro@gmail.com
Subject: Re: [GSOC][PATCH 1/2] editor: make editor_program local to editor.c
Message-ID: <aaRzdeg2BkAKa-4J@fedora>
References: <20260301105228.1738388-1-shreyanshpaliwalcmsmn@gmail.com>
 <20260301105228.1738388-2-shreyanshpaliwalcmsmn@gmail.com>
 <aaQzlE2lsq4WfFxt@fedora>
 <8e657184-ee0b-453a-9f2d-a98080d3582e@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8e657184-ee0b-453a-9f2d-a98080d3582e@gmail.com>

On Sun, Mar 01, 2026 at 04:22:38PM +0000, Phillip Wood wrote:
>>While moving the global variable from 'environment.c' to 'editor.c'
>>doesn't cause any behavior change, it still relies on global state.
>
>That's true, but does it really make sense for this config setting 
>per-repository? Why would I want to use different editors for 
>different repositories in the same process?
>
>Thanks
>
>Phillip

In practical sense, yes, it's true. Users generally don't use different
editors for different repositories. For repository dependent settings 
.editorconfig mostly cover all scenarios.

However, as far as I know git doesn't have a system-wide only
configuration settings. These changes mostly serve to libification
process of git. If we leave 'core.editor' setting as a global variable 
and user tries to interact with multiple repositories that have
different editor configurations using our libified git, it can mix up
the configs of two repositories.

If we really want to keep these variables independent from repositories,
we should probably prohibit 'core.editor' setting in local repository
configs. Otherwise, leaving it global seems like a weird behavioral
choice.

Thanks,
Burak Kaan Karaçay

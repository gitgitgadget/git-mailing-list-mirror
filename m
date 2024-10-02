Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF0F71854
	for <git@vger.kernel.org>; Wed,  2 Oct 2024 17:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727890447; cv=none; b=OJ3CpP6oHxMdP/orcrxjHfyNsQCcpcWExSb5IySy9Y4CqOtHe3Jqv9Zndemng33Vhhd65pq/YkBPj8QXb/KaUWMxP9VHqYivkzPshBmQ8dCZYcZv2dxc+6bqjE0poDoUz3Hk9tO042XD5yv2ihpa4SJhorfPAtk2Lk3frQBSnhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727890447; c=relaxed/simple;
	bh=v59lDkLZDT30ewsPS2pYiR38uAYPIAmOyznJD8xZRx4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nvJE3Sdst7mr7m9u2Ba+v8W6lzFUhy3cBzFggTLaZIqMpLncmNUDBz0KzJFjDyIMfddF4FYpguWrNslOsyn2zq/58Q8wW2WO7/qnBrNxovd+fE/jqrreu8Z2Ehp6MKry7rzDTK82dBUebzOSG2lE1SnZFJJ5+nYhNK0pqDARpCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FhdJrqXL; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FhdJrqXL"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-42ca6ba750eso728525e9.0
        for <git@vger.kernel.org>; Wed, 02 Oct 2024 10:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727890444; x=1728495244; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KfDb4BFlcy0/qkcOAmo0atSu9nKy5FnlE4yRfJv4g5c=;
        b=FhdJrqXLA8thPbn0dMFWky8Q1gg9kEEppBH+tQp82P+U3RoAELbwenXx6Z+FHcPt6H
         j3964ZB8TFb1nJ8M2KXDjfrWnUsyYrpgWst/3gRSdfOX6RabMqO+OrppfklhmXt1Zmi5
         bwTkKNS2bdh3RejclPqlQZGhQ50anEQmUkgtgPYG1epdeCeGjppMCkm7vca9J3iuW1EX
         o3dcXMFhR6GCxiowgFpdGCQr9y9K3XUhsAUIDAWLqQEhA+1KJLc6oxc4sRKmoF9h9YgF
         qFD7R3y2QlJWMIUV/bJAQm62s4HBCiX6KgxewQ7AUJQ+5qTuTYvrBniWfx2CdYpS+87v
         L74g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727890444; x=1728495244;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KfDb4BFlcy0/qkcOAmo0atSu9nKy5FnlE4yRfJv4g5c=;
        b=DgJSX71ifcZ8lItXLPQEZHsV6cRpmWrfnrfaBjEfchp0pEQqBsJxJa7TcX5yeurXCW
         O2AuSXbRSAV7CT8eoHBttSnIo4Ze5pbxoTo26bSc+TVRSMTqPBvr7Nl07MCDmjH8tp4z
         TVbdzJddm1TIxM752XquA+sfeqt2z3NCkkEznL6sR5JQhyV60aemkjJCmj/Us0dMLecu
         8T62/MvGmry8YMIbYD0FMszuDdUxbuJWthLgjT8N8M6imlbed1bQxC+et3ekrZfEYJJM
         lYH4f/53/7Ju3Y4/5u8TM3IFVZQb8XUVTEFCAx1z5M5Rfl6VnwqJfG6pZ+qrs5tcxESz
         IA8w==
X-Gm-Message-State: AOJu0Ywa9K5zYaGU9bZJDkmx4cEz24PL5HP3TNLoXJV4smLfhxB9yrr9
	3IuQKMcBbprwQtyKy2UpncUDS1rCJcIDXAYEUDdJz7/DDMZakhMe
X-Google-Smtp-Source: AGHT+IFY+VJh7QFgTMH56xV5fY/ZSYCmmLHWmCN2t8HROFfBrftwTb1BCWEQjhYoLjjewVqBco8mgQ==
X-Received: by 2002:a05:600c:1990:b0:42c:b68f:38fb with SMTP id 5b1f17b1804b1-42f7df41dfdmr3069575e9.7.1727890444005;
        Wed, 02 Oct 2024 10:34:04 -0700 (PDT)
Received: from gmail.com (132.red-88-14-49.dynamicip.rima-tde.net. [88.14.49.132])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f79ec0722sm25056115e9.15.2024.10.02.10.34.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Oct 2024 10:34:03 -0700 (PDT)
Message-ID: <ee33072c-8759-4c42-ad36-3c33ef5d1c57@gmail.com>
Date: Wed, 2 Oct 2024 19:34:02 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] add-patch: edit the hunk again
To: Junio C Hamano <gitster@pobox.com>
Cc: Git List <git@vger.kernel.org>, Phillip Wood <phillip.wood123@gmail.com>,
 Phillip Wood <phillip.wood@dunelm.org.uk>,
 Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <21ddf64f-10c2-4087-a778-0bd2e82aef42@gmail.com>
 <4dd5a2c7-26a8-470f-b651-e1fe2d1dbcec@gmail.com>
 <74289d8b-7211-452a-ac76-f733e89112e6@gmail.com>
 <9c7af640-ee3a-4a17-84f6-f56fee7efe37@gmail.com> <xmqqv7ybyabs.fsf@gitster.g>
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
Content-Language: en-US
In-Reply-To: <xmqqv7ybyabs.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On Tue, Oct 01, 2024 at 10:58:15AM -0700, Junio C Hamano wrote:

> I would not
> complain if we offered the feature to re-edit

I'm using this:

   $ GIT_EDITOR='bash -c "vim \"$1\" && cp -f $1 /tmp/backup"' git add -p

That way, I have a copy of the edited hunk in case I want to try again
or review it.  In that case, I can simply try again and reload from
"/tmp/backup".

I'm sure there's a more clever way, but I haven't come up with
anything more elegant.

Maybe interactive.editor, apply.editor, add.editor?
